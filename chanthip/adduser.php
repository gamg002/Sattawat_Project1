<?php
	
	
	if (isset($_POST['user'])){
		 
			$user = $_POST['user'];
			$password = $_POST['password'];
			$email = $_POST['email'];
		

	
	//$user = $_POST['user'];
	//$password = $_POST['password'];
	//$email = $_POST['email'];
	
	}

	include 'connected.php';

	$findexist = "SELECT * from username where user = '$user'";

		$resultsearch = mysqli_query($link,$findexist);
		if(mysqli_num_rows($resultsearch) > 0){
			while ($row=mysqli_fetch_array($resultsearch)) {
				echo json_encode('usertrue');
				mysqli_close($link);
			}
		}
		else{

			

			$sql = "INSERT INTO username(`id`, `user`, `password`, `email`, `state`) VALUES (Null,'$user','$password','$email','member')";

			if (mysqli_query($link,$sql)) {
				
				echo json_encode('true');
				mysqli_close($link);
			}
			else{

				echo json_encode('false');
				mysqli_close($link);
			}

		}
?>