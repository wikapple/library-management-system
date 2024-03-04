const pool = require('../config/database');
const debug = require('debug')('app:userDataAccess');

const getAllUsers = async () => {
    try{
        const sqlQuery = `CALL user_SelectAll()`;
        const results = await pool.query(sqlQuery, []);
        return results;
    }
    catch (error) {
        debug(error);
    }
}

const getUserByEmail = async (email) => {
    try{
        const sqlQuery = `CALL user_SelectByEmail(?)`;
        const result = await pool.query(sqlQuery, [email]);
        return result[0][0];
    }
    catch (error) {
        debug(error);
    }
}

const getUserById = async (id) => {
    try{
        const sqlQuery = `CALL user_SelectById(?)`;
        const result = await pool.query(sqlQuery, [id]);
        return result[0][0];
    }
    catch (error) {
        debug(error);
    }
}

const createUser = async (name, phoneNumber, email, passwordHash, dob) => {
    try {
        const sqlQuery = `Call user_Insert(?,?,?,?,?, @IdOutput); select @IdOutput;`;
        const result = await pool.query(sqlQuery, [name, phoneNumber, email, passwordHash, dob]);
        
        return result[1][0]['@IdOutput'];
    }
    catch (error) {
        debug(error);
    }
}

const updateUser = async (id, name, phoneNumber, email, passwordHash, dob, userRoleId) => {
    try {
        const sqlQuery = `Call user_UpdateById(?,?,?,?,?,?,?)`
        const result = await pool.query(sqlQuery, [id, name, phoneNumber, email, passwordHash, dob, userRoleId]);
        return result.IsSuccess;
    }
    catch (error) {
        debug(error);
    }
}

const selectAllRoles= async () => {
    try{
        const sqlQuery = `CALL role_SelectAll()`;
        const results = await pool.query(sqlQuery, []);
        return results;
    }
    catch (error) {
        debug(error);
    }
}

module.exports = {getAllUsers, getUserByEmail, getUserById, createUser, updateUser, selectAllRoles};

