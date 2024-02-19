const debug = require('debug')('app:authRouter');
const mediaDataAccess = require('../data/mediaDataAccess');


const mediaListView = async (req, res) => {
    let model = {};
    //const reqJson = stringify(req);
   
    model.user = req.user;

    model.books = await mediaDataAccess.getAllBooks();

    res.render(`mediaViews/mediaList.ejs`, {'model': model});
};

const getBookList = async (req, res) => {
    const books = await mediaDataAccess.getAllBooks();
    res.status(200).json(books);
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


module.exports = {mediaListView, getBookList, getCdList, getDvdList, getInstrumentList};