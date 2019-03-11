'use strict'
let db = require('./dbMedical-connection'),
    ConfigurationModel =  function () {};

ConfigurationModel.savePassword = function( password, email, callback ) {
    return db.query('UPDATE usuario SET password = ? WHERE email = ?', [password, email], callback);
};

module.exports = ConfigurationModel;