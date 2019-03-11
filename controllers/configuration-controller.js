'use strict';
let modelo = require('../models/configuration-model'),
    sess = null,
    bcrypt = require('bcrypt-nodejs'),
    generateHash = function(password) {
         return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
    },
    ConfigurationController = function () {};

ConfigurationController.configuration = function( req, res ){
    sess = req.session;
    res.render('configuration',{ usuario : sess.usuarioDatos, error : false, listo : false, warning : false } );
};

ConfigurationController.changePassword = function( req, res ){
    sess = req.session;
    let solicitud = {
        passwordActual : req.body.password1,
        passwordNuevo : req.body.password2,
        email : sess.usuarioDatos.email
    };
    if( bcrypt.compareSync( solicitud.passwordActual, sess.usuarioDatos.password ) ){
        let nuevoPassword = generateHash(solicitud.passwordNuevo);
        modelo.savePassword(nuevoPassword, solicitud.email, function( error, body ) {
            if(error){
              console.log(`Ocurrio un error ${error.stack}`);
              res.render('configuration', { usuario : sess.usuarioDatos, error : true, listo : false, warning : false } );
            }else{
              sess.usuarioDatos.password = nuevoPassword;
              res.render('configuration', { usuario : sess.usuarioDatos, error : false, listo : true, warning : false } );
            }
        });
    }else {
        res.render('configuration', { usuario : sess.usuarioDatos, error : false, listo : false, warning : true } );
    }
};



module.exports = ConfigurationController;