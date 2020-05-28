<?php

		session_start();

		if(!isset($_SESSION['zalogowany'])) //to wkleic do kazdego skryptu, gdzie moze byc tylko zalogowany user
		{
			header('Location: index.php');
			exit(); //konczymy wykonywanie kodu
		}
?>

<!DOCTYPE HTML>
<html lang='pl'>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1"/>
	<title>BIBLIOTEX</title>
</head>

<body>
<?php

	echo "<p>Witaj <b>".$_SESSION['imie'].'</b> [<a href="wyloguj.php">Wyloguj się</a>]</p>';
?>

<select  onchange="location = this.options[this.selectedIndex].value;">
<option value="MENU">MENU</option>}
<option value="panel.php">Strona główna</option>}
<option value="wyszukiwanie.php">Wyszukiwanie</option>
<option value="Aktualne wypożyczenia">Aktualne wypożyczenia</option>
</select>

</body>
</html>
