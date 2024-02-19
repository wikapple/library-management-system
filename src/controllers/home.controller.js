const debug = require('debug')('app:authRouter');

const home = (req, res) => {

    const userRole = req.user.UserRole;
    let userDashboard = ['Administrator', 'StaffMember'].includes(userRole) ?
        'employeeHome' : 'memberHome';

    res.render(`homeViews/${userDashboard}.ejs`, {'user' : req.user.Name});
}


module.exports = {home};