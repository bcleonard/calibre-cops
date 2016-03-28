<?php
    if (!isset($config))
        $config = array();
  
    /*
     * The directory containing calibre's metadata.db file, with sub-directories
     * containing all the formats.
     * BEWARE : it has to end with a /
     */
    /*
    $config['calibre_directory'] = './';
     */
    $config['calibre_directory'] = '/data/library/';
    
    /*
     * Catalog's title
     */
    $config['cops_title_default'] = "COPS";
    /*
     * Default timezone
     * Check following link for other timezones :
     * http://www.php.net/manual/en/timezones.php
     */
    $config['default_timezone'] = "America/New_York";
    /*
     * Update Epub metadata before download
     * 1 : Yes (enable)
     * 0 : No
     */
    $config['cops_update_epub-metadata'] = "1";
