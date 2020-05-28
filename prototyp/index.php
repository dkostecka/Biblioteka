<?php
		session_start();

		if((isset($_SESSION['zalogowany'])) && ($_SESSION['zalogowany']==true))
		{
			header('Location: panel.php');
			exit(); //opuszczamy plik, nie wykonujemy dalszej czesci kodu
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
	<h1>LOGOWANIE</h1>
	<form action="zaloguj.php" method="post">
		Login: <br/> <input type="text" name="login"/> <br/>
		Hasło: <br/> <input type="password" name="haslo"/> <br/>
		<input type="submit" value="Zaloguj się"/>
	</form>

<?php
		if(isset($_SESSION['blad']))
		{
			echo $_SESSION['blad'];
			unset($_SESSION['blad']);
		}
?>

</body>
</html>
