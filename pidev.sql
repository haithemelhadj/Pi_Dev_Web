-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 26, 2025 at 01:44 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pidev`
--

-- --------------------------------------------------------

--
-- Table structure for table `article_boutique`
--

CREATE TABLE `article_boutique` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `type` enum('article','ticket') DEFAULT NULL,
  `prix` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `calendrier`
--

CREATE TABLE `calendrier` (
  `id` int(11) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `type` enum('evenement','tache') DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `evenement_id` int(11) DEFAULT NULL,
  `tache_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contrat`
--

CREATE TABLE `contrat` (
  `contrat_id` int(11) NOT NULL,
  `service_id` int(11) DEFAULT NULL,
  `offre_id` int(11) DEFAULT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date DEFAULT NULL,
  `description` longtext NOT NULL,
  `statut` enum('brouillon','actif','termine','resilie','dispute') NOT NULL DEFAULT 'brouillon',
  `echeancier_paiement` longtext NOT NULL,
  `cree_le` timestamp NOT NULL DEFAULT current_timestamp(),
  `mis_a_jour_le` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `equipe`
--

CREATE TABLE `equipe` (
  `id` int(11) NOT NULL,
  `evenement_id` int(11) DEFAULT NULL,
  `nom` varchar(255) NOT NULL,
  `chef_equipe_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `evenement`
--

CREATE TABLE `evenement` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `lieu` varchar(255) DEFAULT NULL,
  `id_localisation` int(11) DEFAULT NULL,
  `cree_par` int(11) DEFAULT NULL,
  `is_added` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `localisation`
--

