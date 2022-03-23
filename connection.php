<?php

$dbhost = "localhost";
$dbuser = "root";
$dbpass = "OriginalFake1";
$dbname = "ccschema";

if(!$con = mysqli_connect($dbhost,$dbuser,$dbpass,$dbname))
{

    die("failed to connect!");

}


