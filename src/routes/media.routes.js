const express = require('express');
const debug = require('debug')('app:itemRouter');
const MediaController = require('../controllers/media.controller');
const authValidator = require('../middleware/validators/authValidator.middleware');

const mediaRouter = express.Router();
const mediaController = new MediaController();

mediaRouter.post('/', authValidator.checkAuthenticatedEmployee, mediaController.addOrUpdateMedia.bind(mediaController));
mediaRouter.delete('/:mediaId', authValidator.checkAuthenticatedEmployee, mediaController.deleteMedia.bind(mediaController));
mediaRouter.get('/', authValidator.checkAuthenticated, mediaController.mediaListView.bind(mediaController));
mediaRouter.get('/:mediaId', authValidator.checkAuthenticated, mediaController.getMediaDetailsView.bind(mediaController));
mediaRouter.get('/createOrEdit/:mediaId', authValidator.checkAuthenticatedEmployee, mediaController.getCreateOrEditView.bind(mediaController));




module.exports = mediaRouter;