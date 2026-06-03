<?php
namespace Controllers\Mnt;

use Controllers\PrivateController;
use Views\Renderer;

class Kardex extends PrivateController
{
    public function run(): void
    {
        $viewData = [];
        Renderer::render("mnt/kardex", $viewData);
    }
}
?>
