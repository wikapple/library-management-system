const express = require('express');
const debug = require('debug')('app:authRouter');
const userDataAccess = require('../data/userDataAccess');
const bcrypt = require('bcrypt');
const passport = require('passport');

const authRouter = express.Router();

authRouter.route('/login').get((req, res) => {
    res.render('authViews/login', {});
});

authRouter.route('/login').post(passport.authenticate('local', {
    successRedirect: '/',
    failureRedirect: '/auth/login',
    failureFlash: true
}));

authRouter.route('/register').get((req, res) => {
    res.render('authViews/register', {});
});

authRouter.route('/register').post( async (req, res) => {
    const {name, phone, email, dob, password} = req.body;
    const passwordHash = await bcrypt.hash(password, 10);
    console.log(`password hash created >>>>>>>> ${passwordHash}`);
    let result = await userDataAccess.createUser(name, phone, email, passwordHash, dob);
    if(result) {
         res.redirect('/auth/login');
    }
    else{
        debug(`Failed to register user. name='${name}', phone='${phone}', email='${email}', dob='${dob}'`);
        request.flash('Error', 'Failed to register user')
        res.redirect('/auth/register');
    }
});

module.exports = authRouter;