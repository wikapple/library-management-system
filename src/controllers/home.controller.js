const debug = require('debug')('app:authRouter');

const home = (req, res) => {

    const userRole = req.user.userRole;
    debug(`user role: ${userRole}`);
    let userDashboard = ['Administrator', 'StaffMember'].includes(userRole) ?
        'employeeHome' : 'memberHome';

    res.render(`homeViews/${userDashboard}.ejs`, {'user' : req.user.name});
}


module.exports = {home};