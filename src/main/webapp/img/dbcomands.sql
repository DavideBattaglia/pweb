-- Drop the existing 'utenti' table if it exists
CREATE TABLE utenti (
                        nome VARCHAR(50) NOT NULL,
                        cognome VARCHAR(50) NOT NULL,
                        data_nascita DATE NOT NULL,
                        email VARCHAR(100) NOT NULL,
                        telefono_cellulare VARCHAR(10) NOT NULL,
                        username VARCHAR(20) NOT NULL PRIMARY KEY,
                        password VARCHAR(255) NOT NULL
);
-- First of all drop table if exist

CREATE TABLE events (
                        event_id INT PRIMARY KEY AUTO_INCREMENT,
                        event_type_id INT NOT NULL,
                        name VARCHAR(255) NOT NULL,
                        date DATE NOT NULL,
                        time TIME NOT NULL,
                        location VARCHAR(255) NOT NULL,
                        image_url VARCHAR(255),
                        FOREIGN KEY (event_type_id) REFERENCES event_types(event_type_id)
);

CREATE TABLE event_types (
                             event_type_id INT PRIMARY KEY AUTO_INCREMENT,
                             type_name VARCHAR(50) NOT NULL
);

CREATE TABLE tickets (
                         ticket_id INT PRIMARY KEY AUTO_INCREMENT,
                         event_id INT NOT NULL,
                         ticket_type VARCHAR(20) NOT NULL, -- e.g., "poltrona", "posto in piedi"
                         price DECIMAL(10,2) NOT NULL,
                         FOREIGN KEY (event_id) REFERENCES events(event_id)
);

INSERT INTO event_types (event_type_id, type_name)
VALUES
    (1, 'Concerto'),
    (2, 'Spettacolo teatrale'),
    (3, 'Evento sportivo'),
    (4, 'Visita guidata');


-- Insert event types
INSERT INTO events (event_id, event_type_id, name, date, time, location, image_url)
VALUES
    (1, 1, 'Concerto dei Linkin Park', '2024-06-10', '21:00:00', 'Stadio San Siro, Milano', 'https://linkinpark.com/wp-content/uploads/2023/04/LP_2024_WORLD_TOUR_EUROPE_MAIN_IMAGE_4000x2667.jpg'),
    (2, 2, 'Hamlet di Shakespeare', '2024-05-25', '20:00:00', 'Teatro alla Scala, Milano', 'https://www.teatroallascala.org/sites/default/files/styles/400x280/public/spettacoli/hamlet_2024.jpg'),
    (3, 3, 'Finale di Champions League', '2024-06-01', '20:00:00', 'Stadio San Siro, Milano', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/UEFA_Champions_League_logo.svg/1200px-UEFA_Champions_League_logo.svg.png'),
    (4, 4, 'Visita guidata alla Galleria degli Uffizi', '2024-06-05', '10:00:00', 'Galleria degli Uffizi, Firenze', 'https://www.uffizi.it/sites/default/files/styles/articolo_full_width/public/immagini/2020/02/galleria_uffizi_esterno_01_1920x1080.jpg');



INSERT INTO tickets (ticket_id, event_id, ticket_type, price)
VALUES
    (1, 1, 'poltrona', 50.00),
    (2, 1, 'posto in piedi', 30.00),
    (3, 2, 'poltrona', 80.00),
    (4, 2, 'posto in piedi', 40.00),
    (5, 3, 'poltrona VIP', 200.00),
    (6, 3, 'poltrona standard', 100.00),
    (7, 3, 'posto in piedi', 50.00),
    (8, 4, 'intero', 20.00),
    (9, 4, 'ridotto', 10.00);