CREATE TABLE `localisation` (
  `id` int(11) NOT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `ville` varchar(100) DEFAULT NULL,
  `pays` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `membre_equipe`
--

CREATE TABLE `membre_equipe` (
  `id` int(11) NOT NULL,
  `equipe_id` int(11) DEFAULT NULL,
  `utilisateur_id` int(11) DEFAULT NULL,
  `role` enum('chef','membre') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `offre`
--

CREATE TABLE `offre` (
  `offre_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `budget` decimal(12,2) UNSIGNED NOT NULL,
  `type_contrat` enum('forfait','horaire','abonnement') NOT NULL,
  `statut` enum('ouvert','ferme','en_cours','expire') NOT NULL DEFAULT 'ouvert',
  `cree_le` timestamp NOT NULL DEFAULT current_timestamp(),
  `expire_le` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panier`
--

CREATE TABLE `panier` (
  `id` int(11) NOT NULL,
  `utilisateur_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `quantite` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `participant_evenement`
--

CREATE TABLE `participant_evenement` (
  `id` int(11) NOT NULL,
  `evenement_id` int(11) DEFAULT NULL,
  `utilisateur_id` int(11) DEFAULT NULL,
  `statut` enum('en_attente','confirme','annule') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id_question` int(11) NOT NULL,
  `numero_question` int(11) NOT NULL,
  `question` text NOT NULL,
  `reponse_1` text NOT NULL,
  `reponse_2` text NOT NULL,
  `reponse_3` text NOT NULL,
  `reponse_4` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reponse`
--

CREATE TABLE `reponse` (
  `id_reponse` int(11) NOT NULL,
  `date_reponse` varchar(20) NOT NULL,
  `description_reponse` varchar(200) NOT NULL,
  `id_reclamation` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reponses`
--

CREATE TABLE `reponses` (
  `id` int(11) NOT NULL,
  `utilisateur_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `reponse` varchar(11) NOT NULL,
  `reponse_correcte` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `service_id` int(11) NOT NULL,
  `freelance_id` int(11) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `expertise` varchar(50) NOT NULL,
  `duree_jours` smallint(5) UNSIGNED NOT NULL,
  `prix` decimal(10,2) UNSIGNED NOT NULL,
  `mode_paiement` enum('horaire','forfait','milestone') NOT NULL,
  `cree_le` timestamp NOT NULL DEFAULT current_timestamp(),
  `mis_a_jour_le` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tache`
--

CREATE TABLE `tache` (
  `id` int(11) NOT NULL,
  `equipe_id` int(11) DEFAULT NULL,
  `titre` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `id_assignateur` int(11) DEFAULT NULL,
  `id_responsable` int(11) DEFAULT NULL,
  `statut` enum('en_attente','en_cours','termine') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` enum('utilisateur','admin','organisateur') NOT NULL DEFAULT 'utilisateur',
  `bio` text DEFAULT NULL,
  `photo_profil` varchar(255) DEFAULT NULL,
  `xp` int(11) DEFAULT 0,
  `niveau` int(10) UNSIGNED DEFAULT NULL,
  `xp_requis` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `nom`, `email`, `mot_de_passe`, `role`, `bio`, `photo_profil`, `xp`, `niveau`, `xp_requis`) VALUES
(1, 'unflappyadmin', 'unflappyadmin@duck.com', 'unflappyadmin', 'admin', 'the admin', NULL, 0, NULL, NULL),
(2, 'John Doe', 'john.doe@example.com', 'password123', 'utilisateur', 'Updated bio.', 'profile.jpg', 100, 1, 200),
(3, 'yass2', 'yass@gmail.com', 'yass', 'utilisateur', '', '', 0, NULL, 100),
(4, 'ala', 'aloulou@gmail.com', 'ala', 'utilisateur', '', '', 0, NULL, 100),
(5, 'sadok', 'sadak@5obza.tn', '5obza', 'utilisateur', '', '', 0, NULL, 100),
(6, 'sadak', 'sadak@5obza.com', '5obza', 'utilisateur', '', '', 0, NULL, 100),
(7, 'seif', 'roku@gmail.com', 'seif2', 'utilisateur', '', '', 0, NULL, 100),
(9, 'haithem', 'haithem@com.com', 'haithem', 'utilisateur', '', '', 0, NULL, 100),
(11, 'nahdi', 'yassNah@gmail.com', '123', 'utilisateur', '', '', 0, NULL, 100);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `article_boutique`
--
ALTER TABLE `article_boutique`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `calendrier`
--
ALTER TABLE `calendrier`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evenement_id` (`evenement_id`),
  ADD KEY `tache_id` (`tache_id`);

--
-- Indexes for table `contrat`
--
ALTER TABLE `contrat`
  ADD PRIMARY KEY (`contrat_id`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `offre_id` (`offre_id`);

--
-- Indexes for table `equipe`
--
ALTER TABLE `equipe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evenement_id` (`evenement_id`),
  ADD KEY `chef_equipe_id` (`chef_equipe_id`);

--
-- Indexes for table `evenement`
--
ALTER TABLE `evenement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_localisation` (`id_localisation`),
  ADD KEY `cree_par` (`cree_par`);

--
-- Indexes for table `localisation`
--
ALTER TABLE `localisation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `membre_equipe`
--
ALTER TABLE `membre_equipe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `equipe_id` (`equipe_id`),
  ADD KEY `utilisateur_id` (`utilisateur_id`);

--
-- Indexes for table `offre`
--
ALTER TABLE `offre`
  ADD PRIMARY KEY (`offre_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `panier`
--
ALTER TABLE `panier`
  ADD PRIMARY KEY (`id`),
  ADD KEY `utilisateur_id` (`utilisateur_id`),
  ADD KEY `article_id` (`article_id`);

--
-- Indexes for table `participant_evenement`
--
ALTER TABLE `participant_evenement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evenement_id` (`evenement_id`),
  ADD KEY `utilisateur_id` (`utilisateur_id`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`service_id`),
  ADD KEY `freelance_id` (`freelance_id`);

--
-- Indexes for table `tache`
--
ALTER TABLE `tache`
  ADD PRIMARY KEY (`id`),
  ADD KEY `equipe_id` (`equipe_id`),
  ADD KEY `id_assignateur` (`id_assignateur`),
  ADD KEY `id_responsable` (`id_responsable`);

--
-- Indexes for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `article_boutique`
--
ALTER TABLE `article_boutique`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `calendrier`
--
ALTER TABLE `calendrier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contrat`
--
ALTER TABLE `contrat`
  MODIFY `contrat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `equipe`
--
ALTER TABLE `equipe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `evenement`
--
ALTER TABLE `evenement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `localisation`
--
ALTER TABLE `localisation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `membre_equipe`
--
ALTER TABLE `membre_equipe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `offre`
--
ALTER TABLE `offre`
  MODIFY `offre_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panier`
--
ALTER TABLE `panier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `participant_evenement`
--
ALTER TABLE `participant_evenement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tache`
--
ALTER TABLE `tache`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `calendrier`
--
ALTER TABLE `calendrier`
  ADD CONSTRAINT `calendrier_ibfk_1` FOREIGN KEY (`evenement_id`) REFERENCES `evenement` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `calendrier_ibfk_2` FOREIGN KEY (`tache_id`) REFERENCES `tache` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `contrat`
--
ALTER TABLE `contrat`
  ADD CONSTRAINT `contrat_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `service` (`service_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `contrat_ibfk_2` FOREIGN KEY (`offre_id`) REFERENCES `offre` (`offre_id`) ON DELETE SET NULL;

--
-- Constraints for table `equipe`
--
ALTER TABLE `equipe`
  ADD CONSTRAINT `equipe_ibfk_1` FOREIGN KEY (`evenement_id`) REFERENCES `evenement` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `equipe_ibfk_2` FOREIGN KEY (`chef_equipe_id`) REFERENCES `utilisateur` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `evenement`
--
ALTER TABLE `evenement`
  ADD CONSTRAINT `evenement_ibfk_1` FOREIGN KEY (`id_localisation`) REFERENCES `localisation` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `evenement_ibfk_2` FOREIGN KEY (`cree_par`) REFERENCES `utilisateur` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `membre_equipe`
--
ALTER TABLE `membre_equipe`
  ADD CONSTRAINT `membre_equipe_ibfk_1` FOREIGN KEY (`equipe_id`) REFERENCES `equipe` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `membre_equipe_ibfk_2` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `offre`
--
ALTER TABLE `offre`
  ADD CONSTRAINT `offre_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `panier`
--
ALTER TABLE `panier`
  ADD CONSTRAINT `panier_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `panier_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `article_boutique` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `participant_evenement`
--
ALTER TABLE `participant_evenement`
  ADD CONSTRAINT `participant_evenement_ibfk_1` FOREIGN KEY (`evenement_id`) REFERENCES `evenement` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `participant_evenement_ibfk_2` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `service`
--
ALTER TABLE `service`
  ADD CONSTRAINT `service_ibfk_1` FOREIGN KEY (`freelance_id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tache`
--
ALTER TABLE `tache`
  ADD CONSTRAINT `tache_ibfk_1` FOREIGN KEY (`equipe_id`) REFERENCES `equipe` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tache_ibfk_2` FOREIGN KEY (`id_assignateur`) REFERENCES `utilisateur` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tache_ibfk_3` FOREIGN KEY (`id_responsable`) REFERENCES `utilisateur` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
