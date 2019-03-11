/* Crea un usuario para el sistema con la contraseña 123 y usuario laSalle@hotmail.edu.ec por defecto */
insert into usuario values ('laSalle@hotmail.com',
                            '$2a$08$jiKszxuZZzS38qRLmf/9Vu9LJIdJrMGhPQIhiRPAQ3BrKhtNJyjUW',
                            'Doctor',
                            'administrador',
                            'Calle CUICHOCA Oe - 54 Y ALFAREROS - COTOCOLLAO',
                            '2535527'  );

DROP view if EXISTS viewlistaEstudianteNivel;
create view viewlistaEstudianteNivel as
select p.idPersona, p.nombrePersona,p.apellidoPersona,nombreNivel, pal.nombreParalelo from persona p
inner join periodoacademico pa on p.idPersona=pa.idPersona
inner join nivel n on n.idNivel=pa.idNivel
inner join paralelo pal on pal.idParalelo= pa.idParalelo;

/*select * from viewlistaEstudianteNivel where nombreNivel='PRIMERO DE BASICA' && nombreParalelo= 'A'*/


DROP view if EXISTS viewAlergia;
create view viewAlergia as
select p.nombrePersona as nombre, p.apellidoPersona as apellido ,nombreAlergia as alergia, tratamientoAlergia as tratamiento from persona p
inner join historia_clinica hc on p.idPersona=hc.idPersona
inner join historia_alergia ha on ha.idHistoria=hc.idHistoriaClinica
inner join alergia a on a.idAlergia = ha.idAlergia;

/* select * from viewalergia */

drop view if EXISTS viewAntecedente;
create view viewAntecedente as
select p.nombrePersona as nombre, p.apellidoPersona as apellido ,
an.nombreAntecedentePatologico as antecedente, ta.nombreTipoAntecedentePatologico as tipo from persona p
inner join historia_clinica hc on p.idPersona=hc.idPersona
inner join historia_antecedente ht on ht.idHistoria=hc.idHistoriaClinica
inner join antecedente an on an.idAntecedentePatologico=ht.idAntecedente
inner join tipo_antecedente ta on ta.idAntecedentePatologico = an.idTipoAntecedentePatologico;

/*select * from viewAntecedente*/
drop view if EXISTS viewEnfermedad;
create view viewEnfermedad as
select p.nombrePersona as nombre, p.apellidoPersona as apellido , e.nombreEnfermedad as enfermedad ,
he.tratamientoEnfermedad as tratamiento from persona p
inner join historia_clinica hc on p.idPersona=hc.idPersona
inner join historia_enfermedad he on he.idHistoria = hc.idHistoriaClinica
inner join enfermedad e on e.idEnfermedad = he.idEnfermedad;

/*select * from viewEnfermedad*/

DROP view if EXISTS viewparaleloNivel;
create view viewparaleloNivel as
select p.nombreParalelo, n.nombreNivel from paralelo p
INNER JOIN periodoacademico pa on pa.idParalelo=p.idParalelo
inner join nivel n on n.idNivel=pa.idNivel;

/*select DISTINCT nombreParalelo  from viewparaleloNivel WHERE nombreNivel = "PRIMERO DE BASICA";*/


DROP FUNCTION IF EXISTS funcionInsertarAlergia;
CREATE FUNCTION funcionInsertarAlergia(
  _idPersona INT ,
  _nombreAlergia VARCHAR (50),
  _tratamientoAlergia VARCHAR(100)
 )
 RETURNS VARCHAR(50)
 BEGIN
  DECLARE _idAlergia INTEGER;
  DECLARE _idHistoriaClinica INTEGER;
  DECLARE msg VARCHAR(50);
    select idHistoriaClinica into _idHistoriaClinica from historia_clinica where idPersona = _idPersona;
    if EXISTS (select nombreAlergia  from alergia where nombreAlergia = _nombreAlergia) THEN
      select idAlergia into _idAlergia from alergia where nombreAlergia = _nombreAlergia ;
      IF EXISTS (select idHistoriaAlergia from historia_alergia where idAlergia = _idAlergia && idHistoria = _idHistoriaClinica  ) THEN
       set msg = 'Ya tiene';
      ELSE
       insert into historia_alergia(idHistoria, idAlergia, tratamientoAlergia) values(_idHistoriaClinica,_idAlergia,_tratamientoAlergia);
       set msg = 'si existe, Datos Insertados';
      END IF;
    else
      insert into alergia(nombreAlergia) values(_nombreAlergia);
      select idAlergia into _idAlergia from alergia where nombreAlergia = _nombreAlergia ;
      insert into historia_alergia(idHistoria, idAlergia, tratamientoAlergia) values(_idHistoriaClinica,_idAlergia,_tratamientoAlergia);
      set msg = 'no existe, Datos Insertados';
   end if;
 RETURN msg;
