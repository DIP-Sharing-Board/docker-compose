CREATE DATABASE IF NOT EXISTS activities;
USE activities;

CREATE TABLE Competitions (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    hashLink VARCHAR(255) NOT NULL UNIQUE,
    link VARCHAR(255) NOT NULL,
    topic TEXT,
    imageUrl TEXT NOT NULL,
    deadline DATETIME,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    isActive BOOLEAN NOT NULL DEFAULT TRUE,
    INDEX competitions_hash_link (hashLink),
    INDEX competitions_updated_at (updatedAt)
);

CREATE TABLE Camps (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    hashLink VARCHAR(255) NOT NULL UNIQUE,
    link VARCHAR(255) NOT NULL,
    topic TEXT,
    imageUrl TEXT NOT NULL,
    deadline DATETIME,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    isActive BOOLEAN NOT NULL DEFAULT TRUE,
    INDEX camps_hash_link (hashLink),
    INDEX camps_updated_at (updatedAt)
);

CREATE TABLE Others (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    hashLink VARCHAR(255) NOT NULL UNIQUE,
    link VARCHAR(255) NOT NULL,
    topic TEXT,
    imageUrl TEXT NOT NULL,
    deadline DATETIME,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    isActive BOOLEAN NOT NULL DEFAULT TRUE,
    INDEX others_hash_link (hashLink),
    INDEX others_updated_at (updatedAt)
);

-- Ensure the event scheduler is enabled
SET GLOBAL event_scheduler = ON;

-- Change the delimiter to handle the event definition
DELIMITER $$

-- Create the event to update overdue activities
CREATE EVENT delete_overdue_activity
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
  UPDATE Camps
  SET isActive = FALSE
  WHERE deadline < NOW();

  UPDATE Competitions
  SET isActive = FALSE
  WHERE deadline < NOW();

  UPDATE Others
  SET isActive = FALSE
  WHERE deadline < NOW();
END $$

-- Change the delimiter back to the default
DELIMITER ;