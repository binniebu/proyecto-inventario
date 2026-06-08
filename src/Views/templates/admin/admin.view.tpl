<style>
  .dashboard-header {
    margin-bottom: 1.75rem;
    border-bottom: 1px solid #dbe3ef;
    padding-bottom: 1.25rem;
  }

  .dashboard-header h1 {
    margin: 0;
    color: #0f172a;
    font-size: 1.85rem;
    font-weight: 800;
    line-height: 1.2;
  }

  .dashboard-header p {
    margin: 0.35rem 0 0;
    color: #64748b;
    font-size: 0.98rem;
  }

  .dashboard-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
    gap: 1rem;
    margin-bottom: 1.75rem;
  }

  .dashboard-card {
    display: flex;
    align-items: center;
    gap: 1rem;
    min-height: 116px;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    background: #ffffff;
    padding: 1.15rem;
    box-shadow: 0 8px 20px rgba(15, 23, 42, 0.06);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }

  .dashboard-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 14px 28px rgba(15, 23, 42, 0.1);
  }

  .dashboard-icon {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 52px;
    height: 52px;
    flex: 0 0 52px;
    border-radius: 8px;
    font-size: 1.35rem;
  }

  .dashboard-label {
    margin: 0;
    color: #64748b;
    font-size: 0.82rem;
    font-weight: 700;
    letter-spacing: 0;
    text-transform: uppercase;
  }

  .dashboard-value {
    margin: 0.25rem 0 0;
    color: #0f172a;
    font-size: 1.75rem;
    font-weight: 800;
    line-height: 1.1;
  }

  .dashboard-card--blue .dashboard-icon {
    background: #dbeafe;
    color: #1d4ed8;
  }

  .dashboard-card--amber .dashboard-icon {
    background: #fef3c7;
    color: #b45309;
  }

  .dashboard-card--green .dashboard-icon {
    background: #dcfce7;
    color: #15803d;
  }

  .dashboard-card--red .dashboard-icon {
    background: #fee2e2;
    color: #b91c1c;
  }

  .dashboard-panel {
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    background: #ffffff;
    box-shadow: 0 8px 20px rgba(15, 23, 42, 0.05);
    overflow: hidden;
  }

  .dashboard-panel__header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1rem;
    padding: 1rem 1.15rem;
    border-bottom: 1px solid #e2e8f0;
  }

  .dashboard-panel__header h2 {
    margin: 0;
    color: #0f172a;
    font-size: 1.1rem;
    font-weight: 800;
  }

  .dashboard-panel__header span {
    color: #64748b;
    font-size: 0.9rem;
    font-weight: 600;
  }

  .dashboard-table-wrap {
    overflow-x: auto;
  }

  .dashboard-table {
    width: 100%;
    border-collapse: collapse;
  }

  .dashboard-table th,
  .dashboard-table td {
    padding: 0.85rem 1rem;
    border-bottom: 1px solid #edf2f7;
    text-align: left;
    vertical-align: middle;
  }

  .dashboard-table th {
    color: #475569;
    background: #f8fafc;
    font-size: 0.78rem;
    font-weight: 800;
    letter-spacing: 0;
    text-transform: uppercase;
  }

  .dashboard-table td {
    color: #0f172a;
    font-size: 0.92rem;
  }

  .dashboard-table tr:last-child td {
    border-bottom: 0;
  }

  .dash-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 76px;
    border-radius: 999px;
    padding: 0.25rem 0.65rem;
    font-size: 0.78rem;
    font-weight: 800;
  }

  .dash-badge--entry {
    background: #dcfce7;
    color: #166534;
  }

  .dash-badge--exit {
    background: #dbeafe;
    color: #1d4ed8;
  }

  .dash-badge--loss {
    background: #fee2e2;
    color: #991b1b;
  }

  .dash-badge--neutral {
    background: #e2e8f0;
    color: #334155;
  }

  .dashboard-empty {
    padding: 2rem 1rem;
    text-align: center;
    color: #64748b;
    font-weight: 600;
  }

  @media (max-width: 640px) {
    .dashboard-header h1 {
      font-size: 1.45rem;
    }

    .dashboard-card {
      min-height: 104px;
    }

    .dashboard-value {
      font-size: 1.45rem;
    }

    .dashboard-panel__header {
      align-items: flex-start;
      flex-direction: column;
    }
  }
</style>

<div class="dashboard-header">
  <h1>Bienvenido, {{userName}}</h1>
  <p>Resumen general de productos, alertas de stock, valor acumulado y actividad reciente del inventario.</p>
</div>

<section class="dashboard-grid">
  <article class="dashboard-card dashboard-card--blue">
    <div class="dashboard-icon">
      <i class="fas fa-boxes"></i>
    </div>
    <div>
      <p class="dashboard-label">Total de Productos</p>
      <p class="dashboard-value">{{totalProductos}}</p>
    </div>
  </article>

  <article class="dashboard-card dashboard-card--amber">
    <div class="dashboard-icon">
      <i class="fas fa-exclamation-triangle"></i>
    </div>
    <div>
      <p class="dashboard-label">Stock Crítico</p>
      <p class="dashboard-value">{{totalStockBajo}}</p>
    </div>
  </article>

  <article class="dashboard-card dashboard-card--green">
    <div class="dashboard-icon">
      <i class="fas fa-coins"></i>
    </div>
    <div>
      <p class="dashboard-label">Valor del Inventario</p>
      <p class="dashboard-value">{{valorInventario}}</p>
    </div>
  </article>

  <article class="dashboard-card dashboard-card--red">
    <div class="dashboard-icon">
      <i class="fas fa-calendar-times"></i>
    </div>
    <div>
      <p class="dashboard-label">Lotes por Vencer</p>
      <p class="dashboard-value">{{totalLotesPorVencer}}</p>
    </div>
  </article>
</section>

<section class="dashboard-panel">
  <div class="dashboard-panel__header">
    <h2>Actividad Reciente</h2>
    <span>Últimos 5 movimientos registrados</span>
  </div>

  {{if MovimientosRecientes}}
  <div class="dashboard-table-wrap">
    <table class="dashboard-table">
      <thead>
        <tr>
          <th>Fecha/Hora</th>
          <th>Producto</th>
          <th>Tipo</th>
          <th style="text-align: right;">Cantidad</th>
        </tr>
      </thead>
      <tbody>
        {{foreach MovimientosRecientes}}
        <tr>
          <td>{{movFecha}}</td>
          <td>{{invPrdDsc}}</td>
          <td><span class="dash-badge {{movTipoClass}}" title="{{movMotivo}}">{{movTipoDsc}}</span></td>
          <td style="text-align: right; font-weight: 800;">{{movCantidad}}</td>
        </tr>
        {{endfor MovimientosRecientes}}
      </tbody>
    </table>
  </div>
  {{endif MovimientosRecientes}}

  {{ifnot MovimientosRecientes}}
  <div class="dashboard-empty">
    Todavía no hay actividad reciente para mostrar.
  </div>
  {{endifnot MovimientosRecientes}}
</section>
