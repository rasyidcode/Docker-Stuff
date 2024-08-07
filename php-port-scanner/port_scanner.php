<?php
ini_set('max_execution_time', 0);
ini_set('memory_limit', -1);

$host = 'google.com';
$ports = [21, 25, 80, 81, 110, 143, 443, 587, 2525, 3306];

foreach($ports as $port) {
    $connection = fsockopen($host, $port, $errno, $errstr, 2);
    if (is_resource($connection)) {
        print($host . ':' . $port . ' ' . '(' . getservbyport($port, 'tcp') . ') is open.' . "\n");
        fclose($connection);
    } else {
        print($host . ':' . $port . ' is not responding.' . "\n");
    }
}
