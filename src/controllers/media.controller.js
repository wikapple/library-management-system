const debug = require('debug')('app:authRouter');
const MediaDataAccess = require('../data/MediaDataAccess');

class MediaController {

  constructor() {

  }

  async getCategoryList(req, res) {
    const mediaDataAccess = new MediaDataAccess();
    const categories = await mediaDataAccess.getAllCategories();
    res.status(200).json(categories);
  }

  async getMediaTypeList(req, res) {
    const mediaDataAccess = new MediaDataAccess();
    const mediaTypes = await mediaDataAccess.getAllMediaTypes();
    res.status(200).json(mediaTypes);
  }

  async getMediaListByType(req, res) {
    const mediaType = req.params.typeId;
    const mediaDataAccess = new MediaDataAccess();
    const mediaList = await mediaDataAccess.getMediaListByType(mediaType);
    res.status(200).json(mediaList);
  }

  async addOrUpdateMedia(req, res) {
    const mediaDataAccess = new MediaDataAccess();

    const dbCallSuccessful =  (req.body?.id === 0) ?
      await mediaDataAccess.createMedia(req.body) :
      await mediaDataAccess.updateMedia(req.body); 
    
    if(dbCallSuccessful) {
      res.sendStatus(204);
    } else {
      res.sendStatus(500);
    }
  }
  async deleteMedia(req, res) {
    const mediaDataAccess = new MediaDataAccess();

    const dbCallSuccessful =  await mediaDataAccess.deleteMediaById(req.params.mediaId);
    
    if(dbCallSuccessful) {
      res.sendStatus(204);
    } else {
      res.sendStatus(500);
    }
  }
}

module.exports = MediaController;