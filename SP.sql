/*BENEFICIOS*/
DELIMITER //
CREATE PROCEDURE SP_beneficio_INSERT(IN descr_ varchar(100), IN estado_ bit, IN nombre_ varchar(100))
BEGIN
  INSERT INTO beneficio(descripcion, estado, nombre) VALUES (descr_, estado_, nombre_);
end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_beneficio_UPDATE(IN id INT, IN descr_ varchar(100), IN estado_ bit, IN nombre_ varchar(100))
BEGIN
  UPDATE beneficio SET descripcion=descr_, estado=estado_, nombre=nombre_ WHERE idbeneficio=id;
end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_beneficio_DELETE(IN id INT)
BEGIN
  UPDATE beneficio SET estado=estado_ WHERE idbeneficio=id;
end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_ASIGN_BENEFICIO(membresia int, beneficio int)
  BEGIN
    INSERT INTO asignacion_beneficios(idmembresia, idbeneficio) VALUES(membresia, beneficio);
  end //
DELIMITER ;

/*SOCIOS*/
  DROP PROCEDURE IF EXISTS SP_SOCIO_INSERT;
  DELIMITER //
  CREATE PROCEDURE SP_SOCIO_INSERT(in nom varchar(100), in apel varchar(100), in dir_dom varchar(255), in tel varchar(8), in fnac date,
    in freg date, in est bit, in dpi_ varchar(13), in dir_cob varchar(255))
    BEGIN
      INSERT INTO socio(nombre, apellido, direccion_domicilio, telefono, fecha_nacimiento, fecha_registro, estado,
                        DPI, direccion_cobro)
      VALUES(nom, apel, dir_dom, tel, fnac, freg, est, dpi_, dir_cob);
    end //
  DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_SOCIO_UPDATE(id int, in nom varchar(100), in apel varchar(100), in dir_dom varchar(255), in tel varchar(8), in fnac date,
    in freg date, in est bit, in dpi_ varchar(13), in dir_cob varchar(255))
BEGIN
  UPDATE socio set nombre=nom, apellido=apel, direccion_domicilio=dir_dom, telefono=tel, fecha_nacimiento=fnac,
    fecha_registro=freg, estado=est, DPI=dpi_, direccion_cobro=dir_cob WHERE idsocio=id;
end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_SOCIO_DELETE(id INT)
  BEGIN
    UPDATE socio SET estado=0 WHERE idsocio=id;
  end //
DELIMITER ;

/*REGISTRO SOCIOS*/
DELIMITER //
CREATE PROCEDURE SP_REGSOCIO_INSERT(membresia int, socio int, est bit, f_cancela date, mora decimal)
  BEGIN
    INSERT INTO registro_socio(estado, idmembresia, idsocio, fecha_cancelacion, mora_acumulada)
    VALUES(est, membresia, socio, f_cancela, mora);
  end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_REGSOCIO_CANCELAR(id int, est bit, f_cancela date)
  BEGIN
    UPDATE registro_socio SET fecha_cancelacion = f_cancela, estado=est where idregistro_socio=id;
  end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_REGSOCIO_MORA(id int, mora decimal)
  BEGIN
    UPDATE registro_socio set mora_acumulada=mora where idregistro_socio = id;
  end //
DELIMITER ;

/*LESION*/
DELIMITER //
CREATE PROCEDURE SP_LESION_INSERT(nom varchar(25), descr nvarchar(250), est bit)
  BEGIN
    INSERT INTO lesion(nombre, descripcion, estado) VALUES(nom, descr, est);
  end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_LESION_UPDATE(id int, nom varchar(25), descr nvarchar(250), est bit)
  BEGIN
    UPDATE lesion SET nombre=nom, descripcion=descr, estado=est WHERE idlesion=id;
  end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_LESION_DELETE(id int)
  BEGIN
    UPDATE lesion SET estado=0 where idlesion=id;
  end//
DELIMITER ;

/*LESION JUGADOR*/
DELIMITER //
CREATE PROCEDURE SP_LESIONJUGADOR_INSERT(finicio date, ffinal date, est bit, mot varchar(250),
jugador int, lesion int, medico int, obs varchar(200))
  BEGIN
    INSERT INTO lesion_jugador(fecha_inicio, fecha_recuperacion, estado, motivo, idjugador,
                               idlesion, idmedico, observacion)
      VALUES(finicio, ffinal, est, mot, jugador, lesion, medico, obs);
  end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_LESIONJUGADOR_UPDATE(id int, finicio date, ffinal date, est bit, mot varchar(250),
jugador int, lesion int, medico int, obs varchar(200))
  BEGIN
    UPDATE lesion_jugador SET fecha_inicio=finicio, fecha_recuperacion=ffinal, estado=est, motivo=mot,
      idjugador=jugador, idlesion=lesion, idmedico=medico, observacion=obs WHERE idlesion_jugador=id;
  end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_LESIONJUGADOR_DELETE(id int)
  BEGIN
    UPDATE lesion_jugador SET estado=0 WHERE idlesion_jugador=id;
  end //
