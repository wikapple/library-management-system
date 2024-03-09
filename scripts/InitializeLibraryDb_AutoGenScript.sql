-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.4.0-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for librarydb
DROP DATABASE IF EXISTS `librarydb`;
CREATE DATABASE IF NOT EXISTS `librarydb` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `librarydb`;

-- Dumping structure for table librarydb.baserentalitem
DROP TABLE IF EXISTS `baserentalitem`;
CREATE TABLE IF NOT EXISTS `baserentalitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text DEFAULT '\'\'',
  `name` varchar(255) NOT NULL,
  `itemType` enum('MEDIA','INSTRUMENT') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.baserentalitem: ~8 rows (approximately)
DELETE FROM `baserentalitem`;
INSERT INTO `baserentalitem` (`id`, `description`, `name`, `itemType`) VALUES
	(7, 'Dracula is a novel by Bram Stoker, published in 1897. An epistolary novel, the narrative is related through letters, diary entries, and newspaper articles. It has no single protagonist and opens with solicitor Jonathan Harker taking a business trip to sta', 'Dracula', 'MEDIA'),
	(8, 'The novel tells the story of Dracula\'s attempt to move from Transylvania to England so that he may find new blood and spread the undead curse, and of the battle between Dracula and a small group of men and a woman led by Professor Abraham Van Helsing.      ', 'Dracula', 'MEDIA'),
	(9, 'A dazzling new edition of J.K. Rowling\'s Harry Potter and the Sorcerer\'s Stone, fully illustrated in brilliant color and featuring exclusive interactive paper craft elements, including a foldout Hogwarts letter and more! In this stunning new edition of Harry Potter and the Sorcerer\'s Stone, experience the story as never before. J.K. Rowling\'s complete and unabridged text is accompanied by full-color illustrations on nearly every page and eight exclusive, interactive paper craft elements: Readers will open Harry\'s Hogwarts letter, reveal the magical entryway to Diagon Alley, make a sumptuous feast appear in the Great Hall, and more.Designed and illustrated by award-winning design studio MinaLima -- best known for establishing the visual graphic style of the Harry Potter and Fantastic Beasts films -- this edition is sure to be a keepsake for Harry Potter fans, a beautiful addition to any collector\'s bookshelf, and an enchanting way to introduce the first book in this beloved series to a new generation of readers.', 'Harry Potter and The Sorcerer\'s Stone', 'MEDIA'),
	(10, 'War and Peace centers broadly on Napoleon’s invasion of Russia in 1812 and follows three of the best-known characters in literature: Pierre Bezukhov, the illegitimate son of a count who is fighting for his inheritance and yearning for spiritual fulfillment; Prince Andrei Bolkonsky, who leaves behind his family to fight in the war against Napoleon; and Natasha Rostov, the beautiful young daughter of a nobleman, who intrigues both men. As Napoleon’s army invades, Tolstoy vividly follows characters from diverse backgrounds—peasants and nobility, civilians and soldiers—as they struggle with the problems unique to their era, their history, and their culture. And as the novel progresses, these characters transcend their specificity, becoming some of the most moving—and human—figures in world literature. Pevear and Volokhonsky have brought us this classic novel in a translation remarkable for its fidelity to Tolstoy’s style and cadence and for its energetic, accessible prose.', 'War and Peace', 'MEDIA'),
	(11, 'George and Harold are fourth-grade buddies with a penchant for practical jokes. When the boys\' latest prank drives their science teacher over the edge, their clueless principal, Mr. Krupp, quickly hires a replacement: Professor Pippy P. Poopypants. Of course, George and Harold can\'t resist making fun of the Professor\'s silly name. But then the Professor retaliates by forcing everyone in town to change their own names to be equally silly, with colossal consequences!', 'Captain Underpants And The Perilous Plot Of Professor Poopypants', 'MEDIA'),
	(12, 'Hailed by Dostoyevsky as "The final and greatest utterance of the human mind," Don Quixote constitutes a founding work of modern Western literature. Cervantes\' masterpiece has been translated into more than sixty languages, and the novel\'s fantasy-driven "knight," Don Quixote, and his loyal squire, Sancho Panza, rank among fiction\'s most recognized characters. Their adventures have been interpreted for film, opera, and ballet, and they head a cast of characters that comprises a diverse array of beliefs and perspectives, reflecting the historical realities of seventeenth-century Spain. Within its absorbing re-creation of the world during Cervantes\' time, this parody of chivalric romances and epic of heroic idealism forms a strikingly contemporary narrative. The author is often credited with inventing the concept of the novel, addressing himself to the readers rather than the characters or the action. This edition of his landmark work presents the acclaimed 1755 Tobias Smollett translation.', 'Don Quixote', 'MEDIA'),
	(24, '     A thrilling history of the Queen City of the West during the Civil War.\r\nThe Man Who Saved Cincinnati...\r\nRescued the Queen City from a Confederate attack;\r\nFormed the first Black Brigade in the Union Army;\r\nSaved Washington, DC;\r\nCaptured Billy the Kid and stopped a bloody range war;\r\nWrote one of the greatest books in American literature, Ben-Hur.\r\nAlso: The secret plot to assassinate Abraham Lincoln in Cincinnati;\r\nPanic and threats from Morgan\'s Raiders;\r\nHow the scapegoat of Shiloh became the Savior of Cincinnati.  ', 'The Man Who Saved Cincinnati', 'MEDIA'),
	(39, 'The Hobbit is set in Middle-earth and follows home-loving Bilbo Baggins, the hobbit of the title, who joins the wizard Gandalf and the thirteen dwarves of Thorin\'s Company, on a quest to reclaim the dwarves\' home and treasure from the dragon Smaug.', 'The Hobbit', 'MEDIA');

-- Dumping structure for table librarydb.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.category: ~27 rows (approximately)
DELETE FROM `category`;
INSERT INTO `category` (`id`, `name`) VALUES
	(28, 'Horror'),
	(29, 'Fantasy'),
	(30, 'Mystery'),
	(31, 'Science Fiction'),
	(32, 'Historical Fiction'),
	(33, 'Romance'),
	(34, 'Thriller'),
	(35, 'Literary Fiction'),
	(36, 'Young Adult'),
	(37, 'Adventure'),
	(38, 'Biography'),
	(39, 'Comics'),
	(40, 'Memoir'),
	(41, 'Contemporary'),
	(42, 'Dystopian'),
	(43, 'Women\'s Fiction'),
	(44, 'Short Story'),
	(45, 'Classics'),
	(46, 'History'),
	(47, 'LGBTQ'),
	(48, 'Religion'),
	(49, 'Cookbook'),
	(50, 'Humor'),
	(51, 'Paranormal'),
	(52, 'Child Friendly'),
	(53, 'Early Child Development Friendly'),
	(54, 'Teenager Friendly');

-- Dumping structure for table librarydb.instrument
DROP TABLE IF EXISTS `instrument`;
CREATE TABLE IF NOT EXISTS `instrument` (
  `name` varchar(255) NOT NULL,
  `manufacturer` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `dimensions` varchar(255) DEFAULT NULL,
  `weightInPounds` varchar(255) DEFAULT NULL,
  `baseRentalItemId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  PRIMARY KEY (`baseRentalItemId`),
  KEY `instrument_instrumentType_FK` (`typeId`),
  CONSTRAINT `instrument_instrumentType_FK` FOREIGN KEY (`typeId`) REFERENCES `instrumenttype` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `instrument_rentalItem_FK` FOREIGN KEY (`baseRentalItemId`) REFERENCES `baserentalitem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.instrument: ~0 rows (approximately)
DELETE FROM `instrument`;

-- Dumping structure for table librarydb.instrumenttype
DROP TABLE IF EXISTS `instrumenttype`;
CREATE TABLE IF NOT EXISTS `instrumenttype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.instrumenttype: ~5 rows (approximately)
DELETE FROM `instrumenttype`;
INSERT INTO `instrumenttype` (`id`, `name`) VALUES
	(1, 'woodwind'),
	(2, 'brass'),
	(3, 'stringed'),
	(4, 'percussion'),
	(5, 'electronic');

