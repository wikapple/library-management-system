const express = require('express');
const debug = require('debug')('app:itemRouter');
const MediaController = require('../controllers/media.controller');
const authValidator = require('../middleware/validators/authValidator.middleware');

const mediaRouter = express.Router();
const mediaController = new MediaController();

mediaRouter.get('/categories', mediaController.getCategoryList);

mediaRouter.get('/types', mediaController.getMediaTypeList.bind(mediaController));
mediaRouter.get('/mediaList/:typeId', mediaController.getMediaListByType.bind(mediaController));
mediaRouter.post('/', mediaController.addOrUpdateMedia.bind(mediaController));
mediaRouter.delete('/:mediaId', mediaController.deleteMedia.bind(mediaController));
mediaRouter.get('/:mediaId', mediaController.getMedia.bind(mediaController));
mediaRouter.get('/', authValidator.checkAuthenticated, mediaController.mediaListView.bind(mediaController));
mediaRouter.get('/views/:mediaId', mediaController.getCreateOrEditView.bind(mediaController));




module.exports = mediaRouter;