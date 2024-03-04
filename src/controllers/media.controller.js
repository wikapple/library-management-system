const chalk = require('chalk');
const debug = require('debug')('app:mediaController');
const MediaDataAccess = require('../data/mediaDataAccess');

class MediaController {

  
  constructor() {
    this._mediaDataAccess = new MediaDataAccess();
  }

  async addOrUpdateMedia(req, res) {
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
      res.redirect('/media');
    } else {
      res.sendStatus(500);
    }
  }

  async mediaListView(req, res) {
    let viewModel = {};

    viewModel.mediaTypes = await this._mediaDataAccess.getAllMediaTypes();

    res.render(`mediaViews/mediaList.ejs`, { viewModel });
  }

  async getMediaDetailsView(req, res) {
    res.status(200).json({'yay': 1});
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
