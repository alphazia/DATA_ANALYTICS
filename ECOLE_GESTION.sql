-- �tape 1 : Cr�er la base de donn�es
DROP DATABASE IF EXISTS GestionScolaire;
CREATE DATABASE GestionScolaire;
GO

USE GestionScolaire;
GO

-- �tape 2 : Cr�er les tables

-- Table des �tudiants
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

-- Table des Pr�sences
CREATE TABLE Presences (
    IDPresence INT IDENTITY(1,1) PRIMARY KEY,
    IDEtudiant INT FOREIGN KEY REFERENCES Etudiants(IDEtudiant) ON DELETE CASCADE,
    DatePresence DATE NOT NULL,
    Statut NVARCHAR(20) CHECK (Statut IN ('Pr�sent', 'Absent', 'Retard')) NOT NULL
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

-- �tape 3 : Ins�rer des donn�es d'exemple

-- Ins�rer des �tudiants
INSERT INTO Etudiants (Prenom, Nom, DateNaissance, Classe) VALUES
('Alice', 'Dubois', '2008-05-14', '6�me A'),
('Pierre', 'Martin', '2007-09-21', '5�me B'),
('Lucie', 'Lemoine', '2006-11-10', '4�me C'),
('Jean', 'Dupont', '2005-12-12', '3�me A'),
('Sophie', 'Durand', '2008-01-23', '6�me A');

-- Ins�rer des Enseignants
INSERT INTO Enseignants (Prenom, Nom, Matiere) VALUES
('Marie', 'Lafont', 'Math�matiques'),
('Paul', 'Bertrand', 'Fran�ais'),
('Camille', 'Rousseau', 'Histoire'),
('Nicolas', 'G�rard', 'Physique'),
('Isabelle', 'Morel', 'Anglais');

-- Ins�rer des Pr�sences
INSERT INTO Presences (IDEtudiant, DatePresence, Statut) VALUES
(1, '2024-06-01', 'Pr�sent'),
(2, '2024-06-01', 'Absent'),
(3, '2024-06-01', 'Retard'),
(4, '2024-06-01', 'Pr�sent'),
(5, '2024-06-01', 'Pr�sent');

-- Ins�rer des Notes
INSERT INTO Notes (IDEtudiant, IDEnseignant, Matiere, Note, DateEvaluation) VALUES
(1, 1, 'Math�matiques', 18.5, '2024-06-05'),
(2, 2, 'Fran�ais', 14.0, '2024-06-05'),
(3, 3, 'Histoire', 12.5, '2024-06-05'),
(4, 4, 'Physique', 15.0, '2024-06-05'),
(5, 5, 'Anglais', 17.0, '2024-06-05');

-- �tape 4 : Requ�tes utiles

-- 1. Afficher tous les �tudiants
SELECT * FROM Etudiants;

-- 2. Afficher les pr�sences avec le statut des �tudiants
SELECT E.Prenom + ' ' + E.Nom AS Etudiant, P.DatePresence, P.Statut
FROM Presences P
JOIN Etudiants E ON P.IDEtudiant = E.IDEtudiant;

-- 3. Afficher les notes des �tudiants avec les enseignants
SELECT 
    E.Prenom + ' ' + E.Nom AS Etudiant, 
    N.Matiere, 
    N.Note, 
    N.DateEvaluation, 
    ENS.Prenom + ' ' + ENS.Nom AS Enseignant
FROM Notes N
JOIN Etudiants E ON N.IDEtudiant = E.IDEtudiant
JOIN Enseignants ENS ON N.IDEnseignant = ENS.IDEnseignant;

-- 4. Calculer la moyenne des notes pour chaque �tudiant
SELECT 
    E.Prenom + ' ' + E.Nom AS Etudiant, 
    AVG(N.Note) AS Moyenne
FROM Notes N
JOIN Etudiants E ON N.IDEtudiant = E.IDEtudiant
GROUP BY E.Prenom, E.Nom;

-- 5. Afficher les �tudiants absents ou en retard un jour donn�
SELECT E.Prenom + ' ' + E.Nom AS Etudiant, P.Statut, P.DatePresence
FROM Presences P
JOIN Etudiants E ON P.IDEtudiant = E.IDEtudiant
WHERE P.Statut IN ('Absent', 'Retard');

-- 6. Afficher les �tudiants ayant une note inf�rieure � 10
SELECT 
    E.Prenom + ' ' + E.Nom AS Etudiant, 
    N.Matiere, 
    N.Note
FROM Notes N
JOIN Etudiants E ON N.IDEtudiant = E.IDEtudiant
WHERE N.Note < 10;
