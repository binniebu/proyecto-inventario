<?php
namespace Controllers\Mnt;

use Controllers\PrivateController;
use Views\Renderer;

class Categorias extends PrivateController
{
    public function run(): void
    {
        $viewData = [];
        Renderer::render("mnt/categorias", $viewData);
    }
}
?>
