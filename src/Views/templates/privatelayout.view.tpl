<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{SITE_TITLE}}</title>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/{{BASE_DIR}}/public/css/appstyle.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  {{foreach SiteLinks}}
  <link rel="stylesheet" href="/{{~BASE_DIR}}/{{this}}" />
  {{endfor SiteLinks}}
  {{foreach BeginScripts}}
  <script src="/{{~BASE_DIR}}/{{this}}"></script>
  {{endfor BeginScripts}}
</head>


<body>
  <input type="checkbox" class="menu_toggle" id="menu_toggle" />
  <nav id="menu">
    <div class="sidebar_header">
      <span class="sidebar_title">Inventario</span>
      <label for="menu_toggle" class="sidebar_toggle_btn">
        <i class="fas fa-angles-left"></i> <!-- Icono moderno para colapsar -->
      </label>
    </div>
    <ul class="nav_list">
      <li><a href="index.php?page=admin_admin"><i class="fas fa-chart-line"></i>&nbsp;Dashboard</a></li>
      {{foreach NAVIGATION}}
          <li><a href="{{nav_url}}"><i class="{{nav_icon}}"></i>&nbsp;{{nav_label}}</a></li>
      {{endfor NAVIGATION}}
    </ul>
    <ul class="nav_logout_list">
      {{with login}}
      <li class="user_card_item">
        <a href="index.php?page=sec_perfil" class="user_card">
          <i class="fas fa-user-circle"></i>
          <div class="user_card_info">
            <span class="user_card_name">{{userName}}</span>
            <span class="user_card_email">{{userEmail}}</span>
          </div>
        </a>
      </li>
      {{endwith login}}
      <li><a href="index.php?page=sec_logout" class="logout_btn"><i class="fas fa-sign-out-alt"></i>&nbsp;Cerrar Sesión</a></li>
    </ul>
  </nav>
  <label for="menu_toggle" class="menu_overlay"></label>
  <header>
    <label for="menu_toggle" class="menu_toggle_icon">
      <div class="hmb dgn pt-1"></div>
      <div class="hmb hrz"></div>
      <div class="hmb dgn pt-2"></div>
    </label>
    <h1>{{SITE_TITLE}}</h1>
  </header>


  <main>
    {{{page_content}}}
  </main>

  <footer>
    <div>Todo los Derechos Reservados 2021 &copy;</div>
  </footer>
  {{foreach EndScripts}}
  <script src="/{{~BASE_DIR}}/{{this}}"></script>
  {{endfor EndScripts}}
</body>
</html>
