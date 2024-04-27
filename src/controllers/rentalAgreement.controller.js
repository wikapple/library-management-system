const chalk = require('chalk');
const debug = require('debug')('app:rentalAgreementController');
const MemberDataAccess = require('../data/memberDataAccess');
const ItemDataAccess = require('../data/itemDataAccess');
const RentalAgreementDataAccess= require('../data/rentalAgreementDataAccess');
class RentalAgreementController {
    
    constructor() {
        this.memberDataAccess = new MemberDataAccess();
        this.itemDataAccess = new ItemDataAccess();
        this.rentalAgreementDataAccess = new RentalAgreementDataAccess();
    }

    async checkoutView(req, res) {
        let viewModel = {};
        const {memberId, rentalItemId} = req.query;
        
        if(memberId) {
            viewModel.member = await this.memberDataAccess.getMemberById(memberId);
        }

        if(rentalItemId) {
            viewModel.rentalItem = await this.itemDataAccess.getItemByGuid(rentalItemId);
        }
                
        res.render(`rentalAgreementViews/checkoutView.ejs`, { viewModel });
    }
    async checkinView(req, res) {
        let viewModel = {};
        const {rentalItemId} = req.query;

        if(rentalItemId) {
            const rentalItem = await this.itemDataAccess.getItemByGuid(rentalItemId);
            const rentalAgreement = await this.getActiveRentalAgreementByRentalItemId(rentalItemId);

            if (rentalItem && rentalAgreement) {
                viewModel.rentalItem = rentalItem;
                viewModel.rentalAgreement = rentalAgreement;
            } else {
                if(!rentalItem) {
                    debug(`Could not find rental item with ID of ${rentalItemId}`);
                }
                if(!rentalAgreement) {
                    debug(`Unable to find an active rental agreement for rental item id: ${rentalItemId}`);
                }
            }
        }
                
        res.render(`rentalAgreementViews/checkinView.ejs`, { viewModel });
    }

    async submitCheckin(req, res) {

        const approvedByEmployeeId = req.user.userId;
        const {rentalAgreementIdInput, returnedCondition, returnDate} = req.body;

        const rentalAgreement = await this.rentalAgreementDataAccess.getRentalAgreementByTransactionId(rentalAgreementIdInput);
        const rentalItem = await this.itemDataAccess.getItemByGuid(rentalAgreement.rentalItemId);
        const member = await this.memberDataAccess.getMemberById(rentalAgreement.borrowerId);

        // Update rentalAgreement (checkin)
        await this.rentalAgreementDataAccess.checkin(rentalAgreementIdInput, returnDate, approvedByEmployeeId);

        // Update rentalItem condition if needed
        if(rentalItem.itemCondition !== returnedCondition) {
            const updateRequest = 
                { itemGuid : rentalItem.rentalItemGuid, condition : returnedCondition, isOnHold : rentalItem.isOnHold }
            
            await this.itemDataAccess.updateItem(updateRequest);
        }

        res.status(200).redirect('/');
    }

    async getActiveRentalAgreementByRentalItemId(rentalItemId) {
        var rentalAgreements = await this.rentalAgreementDataAccess.getRentalAgreementsByRentalItemId(rentalItemId);
        var rentalAgreement = rentalAgreements.find(agreement => !agreement.actualCheckinDate);
        return rentalAgreement;
    }

    
} 

module.exports = RentalAgreementController;