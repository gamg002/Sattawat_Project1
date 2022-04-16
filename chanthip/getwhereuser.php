<?php
include 'connected.php';


if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$user = $_GET['user'];

		$result = mysqli_query($link, "SELECT * FROM username WHERE user LIKE '%$user'");

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