const debug = require('debug')('app:authRouter');
const mediaDataAccess = require('../data/mediaDataAccess');


const mediaListView = async (req, res) => {
  let model = {};
  //const reqJson = stringify(req);

  model.user = req.user;

  model.books = await mediaDataAccess.getAllBooks();

  res.render(`mediaViews/mediaList.ejs`, { 'model': model });
};

const getCategoryList = async (req, res) => {
  const categories = await mediaDataAccess.getAllCategories();
  res.status(200).json(categories);
}

const getBookList = async (req, res) => {
  const books = await mediaDataAccess.getAllBooks();
  res.status(200).json(books);
}
const addOrUpdateBook = async (req, res) => {

  if (typeof req.body['categories[]'] == 'string') {
    req.body['categories[]'] = [req.body['categories[]']];
  }

  if (req.body.mediaId && req.body.mediaId > 0) {
    await mediaDataAccess.updateBook(req.body);
  } else {
    await mediaDataAccess.addBook(req.body);
  }
  res.status(204).send('success');
}

function stringify(obj) {
  let cache = [];
  let str = JSON.stringify(obj, function (key, value) {
    if (typeof value === "object" && value !== null) {
      if (cache.indexOf(value) !== -1) {
        // Circular reference found, discard key
        return;
      }
      // Store value in our collection
      cache.push(value);
    }
    return value;
  });
  cache = null; // reset the cache
  return str;
}
const getCdList = async (req, res) => {
  const books = await mediaDataAccess.getAllBooks();
  res.status(200).json([]);
}
const getDvdList = async (req, res) => {
  const books = await mediaDataAccess.getAllBooks();
  res.status(200).json([]);
}
const getInstrumentList = async (req, res) => {
  const books = await mediaDataAccess.getAllBooks();
  res.status(200).json([]);
}


module.exports = { mediaListView, getCategoryList, getBookList, addOrUpdateBook, getCdList, getDvdList, getInstrumentList };