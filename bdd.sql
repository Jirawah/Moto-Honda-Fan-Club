-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : jeu. 31 août 2023 à 07:53
-- Version du serveur : 8.0.34
-- Version de PHP : 8.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `modele_conceptuel_upper_ppbdd`
--

-- --------------------------------------------------------

--
-- Structure de la table `adherents`
--

CREATE TABLE `adherents` (
  `Espace_personnel_id` INT AUTO_INCREMENT PRIMARY KEY,
  `id_adherent` INT,
  `Mot_de_passe_adherent` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `adherent_admin`
--

CREATE TABLE `adherent_admin` (
  `ID_Adh` int NOT NULL,
  `id_admin` int DEFAULT NULL,
  `id_adherent` int DEFAULT NULL,
  `ID_Uti` int NOT NULL,
  `Pseudonyme` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Genre` varchar(5) NOT NULL,
  `Age` int NOT NULL,
  `Nom` char(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `administrateurs`
--

CREATE TABLE `administrateurs` (
  `id_adherent` int NOT NULL,
  `id_admin` int NOT NULL,
  `Mot_de_passe_admin` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

CREATE TABLE `article` (
  `id_adherent` int NOT NULL,
  `Date_article` date NOT NULL,
  `id_article` int NOT NULL,
  `Titre_article` varchar(100) NOT NULL,
  `Contenu_article` varchar(500) NOT NULL,
  `Pub_id_adherent` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `commentaire`
--

CREATE TABLE `commentaire` (
  `id_adherent` int NOT NULL,
  `Date_commentaire` date NOT NULL,
  `id_commentaire` int NOT NULL,
  `Contenu_commentaire` char(1) NOT NULL,
  `id_article` int NOT NULL,
  `Pos_id_adherent` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `espace_personnel`
--

CREATE TABLE `espace_personnel` (
  `id_espace_personnel` int NOT NULL,
  `id_adherent` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gere`
--

CREATE TABLE `gere` (
  `id_adherent` int NOT NULL,
  `id_admin` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `prenom`
--

CREATE TABLE `prenom` (
  `ID_Adh` int NOT NULL,
  `Prenom` char(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

CREATE TABLE `utilisateurs` (
  `ID_Uti` int NOT NULL,
  `id_visiteur` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `visiteurs`
--

CREATE TABLE `visiteurs` (
  `id_visiteur` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `adherents`
--
ALTER TABLE `adherents`
  ADD PRIMARY KEY (`id_adherent`),
  ADD UNIQUE KEY `SID_Adherents_ID` (`Espace_personnel_id`),
  ADD UNIQUE KEY `ID_Adherents_IND` (`id_adherent`),
  ADD UNIQUE KEY `SID_Adherents_IND` (`Espace_personnel_id`);

--
-- Index pour la table `adherent_admin`
--
ALTER TABLE `adherent_admin`
  ADD PRIMARY KEY (`ID_Adh`),
  ADD UNIQUE KEY `SID_Adher_Utili_ID` (`ID_Uti`),
  ADD UNIQUE KEY `ID_Adherent_Admin_IND` (`ID_Adh`),
  ADD UNIQUE KEY `SID_Adher_Utili_IND` (`ID_Uti`),
  ADD UNIQUE KEY `SID_Adher_Admin_ID` (`id_admin`),
  ADD UNIQUE KEY `SID_Adher_Adher_ID` (`id_adherent`),
  ADD UNIQUE KEY `SID_Adher_Admin_IND` (`id_admin`),
  ADD UNIQUE KEY `SID_Adher_Adher_IND` (`id_adherent`);

--
-- Index pour la table `administrateurs`
--
ALTER TABLE `administrateurs`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `SID_Administrateurs_ID` (`id_adherent`),
  ADD UNIQUE KEY `ID_Administrateurs_IND` (`id_admin`),
  ADD UNIQUE KEY `SID_Administrateurs_IND` (`id_adherent`);

--
-- Index pour la table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id_article`),
  ADD UNIQUE KEY `SID_Article_ID` (`id_adherent`),
  ADD UNIQUE KEY `IDX_Article_Pub_id_adherent` (`Pub_id_adherent`),
  ADD UNIQUE KEY `ID_Article_IND` (`id_article`),
  ADD UNIQUE KEY `SID_Article_IND` (`id_adherent`),
  ADD KEY `EQU_Artic_Adher_IND` (`Pub_id_adherent`);

--
-- Index pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD PRIMARY KEY (`id_commentaire`),
  ADD UNIQUE KEY `SID_Commentaire_ID` (`id_adherent`),
  ADD UNIQUE KEY `IDX_Commentaire_Pos_id_adherent` (`Pos_id_adherent`),
  ADD UNIQUE KEY `ID_Commentaire_IND` (`id_commentaire`),
  ADD UNIQUE KEY `SID_Commentaire_IND` (`id_adherent`),
  ADD KEY `REF_Comme_Artic_IND` (`id_article`),
  ADD KEY `EQU_Comme_Adher_IND` (`Pos_id_adherent`);

--
-- Index pour la table `espace_personnel`
--
ALTER TABLE `espace_personnel`
  ADD PRIMARY KEY (`id_espace_personnel`),
  ADD UNIQUE KEY `SID_Espac_Adher_ID` (`id_adherent`),
  ADD UNIQUE KEY `ID_Espace_personnel_IND` (`id_espace_personnel`),
  ADD UNIQUE KEY `SID_Espac_Adher_IND` (`id_adherent`);

--
-- Index pour la table `gere`
--
ALTER TABLE `gere`
  ADD PRIMARY KEY (`id_adherent`,`id_admin`),
  ADD UNIQUE KEY `IDX_Gere_id_admin` (`id_admin`),
  ADD UNIQUE KEY `ID_Gere_IND` (`id_adherent`,`id_admin`),
  ADD KEY `EQU_Gere_Admin_IND` (`id_admin`);

--
-- Index pour la table `prenom`
--
ALTER TABLE `prenom`
  ADD PRIMARY KEY (`ID_Adh`,`Prenom`),
  ADD UNIQUE KEY `ID_Prenom_IND` (`ID_Adh`,`Prenom`);

--
-- Index pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  ADD PRIMARY KEY (`ID_Uti`),
  ADD UNIQUE KEY `SID_Utili_Visit_ID` (`id_visiteur`),
  ADD UNIQUE KEY `ID_Utilisateurs_IND` (`ID_Uti`),
  ADD UNIQUE KEY `SID_Utili_Visit_IND` (`id_visiteur`);

--
-- Index pour la table `visiteurs`
--
ALTER TABLE `visiteurs`
  ADD PRIMARY KEY (`id_visiteur`),
  ADD UNIQUE KEY `ID_Visiteurs_IND` (`id_visiteur`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `adherents`
--
--
-- Contraintes pour la table `adherent_admin`
--
ALTER TABLE `adherent_admin`
  ADD CONSTRAINT `FK_Adherent_Admin_Prenom` FOREIGN KEY (`ID_Adh`) REFERENCES `prenom` (`ID_Adh`),
  ADD CONSTRAINT `SID_Adher_Adher_FK` FOREIGN KEY (`id_adherent`) REFERENCES `adherents` (`id_adherent`),
  ADD CONSTRAINT `SID_Adher_Admin_FK` FOREIGN KEY (`id_admin`) REFERENCES `administrateurs` (`id_admin`),
  ADD CONSTRAINT `SID_Adher_Utili_FK` FOREIGN KEY (`ID_Uti`) REFERENCES `utilisateurs` (`ID_Uti`);

--
-- Contraintes pour la table `administrateurs`
--
ALTER TABLE `administrateurs`
  ADD CONSTRAINT `FK_Administrateurs_Adherent_Admin` FOREIGN KEY (`id_admin`) REFERENCES `adherent_admin` (`id_admin`),
  ADD CONSTRAINT `FK_Administrateurs_Gere` FOREIGN KEY (`id_admin`) REFERENCES `gere` (`id_admin`);

--
-- Contraintes pour la table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `EQU_Artic_Adher_FK` FOREIGN KEY (`Pub_id_adherent`) REFERENCES `adherents` (`id_adherent`);

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `EQU_Comme_Adher_FK` FOREIGN KEY (`Pos_id_adherent`) REFERENCES `adherents` (`id_adherent`),
  ADD CONSTRAINT `REF_Comme_Artic_FK` FOREIGN KEY (`id_article`) REFERENCES `article` (`id_article`);

--
-- Contraintes pour la table `espace_personnel`
--
ALTER TABLE `espace_personnel`
  ADD CONSTRAINT `SID_Espac_Adher_FK` FOREIGN KEY (`id_adherent`) REFERENCES `adherents` (`id_adherent`);

--
-- Contraintes pour la table `gere`
--
ALTER TABLE `gere`
  ADD CONSTRAINT `EQU_Gere_Adher_FK` FOREIGN KEY (`id_adherent`) REFERENCES `adherents` (`id_adherent`),
  ADD CONSTRAINT `EQU_Gere_Admin_FK` FOREIGN KEY (`id_admin`) REFERENCES `administrateurs` (`id_admin`);

--
-- Contraintes pour la table `prenom`
--
ALTER TABLE `prenom`
  ADD CONSTRAINT `EQU_Preno_Adher_FK` FOREIGN KEY (`ID_Adh`) REFERENCES `adherent_admin` (`ID_Adh`);

--
-- Contraintes pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  ADD CONSTRAINT `SID_Utili_Visit_FK` FOREIGN KEY (`id_visiteur`) REFERENCES `visiteurs` (`id_visiteur`);

--
-- Contraintes pour la table `visiteurs`
--
ALTER TABLE `visiteurs`
  ADD CONSTRAINT `FK_Visiteurs_Utilisateurs` FOREIGN KEY (`id_visiteur`) REFERENCES `utilisateurs` (`id_visiteur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


_________________________________________________________________________________________________________________________________________________________________________________
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : jeu. 31 août 2023 à 10:18
-- Version du serveur : 8.0.34
-- Version de PHP : 8.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `modele_conceptuel_upper_ppbdd`
--

-- --------------------------------------------------------

--
-- Structure de la table `adherents`
--

CREATE TABLE `adherents` (
  `Espace_personnel_id` int NULL,
  `id_adherent`int NOT NULL,
  `Mot_de_passe_adherent` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `adherent_admin`
--

CREATE TABLE `adherent_admin` (
  `ID_Adh` int NOT NULL,
  `id_admin` int DEFAULT NULL,
  `id_adherent` int DEFAULT NULL,
  `ID_Uti` int NOT NULL,
  `Pseudonyme` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Genre` varchar(5) NOT NULL,
  `Age` int NOT NULL,
  `Nom` char(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `administrateurs`
--

CREATE TABLE `administrateurs` (
  `id_adherent` int NOT NULL,
  `id_admin` int NOT NULL,
  `Mot_de_passe_admin` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

CREATE TABLE `article` (
  `id_adherent` int NOT NULL,
  `Date_article` date NOT NULL,
  `id_article` int NOT NULL,
  `Titre_article` varchar(100) NOT NULL,
  `Contenu_article` varchar(500) NOT NULL,
  `Pub_id_adherent` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `commentaire`
--

CREATE TABLE `commentaire` (
  `id_adherent` int NOT NULL,
  `Date_commentaire` date NOT NULL,
  `id_commentaire` int NOT NULL,
  `Contenu_commentaire` char(1) NOT NULL,
  `id_article` int NOT NULL,
  `Pos_id_adherent` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `espace_personnel`
--

CREATE TABLE `espace_personnel` (
  `id_espace_personnel` int NOT NULL,
  `id_adherent` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gere`
--

CREATE TABLE `gere` (
  `id_adherent` int NOT NULL,
  `id_admin` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `prenom`
--

CREATE TABLE `prenom` (
  `ID_Adh` int NOT NULL,
  `Prenom` char(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

CREATE TABLE `utilisateurs` (
  `ID_Uti` int NOT NULL,
  `id_visiteur` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `visiteurs`
--

CREATE TABLE `visiteurs` (
  `id_visiteur` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `adherents`
--
ALTER TABLE `adherents`
  ADD PRIMARY KEY (`id_adherent`),
  ADD UNIQUE KEY `SID_Adherents_ID` (`Espace_personnel_id`),
  ADD UNIQUE KEY `ID_Adherents_IND` (`id_adherent`),
  ADD UNIQUE KEY `SID_Adherents_IND` (`Espace_personnel_id`);

--
-- Index pour la table `adherent_admin`
--
ALTER TABLE `adherent_admin`
  ADD PRIMARY KEY (`ID_Adh`),
  ADD UNIQUE KEY `SID_Adher_Utili_ID` (`ID_Uti`),
  ADD UNIQUE KEY `ID_Adherent_Admin_IND` (`ID_Adh`),
  ADD UNIQUE KEY `SID_Adher_Utili_IND` (`ID_Uti`),
  ADD UNIQUE KEY `SID_Adher_Admin_ID` (`id_admin`),
  ADD UNIQUE KEY `SID_Adher_Adher_ID` (`id_adherent`),
  ADD UNIQUE KEY `SID_Adher_Admin_IND` (`id_admin`),
  ADD UNIQUE KEY `SID_Adher_Adher_IND` (`id_adherent`);

--
-- Index pour la table `administrateurs`
--
ALTER TABLE `administrateurs`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `SID_Administrateurs_ID` (`id_adherent`),
  ADD UNIQUE KEY `ID_Administrateurs_IND` (`id_admin`),
  ADD UNIQUE KEY `SID_Administrateurs_IND` (`id_adherent`);

--
-- Index pour la table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id_article`),
  ADD UNIQUE KEY `SID_Article_ID` (`id_adherent`),
  ADD UNIQUE KEY `IDX_Article_Pub_id_adherent` (`Pub_id_adherent`),
  ADD UNIQUE KEY `ID_Article_IND` (`id_article`),
  ADD UNIQUE KEY `SID_Article_IND` (`id_adherent`),
  ADD KEY `EQU_Artic_Adher_IND` (`Pub_id_adherent`);

--
-- Index pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD PRIMARY KEY (`id_commentaire`),
  ADD UNIQUE KEY `SID_Commentaire_ID` (`id_adherent`),
  ADD UNIQUE KEY `IDX_Commentaire_Pos_id_adherent` (`Pos_id_adherent`),
  ADD UNIQUE KEY `ID_Commentaire_IND` (`id_commentaire`),
  ADD UNIQUE KEY `SID_Commentaire_IND` (`id_adherent`),
  ADD KEY `REF_Comme_Artic_IND` (`id_article`),
  ADD KEY `EQU_Comme_Adher_IND` (`Pos_id_adherent`);

--
-- Index pour la table `espace_personnel`
--
ALTER TABLE `espace_personnel`
  ADD PRIMARY KEY (`id_espace_personnel`),
  ADD UNIQUE KEY `SID_Espac_Adher_ID` (`id_adherent`),
  ADD UNIQUE KEY `ID_Espace_personnel_IND` (`id_espace_personnel`),
  ADD UNIQUE KEY `SID_Espac_Adher_IND` (`id_adherent`);

--
-- Index pour la table `gere`
--
ALTER TABLE `gere`
  ADD PRIMARY KEY (`id_adherent`,`id_admin`),
  ADD UNIQUE KEY `IDX_Gere_id_admin` (`id_admin`),
  ADD UNIQUE KEY `ID_Gere_IND` (`id_adherent`,`id_admin`),
  ADD KEY `EQU_Gere_Admin_IND` (`id_admin`);

--
-- Index pour la table `prenom`
--
ALTER TABLE `prenom`
  ADD PRIMARY KEY (`ID_Adh`,`Prenom`),
  ADD UNIQUE KEY `ID_Prenom_IND` (`ID_Adh`,`Prenom`);

--
-- Index pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  ADD PRIMARY KEY (`ID_Uti`),
  ADD UNIQUE KEY `SID_Utili_Visit_ID` (`id_visiteur`),
  ADD UNIQUE KEY `ID_Utilisateurs_IND` (`ID_Uti`),
  ADD UNIQUE KEY `SID_Utili_Visit_IND` (`id_visiteur`);

--
-- Index pour la table `visiteurs`
--
ALTER TABLE `visiteurs`
  ADD PRIMARY KEY (`id_visiteur`),
  ADD UNIQUE KEY `ID_Visiteurs_IND` (`id_visiteur`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `adherents`
--
ALTER TABLE `adherents`
  MODIFY `id_adherent` int NOT NULL AUTO_INCREMENT;


--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `adherents`
--


--
-- Contraintes pour la table `adherent_admin`
--
ALTER TABLE `adherent_admin`
  ADD CONSTRAINT `FK_Adherent_Admin_Prenom` FOREIGN KEY (`ID_Adh`) REFERENCES `prenom` (`ID_Adh`),
  ADD CONSTRAINT `SID_Adher_Adher_FK` FOREIGN KEY (`id_adherent`) REFERENCES `adherents` (`id_adherent`),
  ADD CONSTRAINT `SID_Adher_Admin_FK` FOREIGN KEY (`id_admin`) REFERENCES `administrateurs` (`id_admin`),
  ADD CONSTRAINT `SID_Adher_Utili_FK` FOREIGN KEY (`ID_Uti`) REFERENCES `utilisateurs` (`ID_Uti`);

--
-- Contraintes pour la table `administrateurs`
--
ALTER TABLE `administrateurs`
  ADD CONSTRAINT `FK_Administrateurs_Adherent_Admin` FOREIGN KEY (`id_admin`) REFERENCES `adherent_admin` (`id_admin`),
  ADD CONSTRAINT `FK_Administrateurs_Gere` FOREIGN KEY (`id_admin`) REFERENCES `gere` (`id_admin`);

--
-- Contraintes pour la table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `EQU_Artic_Adher_FK` FOREIGN KEY (`Pub_id_adherent`) REFERENCES `adherents` (`id_adherent`);

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `EQU_Comme_Adher_FK` FOREIGN KEY (`Pos_id_adherent`) REFERENCES `adherents` (`id_adherent`),
  ADD CONSTRAINT `REF_Comme_Artic_FK` FOREIGN KEY (`id_article`) REFERENCES `article` (`id_article`);

--
-- Contraintes pour la table `espace_personnel`
--
ALTER TABLE `espace_personnel`
  ADD CONSTRAINT `SID_Espac_Adher_FK` FOREIGN KEY (`id_adherent`) REFERENCES `adherents` (`id_adherent`);

--
-- Contraintes pour la table `gere`
--
ALTER TABLE `gere`
  ADD CONSTRAINT `EQU_Gere_Adher_FK` FOREIGN KEY (`id_adherent`) REFERENCES `adherents` (`id_adherent`),
  ADD CONSTRAINT `EQU_Gere_Admin_FK` FOREIGN KEY (`id_admin`) REFERENCES `administrateurs` (`id_admin`);

--
-- Contraintes pour la table `prenom`
--
ALTER TABLE `prenom`
  ADD CONSTRAINT `EQU_Preno_Adher_FK` FOREIGN KEY (`ID_Adh`) REFERENCES `adherent_admin` (`ID_Adh`);

--
-- Contraintes pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  ADD CONSTRAINT `SID_Utili_Visit_FK` FOREIGN KEY (`id_visiteur`) REFERENCES `visiteurs` (`id_visiteur`);

--
-- Contraintes pour la table `visiteurs`
--
ALTER TABLE `visiteurs`
  ADD CONSTRAINT `FK_Visiteurs_Utilisateurs` FOREIGN KEY (`id_visiteur`) REFERENCES `utilisateurs` (`id_visiteur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;











-- Création de la table "Adherent"
CREATE TABLE Adherent (
    idAdherent INT AUTO_INCREMENT PRIMARY KEY,
    pseudonyme VARCHAR(255) NOT NULL UNIQUE,
    prenomnom VARCHAR(255) NOT NULL,
    mail VARCHAR(255) NOT NULL,
    motdepasse VARCHAR(255) NOT NULL,
    datedenaissance DATE NOT NULL
) AUTO_INCREMENT = 1;

-- Création de la table "Administrateur"
CREATE TABLE Administrateur (
    idAdministrateur INT AUTO_INCREMENT PRIMARY KEY,
    pseudonyme VARCHAR(255) NOT NULL UNIQUE,
    prenomnom VARCHAR(255) NOT NULL,
    mail VARCHAR(255) NOT NULL,
    motdepasse VARCHAR(255) NOT NULL,
    datedenaissance DATE NOT NULL
);

-- Table pour gérer les articles du forum
CREATE TABLE ArticleForum (
    idArticle INT AUTO_INCREMENT PRIMARY KEY,
    idAdherent INT,
    titre VARCHAR(255) NOT NULL,
    contenu TEXT NOT NULL,
    datedepublication DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idAdherent) REFERENCES Adherent(idAdherent)
);

-- Table pour gérer les commentaires des articles du forum
CREATE TABLE Commentaire (
    idCommentaire INT AUTO_INCREMENT PRIMARY KEY,
    idArticle INT,
    idAdherent INT,
    contenu TEXT NOT NULL,
    datedecommentaire DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idArticle) REFERENCES ArticleForum(idArticle),
    FOREIGN KEY (idAdherent) REFERENCES Adherent(idAdherent)
);