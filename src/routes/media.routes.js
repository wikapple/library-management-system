const express = require('express');
const debug = require('debug')('app:authRouter');
const mediaController = require('../controllers/media.controller');
const authValidator = require('../middleware/validators/authValidator.middleware');

const mediaRouter = express.Router();

mediaRouter.get('/', authValidator.checkAuthenticated, mediaController.mediaListView);
mediaRouter.get('/books', authValidator.checkAuthenticated, mediaController.getBookList);
mediaRouter.get('/cds', authValidator.checkAuthenticated, mediaController.getCdList);
mediaRouter.get('/dvds', authValidator.checkAuthenticated, mediaController.getDvdList);
mediaRouter.get('/instruments', authValidator.checkAuthenticated, mediaController.getInstrumentList);

module.exports = mediaRouter;