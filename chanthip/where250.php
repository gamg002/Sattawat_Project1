<?php

header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'root', '', "water");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}


	if (isset($_GET)) {
	     if ($_GET['isAdd'] == 'true') {
				
		     $date = $_GET['date'];
		     $fname = $_GET['fname'];
		     $work = $_GET['work'];
		     $type = $_GET['type'];
		     $cost = $_GET['cost'];
		     $unit = $_GET['unit'];
		     $sum = $_GET['sum'];
		     $lat = $_GET['lat'];
		     $lng = $_GET['lng'];
		

							
		 $sql = "INSERT INTO `chartorder`(`id`, `date`,  `fname`, `work2`, `type`, `cost`, `unit`, `sum`, `lng`, `lat`) VALUES (null, '$date', '$fname', '$work', '$type', '$cost', '$unit', '$sum', '$lng', '$lat')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome";
}


	mysqli_close($link);
?>