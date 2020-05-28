<?php

		session_start();

		if(!isset($_SESSION['zalogowany'])) //to wkleic do kazdego skryptu, gdzie moze byc tylko zalogowany user
		{
			header('Location: index.php');
			exit(); //konczymy wykonywanie kodu
		}

		if (isset($_POST['submit']))
		{
			require_once "connect.php";

			$polaczenie=@new mysqli($host, $db_user, $db_password, $db_name);

			$napis = $polaczenie->real_escape_string($_POST['napis']);
			$f1 = $polaczenie->real_escape_string($_POST['f1']);
			$f2 = $polaczenie->real_escape_string($_POST['f2']);

			//////////// nic
			if($f1 == "" && $f2 == "")
			{
				$sql = @$polaczenie->query("SELECT tytul, imie, nazwisko FROM pozycje JOIN pozycje_autorzy ON pozycje.ISBN = pozycje_autorzy.ISBN JOIN autorzy ON autorzy.id=pozycje_autorzy.autor WHERE tytul LIKE '%$napis%' OR imie LIKE '%$napis%' OR nazwisko LIKE '%$napis%'");
			}
			//////////// autor
			if($f1 == "autor" && $f2 == "" && strlen($napis) == 0)
			{
				$sql = @$polaczenie->query("SELECT * FROM pozycje WHERE 1 = 0");
			}
			if($f1 == "autor" && $f2 == "" && strlen($napis) > 0)
			{
				$sql = @$polaczenie->query("SELECT tytul, imie, nazwisko FROM pozycje JOIN pozycje_autorzy ON pozycje.ISBN = pozycje_autorzy.ISBN JOIN autorzy ON autorzy.id=pozycje_autorzy.autor WHERE imie LIKE '%$napis%' or nazwisko LIKE '%$napis%'");
			}
			///////////// fantasy
			if($f1 == "" && $f2 == "fantasy" && strlen($napis) == 0)
			{
				$sql = @$polaczenie->query("SELECT tytul, imie, nazwisko, nazwa FROM pozycje JOIN pozycje_autorzy ON pozycje.ISBN = pozycje_autorzy.ISBN JOIN autorzy ON autorzy.id=pozycje_autorzy.autor JOIN pozycje_kategorie ON pozycje.ISBN = pozycje_kategorie.ISBN JOIN kategorie ON pozycje_kategorie.kategoria=kategorie.nazwa WHERE nazwa = 'fantasy'");
			}
			if($f1 == "" && $f2 == "fantasy" && strlen($napis) > 0)
			{
				$sql = @$polaczenie->query("SELECT tytul, imie, nazwisko, nazwa FROM pozycje JOIN pozycje_autorzy ON pozycje.ISBN = pozycje_autorzy.ISBN JOIN autorzy ON autorzy.id=pozycje_autorzy.autor JOIN pozycje_kategorie ON pozycje.ISBN = pozycje_kategorie.ISBN JOIN kategorie ON pozycje_kategorie.kategoria=kategorie.nazwa WHERE nazwa = 'fantasy' AND (tytul LIKE '%$napis%' OR imie LIKE '%$napis%' OR nazwisko LIKE '%$napis%')");
			}
			//////////// fantasy+autor
			if($f1 == "autor" && $f2 == "fantasy" && strlen($napis) == 0)
			{
				$sql=@$polaczenie->query("SELECT * FROM pozycje WHERE 1 = 0");
			}
			if($f1 == "autor" && $f2 == "fantasy" && strlen($napis) > 0)
			{
				$sql = @$polaczenie->query("SELECT tytul, imie, nazwisko, nazwa FROM pozycje JOIN pozycje_autorzy ON pozycje.ISBN = pozycje_autorzy.ISBN JOIN autorzy ON autorzy.id=pozycje_autorzy.autor JOIN pozycje_kategorie ON pozycje.ISBN = pozycje_kategorie.ISBN JOIN kategorie ON pozycje_kategorie.kategoria=kategorie.nazwa WHERE nazwa = 'fantasy' AND (imie LIKE '%$napis%' OR nazwisko LIKE '%$napis%')");
			}
			/////////////
			if($f1 == "dostepny" && $f2 == "" && strlen($napis) == 0)
			{
				$sql = @$polaczenie->query("SELECT tytul, imie, nazwisko FROM pozycje JOIN pozycje_autorzy ON pozycje.ISBN = pozycje_autorzy.ISBN JOIN autorzy ON autorzy.id=pozycje_autorzy.autor JOIN egzemplarze ON egzemplarze.pozycja_id=pozycje.ISBN JOIN statusy ON egzemplarze.statusy_id=statusy.id WHERE statusy.nazwa='dostępny' GROUP BY 1");
			}
			if($f1 == "dostepny" && $f2 == "" && strlen($napis) > 0)
			{
				$sql = @$polaczenie->query("SELECT tytul, imie, nazwisko FROM pozycje JOIN pozycje_autorzy ON pozycje.ISBN = pozycje_autorzy.ISBN JOIN autorzy ON autorzy.id=pozycje_autorzy.autor JOIN egzemplarze ON egzemplarze.pozycja_id=pozycje.ISBN JOIN statusy ON egzemplarze.statusy_id=statusy.id WHERE statusy.nazwa='dostępny' AND (tytul LIKE '%$napis%' OR imie LIKE '%$napis%' OR nazwisko LIKE '%$napis%') GROUP BY 1");
			}
			/////////////
			if ($sql->num_rows > 0)
			{
				while ($data = $sql->fetch_array())
					echo $data['imie'].' '.$data['nazwisko'].' "'.$data['tytul'] . '"<br>';
			}
			else
				echo "Brak wyszukiwań!";
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

<form method="post" action="wyszukiwanie.php">
			<input type="text" name="napis" placeholder="Wyszukaj...">
			<select name="f1">
				<option value="">Wybierz filtr</option>
				<option value="autor">Autor</option>
				<option value="dostepny">Dostępny</option>
			</select>
			<select name="f2">
				<option value="">Wybierz kategorie</option>
				<option value="fantasy">Fantasy</option>
			</select>
			<input type="submit" name="submit" value="Szukaj">
</form>

</body>
</html>
