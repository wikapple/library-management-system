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
        viewModel.isEmployee = ['Administrator', 'StaffMember'].includes(req.user.userRole);
        const memberDetails = await this.memberDataAccess.getMemberById(memberId);
        viewModel.memberDetails = memberDetails;

        const rentalAgreements = await this.rentalAgreementDataAccess.getRentalAgreementsByBorrowerId(memberId);

        viewModel.rentalAgreements = rentalAgreements;

        res.render(`memberViews/memberDetailsView.ejs`, { viewModel });
    }

    async processPaymentView(req, res) {
        let viewModel = {};
        const memberId = req.query.memberId;

        if(memberId) {
            const memberDetails = await this.memberDataAccess.getMemberById(memberId);
            viewModel.memberDetails = memberDetails;
        }

        res.render(`memberViews/processPayment.ejs`, { viewModel });
    }

    async processPayment(req, res) {
        try{
            const {paymentMemberId, amount} = req.body;
        let memberDetails = await this.memberDataAccess.getMemberById(paymentMemberId);
        if (memberDetails) {
            memberDetails.balance = parseFloat(memberDetails.balance) + parseFloat(amount);
            memberDetails.isFrozen = memberDetails.balance < 0;
            await this.memberDataAccess.updateMember(paymentMemberId, memberDetails.balance, memberDetails.isFrozen);
            req.flash('success', 'Successfully processes member payment');
        }
        else {
            req.flash('error', 'Failed to process payment, user not found');
            res.status(400).rendirect('/');
        }
        
        }
        catch(err) {
            debug(err);
            req.flash('Error', 'Error processing member payment');
        }
        finally {
            res.redirect('/');
        }
        
    }
} 

module.exports = MemberController;