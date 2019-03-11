'use strict';
let config = require('./db-config'),
    mysql = require('mysql'),
    db_config = {
        host: config.mysql.host,
        user: config.mysql.user,
        password: config.mysql.pass,
        database: config.mysql.db
    },
    myConn = mysql.createConnection(db_config);

    myConn.connect(function(err){
      return (err)? console.log(`conexión fallida ${error.stack}`) : console.log(`conectado a la base de datos` );
    });

module.exports = myConn;