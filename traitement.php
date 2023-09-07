<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Récupération des données du formulaire
$pseudonyme = $_POST['pseudonyme'];
$prenomnom = $_POST['prenomnom'];
$mail = $_POST['mail'];
$motdepasse = $_POST['motdepasse'];
$datedenaissance = $_POST['datedenaissance'];
$motdepasse_crypte = password_hash($motdepasse, PASSWORD_BCRYPT);

// Connexion à la base de données
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "modele_conceptuel_upper_ppbdd";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connexion à la base de données échouée : " . $conn->connect_error);
}

// Requête SQL pour vérifier si le pseudonyme existe déjà
$sql_check_pseudonyme = "SELECT pseudonyme FROM Adherent WHERE pseudonyme = ?";
$stmt_check_pseudonyme = $conn->prepare($sql_check_pseudonyme);

if (!$stmt_check_pseudonyme) {
    // Gestion de l'erreur de préparation de la requête
    header("Location: enregistrementechoue.php"); // Rediriger en cas d'erreur
    exit();
}

$stmt_check_pseudonyme->bind_param("s", $pseudonyme);
$stmt_check_pseudonyme->execute();
$stmt_check_pseudonyme->store_result();

if ($stmt_check_pseudonyme->num_rows > 0) {
    // Le pseudonyme existe déjà, vous pouvez afficher un message d'erreur ou rediriger
    header("Location: enregistrementechouendu.php"); // Rediriger si le pseudonyme existe déjà
    exit();
}

// Fermez la première requête préparée
$stmt_check_pseudonyme->close();

// Le pseudonyme n'existe pas, vous pouvez procéder à l'insertion
$sql_insert = "INSERT INTO Adherent (pseudonyme, prenomnom, mail, motdepasse, datedenaissance)
                VALUES (?, ?, ?, ?, ?)";
$stmt_insert = $conn->prepare($sql_insert);

if (!$stmt_insert) {
    // Gestion de l'erreur de préparation de la requête d'insertion
    header("Location: enregistrementechoue.php"); // Rediriger en cas d'erreur
    exit();
}

$stmt_insert->bind_param("sssss", $pseudonyme, $prenomnom, $mail, $motdepasse_crypte, $datedenaissance);

if ($stmt_insert->execute()) {
    // Enregistrement réussi, effectuer la redirection vers la page de réussite
    header("Location: enregistrementreussi.php"); // Rediriger en cas de réussite
    exit();
} else {
    // Enregistrement échoué, effectuer la redirection vers la page d'échec
    header("Location: enregistrementechoue.php"); // Rediriger en cas d'échec
    exit();
}

// Fermez les requêtes préparées et la connexion à la base de données
$stmt_insert->close();
$conn->close();
?>