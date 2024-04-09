const chalk = require('chalk');
const debug = require('debug')('app:memberController');
const MemberDataAccess = require('../data/memberDataAccess');
const RentalAgreementDataAccess = require('../data/rentalAgreementDataAccess');
class MemberController {
    
    constructor() {
        this.memberDataAccess = new MemberDataAccess();
        this.rentalAgreementDataAccess = new RentalAgreementDataAccess();
    }

    async getMemberListView(req, res) {
        let viewModel = {};
        const filterValue = req.query.filter;
        
        let memberList;
        if (filterValue) {
            memberList = await this.memberDataAccess.getMembersByFilter(filterValue);
        } else {
            memberList = await this.memberDataAccess.getAllMembers();
        }

        viewModel.memberList = memberList;
        
        res.render(`memberViews/memberListView.ejs`, { viewModel });
    }

    async getMemberDetailsView(req, res) {
        let viewModel = {};
        const memberId = req.params.memberId;

        const memberDetails = await this.memberDataAccess.getMemberById(memberId);
        debug(memberDetails);
        viewModel.memberDetails = memberDetails;

        const rentalAgreements = await this.rentalAgreementDataAccess.getRentalAgreementsByBorrowerId(memberId);
        debug(rentalAgreements);

        viewModel.rentalAgreements = rentalAgreements;

        res.render(`memberViews/memberDetailsView.ejs`, { viewModel });
    }
} 

module.exports = MemberController;