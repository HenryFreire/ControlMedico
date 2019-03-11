'use strict'
let db = require('./dbMedical-connection'),
    ProfileModel =  function () {};

ProfileModel.getUser = function(id, inicio, fin, callback ) {
    return db.query('select * from usuario where id = ?', id , callback);
};

ProfileModel.reload = function(datos,callback){
    return db.query('UPDATE usuario SET nombres = ?, email = ?, telefono = ?, direccion = ?  WHERE id = ? ',
        [datos.nombres,
        datos.email,
        datos.telefono,
        datos.direccion,
        datos.id],
        callback);
};

module.exports = ProfileModel;