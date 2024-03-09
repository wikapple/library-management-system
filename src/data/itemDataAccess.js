const pool = require('../config/database');
const debug = require('debug')('app:mediaDataAccess');
const chalk = require('chalk');


class ItemDataAccess {

    // createItem
    async createItem(createRequest) {
        try {
            const { itemGuid, condition, isAvailable, baseItemId } = createRequest;
            const sqlQuery = `CALL rentalItem_Insert(?, ?, ?, ?)`;
            await pool.query(sqlQuery, [itemGuid, condition, isAvailable, baseItemId], (error, results, fields) => {
                if (error) {
                    throw error;
                }
            });
            return true;

        } catch (error) {
            debug(error);
            return false;
        }
    }
    // updateItem
    async updateItem(createRequest) {
        try {
            const { itemGuid, condition, isAvailable } = createRequest;
            const sqlQuery = `CALL rentalItem_UpdateByRentalItemGuid(?, ?, ?)`;
            await pool.query(sqlQuery, [itemGuid, condition, isAvailable], (error, results, fields) => {
                if (error) {
                    throw error;
                }
            });
            return true;

        } catch (error) {
            debug(error);
            return false;
        }
    }
    // getItemByGuid
    async getItemByGuid(guidInput) {

        try {
            const sqlQuery = `CALL rentalItem_SelectByRentalItemGuid(?)`;
            const dbResponse = await pool.query(sqlQuery, [guidInput]);
            const rentalItem = dbResponse[0][0];
            return rentalItem;
        } catch (error) {
            debug(error);
        }
    }
    // getItemByBaseId
    async getItemByBaseId(baseItemId) {
        try {
            const sqlQuery = `CALL rentalItem_SelectByBaseItemId(?)`;
            const dbResponse = await pool.query(sqlQuery, [baseItemId]);
            const rentalItem = dbResponse[0];
            return rentalItem;
        } catch (error) {
            debug(error);
        }
    }
    // deleteItemByItemGuid
    async deleteItemByItemGuid(itemGuidToDelete) {
        try {
            const sqlQuery = `Call media_DeleteById(?)`;

            await pool.query(
                sqlQuery,
                [itemGuidToDelete],
                (error, results, fields) => {
                    if (error) {
                        throw error;
                    }
                }
            );
            return true;

        } catch (error) {
            debug(error);
            return false;
        }
    }
}

module.exports = ItemDataAccess;
