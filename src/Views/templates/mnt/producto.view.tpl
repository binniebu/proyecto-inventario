<div style="margin-bottom: 2rem; border-bottom: 1px solid #cbd5e1; padding-bottom: 1rem;">
  <h1 style="margin: 0; font-size: 1.75rem; font-weight: 700; color: #0f172a;">{{mode_dsc}}</h1>
  <p style="color: #64748b; margin-top: 0.25rem;">Completa los datos del producto.</p>
</div>

{{if hasErrors}}
<div style="background-color: #fef2f2; border-left: 4px solid #ef4444; padding: 1rem; border-radius: 4px; margin-bottom: 1.5rem; max-width: 600px; margin-left: auto; margin-right: auto;">
  <ul style="margin: 0; padding-left: 1.25rem; color: #b91c1c; font-size: 0.9rem;">
    {{foreach aErrors}}
    <li>{{this}}</li>
    {{endfor aErrors}}
  </ul>
</div>
{{endif hasErrors}}

<form action="index.php?page=mnt_producto&mode={{mode}}&id={{id}}&catid={{catid_url}}" method="POST" class="form_card">
  <input type="hidden" name="mode" value="{{mode}}" />
  <input type="hidden" name="id" value="{{invPrdId}}" />
  <input type="hidden" name="catid_url" value="{{catid_url}}" />

  <div class="form_field">
    <label for="invPrdDsc">Nombre/Descripción del Producto *</label>
    <input type="text" id="invPrdDsc" name="invPrdDsc" value="{{invPrdDsc}}" required {{readonly}} placeholder="Ej. Coca-Cola 3 Litros" />
  </div>

  <div class="form_row">
    <div class="form_field">
      <label for="invPrdBrCod">Código de Barras</label>
      <input type="text" id="invPrdBrCod" name="invPrdBrCod" value="{{invPrdBrCod}}" {{readonly}} placeholder="Ej. 744100123456" />
    </div>

    <div class="form_field">
      <label for="invPrdCodInt">Código Interno</label>
      <input type="text" id="invPrdCodInt" name="invPrdCodInt" value="{{invPrdCodInt}}" {{readonly}} placeholder="Ej. PRD-0001" />
    </div>
  </div>

  <div class="form_field">
    <label for="catid">Categoría del Producto *</label>
    <select id="catid" name="catid" required {{if readonly}}disabled{{endif readonly}}>
      <option value="">-- Selecciona una Categoría --</option>
      {{foreach Categorias}}
      <option value="{{catid}}" {{selected}}>{{catnom}}</option>
      {{endfor Categorias}}
    </select>
  </div>

  <div class="form_field" style="position: relative;">
    <label for="provBuscar">Proveedor</label>
    <input type="text" id="provBuscar" name="provBuscar" value="{{provNombre}}" {{readonly}} autocomplete="off" placeholder="Escribe para buscar proveedor..." />
    <input type="hidden" name="provId" id="provId" value="{{provId}}" />
    <div id="proveedor-resultados" style="border: 1px solid #cbd5e1; border-radius: 6px; max-height: 180px; overflow-y: auto; display: none; background: #ffffff; position: absolute; left: 0; right: 0; z-index: 1000; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); margin-top: 2px;"></div>
  </div>

  <div class="form_row">
    <div class="form_field">
      <label for="invPrdPrecioVenta">Precio de Venta *</label>
      <input type="number" step="0.01" min="0.01" id="invPrdPrecioVenta" name="invPrdPrecioVenta" value="{{invPrdPrecioVenta}}" required {{readonly}} placeholder="0.00" style="text-align: right;" />
    </div>

    <div class="form_field">
      <label for="invPrdCosto">Costo de Adquisición *</label>
      <input type="number" step="0.01" min="0.00" id="invPrdCosto" name="invPrdCosto" value="{{invPrdCosto}}" required {{readonly}} placeholder="0.00" style="text-align: right;" />
    </div>
  </div>

  <div class="form_row">
    <div class="form_field">
      <label for="invPrdStock">Stock Físico *</label>
      <input type="number" min="0" id="invPrdStock" name="invPrdStock" value="{{invPrdStock}}" required {{stock_readonly}} placeholder="0" style="text-align: center;" />
    </div>

    <div class="form_field">
      <label for="invPrdStockMin">Stock Mínimo (Alerta) *</label>
      <input type="number" min="0" id="invPrdStockMin" name="invPrdStockMin" value="{{invPrdStockMin}}" required {{readonly}} placeholder="10" style="text-align: center;" />
    </div>
  </div>

  {{if show_lote_fields}}
  <div class="form_row" style="background-color: #f8fafc; border: 1px dashed #cbd5e1; padding: 1.25rem; border-radius: 8px; margin-bottom: 1.5rem;">
    <h3 style="grid-column: 1 / -1; margin-top: 0; margin-bottom: 0.75rem; font-size: 0.95rem; color: #475569; font-weight: 700;">Lote de Inventario Inicial</h3>
    <div class="form_field">
      <label for="loteCod">Código de Lote (Requerido si stock > 0)</label>
      <input type="text" id="loteCod" name="loteCod" placeholder="Ej. LOTE-01" />
    </div>
    <div class="form_field">
      <label for="loteFechaVencimiento">Fecha de Vencimiento (Opcional)</label>
      <input type="date" id="loteFechaVencimiento" name="loteFechaVencimiento" />
    </div>
  </div>
  {{endif show_lote_fields}}

  <div class="form_row">
    <div class="form_field">
      <label for="invPrdTip">Tipo *</label>
      <select id="invPrdTip" name="invPrdTip" required {{if readonly}}disabled{{endif readonly}}>
        <option value="PRD" {{invPrdTip_PRD}}>Producto</option>
        <option value="SRV" {{invPrdTip_SRV}}>Servicio</option>
      </select>
    </div>

    <div class="form_field">
      <label for="invPrdEst">Estado *</label>
      <select id="invPrdEst" name="invPrdEst" required {{if readonly}}disabled{{endif readonly}}>
        <option value="DIS" {{invPrdEst_DIS}}>Disponible</option>
        <option value="AGO" {{invPrdEst_AGO}}>Agotado</option>
        <option value="CAS" {{invPrdEst_CAS}}>Casi Agotado</option>
        <option value="INA" {{invPrdEst_INA}}>Descontinuado (Inactivo)</option>
      </select>
    </div>
  </div>

  <div class="form_actions">
    <button type="button" id="btn-cancelar" class="secondary">
      Cancelar
    </button>
    {{if showaction}}
    <button type="submit" class="primary">
      Guardar Producto
    </button>
    {{endif showaction}}
  </div>
