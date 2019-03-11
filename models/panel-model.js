'use strict'
let db = require('./dbMedical-connection'),
    PanelModel =  function () {};

PanelModel.rango = function(id, inicio, fin, callback ) {
    return db.query('select COUNT(idTipoAtencion) as total from atencion where idTipoAtencion = ? and DATE_FORMAT(fechaAtencion,"%Y-%m-%d") BETWEEN  ? and ? ',
        [id, inicio, fin], callback);
};

PanelModel.levelAttention = function(nivel ,inicio, fin, callback ) {
    var query = 'select  COUNT(DISTINCT  a.nombreAtencion) as cantidad, n.nombreNivel, a.fechaAtencion  from nivel n inner join periodoacademico pa on pa.idNivel = n.idNivel INNER JOIN persona pe on pe.idPersona=pa.idPersona INNER JOIN historia_clinica hc on hc.idPersona= pe.idPersona INNER JOIN atencion a on a.idHistoria= hc.idHistoriaClinica  where nombreNivel = ? and DATE_FORMAT(fechaAtencion,"%Y-%m-%d") BETWEEN  ? and ?;'
    return db.query(query,
        [nivel,inicio, fin] , callback);
};

PanelModel.monthAttention = function(nivel, mes ,year, callback ) {
    var query = 'select  COUNT(DISTINCT  a.nombreAtencion) as cantidad, n.nombreNivel, a.fechaAtencion from nivel n inner join periodoacademico pa on pa.idNivel = n.idNivel INNER JOIN persona pe on pe.idPersona=pa.idPersona INNER JOIN historia_clinica hc on hc.idPersona= pe.idPersona INNER JOIN atencion a on a.idHistoria= hc.idHistoriaClinica where nombreNivel = ? and MONTH(fechaAtencion) = ? and YEAR(fechaAtencion) = ?;'
    return db.query(query,
        [nivel,mes, year] , callback);
};

module.exports = PanelModel;