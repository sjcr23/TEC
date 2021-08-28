[IS2021] [BASES-1] [Mi-TEC-Digital] [Tarea3]
======================================

**Índice**

1. Introduccion
2. Esquema
   1. Idioma
   2. Tablas
   3. Atributos
   4. Ejemplos

***

1. **Introduccion**

   ​	Estudiante:  
     	· Josué Castro Ramírez  
     	· Carné: ```2020065036  ```  

   ​	Descripción:   
     	· Crear un estándar de nombres para el esquema de la base de datos entender los requerimientos del motor de base 
   ​         datos para el nombre de: las entidades, atributos y los tipos de datos. Su implicación en la implementación de un 
   ​         esquema de entidad  relación y su posterior uso en la creación de consultas en lenguaje SQL; además de durante la  
   ​         implementación de sistemas que consuman dichas entidades. 

2. **Esquema**

   1. Idioma  :  ``` Inglés ``` 
   Todas las variables se establecen en inglés.
   
2. Nombre de las Tablas  :  ```table_name``` 
      Los **nombres** de las tablas se establecen en **minusuculas** y en **plural**; en caso de necesitar **2 palabras o mas** se utiliza una **raya baja** para separarlos
   
   
3. Nombres de Atriubutos  :  ```table_id - attribute```  
      Para el nombre de los atributos se utiliza una **abreviatura del nombre de la tabla, segudio de un guion y el atributo.**
      (Revisar el diccionario de Abreviaciones)
   4. Ejemplos :
   
   ```sql
   CREATE TABLE students(
       std-id int NOT NULL AUTO_INCREMENT PRIMARY KEY;
       std-f_name varchar(30),
       std-l_name varchar(30)
   );
   ```
   ``````sql
   CREATE TABLE professors(
       prf-id int NOT NULL AUTO_INCREMENT PRIMARY KEY;
       prf-f_name varchar(30),
    prf-l_name varchar(30)
   );
   ``````
   
   ```sql
   INSERT INTO students(std-f_name, std-l_name) VALUES ("Josué", "Castro");
   ```
   
      ```sql
   INSERT INTO professors(prf-f_name, prf-l_name) VALUES ("Aurelio", "Sanabria");
      ```
   
   • Diccionario de Abreviacones
   
   ​	— Identificación de tablas
   ​		• **std** : student
   ​        • **prf** : professor
   
   ​	— Atributos
   
   ​		• **id** : id
   ​		• **f_name** : first_name
   ​        • **l_name** : last_name