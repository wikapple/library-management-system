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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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

-- Dumping structure for table librarydb.employeeaccount
DROP TABLE IF EXISTS `employeeaccount`;
CREATE TABLE IF NOT EXISTS `employeeaccount` (
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `EmployeeAccount_LibraryUser_FK` FOREIGN KEY (`userId`) REFERENCES `libraryuser` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.employeeaccount: ~2 rows (approximately)
DELETE FROM `employeeaccount`;
INSERT INTO `employeeaccount` (`userId`) VALUES
	(1),
	(2);

-- Dumping structure for table librarydb.instrument
DROP TABLE IF EXISTS `instrument`;
CREATE TABLE IF NOT EXISTS `instrument` (
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
  `userId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The user''s system ID auto-generated by the database. ',
  `name` varchar(255) NOT NULL COMMENT 'The user''s full name stored in one column',
  `phoneNumber` varchar(20) NOT NULL COMMENT 'The user''s phone number',
  `email` varchar(255) NOT NULL COMMENT 'The user''s email address, that will also be used for log in ',
  `passwordHash` varchar(255) NOT NULL COMMENT 'The hashed value of the user''s password',
  `dateOfBirth` date NOT NULL COMMENT 'The user''s date of birth',
  `userRoleId` int(11) NOT NULL COMMENT 'The user may only have one user role',
  PRIMARY KEY (`userId`) USING BTREE,
  UNIQUE KEY `Email` (`email`) USING BTREE,
  KEY `UserRoleId` (`userRoleId`) USING BTREE,
  CONSTRAINT `libraryuser_ibfk_1` FOREIGN KEY (`userRoleId`) REFERENCES `userrole` (`roleId`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.libraryuser: ~12 rows (approximately)
DELETE FROM `libraryuser`;
INSERT INTO `libraryuser` (`userId`, `name`, `phoneNumber`, `email`, `passwordHash`, `dateOfBirth`, `userRoleId`) VALUES
	(1, 'admin', '111-222-3333', 'admin@admin.com', '$2a$12$PbFqKsS1gGmPuMHPus6jIOst0RpmOTkji8s2tAyxUyGglh7tMu3Ny', '1990-01-01', 3),
	(2, 'staff', '123-456-7890', 'staff@staff.com', '$2a$12$XZt.7XHQtwJ4MwpmGPbAOucT7AjDgRF63E4JzGlLoUNSpLEFSfihS', '1995-05-05', 2),
	(3, 'member', '987-654-3210', 'member@member.com', '$2a$12$AQ6qrVf0HPFdL.9hsLVkAOrnu4kr/2CIuE5i..zdmGkUbR7SghR5e', '2000-10-10', 1),
	(4, 'Kris', '111-222-3333', 'kris@kris.com', '$2b$10$GOqfDR3Ke3GJIA2hErzLruBdyAIr/DVVULtJHDh7vy56VKmfnYCKi', '1990-05-05', 1),
	(5, 'William Applegate', '15026485380', 'w.applegate@ymail.com', '$2b$10$w5XjP2fmf9iYUl8.6fUToOwVB8/.icMDT3/O6JEode94.PqNtDleq', '1190-05-05', 1),
	(7, 'William Applegate', '5026485380', 'apples@apples.com', '$2b$10$ymiZs0bC3WtjIK/rB5HEsuUIQJD3pXA63/PUvdRnKVKrmU.UVj9c2', '2024-02-25', 1),
	(8, 'John', '5026485380', 'wikapple@gmail.com', '$2b$10$NRqBU4q76b2lnoNOZV0VYe41XmggTTKd/EZ/vX6slKwCgcr6P7LEO', '2024-02-26', 1),
	(9, 'Kyle', '1234132451232', 'wefa@eafa.com', '$2b$10$L8dQN.dOrWLv5Yvvag3ef.nnrCpft8cVEqEAdfGS6ynkdEVJ4ecgi', '2024-02-26', 1),
	(10, 'Matt', '123-456-1234', 'matt@matthew.com', '$2b$10$olKlcya6kiYEbjAD.bd1E.zlcDolOddK.rqIHdZwoOr87KjlY3mT6', '2024-02-26', 1),
	(12, 'William Applegate', '502-648-5380', 'wikapple@iu.edu', '$2b$10$h2G81ek0A.ydC9WPYT2mNOjhEOyr4JnVxjq8csq6xk1hQyP3GBG4a', '1990-05-05', 1),
	(15, 'John Doe', '111-222-3333', 'john@doe.com', '$2b$10$FgZathCO1yJpDlzXJ/EbqeWhOFXiev5iE8RV4vi1TlCG9YC1IeYju', '1990-01-01', 1),
	(16, 'Mary Member', '987-654-3210', 'mary@member.com', '$2b$10$02kOSB0AsqmnX7j457TaOO0UvhoMzkZbUwyN5n6fXHm9..NEoBUQK', '2000-01-01', 1);

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

-- Dumping data for table librarydb.mediacategories: ~24 rows (approximately)
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

-- Dumping structure for table librarydb.memberaccount
DROP TABLE IF EXISTS `memberaccount`;
CREATE TABLE IF NOT EXISTS `memberaccount` (
  `userId` int(11) NOT NULL,
  `balance` decimal(20,2) NOT NULL DEFAULT 0.00,
  `isFrozen` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`userId`),
  CONSTRAINT `MemberAccount_LibraryUser_FK` FOREIGN KEY (`userId`) REFERENCES `libraryuser` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.memberaccount: ~10 rows (approximately)
DELETE FROM `memberaccount`;
INSERT INTO `memberaccount` (`userId`, `balance`, `isFrozen`) VALUES
	(3, -2.00, b'1'),
	(4, 0.00, b'0'),
	(5, -2.00, b'1'),
	(7, 0.00, b'0'),
	(8, 0.00, b'0'),
	(9, 0.00, b'0'),
	(10, -1.00, b'1'),
	(12, 0.00, b'0'),
	(15, 0.00, b'0'),
	(16, 0.00, b'0');

-- Dumping structure for table librarydb.rentalagreement
DROP TABLE IF EXISTS `rentalagreement`;
CREATE TABLE IF NOT EXISTS `rentalagreement` (
  `transactionId` int(11) NOT NULL AUTO_INCREMENT,
  `checkoutDate` date NOT NULL,
  `checkinDueDate` date NOT NULL,
  `rentalItemId` varchar(36) NOT NULL,
  `borrowerId` int(11) NOT NULL,
  `checkoutApprovedBy` int(11) NOT NULL,
  `checkinApprovedBy` int(11) DEFAULT NULL,
  `actualCheckinDate` date DEFAULT NULL,
  `lastUpdatedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`transactionId`),
  KEY `RentalAgreement_Member_FK` (`borrowerId`),
  KEY `RentalAgreement_EmployeeCheckout_FK` (`checkoutApprovedBy`),
  KEY `RentalAgreement_EmployeeCheckin_FK` (`checkinApprovedBy`),
  KEY `RentalAgreement_EmployeeLastUpdated_FK` (`lastUpdatedBy`),
  CONSTRAINT `RentalAgreement_EmployeeCheckin_FK` FOREIGN KEY (`checkinApprovedBy`) REFERENCES `employeeaccount` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `RentalAgreement_EmployeeCheckout_FK` FOREIGN KEY (`checkoutApprovedBy`) REFERENCES `employeeaccount` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `RentalAgreement_EmployeeLastUpdated_FK` FOREIGN KEY (`lastUpdatedBy`) REFERENCES `employeeaccount` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `RentalAgreement_Member_FK` FOREIGN KEY (`borrowerId`) REFERENCES `memberaccount` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.rentalagreement: ~0 rows (approximately)
DELETE FROM `rentalagreement`;
INSERT INTO `rentalagreement` (`transactionId`, `checkoutDate`, `checkinDueDate`, `rentalItemId`, `borrowerId`, `checkoutApprovedBy`, `checkinApprovedBy`, `actualCheckinDate`, `lastUpdatedBy`) VALUES
	(12, '2024-04-20', '2024-05-21', 'a977e95c-4328-4b5e-b715-fdd93b84135e', 16, 1, 1, '2024-04-20', 1),
	(13, '2024-04-20', '2024-05-04', 'f41fc0e2-8734-4900-a450-ff1c3ae9e5d5', 16, 1, 1, '2024-04-20', 1);

-- Dumping structure for table librarydb.rentalitem
DROP TABLE IF EXISTS `rentalitem`;
CREATE TABLE IF NOT EXISTS `rentalitem` (
  `rentalItemGuid` varchar(36) NOT NULL DEFAULT '',
  `itemCondition` varchar(50) NOT NULL,
  `isOnHold` bit(1) NOT NULL,
  `baseRentalItemId` int(11) NOT NULL,
  PRIMARY KEY (`rentalItemGuid`) USING BTREE,
  KEY `RentalItemCopy_BaseRentalItem_FK` (`baseRentalItemId`),
  CONSTRAINT `RentalItemCopy_BaseRentalItem_FK` FOREIGN KEY (`baseRentalItemId`) REFERENCES `baserentalitem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.rentalitem: ~14 rows (approximately)
DELETE FROM `rentalitem`;
INSERT INTO `rentalitem` (`rentalItemGuid`, `itemCondition`, `isOnHold`, `baseRentalItemId`) VALUES
	('06b9bb1b-a57e-4dd2-b27a-14a719dbecee', 'Good', b'0', 9),
	('07211d07-cc27-438b-abf7-608cee23a2fd', 'New', b'0', 24),
	('181a261b-b591-4866-8d3c-c904df3fd67c', 'New', b'0', 9),
	('18fa80d0-ce73-431e-a1fb-b52897245885', 'new', b'0', 8),
	('3339b5ea-b6bb-49e4-bad1-8c222b6d7a92', 'Fair', b'1', 24),
	('484daa14-149b-4677-9f5a-efe4e0f2fd1d', 'New', b'0', 8),
	('4e06d263-86d7-4edb-96d2-167287b60151', 'Fair', b'0', 9),
	('73681d3c-65f5-413e-876e-e8a88ebe5a67', 'New', b'0', 8),
	('8fe8174f-537a-445b-9646-0cb71903aeb8', 'Fair', b'0', 11),
	('a977e95c-4328-4b5e-b715-fdd93b84135e', 'New', b'0', 12),
	('b99f4ad1-8ee9-4b3b-82d2-72a2219f3f17', 'Good', b'0', 9),
	('db3dd69e-836b-494a-9a4b-3593d7531b69', 'Fair', b'0', 10),
	('f41fc0e2-8734-4900-a450-ff1c3ae9e5d5', 'Good', b'0', 39);

-- Dumping structure for table librarydb.userrole
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE IF NOT EXISTS `userrole` (
  `roleId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The system ID of the given role. Auto-generated by the database',
  `name` varchar(50) NOT NULL COMMENT 'The name of the user role',
  PRIMARY KEY (`roleId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='The user roles that may be given to a user. Determines if a user is authorized to access certain content or perform certain actions.\r\n';

-- Dumping data for table librarydb.userrole: ~3 rows (approximately)
DELETE FROM `userrole`;
INSERT INTO `userrole` (`roleId`, `name`) VALUES
	(1, 'Member'),
	(2, 'StaffMember'),
	(3, 'Administrator');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
