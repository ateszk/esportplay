<?php

namespace FusionFramework;

class Response
{
    /**
     * @param string $path
     * @param array  $params
     * @param string $tab
     */
    public function redirect($path, $params = [], $tab = '')
    {
        $paramString = '';
        foreach ($params as $paramName => $paramValue) {
            $paramString .= "&{$paramName}={$paramValue}";
        }

        if (count(explode('_', $path)) === 2) {
            $path = 'pixiefreakpanel_' . $path;
            ?>
                <script>
                    window.location.href = '<?php echo get_admin_url(null, 'admin.php?page=' . $path . $paramString . '#' . $tab); ?>';
                </script>
            <?php
        }

        ?>
            <script>
                window.location.href = '<?php echo esc_url($path . $paramString); ?>';
            </script>
        <?php
    }

    /**
     * @param array $data
     */
    public function json($data = [])
    {
        if (!is_array($data)) {
            if (is_integer($data) || is_numeric($data)) {
                $data = [$data];
            } else {
                $data = [$data];
            }
        }

        foreach ($data as $key => $value) {
            if ($this->checkEmail($value)) {
                $data[$key] = str_replace('@', ':email:', $value);
            }
        }


        echo '+!!!JSON!!!+'.json_encode($data, JSON_UNESCAPED_SLASHES) .'+!!!!JSON!!!!+'; exit;
    }

    /**
     * @param  string $email
     * @return bool
     */
    private function checkEmail($email) {
        $find1 = strpos($email, '@');
        $find2 = strpos($email, '.');
        return ($find1 !== false && $find2 !== false && $find2 > $find1 ? true : false);
    }
}