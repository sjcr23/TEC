
-- CREACIÓN DE LA BASE DE DATOS Y LAS TABLAS

drop database if exists universidad;
create database universidad;
use universidad;


drop table if exists estudiante;
create table estudiante(
	id int primary key,
    nombre varchar(30),
    apellido varchar(30),
    fecha_nacimiento VARCHAR(30),
    total_creditos int check (total_creditos > 0)
);

drop table if exists curso;
create table curso(
    id int primary key,
	nombre varchar(20),
    creditos int,
    departamento VARCHAR(50)
);

drop table if exists profesor;
create table profesor(
	id int primary key,
    nombre varchar(30),
    apellido varchar(30),
    ciudad varchar(30)
);


-- INSERCIONES EN LAS TABLAS 

insert into estudiante(id, nombre, apellido, fecha_nacimiento, total_creditos) values(0, "e_nombre-0", "e_apellido-0", "1976-09-23", 30);
insert into estudiante(id, nombre, apellido, fecha_nacimiento, total_creditos) values(1, "e_nombre-1", "e_apellido-1", "1980-11-29", 04);
insert into estudiante(id, nombre, apellido, fecha_nacimiento, total_creditos) values(2, "e_nombre-2", "e_apellido-2", "1980-11-29", 12);
insert into estudiante(id, nombre, apellido, fecha_nacimiento, total_creditos) values(3, "e_nombre-3", "e_apellido-3", "1984-12-21", 14);
insert into estudiante(id, nombre, apellido, fecha_nacimiento, total_creditos) values(4, "e_nombre-4", "e_apellido-4", "1993-10-20", 23);
insert into estudiante(id, nombre, apellido, fecha_nacimiento, total_creditos) values(5, "e_nombre-5", "e_apellido-5", "1980-01-22", 15);
insert into estudiante(id, nombre, apellido, fecha_nacimiento, total_creditos) values(6, "e_nombre-6", "e_apellido-6", "1987-03-24", 12);
insert into estudiante(id, nombre, apellido, fecha_nacimiento, total_creditos) values(7, "e_nombre-7", "e_apellido-7", "1979-06-27", 10);
insert into estudiante(id, nombre, apellido, fecha_nacimiento, total_creditos) values(8, "e_nombre-8", "e_apellido-8", "1989-07-26", 11);
insert into estudiante(id, nombre, apellido, fecha_nacimiento, total_creditos) values(9, "e_nombre-9", "e_apellido-9", "1990-08-21", 18);


insert into curso(id, nombre, creditos, departamento) values(0, "curso-0", 1 ,'departamento-0');
insert into curso(id, nombre, creditos, departamento) values(1, "curso-1", 2 ,'departamento-1');
insert into curso(id, nombre, creditos, departamento) values(2, "curso-2", 3 ,'departamento-2');
insert into curso(id, nombre, creditos, departamento) values(3, "curso-3", 0 ,'departamento-3');
insert into curso(id, nombre, creditos, departamento) values(4, "curso-4", 3 ,'departamento-4');
insert into curso(id, nombre, creditos, departamento) values(5, "curso-5", 2 ,'departamento-5');
insert into curso(id, nombre, creditos, departamento) values(6, "curso-6", 0 ,'departamento-6');
insert into curso(id, nombre, creditos, departamento) values(7, "curso-7", 4 ,'departamento-7');
insert into curso(id, nombre, creditos, departamento) values(8, "curso-8", 2 ,'departamento-8');
insert into curso(id, nombre, creditos, departamento) values(9, "curso-9", 3 ,'departamento-9');


insert into profesor(id, nombre, apellido, ciudad) values(0, "p_nombre-0", "p_apellido-0", "ciudad-0");
insert into profesor(id, nombre, apellido, ciudad) values(1, "p_nombre-1", "p_apellido-1", "ciudad-1");
insert into profesor(id, nombre, apellido, ciudad) values(2, "p_nombre-2", "p_apellido-2", "ciudad-2");
insert into profesor(id, nombre, apellido, ciudad) values(3, "p_nombre-3", "p_apellido-3", "ciudad-3");
insert into profesor(id, nombre, apellido, ciudad) values(4, "p_nombre-4", "p_apellido-4", "ciudad-4");
insert into profesor(id, nombre, apellido, ciudad) values(5, "p_nombre-5", "p_apellido-5", "ciudad-5");
insert into profesor(id, nombre, apellido, ciudad) values(6, "p_nombre-6", "p_apellido-6", "ciudad-6");
insert into profesor(id, nombre, apellido, ciudad) values(7, "p_nombre-7", "p_apellido-7", "ciudad-7");
insert into profesor(id, nombre, apellido, ciudad) values(8, "p_nombre-8", "p_apellido-8", "ciudad-8");
insert into profesor(id, nombre, apellido, ciudad) values(9, "p_nombre-9", "p_apellido-9", "ciudad-9");






