<?php
require 'util.php';
session_start();
ini_set('display_errors', 1);
error_reporting(E_ALL);

if (isset($_POST['valid_connection'])) {
    if (
        isset($_POST['pseudonyme']) && !empty($_POST['pseudonyme']) &&
        isset($_POST['motdepasse']) && !empty($_POST['motdepasse'])
    ) {
        // Récupérez le nom d'utilisateur (Pseudonyme) et le mot de passe saisis dans le formulaire
        $pseudonyme = $_POST['pseudonyme'];
        $motdepasse = $_POST['motdepasse'];

        // Connexion à la base de données
        $servername = "localhost";
        $username = "root"; // Mettez votre nom d'utilisateur de la base de données ici
        $password = ""; // Mettez votre mot de passe de la base de données ici
        $dbname = "modele_conceptuel_upper_ppbdd";

        $conn = new mysqli($servername, $username, $password, $dbname);

        if ($conn->connect_error) {
            die("Connexion à la base de données échouée : " . $conn->connect_error);
        }

        // Requête SQL pour récupérer le mot de passe crypté associé à l'utilisateur (Pseudonyme)
        $sql = "SELECT motdepasse FROM Adherent WHERE pseudonyme = ?";

        // Utilisation d'une requête préparée pour éviter les injections SQL
        if ($stmt = $conn->prepare($sql)) {
            // Lie les paramètres à la requête
            $stmt->bind_param("s", $pseudonyme);

            // Exécute la requête
            if ($stmt->execute()) {
                $stmt->store_result(); // Ajoutez cette ligne pour libérer les résultats

                // Lie les résultats à des variables
                $stmt->bind_result($hashed_password);

                // Récupère le résultat
                if ($stmt->fetch()) {
                    // Vérifie si le mot de passe saisi correspond au mot de passe crypté dans la base de données
                    if (password_verify($motdepasse, $hashed_password)) {
                        // Mot de passe correct, connectez l'utilisateur
                        // Vous pouvez mettre en place la session ou rediriger vers la page d'accueil

                        // Récupérez l'ID de l'adhérent depuis la base de données
                        $stmt->close(); // Fermez la première déclaration ici

                        $sql = "SELECT idAdherent FROM Adherent WHERE pseudonyme = ?";
                        if ($stmt = $conn->prepare($sql)) {
                            // Lie les paramètres à la requête
                            $stmt->bind_param("s", $pseudonyme);

                            // Exécute la requête
                            if ($stmt->execute()) {
                                $stmt->bind_result($idAdherent);
                                if ($stmt->fetch()) {
                                    $_SESSION['idAdherent'] = $idAdherent;
                                    $_SESSION['authenticated'] = true; // Définissez une variable de session pour indiquer que l'utilisateur est connecté
                                    header("Location: espaceperso.php"); // Redirige vers la page d'accueil de l'utilisateur
                                    exit();
                                } else {
                                    // Gestion de l'erreur si l'ID de l'adhérent n'est pas trouvé
                                    echo "Erreur : L'utilisateur n'existe pas.";
                                }
                            } else {
                                echo "Erreur lors de l'exécution de la deuxième requête : " . $stmt->error;
                            }
                            $stmt->close();
                        } else {
                            echo "Erreur lors de la préparation de la deuxième requête : " . $conn->error;
                        }
                    } else {
                        // Mot de passe incorrect, affichez un message d'erreur
                        echo "Mot de passe incorrect. Veuillez réessayer.";
                        header("Location: mdpconfalse.php");
                    }
                } else {
                    // L'utilisateur n'existe pas, affichez un message d'erreur
                    echo "Identifiant incorrect. Veuillez réessayer.";
                    header("Location: idconfalse.php");
                }
            } else {
                echo "Erreur lors de l'exécution de la première requête : " . $stmt->error;
            }

            // Ferme la déclaration
            $stmt->close();
        } else {
            echo "Erreur lors de la préparation de la première requête : " . $conn->error;
        }

        // Ferme la connexion à la base de données
        $conn->close();
    }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
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
        <div class="sdl">
        <div class="conform">
        <div class="fotcon">
            <h1 class="fotcon2">Entrez vos informations de connexion</h1>
        </div>
            <form action="/connexion.php" method="post">
                <input type="text" class="div-form" name="pseudonyme" placeholder="Pseudonyme (Identifiant de connexion)...">
                <input type="password" class="div-form" name="motdepasse" placeholder="Mot de passe...">
                <input type="submit" class="div-form2" name="valid_connection" placeholder="connexion...">
            </form>
        </div>
        </div>
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
    <?php
    echo "Le code PHP fonctionne correctement.";
    ?>
</body>

</html>