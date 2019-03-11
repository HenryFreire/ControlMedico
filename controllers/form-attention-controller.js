'use strict';
let model = require('../models/form-attention-model'),
    sess = null,
    moment = require('moment'),
    FormAttentionController = function () {};

/*  Carga los datos del paciente  */
FormAttentionController.loadPerson = function ( req, res ){
    sess = req.session;
    let fullName = req.query.q.split('-'),
        person = {};
    model.dataMedical(fullName, function ( error, dataMedical ) {
        if(error){
           console.log( `Erro en la base de datos ${ danger }` );
           res.render( 'form-attention', { usuario : sess.usuarioDatos ,paciente : [], error : true  } );
        }else{
            model.allergie(fullName, function (danger, allergies) {
                if(danger){
                    console.log( `Erro en la base de datos ${ danger }` );
                    res.render( 'form-attention', { usuario : sess.usuarioDatos ,paciente : [], error : true  } );
                }else{
                    model.antecedent(fullName, function (err, antecedents) {
                        if(err){
                            console.log( `Erro en la base de datos ${ danger }` );
                            res.render( 'form-attention', { usuario : sess.usuarioDatos ,paciente : [], error : true  } );
                        }else{
                            model.disease(fullName, function (er, diseases) {
                                if(er){
                                    console.log( `Erro en la base de datos ${ danger }` );
                                    res.render( 'form-attention', { usuario : sess.usuarioDatos ,paciente : [], error : true  } );
                                }else{
                                    person.dataMedical = dataMedical;
                                    person.allergies = allergies;
                                    person.antecedents = antecedents;
                                    person.diseases = diseases;
                                    console.log('servidor  : ',  person.dataMedical)
                                    res.render( 'form-attention', { usuario : sess.usuarioDatos ,paciente : person, error : false  } );
                                }
                            })
                        }
                    })
                }

            })
        }
    });
};

FormAttentionController.newAntecedent = function( req, res ) {
    sess = req.session;
    let parametros = [];
    parametros.push(req.body.idPaciente, req.body.antecedentNombre, req.body.antecedentId);
    console.log(parametros);
    model.newAntecedent(parametros, function ( error, body ) {
       if(error){
           console.log(`Erro en la base de datos ${error}` );
           res.send('error');
       } else{
           res.send(body[0].msg);
       }
    });
};

FormAttentionController.newAllergie = function( req, res ) {
    sess = req.session;
    let parametros = [];
    parametros.push( req.body.idPaciente, req.body.tipo, req.body.tratamiento );
    model.newAllergie(parametros, function ( error, body ) {
        if(error){
            console.log(`Erro en la base de datos ${error}` );
            res.send('error');
        } else{
            res.send(body[0].msg);
        }
    });
};

FormAttentionController.newDisease = function( req, res ) {
    sess = req.session;
    let parametros = [];
    parametros.push( req.body.idPaciente, req.body.tipo, req.body.tratamiento );
    model.newDisease(parametros, function ( error, body ) {
        if(error){
            console.log(`Erro en la base de datos ${error}` );
            res.send('error');
        } else{
            res.send(body[0].msg);
        }
    });
};

FormAttentionController.deleteAntecedent = function ( req ,res ) {
    sess = req.session;
    let parametros = [];
    parametros.push( req.body.nombreAntecedente, req.body.nombreTipo, req.body.idPaciente );
    model.deleteAntecedent(parametros, function( error, body ) {
        if(error){
            console.log(`Erro en la base de datos ${error}` );
            res.send('error');
        }else{
            res.send('selectAntecedente');
        }
    });
};

FormAttentionController.deleteAllergie = function ( req ,res ) {
    sess = req.session;
    let parametros = [];
    parametros.push( req.body.nombreAlergia, req.body.idPaciente );
    model.deleteAllergie(parametros, function( error, body ) {
        if(error){
            console.log(`Erro en la base de datos ${error}` );
            res.send('error');
        }else{
            res.send('selectAlergia');
        }
    });
};

FormAttentionController.deleteDisease = function ( req ,res ) {
    sess = req.session;
    let parametros = [];
    parametros.push( req.body.nombreEnfermedad, req.body.idPaciente );
    model.deleteDisease(parametros, function( error, body ) {
        if(error){
            console.log(`Erro en la base de datos ${error}` );
            res.send('error');
        }else{
            res.send('selectEnfermedad');
        }
    });
};

FormAttentionController.getCie10 = function( req, res) {
    sess = req.session;
    model.getCie10(function( error, body ) {
       if(error){
           console.log(`Erro en la base de datos ${error}` );
           res.send( 'error' );
       } else{
           let option = '<option selected disabled>Seleccionar..</option>';
           body.forEach(function(item){
               option += `<option value="${item.idTipoAtencion}">${item.categoriaTipoAtencion}</option>`;
           });
           res.send(option);
       }
    });
}

FormAttentionController.createHistory = function( req, res ) {
    sess = req.session;
    let idPaciente = req.body.idPaciente;
    console.log('Paciente: ', idPaciente);
    model.createHistory(idPaciente, function(error, body) {
        if(error){
            console.log(`Erro en la base de datos ${error}` );
            res.send( 'error' );
        }else{
            res.send(body);
        }
    });
}

FormAttentionController.newAttention = function( req, res ) {
    sess = req.session;
    let fecha = moment().format('YYYY-MM-DD'),
        hora = moment().format('HH:mm'),
        paciente = new Array();
    paciente.push(
        req.body.idPaciente,
        req.body.nombre,
        fecha,
        hora,
        req.body.sintomas,
        req.body.diagnostico,
        req.body.tratamiento,
        req.body.categoria
    )
    console.log('consulta: ', JSON.stringify(paciente));
    model.newAttention(paciente, function( error, body ) {
        if(error){
            console.log(`Erro en la base de datos ${error}` );
            res.render('attention-finalized',{ usuario : sess.usuarioDatos, paciente : body , listo: false, error: true  });
        }else{
            console.log('Datos insertados ', body);
            res.render('attention-finalized',{ usuario : sess.usuarioDatos, paciente : paciente , listo: true, error: false  });
        }
    })
}

/* Actualizar Datos Medicos */
FormAttentionController.editDatosMedicos = function( req, res ) {
    sess = req.session;
    var datos = new Array();
    datos.push(req.body.peso, req.body.talla, req.body.tipoSangre, req.body.idPersona);
    console.log(`Datos recibidos:  ${datos}`);
    model.editarDatosMedicos(datos, function(error, response) {
        if(error){
            console.log(`Erro en la base de datos ${error}` );
            res.send('error');
        }else{
            res.send('!ok');
        }
    });
}
module.exports = FormAttentionController;