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

-- Dumping structure for table librarydb.book
DROP TABLE IF EXISTS `book`;
CREATE TABLE IF NOT EXISTS `book` (
  `mediaId` int(11) NOT NULL,
  `ISBN` varchar(20) NOT NULL,
  `pageCount` int(11) NOT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `author` varchar(255) NOT NULL,
  PRIMARY KEY (`mediaId`),
  CONSTRAINT `Book_MediaFK` FOREIGN KEY (`mediaId`) REFERENCES `media` (`mediaId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.book: ~7 rows (approximately)
DELETE FROM `book`;
INSERT INTO `book` (`mediaId`, `ISBN`, `pageCount`, `publisher`, `author`) VALUES
	(8, '9780194789431', 417, 'Random House', 'Bram Stoker'),
	(9, '9788408061052', 545, 'P F Collier & Son Company', 'Miguel De Cervantes'),
	(10, '9781350116788', 136, 'D. Appleton & CO.', 'Henrik Ibsen'),
	(11, '9788412664812', 1225, 'Dana Estes & Company', 'Leo Tolstoy'),
	(12, '9780316017749', 448, 'Little, Brown and Company', 'James Patterson'),
	(13, '9781501180989', 576, 'Scribner', 'Stephen King'),
	(14, '9780590353403', 309, 'Scholastic Press', 'J.K. Rowling');

-- Dumping structure for procedure librarydb.book_Insert
DROP PROCEDURE IF EXISTS `book_Insert`;
DELIMITER //
CREATE PROCEDURE `book_Insert`(
	IN `title` VARCHAR(255),
	IN `description` VARCHAR(255),
	IN `ISBN` VARCHAR(20),
	IN `author` VARCHAR(255),
	IN `publisher` VARCHAR(255),
	IN `categoryIds` VARCHAR(255),
	IN `pageCount` INT
)
BEGIN
    DECLARE lastInsertId INT;
	
		START TRANSACTION;
    -- Insert into the media table
    INSERT INTO media (title, description)
    VALUES (title, description);

    -- Get the last inserted mediaId
    SET lastInsertId = LAST_INSERT_ID();
   
    -- Insert into the Book table
    INSERT INTO book (mediaId, ISBN, author, publisher, pageCount)
    VALUES (lastInsertId, ISBN, author, publisher, pageCount);

    -- Insert into the MediaCategories table
    INSERT INTO MediaCategories (mediaId, categoryId)
    SELECT lastInsertId, categoryId
    FROM Category
    WHERE FIND_IN_SET(categoryId, categoryIds);
   COMMIT;
   ROLLBACK;
END//
DELIMITER ;

-- Dumping structure for procedure librarydb.book_SelectAll
DROP PROCEDURE IF EXISTS `book_SelectAll`;
DELIMITER //
CREATE PROCEDURE `book_SelectAll`()
BEGIN
	SELECT m.*, b.ISBN, b.author, b.publisher, b.pageCount
	FROM book b
	INNER JOIN
	media m
	ON m.mediaId = b.mediaId;
END//
DELIMITER ;

-- Dumping structure for table librarydb.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `categoryId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.category: ~27 rows (approximately)
DELETE FROM `category`;
INSERT INTO `category` (`categoryId`, `name`) VALUES
	(1, 'Horror'),
	(2, 'Fantasy'),
	(3, 'Mystery'),
	(4, 'Science Fiction'),
	(5, 'Historical Fiction'),
	(6, 'Romance'),
	(7, 'Thriller'),
	(8, 'Literary Fiction'),
	(9, 'Young Adult'),
	(10, 'Adventure'),
	(11, 'Biography'),
	(12, 'Comics'),
	(13, 'Memoir'),
	(14, 'Contemporary'),
	(15, 'Dystopian'),
	(16, 'Women\'s Fiction'),
	(17, 'Short Story'),
	(18, 'Classics'),
	(19, 'History'),
	(20, 'LGBTQ'),
	(21, 'Religion'),
	(22, 'Cookbook'),
	(23, 'Humor'),
	(24, 'Paranormal'),
	(25, 'Child Friendly'),
	(26, 'Early Child Development Friendly'),
	(27, 'Teenager Friendly');

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
	WHERE c.categoryId IN (
		SELECT mc.categoryId
		FROM mediacategories mc 
		WHERE mc.mediaId = mediaId
	);
END//
DELIMITER ;

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
  KEY `UserRoleId` (`UserRoleId`),
  CONSTRAINT `libraryuser_ibfk_1` FOREIGN KEY (`UserRoleId`) REFERENCES `userrole` (`RoleId`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.libraryuser: ~5 rows (approximately)
DELETE FROM `libraryuser`;
INSERT INTO `libraryuser` (`UserId`, `Name`, `PhoneNumber`, `Email`, `PasswordHash`, `DateOfBirth`, `UserRoleId`) VALUES
	(1, 'admin', '111-222-3333', 'admin@admin.com', '$2a$12$PbFqKsS1gGmPuMHPus6jIOst0RpmOTkji8s2tAyxUyGglh7tMu3Ny', '1990-01-01', 3),
	(2, 'staff', '123-456-7890', 'staff@staff.com', '$2a$12$XZt.7XHQtwJ4MwpmGPbAOucT7AjDgRF63E4JzGlLoUNSpLEFSfihS', '1995-05-05', 2),
	(3, 'member', '987-654-3210', 'member@member.com', '$2a$12$AQ6qrVf0HPFdL.9hsLVkAOrnu4kr/2CIuE5i..zdmGkUbR7SghR5e', '2000-10-10', 1),
	(4, 'Kris', '111-222-3333', 'kris@kris.com', '$2b$10$GOqfDR3Ke3GJIA2hErzLruBdyAIr/DVVULtJHDh7vy56VKmfnYCKi', '1990-05-05', 1),
	(5, 'William Applegate', '15026485380', 'w.applegate@ymail.com', '$2b$10$w5XjP2fmf9iYUl8.6fUToOwVB8/.icMDT3/O6JEode94.PqNtDleq', '1190-05-05', 1);

-- Dumping structure for table librarydb.media
DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `mediaId` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`mediaId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.media: ~7 rows (approximately)
DELETE FROM `media`;
INSERT INTO `media` (`mediaId`, `title`, `description`) VALUES
	(8, 'Dracula', 'Dracula is a novel by Bram Stoker, published in 1897. An epistolary novel, the narrative is related through letters, diary entries, and newspaper articles. It has no single protagonist and opens with solicitor Jonathan Harker taking a business trip to sta'),
	(9, 'Don Quixote', 'Don Quixote is a Spanish epic novel by Miguel de Cervantes. It was originally published in two parts, in 1605 and 1615. Considered a founding work of Western literature, it is often labelled as the first modern novel and one of the greatest works ever wri'),
	(10, 'A Doll\'s House', 'A Doll\'s House is a three-act play written by Norwegian playwright Henrik Ibsen. It premiered at the Royal Theatre in Copenhagen, Denmark, on 21 December 1879, having been published earlier that month. The play is set in a Norwegian town circa 1879'),
	(11, 'War and Peace', 'War and Peace is a literary work by Russian author Leo Tolstoy. Set during the Napoleonic Wars, the work mixes fictional narrative with chapters discussing history and philosophy. First published serially beginning in 1865, the work was rewritten and publ'),
	(12, 'Cross', 'Cross is James Patterson\'s 12th novel featuring his most famous character, Alex Cross. It was released in 2006. This novel was also released in some markets under the title Alex Cross. This book is followed by Double Cross.'),
	(13, 'The Outsider', 'The Outsider is a horror novel by the American author Stephen King. The novel was published by Scribner.'),
	(14, 'Harry Potter And The Sorcerer\'s Stone', 'Adaptation of the first of J.K. Rowling\'s popular children\'s novels about Harry Potter, a boy who learns on his eleventh birthday that he is the orphaned son of two powerful wizards and possesses unique magical powers of his own.');

-- Dumping structure for table librarydb.mediacategories
DROP TABLE IF EXISTS `mediacategories`;
CREATE TABLE IF NOT EXISTS `mediacategories` (
  `categoryId` int(11) NOT NULL,
  `mediaId` int(11) NOT NULL,
  PRIMARY KEY (`categoryId`,`mediaId`),
  KEY `MediaCategory_MediaFK` (`mediaId`),
  CONSTRAINT `MediaCategory_CategoryFK` FOREIGN KEY (`categoryId`) REFERENCES `category` (`categoryId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MediaCategory_MediaFK` FOREIGN KEY (`mediaId`) REFERENCES `media` (`mediaId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table librarydb.mediacategories: ~22 rows (approximately)
DELETE FROM `mediacategories`;
INSERT INTO `mediacategories` (`categoryId`, `mediaId`) VALUES
	(1, 8),
	(2, 8),
	(18, 8),
	(10, 9),
	(18, 9),
	(23, 9),
	(18, 10),
	(5, 11),
	(6, 11),
	(18, 11),
	(3, 12),
	(7, 12),
	(14, 12),
	(1, 13),
	(3, 13),
	(7, 13),
	(2, 14),
	(7, 14),
	(9, 14),
	(10, 14),
	(25, 14),
	(27, 14);

-- Dumping structure for procedure librarydb.role_SelectAll
DROP PROCEDURE IF EXISTS `role_SelectAll`;
DELIMITER //
CREATE PROCEDURE `role_SelectAll`()
SELECT RoleId, Name From UserRole//
DELIMITER ;

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
