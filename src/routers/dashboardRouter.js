const express = require('express');
const debug = require('debug')('app:authRouter');
const userDataAccess = require('../data/userDataAccess');
const passport = require('passport');
const dashboardRouter = express.Router();

dashboardRouter.route('/').get(checkAuthenticated, (req, res) => {
    
    const userRole = req.session.passport.user.UserRole;
    let userDashboard = ['Administrator', 'StaffMember'].includes(userRole) ?
        'employeeDashboard' : 'memberDashboard';

    res.render(`dashboardViews/${userDashboard}.ejs`, {'user' : req.session.passport.user.Name});
});

function stringify(obj) {
    let cache = [];
    let str = JSON.stringify(obj, function(key, value) {
      if (typeof value === "object" && value !== null) {
        if (cache.indexOf(value) !== -1) {
          // Circular reference found, discard key
          return;
        }
        // Store value in our collection
        cache.push(value);
      }
      return value;
    });
    cache = null; // reset the cache
    return str;
  }

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