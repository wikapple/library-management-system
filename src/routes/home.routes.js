const express = require('express');
const debug = require('debug')('app:authRouter');
const HomeController = require('../controllers/home.controller');
const authValidator = require('../middleware/validators/authValidator.middleware');


const homeRouter = express.Router();
const homeController = new HomeController();

homeRouter.get('/', authValidator.checkAuthenticated, homeController.home.bind(homeController));

module.exports = homeRouter;