END;
/*select funcionInsertarAlergia(1,'ALERGIAL AL MANI','NO COMER NUEZ');*/

DROP FUNCTION IF EXISTS funcionInsertarEnfermedades;
CREATE FUNCTION funcionInsertarEnfermedades(
  _idPersona INT ,
  _nombreEnfermedad VARCHAR (50),
  _tratamientoEnfermedad VARCHAR(100)
 )
 RETURNS VARCHAR(50)
 BEGIN
  DECLARE _idEnfermedad INTEGER;
  DECLARE _idHistoriaClinica INTEGER;
  DECLARE msg VARCHAR(50);
    select idHistoriaClinica into _idHistoriaClinica from historia_clinica where idPersona = _idPersona;
    if EXISTS (select nombreEnfermedad  from enfermedad where nombreEnfermedad = _nombreEnfermedad) THEN
      select idEnfermedad into _idEnfermedad from enfermedad where nombreEnfermedad = _nombreEnfermedad ;
       if EXISTS ( select idHistoriaEnfermedad from historia_enfermedad where idEnfermedad = _idEnfermedad && idHistoria = _idHistoriaClinica ) THEN
        set msg = 'Ya tiene';
       ELSE
        insert into historia_enfermedad(idHistoria, idEnfermedad, tratamientoEnfermedad) values(_idHistoriaClinica,_idEnfermedad,_tratamientoEnfermedad);
        set msg = 'si existe, Datos Insertados';
       end if;
    else
      insert into enfermedad(nombreEnfermedad) values(_nombreEnfermedad);
      select idEnfermedad into _idEnfermedad from enfermedad where nombreEnfermedad = _nombreEnfermedad ;
      insert into historia_enfermedad(idHistoria, idEnfermedad, tratamientoEnfermedad) values(_idHistoriaClinica,_idEnfermedad,_tratamientoEnfermedad);
      set msg = 'no existe, Datos Insertados';
   end if;
 RETURN msg;
END;
/*select funcionInsertarEnfermedades(2,'ASMA BRONQUIAL','Antialnagesicos');*/

DROP FUNCTION IF EXISTS funcionInsertarAntecedente;
CREATE FUNCTION funcionInsertarAntecedente(
  _idPersona INT ,
  _nombreAntecedente VARCHAR (50),
  _idTipoAntecedente integer
 )
 RETURNS VARCHAR(50)
 BEGIN
  DECLARE _idAntecedentePatologico INTEGER;
  DECLARE _idHistoriaClinica INTEGER;
  DECLARE msg VARCHAR(50);
    select idHistoriaClinica into _idHistoriaClinica from historia_clinica where idPersona = _idPersona;
   /*Seleciona el id del antecedente por nombre y tipo*/
    select idAntecedentePatologico into _idAntecedentePatologico
           from antecedente
           where nombreAntecedentePatologico = _nombreAntecedente && idTipoAntecedentePatologico=_idTipoAntecedente;
    if exists (select idHistoriaAntecedente from historia_antecedente where idHistoria = _idHistoriaClinica && idAntecedente = _idAntecedentePatologico ) THEN
     set msg = 'Ya tiene';
    ELSE
     if EXISTS (select nombreAntecedentePatologico  from antecedente where nombreAntecedentePatologico = _nombreAntecedente ) THEN

       if (_idAntecedentePatologico) then/* Si el nombre y tipo son iguales  */
          insert into historia_antecedente(idHistoria,idAntecedente)values(_idHistoriaClinica,_idAntecedentePatologico);
          set msg = 'los dos son iguales,insertado';

        ELSE

         insert into antecedente(nombreAntecedentePatologico,idTipoAntecedentePatologico) values(_nombreAntecedente,_idTipoAntecedente);
         select idAntecedentePatologico into _idAntecedentePatologico
           from antecedente
           where nombreAntecedentePatologico = _nombreAntecedente && idTipoAntecedentePatologico=_idTipoAntecedente;
         insert into historia_antecedente(idHistoria,idAntecedente)values(_idHistoriaClinica,_idAntecedentePatologico);
         set msg = 'Solo el nombre es igual,insertado ';

        end if;

    else
       insert into antecedente(nombreAntecedentePatologico,idTipoAntecedentePatologico) values(_nombreAntecedente,_idTipoAntecedente);
       select idAntecedentePatologico into _idAntecedentePatologico
           from antecedente
           where nombreAntecedentePatologico = _nombreAntecedente && idTipoAntecedentePatologico=_idTipoAntecedente;
       insert into historia_antecedente(idHistoria,idAntecedente)values(_idHistoriaClinica,_idAntecedentePatologico);
       set msg = 'no existe el antecedente,insertado';

   end if;
    end if;
 RETURN msg;
