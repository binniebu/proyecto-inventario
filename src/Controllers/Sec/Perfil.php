<?php
namespace Controllers\Sec;

use Controllers\PrivateController;
use Views\Renderer;

class Perfil extends PrivateController
{
    public function run(): void
    {
        $viewData = [];
        Renderer::render("security/perfil", $viewData);
    }
}
?>
