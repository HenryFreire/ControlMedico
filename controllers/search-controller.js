'use strict';
let model = require('../models/search-model'),
    sess = null,
    SearchController = function () {};

SearchController.open = function ( req, res ) {
    sess = req.session;
    model.getLevel(function( error, lvl ) {
       if(error) {
           console.log(`Error : ${error}`);
           res.render('search',{usuario : sess.usuarioDatos, error : true, nivel : [], profesores: [], estudiantes: [] } );
       }else {
           model.listTeachers(function(err, teachers){
               if(err){
                   console.log(`Error : ${err}`);
                   res.render('search',{usuario : sess.usuarioDatos, error : true, nivel : [], profesores: [], studiantes: [] } );
               }else{
                   model.allEstudents(function(er, students){
                        if(er){
                            console.log(`Error : ${er}`);
                            res.render('search',{usuario : sess.usuarioDatos, error : true, nivel : [], profesores: [], studiantes: [] } );
                        }else{
                            console.log('los estudiantes son: ', students);
                            res.render('search',{usuario : sess.usuarioDatos, error : false, nivel : lvl, profesores: teachers, estudiantes: students } )
                        }
                   })

               }
           });
       }
    });
};

SearchController.loadParalel = function ( req, res ) {
  model.loadParalel(req.body.nivel,function(error, body) {
      if(error){
          console.log(`Error en la base de datos: ${error}`);
      }else{
         let item = `<option value="" disabled selected>Seleccionar</option>`;
         body.forEach(function (elemento) {
             let paralelo = elemento.nombreParalelo
             item += `<option value="${paralelo}"> ${paralelo} </option>`
         });
          res.send(item);
      }
  });
};

SearchController.loadTable = function ( req, res ) {
 model.listEstudent(req.body.nivel, req.body.paralelo, function (error, students) {
     if(error){
         console.log(`Error en la base de datos: ${error}`);
     }else{
        res.send(students);
     }

 });
};


module.exports = SearchController;