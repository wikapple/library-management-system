const express = require('express');
const debug = require('debug')('app:authRouter');
const userDataAccess = require('../data/userDataAccess');
const passport = require('passport');
const dashboardRouter = express.Router();

dashboardRouter.route('/').get(checkAuthenticated, (req, res) => {

    const userRole = req.user.UserRole;
    let userDashboard = ['Administrator', 'StaffMember'].includes(userRole) ?
        'employeeDashboard' : 'memberDashboard';

    res.render(`dashboardViews/${userDashboard}.ejs`, {'user' : req.user.Name});
});

function checkNotAuthenticated(req, res, next) {
    if (req.isAuthenticated()) {
        return res.redirect('/');
    }
    else {
        next();
    }
}

function checkAuthenticated(req, res, next) {
    if (req.isAuthenticated()){
        return next();
    }
    else{
        return res.redirect('../auth/login');
    }
}



module.exports = dashboardRouter;