DELIMITER ;

/*TRATAMIENTO*/
DELIMITER //
CREATE PROCEDURE SP_TRATAMIENTO_INSERT(medi varchar(250), cant int, pres varchar(250), lesion int)
  BEGIN
    INSERT INTO tratamiento(medicamento, cantidad, prescripcion, idlesion)
    VALUES(medi, cant, pres, lesion);
  end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_TRATAMIENTO_UPDATE(id int,medi varchar(250), cant int, pres varchar(250), lesion int)
  BEGIN
    UPDATE tratamiento SET medicamento=medi, cantidad=cant, prescripcion=pres, idlesion=lesion WHERE idtratamiento=id;
  end //
DELIMITER ;

DELIMITER //
CREATE  PROCEDURE  SP_TRATAMIENTO_DELETE(id int)
  BEGIN
    DELETE FROM tratamiento WHERE idtratamiento=id;
  end //
DELIMITER ;

/*MEDICO*/
DELIMITER //
CREATE PROCEDURE SP_MEDICO_INSERT(nom varchar(100), apel varchar(100), fnacimiento date, finicio date, ffinal date, est bit,
dir varchar(30), tel varchar(8))
  BEGIN
    INSERT INTO medico(nombre, apellido, fecha_nacimiento, fecha_inicio, fecha_final, estado, direccion, telefono)
      VALUES(nom, apel, fnacimiento, finicio, ffinal, est, dir, tel);
  end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_MEDICO_UPDATE(id int,nom varchar(100), apel varchar(100), fnacimiento date, finicio date, ffinal date, est bit,
dir varchar(30), tel varchar(8))
  BEGIN
    UPDATE medico SET nombre=nom, apellido=apel, fecha_nacimiento=fnacimiento, fecha_inicio=finicio, fecha_final=ffinal,
      estado=est, direccion=dir, telefono=tel WHERE idmedico=id;
  end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_MEDICO_DELETE(id int)
  BEGIN
    UPDATE medico SET estado=0 WHERE idmedico=id;
  end //
DELIMITER ;

/*DOCUMENTO DIGITAL*/
DELIMITER //
CREATE PROCEDURE SP_DOCDIGITAL_INSERT(fcrea date, est bit, pat varchar(255), descr varchar(255), cat int)
  BEGIN
    INSERT INTO documento_digital(fecha_creacion, estado, path, descripcion, idcategoria_documentos)
    VALUES (fcrea, est, pat, descr, cat);
  end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_DOCDIGITAL_UPDATE(id int, est bit, pat varchar(255), descr varchar(255), cat int)
  BEGIN
    UPDATE documento_digital SET estado=est, path=pat, descripcion=descr, idcategoria_documentos=cat WHERE iddocumento=id;
  end //
DELIMITER ;

DROP PROCEDURE IF EXISTS SP_DOCDIGITAL_DELETE;
DELIMITER //
CREATE PROCEDURE SP_DOCDIGITAL_DELETE(id int)
  BEGIN
    UPDATE documento_digital SET estado=0 WHERE iddocumento=id;
  end //
DELIMITER ;

/*JUGADOR-CATEGORIAS-ASIGNACION*/
DELIMITER //
CREATE PROCEDURE SP_ASIG_JUG_CAT_INSERT(fini date, est bit, categoria int, jugador int, equipo int)
  BEGIN
    INSERT INTO asignacion_categoria(fecha_inicio, estado, idcategoria, idjugador, idequipo)
      VALUES(fini, est, categoria, jugador, equipo);
  end //
DELIMITER ;

DROP PROCEDURE  IF EXISTS SP_ASCENDERCAT;
DELIMITER //
CREATE PROCEDURE SP_ASCENDERCAT(fini date, est bit, ncategoria int, jugador int, equipo int)
  BEGIN
    DECLARE errno INT;
    DECLARE vcat INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    SELECT errno AS MYSQL_ERROR;
    ROLLBACK;
    END;
    START TRANSACTION;
    SET vcat=(SELECT MAX(idasignacion) FROM asignacion_categoria WHERE idjugador=jugador and estado=1);
    UPDATE asignacion_categoria SET fecha_final=fini, estado=0 WHERE idasignacion=vcat;
    INSERT INTO asignacion_categoria(fecha_inicio, estado, idcategoria, idjugador, idequipo)
      VALUES (fini, est, ncategoria, jugador, equipo);
    COMMIT;
  end//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_JUG_CAT_CANCELAR(jugador int, ffinal date)
  BEGIN
    DECLARE asignacion INT;
    SET asignacion=(SELECT MAX(idasignacion) FROM asignacion_categoria WHERE idjugador=jugador);
    UPDATE asignacion_categoria SET estado=0, fecha_final=ffinal WHERE idasignacion=asignacion;
  end//
DELIMITER ;
