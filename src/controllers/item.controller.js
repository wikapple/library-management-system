const chalk = require('chalk');
const debug = require('debug')('app:itemController');
const ItemDataAccess = require('../data/itemDataAccess');
const RentalAgreementDataAccess = require('../data/rentalAgreementDataAccess');
const { v4: uuidv4 } = require('uuid');
const QRCode = require('qrcode');

class ItemController {

    constructor() {
        this._itemDataAccess = new ItemDataAccess();
        this._rentalAgreementDataAccess = new RentalAgreementDataAccess();
    }


    // createOrUpdateItem
    async createOrUpdateItem(req, res) {
        const isNewItem = req.body.rentalItemGuid ? false : true;

        if (isNewItem) {
            await this.createNewItem(req, res);
        }
        else {
            await this.updateItem(req, res);
        }
    }

    async createNewItem(req, res) {
        let dbParams = {
            itemGuid: uuidv4(),
            isOnHold: req.body.isOnHold ? true : false,
            condition: req.body.condition,
            baseItemId: req.body.baseItemId
        };

        const isCreateSuccessful = await this._itemDataAccess.createItem(dbParams);

        if (isCreateSuccessful) {
            res.status(200).json({ idAssigned: dbParams.itemGuid });
        } else {
            res.sendStatus(500);
        }
    }

    async updateItem(req, res) {
        let dbParams = {
            itemGuid: req.body.rentalItemGuid,
            isOnHold: req.body.isOnHold ? true : false,
            condition: req.body.condition,
        };

        const isUpdateSuccessful = await this._itemDataAccess.updateItem(dbParams);

        if (isUpdateSuccessful) {
            res.redirect(`/item/${req.body.rentalItemGuid}`);
        } else {
            res.sendStatus(500);
        }
    }

    async getItemDetailsViewByGuid(req, res) {
        let viewModel = {}
        const rentalItemGuid = req.params.rentalItemGuid;

        const rentalItem = await this._itemDataAccess.getItemByGuid(rentalItemGuid);
        viewModel.rentalItem = rentalItem;

        const rentalAgreements = await this._rentalAgreementDataAccess.getRentalAgreementsByRentalItemId(rentalItemGuid);
        viewModel.rentalAgreements = rentalAgreements

        const isCheckedOut = rentalAgreements.some(rentalAgreement => rentalAgreement.actualCheckinDate == null);
        viewModel.rentalItem.isCheckedOut = isCheckedOut;

        const qrCode = await this.generateQRCode(rentalItemGuid);
        viewModel.qrCode = qrCode;

        // Get Transaction history
        res.render(`itemViews/itemDetails.ejs`, { viewModel });
    }
    

    // getItemByGuid
    async getItemByGuid(req, res) {
        const rentalItemGuid = req.params.rentalItemGuid;
        const rentalItem = await this._itemDataAccess.getItemByGuid(rentalItemGuid);
        return res.status(200).json(rentalItem);
    }


    // getItemByBaseItemId
    async getItemByBaseItemId(req, res) {
        const baseItemId = req.params.baseItemId;
        const rentalItem = await this._itemDataAccess.getItemByBaseId(baseItemId);
        return res.status(200).json(rentalItem);
    }

    // delete item
    async deleteItemByGuid(req, res) {
        const rentalItemGuid = req.params.rentalItemGuid;
        await this._itemDataAccess.deleteItemByItemGuid(rentalItemGuid);
        res.sendStatus(204);
    }

    async getItemQrCode(req, res) {
        const guid = req.params.rentalItemGuid;

        try {
            const qrCodeDataUrl = await this.generateQRCode(guid);
            res.status(200).send(qrCodeDataUrl);
        } catch (error) {
            debug(error);
            res.sendStatus(500);
        }
    }

    async generateQRCode(guid) {
        try {
            const qrCodeDataUrl = await QRCode.toDataURL(guid);
            return qrCodeDataUrl;
        } catch(error) {
            debug(error);
            throw error;
        }
    }
}

module.exports = ItemController;
