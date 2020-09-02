/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     30/08/2020 1:29:17 a. m.                     */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BET') and o.name = 'FK_BET_RELATIONS_CLIENT')
alter table BET
   drop constraint FK_BET_RELATIONS_CLIENT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BET') and o.name = 'FK_BET_RELATIONS_ROULETTE')
alter table BET
   drop constraint FK_BET_RELATIONS_ROULETTE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BET')
            and   name  = 'RELATIONSHIP_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index BET.RELATIONSHIP_1_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BET')
            and   name  = 'RELATIONSHIP_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index BET.RELATIONSHIP_2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BET')
            and   type = 'U')
   drop table BET
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CLIENT')
            and   type = 'U')
   drop table CLIENT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ROULETTE')
            and   type = 'U')
   drop table ROULETTE
go

/*==============================================================*/
/* Table: BET                                                   */
/*==============================================================*/
create table BET (
   CLIENT               int                  not null,
   ROULET               int                  not null,
   NUMBER_ROULET        varchar(16)          null,
   COLOUR_ROULET        varchar(16)          null,
   RESULT_BET           varchar(20)          null,
   DATE_BET				DATETIME			 not null,
   MONEY_BET			float(16)            not null,
   constraint PK_BET primary key nonclustered (CLIENT, ROULET)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_2_FK on BET (
ROULET ASC
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_1_FK on BET (
CLIENT ASC
)
go

/*==============================================================*/
/* Table: CLIENT                                                */
/*==============================================================*/
create table CLIENT (
   IDCLIENT             int                  not null,
   NAME                 varchar(50)          not null,
   LAST_NAME			varchar(50)          not null,
   MONEY_CLIENT         float(16)            not null,
   constraint PK_CLIENT primary key nonclustered (IDCLIENT)
)
go

/*==============================================================*/
/* Table: ROULETTE                                              */
/*==============================================================*/
create table ROULETTE (
   IDROULET             int                  not null,
   STATEROULET          varchar(20)          not null,
   CREATED_AT			DATETIME			 not null,
   constraint PK_ROULETTE primary key nonclustered (IDROULET)
)
go

alter table BET
   add constraint FK_BET_RELATIONS_CLIENT foreign key (CLIENT)
      references CLIENT (IDCLIENT)
go

alter table BET
   add constraint FK_BET_RELATIONS_ROULETTE foreign key (ROULET)
      references ROULETTE (IDROULET)
go

