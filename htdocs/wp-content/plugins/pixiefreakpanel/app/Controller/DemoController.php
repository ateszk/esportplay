<?php

namespace PixieFreakPanel\Controller;

use FusionFramework\Database\ORM;
use FusionFramework\Request;
use PixieFreakPanel\Model\Tables;

class DemoController extends Controller
{
    /**
     * @var string $seedPath
     */
    protected $seedPath = __DIR__ . '/../../database/seed/';

    /**
     * DemoController constructor.
     *
     * @param Request $request
     * @param string|null $DBAL
     */
    public function __construct(Request $request, string $DBAL = null)
    {
        if (!empty($request->getRaw('page')) && $request->getRaw('page') === 'pixiefreakpanel_demo_export') {
            $this->export(); die();
        } else if ($request->getRaw('page') && $request->getRaw('page') === 'pixiefreakpanel_demo_import') {
            $this->import($request); die();
        }

        parent::__construct($request, $DBAL);
    }

    /**
     * @param Request $request
     */
    public function import(Request $request)
    {
        global $wpdb;
        if (empty($request->get('import_type')) && empty($request->getFiles()['database_file'])) {
            return response()->redirect('general_index', $this->defaultResponseData(), 'demo');
        }

        $files = $request->getFiles();
        if ($request->has('import_type') && !empty($request->get('import_type'))) {
            $files = [];
            $files['database_file']['tmp_name'] = __DIR__ . './../../database/demo/' . $request->get('import_type') . '.sql';
        }

        try {

            if (!empty($file = $files['database_file']) && !empty($files['database_file']['tmp_name'])) {

                try {
                    $id = @ORM::query()
                        ->setTable($table = $wpdb->prefix . 'options')
                        ->where('option_name', 'theme_mods_pixiefreak')
                        ->get()
                        ->first()
                        ->option_id
                    ;

                    ORM::query()->raw("DELETE FROM {$table} WHERE option_id='{$id}'");

                } catch (\Exception $ex) {}

                Tables::clear(); // Drop old pixiefreak tables

                $filename   = $file['tmp_name'];
                $host       = DB_HOST;
                $username   = DB_USER;
                $password   = DB_PASSWORD;
                $database   = DB_NAME;
                $connection = mysqli_connect($host, $username, $password, $database);
                if (mysqli_connect_errno()) {
                    echo 'Failed to connect to MySQL: ' . mysqli_connect_error();
                }

                $tmpLine = '';
	            $dbPrefix = '';
                $fp = fopen($filename, 'r');
                while (($line = fgets($fp)) !== false) {
                    if (substr($line, 0, 2) == '--' || $line == '') { // Skip it if it's a comment
                        continue;
                    }

                    if (!empty(trim($line)) && empty($dbPrefix)) {
	                    preg_match("/\s+TABLE\s+`?([a-z\d_]+)`?/i", $line, $match);
	                    $prefixFinder = explode('pixiefreak_about', $match[1]);
	                    if (!empty($prefixFinder[0])) {
	                    	$dbPrefix = $prefixFinder[0];
	                    }
                    }


	                $tmpLine .= str_replace($dbPrefix, $wpdb->prefix, $line);;
                    if (substr(trim($line), -1, 1) == ';') {
                        if (!mysqli_query($connection, $tmpLine)) {
                            print_r('Error performing query \'<strong>' . $tmpLine . '\': ' . mysqli_error($connection) . '<br /><br />');
                        }

                        $tmpLine = '';
                    }
                }

                mysqli_close($connection);
                fclose($fp);

                $responseData = ['notification' => esc_html__('Database successfully imported.', 'pixiefreakpanel')];
                return response()->redirect('general_index', $responseData, 'demo');
            }
        } catch (\Exception $ex) {
            //dd($ex);
        }


        return response()->redirect('general_index', $this->defaultResponseData(), 'demo');
    }

    public function export()
    {
        global $wpdb;

        $mysqli = new \mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
        $mysqli->select_db(DB_NAME);
        $mysqli->query("SET NAMES 'utf8'");

        foreach ($tables = Tables::dump() as $key => $table) {
            $result = $mysqli->query('SELECT * FROM ' . $table);
            $fieldsAmount = $result->field_count;
            $rowsNum = $mysqli->affected_rows;
            $res = $mysqli->query('SHOW CREATE TABLE '.$table);
            $tableLine = $res->fetch_row();
            $content = (!isset($content) ?  '' : $content) . "\n\n".$tableLine[1].";\n\n";
            for ($i = 0, $strCnt = 0; $i < $fieldsAmount;   $i++, $strCnt=0) {
                while ($row = $result->fetch_row()) {
                    if ($strCnt % 100 == 0 || $strCnt == 0) {
                        $content .= "\nINSERT INTO ".$table." VALUES";
                    }

                    $content .= "\n(";
                    for ($j=0; $j<$fieldsAmount; $j++)
                    {
                        $row[$j] = str_replace("\n","\\n", addslashes($row[$j]) );
                        isset($row[$j])
                            ? $content .= '"'.$row[$j].'"'
                            : $content .= '""'
                        ;

                        if ($j<($fieldsAmount-1)) {
                            $content.= ',';
                        }
                    }

                    $content .= ')';

                    ((($strCnt + 1) % 100 == 0 && $strCnt != 0) || $strCnt + 1 == $rowsNum)
                        ? $content .= ';'
                        : $content .= ','
                    ;

                    $strCnt = $strCnt + 1;
                }
            }
        }

        $insertVal = serialize(get_option('theme_mods_pixiefreak'));
        $wpOptionsSql =
            "\n\n INSERT INTO " . $wpdb->prefix . "options " .
            " VALUES (NULL, 'theme_mods_pixiefreak', '".$insertVal."', 'yes');";

        $content = $content . $wpOptionsSql;
        $content = str_replace('""', 'NULL', $content);
        $backupName = 'pixiefreak-' . date('y-m-d-h:i:s') . '.sql';
        file_put_contents($filename = __DIR__ . '/../../database/seed/' . $backupName, $content, FILE_APPEND);

        if (file_exists($filename)) {
            header_remove();
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename="'.basename($filename).'"');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($filename));
            flush();
            readfile($filename);
            exit;
        }

        return response()->redirect('general_index', $this->defaultResponseData(), 'demo');
    }
}