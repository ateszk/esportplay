<?php
/**
 * A WordPress fő konfigurációs állománya
 *
 * Ebben a fájlban a következő beállításokat lehet megtenni: MySQL beállítások
 * tábla előtagok, titkos kulcsok, a WordPress nyelve, és ABSPATH.
 * További információ a fájl lehetséges opcióiról angolul itt található:
 * {@link http://codex.wordpress.org/Editing_wp-config.php Editing wp-config.php}
 *  A MySQL beállításokat a szolgáltatónktól kell kérni.
 *
 * Ebből a fájlból készül el a telepítési folyamat közben a wp-config.php
 * állomány. Nem kötelező a webes telepítés használata, elegendő átnevezni
 * "wp-config.php" névre, és kitölteni az értékeket.
 *
 * @package WordPress
 */

// ** MySQL beállítások - Ezeket a szolgálatótól lehet beszerezni ** //
/** Adatbázis neve */
define( 'DB_NAME', 'b18914' );

/** MySQL felhasználónév */
define( 'DB_USER', 'b18914' );

/** MySQL jelszó. */
define( 'DB_PASSWORD', '96Fxseb7' );

/** MySQL  kiszolgáló neve */
define( 'DB_HOST', 'a042um.forpsi.com' );

/** Az adatbázis karakter kódolása */
define( 'DB_CHARSET', 'utf8mb4' );

/** Az adatbázis egybevetése */
define('DB_COLLATE', '');

/**#@+
 * Bejelentkezést tikosító kulcsok
 *
 * Változtassuk meg a lenti konstansok értékét egy-egy tetszóleges mondatra.
 * Generálhatunk is ilyen kulcsokat a {@link http://api.wordpress.org/secret-key/1.1/ WordPress.org titkos kulcs szolgáltatásával}
 * Ezeknek a kulcsoknak a módosításával bármikor kiléptethető az összes bejelentkezett felhasználó az oldalról.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY', 'w(06gmCd=NNjDg~T{h:Uf%%OIvt&^@hH~rm+LeuY$%#hn:pBJfG]$%kWg|rQ+Icd' );
define( 'SECURE_AUTH_KEY', '7252 V|(/1B,~SQa Z_[`N?8K>U`|P%gp8CEh5ujyK _r.TLi:;qggMu$!zzpaWu' );
define( 'LOGGED_IN_KEY', 'K|wj+t5W&^:T+nUW}KX.CPGpTnn,m[M9w):)+/]Zx^OvnHSCBc!FLW?.+XWoRznG' );
define( 'NONCE_KEY', '(eO-KOyvk;s?pvsPdXkZjJ5t:TK5)$k<M]<f|Pg$(2FWa6@&yZD`~OX1I]<h8Fp*' );
define( 'AUTH_SALT',        'hfd,-1!/YYAH5$v~{Vh0NC {*>l25:-Kaj]3ds-&smpT^]af5rPDe&U;KJ4Uaej(' );
define( 'SECURE_AUTH_SALT', 'Z#6ESDR?2LFKt{E@{]{9u *[KV)x d f=&XKQ6yYa0GdX;MC6=Q!S+1-uY%GG fI' );
define( 'LOGGED_IN_SALT',   '+S27ZVZ6a_`X$|GO1?1FR41C*}WGEdR_$}(u?x3tvv7AbAwP&Lv-muV,Evx|,T#=' );
define( 'NONCE_SALT',       'Uf`w5=]vy7#g&D}4},Keh/9NsUYV&W6`c+V3+91Tu5Ywk*_d3WVG:iMsBl8N!3,z' );

/**#@-*/

/**
 * WordPress-adatbázis tábla előtag.
 *
 * Több blogot is telepíthetünk egy adatbázisba, ha valamennyinek egyedi
 * előtagot adunk. Csak számokat, betűket és alulvonásokat adhatunk meg.
 */
$table_prefix = 'wp_';

/**
 * Fejlesztőknek: WordPress hibakereső mód.
 *
 * Engedélyezzük ezt a megjegyzések megjelenítéséhez a fejlesztés során.
 * Erősen ajánlott, hogy a bővítmény- és sablonfejlesztők használják a WP_DEBUG
 * konstansot.
 */
define('WP_DEBUG', false);

/* Ennyi volt, kellemes blogolást! */

/** A WordPress könyvtár abszolút elérési útja. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Betöltjük a WordPress változókat és szükséges fájlokat. */
require_once(ABSPATH . 'wp-settings.php');
