-- Étape 1 : Créer la base de données
DROP DATABASE IF EXISTS GestionCentreAppels;
CREATE DATABASE GestionCentreAppels;
GO

USE GestionCentreAppels;
GO

-- Étape 2 : Créer les tables

-- Table des Agents
CREATE TABLE Agents (
    IDAgent INT IDENTITY(1,1) PRIMARY KEY,
    Prenom NVARCHAR(50) NOT NULL,
    Nom NVARCHAR(50) NOT NULL,
    DateEmbauche DATE NOT NULL,
    Telephone NVARCHAR(20) NOT NULL,
    Statut NVARCHAR(20) CHECK (Statut IN ('Disponible', 'Occupé', 'Absent')) NOT NULL
);

-- Table des Clients
CREATE TABLE Clients (
    IDClient INT IDENTITY(1,1) PRIMARY KEY,
    Prenom NVARCHAR(50) NOT NULL,
    Nom NVARCHAR(50) NOT NULL,
    Telephone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100),
    Ville NVARCHAR(50)
);

-- Table des Appels
CREATE TABLE Appels (
    IDAppel INT IDENTITY(1,1) PRIMARY KEY,
    IDAgent INT FOREIGN KEY REFERENCES Agents(IDAgent) ON DELETE SET NULL,
    IDClient INT FOREIGN KEY REFERENCES Clients(IDClient) ON DELETE CASCADE,
    DateAppel DATETIME NOT NULL,
    Duree INT NOT NULL, -- Durée en minutes
    TypeAppel NVARCHAR(20) CHECK (TypeAppel IN ('Entrant', 'Sortant')) NOT NULL
);

-- Table des Résultats des Appels
CREATE TABLE ResultatsAppels (
    IDResultat INT IDENTITY(1,1) PRIMARY KEY,
    IDAppel INT FOREIGN KEY REFERENCES Appels(IDAppel) ON DELETE CASCADE,
    StatutAppel NVARCHAR(50) CHECK (StatutAppel IN ('Réussi', 'Échec', 'En attente')) NOT NULL,
    Commentaire NVARCHAR(255)
);

-- Étape 3 : Insérer des données d'exemple

-- Insérer des Agents
INSERT INTO Agents (Prenom, Nom, DateEmbauche, Telephone, Statut) VALUES
('Alice', 'Dubois', '2020-01-15', '0601020304', 'Disponible'),
('Pierre', 'Martin', '2019-06-20', '0602030405', 'Occupé'),
('Sophie', 'Lemoine', '2021-03-10', '0612345678', 'Disponible'),
('Jean', 'Durand', '2022-02-15', '0623456789', 'Absent'),
('Isabelle', 'Morel', '2018-11-25', '0634567890', 'Disponible');

-- Insérer 20 Clients
INSERT INTO Clients (Prenom, Nom, Telephone, Email, Ville) VALUES
('Marc', 'Leroy', '0701020304', 'marc.leroy@example.com', 'Paris'),
('Claire', 'Dubois', '0702030405', 'claire.dubois@example.com', 'Lyon'),
('Lucas', 'Moreau', '0712345678', 'lucas.moreau@example.com', 'Marseille'),
('Emma', 'Bertrand', '0723456789', 'emma.bertrand@example.com', 'Toulouse'),
('Nicolas', 'Girard', '0734567890', 'nicolas.girard@example.com', 'Bordeaux'),
('Laura', 'Garnier', '0741020304', 'laura.garnier@example.com', 'Nice'),
('Thomas', 'Petit', '0742030405', 'thomas.petit@example.com', 'Strasbourg'),
('Julie', 'Roux', '0743040506', 'julie.roux@example.com', 'Montpellier'),
('Antoine', 'Blanc', '0744050607', 'antoine.blanc@example.com', 'Nantes'),
('Sophie', 'Morel', '0745060708', 'sophie.morel@example.com', 'Rennes'),
('Paul', 'Henry', '0746070809', 'paul.henry@example.com', 'Lille'),
('Isabelle', 'Simon', '0747080910', 'isabelle.simon@example.com', 'Grenoble'),
('Kevin', 'Robin', '0748091011', 'kevin.robin@example.com', 'Rouen'),
('Camille', 'Lucas', '0749101112', 'camille.lucas@example.com', 'Reims'),
('Hugo', 'Dupuis', '0750111213', 'hugo.dupuis@example.com', 'Saint-Étienne'),
('Manon', 'Lambert', '0751121314', 'manon.lambert@example.com', 'Le Havre'),
('Vincent', 'Chevalier', '0752131415', 'vincent.chevalier@example.com', 'Angers'),
('Chloe', 'Benoit', '0753141516', 'chloe.benoit@example.com', 'Dijon'),
('Alexandre', 'Fabre', '0754151617', 'alexandre.fabre@example.com', 'Clermont-Ferrand'),
('Elise', 'Bonnet', '0755161718', 'elise.bonnet@example.com', 'Metz');

-- Étape 4 : Requêtes utiles

-- 1. Afficher tous les clients
SELECT * FROM Clients;

-- 2. Afficher les appels avec les détails de l'agent et du client
SELECT 
    A.IDAppel,
    AG.Prenom + ' ' + AG.Nom AS Agent,
    C.Prenom + ' ' + C.Nom AS Client,
    A.DateAppel,
    A.Duree AS DureeMinutes,
    A.TypeAppel
FROM Appels A
JOIN Agents AG ON A.IDAgent = AG.IDAgent
JOIN Clients C ON A.IDClient = C.IDClient;

-- 3. Afficher les agents disponibles
SELECT Prenom + ' ' + Nom AS AgentDisponible
FROM Agents
WHERE Statut = 'Disponible';

-- 4. Afficher les clients avec leurs numéros de téléphone
SELECT Prenom + ' ' + Nom AS Client, Telephone
FROM Clients;

-- 5. Afficher les appels réussis
SELECT 
    A.IDAppel,
    C.Prenom + ' ' + C.Nom AS Client,
    RA.StatutAppel,
    RA.Commentaire
FROM ResultatsAppels RA
JOIN Appels A ON RA.IDAppel = A.IDAppel
JOIN Clients C ON A.IDClient = C.IDClient
WHERE RA.StatutAppel = 'Réussi';
