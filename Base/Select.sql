/*
	Lezione 1 – Il comando SELECT
	
	1. Cos'è SELECT?
	SELECT è il comando SQL utilizzato per interrogare una o più tabelle e recuperare i dati che ci interessano.
	
	2. A cosa serve?
	Permette di:
		- visualizzare tutte le colonne di una tabella;
		- selezionare soltanto alcune colonne;
		- creare colonne calcolate;
		- assegnare nomi personalizzati alle colonne del risultato;
		- individuare valori distinti.
	
	3. Perché è importante per un Data Analyst?
	Un Data Analyst raramente ha bisogno di visualizzare un'intera tabella. Generalmente deve estrarre soltanto le informazioni utili per rispondere a una domanda aziendale.

	Per esempio:
		- Quanti studenti sono iscritti?
		- Quali corsi sono disponibili?
		- Quali studenti hanno un indirizzo email?
		- Quali sono i voti degli studenti?
		- Quanto costa ciascun corso?

	SELECT è quindi uno dei comandi fondamentali per costruire report e analisi.

	4. Sintassi di base
	SELECT Colonna1, Colonna2, Colonna3
	FROM NomeTabella;


	- SELECT: indica quali colonne vogliamo visualizzare.
	- FROM: indica da quale tabella recuperare i dati.
	- ;: termina l'istruzione SQL.



	Obiettivi del modulo
		- Estrarre dati da una o più tabelle.
		- Selezionare soltanto le colonne necessarie.
		- Filtrare i dati in base a condizioni.
		- Ordinare e limitare i risultati.
		- Individuare valori mancanti e duplicati.
		- Preparare dataset per report e dashboard.
*/

USE ScuolaDb;


-- Esempio 1: Estrarre dati da una o più tabelle.
SELECT * FROM AnniScolastici;

-- Esempio 2: Selezionare soltanto le colonne necessarie della tabella Studenti.
-- Nome, Cognome, Email, CodiceFiscale, Sesso
SELECT
	Nome,
	Cognome,
	Email,
	CodiceFiscale,
	Sesso
FROM Studenti;


-- WHERE: filtra i dati a seconda delle condizioni.  
-- Esempio 3: - Filtrare i dati in base alle condizioni usando (WHERE).
SELECT 
	*
FROM Aule
WHERE AulaId = 7;


-- Concvatenazione: Permette di nire più stringhe usando il "+"
-- Esempio 3.1: Restituire il nome completo dello studente con il Codcie Fiscale 
SELECT 
	Nome + ' ' + Cognome,
	CodiceFiscale
FROM Studenti;

-- Aliass (AS): Permette di definire un nome ad una colonna

-- Esempio 1
SELECT 
	Nome + ' ' + Cognome AS NomeCompleto,
	CodiceFiscale
FROM Studenti;


-- Esempio 2
SELECT 
	Nome + ' ' + Cognome AS 'Nome Completo',
	CodiceFiscale
FROM Studenti;


-- Esempio 3
SELECT 
	Nome + ' ' + Cognome AS 'Nome Completo',
	CodiceFiscale AS [Codice Fiscale]
FROM Studenti;



-- Modifica della colonna Capacita 
Alter Table Aule
ALTER COLUMN Capacita INT NULL;

-- Modifica della colonna TipoAula
Alter Table Aule
ALTER COLUMN TipoAula NVARCHAR(50) NULL;



-- Inseriemnto dei dati con valore NULL
INSERT INTO Aule 
	(NomeAula, TipoAula, Capacita, Piano, Attiva)
VALUES 
	('Aula 32', null, 100, null, 0);



-- Ordinare e limitare i risultati.
-- IS NULL E IS NOT NULL
SELECT * 
FROM Aule
WHERE Piano is NULL;


SELECT * FROM Classi; 

-- Inserimento dell aclasse con valore NULL
INSERT INTO Classi
	(NomeClasse, AnnoScolasticoId, TutorDocenteId)
VALUES
	('2IT-Sezione 35', 12, 30);


SELECT * 
FROM Classi
WHERE NomeClasse = '2IT-Sezione 35';


SELECT * 
FROM Classi
WHERE ClasseId = 31; 


-- TOP
-- Limitare il risultato della Select a 5
SELECT TOP 5 *
FROM Studenti
WHERE Sesso = 'F';

SELECT TOP 3 *
FROM Studenti
WHERE Sesso = 'M';


-- Selezione ultime righe 
SELECT *
FROM(
    SELECT TOP 5 * 
    FROM Studenti
    ORDER BY StudenteId DESC
) AS Ulitmi
ORDER BY StudenteId ASC;
