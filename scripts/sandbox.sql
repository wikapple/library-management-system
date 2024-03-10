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



DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `memberAccount_SelectAll`()
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Selects all members'
BEGIN
    SELECT lu.userId, lu.name, lu.phoneNumber, lu.email, ma.balance, ma.isFrozen
    FROM libraryuser lu
    INNER JOIN
    MemberAccount ma
    ON lu.userId = ma.userId
END //
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `memberAccount_filter`(
    IN `filterValue` VARCHAR(255)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Selects all members that match filter value'
BEGIN
    SELECT lu.userId, lu.name, lu.phoneNumber, lu.email, ma.balance, ma.isFrozen
    FROM libraryuser lu
    INNER JOIN
    MemberAccount ma
    ON lu.userId = ma.userId
    WHERE
        lu.name LIKE CONCAT('%',filterValue,'%')
        OR lu.phoneNumber LIKE CONCAT('%',filterValue,'%')
        OR lu.email LIKE CONCAT('%',filterValue,'%');

END //
DELIMITER ;


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `memberAccount_SelectByUserId`(
    IN `userIdInput` int
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Selects a member by their user ID'
BEGIN
    SELECT lu.userId, lu.name, lu.phoneNumber, lu.email, ma.balance, ma.isFrozen
    FROM libraryuser lu
    INNER JOIN
    MemberAccount ma
    ON lu.userId = ma.userId
    WHERE
        lu.userId = userIdInput;

END //
DELIMITER ;

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `rentalItem_Filter`(
    IN `filterValue` VARCHAR(36)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Selects all rental items that have an ID containing the filter value'
BEGIN
    SELECT item.rentalItemGuid, item.itemCondition, item.isAvailable, baseItem.name, baseItem.description, baseItem.itemType, baseItem.id
    FROM RentalItem item
    INNER JOIN baserentalitem baseItem
ON item.baseRentalItemId = baseItem.id
    WHERE
        item.rentalItemGuid LIKE CONCAT('%',filterValue,'%');
END //
DELIMITER ;