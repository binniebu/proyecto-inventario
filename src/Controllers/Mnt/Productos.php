<?php

namespace Controllers\Mnt;

use Controllers\PrivateController;
use Dao\Mnt\Productos as DaoProductos;
use Views\Renderer;

class Productos extends PrivateController
{
    public function run(): void
    {
        $viewData = [
            "show_categories" => false,
            "show_products" => false,
            "catid" => 0,
            "catnom" => "",
            "Categorias" => [],
            "Productos" => [],
            "CanInsert" => false,
            "CanUpdate" => false,
            "CanDelete" => false,
            "CanView" => false
        ];

        // Permissions
        $viewData["CanInsert"] = self::isFeatureAutorized("Controllers\\Mnt\\Producto\\New");
        $viewData["CanUpdate"] = self::isFeatureAutorized("Controllers\\Mnt\\Producto\\Upd");
        $viewData["CanView"] = self::isFeatureAutorized("Controllers\\Mnt\\Producto\\Dsp");

        // Handle stock adjustment POSTback
        if ($this->isPostBack()) {
            if (isset($_POST["action"]) && $_POST["action"] === "ajuste_stock") {
                $prdId = isset($_POST["invPrdId"]) ? intval($_POST["invPrdId"]) : 0;
                $tipo = isset($_POST["ajuste_tipo"]) ? $_POST["ajuste_tipo"] : "";
                $cantidad = isset($_POST["ajuste_cantidad"]) ? intval($_POST["ajuste_cantidad"]) : 0;
                $motivo = isset($_POST["ajuste_motivo"]) ? trim($_POST["ajuste_motivo"]) : "";

                $urlCatId = isset($_GET["catid"]) ? intval($_GET["catid"]) : 0;
                $fallbackRedirect = "index.php?page=mnt_productos" . ($urlCatId > 0 ? "&catid=" . $urlCatId : "");

                if ($prdId <= 0) {
                    \Utilities\Site::redirectToWithMsg($fallbackRedirect, "¡Error: Producto no válido!");
                }

                $prod = DaoProductos::getProductoByCode($prdId);
                if (!$prod) {
                    \Utilities\Site::redirectToWithMsg($fallbackRedirect, "¡Error: El producto especificado no existe!");
                }

                $redirectUrl = "index.php?page=mnt_productos&catid=" . $prod["catid"];

                if (!in_array($tipo, ["ENT", "SAL", "MER"])) {
                    \Utilities\Site::redirectToWithMsg($redirectUrl, "¡Error: Tipo de ajuste no válido!");
                }

                if ($cantidad <= 0) {
                    \Utilities\Site::redirectToWithMsg($redirectUrl, "¡Error: La cantidad a ajustar debe ser mayor a cero!");
                }

                if (empty($motivo)) {
                    \Utilities\Site::redirectToWithMsg($redirectUrl, "¡Error: El motivo del ajuste es obligatorio!");
                }

                $loteCod = isset($_POST["ajuste_lote_cod"]) ? trim($_POST["ajuste_lote_cod"]) : "";
                $loteFechaVencimiento = isset($_POST["ajuste_lote_vence"]) ? trim($_POST["ajuste_lote_vence"]) : "";

                if ($tipo === "ENT" && empty($loteCod)) {
                    \Utilities\Site::redirectToWithMsg($redirectUrl, "¡Error: El código de lote es obligatorio para entradas!");
                }

                $currentStock = intval($prod["invPrdStock"]);
                $newStock = $currentStock;
                if ($tipo === "ENT") {
                    $newStock += $cantidad;
                } else {
                    $newStock -= $cantidad;
                }

                if ($newStock < 0) {
                    \Utilities\Site::redirectToWithMsg(
                        $redirectUrl,
                        "¡Error: El stock resultante no puede ser negativo!"
                    );
                }

                $userId = \Utilities\Security::getUserId();
                $updateResult = DaoProductos::updateProducto(
                    $prdId,
                    $prod["invPrdBrCod"],
                    $prod["invPrdCodInt"],
                    $prod["invPrdDsc"],
                    $prod["catid"],
                    $prod["invPrdPrecioVenta"],
                    $prod["invPrdCosto"],
                    $newStock,
                    $prod["invPrdStockMin"],
                    $prod["invPrdTip"],
                    $prod["invPrdEst"],
                    $userId
                );

                if ($updateResult) {
                    if ($tipo === "ENT") {
                        // Entrada por Compra: Crear o actualizar lote
                        $existingLote = DaoProductos::getLoteByCode($prdId, $loteCod);
                        if ($existingLote) {
                            DaoProductos::incrementarLote($existingLote["loteId"], $cantidad);
                            $loteId = $existingLote["loteId"];
                        } else {
                            DaoProductos::registrarLote($prdId, $loteCod, $cantidad, $loteFechaVencimiento, $prod["invPrdCosto"]);
                            $loteResult = DaoProductos::getLoteByCode($prdId, $loteCod);
                            $loteId = $loteResult ? $loteResult["loteId"] : null;
                        }
                        DaoProductos::registrarMovimiento($prdId, $tipo, $cantidad, $motivo, $userId, $loteId);
                    } else {
                        // Salida/Merma: Descontar de lote específico o aplicar PEPS
                        if (!empty($loteCod)) {
                            $existingLote = DaoProductos::getLoteByCode($prdId, $loteCod);
                            if (!$existingLote || $existingLote["loteEst"] !== "ACT" || intval($existingLote["loteCantActual"]) <= 0) {
                                \Utilities\Site::redirectToWithMsg($redirectUrl, "¡Error: El lote seleccionado no existe o no cuenta con stock activo!");
                            }
                            $cantActual = intval($existingLote["loteCantActual"]);
                            if ($cantActual < $cantidad) {
                                \Utilities\Site::redirectToWithMsg($redirectUrl, "¡Error: El lote seleccionado (" . $loteCod . ") solo cuenta con " . $cantActual . " unidades!");
                            }
                            DaoProductos::actualizarCantidadLote($existingLote["loteId"], $cantActual - $cantidad);
                            DaoProductos::registrarMovimiento($prdId, $tipo, $cantidad, $motivo, $userId, $existingLote["loteId"]);
                        } else {
                            // Salida/Merma: Descontar de lotes activos usando PEPS (FIFO)
                            $lotes = DaoProductos::getLotesActivos($prdId);
                            $cantRestante = $cantidad;
                            foreach ($lotes as $lote) {
                                if ($cantRestante <= 0) {
                                    break;
                                }
                                $loteId = intval($lote["loteId"]);
                                $cantActual = intval($lote["loteCantActual"]);

                                if ($cantActual >= $cantRestante) {
                                    DaoProductos::actualizarCantidadLote($loteId, $cantActual - $cantRestante);
                                    DaoProductos::registrarMovimiento($prdId, $tipo, $cantRestante, $motivo, $userId, $loteId);
                                    $cantRestante = 0;
                                } else {
                                    DaoProductos::actualizarCantidadLote($loteId, 0);
                                    DaoProductos::registrarMovimiento($prdId, $tipo, $cantActual, $motivo, $userId, $loteId);
                                    $cantRestante -= $cantActual;
                                }
                            }

                            // Registro de excedente si hay desfase
                            if ($cantRestante > 0) {
                                DaoProductos::registrarMovimiento($prdId, $tipo, $cantRestante, $motivo, $userId, null);
                            }
                        }
                    }

                    \Utilities\Site::redirectToWithMsg(
                        $redirectUrl,
                        "¡Ajuste de stock registrado exitosamente!"
                    );
                } else {
                    \Utilities\Site::redirectToWithMsg(
                        $redirectUrl,
                        "¡Error al actualizar el inventario!"
                    );
                }
            }
        }

        if (isset($_GET["catid"])) {
            $viewData["catid"] = intval($_GET["catid"]);
        }

        if ($viewData["catid"] > 0) {
            // Drill down: Show products for selected category
            $category = DaoProductos::getCategoriaByCode($viewData["catid"]);
            if ($category) {
                $viewData["catnom"] = $category["catnom"];
                $viewData["show_products"] = true;
                $rawProducts = DaoProductos::getProductosByCategoria($viewData["catid"]);
                $productsFormatted = [];
                foreach ($rawProducts as $prod) {
                    $stock = intval($prod["invPrdStock"]);
                    $stockMin = intval($prod["invPrdStockMin"]);
                    $est = $prod["invPrdEst"];

                    if ($est === "INA") {
                        $statusDsc = "Descontinuado";
                        $statusClass = "badge-error";
                    } elseif ($stock === 0) {
                        $statusDsc = "Agotado";
                        $statusClass = "badge-error";
                    } elseif ($stock <= $stockMin) {
                        $statusDsc = "Casi Agotado";
                        $statusClass = "badge-warning";
                    } else {
                        $statusDsc = "Disponible";
                        $statusClass = "badge-success";
                    }

                    $prod["invPrdEst_dsc"] = $statusDsc;
                    $prod["invPrdEst_class"] = $statusClass;

                    $lotes = DaoProductos::getLotesActivos($prod["invPrdId"]);
                    $lotesArr = [];
                    foreach ($lotes as $l) {
                        $lotesArr[] = [
                            "loteCod" => $l["loteCod"],
                            "loteCantActual" => intval($l["loteCantActual"])
                        ];
                    }
                    $prod["lotes_json"] = json_encode($lotesArr);

                    $productsFormatted[] = $prod;
                }
                $viewData["Productos"] = $productsFormatted;
            } else {
                \Utilities\Site::redirectToWithMsg("index.php?page=mnt_productos", "¡Categoría no encontrada!");
            }
        } else {
            // Main view: Show list of categories
            $viewData["show_categories"] = true;
            $viewData["Categorias"] = DaoProductos::getCategorias();
        }

        Renderer::render("mnt/productos", $viewData);
    }
}
