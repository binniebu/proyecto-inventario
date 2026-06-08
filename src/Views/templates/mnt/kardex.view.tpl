<h1>Historial de Kardex (Bitácora de Inventario)</h1>
<hr>

<div style="background-color: #fff; padding: 1.25rem; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); margin-bottom: 1.5rem;">
    <form action="index.php" method="get" style="display: flex; flex-wrap: wrap; gap: 1rem; align-items: flex-end; width: 100%; margin: 0; padding: 0;">
        <input type="hidden" name="page" value="mnt_kardex">

        <div style="display: flex; flex-direction: column; gap: 0.25rem; flex: 1; min-width: 200px;">
            <label for="search_query" style="font-weight: 600; font-size: 0.85rem; color: #475569;">Buscar Producto</label>
            <input type="text" id="search_query" name="search_query" value="{{search_query}}" placeholder="Nombre o código de barras..." style="width: 100%; height: 36px; padding: 0.5rem; border: 1px solid #cbd5e1; border-radius: 4px; box-sizing: border-box;">
        </div>

        <div style="display: flex; flex-direction: column; gap: 0.25rem; min-width: 150px;">
            <label for="mov_tipo" style="font-weight: 600; font-size: 0.85rem; color: #475569;">Tipo Movimiento</label>
            <select name="mov_tipo" id="mov_tipo" style="width: 100%; height: 36px; padding: 0.25rem 0.5rem; border: 1px solid #cbd5e1; border-radius: 4px; background-color: #fff; box-sizing: border-box;">
                <option value="" {{tipo__selected}}>Todos</option>
                <option value="ENT" {{tipo_ENT_selected}}>Entradas (Compras)</option>
                <option value="SAL" {{tipo_SAL_selected}}>Salidas (Ventas)</option>
                <option value="MER" {{tipo_MER_selected}}>Mermas (Pérdidas)</option>
            </select>
        </div>

        <div style="display: flex; flex-direction: column; gap: 0.25rem; min-width: 90px;">
            <label for="year" style="font-weight: 600; font-size: 0.85rem; color: #475569;">Año</label>
            <select name="year" id="year" style="width: 100%; height: 36px; padding: 0.25rem 0.5rem; border: 1px solid #cbd5e1; border-radius: 4px; background-color: #fff; box-sizing: border-box;">
                <option value="" {{year__selected}}>Todos</option>
                <option value="2026" {{year_2026_selected}}>2026</option>
                <option value="2025" {{year_2025_selected}}>2025</option>
                <option value="2024" {{year_2024_selected}}>2024</option>
            </select>
        </div>

        <div style="display: flex; flex-direction: column; gap: 0.25rem; min-width: 110px;">
            <label for="month" style="font-weight: 600; font-size: 0.85rem; color: #475569;">Mes</label>
            <select name="month" id="month" style="width: 100%; height: 36px; padding: 0.25rem 0.5rem; border: 1px solid #cbd5e1; border-radius: 4px; background-color: #fff; box-sizing: border-box;">
                <option value="" {{month__selected}}>Todos</option>
                <option value="1" {{month_1_selected}}>Enero</option>
                <option value="2" {{month_2_selected}}>Febrero</option>
                <option value="3" {{month_3_selected}}>Marzo</option>
                <option value="4" {{month_4_selected}}>Abril</option>
                <option value="5" {{month_5_selected}}>Mayo</option>
                <option value="6" {{month_6_selected}}>Junio</option>
                <option value="7" {{month_7_selected}}>Julio</option>
                <option value="8" {{month_8_selected}}>Agosto</option>
                <option value="9" {{month_9_selected}}>Septiembre</option>
                <option value="10" {{month_10_selected}}>Octubre</option>
                <option value="11" {{month_11_selected}}>Noviembre</option>
                <option value="12" {{month_12_selected}}>Diciembre</option>
            </select>
        </div>

        <div style="display: flex; flex-direction: column; gap: 0.25rem; min-width: 130px;">
            <label for="fecha_inicio" style="font-weight: 600; font-size: 0.85rem; color: #475569;">Desde</label>
            <input type="date" id="fecha_inicio" name="fecha_inicio" value="{{fecha_inicio}}" style="width: 100%; height: 36px; padding: 0.5rem; border: 1px solid #cbd5e1; border-radius: 4px; box-sizing: border-box;">
        </div>

        <div style="display: flex; flex-direction: column; gap: 0.25rem; min-width: 130px;">
            <label for="fecha_fin" style="font-weight: 600; font-size: 0.85rem; color: #475569;">Hasta</label>
            <input type="date" id="fecha_fin" name="fecha_fin" value="{{fecha_fin}}" style="width: 100%; height: 36px; padding: 0.5rem; border: 1px solid #cbd5e1; border-radius: 4px; box-sizing: border-box;">
        </div>

        <div style="display: flex; gap: 0.5rem; min-width: 190px; box-sizing: border-box;">
            <button type="submit" style="flex: 1; height: 36px; background-color: #0f172a; color: #ffffff; border: none; border-radius: 4px; font-weight: 600; font-size: 0.9rem; cursor: pointer; transition: background 0.2s; display: inline-flex; align-items: center; justify-content: center;">
                Filtrar
            </button>
            
            <a href="index.php?page=mnt_kardex" style="flex: 1; height: 36px; background-color: #e2e8f0; color: #334155; border: none; border-radius: 4px; font-weight: 600; font-size: 0.9rem; text-decoration: none; display: inline-flex; align-items: center; justify-content: center; box-sizing: border-box;">
                Limpiar
            </a>
        </div>
    </form>
</div>

<section class="WWList">
    <table>
        <thead>
            <tr>
                <th>ID Mov</th>
                <th>Fecha/Hora</th>
                <th>Código Barras</th>
                <th>Producto</th>
                <th>Tipo</th>
                <th>Cantidad</th>
                <th>Motivo/Detalle</th>
                <th>Lote</th>
                <th>Responsable</th>
            </tr>
        </thead>
        <tbody>
            {{if has_movimientos}}
                {{foreach movimientos}}
                <tr>
                    <td>{{movId}}</td>
                    <td>{{fecha_formateada}}</td>
                    <td>{{invPrdBrCod}}</td>
                    <td><strong>{{invPrdDsc}}</strong></td>
                    <td>
                        <span class="badge {{badge_class}}">{{movTipoDsc}}</span>
                    </td>
                    <td style="text-align: right; font-weight: bold;">{{movCantidad}}</td>
                    <td>{{movMotivo}}</td>
                    <td>{{if loteId}}{{loteId}}{{ifnot loteId}}N/A{{endif loteId}}</td>
                    <td>{{username}}</td>
                </tr>
                {{endfor movimientos}}
            {{endif has_movimientos}}

            {{ifnot has_movimientos}}
            <tr>
                <td colspan="9" style="text-align: center; padding: 2rem; color: #777;">
                    <strong>No se encontraron movimientos que coincidan con los filtros seleccionados.</strong>
                </td>
            </tr>
            {{endifnot has_movimientos}}
        </tbody>
    </table>
</section>

<script>
 
</script>