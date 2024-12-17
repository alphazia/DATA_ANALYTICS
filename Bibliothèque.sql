-- Step 1: Create the database
CREATE DATABASE GestionBibliotheque;
GO

USE GestionBibliotheque;
GO

-- Step 2: Create the tables

-- Table: Biblioth�que (Library Branches)
CREATE TABLE Biblioth�que (
    BibliothequeID INT PRIMARY KEY IDENTITY(1,1),
    Nom NVARCHAR(100),
    Adresse NVARCHAR(255),
    T�l�phone NVARCHAR(20)
);
GO

-- Table: Livres (Books)
CREATE TABLE Livres (
    LivreID INT PRIMARY KEY IDENTITY(1,1),
    Titre NVARCHAR(255),
    Auteur NVARCHAR(100),
    Genre NVARCHAR(50),
    Ann�ePublication INT,
    BibliothequeID INT FOREIGN KEY REFERENCES Biblioth�que(BibliothequeID),
    Quantit� INT
);
GO

-- Table: Membres (Library Members)
CREATE TABLE Membres (
    MembreID INT PRIMARY KEY IDENTITY(1,1),
    Pr�nom NVARCHAR(50),
    Nom NVARCHAR(50),
    Email NVARCHAR(100),
    T�l�phone NVARCHAR(20),
    Adresse NVARCHAR(255),
    DateInscription DATE
);
GO

-- Table: Employ�s (Staff)
CREATE TABLE Employ�s (
    Employ�ID INT PRIMARY KEY IDENTITY(1,1),
    Pr�nom NVARCHAR(50),
    Nom NVARCHAR(50),
    Poste NVARCHAR(50),
    Salaire DECIMAL(10, 2),
    BibliothequeID INT FOREIGN KEY REFERENCES Biblioth�que(BibliothequeID)
);
GO

-- Table: Emprunts (Borrowing)
CREATE TABLE Emprunts (
    EmpruntID INT PRIMARY KEY IDENTITY(1,1),
    LivreID INT FOREIGN KEY REFERENCES Livres(LivreID),
    MembreID INT FOREIGN KEY REFERENCES Membres(MembreID),
    DateEmprunt DATE,
    DateRetourPr�vue DATE,
    DateRetourEffective DATE
);
GO

-- Table: R�servations (Reservations)
CREATE TABLE R�servations (
    ReservationID INT PRIMARY KEY IDENTITY(1,1),
    LivreID INT FOREIGN KEY REFERENCES Livres(LivreID),
    MembreID INT FOREIGN KEY REFERENCES Membres(MembreID),
    DateReservation DATE,
    Statut NVARCHAR(50) -- (e.g., 'En attente', 'Compl�t�e', 'Annul�e')
);
GO

-- Step 3: Insert sample data

-- Biblioth�que branches
INSERT INTO Biblioth�que (Nom, Adresse, T�l�phone) VALUES
('Biblioth�que Centrale', '123 Rue Principale, Paris', '01-23-45-67-89'),
('Biblioth�que de Lyon', '456 Rue du Rh�ne, Lyon', '04-56-78-90-12');
GO

-- Livres (Books)
INSERT INTO Livres (Titre, Auteur, Genre, Ann�ePublication, BibliothequeID, Quantit�) VALUES
('Le Petit Prince', 'Antoine de Saint-Exup�ry', 'Fiction', 1943, 1, 10),
('Les Mis�rables', 'Victor Hugo', 'Classique', 1862, 1, 5),
('L�tranger', 'Albert Camus', 'Philosophie', 1942, 2, 8);
GO

-- Membres (Library Members)
INSERT INTO Membres (Pr�nom, Nom, Email, T�l�phone, Adresse, DateInscription) VALUES
('Marie', 'Dupont', 'marie.dupont@example.com', '06-12-34-56-78', '10 Rue des Fleurs, Paris', '2024-01-15'),
('Jean', 'Martin', 'jean.martin@example.com', '07-89-45-23-67', '25 Avenue des Champs, Lyon', '2024-02-01');
GO

-- Employ�s (Staff)
INSERT INTO Employ�s (Pr�nom, Nom, Poste, Salaire, BibliothequeID) VALUES
('Luc', 'Durand', 'Biblioth�caire', 2500.00, 1),
('Sophie', 'Moreau', 'Assistante', 2000.00, 2);
GO

-- Emprunts (Borrowing)
INSERT INTO Emprunts (LivreID, MembreID, DateEmprunt, DateRetourPr�vue, DateRetourEffective) VALUES
(1, 1, '2024-12-01', '2024-12-15', NULL),
(2, 2, '2024-12-03', '2024-12-17', '2024-12-16');
GO

-- R�servations (Reservations)
INSERT INTO R�servations (LivreID, MembreID, DateReservation, Statut) VALUES
(3, 1, '2024-12-05', 'En attente'),
(2, 2, '2024-12-07', 'Compl�t�e');
GO

-- Step 4: Queries for Library Management System

-- 1. Retrieve all books in a library branch
SELECT L.Titre, L.Auteur, L.Genre, L.Quantit�
FROM Livres L
JOIN Biblioth�que B ON L.BibliothequeID = B.BibliothequeID
WHERE B.Nom = 'Biblioth�que Centrale';

-- 2. List all members and their borrowed books
SELECT M.Pr�nom + ' ' + M.Nom AS NomMembre, L.Titre, E.DateEmprunt, E.DateRetourPr�vue
FROM Membres M
JOIN Emprunts E ON M.MembreID = E.MembreID
JOIN Livres L ON E.LivreID = L.LivreID;

-- 3. List overdue books
SELECT L.Titre, M.Pr�nom + ' ' + M.Nom AS NomMembre, E.DateRetourPr�vue
FROM Emprunts E
JOIN Livres L ON E.LivreID = L.LivreID
JOIN Membres M ON E.MembreID = M.MembreID
WHERE E.DateRetourEffective IS NULL AND E.DateRetourPr�vue < GETDATE();

-- 4. Retrieve staff details for a branch
SELECT E.Pr�nom, E.Nom, E.Poste, E.Salaire
FROM Employ�s E
JOIN Biblioth�que B ON E.BibliothequeID = B.BibliothequeID
WHERE B.Nom = 'Biblioth�que de Lyon';

-- 5. Retrieve reservation details
SELECT R.DateReservation, L.Titre, M.Pr�nom + ' ' + M.Nom AS NomMembre, R.Statut
FROM R�servations R
JOIN Livres L ON R.LivreID = L.LivreID
JOIN Membres M ON R.MembreID = M.MembreID;
