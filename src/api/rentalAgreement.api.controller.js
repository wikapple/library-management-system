const chalk = require('chalk');
const debug = require('debug')('app:rentalAgreementApiController');
const MemberDataAccess = require('../data/memberDataAccess');

class RentalAgreementApiController {
    
    constructor() {
        this.memberDataAccess = new MemberDataAccess();
    }

    async submitRentalAgreements(req, res) {
        const approvedByEmployeeId = req.user.userId;
        const {userId, checkoutDate, rentalAgreements} = req.body;

        let checkoutResults = [];

        for(let rentalAgreement of rentalAgreements) {
            
        }

        res.status(200).json(req.body);


    }
} 

module.exports = RentalAgreementApiController;