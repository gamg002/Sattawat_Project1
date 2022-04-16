<?php
include 'connected.php';


if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$date = $_GET['date'];

		$result = mysqli_query($link, "SELECT * FROM `order` WHERE date = '$date'");

		if ($result) {

			while($row=mysqli_fetch_assoc($result)){
			$output[]=$row;

			}	// while

			echo json_encode($output);

		} //if

	} else echo "Welcome ";	// if2
   
}	// if1


	mysqli_close($link);
?>