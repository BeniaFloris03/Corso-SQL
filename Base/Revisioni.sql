USE master;
GO

CREATE DATABASE Azienda_Db;
GO

USE Azienda_Db;
GO


-- Dipendenti
CREATE TABLE Dipendenti(
    DipendenteId INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Nome NVARCHAR(100) NOT NULL,
    Cognome NVARCHAR(100) NOT NULL,
    CodiceFiscale CHAR (16) NOT NULL UNIQUE,
    Telefono NVARCHAR(25) NULL,
    Email NVARCHAR(50) NULL
);


-- Stipendi
CREATE TABLE Stipendi(
    StipendioId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    DipendenteId INT NOT NULL,
    Importo DECIMAL(10, 2),
    DataPagamento DATE DEFAULT GETDATE(),
    OreLavorate DECIMAL(5,2),
    TasseRitenuta DECIMAL(10, 2),
    Straordinari DECIMAL(5,2),

    FOREIGN KEY (DipendenteId) REFERENCES Dipendenti(DipendenteId)
)


SELECT * FROM Dipendenti;
SELECT * FROM Stipendi;


-- Modifica del nome della colonna CodiceFiscale
EXEC sp_rename 'Dipendente.CodiceFiscale', 'Codice_Fiscale';

-- Modifica del nome della Tabella
EXEC sp_rename 'Dipendente', 'Dipendenti';

-- Modifica del tipo di una Colonna
ALTER TABLE Stipendi 
ALTER COLUMN TasseRitenuta DECIMAL(10, 2) NOT NULL;


-- Aggiungere condizioni in una colonna:

-- Controlla che lo stipendio non sia negativo
ALTER TABLE Stipendi
ADD CONSTRAINT CK_Stipendi_importo
    CHECK (Importo >=0);

-- Controllo delle ore lavorative e straordinarie
ALTER TABLE Stipendi
ADD CONSTRAINT CK_Stipendi_ore
    CHECK (OreLavorate >=0 AND Straordinari >=0);

-- Controllo delle tasse trattenute
ALTER TABLE Stipendi
ADD CONSTRAINT CK_Stipendi_Tasse
    CHECK (TasseRitenuta >= 0);


-- Verifica del vincolo
SELECT 
    name AS NomeVincolo,
    type_desc AS TipoVincolo
FROM sys.check_constraints 
where parent_object_id = OBJECT_ID('Stipendi');

-- Create Read Update Delete
-- Inserimento dei Dati
INSERT INTO Dipendenti
(
    Nome,
    Cognome,
    Codice_Fiscale,
    Telefono,
    Email
)
VALUES
    ('Beniamino', 'Ale', 'ABCD123478DE4RT6', '+394563726897', 'Benia.Ale@gmail.it'),
    ('Mario', 'Rossi', 'RSSMRA85M01H501Z', '+3935621470000', 'm.rossi@gmail.com'),
    ('Christian', 'Pegoraro', 'PGRCRS1234567890','+392345678901','c.pegoraro@gmail.it'),
    ('Francesca', 'Pitzanti', 'FGHYWBSSSHAUAJGS', '+393567896478', 'f.pitzanti@gmail.it'),
    ('Simone', 'Ale', 'SIMO243567YTR67O', '+390003336767', 'Simo.ale@gmail.it'),
    ('Jeanyfer', 'Andrades', 'ARCD234056YK258P', '+393586541324', 'j.andrades@gmail.it'),
    ('Raquel','Santana',' DFSGSD8266225N', '393214569', 'raquelsantana@outlook.it'),
    ('Chiara', 'Bono', 'BCAS562147XS456O', '+394512365478', 'c.bno@gmail.it'),
    ('Davide','De Rossi', 'DDR216354TA258D', '+39388526563','d.rossi@gmail.com'),
    ('Caterina','Franco','ASDO1O39079D3124', '+39 32189421', 'catcat@mail.it'),
    ('Paolo', 'Rossi', 'PUEKOI157893DOIE', '+3935874687','paolorossi@aruba.it'),
    ('Italo', 'Massacesi', 'MSSTLI45P56E567I', '+3932381234567', 'italo.m@gmail.com');

SELECT * FROM Dipendenti;


INSERT INTO Stipendi
    (
        DipendenteId,
        Importo,
        DataPagamento,
        OreLavorate,
        TasseRitenuta,
        Straordinari
    )
VALUES
    (1, 7000.00, '2026.11.30', 150, 1075, 7),
    (2, 2200.00, '2025-12-08', 160.00, 310.50, 9.00),
    (3, 2900.00, '2026-11-30', 168, 450.00, 12),
    (4, 3200.00, '2026-04-30', 176, 600.00, 18),
    (5, 5000.00, '2026-03-30', 100, 875.00, 15),
    (6, 3500.00,  '2026-02-18', 150, 250.00, 12),
    (7, 1850.00, '2026-06-28', 145, 250.00, 8),
    (8, 2600.00, '2026-05-30', 200, 350.00, 80),
    (9, 3100.00, '2026-11-15', 150, 300, 10),
    (10, 3500.00, '2026-01-30', 160, 500.00, 20),
    (11, 3000.00, '2026-12-18', 165.00, 500.00, 10.00),
    (12, 1500.00, '2026-09-30', 120, 18, 2);


SELECT * FROM Stipendi;



-- Restituisce le prime 5 righe della tabella
SELECT TOP 5 * FROM Stipendi;



USE ScuolaDb;

SELECT * FROM Studenti;

select * from Studenti ORDER BY Nome ASC;


INSERT INTO Studenti
    (Nome, Cognome, DataNascita, Sesso, CodiceFiscale, Email, Telefono, Indirizzo, Citta, DataRegistrazione, Attivo)
VALUES
    ('Luca', 'Rossi', '2009-01-01', 'M', 'MSS000000000PPP', 'l.rossi@studenti.it', '+393455436262', 'Via Roma 31', 'Ferrar', '2026-06-16', 0);


-- DISTINCT: Ci permette di rimuovere i duplicati
SELECT DISTINCT
    Nome, Cognome
FROM Studenti 
ORDER BY Nome ASC;

-- DISTINCT-WHERE-LIKE: Ci permette di cercare all'interno della tabella secondo 
-- i parametri che indichiamo delle colonne
SELECT DISTINCT
    Nome, Cognome
FROM Studenti 
Where Nome LIKE 'Luca'
ORDER BY Nome ASC;

