'use strict';
let modelo = require('../models/consultation-model'),
    sess = null,
    ConsultasController = function () {};

ConsultasController.open = function( req, res ){
    sess = req.session;
    modelo.allConsult(function( error, consults ){
       if(error){
           console.log(`Erro en la base de datos ${error}` );
       }else{
           console.log('consultas: ', consults);
           res.render('consultation',{ usuario : sess.usuarioDatos, atenciones: consults } );
       }
    });
};

ConsultasController.viewDetail = function( req, res ) {
    sess = req.session;
    modelo.ver(req.query.q, function (error, detalle) {
        if(error){
            console.log(`Erro en la base de datos ${error}` );
            res.send('error');
        }else{
            res.send(detalle);
        }
    });
};

ConsultasController.delete = function( req, res ) {
    sess = req.session;
    modelo.delete(req.query.q, function (error, response) {
        if(error){
            console.log(`Erro en la base de datos ${error}` );
            res.send('error');
        }else{
            res.send(req.query.q);
        }
    });
};

module.exports = ConsultasController;