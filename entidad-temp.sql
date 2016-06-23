
/****** Object:  Table [dbo].[Persona]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Persona](
	[empresa] [smallint] NOT NULL,
	[idPersona] [int] NOT NULL,
	[tipoident] [char](10) NULL,
	[identifica] [nvarchar](50) NULL,
	[nit] [nvarchar](50) NULL,
	[nombre1] [nvarchar](50) NULL,
	[nombre2] [nvarchar](50) NULL,
	[nombre3] [nvarchar](50) NULL,
	[apellido1] [nvarchar](50) NULL,
	[apellido2] [nvarchar](50) NULL,
	[apecasada] [nvarchar](50) NULL,
	[nombrelargo] [nvarchar](250) NULL,
	[genero] [char](1) NOT NULL,
	[fechanac] [date] NULL,
	[ocupacion] [char](10) NULL,
	[estadocivil] [char](10) NULL,
	[recibePublicidad] [int] NULL,
	
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_persona] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

create table Cliente(
    empresa smallint,
	idCliente int,
	idPersona int,
	tipoCliente char(10),
	clasificacionCliente char(10),
	ultimoServicio datetime null,
	estaEmbarazada char(1) null,
	aplicaFactura char(1) null,
	avisoPorInasistencia char(1) null,
	ultimaInasistencia datetime null,
)

create table ocupacion(
	empresa smallint,
	idCliente int,
	idOcupacion int primary key,
	categoria char(10),
	puesto char(10),
	ingresoMensual money,
	idEmpresa int,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL	
)

create table Empresa(
    empresa smallint,
	idEmpresa int,
	rubroServicio char(10),
	categoria char(10),
	descripcion varchar(100),
	nit varchar(20),
	fechaFundacion datetime,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL	
)

create table EmpresaDireccion(
    empresa smallint,
	idEmpresa int,
	idDireccion int,
	[fechaing] [datetime] NOT NULL,	
	[usuarioing] [nvarchar](50) NOT NULL,	
	[maquinaing] [nvarchar](50) NOT NULL,	
	[estado] [int] NOT NULL,
	[eliminado] char(1) not null,	
)

create table Estudios(
    empresa smallint
	idPersona int,
	idEstudio int,
	categoria char(10),
	fechaInicio datetime,
	fechaFinal datetime not null,
	terminado char(1) not null,
	institucion varchar(100),
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL	
)

--tabla que contiene datos de eventualidades que haya pasado el cliente, como
--accidentes, enfermedades, procesos legales, etc.
create table Evento (
   empresa smallint,
   idEvento int,
   tipoEvento char(10), --accidente, enfermedad, procesos legales
   categoria char(10),
   descripcion varchar(100),   
   	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL	
)

create table PersonaEvento (
   empresa smallint,
   idEvento int,
   idPersona int,
   fechaInicio datetime,
   fechaFinal datetime,
   finalizado char(1),
   nota varchar(250) null,
   	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL	   
)


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MedioContacto](
	[empresa] [smallint] NOT NULL,
	[idContacto] [int] NOT NULL,
	[tipoContacto] [char](10) NOT NULL,
	[valor] [nvarchar](50) NOT NULL,	
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Contacto] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idContacto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

create table ClienteMedioContacto(
    empresa smallint,
	idContacto int,
	idCliente int,
	[fechaing] [datetime] NOT NULL,	
	[usuarioing] [nvarchar](50) NOT NULL,	
	[maquinaing] [nvarchar](50) NOT NULL,	
	[eliminado] char(1) not null	
)


/****** Object:  Table [dbo].[Direccion]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Direccion](
	[empresa] [smallint] NOT NULL,
	[idDireccion] [int] NOT NULL,	
	[direccion] [nvarchar](100) NOT NULL,
	[direccion2] [nvarchar](100) NULL,
	[zona] [char](10) NULL,
	[municipio] [char](10) NULL,
	[departamento] [char](10) NULL,
	[pais] [char](10) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Direcciones] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idDireccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

create table ClienteDireccion(
   empresa smallint,
   idDireccion int,
   idCliente int,
   tipoDireccion char(10),
	[fechaing] [datetime] NOT NULL,	
	[usuarioing] [nvarchar](50) NOT NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[eliminado] char(1) not null
)



create table ImagenCliente(
   empresa smallint,
   idImagen int,
   idCliente int,
   tipoImagen char(10),
   	[fechaing] [datetime] NOT NULL,	
	[usuarioing] [nvarchar](50) NOT NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[eliminado] char(1) not null
)

/****** Object:  Table [dbo].[Huella]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Huella](
	[empresa] [smallint] NOT NULL,
	[idHuella] [int] NOT NULL,
	[huella] [varbinary](max) NOT NULL,
	[mano] [varchar](50) NULL,
	[dedo] [varchar](50) NULL,
	[huella_long] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Huella] PRIMARY KEY CLUSTERED 
(
	[idHuella] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

create table HuellaCliente(
   empresa smallint,
   idHuella int,
   idCliente int,
	[fechaing] [datetime] NOT NULL,	
	[usuarioing] [nvarchar](50) NOT NULL,	
	[maquinaing] [nvarchar](50) NOT NULL,	
	[estado] [int] NOT NULL,
	[rowVersion] [int] NOT NULL
)

/****** Object:  Table [dbo].[Imagen]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Imagen](
	[empresa] [smallint] NOT NULL,
	[codImagen] [int] NOT NULL,
	[nombreImagen] [nvarchar](75) NOT NULL,
	[imagen] [text] NOT NULL,
	[estImagen] [char](1) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK__Imagen__3BF6DF1C2B3F6F97] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[codImagen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


create table ImagenAtributo(
   empresa smallint not null,
   idImagen int,
   codigoAtributo char(10),
   valor varchar(100),
   	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
)


/****** Object:  Table [dbo].[Sucursal]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sucursal](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[encargado] [int] NOT NULL,
	[direccion] [nvarchar](200) NOT NULL,
	[telefono] [nvarchar](50) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Sucursal] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



create table ClienteFamiliar(
   empresa smallint not null,
   idFamiliar int,
   idCliente int,
   
)

/****** Object:  Table [dbo].[Proveedor]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proveedor](
	[empresa] [smallint] NOT NULL,
	[proveedor] [int] NOT NULL,
	[tipoProveedor] [char](10) NOT NULL,
	[nombre1] [nvarchar](100) NULL,
	[nombre2] [nvarchar](100) NULL,
	[nit] [nvarchar](50) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_proveedor] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO




