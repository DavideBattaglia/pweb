java -jar %DERBY_HOME%/lib/derbyrun.jar server start

java -jar %DERBY_HOME%/lib/derbyrun.jar ij
CONNECT 'jdbc:derby://localhost:1527/ProgWebDB;create=true';
SHOW CONNECTIONS;

SELECT * FROM UTENTI;



CREATE TABLE Eventi (
    Id INT PRIMARY KEY,
    TipoEvento VARCHAR(255),
    NomeEvento VARCHAR(255),
    DataOra TIMESTAMP,
    Localita VARCHAR(255),
    PostiASedere INT,
    PostiInPiedi INT,
    PrezzoASedere FLOAT,
    PrezzoInPiedi FLOAT,
    Immagine VARCHAR(255) NOT NULL,
    Click INT);

INSERT INTO Eventi (Id,TipoEvento, NomeEvento, DataOra, Localita, PostiASedere, PostiInPiedi, PrezzoASedere, PrezzoInPiedi, Immagine, Click)
VALUES
    (1,'concerti', 'Concerto 1', '2024-06-01 20:00:00', 'Località A', 100, 80, 25.00, 30.00, 'https://example.com/images/concerti/1.jpg', 0),
    (2,'eventi sportivi', 'Partita Calcio', '2024-06-01 20:00:00', 'Località B', 150, 110, 35.00, 45.00, 'https://example.com/images/sportivi/1.jpg', 0),
    (3,'spettacoli teatrali', 'Opera 1','2024-06-01 20:00:00', 'Località C', 120, 90, 28.00, 36.00, 'https://example.com/images/spettacoli/1.jpg', 0),
    (4,'visite guidate', 'Visita Museo 1', '2024-06-01 20:00:00', 'Località A', 130, 95, 32.00, 42.00, 'https://example.com/images/guidate/1.jpg', 0),
    (5,'concerti', 'Concerto 2', '2024-06-01 20:00:00', 'Località B', 140, 105, 33.00, 43.00, 'https://example.com/images/concerti/2.jpg', 0),
    (6,'eventi sportivi', 'Partita Pallavolo','2024-06-01 20:00:00', 'Località C', 160, 115, 38.00, 48.00, 'https://example.com/images/sportivi/2.jpg', 0),
    (7,'spettacoli teatrali', 'Musical 1', '2024-06-01 20:00:00', 'Località A', 130, 95, 32.00, 42.00, 'https://example.com/images/spettacoli/2.jpg', 0),
    (8,'visite guidate', 'Visita Castello 1', '2024-06-01 20:00:00', 'Località B', 150, 110, 35.00, 45.00, 'https://example.com/images/guidate/2.jpg', 0),
    (9,'concerti', 'Concerto 3', '2024-06-01 20:00:00', 'Località C', 170, 125, 40.00, 50.00, 'https://example.com/images/concerti/3.jpg', 0),
    (10,'eventi sportivi', 'Gara Automobilistica', '2024-06-01 20:00:00', 'Località A', 180, 135, 45.00, 55.00, 'https://example.com/images/sportivi/3.jpg', 0);
