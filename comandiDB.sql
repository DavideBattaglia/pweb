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
                        telefono_cellulare INT,
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
    ('concerti', 'Concerto 1', '2024-06-01 20:00:00', 'Località A', 100, 80, 25.00, 30.00, 'https://example.com/images/concerti/1.jpg', 12,5),
    ('eventi sportivi', 'Partita Calcio', '2024-06-01 20:00:00', 'Località B', 150, 110, 35.00, 45.00, 'https://example.com/images/sportivi/1.jpg', 23,10),
    ('spettacoli teatrali', 'Opera 1','2024-06-01 20:00:00', 'Località C', 120, 90, 28.00, 36.00, 'https://example.com/images/spettacoli/1.jpg', 32,2),
    ('visite guidate', 'Visita Museo 1', '2024-06-01 20:00:00', 'Località A', 130, 95, 32.00, 42.00, 'https://example.com/images/guidate/1.jpg', 123,1),
    ('concerti', 'Concerto 2', '2024-06-01 20:00:00', 'Località B', 140, 105, 33.00, 43.00, 'https://example.com/images/concerti/2.jpg', 63,0),
    ('eventi sportivi', 'Partita Pallavolo','2024-06-01 20:00:00', 'Località C', 160, 115, 38.00, 48.00, 'https://example.com/images/sportivi/2.jpg', 43,15),
    ('spettacoli teatrali', 'Musical 1', '2024-06-01 20:00:00', 'Località A', 130, 95, 32.00, 42.00, 'https://example.com/images/spettacoli/2.jpg', 21,10),
    ('visite guidate', 'Visita Castello 1', '2024-06-01 20:00:00', 'Località B', 150, 110, 35.00, 45.00, 'https://example.com/images/guidate/2.jpg', 51,7),
    ('concerti', 'Concerto 3', '2024-06-01 20:00:00', 'Località C', 170, 125, 40.00, 50.00, 'https://example.com/images/concerti/3.jpg', 2,2),
    ('eventi sportivi', 'Gara Automobilistica', '2024-06-01 20:00:00', 'Località A', 180, 135, 45.00, 55.00, 'https://example.com/images/sportivi/3.jpg', 14,7);

