-- Don't pay attention to this file.. I'm only testing out my scripts here.


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `memberAccount_Insert`(
	IN `nameInput` VARCHAR(255),
	IN `phoneNumberInput` VARCHAR(20),
	IN `emailInput` VARCHAR(255),
	IN `passwordHashInput` VARCHAR(255),
	IN `dobInput` DATE,
	OUT `IdOutput` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Inserts a user into the database with the default role of Member and created a member account'
BEGIN
	START TRANSACTION;
	  SET @memberIdVar = (SELECT roleId FROM userrole WHERE NAME LIKE 'Member' LIMIT 1);

	  INSERT INTO librarydb.libraryuser (NAME, phoneNumber, email, passwordhash, dateofbirth, userRoleId)
	  VALUES(nameInput, phoneNumberInput, emailInput, passwordHashInput, dobInput, @memberIdVar);
	
	  SET IdOutput = LAST_INSERT_ID();
	
	  INSERT INTO librarydb.memberaccount (userId)
	  VALUES (IdOutput);
	COMMIT;
	ROLLBACK;
END //
DELIMITER ;