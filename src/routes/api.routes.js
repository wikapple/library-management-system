const express = require('express');
const debug = require('debug')('app:apiRouter');
const MediaApiController = require('../api/media.api.controller');
const authValidator = require('../middleware/validators/authValidator.middleware');

const apiRouter = express.Router();
const mediaApiController = new MediaApiController();

// users

// media types

// media
apiRouter.get('/mediacategories', mediaApiController.getCategoryList.bind(mediaApiController));
apiRouter.get('/mediaTypes', mediaApiController.getMediaTypeList.bind(mediaApiController));
apiRouter.get('/media/list/:typeId', mediaApiController.getMediaListByType.bind(mediaApiController));

apiRouter.post('/media', mediaApiController.addOrUpdateMedia.bind(mediaApiController));
apiRouter.delete('/media/:mediaId', mediaApiController.deleteMedia.bind(mediaApiController));
apiRouter.get('/media/:mediaId', mediaApiController.getMedia.bind(mediaApiController));

// instruments

// rental item



module.exports = apiRouter;