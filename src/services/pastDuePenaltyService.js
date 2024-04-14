const debug = require('debug')('app:mediaDataAccess');
const cron = require('node-cron');
const RentalAgreementDataAccess= require('../data/rentalAgreementDataAccess');
const MemberDataAccess = require('../data/memberDataAccess');

class pastDuePenaltyService {

    constructor(){
        this.memberDataAccess = new MemberDataAccess();
        this.rentalAgreementDataAccess = new RentalAgreementDataAccess();
    }
    
    // Setting default task initiation time to 1:00 AM Monday - Friday:
    schedulerPastDueScan(minute = '0', hour = '1', dayOfMonth = '*', month = '*', dayOfWeek = '1-5') {
        cron.schedule(`${minute} ${hour} ${dayOfMonth} ${month} ${dayOfWeek}`, async () => {
            await this.runPastDueScanTask();
        });
        debug(`past due scan scheduled.`);
    }

    async runPastDueScanTask() {
        // Get overdue rental agreements
        debug('running past due scan task...');
        debug('Getting overdue rental agreements');
        const overdueRentalAgreements = await this.rentalAgreementDataAccess.getOverdueRentals();
        
        for (const overdueRental of overdueRentalAgreements) {
            const member = await this.memberDataAccess.getMemberById(overdueRental.borrowerId);
                        
            await this.memberDataAccess.updateMember(member.userId, --member.balance, true);
        }
    }

}

module.exports = pastDuePenaltyService;