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

    async getRentalAgreementsByRentalItemId(rentalItemId) {
        try {
            const sqlQuery = `CALL rentalAgreement_SelectByRentalItemId(?)`;
            const result = await pool.query(sqlQuery, [rentalItemId]);
            let rentalAgreements = result[0];

            rentalAgreements.sort((a,b) => this._sortRentalAgreementsByDates(a,b));

            rentalAgreements = rentalAgreements.map(x =>{
                x.isPastDue = x.actualCheckinDate ?? new Date() > new Date(x.checkinDueDate);
                return x;
            });
            return rentalAgreements;
        }
        catch (err) {
            debug(err);
        }
    }

    async getRentalAgreementByTransactionId(transactionId) {
        try {
            const sqlQuery = `CALL rentalAgreement_SelectByTransactionId(?)`;
            const result = await pool.query(sqlQuery, [transactionId]);
            let rentalAgreement = result[0][0];

            if(rentalAgreement) {
                rentalAgreement.isPastDue = rentalAgreement.actualCheckinDate ?? new Date() > new Date(rentalAgreement.checkinDueDate);
            } 

            return rentalAgreement;
        }
        catch (err) {
            debug(err);
        }
    }

    async checkin(transactionId, returnDate, approvedByEmployeeId) {
        try {
            const sqlQuery = `CALL rentalAgreement_CheckinByTransactionId(?, ?, ?, @IsSuccessful); select @IsSuccessful;`;
            const result = await pool.query(sqlQuery, [transactionId, returnDate, approvedByEmployeeId]);
            return result[1][0]['@IsSuccessful'];
        }
        catch (err) {
            debug(err);
        }
    }

    _sortRentalAgreementsByDates(a,b) {
        try {
        if (a.actualCheckinDate == null && b.actualCheckinDate != null) { return -1;}
        if (b.actualCheckinDate == null && a.actualCheckinDate != null) { return 1;}

        if (a.actualCheckinDate > b.actualCheckinDate) {return -1;}
        if (a.actualCheckinDate < b.actualCheckinDate) {return -1;}

        if (a.checkinDueDate > b.checkinDueDate) {return -1;}
        if (a.checkinDueDate < b.checkinDueDate) {return -1;}

        if (a.checkoutDate > b.checkoutDate) {return -1;}
        if (a.checkoutDate < b.checoutDate) {return -1;}

        return 0;
        }
        catch(err) {
            debug(`Error sorting rental agreements 'a' and 'b'. a='${a}', b='${b}'. Error: ${err}`);
        }
    }

    async getRentalAgreementsByBorrowerId(borrowerId) {
        try {
            const sqlQuery = `CALL rentalAgreement_SelectByBorrowerId(?)`;
            const result = await pool.query(sqlQuery, [borrowerId]);
            const rentalAgreements = result[0];
            return rentalAgreements;
        }
        catch (err) {
            debug(err);
        }
    }

    async getOverdueRentals() {
        try {
            const sqlQuery = `CALL rentalAgreement_SelectCurrentOverdue()`;
            const result = await pool.query(sqlQuery, []);
            let rentalAgreements = result[0];

            rentalAgreements.sort((a,b) => a.borrowerId < b.borrowerId ? 1 : -1);

            rentalAgreements = rentalAgreements.map(x =>{
                x.isPastDue = x.actualCheckinDate ?? new Date() > new Date(x.checkinDueDate);
                return x;
            });
            return rentalAgreements;
        }
        catch (err) {
            debug(err);
        }
    }
}

module.exports = RentalAgreementDataAccess;