END;
/*select funcionInsertarAntecedente(1,'ASMA',1);*/


drop function if exists funcionEditar;
create function funcionEditar(
 _peso double,
 _talla double,
 _tipo  varchar(30),
 _idPersona varchar(30)
)
returns varchar(50)
begin
 declare _idTipo integer;
 declare _msg varchar(50);
  select idGrupoSanguineo into _idTipo from gruposanguineo where nombreGrupoSanguineo = _tipo;
  update  persona  set tallaPersona = _talla , pesoPersona =_peso , idGrupoSanguineo = _idTipo where idPersona =_idPersona ;
  set _msg = 'Datos editados';
return _msg;
end;

/*select funcionEditar(10.24,2.12,'O NEGATIVO',1);*/


drop function if exists funcionBorrarAlergia;
create function funcionBorrarAlergia(
 _nombreAlergia varchar(50),
 _idPersona int
)
returns int
 begin
  declare _msg varchar(80);
  declare _idAlergia int;
  declare _cantidad int;
  declare _idHistoria int ;
  select idHistoriaClinica into _idHistoria from historia_clinica  where idPersona = _idPersona;
  select idAlergia into _idAlergia from alergia where nombreAlergia = _nombreAlergia;
  select count(idAlergia) into _cantidad from historia_alergia where idAlergia = _idAlergia;
    if _cantidad > 1 then
      delete from historia_alergia where idHistoria = _idHistoria && idAlergia = _idAlergia;
    else
      delete from historia_alergia where idHistoria = _idHistoria && idAlergia = _idAlergia;
      delete from alergia where idAlergia = _idAlergia;
    end if;
return _cantidad ;
end;

/*select funcionBorrarAlergia('ALERGIAL A LA NUEZ',2); */

drop function if exists funcionBorrarEnfermedad;
create function funcionBorrarEnfermedad(
 _nombreEnfermedad varchar(50),
 _idPersona int
)
returns varchar(50)
 begin
  declare _idEnfermedad int;
  declare _cantidad int;
  declare _idHistoria int ;
  select idHistoriaClinica into _idHistoria from historia_clinica  where idPersona = _idPersona;
  select idEnfermedad into _idEnfermedad from enfermedad where nombreEnfermedad = _nombreEnfermedad;
  select count(idEnfermedad) into _cantidad from historia_enfermedad where idEnfermedad = _idEnfermedad;
    if _cantidad > 1 then
      delete from historia_enfermedad where idHistoria = _idHistoria && idEnfermedad = _idEnfermedad;
    else
      delete from historia_enfermedad where idHistoria = _idHistoria && idEnfermedad = _idEnfermedad;
      delete from enfermedad where idEnfermedad = _idEnfermedad;
    end if;
return 'Borrado' ;
end;

/*select funcionBorrarEnfermedad('nombre enfermedad',1);*/

DROP FUNCTION IF EXISTS funcionBorrarAntecedente;
CREATE FUNCTION funcionBorrarAntecedente(
  _nombreAntecedente VARCHAR (50) ,
  _nombreTipoAntecedente varchar (50),
  _idPersona INT
 )
 RETURNS VARCHAR(50)
 begin
  declare _idAntecedente int;
  declare _idTipoAntecedente int;
  declare _cantidad int;
  declare _idHistoria int ;
  declare _msg varchar(50);
  select idHistoriaClinica into _idHistoria from historia_clinica  where idPersona = _idPersona;
  select idAntecedentePatologico into _idTipoAntecedente from tipo_antecedente where nombreTipoAntecedentePatologico =  _nombreTipoAntecedente;
  select idAntecedentePatologico into _idAntecedente from antecedente where nombreAntecedentePatologico = _nombreAntecedente && idTipoAntecedentePatologico = _idTipoAntecedente;
  select count(idAntecedente) into _cantidad from historia_antecedente where idAntecedente = _idAntecedente;
    if _cantidad > 1 then
       delete from historia_antecedente where idHistoria = _idHistoria && idAntecedente = _idAntecedente;
       set _msg = 'mas de 1 tiene, borrado';
    else
       set _msg = '1 tiene, borrado ';
      delete from historia_antecedente where idHistoria = _idHistoria && idAntecedente = _idAntecedente;
      delete from antecedente where idAntecedentePatologico = _idAntecedente && idTipoAntecedentePatologico = _idTipoAntecedente;
    end if;
