const express = require('express');
const debug = require('debug')('app:authRouter');
const userDataAccess = require('../data/userDataAccess');
const bcrypt = require('bcrypt');
const passport = require('passport');

const registerView = async (req, res, next) => {
    res.render('authViews/register', {});
}

const register = async (req, res, next) => {
    const { name, phone, email, dob, password } = req.body;
    const passwordHash = await bcrypt.hash(password, 10);
    let result = await userDataAccess.createUser(name, phone, email, passwordHash, dob);
    if (result) {
        res.redirect('/auth/login');
    }
    else {
        request.flash('Error', 'Failed to register user')
        res.redirect('/register');
    }
}


const loginView = async (req, res, next) => {
    res.render('authViews/login', {});
}

const login = (
    passport.authenticate('local', {
        successRedirect: '/',
        failureRedirect: '/login',
        failureFlash: true
    }));

const logout = (req, res) => {
    req.logout(err => {
        if (err) {
            debug("Error: ", err);
            return next(err);
        }
        res.redirect('/');
    });
};


module.exports = { register, registerView, login, loginView, logout };