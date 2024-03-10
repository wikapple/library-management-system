const pool = require('../config/database');
const debug = require('debug')('app:rentalAgreementDataAccess');
const chalk = require('chalk');

class RentalAgreementDataAccess {

    async insertRentalAgreement(rentalAgreement) {
        try{
            const {checkoutDate, checkinDueDate, rentalItemId, borrowerId, checkoutApprovedBy} = rentalAgreement;

            const sqlQuery = `CALL rentalAgreement_Insert(?, ?, ?, ?, ?, @IsSuccessful); select @IsSuccessful;`;
            const result = await pool.query(sqlQuery, [checkoutDate, checkinDueDate, rentalItemId, borrowerId, checkoutApprovedBy]);
            return result[1][0]['@IsSuccessful'];
        }
        catch (err) {
            debug(err);
            return false;
        }
    }
}

module.exports = RentalAgreementDataAccess;