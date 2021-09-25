<?php
	include 'connected.php';
	
		 
				$user = $_POST['user'];
				$password = $_POST['password'];
				
			
		
	
	$sql = "SELECT * from username where user = '$user' and password = '$password' ";

	$result = mysqli_query($link,$sql);
	$count = mysqli_fetch_array($result);




		if ( $count >= 1 ) {
			

				if ( $count[4] == 'admin') {

				echo json_encode("admin");
				}
				else {

				echo json_encode("member");
				}

		}

		else  {
			echo json_encode("false");

		}
			
			
     


?>