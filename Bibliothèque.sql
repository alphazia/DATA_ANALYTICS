-- Step 1: Create the database
CREATE DATABASE GestionBibliotheque;
GO

USE GestionBibliotheque;
GO

-- Step 2: Create the tables

-- Table: Bibliothèque (Library Branches)
CREATE TABLE Bibliothèque (
    BibliothequeID INT PRIMARY KEY IDENTITY(1,1),
    Nom NVARCHAR(100),
    Adresse NVARCHAR(255),
    Téléphone NVARCHAR(20)
);
GO

-- Table: Livres (Books)
CREATE TABLE Livres (
    LivreID INT PRIMARY KEY IDENTITY(1,1),
    Titre NVARCHAR(255),
    Auteur NVARCHAR(100),
    Genre NVARCHAR(50),
    AnnéePublication INT,
    BibliothequeID INT FOREIGN KEY REFERENCES Bibliothèque(BibliothequeID),
    Quantité INT
);
GO

-- Table: Membres (Library Members)
CREATE TABLE Membres (
    MembreID INT PRIMARY KEY IDENTITY(1,1),
    Prénom NVARCHAR(50),
    Nom NVARCHAR(50),
    Email NVARCHAR(100),
    Téléphone NVARCHAR(20),
    Adresse NVARCHAR(255),
    DateInscription DATE
);
GO

-- Table: Employés (Staff)
CREATE TABLE Employés (
    EmployéID INT PRIMARY KEY IDENTITY(1,1),
    Prénom NVARCHAR(50),
    Nom NVARCHAR(50),
    Poste NVARCHAR(50),
    Salaire DECIMAL(10, 2),
    BibliothequeID INT FOREIGN KEY REFERENCES Bibliothèque(BibliothequeID)
);
GO

-- Table: Emprunts (Borrowing)
CREATE TABLE Emprunts (
    EmpruntID INT PRIMARY KEY IDENTITY(1,1),
    LivreID INT FOREIGN KEY REFERENCES Livres(LivreID),
    MembreID INT FOREIGN KEY REFERENCES Membres(MembreID),
    DateEmprunt DATE,
    DateRetourPrévue DATE,
    DateRetourEffective DATE
);
GO

-- Table: Réservations (Reservations)
CREATE TABLE Réservations (
    ReservationID INT PRIMARY KEY IDENTITY(1,1),
    LivreID INT FOREIGN KEY REFERENCES Livres(LivreID),
    MembreID INT FOREIGN KEY REFERENCES Membres(MembreID),
    DateReservation DATE,
    Statut NVARCHAR(50) -- (e.g., 'En attente', 'Complétée', 'Annulée')
);
GO

-- Step 3: Insert sample data

-- Bibliothèque branches
INSERT INTO Bibliothèque (Nom, Adresse, Téléphone) VALUES
('Bibliothèque Centrale', '123 Rue Principale, Paris', '01-23-45-67-89'),
('Bibliothèque de Lyon', '456 Rue du Rhône, Lyon', '04-56-78-90-12');
GO

-- Livres (Books)
INSERT INTO Livres (Titre, Auteur, Genre, AnnéePublication, BibliothequeID, Quantité) VALUES
('Le Petit Prince', 'Antoine de Saint-Exupéry', 'Fiction', 1943, 1, 10),
('Les Misérables', 'Victor Hugo', 'Classique', 1862, 1, 5),
('LÉtranger', 'Albert Camus', 'Philosophie', 1942, 2, 8);
GO

-- Membres (Library Members)
INSERT INTO Membres (Prénom, Nom, Email, Téléphone, Adresse, DateInscription) VALUES
('Marie', 'Dupont', 'marie.dupont@example.com', '06-12-34-56-78', '10 Rue des Fleurs, Paris', '2024-01-15'),
('Jean', 'Martin', 'jean.martin@example.com', '07-89-45-23-67', '25 Avenue des Champs, Lyon', '2024-02-01');
GO

-- Employés (Staff)
INSERT INTO Employés (Prénom, Nom, Poste, Salaire, BibliothequeID) VALUES
('Luc', 'Durand', 'Bibliothécaire', 2500.00, 1),
('Sophie', 'Moreau', 'Assistante', 2000.00, 2);
GO

-- Emprunts (Borrowing)
INSERT INTO Emprunts (LivreID, MembreID, DateEmprunt, DateRetourPrévue, DateRetourEffective) VALUES
(1, 1, '2024-12-01', '2024-12-15', NULL),
(2, 2, '2024-12-03', '2024-12-17', '2024-12-16');
GO

-- Réservations (Reservations)
INSERT INTO Réservations (LivreID, MembreID, DateReservation, Statut) VALUES
(3, 1, '2024-12-05', 'En attente'),
(2, 2, '2024-12-07', 'Complétée');
GO

-- Step 4: Queries for Library Management System

-- 1. Retrieve all books in a library branch
SELECT L.Titre, L.Auteur, L.Genre, L.Quantité
FROM Livres L
JOIN Bibliothèque B ON L.BibliothequeID = B.BibliothequeID
WHERE B.Nom = 'Bibliothèque Centrale';

-- 2. List all members and their borrowed books
SELECT M.Prénom + ' ' + M.Nom AS NomMembre, L.Titre, E.DateEmprunt, E.DateRetourPrévue
FROM Membres M
JOIN Emprunts E ON M.MembreID = E.MembreID
JOIN Livres L ON E.LivreID = L.LivreID;

-- 3. List overdue books
SELECT L.Titre, M.Prénom + ' ' + M.Nom AS NomMembre, E.DateRetourPrévue
FROM Emprunts E
JOIN Livres L ON E.LivreID = L.LivreID
JOIN Membres M ON E.MembreID = M.MembreID
WHERE E.DateRetourEffective IS NULL AND E.DateRetourPrévue < GETDATE();

-- 4. Retrieve staff details for a branch
SELECT E.Prénom, E.Nom, E.Poste, E.Salaire
FROM Employés E
JOIN Bibliothèque B ON E.BibliothequeID = B.BibliothequeID
WHERE B.Nom = 'Bibliothèque de Lyon';

-- 5. Retrieve reservation details
SELECT R.DateReservation, L.Titre, M.Prénom + ' ' + M.Nom AS NomMembre, R.Statut
FROM Réservations R
JOIN Livres L ON R.LivreID = L.LivreID
JOIN Membres M ON R.MembreID = M.MembreID;
