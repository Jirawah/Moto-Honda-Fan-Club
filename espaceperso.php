<?php
require 'util.php';
init_php_session();

// Vérifiez si l'utilisateur est connecté, sinon redirigez-le vers la page de connexion
if (!is_logged()) {
    header("Location: connexion.php");
    exit();
}

// Récupérez l'ID de l'adhérent depuis la session
$idAdherent = $_SESSION['idAdherent'];

// Connexion à la base de données
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "modele_conceptuel_upper_ppbdd";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connexion à la base de données échouée : " . $conn->connect_error);
}

$sql = "SELECT * FROM Adherent WHERE idAdherent = ?";
$stmt = $conn->prepare($sql);

if ($stmt) {
    // Liez les paramètres à la requête
    $stmt->bind_param("i", $idAdherent);

    // Exécutez la requête
    $stmt->execute();

    // Obtenez le résultat
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $pseudonyme = $row['pseudonyme'];
        $prenomnom = $row['prenomnom'];
        $mail = $row['mail'];
        $datedenaissance = $row['datedenaissance'];
    } else {
        header("Location: connexion.php");
        exit();
    }

    // Fermez la déclaration
    $stmt->close();
} else {
    echo "Erreur lors de la préparation de la requête : " . $conn->error;
}
/*$sql = "SELECT * FROM Adherent WHERE idAdherent = ?";
$result = $conn->query($sql);


if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $pseudonyme = $row['pseudonyme'];
    $prenomnom = $row['prenomnom'];
    $mail = $row['mail'];
    $datedenaissance = $row['datedenaissance'];
} else {
    echo "Erreur : L'utilisateur n'existe pas.";
    exit();
}*/

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Espace Personnel</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

    <header>
        <navc class="backtoportfolio-btn">
            <button onclick="window.location.href = 'http://13.formation.mode83.net/antoine.pouzeratte/portfolio/';" class="btp-btn">
                <img src="img/btn_retour-pf.png" alt="Retour au portfolio" class="icon">
                Retour au portfolio
            </button>
        </navc>
        <nav class="navbar">
            <div class="nav-links">
                <ul>
                    <li><a href="index.php" class="tittle">Accueil</a></li>
                    <li><a href="espaceperso.php" class="tittle">Espace personnel</a></li>
                    <li><a href="forum.php" class="tittle">forum</a></li>
                    <li><a href="motos_presentees.php" class="tittle">Motos présentées</a></li>
                    <li><a href="enregistrement.php" class="tittle">S'enregistrer</a></li>
                </ul>
            </div>
        </nav>
        <div class="btn-container">
            <button class="btn-connexion">
                <img src="img/btn_connexion.png" alt="connexion button" class="btn-icon"><a href="connexion.php">
                    Connexion</a>
            </button>
        </div>
    </header>

    <main>
        <h1>Bienvenue dans votre espace personnel !</h1>
        <h2>Vos informations personnelles :</h2>
        <table>
            <tr>
                <th></th>
                <th>Vos informations</th>
                <th>Modifier</th>
            </tr>
            <tr>
                <td>Pseudonyme</td>
                <td><?= $pseudonyme ?></td>
                <td><a href="modifier.php?champ=pseudonyme">Modifier</a></td>
            </tr>
            <tr>
                <td>Prénom et Nom</td>
                <td><?= $prenomnom ?></td>
                <td><a href="modifier.php?champ=prenomnom">Modifier</a></td>
            </tr>
            <tr>
                <td>Adresse mail</td>
                <td><?= $mail ?></td>
                <td><a href="modifier.php?champ=mail">Modifier</a></td>
            </tr>
            <tr>
                <td>Date de naissance</td>
                <td><?= $datedenaissance ?></td>
                <td><a href="modifier.php?champ=datedenaissance">Modifier</a></td>
            </tr>
        </table>

        <p>Si vous souhaitez supprimer votre compte, cliquez <a href="supprimer.php">ici</a>.</p>
    </main>

    <footer>
    <div class="img-footer">
      <img src="img/img_footer.png" alt="image footer" class="img-footer-cla">
    </div>
    <nav class="footer">
      <div class="footer-links">
        <ul>
          <li><a href="#" class="tittle_footer" id="con">Contact</a></li>
          <li><a href="#" class="tittle_footer">Données personnelles</a></li>
          <li><a href="#" class="tittle_footer">Gestion des cookies</a></li>
          <li><a href="#" class="tittle_footer">Informations légales</a></li>
        </ul>
      </div>
    </nav>
    </footer>

</body>

</html>