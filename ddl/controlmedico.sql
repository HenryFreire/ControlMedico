/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : controlmedico

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2019-03-10 20:24:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `alergia`
-- ----------------------------
DROP TABLE IF EXISTS `alergia`;
CREATE TABLE `alergia` (
  `idAlergia` tinyint(255) NOT NULL AUTO_INCREMENT,
  `nombreAlergia` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idAlergia`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of alergia
-- ----------------------------
INSERT INTO `alergia` VALUES ('1', 'ALERGI AL PELO DE ANIMALES');
INSERT INTO `alergia` VALUES ('2', 'PICADURA DE INSECTOS');
INSERT INTO `alergia` VALUES ('13', 'L');
INSERT INTO `alergia` VALUES ('15', 'SDF');
INSERT INTO `alergia` VALUES ('16', 'FDSAD');
INSERT INTO `alergia` VALUES ('17', 'TYFTYFGY');
INSERT INTO `alergia` VALUES ('18', 'YYY');

-- ----------------------------
-- Table structure for `antecedente`
-- ----------------------------
DROP TABLE IF EXISTS `antecedente`;
CREATE TABLE `antecedente` (
  `idAntecedentePatologico` tinyint(255) NOT NULL AUTO_INCREMENT,
  `nombreAntecedentePatologico` varchar(255) NOT NULL,
  `idTipoAntecedentePatologico` tinyint(4) NOT NULL,
  PRIMARY KEY (`idAntecedentePatologico`),
  KEY `fkTipo` (`idTipoAntecedentePatologico`),
  CONSTRAINT `fkTipo` FOREIGN KEY (`idTipoAntecedentePatologico`) REFERENCES `tipo_antecedente` (`idAntecedentePatologico`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of antecedente
-- ----------------------------
INSERT INTO `antecedente` VALUES ('2', 'FGHDFGHDFG', '3');
INSERT INTO `antecedente` VALUES ('3', 'HGVGHVGH', '2');
INSERT INTO `antecedente` VALUES ('4', 'EEEE', '1');

-- ----------------------------
-- Table structure for `atencion`
-- ----------------------------
DROP TABLE IF EXISTS `atencion`;
CREATE TABLE `atencion` (
  `idAtencion` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombreAtencion` varchar(50) NOT NULL,
  `fechaAtencion` date NOT NULL,
  `horaAtencion` varchar(6) NOT NULL,
  `idHistoria` varchar(50) NOT NULL,
  `sintomasAtencion` varchar(255) NOT NULL,
  `diagnosticoAtencion` varchar(255) NOT NULL,
  `tratamientoAtencion` varchar(255) NOT NULL,
  `idTipoAtencion` smallint(255) NOT NULL,
  PRIMARY KEY (`idAtencion`),
  KEY `fkHistoriaAte` (`idHistoria`),
  KEY `fkTipoAtencion` (`idTipoAtencion`),
  CONSTRAINT `fkHistoriaAte` FOREIGN KEY (`idHistoria`) REFERENCES `historia_clinica` (`idHistoriaClinica`),
  CONSTRAINT `fkTipoAtencion` FOREIGN KEY (`idTipoAtencion`) REFERENCES `tipoatencion` (`idTipoAtencion`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of atencion
-- ----------------------------
INSERT INTO `atencion` VALUES ('86', 'ADRIAN JAVIER PAUCAR GONZALES', '2018-07-14', '16:53', '1', 'fghf,ghfgh,fgh,fg,h,hfghfgh', 'fghfghfghfgh', 'fghfghfgh', '10');
INSERT INTO `atencion` VALUES ('87', 'ADRIAN JAVIER PAUCAR GONZALES', '2019-03-10', '20:17', '1', 'sdfgsdf,sdfg', 'wertwer', 'wert', '5');

-- ----------------------------
-- Table structure for `enfermedad`
-- ----------------------------
DROP TABLE IF EXISTS `enfermedad`;
CREATE TABLE `enfermedad` (
  `idEnfermedad` tinyint(255) NOT NULL AUTO_INCREMENT,
  `nombreEnfermedad` varchar(50) NOT NULL,
  PRIMARY KEY (`idEnfermedad`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of enfermedad
-- ----------------------------
INSERT INTO `enfermedad` VALUES ('2', 'DESMAYOS Y MAREOS');
INSERT INTO `enfermedad` VALUES ('4', 'ASMA BRONQUIAL');
INSERT INTO `enfermedad` VALUES ('6', 'SDFGSD');

-- ----------------------------
-- Table structure for `gruposanguineo`
-- ----------------------------
DROP TABLE IF EXISTS `gruposanguineo`;
CREATE TABLE `gruposanguineo` (
  `idGrupoSanguineo` smallint(6) NOT NULL,
  `nombreGrupoSanguineo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idGrupoSanguineo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gruposanguineo
-- ----------------------------
INSERT INTO `gruposanguineo` VALUES ('1', 'A POSITIVO');
INSERT INTO `gruposanguineo` VALUES ('2', 'A NEGATIVO');
INSERT INTO `gruposanguineo` VALUES ('3', 'B POSITIVO');
INSERT INTO `gruposanguineo` VALUES ('4', 'B NEGATIVO');
INSERT INTO `gruposanguineo` VALUES ('5', 'AB POSITIVO');
INSERT INTO `gruposanguineo` VALUES ('6', 'AB NEGATIVO');
INSERT INTO `gruposanguineo` VALUES ('7', 'O POSITIVO');
INSERT INTO `gruposanguineo` VALUES ('8', 'O NEGATIVO');

-- ----------------------------
-- Table structure for `historia_alergia`
-- ----------------------------
DROP TABLE IF EXISTS `historia_alergia`;
CREATE TABLE `historia_alergia` (
  `idHistoriaAlergia` int(255) NOT NULL AUTO_INCREMENT,
  `idHistoria` varchar(50) NOT NULL,
  `idAlergia` tinyint(255) NOT NULL,
  `tratamientoAlergia` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idHistoriaAlergia`),
  KEY `fkHistoriaAle` (`idHistoria`),
  KEY `fkAlergia` (`idAlergia`),
  CONSTRAINT `fkAlergia` FOREIGN KEY (`idAlergia`) REFERENCES `alergia` (`idAlergia`),
  CONSTRAINT `fkHistoriaAle` FOREIGN KEY (`idHistoria`) REFERENCES `historia_clinica` (`idHistoriaClinica`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of historia_alergia
-- ----------------------------
INSERT INTO `historia_alergia` VALUES ('2', '1', '15', 'ASDF');
INSERT INTO `historia_alergia` VALUES ('3', '3', '16', 'ASDF');
INSERT INTO `historia_alergia` VALUES ('4', '1', '17', 'FGHFGHFGH');
INSERT INTO `historia_alergia` VALUES ('5', '1', '18', '222');

-- ----------------------------
-- Table structure for `historia_antecedente`
-- ----------------------------
DROP TABLE IF EXISTS `historia_antecedente`;
CREATE TABLE `historia_antecedente` (
  `idHistoriaAntecedente` tinyint(255) NOT NULL AUTO_INCREMENT,
  `idHistoria` varchar(50) NOT NULL,
  `idAntecedente` tinyint(255) DEFAULT NULL,
  PRIMARY KEY (`idHistoriaAntecedente`),
  KEY `fkHistoria` (`idHistoria`),
  KEY `fkAnt` (`idAntecedente`),
  CONSTRAINT `fkAnt` FOREIGN KEY (`idAntecedente`) REFERENCES `antecedente` (`idAntecedentePatologico`),
  CONSTRAINT `fkHistoria` FOREIGN KEY (`idHistoria`) REFERENCES `historia_clinica` (`idHistoriaClinica`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of historia_antecedente
-- ----------------------------
INSERT INTO `historia_antecedente` VALUES ('2', '3', '2');
INSERT INTO `historia_antecedente` VALUES ('3', '1', '3');
INSERT INTO `historia_antecedente` VALUES ('4', '1', '4');

-- ----------------------------
-- Table structure for `historia_clinica`
-- ----------------------------
DROP TABLE IF EXISTS `historia_clinica`;
CREATE TABLE `historia_clinica` (
  `idHistoriaClinica` varchar(20) NOT NULL,
  `idPersona` varchar(15) NOT NULL,
  KEY `fk_persona` (`idPersona`),
  KEY `idHistoriaClinica` (`idHistoriaClinica`),
  CONSTRAINT `fk_persona` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of historia_clinica
-- ----------------------------
INSERT INTO `historia_clinica` VALUES ('1', '1');
INSERT INTO `historia_clinica` VALUES ('2', '2');
INSERT INTO `historia_clinica` VALUES ('3', '1727016295');
INSERT INTO `historia_clinica` VALUES ('consultaRapida', 'consultaRapida');
INSERT INTO `historia_clinica` VALUES ('4', '123456789');
INSERT INTO `historia_clinica` VALUES ('6', '111111111');

-- ----------------------------
-- Table structure for `historia_enfermedad`
-- ----------------------------
DROP TABLE IF EXISTS `historia_enfermedad`;
CREATE TABLE `historia_enfermedad` (
  `idHistoriaEnfermedad` tinyint(255) NOT NULL AUTO_INCREMENT,
  `idHistoria` varchar(50) NOT NULL,
  `idEnfermedad` tinyint(255) NOT NULL,
  `tratamientoEnfermedad` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idHistoriaEnfermedad`),
  KEY `fkHistoriaEnf` (`idHistoria`),
  KEY `fkEnfermedad` (`idEnfermedad`),
  CONSTRAINT `fkEnfermedad` FOREIGN KEY (`idEnfermedad`) REFERENCES `enfermedad` (`idEnfermedad`),
  CONSTRAINT `fkHistoriaEnf` FOREIGN KEY (`idHistoria`) REFERENCES `historia_clinica` (`idHistoriaClinica`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of historia_enfermedad
-- ----------------------------
INSERT INTO `historia_enfermedad` VALUES ('2', '2', '4', 'Antialnagesicos');
INSERT INTO `historia_enfermedad` VALUES ('4', '3', '6', 'GSDFGSD');

-- ----------------------------
-- Table structure for `nivel`
-- ----------------------------
DROP TABLE IF EXISTS `nivel`;
CREATE TABLE `nivel` (
  `idNivel` smallint(6) NOT NULL AUTO_INCREMENT,
  `nombreNivel` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idNivel`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nivel
-- ----------------------------
INSERT INTO `nivel` VALUES ('1', 'PRIMERO DE BASICA');
INSERT INTO `nivel` VALUES ('2', 'SEGUNDO DE BASICA ELEMENTAL');
INSERT INTO `nivel` VALUES ('3', 'TERCERO DE BASICA ELEMENTAL');
INSERT INTO `nivel` VALUES ('4', 'CUARTO DE BASICA ELEMENTAL');
INSERT INTO `nivel` VALUES ('5', 'QUINTO DE BASICA MEDIA ');
INSERT INTO `nivel` VALUES ('6', 'SEXTO DE BASICA MEDIA');
INSERT INTO `nivel` VALUES ('7', 'SEPTIMO DE BASICA MEDIA');
INSERT INTO `nivel` VALUES ('8', 'OCTAVO DE BASICA SUPERIOR');
INSERT INTO `nivel` VALUES ('9', 'NOVENO DE BASICA SUPERIOR');
INSERT INTO `nivel` VALUES ('10', 'DECIMO DE BASICA SUPERIOR ');
INSERT INTO `nivel` VALUES ('11', 'PRIMER AÑO DE BACHILLERATO EN CIENCIAS(GENERAL)');
INSERT INTO `nivel` VALUES ('12', 'SEGUNDO AÑO DE BACHILLERATO EN CIENCIAS (GENERAL)');
INSERT INTO `nivel` VALUES ('13', 'TERCER AÑO DE BACHILLERATO EN CIENCIAS (GENERAL)');

-- ----------------------------
-- Table structure for `paralelo`
-- ----------------------------
DROP TABLE IF EXISTS `paralelo`;
CREATE TABLE `paralelo` (
  `idParalelo` smallint(6) NOT NULL AUTO_INCREMENT,
  `nombreParalelo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idParalelo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paralelo
-- ----------------------------
INSERT INTO `paralelo` VALUES ('1', 'A');
INSERT INTO `paralelo` VALUES ('2', 'B');
INSERT INTO `paralelo` VALUES ('3', 'C');

-- ----------------------------
-- Table structure for `periodoacademico`
-- ----------------------------
DROP TABLE IF EXISTS `periodoacademico`;
CREATE TABLE `periodoacademico` (
  `idPeriodoAcademico` smallint(6) NOT NULL AUTO_INCREMENT,
  `nombrePeriodoAcademico` varchar(100) DEFAULT NULL,
  `idNivel` smallint(6) DEFAULT NULL,
  `idParalelo` smallint(6) DEFAULT NULL,
  `idPersona` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`idPeriodoAcademico`),
  KEY `idNivel` (`idNivel`),
  KEY `idParalelo` (`idParalelo`),
  KEY `idPersona` (`idPersona`),
  CONSTRAINT `idNivel` FOREIGN KEY (`idNivel`) REFERENCES `nivel` (`idNivel`),
  CONSTRAINT `idParalelo` FOREIGN KEY (`idParalelo`) REFERENCES `paralelo` (`idParalelo`),
  CONSTRAINT `idPersona` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of periodoacademico
-- ----------------------------
INSERT INTO `periodoacademico` VALUES ('1', 'ENERO-JUNIO', '1', '1', '1');
INSERT INTO `periodoacademico` VALUES ('2', 'ENERO-JUNIO', '1', '2', '2');
INSERT INTO `periodoacademico` VALUES ('3', 'JUNIO-DICIEMBRE', '1', '2', '1727016295');
INSERT INTO `periodoacademico` VALUES ('4', 'JUNIO-DICIEMBRE', '10', '1', '111111111');

-- ----------------------------
-- Table structure for `persona`
-- ----------------------------
DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona` (
  `idPersona` varchar(15) NOT NULL,
  `nombrePersona` varchar(50) DEFAULT NULL,
  `apellidoPersona` varchar(50) DEFAULT NULL,
  `generoPersona` varchar(10) DEFAULT NULL,
  `estadocivilPersona` varchar(10) DEFAULT NULL,
  `telfDomicilioPersona` varchar(20) DEFAULT NULL,
  `telfCelularPersona` varchar(20) DEFAULT NULL,
  `fechaNacimientoPersona` varchar(30) DEFAULT NULL,
  `tallaPersona` double(10,2) DEFAULT NULL,
  `pesoPersona` double(10,2) DEFAULT NULL,
  `rolPersona` varchar(10) DEFAULT NULL,
  `idGrupoSanguineo` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`idPersona`),
  KEY `fkGrupoSanguineo` (`idGrupoSanguineo`),
  CONSTRAINT `fkGrupoSanguineo` FOREIGN KEY (`idGrupoSanguineo`) REFERENCES `gruposanguineo` (`idGrupoSanguineo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of persona
-- ----------------------------
INSERT INTO `persona` VALUES ('1', 'ADRIAN JAVIER', 'PAUCAR GONZALES', 'MASCULINO', 'SOLTERO', '2658747', '0987415874', '11/01/1999', '1.80', '60.03', 'ESTUDIANTE', '5');
INSERT INTO `persona` VALUES ('111111111', 'Anita Daniela', 'Alvarez Ramirez', 'FEMENINO', 'CASADA', '265646684', '0974684654', '08/04/1193', '2.00', '49.32', 'ESTUDIANTE', '6');
INSERT INTO `persona` VALUES ('123456789', 'Cistian Alejandro', 'Enriquez ', 'masculino', 'CASADO', '1111122', '0968745874', '08/05/1996', '1.60', '60.10', 'PROFESOR', '8');
INSERT INTO `persona` VALUES ('1727016295', 'HENRY PAUL', 'FREIRE RAMIREZ', 'MASCULINO', 'SOLTERO', '3033329', '0985784574', '22/04/1993', '1.70', '48.00', 'ESTUDIANTE', '5');
INSERT INTO `persona` VALUES ('2', 'JOSE ALEJANDRO', 'VARGAS SUAREZ', 'masculino', 'SOLTERO', '2574874', '0547874785', '08/04/1988', '1.80', '54.20', 'ESTUDIANTE', '4');
INSERT INTO `persona` VALUES ('consultaRapida', null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `tipoatencion`
-- ----------------------------
DROP TABLE IF EXISTS `tipoatencion`;
CREATE TABLE `tipoatencion` (
  `idTipoAtencion` smallint(6) NOT NULL,
  `categoriaTipoAtencion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idTipoAtencion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tipoatencion
-- ----------------------------
INSERT INTO `tipoatencion` VALUES ('1', '(A00-B99) Ciertas enfermedades infecciosas y parasitarias');
INSERT INTO `tipoatencion` VALUES ('2', '(C00-D48) Neoplasias');
INSERT INTO `tipoatencion` VALUES ('3', '(D50-D89) Enfermedades de la sangre y de los órganos hematopoyéticos y otros trastornos que afectan el mecanismo de la inmunidad');
INSERT INTO `tipoatencion` VALUES ('4', '(E00-E90) Enfermedades endocrinas, nutricionales y metabólicas');
INSERT INTO `tipoatencion` VALUES ('5', '(F00-F99) Trastornos mentales y del comportamiento');
INSERT INTO `tipoatencion` VALUES ('6', '(G00-G99) Enfermedades del sistema nervioso');
INSERT INTO `tipoatencion` VALUES ('7', '(H00-H59) Enfermedades del ojo y sus anexos');
INSERT INTO `tipoatencion` VALUES ('8', '(H60-H95) Enfermedades del oído y de la apófisis mastoides');
INSERT INTO `tipoatencion` VALUES ('9', '(I00-I99) Enfermedades del sistema circulatorio');
INSERT INTO `tipoatencion` VALUES ('10', '(J00-J99) Enfermedades del sistema respiratorio');
INSERT INTO `tipoatencion` VALUES ('11', '(K00-K93) Enfermedades del aparato digestivo');
INSERT INTO `tipoatencion` VALUES ('12', '(L00-L99) Enfermedades de la piel y el tejido subcutáneo');
INSERT INTO `tipoatencion` VALUES ('13', '(M00-M99) Enfermedades del sistema osteomuscular y del tejido conectivo');
INSERT INTO `tipoatencion` VALUES ('14', '(N00-N99) Enfermedades del aparato genitourinario');
INSERT INTO `tipoatencion` VALUES ('15', '(O00-O99) Embarazo, parto y puerperio');
INSERT INTO `tipoatencion` VALUES ('16', '(P00-P96) Ciertas afecciones originadas en el periodo perinatal');
INSERT INTO `tipoatencion` VALUES ('17', '(Q00-Q99) Malformaciones congénitas, deformidades y anomalías cromosómicas');
INSERT INTO `tipoatencion` VALUES ('18', '(R00-R99) Síntomas, signos y hallazgos anormales clínicos y de laboratorio, no clasificados en otra parte');
INSERT INTO `tipoatencion` VALUES ('19', '(S00-T98)Traumatismos, envenenamientos y algunas otras consecuencias de causa externa');
INSERT INTO `tipoatencion` VALUES ('20', '(V01-Y98) Causas externas de morbilidad y de mortalidad');
INSERT INTO `tipoatencion` VALUES ('21', '(Z00-Z99) Factores que influyen en el estado de salud y contacto con los servicios de salud');
INSERT INTO `tipoatencion` VALUES ('22', '(U00-U99) Códigos para situaciones especiales');

-- ----------------------------
-- Table structure for `tipo_antecedente`
-- ----------------------------
DROP TABLE IF EXISTS `tipo_antecedente`;
CREATE TABLE `tipo_antecedente` (
  `idAntecedentePatologico` tinyint(255) NOT NULL AUTO_INCREMENT,
  `nombreTipoAntecedentePatologico` varchar(255) NOT NULL,
  PRIMARY KEY (`idAntecedentePatologico`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tipo_antecedente
-- ----------------------------
INSERT INTO `tipo_antecedente` VALUES ('1', ' PATOLÓGICO');
INSERT INTO `tipo_antecedente` VALUES ('2', 'NO PATOLÓGICO');
INSERT INTO `tipo_antecedente` VALUES ('3', 'HEREDOFAMILIARES');
INSERT INTO `tipo_antecedente` VALUES ('4', 'OTRO');

-- ----------------------------
-- Table structure for `usuario`
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `password` varchar(80) NOT NULL,
  `nombres` varchar(25) NOT NULL,
  `rol` varchar(20) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` int(12) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES ('1', 'hfreire@itelsys.com.ec', '$2a$08$KWq21TjVQBNCUkrGvWVeO.54dvxBrthnDeD76xAC3VHWUm5i5dCWq', 'admin', 'administrador', 'Calle CUICHOCA Oe - 54 Y ALFAREROS - COTOCOLLAO', '2535527');
INSERT INTO `usuario` VALUES ('2', 'laSalle@hotmail.edu.ec', '$2a$08$jiKszxuZZzS38qRLmf/9Vu9LJIdJrMGhPQIhiRPAQ3BrKhtNJyjUW', 'LA SALLE', 'administrador', 'Cotocollao', '98745877');

-- ----------------------------
-- View structure for `viewalergia`
-- ----------------------------
DROP VIEW IF EXISTS `viewalergia`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewalergia` AS select `p`.`nombrePersona` AS `nombre`,`p`.`apellidoPersona` AS `apellido`,`a`.`nombreAlergia` AS `alergia`,`ha`.`tratamientoAlergia` AS `tratamiento` from (((`persona` `p` join `historia_clinica` `hc` on((`p`.`idPersona` = `hc`.`idPersona`))) join `historia_alergia` `ha` on((`ha`.`idHistoria` = `hc`.`idHistoriaClinica`))) join `alergia` `a` on((`a`.`idAlergia` = `ha`.`idAlergia`))) ;

-- ----------------------------
-- View structure for `viewantecedente`
-- ----------------------------
DROP VIEW IF EXISTS `viewantecedente`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewantecedente` AS select `p`.`nombrePersona` AS `nombre`,`p`.`apellidoPersona` AS `apellido`,`an`.`nombreAntecedentePatologico` AS `antecedente`,`ta`.`nombreTipoAntecedentePatologico` AS `tipo` from ((((`persona` `p` join `historia_clinica` `hc` on((`p`.`idPersona` = `hc`.`idPersona`))) join `historia_antecedente` `ht` on((`ht`.`idHistoria` = `hc`.`idHistoriaClinica`))) join `antecedente` `an` on((`an`.`idAntecedentePatologico` = `ht`.`idAntecedente`))) join `tipo_antecedente` `ta` on((`ta`.`idAntecedentePatologico` = `an`.`idTipoAntecedentePatologico`))) ;

-- ----------------------------
-- View structure for `viewenfermedad`
-- ----------------------------
DROP VIEW IF EXISTS `viewenfermedad`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewenfermedad` AS select `p`.`nombrePersona` AS `nombre`,`p`.`apellidoPersona` AS `apellido`,`e`.`nombreEnfermedad` AS `enfermedad`,`he`.`tratamientoEnfermedad` AS `tratamiento` from (((`persona` `p` join `historia_clinica` `hc` on((`p`.`idPersona` = `hc`.`idPersona`))) join `historia_enfermedad` `he` on((`he`.`idHistoria` = `hc`.`idHistoriaClinica`))) join `enfermedad` `e` on((`e`.`idEnfermedad` = `he`.`idEnfermedad`))) ;

-- ----------------------------
-- View structure for `viewlistaestudiantenivel`
-- ----------------------------
DROP VIEW IF EXISTS `viewlistaestudiantenivel`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewlistaestudiantenivel` AS select `p`.`idPersona` AS `idPersona`,`p`.`nombrePersona` AS `nombrePersona`,`p`.`apellidoPersona` AS `apellidoPersona`,`n`.`nombreNivel` AS `nombreNivel`,`pal`.`nombreParalelo` AS `nombreParalelo` from (((`persona` `p` join `periodoacademico` `pa` on((`p`.`idPersona` = `pa`.`idPersona`))) join `nivel` `n` on((`n`.`idNivel` = `pa`.`idNivel`))) join `paralelo` `pal` on((`pal`.`idParalelo` = `pa`.`idParalelo`))) ;

-- ----------------------------
-- View structure for `viewparalelonivel`
-- ----------------------------
DROP VIEW IF EXISTS `viewparalelonivel`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewparalelonivel` AS select `p`.`nombreParalelo` AS `nombreParalelo`,`n`.`nombreNivel` AS `nombreNivel` from ((`paralelo` `p` join `periodoacademico` `pa` on((`pa`.`idParalelo` = `p`.`idParalelo`))) join `nivel` `n` on((`n`.`idNivel` = `pa`.`idNivel`))) ;

-- ----------------------------
-- View structure for `wieatencionnivel`
-- ----------------------------
DROP VIEW IF EXISTS `wieatencionnivel`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wieatencionnivel` AS select count(distinct `a`.`nombreAtencion`) AS `COUNT(DISTINCT  a.nombreAtencion)`,`n`.`nombreNivel` AS `nombreNivel` from ((((`nivel` `n` join `periodoacademico` `pa` on((`pa`.`idNivel` = `n`.`idNivel`))) join `persona` `pe` on((`pe`.`idPersona` = `pa`.`idPersona`))) join `historia_clinica` `hc` on((`hc`.`idPersona` = `pe`.`idPersona`))) join `atencion` `a` on((`a`.`idHistoria` = `hc`.`idHistoriaClinica`))) where (`n`.`nombreNivel` = 'DECIMO DE BASICA SUPERIOR') ;

-- ----------------------------
-- Function structure for `consultaRapida`
-- ----------------------------
DROP FUNCTION IF EXISTS `consultaRapida`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `consultaRapida`(
  _nombre varchar(50),
  _fecha Date,
  _hora varchar(6) ,
  _sintomas varchar(250),
  _diagnostico varchar(250),
  _tratamiento varchar(250),
  _nombreCategoria varchar(100)
) RETURNS varchar(50) CHARSET utf8
BEGIN
  declare _idTipoAtencion int;
  select idTipoAtencion into _idTipoAtencion from tipoatencion where categoriaTipoAtencion = _nombreCategoria;
  insert into atencion(nombreAtencion,fechaAtencion,horaAtencion,idHistoria,sintomasAtencion,diagnosticoAtencion,tratamientoAtencion,idTipoAtencion)
              values(_nombre,_fecha,_hora,'consultaRapida',_sintomas,_diagnostico,_tratamiento,_idTipoAtencion);
RETURN 'Ok';
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `consultaRapidaPersona`
-- ----------------------------
DROP FUNCTION IF EXISTS `consultaRapidaPersona`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `consultaRapidaPersona`() RETURNS varchar(52) CHARSET utf8
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
end
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `crearHistorial`
-- ----------------------------
DROP FUNCTION IF EXISTS `crearHistorial`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `crearHistorial`(_idPersona varchar(250)) RETURNS varchar(50) CHARSET utf8
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `funcionBorrarAlergia`
-- ----------------------------
DROP FUNCTION IF EXISTS `funcionBorrarAlergia`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `funcionBorrarAlergia`(
 _nombreAlergia varchar(50),
 _idPersona int
) RETURNS int(11)
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
end
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `funcionBorrarAntecedente`
-- ----------------------------
DROP FUNCTION IF EXISTS `funcionBorrarAntecedente`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `funcionBorrarAntecedente`(
  _nombreAntecedente VARCHAR (50) ,
  _nombreTipoAntecedente varchar (50),
  _idPersona INT
 ) RETURNS varchar(50) CHARSET utf8
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
end
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `funcionBorrarEnfermedad`
-- ----------------------------
DROP FUNCTION IF EXISTS `funcionBorrarEnfermedad`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `funcionBorrarEnfermedad`(
 _nombreEnfermedad varchar(50),
 _idPersona int
) RETURNS varchar(50) CHARSET utf8
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
end
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `funcionEditar`
-- ----------------------------
DROP FUNCTION IF EXISTS `funcionEditar`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `funcionEditar`(
 _peso double,
 _talla double,
 _tipo  varchar(30),
 _idPersona varchar(30)
) RETURNS varchar(50) CHARSET utf8
begin
 declare _idTipo integer;
 declare _msg varchar(50);
  select idGrupoSanguineo into _idTipo from gruposanguineo where nombreGrupoSanguineo = _tipo;
  update  persona  set tallaPersona = _talla , pesoPersona =_peso , idGrupoSanguineo = _idTipo where idPersona =_idPersona ;
  set _msg = 'Datos editados';
return _msg;
end
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `funcionInsertarAlergia`
-- ----------------------------
DROP FUNCTION IF EXISTS `funcionInsertarAlergia`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `funcionInsertarAlergia`(
  _idPersona INT ,
  _nombreAlergia VARCHAR (50),
  _tratamientoAlergia VARCHAR(100)
 ) RETURNS varchar(50) CHARSET utf8
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `funcionInsertarAntecedente`
-- ----------------------------
DROP FUNCTION IF EXISTS `funcionInsertarAntecedente`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `funcionInsertarAntecedente`(
  _idPersona INT ,
  _nombreAntecedente VARCHAR (50),
  _idTipoAntecedente integer
 ) RETURNS varchar(50) CHARSET utf8
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `funcionInsertarEnfermedades`
-- ----------------------------
DROP FUNCTION IF EXISTS `funcionInsertarEnfermedades`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `funcionInsertarEnfermedades`(
  _idPersona INT ,
  _nombreEnfermedad VARCHAR (50),
  _tratamientoEnfermedad VARCHAR(100)
 ) RETURNS varchar(50) CHARSET utf8
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `guardarConsulta`
-- ----------------------------
DROP FUNCTION IF EXISTS `guardarConsulta`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `guardarConsulta`(
  _idPersona int,
  _nombre varchar(50),
  _fecha Date,
  _hora varchar(6) ,
  _sintomas varchar(250),
  _diagnostico varchar(250),
  _tratamiento varchar(250),
  _idNombreCategoria varchar(100)
) RETURNS varchar(50) CHARSET utf8
BEGIN
  declare _idHistorial int;
  declare _idTipoAtencion int;
  select idHistoriaClinica into _idHistorial from historia_clinica where idPersona = _idPersona;

  insert into atencion(nombreAtencion,fechaAtencion,horaAtencion,idHistoria,sintomasAtencion,diagnosticoAtencion,tratamientoAtencion,idTipoAtencion)
              values(_nombre,_fecha,_hora,_idHistorial,_sintomas,_diagnostico,_tratamiento,_idNombreCategoria);

RETURN 'ok';
END
;;
DELIMITER ;
