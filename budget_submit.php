<?php

$db_user = 'username';
$db_pass = 'password';

$db_host = 'localhost';
$db_name = 'databasename';
$db_engine = 'mysql';

$link = mysql_connect($db_host, $db_user, $db_pass);
if (!$link) {
    die('Could not connect: ' . mysql_error());
}
mysql_select_db($db_name) or die('Could not select the database');

$sql = <<< EOF
CREATE TABLE `submissions` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `name` varchar(55) default NULL,
  `email` varchar(55) default NULL,
  `ip_addy` varchar(15) NOT NULL,
  `expenditure_array` text NOT NULL,
  `revenue_array` text NOT NULL,
  `deficit_total` int(11) unsigned NOT NULL,
  `newsletters` text NOT NULL,
  `datestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Budget game submissions'
EOF;
mysql_query($sql);


$vars = array('name','email','ip_addy','datestamp','expenditure_array','revenue_array','deficit_total','newsletters');
$data = array();
foreach($vars as $k) $data[$k] = $_GET[$k];

$vals = array();
foreach($data as $k=>$v) {
	if(($k == 'name' or $k == 'email') and !$v) $vals[] = 'null';
	else                                        $vals[] = "'".addslashes($v)."'";
}

mysql_query("insert into submissions(".implode(',',$vars).") values (".implode(',',$vals).")");


