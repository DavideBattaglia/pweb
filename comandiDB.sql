java -jar %DERBY_HOME%/lib/derbyrun.jar server start

java -jar %DERBY_HOME%/lib/derbyrun.jar ij
CONNECT 'jdbc:derby://localhost:1527/ProgWebDB;create=true';
SHOW CONNECTIONS;

SELECT * FROM UTENTI;

CREATE TABLE UTENTI (
                        Id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                        nome VARCHAR(255),
                        cognome VARCHAR(255),
                        data_nascita DATE,
                        email VARCHAR(255),
                        telefono_cellulare VARCHAR(10),
                        username VARCHAR(255),
                        password VARCHAR(255),
                        IsAdmin BOOLEAN,
                        Acquisti INT
);


CREATE TABLE Eventi (
    Id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    TipoEvento VARCHAR(255),
    NomeEvento VARCHAR(255),
    DataOra TIMESTAMP,
    Localita VARCHAR(255),
    PostiASedere INT,
    PostiInPiedi INT,
    PrezzoASedere FLOAT,
    PrezzoInPiedi FLOAT,
    Immagine VARCHAR(255) NOT NULL,
    Click INT,
    Sconto INT);

CREATE TABLE Carrello (
                          Id INT PRIMARY KEY,
                          Username VARCHAR(255) NOT NULL,
                          IdEvento INT NOT NULL,
                          TipologiaBiglietto VARCHAR(255) NOT NULL,
                          Prezzo INT NOT NULL,
                          FOREIGN KEY (IdEvento) REFERENCES Eventi(Id)
);

INSERT INTO Eventi (TipoEvento, NomeEvento, DataOra, Localita, PostiASedere, PostiInPiedi, PrezzoASedere, PrezzoInPiedi, Immagine, Click,Sconto)
VALUES
    ('concerti', 'Concerto 1', '2024-06-01 20:00:00', 'Località A', 100, 80, 25.00, 30.00, 'C:\Users\1vinc\IdeaProjects\ProgWeb\src\main\webapp\img\c1.jpeg', 12,5),
    ('eventi sportivi', 'Partita Calcio', '2024-06-01 20:00:00', 'Località B', 150, 110, 35.00, 45.00, 'C:\Users\1vinc\IdeaProjects\ProgWeb\src\main\webapp\img\e1.jpeg', 23,10),
    ('spettacoli teatrali', 'Opera 1','2024-06-01 20:00:00', 'Località C', 120, 90, 28.00, 36.00, 'https://example.com/images/spettacoli/1.jpg', 32,2),
    ('visite guidate', 'Visita Museo 1', '2024-06-01 20:00:00', 'Località A', 130, 95, 32.00, 42.00, './img/c1.jpeg', 123,120),
    ('concerti', 'Concerto 2', '2024-06-01 20:00:00', 'Località B', 140, 105, 33.00, 43.00, 'C:\Users\1vinc\IdeaProjects\ProgWeb\src\main\webapp\img\s1.jpeg', 63,0),
    ('eventi sportivi', 'Partita Pallavolo','2024-06-01 20:00:00', 'Località C', 160, 115, 38.00, 48.00, 'https://example.com/images/sportivi/2.jpg', 43,15),
    ('spettacoli teatrali', 'Musical 1', '2024-06-01 20:00:00', 'Località A', 130, 95, 32.00, 42.00, 'https://example.com/images/spettacoli/2.jpg', 21,10),
    ('visite guidate', 'Visita Castello 1', '2024-06-01 20:00:00', 'Località B', 150, 110, 35.00, 45.00, 'C:\Users\1vinc\IdeaProjects\ProgWeb\src\main\webapp\img\c1.jpeg', 51,7),
    ('concerti', 'Concerto 3', '2024-06-01 20:00:00', 'Località C', 170, 125, 40.00, 50.00, 'https://example.com/images/concerti/3.jpg', 2,2),
    ('eventi sportivi', 'Gara Automobilistica', '2024-06-01 20:00:00', 'Località A', 180, 135, 45.00, 55.00, 'https://example.com/images/sportivi/3.jpg', 14,7);


INSERT INTO UTENTI (nome, cognome, Data_nascita, email, telefono_cellulare, username, password, IsAdmin, Acquisti) VALUES
    ('AdminNome', 'AdminCognome', '1980-01-01', 'admin@example.com', 1234567890, 'admin', 'admin', TRUE, 0);

INSERT INTO UTENTI (nome, cognome, Data_nascita, email, telefono_cellulare, username, password, IsAdmin, Acquisti) VALUES
    ('User1Nome', 'User1Cognome', '1990-02-02', 'user1@example.com', 1234567891, 'user1', 'user1Pass', FALSE, 0);

INSERT INTO UTENTI (nome, cognome, Data_nascita, email, telefono_cellulare, username, password, IsAdmin, Acquisti) VALUES
    ('User2Nome', 'User2Cognome', '1991-03-03', 'user2@example.com', 1234567892, 'user2', 'user2Pass', FALSE, 0);

INSERT INTO UTENTI (nome, cognome, Data_nascita, email, telefono_cellulare, username, password, IsAdmin, Acquisti) VALUES
    ('User3Nome', 'User3Cognome', '1992-04-04', 'user3@example.com', 1234567893, 'user3', 'user3Pass', FALSE, 0);

INSERT INTO UTENTI (nome, cognome, Data_nascita, email, telefono_cellulare, username, password, IsAdmin, Acquisti) VALUES
    ('User4Nome', 'User4Cognome', '1993-05-05', 'user4@example.com', 1234567894, 'user4', 'user4Pass', FALSE, 0);