-- ----------------------------> PROCEDIMIENTOS ALMACENADOS : CURSOS <-------------------------------





-- ver_todos_los_cursos : Este proceso selecciona todos los datos de la tabla curso.

drop procedure if exists ver_todos_los_cursos;
delimiter $$
create procedure ver_todos_los_cursos()
begin
	select id, nombre, creditos, departamento from curso;
end
$$
delimiter ;

call ver_todos_los_cursos();





-- curso_por_id : Este proceso selecciona todos los datos de un curso por el id.
drop procedure if exists curso_por_id;
delimiter $$
create procedure curso_por_id(in curso_id int)
begin
    start transaction;
	select id, nombre, creditos, departamento from curso where id = curso_id;
    commit;
end
$$
delimiter ;

call curso_por_id(1);





-- agregar_curso : Este proceso agrega un curso a la tabla curso.
drop procedure if exists agregar_curso;
delimiter $$
create procedure agregar_curso(in curso_id int, curso_nombre text, curso_creditos int, curso_departamento text)
begin
	start transaction;
    insert into curso (id, nombre, creditos, departamento) values (curso_id, curso_nombre, curso_creditos, curso_departamento);
    commit;
end
$$
delimiter ;

call agregar_curso(10, 'curso-10', 4, 'departamento-10');





-- actualizar_curso : Este proceso actualiza un curso de la tabla curso.
drop procedure if exists actualizar_curso;
delimiter $$
create procedure actualizar_curso(in curso_id int, curso_nombre text, curso_creditos int, curso_departamento text)
begin
	start transaction;
    update curso set nombre = curso_nombre, creditos = curso_creditos, departamento = curso_departamento where id = curso_id;
    commit;
end
$$
delimiter ;

call actualizar_curso(7, 'curso-777', 777, 'departamento-777');





-- eliminar_curso : Este proceso elimina un curso de la tabla curso.
drop procedure if exists eliminar_curso;
delimiter $$
create procedure eliminar_curso(in curso_id int)
begin
	start transaction;
    delete from curso where id = curso_id;
    commit;
end
$$
delimiter ;

call eliminar_curso(10);





-- curso_por_departamento : Este proceso selecciona todos los datos de un curso por el id.
drop procedure if exists curso_por_departamento;
delimiter $$
create procedure curso_por_departamento(in curso_departamento text)
begin
    select id, nombre, creditos, departamento from curso where departamento = curso_departamento;
end
$$
delimiter ;

call curso_por_departamento('departamento-777');




-- ----------------------------> PROCEDIMIENTOS ALMACENADOS : ESTUDIANTES <-------------------------------





-- ver_todos_los_estudiantes : Este proceso selecciona todos los datos de la tabla estudiante.

drop procedure if exists ver_todos_los_estudiantes;
delimiter $$
create procedure ver_todos_los_estudiantes()
begin
	select id, nombre, apellido, fecha_nacimiento, total_creditos from estudiante;
end
$$
delimiter ;

call ver_todos_los_estudiantes();






-- estudiante_por_id : Este proceso selecciona todos los datos de un estudiante por el id.
drop procedure if exists estudiante_por_id;
delimiter $$
create procedure estudiante_por_id(in estudiante_id int)
begin
    start transaction;
	select id, nombre, apellido, fecha_nacimiento, total_creditos from estudiante where id = estudiante_id;
    commit;
end
$$
delimiter ;

call estudiante_por_id(1);





-- agregar_estudiante : Este proceso agrega un estudiante a la tabla estudiante.
drop procedure if exists agregar_estudiante;
delimiter $$
create procedure agregar_estudiante(in e_id int, e_nombre text, e_apellido text, e_fecha_nacimiento text, e_creditos int)
begin
	start transaction;
    insert into estudiante (id, nombre, apellido, fecha_nacimiento, total_creditos) values(e_id, e_nombre, e_apellido, e_fecha_nacimiento, e_creditos);
    commit;
end
$$
delimiter ;

call agregar_estudiante(10, "e_nombre-10", "e_apellido-10", "1990-08-21", 18);





-- actualizar_estudiante : Este proceso estudiante un curso de la tabla estudiante.
drop procedure if exists actualizar_estudiante;
delimiter $$
create procedure actualizar_estudiante(in e_id int, e_nombre text, e_apellido text, e_fecha_nacimiento text, e_creditos int)
begin
	start transaction;
    update estudiante set nombre = e_nombre, apellido = e_apellido, fecha_nacimiento = e_fecha_nacimiento, total_creditos = e_creditos where id = e_id;
    commit;
