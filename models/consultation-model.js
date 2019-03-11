'use strict'
let db = require('./dbMedical-connection'),
    ConsultasModel =  function () {};

ConsultasModel.allConsult = function( callback ) {
    return db.query('select idAtencion as id, nombreAtencion as nombre, DATE_FORMAT(fechaAtencion,"%d-%m-%Y") as fecha, horaAtencion as hora from atencion;', callback);
};

ConsultasModel.ver = function( id, callback) {
   return db.query('select sintomasAtencion as sintomas, diagnosticoAtencion as diagnostico, tratamientoAtencion as tratamiento from atencion where idAtencion = ?',id, callback);
};

ConsultasModel.delete = function (id, callback) {
    return db.query('delete from atencion where idAtencion = ?',id, callback);
};

module.exports = ConsultasModel;