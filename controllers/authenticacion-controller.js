'use strict';
let modelo = require('../models/authentication-model'),
    bcrypt = require('bcrypt-nodejs'),
    moment = require('moment'),
    sess = null,
    AuthenticationController = function () {};


AuthenticationController.login = function( req, res, next ) {
    res.render('authentication', { error: false, msg: '' });
};

// Inicio de sesion
AuthenticationController.authentication = function( req, res, next ) {
    sess= req.session;
    let user = {
        email: req.body.email,
        password: req.body.password
    };
    modelo.byId(user.email,function( error, rows){
        if(error){
            console.log("Ocurrio un error: ", error);
            res.render('authentication',{error : true , msg : 'Error en la base de datos, intentelo luego'});
        }else{
            if(rows[0]){
                if(bcrypt.compareSync( user.password, rows[0].password ) ) {
                    sess.usuarioDatos = {
                        id: rows[0].id,
                        email: rows[0].email,
                        nombre: rows[0].nombres,
                        direccion: rows[0].direccion,
                        telefono: rows[0].telefono,
                        password: rows[0].password,
                        horaInicio: moment().format('hh:mm:ss')
                    };
                    console.log(sess.usuarioDatos);
                    res.redirect('/panel');
                }else{
                    res.render('authentication',{error:true,  msg:'Credenciales incorrectas'});
                }
            }else{
                res.render('authentication',{error:true,  msg:'Credenciales incorrectas'});
            }
        }
    });
};

AuthenticationController.logout = function ( req, res ) {
    req.session.destroy(function(err){
        if(err){
            console.log(err);
        }
        else{
            console.log('Cerrando session');
            res.redirect('/');
        }
    });
};

module.exports = AuthenticationController;
