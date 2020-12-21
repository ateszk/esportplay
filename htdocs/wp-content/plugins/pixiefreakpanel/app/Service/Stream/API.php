<?php

namespace PixieFreakPanel\Service\Stream;

class API
{
    const NETWORKS = [
        'youtube',
        'twitch',
        'mixer'
    ];

    /**
     * @param  string $apiKey
     * @param  string $network
     * @return bool
     */
    public static function handshake($apiKey, $network)
    {
        if (in_array($network, self::NETWORKS)) {
            $network = ucfirst($network);
            $method  = "validate{$network}";
            return self::$method($apiKey);
        }

        return false;
    }

    /**
     * @param  string $apiKey
     * @return bool
     */
    public static function validateYoutube($apiKey)
    {
        $endpoint = 'https://www.googleapis.com/youtube/v3/search?part=snippet&q=YouTube+Data+API&type=video&key=' . $apiKey;
        $request  = self::request($endpoint);
        if ($request && $request->getStatusCode() == 200) {
            return true;
        }

        return false;
    }

    /**
     * @param  string $apiKey
     * @return bool
     */
    public static function validateTwitch($apiKey)
    {
        $endpoint = 'https://api.twitch.tv/helix/streams?game_id=33214';
        $request  = self::request($endpoint, $apiKey);
        if ($request && $request->getStatusCode() == 200) {
            return true;
        }

        return false;
    }

    /**
     * @param  string $endpoint
     * @param  string $twitchKey
     * @return \stdClass|bool
     */
    private static function request($endpoint, $twitchKey = '')
    {
        if (!$endpoint
            || !is_string($endpoint)
            || ! preg_match('/^http(s)?:\/\/[a-z0-9-]+(.[a-z0-9-]+)*(:[0-9]+)?(\/.*)?$/i', $endpoint))
        {
            return false;
        }

        $options = array(
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_HEADER         => true,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_MAXREDIRS      => 10,
            CURLOPT_ENCODING       => '',
            CURLOPT_USERAGENT      => 'test',
            CURLOPT_AUTOREFERER    => true,
            CURLOPT_CONNECTTIMEOUT => 120,
            CURLOPT_TIMEOUT        => 120,
        );

        if (!empty($twitchKey)) {
            $options[CURLOPT_HTTPHEADER] = ['Client-Id:  ' . $twitchKey];
        }

        $ch = curl_init($endpoint);
        curl_setopt_array($ch, $options);

        $content = curl_exec($ch);
        $code    = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        curl_close($ch);

        return ((new class {
            protected $content;
            protected $code;

            public function construct($content, $code)
            {
                $this->content = $content;
                $this->code = $code;
                return $this;
            }

            public function getContent()
            {
                return $this->content;
            }

            public function getStatusCode()
            {
                return $this->code;
            }

        })->construct($content, $code));
    }
}