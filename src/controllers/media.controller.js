const chalk = require('chalk');
const debug = require('debug')('app:mediaController');
const MediaDataAccess = require('../data/mediaDataAccess');

class MediaController {

  
  constructor() {
    this._mediaDataAccess = new MediaDataAccess();
  }

  async getCategoryList(req, res) {

    const categories = await this._mediaDataAccess.getAllCategories();
    res.status(200).json(categories);
  }

  async getMediaTypeList(req, res) {
    const mediaDataAccess = new MediaDataAccess();
    const mediaTypes = await mediaDataAccess.getAllMediaTypes();
    res.status(200).json(mediaTypes);
  }
  async getMedia(req, res) {

    const dbResult=  await this._mediaDataAccess.getMediaById(req.params.mediaId);
    
    res.status(200).json(dbResult);
  }

  async getMediaListByType(req, res) {
    const mediaType = req.params.typeId;
    const filterValue = req.query.filter;

    const mediaList = filterValue ? 
      await this._mediaDataAccess.getMediaListByTypeAndFilter(mediaType, filterValue) :
      await this._mediaDataAccess.getMediaListByType(mediaType);

    res.status(200).json(mediaList);
  }

  async addOrUpdateMedia(req, res) {
    debug('in add or update media');
    const dbCallSuccessful =  (req.body?.id == 0) ?
      await this._mediaDataAccess.createMedia(req.body) :
      await this._mediaDataAccess.updateMedia(req.body); 
    
    if(dbCallSuccessful) {
      res.redirect('/media');
    }
  }
  async deleteMedia(req, res) {

    const dbCallSuccessful =  await this._mediaDataAccess.deleteMediaById(req.params.mediaId);
    
    if(dbCallSuccessful) {
      res.sendStatus(204);
    } else {
      res.sendStatus(500);
    }
  }

  async mediaListView(req, res) {
    let model = {};

    res.render(`mediaViews/mediaList.ejs`, {'model': model});
  }
  async getCreateOrEditView(req, res) {
    const id = req.params.mediaId;
    let viewModel = {};
    if (id && id != 0) {
      viewModel.isNewMedia = false;
      viewModel.mediaToUpdate = await this._mediaDataAccess.getMediaById(id);
      if(! viewModel.mediaToUpdate) {
        res.redirect('/')
      }
    } else {
      viewModel.isNewMedia = true;
    }
    viewModel.categories = await this._mediaDataAccess.getAllCategories();
    viewModel.mediaTypes = await this._mediaDataAccess.getAllMediaTypes();
 
    res.render(`mediaViews/createOrEditMedia.ejs`, {viewModel});
  }
}

module.exports = MediaController;
