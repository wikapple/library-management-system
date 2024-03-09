const pool = require('../config/database');
const debug = require('debug')('app:mediaDataAccess');
const chalk = require('chalk');

class MemberDataAccess {

    async getAllMembers() {
        try {
            const sqlQuery = `Call memberAccount_SelectAll();`;
            const result = await pool.query(sqlQuery, []);
            
            return result[0];
        }
        catch (error) {
            debug(error);
        }
    }
    async getMembersByFilter(filterValue) {
        try {
            const sqlQuery = `CALL memberAccount_Filter(?)`;
            const result = await pool.query(sqlQuery, [filterValue]);
            let memberList = result[0];

            return memberList;
        } catch (error) {
            debug(error);
        }
    }
}

module.exports = MemberDataAccess;