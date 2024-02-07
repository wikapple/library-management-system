/**
 * Imports
 */
const express = require('express');
const dotenv = require('dotenv');
const chalk = require('chalk');
const debug = require('debug')('app');
const cookieParser = require('cookie-parser');
const flash = require('express-flash');
const path = require('path');
const morgan = require('morgan');
const session = require('express-session');
dotenv.config({path: '.env'});
const userDataAccess = require('./src/data/userDataAccess');
const passport = require('passport');
const authRouter = require('./src/routers/authRouter');
const dashboardRouter = require('./src/routers/dashboardRouter');

const app = express();
app.set('views', './src/views/');
app.set('view engine', 'ejs');
const initializePassport = require('./src/config/passport');

initializePassport (
    passport,
    async email => await userDataAccess.getUserByEmail(email),
    async id => await userDataAccess.getUserById(id)
 );


/**
 * Middleware
 */
app.use(morgan('combined'));
app.use(express.static(path.join(__dirname, '/public/')));
app.use(express.json());
app.use(express.urlencoded({extended:false}));
app.use(cookieParser());
app.use(flash())
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
}));
app.use(passport.initialize());
app.use(passport.session());
app.use('/auth', authRouter);
app.use('/dashboard', dashboardRouter);

/**
 * Routes
 */

app.get('/', checkAuthenticated, (req, res) => {
    res.redirect(`dashboard/`);
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Listening for requests on port ${PORT}`);
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
        return res.redirect('auth/login');
    }
}