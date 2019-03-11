'use strict'
let db = require('./dbMedical-connection'),
    AuthenticationModel =  function () {};

AuthenticationModel.byId = function( email, callback ) {
   return db.query('SELECT * FROM usuario Where email = ?', email, callback);
}

module.exports = AuthenticationModel;