'use strict'
let db = require('./dbMedical-connection'),
    SearchModel =  function () {};

SearchModel.getLevel = function( callback ) {
    return db.query('select n.nombreNivel from nivel n', callback);
};

SearchModel.loadParalel = function ( nivel, callback ) {
    return db.query('select DISTINCT nombreParalelo  from viewparaleloNivel WHERE nombreNivel = ? ', nivel, callback );
};

SearchModel.listEstudent = function ( nivel, paralelo, callback ) {
    return db.query( 'select * from viewlistaEstudianteNivel where nombreNivel= ? && nombreParalelo= ? ',[nivel, paralelo], callback );
}

SearchModel.listTeachers = function ( callback ) {
    return db.query( 'select * from persona where rolPersona = ? ',['PROFESOR'], callback );
}

SearchModel.allEstudents = function ( callback ) {
    return db.query('select * from  persona where rolPersona = ?',['ESTUDIANTE'], callback )
}



module.exports = SearchModel;