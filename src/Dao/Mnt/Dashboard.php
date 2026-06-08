<?php

namespace Dao\Mnt;

class Dashboard extends \Dao\Table
{
    public static function getMovimientosRecientes()
    {
        $sqlstr = "SELECT m.movCreatedAt, m.movTipo, m.movCantidad, m.movMotivo, p.invPrdDsc
                   FROM movimientos_inventario m
                   INNER JOIN productos p ON m.invPrdId = p.invPrdId
                   ORDER BY m.movCreatedAt DESC
                   LIMIT 5;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getTotalProductosActivos()
    {
        $sqlstr = "SELECT COUNT(*) as total FROM productos WHERE invPrdEst = 'ACT';";
        $result = self::obtenerUnRegistro($sqlstr, []);
        return $result ? intval($result["total"]) : 0;
    }

    public static function getTotalProductosStockBajo()
    {
        $sqlstr = "SELECT COUNT(*) as total FROM productos WHERE invPrdStock <= invPrdStockMin AND invPrdEst = 'ACT';";
        $result = self::obtenerUnRegistro($sqlstr, []);
        return $result ? intval($result["total"]) : 0;
    }

    public static function getValorInventarioActivo()
    {
        $sqlstr = "SELECT SUM(invPrdStock * invPrdCosto) as total_valor FROM productos WHERE invPrdEst = 'ACT';";
        $result = self::obtenerUnRegistro($sqlstr, []);
        return $result && $result["total_valor"] ? floatval($result["total_valor"]) : 0.00;
    }

    public static function getTotalLotesPorVencer()
    {
        $sqlstr = "SELECT COUNT(*) as total FROM lotes_inventario 
                   WHERE loteCantActual > 0 
                     AND loteFechaVencimiento IS NOT NULL 
                     AND loteFechaVencimiento <= DATE_ADD(NOW(), INTERVAL 30 DAY);";
        $result = self::obtenerUnRegistro($sqlstr, []);
        return $result ? intval($result["total"]) : 0;
    }
}