end
$$
delimiter ;

call actualizar_estudiante(7, 'e_nombre-777', 'e_apellido-777', '7777-77-77', 777);





-- eliminar_estudiante : Este proceso elimina un estudiante de la tabla estudiante.
drop procedure if exists eliminar_estudiante;
delimiter $$
create procedure eliminar_estudiante(in e_id int)
begin
	start transaction;
    delete from estudiante where id = e_id;
    commit;
end
$$
delimiter ;

call eliminar_estudiante(10);





-- estudiantes_por_apellido : Este proceso selecciona todos los estudiantes por el apellido.
drop procedure if exists estudiantes_por_apellido;
delimiter $$
create procedure estudiantes_por_apellido(in e_apellido text)
begin
    select id, nombre, apellido, fecha_nacimiento, total_creditos from estudiante where apellido = e_apellido;
end
$$
delimiter ;

-- Agregamos más estudiantes con el apellido "apellido-777"
call agregar_estudiante(10, "e_nombre-10", "e_apellido-777", "1990-01-20", 10);
call agregar_estudiante(11, "e_nombre-11", "e_apellido-777", "1991-02-21", 11);
call agregar_estudiante(12, "e_nombre-12", "e_apellido-777", "1992-03-22", 12);
call agregar_estudiante(13, "e_nombre-13", "e_apellido-777", "1993-04-23", 13);

call estudiantes_por_apellido('e_apellido-777');




-- ----------------------------> PROCEDIMIENTOS ALMACENADOS : PROFESORES <-------------------------------





-- ver_todos_los_profesores : Este proceso selecciona todos los datos de la tabla estudiante.

drop procedure if exists ver_todos_los_profesores;
delimiter $$
create procedure ver_todos_los_profesores()
begin
	select id, nombre, apellido, ciudad from profesor;
end
$$
delimiter ;

call ver_todos_los_profesores();






-- profesor_por_id : Este proceso selecciona todos los datos de un profesor por el id.
drop procedure if exists profesor_por_id;
delimiter $$
create procedure profesor_por_id(in profesor_id int)
begin
    start transaction;
	select id, nombre, apellido, ciudad from profesor where id = profesor_id;
    commit;
end
$$
delimiter ;

call profesor_por_id(1);





-- agregar_profesor : Este proceso agrega un profesor a la tabla profesor.
drop procedure if exists agregar_profesor;
delimiter $$
create procedure agregar_profesor(in p_id int, p_nombre text, p_apellido text, p_ciudad text)
begin
	start transaction;
    insert into profesor (id, nombre, apellido, ciudad) values(p_id, p_nombre, p_apellido, p_ciudad);
    commit;
end
$$
delimiter ;

call agregar_profesor(10, "p_nombre-10", "p_apellido-10", "p_ciudad-10");





-- actualizar_profesor : Este proceso profesor un curso de la tabla profesor.
drop procedure if exists actualizar_profesor;
delimiter $$
create procedure actualizar_profesor(in p_id int, p_nombre text, p_apellido text, p_ciudad text)
begin
	start transaction;
    update profesor set nombre = p_nombre, apellido = p_apellido, ciudad = p_ciudad where id = p_id;
    commit;
end
$$
delimiter ;

call actualizar_profesor(7, "p_nombre-777", "p_apellido-777", "p_ciudad-777");





-- eliminar_profesor : Este proceso elimina un profesor de la tabla profesor.
drop procedure if exists eliminar_profesor;
delimiter $$
create procedure eliminar_profesor(in p_id int)
begin
	start transaction;
    delete from profesor where id = p_id;
    commit;
end
$$
delimiter ;

call eliminar_profesor(10);





-- profesores_por_ciudad : Este proceso selecciona todos los profesores por la ciudad.
drop procedure if exists profesores_por_ciudad;
delimiter $$
create procedure profesores_por_ciudad(in p_ciudad text)
begin
    select id, nombre, apellido, ciudad from profesor where ciudad = p_ciudad;
end
$$
delimiter ;

-- Agregamos más profesores con la ciudad ciudad-777"
call agregar_profesor(10, "p_nombre-10", "p_apellido-10", "p_ciudad-777");
call agregar_profesor(11, "p_nombre-11", "p_apellido-11", "p_ciudad-777");
call agregar_profesor(12, "p_nombre-12", "p_apellido-12", "p_ciudad-777");
call agregar_profesor(13, "p_nombre-13", "p_apellido-13", "p_ciudad-777");
call agregar_profesor(14, "p_nombre-14", "p_apellido-14", "p_ciudad-777");
call agregar_profesor(15, "p_nombre-15", "p_apellido-15", "p_ciudad-777");


call profesores_por_ciudad('p_ciudad-777');




