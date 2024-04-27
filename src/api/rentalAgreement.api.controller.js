const chalk = require('chalk');
const debug = require('debug')('app:rentalAgreementApiController');
const MemberDataAccess = require('../data/memberDataAccess');
const RentalAgreementDataAccess = require('../data/rentalAgreementDataAccess');
const ItemDataAccess = require('../data/itemDataAccess');

class RentalAgreementApiController {

    constructor() {
        this.memberDataAccess = new MemberDataAccess();
        this.rentalAgreementDataAccess = new RentalAgreementDataAccess();
        this.itemDataAccess = new ItemDataAccess();
    }

    async submitRentalAgreements(req, res) {
        const approvedByEmployeeId = req.user.userId;
        const { userId, checkoutDate, rentalAgreements } = req.body;

        const memberDetails = await this.memberDataAccess.getMemberById(userId);

        debug(memberDetails);
        if (memberDetails && memberDetails.isFrozen) {
            debug(memberDetails);
            res.status(400).json({error: 'Member account is frozen'});
            return;
        }

        let checkoutResults = [];

        for (let rentalAgreement of rentalAgreements) {
            try {

                const rentalItem = await this.itemDataAccess.getItemByGuid(rentalAgreement.rentalItemId);
                if (rentalItem.isCheckedOut) {
                    throw Error('rental item is already checked out.');
                }
                if (rentalItem.isOnHold) {
                    throw Error('rental item is on hold.');
                }

                let sqlParams = {};
                sqlParams.checkoutDate = checkoutDate;
                sqlParams.checkinDueDate = rentalAgreement.returnDate;
                sqlParams.rentalItemId = rentalAgreement.rentalItemId;
                sqlParams.borrowerId = userId;
                sqlParams.checkoutApprovedBy = approvedByEmployeeId;
                let isSuccessful = await this.rentalAgreementDataAccess.insertRentalAgreement(sqlParams);
                checkoutResults.push({ rentalItemId: rentalAgreement?.rentalItemId, isCheckoutSuccessful: isSuccessful ? true : false });
            } catch (err) {
                debug(err.message);
                checkoutResults.push({ rentalItemId: rentalAgreement?.rentalItemId, isCheckoutSuccessful: false, errorMessage: err.message });
            }
        }
        res.status(200).json(checkoutResults);
    }
    async getRentalAgreementsByRentalItemId(req, res) {
        try {
            const { rentalItemId } = req.params;
            const { isActive } = req.query;

            var rentalAgreements = await this.rentalAgreementDataAccess.getRentalAgreementsByRentalItemId(rentalItemId);
            
            if (isActive) {
                rentalAgreements = rentalAgreements.find(agreement => !agreement.actualCheckinDate);
            }
            res.status(200).json(rentalAgreements);
        }
        catch (error) {
            debug(error);
            res.sendStatus(500);
        }
    }
}

module.exports = RentalAgreementApiController;