'use strict';
let modelo = require('../models/profile-model'),
    sess = null,
    multiparty = require("multiparty"),
    fs = require('fs-extra'),
    ProfileController = function () {};

ProfileController.open = function( req, res ){
    sess = req.session;
    res.render('profile',{ usuario : sess.usuarioDatos, error: false, listo: false , msg:'' } );
};

ProfileController.upload = function( req, res){
    sess = req.session;
    var form=new multiparty.Form();
    form.parse(req,function(error,fields,files){
        var avatar = files.avatar[0];
        var mime = avatar.headers['content-type'];
        if( mime == 'image/png' || mime == 'image/jpeg' ){
            fs.copy(avatar.path,'public/images/'+sess.usuarioDatos.id+'.jpg',function (err) {
                if(err){
                    console.log(`Ocurrio un error: ${err}`);
                    res.render('profile.html',{error: true, msg:'Ocurrio un error intentelo luego', listo: false , usuario: sess.usuarioDatos});
                }else{
                    res.render('profile.html',{error: false, msg:'Foto actualizada', listo: true , usuario: sess.usuarioDatos});
                }
            });
        }else{
            console.log("Denegado");
            res.render('profile.html',{error: true ,msg:'seleccione un archivo jpg o png', listo: false, usuario: sess.usuarioDatos});
        }
    });
};

ProfileController.reload = function( req, res){
    sess = req.session;
    var datos = {
        id : sess.usuarioDatos.id,
        nombres: req.body.nombre,
        email: req.body.email,
        telefono: req.body.telefono,
        direccion: req.body.direccion
    };
    modelo.reload(datos,function(err, response) {
      if(err){
          console.log(`Ocurrio un error: ${err}`);
          res.render('profile.html',{error: true, msg:'Ocurrio un error intentelo luego', listo: false , usuario: sess.usuarioDatos});
      }else{
          var user = sess.usuarioDatos;
          user.nombre = req.body.nombre;
          user.email = req.body.email;
          user.telefono = req.body.telefono;
          user.direccion = req.body.direccion;
          res.render('profile.html',{error: false, msg:'Datos actualizados', listo: true , usuario: sess.usuarioDatos});
      }
    })
};

module.exports = ProfileController;