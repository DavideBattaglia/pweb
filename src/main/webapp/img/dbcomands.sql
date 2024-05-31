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

CREATE TABLE EVENT (
                        EVENT_ID INT PRIMARY KEY,
                        EVENT_CATEGORY VARCHAR(255) NOT NULL,
                        EVENT_NAME VARCHAR(255) NOT NULL,
                        EVENT_DATE DATE NOT NULL,
                        EVENT_TIME TIME NOT NULL,
                        EVENT_LOCATION VARCHAR(255) NOT NULL,
                        IMG_URL VARCHAR(255) NOT NULL,
                        SEAT_TICKET_PRICE DECIMAL(10,2) NOT NULL,  -- Decimal with precision (10 digits) and scale (2 decimal places)
                        STANDING_TICKET_PRICE DECIMAL(10,2) NOT NULL  -- Decimal with precision (10 digits) and scale (2 decimal places)
);

INSERT INTO EVENT (EVENT_ID, EVENT_CATEGORY, EVENT_NAME, EVENT_DATE, EVENT_TIME, EVENT_LOCATION, IMG_URL, SEAT_TICKET_PRICE, STANDING_TICKET_PRICE)
VALUES
    (1, 'Music', 'Rock Concert', '2024-07-01', '20:00:00', 'City Stadium', 'https://example.com/rock-concert.jpg', 35.00, 25.00),
    (2, 'Music', 'Pop Festival', '2024-07-10', '18:00:00', 'Concert Hall', 'https://example.com/pop-festival.jpg', 40.00, 30.00),
    (3, 'Music', 'Jazz Performance', '2024-07-15', '19:30:00', 'Jazz Club', 'https://example.com/jazz-performance.jpg', 25.00, 15.00),
    (4, 'Sports', 'Football Match', '2024-07-20', '17:00:00', 'Stadium Arena', 'https://example.com/football-match.jpg', 45.00, 35.00),
    (5, 'Sports', 'Basketball Game', '2024-07-25', '19:00:00', 'Indoor Arena', 'https://example.com/basketball-game.jpg', 30.00, 20.00),
    (6, 'Theater', 'Shakespeare Play', '2024-07-30', '20:00:00', 'Grand Theater', 'https://example.com/shakespeare-play.jpg', 50.00, 35.00),
    (7, 'Dance', 'Ballet Performance', '2024-08-04', '19:30:00', 'Opera House', 'https://example.com/ballet-performance.jpg', 40.00, 25.00),
    (8, 'Comedy', 'Stand-Up Show', '2024-08-09', '21:00:00', 'Comedy Club', 'https://example.com/stand-up-show.jpg', 35.00, 20.00),
    (9, 'Art', 'Painting Exhibition', '2024-08-14', '10:00:00', 'Art Gallery', 'https://example.com/painting-exhibition.jpg', 20.00, 15.00),
    (10, 'Other', 'Conference', '2024-08-19', '09:00:00', 'Conference Center', 'https://example.com/conference.jpg', 60.00, 40.00);


