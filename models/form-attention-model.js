'use strict';
let db = require('./dbMedical-connection'),
    FormAttentionModel =  function () {};

FormAttentionModel.dataMedical = function ( fullName, callback ) {
    return db.query('select * from persona p inner join gruposanguineo gs on p.idGrupoSanguineo=gs.idGrupoSanguineo  where nombrePersona = ? && apellidoPersona = ?', fullName, callback );
};

FormAttentionModel.allergie = function ( fullName, callback ) {
    return db.query('select alergia, tratamiento from viewAlergia  where nombre = ? && apellido = ? ', fullName, callback);
};

FormAttentionModel.antecedent = function ( fullname, callback ) {
    return db.query('select antecedente, tipo from viewAntecedente  where nombre = ? && apellido = ? ', fullname, callback);
};

FormAttentionModel.disease = function ( fullname, callback ) {
    return db.query('select enfermedad,tratamiento from viewEnfermedad where nombre = ? && apellido = ?', fullname, callback);
};

FormAttentionModel.newAntecedent = function ( parametros, callback ) {
    return db.query('select funcionInsertarAntecedente (?,?,?) msg', parametros, callback);
};

FormAttentionModel.newAllergie = function ( parametros, callback ) {
    return db.query('select funcionInsertarAlergia(?,?,?) msg', parametros, callback);
};

FormAttentionModel.newDisease = function ( parametros, callback ) {
    return db.query('select funcionInsertarEnfermedades(?,?,?) msg', parametros, callback);
};

FormAttentionModel.deleteAntecedent = function ( parametros, callback ) {
    return db.query('select funcionBorrarAntecedente (?,?,?)', parametros, callback);
};

FormAttentionModel.deleteAllergie = function ( parametros, callback ) {
    return db.query('select funcionBorrarAlergia (?,?)', parametros, callback);
};

FormAttentionModel.deleteDisease = function ( parametros, callback ) {
    return db.query('select funcionBorrarEnfermedad (?,?)', parametros, callback);
};


FormAttentionModel.getCie10 = function ( callback ) {
    return db.query('select * from tipoatencion', callback);
};

FormAttentionModel.createHistory = function ( idPaciente, callback ) {
    return db.query('select crearHistorial(?)', idPaciente, callback);
};

FormAttentionModel.newAttention = function( paciente, callback ) {
    return db.query('select guardarConsulta (?,?,?,?,?,?,?,?)', paciente, callback);
}

FormAttentionModel.editarDatosMedicos = function( datos, callback ) {
    return db.query('select funcionEditar(?,?,?,?)', datos, callback);
}



module.exports = FormAttentionModel;