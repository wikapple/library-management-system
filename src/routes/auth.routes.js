const express = require('express');
const authRouter = express.Router();
const authController = require('../controllers/auth.controller');
const authValidator = require('../middleware/validators/authValidator.middleware');

authRouter.get('/login', authValidator.checkNotAuthenticated, authController.loginView);
authRouter.post('/login', authValidator.checkNotAuthenticated, authController.login);
authRouter.post('/logout', authValidator.checkAuthenticated, authController.logout);
authRouter.get('/register', authValidator.checkNotAuthenticated, authController.registerView);
authRouter.post('/register', authValidator.checkNotAuthenticated, authController.register);

module.exports = authRouter;