-- Étape 1 : Créer la base de données
DROP DATABASE IF EXISTS GestionScolaire;
CREATE DATABASE GestionScolaire;
GO

USE GestionScolaire;
GO

-- Étape 2 : Créer les tables

-- Table des Étudiants
CREATE TABLE Etudiants (
    IDEtudiant INT IDENTITY(1,1) PRIMARY KEY,
    Prenom NVARCHAR(50) NOT NULL,
    Nom NVARCHAR(50) NOT NULL,
    DateNaissance DATE NOT NULL,
    Classe NVARCHAR(20) NOT NULL
);

-- Table des Enseignants
CREATE TABLE Enseignants (
    IDEnseignant INT IDENTITY(1,1) PRIMARY KEY,
    Prenom NVARCHAR(50) NOT NULL,
    Nom NVARCHAR(50) NOT NULL,
    Matiere NVARCHAR(50) NOT NULL
);

-- Table des Présences
CREATE TABLE Presences (
    IDPresence INT IDENTITY(1,1) PRIMARY KEY,
    IDEtudiant INT FOREIGN KEY REFERENCES Etudiants(IDEtudiant) ON DELETE CASCADE,
    DatePresence DATE NOT NULL,
    Statut NVARCHAR(20) CHECK (Statut IN ('Présent', 'Absent', 'Retard')) NOT NULL
);

-- Table des Notes
CREATE TABLE Notes (
    IDNote INT IDENTITY(1,1) PRIMARY KEY,
    IDEtudiant INT FOREIGN KEY REFERENCES Etudiants(IDEtudiant) ON DELETE CASCADE,
    IDEnseignant INT FOREIGN KEY REFERENCES Enseignants(IDEnseignant) ON DELETE CASCADE,
    Matiere NVARCHAR(50) NOT NULL,
    Note DECIMAL(5,2) CHECK (Note BETWEEN 0 AND 20) NOT NULL,
    DateEvaluation DATE NOT NULL
);

-- Étape 3 : Insérer des données d'exemple

-- Insérer des Étudiants
INSERT INTO Etudiants (Prenom, Nom, DateNaissance, Classe) VALUES
('Alice', 'Dubois', '2008-05-14', '6ème A'),
('Pierre', 'Martin', '2007-09-21', '5ème B'),
('Lucie', 'Lemoine', '2006-11-10', '4ème C'),
('Jean', 'Dupont', '2005-12-12', '3ème A'),
('Sophie', 'Durand', '2008-01-23', '6ème A');

-- Insérer des Enseignants
INSERT INTO Enseignants (Prenom, Nom, Matiere) VALUES
('Marie', 'Lafont', 'Mathématiques'),
('Paul', 'Bertrand', 'Français'),
('Camille', 'Rousseau', 'Histoire'),
('Nicolas', 'Gérard', 'Physique'),
('Isabelle', 'Morel', 'Anglais');

-- Insérer des Présences
INSERT INTO Presences (IDEtudiant, DatePresence, Statut) VALUES
(1, '2024-06-01', 'Présent'),
(2, '2024-06-01', 'Absent'),
(3, '2024-06-01', 'Retard'),
(4, '2024-06-01', 'Présent'),
(5, '2024-06-01', 'Présent');

-- Insérer des Notes
INSERT INTO Notes (IDEtudiant, IDEnseignant, Matiere, Note, DateEvaluation) VALUES
(1, 1, 'Mathématiques', 18.5, '2024-06-05'),
(2, 2, 'Français', 14.0, '2024-06-05'),
(3, 3, 'Histoire', 12.5, '2024-06-05'),
(4, 4, 'Physique', 15.0, '2024-06-05'),
(5, 5, 'Anglais', 17.0, '2024-06-05');

-- Étape 4 : Requêtes utiles

-- 1. Afficher tous les étudiants
SELECT * FROM Etudiants;

-- 2. Afficher les présences avec le statut des étudiants
SELECT E.Prenom + ' ' + E.Nom AS Etudiant, P.DatePresence, P.Statut
FROM Presences P
JOIN Etudiants E ON P.IDEtudiant = E.IDEtudiant;

-- 3. Afficher les notes des étudiants avec les enseignants
SELECT 
    E.Prenom + ' ' + E.Nom AS Etudiant, 
    N.Matiere, 
    N.Note, 
    N.DateEvaluation, 
    ENS.Prenom + ' ' + ENS.Nom AS Enseignant
FROM Notes N
JOIN Etudiants E ON N.IDEtudiant = E.IDEtudiant
JOIN Enseignants ENS ON N.IDEnseignant = ENS.IDEnseignant;

-- 4. Calculer la moyenne des notes pour chaque étudiant
SELECT 
    E.Prenom + ' ' + E.Nom AS Etudiant, 
    AVG(N.Note) AS Moyenne
FROM Notes N
JOIN Etudiants E ON N.IDEtudiant = E.IDEtudiant
GROUP BY E.Prenom, E.Nom;

-- 5. Afficher les étudiants absents ou en retard un jour donné
SELECT E.Prenom + ' ' + E.Nom AS Etudiant, P.Statut, P.DatePresence
FROM Presences P
JOIN Etudiants E ON P.IDEtudiant = E.IDEtudiant
WHERE P.Statut IN ('Absent', 'Retard');

-- 6. Afficher les étudiants ayant une note inférieure à 10
SELECT 
    E.Prenom + ' ' + E.Nom AS Etudiant, 
    N.Matiere, 
    N.Note
FROM Notes N
JOIN Etudiants E ON N.IDEtudiant = E.IDEtudiant
WHERE N.Note < 10;