return _msg ;
end;
/*select funcionBorrarAntecedente ('A','OTRO',2);*/

drop function if exists guardarConsulta;
create function guardarConsulta(
  _idPersona int,
  _nombre varchar(50),
  _fecha Date,
  _hora varchar(6) ,
  _sintomas varchar(250),
  _diagnostico varchar(250),
  _tratamiento varchar(250),
  _idNombreCategoria varchar(100)
)
RETURNS varchar(50)
BEGIN
  declare _idHistorial int;
  declare _idTipoAtencion int;
  select idHistoriaClinica into _idHistorial from historia_clinica where idPersona = _idPersona;

  insert into atencion(nombreAtencion,fechaAtencion,horaAtencion,idHistoria,sintomasAtencion,diagnosticoAtencion,tratamientoAtencion,idTipoAtencion)
              values(_nombre,_fecha,_hora,_idHistorial,_sintomas,_diagnostico,_tratamiento,_idNombreCategoria);

RETURN 'ok';
END;
/*select guardarConsulta(1,'ADRIAN JAVIER PAUCAR GONZALES','2017-06-12','19:26','dolor, fiebre','Gripe','Analgesicos','ENFERMEDADES RESPIRATORIAS');*/

/*  Crea el id de la persona para la consultas rapidas */
drop function if EXISTS consultaRapidaPersona;
create function consultaRapidaPersona()
RETURNS varchar(52)
BEGIN
 declare msg varchar(50);
 declare _idPersona varchar(20);
  if EXISTS (select idPersona from  persona where idPersona = 'consultaRapida') THEN
     set msg = 'Ya existe el id de consulta rapida';
   ELSE
     insert into persona(idPersona) value('consultaRapida');
     select idPersona into _idPersona from  persona where idPersona = 'consultaRapida';
     insert into historia_clinica(idHistoriaClinica, idPersona) values('consultaRapida',_idPersona);
     set msg = 'No existe pero ya se creo';
   end if;

return msg;
end;

/*select consultaRapidaPersona();*/

drop function if exists consultaRapida;
create function consultaRapida(
  _nombre varchar(50),
  _fecha Date,
  _hora varchar(6) ,
  _sintomas varchar(250),
  _diagnostico varchar(250),
  _tratamiento varchar(250),
  _nombreCategoria varchar(100)
)
RETURNS varchar(50)
BEGIN
  declare _idTipoAtencion int;
  select idTipoAtencion into _idTipoAtencion from tipoatencion where categoriaTipoAtencion = _nombreCategoria;
  insert into atencion(nombreAtencion,fechaAtencion,horaAtencion,idHistoria,sintomasAtencion,diagnosticoAtencion,tratamientoAtencion,idTipoAtencion)
              values(_nombre,_fecha,_hora,'consultaRapida',_sintomas,_diagnostico,_tratamiento,_idTipoAtencion);
RETURN 'Ok';
END;
/*SELECT consultaRapida('prueba','2017-06-12','9:00','dolor de cabeza','gripe','descanzo','ENFERMEDADES RESPIRATORIAS');*/


drop function if exists crearHistorial;
create function crearHistorial(_idPersona varchar(250))
returns varchar(50)
BEGIN
  declare msg varchar(50);
  declare _codigoHistorial varchar(250);
  if EXISTS( select idHistoriaClinica from historia_clinica where idPersona = _idPersona ) THEN
    set msg = 'Ya tiene historial';
  ELSE
    select count(idHistoriaClinica)+1 into _codigoHistorial from historia_clinica;
    INSERT into historia_clinica values(_codigoHistorial,_idPersona);
    set msg = 'Historial creado';
  end if;
return msg;
END;
/*select crearHistorial(1)*/
