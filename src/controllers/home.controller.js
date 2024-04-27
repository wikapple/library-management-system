const MemberDataAccess = require('../data/memberDataAccess');
const RentalAgreementDataAccess = require('../data/rentalAgreementDataAccess');
const debug = require('debug')('app:homeController');

class HomeController {
    constructor() {
        this._memberDataAccess = new MemberDataAccess();
        this._rentalAgreementDataAccess = new RentalAgreementDataAccess();
    }

    async home(req, res) {
    let viewModel = {};
    viewModel.user = req.user.name;
    const userRole = req.user.userRole;
    let userDashboard = ['Administrator', 'StaffMember'].includes(userRole) ?
        'employeeHome' : 'memberHome';

    if (userDashboard == 'memberHome') {
        const memberDetails = await this._memberDataAccess.getMemberById(req.user.userId);
        debug(memberDetails);
        viewModel.memberDetails = memberDetails;
        let notifications = [];

        if (memberDetails.isFrozen) {
            notifications.push('Member account is frozen');
        }
        if (memberDetails.balance < 0) {
            notifications.push('Member has library fees');
        }

        let memberRentalAgreements = await this._rentalAgreementDataAccess.getRentalAgreementsByBorrowerId(req.user.userId);
        memberRentalAgreements.map(ra => {
            const millisecondsFromDueDate = ra.checkinDueDate - new Date();
            ra.daysFromDueDate = millisecondsFromDueDate / (1000 * 60 * 60 * 24);
            return ra;
        });
        if (memberRentalAgreements.some(ra => ra.daysFromDueDate > 0 && ra.daysFromDueDate <= 5)) {
            notifications.push('You have checked out items due back soon');
        }

        if (memberRentalAgreements.some(ra => ra.daysFromDueDate < 0)) {
            notifications.push('You have overdue items to return!');
        }

        viewModel.notifications = notifications;

    }

    res.render(`homeViews/${userDashboard}.ejs`, { viewModel });
    }
}

module.exports = HomeController;