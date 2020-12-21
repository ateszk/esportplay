<?php

namespace FusionFramework;


class View
{
    /**
     * @var string $templateDirectory | Templates root directory.
     */
    protected $templateDirectory = __DIR__ . '/../app/View';

    /**
     * @var string $templateLayouts | Layouts (Header, Footer) root directory.
     */
    protected $templateLayoutDirectory = __DIR__ . '/../app/View/layouts';

    /**
     * @var array $viewArguments
     */
    protected $viewArguments = [];

    /**
     * @param  string $template
     * @param  array  $viewArgs
     * @param  bool   $renderLayout
     * @param  bool   $returnAsString
     * @return string
     */
    public function render($template = '', $viewArgs = [], $renderLayout = true, $returnAsString = false)
    {
        $this->viewArguments = $viewArgs;

        $normalizedTemplatePath = str_replace('.', '/', $template) . '.phtml';

        ob_start();
        $renderLayout
            ? $this->renderWithLayout($normalizedTemplatePath)
            : $this->renderSingle($normalizedTemplatePath)
        ;

        if (!$returnAsString) {
            echo ltrim(ob_get_clean());
        }

        return ltrim(ob_get_clean());
    }

    /**
     * @param string $normalizedTemplatePath
     */
    protected function renderWithLayout($normalizedTemplatePath)
    {
        $templateLayoutDirectory = $this->getTemplateLayoutDirectory();

        // Extract variables to view script.
        extract($this->viewArguments, EXTR_SKIP);
        $notification = get_notification();

        if (file_exists($header = $templateLayoutDirectory .'/header.phtml')) {
            require_once $header;
        }

        $templateDirectory = $this->getTemplateDirectory();
        require_once $templateDirectory .'/'. $normalizedTemplatePath;

        if (file_exists($footer = $templateLayoutDirectory .'/footer.phtml')) {
            require_once $footer;
        }
    }

    /**
     * @param string $normalizedTemplatePath
     */
    protected function renderSingle($normalizedTemplatePath)
    {
        // Extract variables to view script.
        extract($this->viewArguments, EXTR_SKIP);
        $notification = get_notification();

        $templateDirectory = $this->getTemplateDirectory();
        require_once $templateDirectory .'/'. $normalizedTemplatePath;
    }

    /**
     * @param $directory
     * @return View
     */
    public function setTemplateDirectory($directory)
    {
        $this->templateDirectory = $directory;
        return $this;
    }

    /**
     * @return string
     */
    public function getTemplateDirectory()
    {
        return $this->templateDirectory;
    }

    /**
     * @return string
     */
    public function getTemplateLayoutDirectory()
    {
        return $this->templateLayoutDirectory;
    }

    /**
     * @param string $templateLayoutDirectory
     * @return View
     */
    public function setTemplateLayoutDirectory(string $templateLayoutDirectory)
    {
        $this->templateLayoutDirectory = $templateLayoutDirectory;
        return $this;
    }
}