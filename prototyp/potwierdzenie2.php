<?php
	session_start();

	require_once "connect.php";

	$polaczenie=@new mysqli($host, $db_user, $db_password, $db_name);

	$rezerwacja=$_SESSION['niepotwierdzona'];

  $sql=@$polaczenie->query("UPDATE rezerwacje SET id_status=8 WHERE id=$rezerwacja");
	$sql2=@$polaczenie->query("SELECT id_egzemplarza FROM rezerwacje WHERE id=$rezerwacja");
	while($data=$sql2->fetch_assoc())
	{
		$egzemplarz=$data['id_egzemplarza'];
	}
	$sql3=@$polaczenie->query("UPDATE egzemplarze SET statusy_id=3 WHERE id=$egzemplarz");
	$_SESSION['ile']+=1;

	header('Location: aktualne_rezerwacje.php');
 ?>
