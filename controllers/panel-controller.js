'use strict';
let modelo = require('../models/panel-model'),
    async = require('async'),
    sess = null,
    moment = require('moment'),
    ids = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22'], /* 22 enfermedades de la CI10 */
    cursos = [ // niveles
        'PRIMERO DE BASICA', 'SEGUNDO DE BASICA ELEMENTAL', 'TERCERO DE BASICA ELEMENTAL',
        'CUARTO DE BASICA ELEMENTAL', 'QUINTO DE BASICA MEDIA ', 'SEXTO DE BASICA MEDIA',
        'SEPTIMO DE BASICA MEDIA', 'OCTAVO DE BASICA SUPERIOR', 'NOVENO DE BASICA SUPERIOR',
        'DECIMO DE BASICA SUPERIOR','PRIMER AÑO DE BACHILLERATO EN CIENCIAS(GENERAL)','SEGUNDO AÑO DE BACHILLERATO EN CIENCIAS (GENERAL)',
        'TERCER AÑO DE BACHILLERATO EN CIENCIAS (GENERAL)'
    ],
    PanelController = function () {};

PanelController.panel = function( req, res ){
    sess = req.session;
    var mes = moment().format('MM');
    var year = moment().format('YYYY');
    console.log(mes,'  ',year);
    var enfermedades = new Array(),
        nivelAtencion = new Array();
    async.series([function (callback) {
                async.forEachLimit(cursos, 1, function(curso, callback){
                    modelo.monthAttention(curso, mes, year, function(error, response){
                        if(error){
                            console.log(`Erro en la base de datos ${error}`);
                            callback();
                        }else{
                            (response[0]) ?  nivelAtencion.push(response[0].cantidad) : nivelAtencion.push(0);
                            callback();
                        }
                    });
                },function() {
                    callback();
                });
            }
        ],
        function(error){
            if(error) {
                console.log(`Exploto ${error}`);
            }else {
                console.log('niveles: ', nivelAtencion);
                res.render('panel',{ usuario : sess.usuarioDatos,
                    enfermedades: enfermedades,
                    nivelAtencion: nivelAtencion,
                    inicio: '',
                    fin: '',
                    imprimir: false,
                    hoy: moment().format('DD-MM-YYYY')
                } );
            }
        });
   // res.render('panel',{ usuario : sess.usuarioDatos, enfermedades:[], nivelAtencion:[], inicio:'', fin: '', imprimir: false, hoy: moment().format('YYYY-MM-DD') } );
};

PanelController.rango = function ( req, res ) {
    sess = req.session;
    var inicio = req.body.fechaInicio;
    var fin = req.body.fechaFin;
    console.log(inicio, fin);
    var enfermedades = new Array(),
        nivelAtencion = new Array();
    async.series([
            function(callback){
                async.forEachLimit(ids, 1, function(id, callback){
                    modelo.rango(id, inicio, fin, function(error, response){
                        if(error){
                            console.log(`Erro en la base de datos ${error}`);
                            callback();
                        }else{
                            enfermedades.push(response[0].total);
                            callback();
                        }
                    });
                },function() {
                    callback();
                });
            },function (callback) {
                async.forEachLimit(cursos, 1, function(curso, callback){
                    modelo.levelAttention(curso, inicio, fin, function(error, response){
                        if(error){
                            console.log(`Erro en la base de datos ${error}`);
                            callback();
                        }else{
                            (response[0]) ?  nivelAtencion.push(response[0].cantidad) : nivelAtencion.push(0);
                            callback();
                        }
                    });
                },function() {
                    callback();
                });
            }
        ],
        function(error){
            if(error) {
                console.log(`Exploto ${error}`);
            }else {
                console.log('niveles: ', nivelAtencion);
                res.render('panel',{ usuario : sess.usuarioDatos,
                    enfermedades: enfermedades,
                    nivelAtencion: nivelAtencion,
                    inicio: moment(inicio).format('DD-MM-YYYY'),
                    fin: moment(fin).format('DD-MM-YYYY'),
                    imprimir: true,
                    hoy: moment().format('DD-MM-YYYY')
                } );
            }
        });
};
module.exports = PanelController;