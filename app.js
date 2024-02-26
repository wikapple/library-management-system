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
const authRoutes = require('./src/routes/auth.routes');
const homeRoutes = require('./src/routes/home.routes');
const mediaRoutes = require('./src/routes/media.routes');
const expressLayouts = require('express-ejs-layouts');
const app = express();
app.use(express.static(path.join(__dirname, '/public/')));

app.set('views', './src/views/');
app.use(expressLayouts);
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
app.use((req, res, next) => {
    console.log("Layout:", res.locals.layout);
    res.locals.layout = 'shared/layout.ejs';
    res.locals.currentUser = req.user;
    next();
});

app.use('/auth', authRoutes);
app.use('/', homeRoutes);
app.use('/media', mediaRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Listening for requests on port ${PORT}`);
});