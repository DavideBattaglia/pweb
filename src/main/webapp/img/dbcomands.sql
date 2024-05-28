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
