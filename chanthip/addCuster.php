<?php
include 'connected.php';


if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
			
		$id = $_GET['id'];
		$traval = $_GET['traval'];		
		$name = $_GET['name'];
		$other = $_GET['other'];
		$Lat = $_GET['Lat'];
		$Lng = $_GET['Lng'];
		
		
							
		$sql = "INSERT INTO `costomer`(`id`, `traval`, `name`, `other`, `Lat`, `Lng`) VALUES (Null,'$traval','$name','$other','$Lat','$Lng')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}


	mysqli_close($link);
?>