-- Dumping structure for table librarydb.libraryuser
DROP TABLE IF EXISTS `libraryuser`;
CREATE TABLE IF NOT EXISTS `libraryuser` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The user''s system ID auto-generated by the database. ',
  `Name` varchar(255) NOT NULL COMMENT 'The user''s full name stored in one column',
  `PhoneNumber` varchar(20) NOT NULL COMMENT 'The user''s phone number',
  `Email` varchar(255) NOT NULL COMMENT 'The user''s email address, that will also be used for log in ',
  `PasswordHash` varchar(255) NOT NULL COMMENT 'The hashed value of the user''s password',
  `DateOfBirth` date NOT NULL COMMENT 'The user''s date of birth',
  `UserRoleId` int(11) NOT NULL COMMENT 'The user may only have one user role',
  PRIMARY KEY (`UserId`),
  UNIQUE KEY `Email` (`Email`),
  KEY `UserRoleId` (`UserRoleId`),
  CONSTRAINT `libraryuser_ibfk_1` FOREIGN KEY (`UserRoleId`) REFERENCES `userrole` (`RoleId`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.libraryuser: ~10 rows (approximately)
DELETE FROM `libraryuser`;
INSERT INTO `libraryuser` (`UserId`, `Name`, `PhoneNumber`, `Email`, `PasswordHash`, `DateOfBirth`, `UserRoleId`) VALUES
	(1, 'admin', '111-222-3333', 'admin@admin.com', '$2a$12$PbFqKsS1gGmPuMHPus6jIOst0RpmOTkji8s2tAyxUyGglh7tMu3Ny', '1990-01-01', 3),
	(2, 'staff', '123-456-7890', 'staff@staff.com', '$2a$12$XZt.7XHQtwJ4MwpmGPbAOucT7AjDgRF63E4JzGlLoUNSpLEFSfihS', '1995-05-05', 2),
	(3, 'member', '987-654-3210', 'member@member.com', '$2a$12$AQ6qrVf0HPFdL.9hsLVkAOrnu4kr/2CIuE5i..zdmGkUbR7SghR5e', '2000-10-10', 1),
	(4, 'Kris', '111-222-3333', 'kris@kris.com', '$2b$10$GOqfDR3Ke3GJIA2hErzLruBdyAIr/DVVULtJHDh7vy56VKmfnYCKi', '1990-05-05', 1),
	(5, 'William Applegate', '15026485380', 'w.applegate@ymail.com', '$2b$10$w5XjP2fmf9iYUl8.6fUToOwVB8/.icMDT3/O6JEode94.PqNtDleq', '1190-05-05', 1),
	(7, 'William Applegate', '5026485380', 'apples@apples.com', '$2b$10$ymiZs0bC3WtjIK/rB5HEsuUIQJD3pXA63/PUvdRnKVKrmU.UVj9c2', '2024-02-25', 1),
	(8, 'John', '5026485380', 'wikapple@gmail.com', '$2b$10$NRqBU4q76b2lnoNOZV0VYe41XmggTTKd/EZ/vX6slKwCgcr6P7LEO', '2024-02-26', 1),
	(9, 'Kyle', '1234132451232', 'wefa@eafa.com', '$2b$10$L8dQN.dOrWLv5Yvvag3ef.nnrCpft8cVEqEAdfGS6ynkdEVJ4ecgi', '2024-02-26', 1),
	(10, 'Matt', '123-456-1234', 'matt@matthew.com', '$2b$10$olKlcya6kiYEbjAD.bd1E.zlcDolOddK.rqIHdZwoOr87KjlY3mT6', '2024-02-26', 1),
	(12, 'William Applegate', '502-648-5380', 'wikapple@iu.edu', '$2b$10$h2G81ek0A.ydC9WPYT2mNOjhEOyr4JnVxjq8csq6xk1hQyP3GBG4a', '1990-05-05', 1);

-- Dumping structure for table librarydb.media
DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `uniqueIdentifier` varchar(255) DEFAULT NULL,
  `publisher` varchar(255) NOT NULL,
  `isChildSafe` bit(1) NOT NULL DEFAULT b'0',
  `baseRentalItemId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `pageCountOrSize` int(11) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`baseRentalItemId`),
  KEY `media_mediaType_FK` (`typeId`),
  CONSTRAINT `media_baseRentalItem_FK` FOREIGN KEY (`baseRentalItemId`) REFERENCES `baserentalitem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_mediaType_FK` FOREIGN KEY (`typeId`) REFERENCES `mediatype` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.media: ~7 rows (approximately)
DELETE FROM `media`;
INSERT INTO `media` (`uniqueIdentifier`, `publisher`, `isChildSafe`, `baseRentalItemId`, `typeId`, `pageCountOrSize`, `author`) VALUES
	('9780194789431', 'Random House', b'0', 8, 1, 417, 'Bram Stoker'),
	('978-1338596700', 'Scholastic Inc.', b'1', 9, 1, 368, 'J.K. Rowling'),
	('978-1400079988', 'Vintage', b'1', 10, 1, 1296, 'Leo Tolstoy'),
	('978-1338864328', 'Scholastic Inc.', b'1', 11, 1, 160, 'Dav Pilkey'),
	('978-0486821955', 'Dover Publications', b'1', 12, 1, 992, 'Miguel de Cervantes'),
	('979-8988581710', 'Chilidog Press LLC', b'1', 24, 1, 294, 'Peter Bronson'),
	('978-026110334', 'Harper Collins', b'1', 39, 1, 288, 'J.R.R. Tolkien');

-- Dumping structure for table librarydb.mediacategories
DROP TABLE IF EXISTS `mediacategories`;
CREATE TABLE IF NOT EXISTS `mediacategories` (
  `mediaId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  PRIMARY KEY (`mediaId`,`categoryId`),
  KEY `categoryFK` (`categoryId`),
  CONSTRAINT `categoryFK` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mediaFK` FOREIGN KEY (`mediaId`) REFERENCES `media` (`baseRentalItemId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.mediacategories: ~27 rows (approximately)
DELETE FROM `mediacategories`;
INSERT INTO `mediacategories` (`mediaId`, `categoryId`) VALUES
	(8, 28),
	(9, 29),
	(12, 29),
	(39, 29),
	(10, 32),
	(10, 33),
	(8, 34),
	(9, 37),
	(39, 37),
	(24, 38),
	(11, 44),
	(12, 44),
	(8, 45),
	(10, 45),
	(12, 45),
	(24, 46),
	(11, 50),
	(12, 50),
	(9, 52),
	(11, 52),
	(12, 52),
	(11, 53),
	(9, 54),
	(12, 54);

-- Dumping structure for table librarydb.mediatype
DROP TABLE IF EXISTS `mediatype`;
CREATE TABLE IF NOT EXISTS `mediatype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.mediatype: ~10 rows (approximately)
DELETE FROM `mediatype`;
INSERT INTO `mediatype` (`id`, `name`) VALUES
	(1, 'book'),
	(2, 'dvd'),
	(3, 'cd'),
	(4, 'vhs'),
	(5, 'newspaper'),
	(6, 'magazine'),
	(7, 'journal'),
	(8, 'cassette'),
	(9, 'vinyl'),
	(10, 'diskette');

-- Dumping structure for table librarydb.rentalitemcopy
DROP TABLE IF EXISTS `rentalitemcopy`;
CREATE TABLE IF NOT EXISTS `rentalitemcopy` (
  `itemCopyGuid` varchar(36) NOT NULL DEFAULT '',
  `copyCondition` varchar(50) NOT NULL,
  `isAvailable` bit(1) NOT NULL,
  `baseRentalItemId` int(11) NOT NULL,
  PRIMARY KEY (`itemCopyGuid`) USING BTREE,
  KEY `RentalItemCopy_BaseRentalItem_FK` (`baseRentalItemId`),
  CONSTRAINT `RentalItemCopy_BaseRentalItem_FK` FOREIGN KEY (`baseRentalItemId`) REFERENCES `baserentalitem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.rentalitemcopy: ~2 rows (approximately)
DELETE FROM `rentalitemcopy`;
INSERT INTO `rentalitemcopy` (`itemCopyGuid`, `copyCondition`, `isAvailable`, `baseRentalItemId`) VALUES
	('18fa80d0-ce73-431e-a1fb-b52897245885', 'new', b'1', 8),
	('484daa14-149b-4677-9f5a-efe4e0f2fd1d', 'New', b'1', 8),
	('73681d3c-65f5-413e-876e-e8a88ebe5a67', 'New', b'1', 8);

-- Dumping structure for table librarydb.userrole
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE IF NOT EXISTS `userrole` (
  `RoleId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The system ID of the given role. Auto-generated by the database',
  `Name` varchar(50) NOT NULL COMMENT 'The name of the user role',
  PRIMARY KEY (`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='The user roles that may be given to a user. Determines if a user is authorized to access certain content or perform certain actions.\r\n';

-- Dumping data for table librarydb.userrole: ~3 rows (approximately)
DELETE FROM `userrole`;
INSERT INTO `userrole` (`RoleId`, `Name`) VALUES
	(1, 'Member'),
	(2, 'StaffMember'),
	(3, 'Administrator');

-- Dumping structure for procedure librarydb.category_SelectAll
DROP PROCEDURE IF EXISTS `category_SelectAll`;
DELIMITER //
CREATE PROCEDURE `category_SelectAll`()
BEGIN
	SELECT *
	FROM category;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.category_SelectByMediaId
DROP PROCEDURE IF EXISTS `category_SelectByMediaId`;
DELIMITER //
CREATE PROCEDURE `category_SelectByMediaId`(
	IN `mediaId` int
)
BEGIN
	SELECT c.*
	FROM category c
	WHERE c.id IN (
		SELECT mc.categoryId
		FROM mediacategories mc 
		WHERE mc.mediaId = mediaId
	);
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.instrumentType_SelectAll
DROP PROCEDURE IF EXISTS `instrumentType_SelectAll`;
DELIMITER //
CREATE PROCEDURE `instrumentType_SelectAll`()
BEGIN
	SELECT *
	FROM InstrumentType;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.mediaType_SelectAll
DROP PROCEDURE IF EXISTS `mediaType_SelectAll`;
DELIMITER //
CREATE PROCEDURE `mediaType_SelectAll`()
BEGIN
	SELECT *
	FROM MediaType;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.media_DeleteById
DROP PROCEDURE IF EXISTS `media_DeleteById`;
DELIMITER //
CREATE PROCEDURE `media_DeleteById`(
	IN `idToDelete` int
)
BEGIN
	START TRANSACTION;

	DELETE 
	FROM mediacategories
	WHERE mediacategories.mediaId= idToDelete;

	DELETE
	FROM media
	WHERE media.baseRentalItemId = idToDelete;
	
	DELETE 
	FROM BaseRentalItem
	WHERE baserentalitem.id = idToDelete;
	
	COMMIT;
	ROLLBACK;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.media_Filter
DROP PROCEDURE IF EXISTS `media_Filter`;
DELIMITER //
CREATE PROCEDURE `media_Filter`(
	IN `typeIdInput` INT,
	IN `filterValue` VARCHAR(255)
)
BEGIN
	SELECT i.id, i.description, mt.name AS type, m.uniqueIdentifier, m.author, i.name, m.publisher, m.isChildSafe, m.pageCountOrSize   
	FROM media m
	INNER JOIN BaseRentalItem i
	ON m.baseRentalItemId = i.id
	INNER JOIN MediaType mt
	ON m.typeId = mt.Id
	WHERE 
		m.typeId = typeIdInput 
		AND 
		(
			m.uniqueIdentifier LIKE CONCAT('%',filterValue,'%')
			OR m.publisher LIKE CONCAT('%',filterValue,'%')
			OR m.author LIKE CONCAT('%',filterValue,'%')
			OR i.name LIKE CONCAT('%',filterValue,'%')
		);
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.media_Insert
DROP PROCEDURE IF EXISTS `media_Insert`;
DELIMITER //
CREATE PROCEDURE `media_Insert`(
	IN `uniqueIdentifierInput` VARCHAR(255),
	IN `nameInput` VARCHAR(255),
	IN `descriptionInput` TEXT,
	IN `publisherInput` VARCHAR(255),
	IN `isChildSafeInput` BIT,
	IN `typeInput` INT,
	IN `sizeInput` INT,
	IN `categoryIdsInput` VARCHAR(255),
	IN `authorInput` VARCHAR(255)
)
BEGIN
	DECLARE lastInsertId INT;
	
	START TRANSACTION;

	INSERT INTO BaseRentalItem (NAME, DESCRIPTION, ITEMTYPE)
	VALUES (nameInput, descriptionInput, 'MEDIA');
	
	SET lastInsertId = LAST_INSERT_ID();
	
	INSERT INTO media (baseRentalItemId, uniqueIdentifier, publisher, isChildSafe, typeId, author, pageCountOrSize)
	VALUES (lastInsertId, uniqueIdentifierInput, publisherInput, isChildSafeInput, typeInput, authorInput, sizeInput);
	
	INSERT INTO mediacategories (mediaId, categoryId)
	SELECT lastInsertId, id
	FROM Category
	WHERE FIND_IN_SET(id, categoryIdsInput);
	
	COMMIT;
	ROLLBACK;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.media_SelectAll
DROP PROCEDURE IF EXISTS `media_SelectAll`;
DELIMITER //
CREATE PROCEDURE `media_SelectAll`()
BEGIN
	SELECT i.id, i.description, mt.name AS type, m.uniqueIdentifier, m.author, i.name, m.publisher, m.isChildSafe, m.pageCountOrSize  
	FROM media m
	INNER JOIN BaseRentalItem i
	ON m.baseRentalItemId = i.id
	INNER JOIN MediaType mt
	ON m.typeId = mt.Id;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.media_SelectById
DROP PROCEDURE IF EXISTS `media_SelectById`;
DELIMITER //
CREATE PROCEDURE `media_SelectById`(
	IN `idInput` int
)
BEGIN
	SELECT i.id, i.description, mt.name AS type, m.uniqueIdentifier, m.author, i.name, m.publisher, m.isChildSafe  , m.pageCountOrSize 
	FROM media m
	INNER JOIN BaseRentalItem i
	ON m.baseRentalItemId = i.id
	INNER JOIN MediaType mt
	ON m.typeId = mt.Id
	WHERE m.baseRentalItemId = idInput;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.media_SelectByType
DROP PROCEDURE IF EXISTS `media_SelectByType`;
DELIMITER //
CREATE PROCEDURE `media_SelectByType`(
	IN `typeIdInput` int
)
BEGIN
	SELECT i.id, i.description, mt.name AS type, m.uniqueIdentifier, m.author, i.name, m.publisher, m.isChildSafe, m.pageCountOrSize   
	FROM media m
	INNER JOIN BaseRentalItem i
	ON m.baseRentalItemId = i.id
	INNER JOIN MediaType mt
	ON m.typeId = mt.Id
	WHERE m.typeId = typeIdInput;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.media_UpdateById
DROP PROCEDURE IF EXISTS `media_UpdateById`;
DELIMITER //
CREATE PROCEDURE `media_UpdateById`(
	IN `idToUpdate` INT,
	IN `uniqueIdentifierToUpdate` VARCHAR(255),
	IN `nameToUpdate` VARCHAR(255),
	IN `descriptionToUpdate` TEXT,
	IN `publisherToUpdate` VARCHAR(255),
	IN `isChildSafeToUpdate` BIT,
	IN `typeToUpdate` INT,
	IN `categoryIdsToUpdate` VARCHAR(255),
	IN `authorToUpdate` VARCHAR(255),
	IN `pageCountOrSizeToUpdate` INT
)
BEGIN
	
	START TRANSACTION;
	
	UPDATE BaseRentalItem 
	SET 
		NAME = nameToUpdate,
		DESCRIPTION = descriptionToUpdate
	WHERE id = idToUpdate;

	UPDATE Media
	SET
		uniqueIdentifier = uniqueIdentifierToUpdate,
		publisher = publisherToUpdate,
		isChildSafe = isChildSafeToUpdate,
		typeId = typeToUpdate,
		author = authorToUpdate,
		pageCountOrSize = pageCountOrSizeToUpdate
	WHERE baseRentalItemId = idToUpdate;
	
	DELETE FROM MediaCategories
	WHERE mediaId = idToUpdate;
	
	INSERT INTO mediacategories (mediaId, categoryId)
	SELECT idToUpdate, id
	FROM Category
	WHERE FIND_IN_SET(id, categoryIdsToUpdate);
	
	COMMIT;
	ROLLBACK;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.rentalItemCopy_DeleteByItemCopyGuid
DROP PROCEDURE IF EXISTS `rentalItemCopy_DeleteByItemCopyGuid`;
DELIMITER //
CREATE PROCEDURE `rentalItemCopy_DeleteByItemCopyGuid`(
	IN `guidInput` VARCHAR(36)
)
BEGIN
DELETE FROM rentalItemCopy
WHERE copy.itemCopyGuid = guidInput;

END//
DELIMITER ;

-- Dumping structure for procedure librarydb.rentalItemCopy_Insert
DROP PROCEDURE IF EXISTS `rentalItemCopy_Insert`;
DELIMITER //
CREATE PROCEDURE `rentalItemCopy_Insert`(
	IN `guidInput` VARCHAR(36),
	IN `copyConditionInput` VARCHAR(50),
	IN `isAvailableInput` BIT,
	IN `baseRentalItemIdInput` INT
)
BEGIN
INSERT INTO rentalitemcopy (itemCopyGuid, copyCondition, isAvailable, baseRentalItemId)
VALUES (guidInput, copyConditionInput, isAvailableInput, baseRentalItemIdInput);
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.rentalItemCopy_SelectByBaseItemId
DROP PROCEDURE IF EXISTS `rentalItemCopy_SelectByBaseItemId`;
DELIMITER //
CREATE PROCEDURE `rentalItemCopy_SelectByBaseItemId`(
	IN `baseItemIdInput` INT
)
BEGIN
SELECT copy.itemCopyGuid, copy.copyCondition, copy.isAvailable, baseItem.name, baseItem.description, baseItem.itemType
FROM RentalItemCopy copy
INNER JOIN baserentalitem baseItem
ON copy.baseRentalItemId = baseItem.id
WHERE baseItem.id = baseItemIdInput;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.rentalItemCopy_SelectByItemCopyGuid
DROP PROCEDURE IF EXISTS `rentalItemCopy_SelectByItemCopyGuid`;
DELIMITER //
CREATE PROCEDURE `rentalItemCopy_SelectByItemCopyGuid`(
	IN `guidInput` VARCHAR(36)
)
BEGIN
SELECT copy.itemCopyGuid, copy.copyCondition, copy.isAvailable, baseItem.name, baseItem.description, baseItem.itemType, baseItem.id
FROM RentalItemCopy copy
INNER JOIN baserentalitem baseItem
ON copy.baseRentalItemId = baseItem.id
WHERE copy.itemCopyGuid = guidInput;

END//
DELIMITER ;

-- Dumping structure for procedure librarydb.rentalItemCopy_UpdateByRentalItemGuid
DROP PROCEDURE IF EXISTS `rentalItemCopy_UpdateByRentalItemGuid`;
DELIMITER //
CREATE PROCEDURE `rentalItemCopy_UpdateByRentalItemGuid`(
	IN `guidInput` VARCHAR(36),
	IN `copyConditionInput` VARCHAR(50),
	IN `isAvailableInput` BIT
)
BEGIN
UPDATE rentalItemCopy
SET
	copyCondition = copyConditionInput,
	isAvailable = isAvailableInput
WHERE itemCopyGuid = guidInput;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.role_SelectAll
DROP PROCEDURE IF EXISTS `role_SelectAll`;
DELIMITER //
CREATE PROCEDURE `role_SelectAll`()
SELECT RoleId, Name From UserRole//
DELIMITER ;

-- Dumping structure for procedure librarydb.user_DeleteById
DROP PROCEDURE IF EXISTS `user_DeleteById`;
DELIMITER //
CREATE PROCEDURE `user_DeleteById`(
	IN `idToDelete` INT
)
    COMMENT 'Deletes the user by their UserId'
BEGIN
	DELETE FROM librarydb.libraryuser
	WHERE UserId = idToDelete;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.user_Insert
DROP PROCEDURE IF EXISTS `user_Insert`;
DELIMITER //
CREATE PROCEDURE `user_Insert`(
	IN `nameInput` VARCHAR(255),
	IN `phoneNumberInput` VARCHAR(20),
	IN `emailInput` VARCHAR(255),
	IN `passwordHashInput` VARCHAR(255),
	IN `dobInput` DATE,
	OUT `IdOutput` INT
)
    COMMENT 'Inserts a user into the database with the default role of Member'
BEGIN
	SET @memberIdVar = (SELECT RoleId FROM userrole WHERE NAME LIKE 'Member' LIMIT 1);

	INSERT INTO librarydb.libraryuser (NAME, phoneNumber, email, passwordhash, dateofbirth, UserRoleId)
	VALUES(nameInput, phoneNumberInput, emailInput, passwordHashInput, dobInput, @memberIdVar);
	
	SET IdOutput = LAST_INSERT_ID();
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.user_SelectByEmail
DROP PROCEDURE IF EXISTS `user_SelectByEmail`;
DELIMITER //
CREATE PROCEDURE `user_SelectByEmail`(
	IN `emailInput` varchar(255)
)
SELECT u.UserId, u.Name, u.PhoneNumber, u.Email, u.PasswordHash, u.DateOfBirth, r.Name UserRole FROM libraryuser u INNER JOIN userrole r ON u.UserRoleId = r.RoleId WHERE u.email = emailInput//
DELIMITER ;

-- Dumping structure for procedure librarydb.user_SelectById
DROP PROCEDURE IF EXISTS `user_SelectById`;
DELIMITER //
CREATE PROCEDURE `user_SelectById`(
	IN `idInput` int
)
SELECT u.UserId, u.Name, u.PhoneNumber, u.Email, u.PasswordHash, u.DateOfBirth, r.Name UserRole FROM libraryuser u INNER JOIN userrole r ON u.UserRoleId = r.RoleId WHERE u.UserId = idInput//
DELIMITER ;

-- Dumping structure for procedure librarydb.user_UpdateById
DROP PROCEDURE IF EXISTS `user_UpdateById`;
DELIMITER //
CREATE PROCEDURE `user_UpdateById`(
	IN `IdInput` INT,
	IN `nameInput` VARCHAR(255),
	IN `phoneNumberInput` VARCHAR(20),
	IN `emailInput` VARCHAR(255),
	IN `passwordHashInput` VARCHAR(255),
	IN `dobInput` DATE,
	IN `UserRoleIdInput` INT
)
BEGIN
	UPDATE librarydb.libraryuser u
	SET
		u.Name = nameInput,
		u.PhoneNumber = phoneNumberInput,
		u.Email = emailInput,
		u.PasswordHash = passwordHashInput,
		u.DateOfBirth = dobInput,
		u.UserRoleId = UserRoleIdInput
	WHERE 
		u.UserId = idInput;
END//
DELIMITER ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
