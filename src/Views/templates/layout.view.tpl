<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{SITE_TITLE}}</title>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
  
  <link rel="stylesheet" href="{{BASE_PATH}}/public/css/appstyle.css" />
  <link rel="stylesheet" href="{{BASE_PATH}}/public/css/style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  
  {{foreach SiteLinks}}
    <link rel="stylesheet" href="{{~BASE_PATH}}/{{this}}" />
  {{endfor SiteLinks}}
  {{foreach BeginScripts}}
    <script src="{{~BASE_PATH}}/{{this}}"></script>
  {{endfor BeginScripts}}
</head>

<body>
  <header style="justify-content: center;">
    <h1>{{SITE_TITLE}}</h1>
  </header>
  <main>
  {{{page_content}}}
  </main>
  <footer>
    <div>Todo los Derechos Reservados 2021 &copy;</div>
  </footer>
  {{foreach EndScripts}}
    <script src="{{~BASE_PATH}}/{{this}}"></script>
  {{endfor EndScripts}}
</body>
</html>
