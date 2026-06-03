<?php
namespace Controllers\Admin;

use Controllers\PrivateController;
use Views\Renderer;

class Bitacoras extends PrivateController
{
    public function run(): void
    {
        $viewData = [];
        Renderer::render("admin/bitacoras", $viewData);
    }
}
?>
