<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Enregistrement</title>
  <link rel="stylesheet" href="style.css">

  <script>
    document.addEventListener("DOMContentLoaded", function() {
      const inputFields = document.querySelectorAll("input");

      inputFields.forEach(function(input) {
        const label = input.previousElementSibling;

        // Affiche le label au chargement de la page
        label.style.display = "block";

        input.addEventListener("focus", function() {
          // Cache le label quand l'utilisateur clique dans le champ
          label.style.display = "none";
        });

        input.addEventListener("blur", function() {
          // Affiche le label seulement si le champ est vide
          if (this.value === "") {
            label.style.display = "block";
          }
        });

        input.addEventListener("input", function() {
          // Cache le label pendant que l'utilisateur tape
          label.style.display = "none";
        });
      });

      // Sélectionne le bouton d'enregistrement
      const formBtn = document.getElementById("form-btn");

      // Ajoute un écouteur d'événement "click" au bouton d'enregistrement
      formBtn.addEventListener("click", function() {
        // Récupère les valeurs des champs de formulaire
        const pseudonyme = document.getElementById("pseudonyme").value;
        const prenomnom = document.getElementById("prenomnom").value;
        const mail = document.getElementById("mail").value;
        const motdepasse = document.getElementById("motdepasse").value;
        const datedenaissance = document.getElementById("datedenaissance").value;

        // Crée un objet FormData pour envoyer les données au script PHP
        const formData = new FormData();
        formData.append("pseudonyme", pseudonyme);
        formData.append("prenomnom", prenomnom);
        formData.append("mail", mail);
        formData.append("motdepasse", motdepasse);
        formData.append("datedenaissance", datedenaissance);

        // Envoie les données au script PHP via une requête XMLHttpRequest
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "traitement.php", true);
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
              // Traitement réussi
              console.log(xhr.responseText);
            } else {
              // Erreur lors du traitement
              console.error("Erreur lors du traitement : " + xhr.statusText);
            }
          }
        };
        xhr.send(formData);
      });
    });
  </script>
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
    <div>
      <img src="img/logo2.png" alt="logo2" id="logo2">
    </div>
    <div>
      <h1 id="form-tittle">Enregistrement</h1>
    </div>
    <!--Contact-form-->
    <div class="container" id="sli">
      <form action="traitement.php" method="POST">
        <div class="name-field">
          <div class="div-form">
            <label for="pseudonyme">Pseudonyme (identifiant de connexion)</label>
            <input type="text" id="pseudonyme" name="pseudonyme" required>
          </div>
          <div class="div-form">
            <label for="prenomnom">Prénom et Nom</label>
            <input type="text" id="prenomnom" name="prenomnom" required>
          </div>
          <div class="div-form">
            <label for="mail">Adresse mail</label>
            <input type="email" id="mail" name="mail" required>
          </div>
          <div class="div-form">
            <label for="motdepasse">Mot de passe</label>
            <input type="password" id="motdepasse" name="motdepasse" required>
          </div>
          <div class="div-form">
            <label for="confirmerlemotdepasse">Confirmer le mot de passe</label>
            <input type="password" id="confirmerlemotdepasse" name="confirmerlemotdepasse">
          </div>
          <div id="ddn">
            <label>Date de naissance</label><br>
            <input type="date" id="datedenaissance" name="datedenaissance">
          </div>
          <div>
            <button type="submit" id="form-btn">S'enregistrer</button>
          </div>
        </div>
      </form>
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

</body>

</html>