</form>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    var proveedoresData = {{proveedores_json}};
    var provBuscar = document.getElementById("provBuscar");
    var provId = document.getElementById("provId");
    var proveedorResultados = document.getElementById("proveedor-resultados");

    function hideProveedorResultados() {
      if (proveedorResultados) {
        proveedorResultados.style.display = "none";
      }
    }

    function renderProveedorResultados(matches) {
      if (!proveedorResultados) return;
      proveedorResultados.innerHTML = "";

      if (matches.length === 0) {
        hideProveedorResultados();
        return;
      }

      matches.forEach(function(prov) {
        var item = document.createElement("div");
        item.style.padding = "0.75rem";
        item.style.borderBottom = "1px solid #f1f5f9";
        item.style.cursor = "pointer";
        item.style.textAlign = "left";
        item.style.fontSize = "0.9rem";
        item.textContent = prov.provNombre;

        item.addEventListener("mouseover", function() {
          item.style.background = "#f8fafc";
        });
        item.addEventListener("mouseout", function() {
          item.style.background = "#ffffff";
        });
        item.addEventListener("click", function() {
          if (provBuscar) provBuscar.value = prov.provNombre;
          if (provId) provId.value = prov.provId;
          hideProveedorResultados();
        });

        proveedorResultados.appendChild(item);
      });

      proveedorResultados.style.display = "block";
    }

    if (provBuscar && provId && proveedorResultados && !provBuscar.hasAttribute("readonly")) {
      provBuscar.addEventListener("input", function() {
        var query = provBuscar.value.trim().toLowerCase();
        provId.value = "";

        if (query.length === 0) {
          hideProveedorResultados();
          return;
        }

        var matches = proveedoresData.filter(function(prov) {
          return prov.provNombre.toLowerCase().indexOf(query) > -1;
        }).slice(0, 8);

        renderProveedorResultados(matches);
      });

      document.addEventListener("click", function(e) {
        if (e.target !== provBuscar && e.target.parentNode !== proveedorResultados) {
          hideProveedorResultados();
        }
      });
    }

    var btnCancelar = document.getElementById("btn-cancelar");
    if (btnCancelar) {
      btnCancelar.addEventListener("click", function() {
        window.location.assign("index.php?page=mnt_productos&catid={{catid_url}}");
      });
    }

    var form = document.querySelector("form");
    if (form) {
      form.addEventListener("submit", function(e) {
        var stockInput = document.getElementById("invPrdStock");
        var loteInput = document.getElementById("loteCod");
        if (stockInput && loteInput) {
          var stock = parseInt(stockInput.value, 10) || 0;
          var lote = loteInput.value.trim();
          if (stock > 0 && lote === "") {
            e.preventDefault();
            alert("¡Error: Debe proporcionar un código de lote si el stock inicial es mayor a cero!");
            loteInput.focus();
            return false;
          }
        }
      });
    }
  });
</script>
