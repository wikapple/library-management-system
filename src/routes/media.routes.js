const express = require('express');
const debug = require('debug')('app:authRouter');
const MediaController = require('../controllers/media.controller');
const authValidator = require('../middleware/validators/authValidator.middleware');

const mediaRouter = express.Router();
const mediaController = new MediaController();

mediaRouter.get('/categories', mediaController.getCategoryList);

mediaRouter.get('/types', mediaController.getMediaTypeList);
mediaRouter.get('/mediaList/:typeId', mediaController.getMediaListByType);
mediaRouter.post('/', (req, res) => mediaController.addOrUpdateMedia(req, res));
mediaRouter.delete('/:mediaId', (req, res) => mediaController.deleteMedia(req, res));
//mediaRouter.get('/', authValidator.checkAuthenticated, mediaController.mediaListView);




module.exports = mediaRouter;