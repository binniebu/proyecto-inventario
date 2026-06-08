<?php

/**
 * PHP Version 7.2
 *
 * @category Private
 * @package  Controllers
 * @author   Orlando J Betancourth <orlando.betancourth@gmail.com>
 * @license  MIT http://
 * @version  CVS:1.0.0
 * @link     http://
 */
namespace Controllers\Admin;

use Dao\Mnt\Dashboard as DaoDashboard;

/**
 * Página Principal de Administradores
 *
 * @category Public
 * @package  Controllers/Admin
 * @author   Orlando J Betancourth <orlando.betancourth@gmail.com>
 * @license  MIT http://
 * @link     http://
 */
class Admin extends \Controllers\PrivateController
{
    /**
     * Constructor
     */
    public function __construct()
    {
        // $userInRole = \Utilities\Security::isInRol(
        //     \Utilities\Security::getUserId(),
        //     "ADMIN"
        // );
        parent::__construct();
    }
    /** 
     * Ejecuta el controlador
     */
    public function run() :void
    {
        $user = \Utilities\Security::getUser();
        $movimientos = [];

        foreach (DaoDashboard::getMovimientosRecientes() as $movimiento) {
            $movimientos[] = [
                "movFecha" => date("d/m/Y H:i", strtotime($movimiento["movCreatedAt"])),
                "invPrdDsc" => $movimiento["invPrdDsc"],
                "movCantidad" => number_format(floatval($movimiento["movCantidad"]), 0),
                "movMotivo" => $movimiento["movMotivo"],
                "movTipoDsc" => self::getMovimientoTipoDsc($movimiento["movTipo"]),
                "movTipoClass" => self::getMovimientoTipoClass($movimiento["movTipo"])
            ];
        }

        $viewData = [
            "userName" => $user && isset($user["userName"]) ? $user["userName"] : "Usuario",
            "totalProductos" => number_format(DaoDashboard::getTotalProductosActivos(), 0),
            "totalStockBajo" => number_format(DaoDashboard::getTotalProductosStockBajo(), 0),
            "valorInventario" => "L. " . number_format(DaoDashboard::getValorInventarioActivo(), 2),
            "totalLotesPorVencer" => number_format(DaoDashboard::getTotalLotesPorVencer(), 0),
            "MovimientosRecientes" => $movimientos
        ];

        \Views\Renderer::render("admin/admin", $viewData);
    }

    private static function getMovimientoTipoDsc($tipo)
    {
        switch ($tipo) {
            case "ENT":
                return "Entrada";
            case "SAL":
                return "Salida";
            case "MER":
                return "Merma";
            default:
                return "Movimiento";
        }
    }

    private static function getMovimientoTipoClass($tipo)
    {
        switch ($tipo) {
            case "ENT":
                return "dash-badge--entry";
            case "SAL":
                return "dash-badge--exit";
            case "MER":
                return "dash-badge--loss";
            default:
                return "dash-badge--neutral";
        }
    }
}
?>
