drop database if exists Carpooling;
create database Carpooling;

use Carpooling;

create table Auto (
   ID          int primary key auto_increment,
   targa       char(8) not null unique,
   marca       varchar(15) not null,
   modello     varchar(15) not null,
   cilindrata  int not null,
   annoImmatr  date not null,
   condizioni  int(1) not null,
   note        varchar(200));

create table Utenti (
   ID          int primary key auto_increment,
   userName    varchar(20) unique,
   psw         varchar(10) not null,
   nome        varchar(20) not null,
   cognome     varchar(20) not null,
   sesso       enum('f','m') not null,
   dataNascita date not null,
   email       varchar(40) not null unique,
   dataPatente date not null,
   fumatore    boolean not null,
   dataIscriz  date not null,
   localita    varchar(20) not null,
   idAutoPref  int references Auto(ID));

create table AutoUtenti(
   idAuto      int not null references Auto(ID),
   idUtente    int not null references Utenti(ID),
   valido      boolean not null default false,
   primary key(idAuto,idUtente));

create table Tragitto (
   ID          int primary key auto_increment,
   idPropr     int not null,
   idAuto      int not null, 
   partenza    varchar(20) not null,
   destinaz    varchar(20) not null,
   dataPart    date not null,
   oraPart     time not null,
   durata      time not null,
   fumo        boolean not null,
   musica      boolean not null,
   spese       decimal(6,2) unsigned default 0,
   postiDisp   int(1) not null,
   foreign key (idPropr, idAuto)
      references AutoUtenti(idUtente,idAuto));

create table UtentiTragitto (
   idUtente    int not null references Utenti(ID),
   idTragitto  int not null references Tragitto(ID),
   primary key(idUtente,idTragitto));

create table Feedback (
   autore      int not null,
   tragittoAut int not null,
   valutato    int not null,
   tragittoVal int not null,
   valutazione int(1) not null,
   data        datetime not null,
   note        varchar(50),
   foreign key(autore,tragittoAut)
      references UtentiTragitto(idUtente,idTragitto),
   foreign key(valutato,tragittoVal)
      references UtentiTragitto(idUtente,idTragitto),
   primary key(autore,tragittoAut,valutato,tragittoVal));

/* Dati d'esempio */
insert into 
   Utenti(userName,psw,nome,cognome,sesso,dataNascita,email,dataPatente,fumatore,dataIscriz,localita) values 
   ('ari','ciao1','Alfio','Rinaldi','m','1977-12-15','a.rinaldi@tin.it','1990-12-15',0,'2006-11-15','Catania'),
   ('gica','ciao2','Giuseppa','Cantone','f','1980-10-10','g.canto@tin.it','1998-12-15',0,'2006-11-16','Catania'),
   ('caccio','ciao3','Filippo','Cacciola','m','1975-07-02','filcacciola@libero.it','1985-12-01',1,'2006-11-17','Catania'),
   ('frano','ciao4','Francesco','Nocita','m','1960-02-02','fr.nocita@gmail.com','1990-03-04',0,'2006-11-18','Catania'),
   ('ape','ciao5','Angela','Perna','f','1962-05-06','aperna@hotmail.it','1990-07-12',0,'2006-11-19','Catania'),
   ('rosi','ciao6','Rosalia','Fichera','f','1973-01-06','firosa@hotmail.com','1995-03-05',1,'2006-11-19','Messina'),
   ('coca','ciao7','Concetto','Calabro','m','1970-05-06','cocala@tin.it','1990-11-10',1,'2006-11-19','Messina'),
   ('seby','ciao8','Sebastiano','Accetta','m','1971-05-06','sebya@yahoo.it','1992-05-08',1,'2006-11-19','Messina'),
   ('giuta','ciao9','Giuseppa','Taccetta','f','1972-05-06','gtaccetta@hotmail.it','1993-09-08',1,'2006-11-19','Messina'),
   ('vica','ciao10','Vincenzo','Castorina','m','1975-05-06','castorov@gmail.com','1994-01-09',0,'2006-11-19','Messina');

insert into Auto(targa,marca,modello,cilindrata,annoImmatr,condizioni) values
   ('WF345PY','Audi','A3',1990,'2000-12-12',3),
   ('AB321FI','Alfa Romeo','159',1990,'2000-03-04',4),
   ('ID458TV','Mercedes','A 180 Classic',1990,'2000-05-01',5),
   ('MN432HC','Bmw','118',1990,'2000-10-20',4),
   ('RD341OX','Citroen','C3',1990,'2000-02-07',3);

insert into AutoUtenti(idAuto,idUtente,valido) values 
   (1,1,true),
   (2,2,true),
   (3,3,true),
   (4,4,true),
   (5,5,true);

insert into Tragitto(idPropr,idAuto,partenza,destinaz,dataPart,oraPart,durata,fumo,musica,postiDisp) values
   (1,1,'Catania','Palermo','2008-04-13','08:00','1:30',0,0,3),
   (2,2,'Messina','Palermo','2008-04-10','09:00','1:30',0,0,4),
   (3,3,'Catania','Palermo','2008-04-10','07:00','2:00',0,0,4),
   (4,4,'Catania','Palermo','2008-04-10','08:30','1:30',0,0,4),
   (5,5,'Messina','Palermo','2008-04-10','08:00','2:00',0,0,3);

insert into UtentiTragitto(idUtente,idTragitto) values
   (1,1),
   (2,2),
   (3,3),
   (4,4),
   (5,5),
   (6,1),
   (7,2),
   (8,3),
   (9,3),
   (10,3);

insert into Feedback(autore,tragittoAut,valutato,tragittoVal,valutazione,data) values
   (1,1,6,1,5,'2008-03-28 11:00:00'),
   (6,1,1,1,7,'2008-03-28 11:00:00'),
   (2,2,7,2,8,'2008-03-28 11:00:00'),
   (7,2,2,2,9,'2008-03-28 11:00:00'),
   (3,3,8,3,4,'2008-03-28 11:00:00');