USE [master]
GO
/****** Object:  Database [new_ortodental]    Script Date: 16/06/2016 11:41:52 p.m. ******/
CREATE DATABASE [new_ortodental]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'new_ortodental', FILENAME = N'C:\Program Files\Microsoft SQL Server 2012\MSSQL11.SQLSERVER2012\MSSQL\DATA\new_ortodental.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'new_ortodental_log', FILENAME = N'C:\Program Files\Microsoft SQL Server 2012\MSSQL11.SQLSERVER2012\MSSQL\DATA\new_ortodental_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [new_ortodental] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [new_ortodental].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [new_ortodental] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [new_ortodental] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [new_ortodental] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [new_ortodental] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [new_ortodental] SET ARITHABORT OFF 
GO
ALTER DATABASE [new_ortodental] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [new_ortodental] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [new_ortodental] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [new_ortodental] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [new_ortodental] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [new_ortodental] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [new_ortodental] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [new_ortodental] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [new_ortodental] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [new_ortodental] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [new_ortodental] SET  DISABLE_BROKER 
GO
ALTER DATABASE [new_ortodental] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [new_ortodental] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [new_ortodental] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [new_ortodental] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [new_ortodental] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [new_ortodental] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [new_ortodental] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [new_ortodental] SET RECOVERY FULL 
GO
ALTER DATABASE [new_ortodental] SET  MULTI_USER 
GO
ALTER DATABASE [new_ortodental] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [new_ortodental] SET DB_CHAINING OFF 
GO
ALTER DATABASE [new_ortodental] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [new_ortodental] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'new_ortodental', N'ON'
GO
USE [new_ortodental]
GO
/****** Object:  Table [dbo].[ArqueoCaja]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ArqueoCaja](
	[empresa] [smallint] NOT NULL,
	[idCierreCaja] [int] NOT NULL,
	[idArqueoCaja] [int] NOT NULL,
	[moneda] [char](10) NOT NULL,
	[presentacionMoneda] [char](10) NOT NULL,
	[denominacion] [char](10) NULL,
	[cantidad] [int] NOT NULL,
	[montoTotal] [money] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_ArqueoCaja] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idCierreCaja] ASC,
	[idArqueoCaja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CabCatalogo]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CabCatalogo](
	[cc_empresa] [smallint] NOT NULL,
	[cc_IdCatalogo] [int] IDENTITY(1,1) NOT NULL,
	[cc_nombre] [nvarchar](50) NOT NULL,
	[cc_nomVal1] [nvarchar](50) NULL,
	[cc_nomVal2] [nvarchar](50) NULL,
	[cc_nomVal3] [nvarchar](50) NULL,
	[cc_fechaing] [datetime] NOT NULL,
	[cc_fechamod] [datetime] NULL,
	[cc_usuarioing] [nvarchar](50) NOT NULL,
	[cc_usuariomod] [nvarchar](50) NULL,
	[cc_maquinaing] [nvarchar](50) NOT NULL,
	[cc_maquinamod] [nvarchar](50) NULL,
	[cc_estado] [int] NOT NULL,
	[cc_timestamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_CabCatalogo_1] PRIMARY KEY CLUSTERED 
(
	[cc_IdCatalogo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CierreCaja]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CierreCaja](
	[empresa] [smallint] NOT NULL,
	[idCierreCaja] [int] NOT NULL,
	[terminal] [varchar](50) NOT NULL,
	[idSucursal] [int] NOT NULL,
	[fechaHoraCierre] [datetime] NOT NULL,
	[moneda] [char](10) NOT NULL,
	[saldoAnterior] [money] NULL,
	[entradasEfectivo] [money] NULL,
	[salidasEfectivo] [money] NULL,
	[efectivoTeorico] [money] NULL,
	[efectivoFisico] [money] NULL,
	[ajusteEfectivo] [money] NULL,
	[chequeTeorico] [money] NULL,
	[chequeFisico] [money] NULL,
	[ajusteCheque] [money] NULL,
	[tarjetaTeorico] [money] NULL,
	[tarjetaFisico] [money] NULL,
	[ajusteTarjeta] [money] NULL,
	[descuadre] [money] NULL,
	[retiroEfectivoAdmin] [money] NULL,
	[saldoActual] [money] NULL,
	[estCierreCaja] [char](10) NOT NULL,
	[totalVenta] [money] NULL,
	[totalPropina] [money] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_CierreCaja] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idCierreCaja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CierreDiario]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CierreDiario](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idCierreDiario] [int] NOT NULL,
	[fechaCierreDiario] [date] NOT NULL,
	[estCierreDiario] [char](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_CierreDiario] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idCierreDiario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CierreMensualDocumentoPromo]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[CierreMensualDocumentoPromo](
	[empresa] [smallint] NOT NULL,
	[anio] [int] NOT NULL,
	[mes] [int] NOT NULL,
	[cliente] [int] NOT NULL,
	[idDocumentoPromo] [int] NOT NULL,
	[idPaquete] [int] NOT NULL,
	[idDetallePaquete] [int] NOT NULL,
	[montoAnterior] [money] NULL,
	[montoEntradas] [money] NULL,
	[montoSalidas] [money] NULL,
	[montoCierre] [money] NULL,
	[cantidadAnterior] [int] NULL,
	[cantidadEntradas] [int] NULL,
	[cantidadSalidas] [int] NULL,
	[cantidadCierre] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_CierreMensualTarjeta_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[anio] ASC,
	[mes] ASC,
	[cliente] ASC,
	[idDocumentoPromo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cita]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cita](
	[empresa] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idCita] [int] IDENTITY(1,1) NOT NULL,
	[cliente] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[dia] [int] NOT NULL,
	[horaInicio] [char](10) NULL,
	[horaFin] [char](10) NULL,
	[estRegistro] [char](2) NOT NULL,
	[actCentral] [int] NULL,
	[comentarios] [varchar](300) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Cita] PRIMARY KEY CLUSTERED 
(
	[idCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CuentaContable]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CuentaContable](
	[empresa] [smallint] NOT NULL,
	[noCuenta] [varchar](20) NOT NULL,
	[nombreCuenta] [varchar](100) NOT NULL,
	[descripcion] [varchar](200) NOT NULL,
	[noCuentaPadre] [varchar](20) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[estado] [int] NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_CuentaContable] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[noCuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CuentaXCobrar]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CuentaXCobrar](
	[empresa] [smallint] NOT NULL,
	[idCuentaXCobrar] [int] IDENTITY(1,1) NOT NULL,
	[cliente] [int] NOT NULL,
	[saldo] [money] NOT NULL,
	[fechaUltMov] [datetime] NOT NULL,
	[montoUltMov] [money] NOT NULL,
	[estCuentaXCobrar] [char](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_CuentaXCobrar] PRIMARY KEY CLUSTERED 
(
	[idCuentaXCobrar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Descuento]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Descuento](
	[empresa] [smallint] NOT NULL,
	[idDescuento] [int] IDENTITY(1,1) NOT NULL,
	[idSucursal] [int] NOT NULL,
	[tipoDescuento] [char](10) NOT NULL,
	[descripcion] [nvarchar](200) NOT NULL,
	[porcentaje] [int] NOT NULL,
	[cantidad] [money] NOT NULL,
	[idDoc] [int] NOT NULL,
	[idMov] [int] NOT NULL,
	[idAutorizacion] [int] NOT NULL,
	[idMovDescuento] [int] NULL,
	[comentario] [varchar](300) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Descuento_1] PRIMARY KEY CLUSTERED 
(
	[idDescuento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetalleCierreCaja]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetalleCierreCaja](
	[empresa] [smallint] NOT NULL,
	[idCierreCaja] [int] NOT NULL,
	[idDetalleCierreCaja] [int] NOT NULL,
	[idFormaPago] [char](10) NOT NULL,
	[monto] [money] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_DetalleCierreCaja] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idCierreCaja] ASC,
	[idDetalleCierreCaja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetalleCita]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetalleCita](
	[empresa] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idCita] [int] NOT NULL,
	[idDetalleCita] [int] IDENTITY(1,1) NOT NULL,
	[empleado] [int] NOT NULL,
	[idServicio] [int] NOT NULL,
	[horaInicio] [char](8) NULL,
	[horaFin] [char](8) NULL,
	[estRegistro] [char](2) NOT NULL,
	[clasificacion] [char](10) NULL,
	[comentarios] [varchar](300) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_DetalleCita] PRIMARY KEY CLUSTERED 
(
	[idDetalleCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetalleOrdenProducto]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetalleOrdenProducto](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idOrdenCliente] [int] NOT NULL,
	[idDetalleOrdenProducto] [int] IDENTITY(1,1) NOT NULL,
	[idProducto] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[costoUnitario] [money] NOT NULL,
	[montoTotal] [money] NOT NULL,
	[estado] [varchar](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_DetalleOrdenProducto_1] PRIMARY KEY CLUSTERED 
(
	[idDetalleOrdenProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetalleOrdenServicio]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetalleOrdenServicio](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idOrdenCliente] [int] NOT NULL,
	[idDetalleOrdenServicio] [int] IDENTITY(1,1) NOT NULL,
	[empleado] [int] NOT NULL,
	[idServicio] [int] NOT NULL,
	[horaInicio] [char](8) NULL,
	[horaFin] [char](8) NULL,
	[precio] [money] NOT NULL,
	[estRegistro] [char](2) NOT NULL,
	[calificacion] [char](10) NULL,
	[clasificacion] [char](10) NULL,
	[clasificacionCita] [char](10) NULL,
	[comentarios] [varchar](300) NULL,
	[comentariosCo] [varchar](300) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_DetalleOrdenServicio_1] PRIMARY KEY CLUSTERED 
(
	[idDetalleOrdenServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetalleServicioPlan]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DetalleServicioPlan](
	[empresa] [smallint] NULL,
	[idSucursal] [int] NULL,
	[idServicioPlan] [int] NULL,
	[idServicio] [int] NULL,
	[montoServicio] [money] NULL,
	[descuento] [money] NULL,
	[fechaInicio] [datetime] NULL,
	[sesiones] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetCatalogo]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetCatalogo](
	[cd_empresa] [smallint] NOT NULL,
	[cd_IdCatalogo] [int] NOT NULL,
	[cd_codigo] [char](10) NOT NULL,
	[cd_valor] [nvarchar](100) NOT NULL,
	[cd_valor1] [nvarchar](100) NULL,
	[cd_valor2] [nvarchar](100) NULL,
	[cd_valor3] [nvarchar](100) NULL,
	[cd_fechaing] [datetime] NOT NULL,
	[cd_fechamod] [datetime] NULL,
	[cd_usuarioing] [nvarchar](50) NOT NULL,
	[cd_usuariomod] [nvarchar](50) NULL,
	[cd_maquinaing] [nvarchar](50) NOT NULL,
	[cd_maquinamod] [nvarchar](50) NULL,
	[cd_estado] [int] NOT NULL,
	[cd_timestamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_DetCatalogo] PRIMARY KEY CLUSTERED 
(
	[cd_IdCatalogo] ASC,
	[cd_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Documento]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Documento](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idDoc] [int] IDENTITY(1,1) NOT NULL,
	[tipoDocumento] [char](10) NOT NULL,
	[tipoAsociado] [char](10) NULL,
	[idSerieFactura] [int] NULL,
	[asociado] [int] NULL,
	[nombreAsociado] [nvarchar](250) NULL,
	[direccionAsociado] [nvarchar](250) NULL,
	[nit] [varchar](50) NULL,
	[subtotal] [money] NOT NULL,
	[descuento] [money] NOT NULL,
	[total] [money] NOT NULL,
	[serieDoc] [nvarchar](50) NULL,
	[noDocumento] [nvarchar](50) NOT NULL,
	[fechaDoc] [datetime] NOT NULL,
	[estDocumento] [char](2) NOT NULL,
	[terminal] [varchar](50) NULL,
	[motivoAnulacion] [char](10) NULL,
	[motivoNCND] [char](10) NULL,
	[comentario] [varchar](300) NULL,
	[idDocAnulado] [int] NULL,
	[idCierreDiario] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Documento_1] PRIMARY KEY CLUSTERED 
(
	[idDoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentoPromo]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DocumentoPromo](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idDocumentoPromo] [int] NOT NULL,
	[tipoDocumentoPromo] [nchar](10) NOT NULL,
	[idLoteDocumentoPromo] [int] NOT NULL,
	[noDocumento] [bigint] NULL,
	[cliente] [int] NULL,
	[estDocPromo] [nchar](10) NOT NULL,
	[saldo] [money] NOT NULL,
	[fechaing] [datetime] NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Tarjeta_1] PRIMARY KEY CLUSTERED 
(
	[idDocumentoPromo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentoPromoPaquete]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DocumentoPromoPaquete](
	[empresa] [smallint] NOT NULL,
	[idDocumentoPromo] [int] NOT NULL,
	[idPaquete] [int] NOT NULL,
	[idDetallePaquete] [int] NOT NULL,
	[idServicio] [int] NOT NULL,
	[cantidadSaldo] [int] NOT NULL,
	[fechaVigencia] [datetime] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_TarjetaPaquete_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idDocumentoPromo] ASC,
	[idPaquete] ASC,
	[idDetallePaquete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentoPromoProducto]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DocumentoPromoProducto](
	[empresa] [smallint] NOT NULL,
	[idDocumentoPromo] [int] NOT NULL,
	[idProducto] [int] NOT NULL,
	[cantidadSaldo] [int] NOT NULL,
	[fechaVigencia] [datetime] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_DocumentoPromoProducto] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idDocumentoPromo] ASC,
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Existencia]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Existencia](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idExistencia] [int] NOT NULL,
	[tipoProducto] [int] NOT NULL,
	[idProd] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precioUnitario] [money] NOT NULL,
	[fechaCaducidad] [date] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Existencia] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[tipoProducto] ASC,
	[idProd] ASC,
	[fechaing] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacturaActualCaja]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[FacturaActualCaja](
	[empresa] [int] NOT NULL,
	[terminal] [nvarchar](50) NOT NULL,
	[idDoc] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_FacturaActualCaja_1] PRIMARY KEY CLUSTERED 
(
	[terminal] ASC,
	[idDoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacturaFormaPago]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacturaFormaPago](
	[empresa] [smallint] NOT NULL,
	[idFacturaFormaPago] [int] IDENTITY(1,1) NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idDoc] [int] NOT NULL,
	[idMovDocPromo] [int] NULL,
	[idFormaPago] [char](10) NOT NULL,
	[idAutorizacion] [int] NULL,
	[cantidad] [money] NULL,
	[unidades] [int] NULL,
	[noDocumento] [bigint] NULL,
	[idBanco] [char](10) NULL,
	[idMarcaTarjeta] [char](10) NULL,
	[comentario] [nvarchar](200) NULL,
	[moneda] [char](10) NULL,
	[tasaCambio] [money] NULL,
	[cantidadOriginal] [money] NULL,
	[idCierreCaja] [int] NULL,
	[confirmaCierreCaja] [int] NULL,
	[efectivoRecibido] [money] NULL,
	[efectivoVuelto] [money] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_FacturaFormaPago_1] PRIMARY KEY CLUSTERED 
(
	[idFacturaFormaPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoteDocumentoPromo]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[LoteDocumentoPromo](
	[empresa] [smallint] NOT NULL,
	[idSucrusal] [int] NOT NULL,
	[idLoteDocumentoPromo] [int] NOT NULL,
	[tipoLote] [char](10) NOT NULL,
	[idInicio] [bigint] NOT NULL,
	[idFinal] [bigint] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_LoteDocumentoPromo_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idLoteDocumentoPromo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Movimiento]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movimiento](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idMov] [int] IDENTITY(1,1) NOT NULL,
	[prodServ] [char](1) NOT NULL,
	[idProdServ] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[valorMov] [money] NOT NULL,
	[tipoMovimiento] [char](10) NOT NULL,
	[fechaMov] [datetime] NOT NULL,
	[idDoc] [int] NOT NULL,
	[idOrdenCliente] [int] NULL,
	[idOrdenServicio] [int] NULL,
	[idOrdenProducto] [int] NULL,
	[idAutorizacion] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Movimiento_1] PRIMARY KEY CLUSTERED 
(
	[idMov] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovimientoCuentaXCobrar]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MovimientoCuentaXCobrar](
	[empresa] [smallint] NOT NULL,
	[idCuentaXCobrar] [int] NOT NULL,
	[idMovCuentaXCobrar] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idDoc] [int] NOT NULL,
	[cliente] [int] NOT NULL,
	[fechaMov] [datetime] NOT NULL,
	[montoMov] [money] NOT NULL,
	[creditoDebito] [char](1) NOT NULL,
	[descripcion] [nvarchar](200) NOT NULL,
	[estMovCuentaXCobrar] [char](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_MovimientoCuentaXCobrar_1] PRIMARY KEY CLUSTERED 
(
	[idMovCuentaXCobrar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovimientoDocumentoPromo]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MovimientoDocumentoPromo](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idDocumentoPromo] [int] NOT NULL,
	[idMovDocPromo] [int] NOT NULL,
	[idDoc] [int] NOT NULL,
	[idMov] [int] NULL,
	[cliente] [int] NULL,
	[idPaquete] [int] NULL,
	[idDetallePaquete] [int] NULL,
	[fechaMov] [datetime] NOT NULL,
	[montoMov] [money] NULL,
	[cantidadMov] [int] NULL,
	[creditoDebito] [char](1) NOT NULL,
	[idOrdenServicio] [int] NULL,
	[idDetalleOrdenServicio] [int] NULL,
	[idProducto] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_MovimientoDocumentoPromo] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idDocumentoPromo] ASC,
	[idMovDocPromo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NitFactura]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NitFactura](
	[empresa] [smallint] NOT NULL,
	[nit] [varchar](50) NOT NULL,
	[idSucursal] [int] NOT NULL,
	[nombre] [varchar](250) NOT NULL,
	[direccion] [varchar](250) NOT NULL,
	[actCentral] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_NitFactura_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[nit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrdenCliente]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrdenCliente](
	[empresa] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idOrdenCliente] [int] IDENTITY(1,1) NOT NULL,
	[cliente] [int] NOT NULL,
	[fecha] [date] NULL,
	[dia] [int] NULL,
	[horaInicio] [char](8) NULL,
	[horaFin] [char](8) NULL,
	[estRegistro] [char](2) NOT NULL,
	[idCitaActual] [int] NULL,
	[comentariosCita] [varchar](300) NULL,
	[comentarios] [varchar](300) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_OrdenCliente] PRIMARY KEY CLUSTERED 
(
	[idOrdenCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Paquete]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Paquete](
	[empresa] [smallint] NOT NULL,
	[idPaquete] [int] NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[descripcion] [nvarchar](200) NOT NULL,
	[precio] [money] NULL,
	[estPaquete] [nchar](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Paquete_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idPaquete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[planilla_empleado]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[planilla_empleado](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[corrPlanilla] [int] NOT NULL,
	[corrEmpleado] [int] NOT NULL,
	[montoTotal] [money] NOT NULL,
	[descripcion] [varchar](50) NULL,
	[fecha_creacion] [datetime] NOT NULL,
	[bonificacion] [money] NOT NULL,
	[sueldoBase] [money] NOT NULL,
	[descuento] [money] NOT NULL,
	[comision] [money] NOT NULL,
	[igss] [money] NOT NULL,
	[costo_hora_extra] [money] NOT NULL,
	[asistencia] [int] NOT NULL,
	[hora_extra] [money] NULL,
	[descuentoInasistencia] [money] NULL,
	[eliminado] [char](1) NULL,
 CONSTRAINT [PK_planilla_empleado] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[planilla_empleado_rubro]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[planilla_empleado_rubro](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[corrPlanillaEmp] [int] NULL,
	[rubro] [varchar](50) NOT NULL,
	[cantidad] [int] NOT NULL,
	[montoTotal] [money] NOT NULL,
	[signo] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
	[costoUnitario] [money] NULL,
 CONSTRAINT [PK_planilla_empleado_rubro] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[planilla_rubro_descripcion]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[planilla_rubro_descripcion](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[rubro] [varchar](20) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_planilla_rubro_descripcion] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[planilla_total]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[planilla_total](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[fecha_creacion] [datetime] NOT NULL,
	[autorizada] [char](1) NOT NULL,
	[montoTotal] [money] NOT NULL,
	[registros] [int] NOT NULL,
	[descuentoTotal] [money] NOT NULL,
	[bonosTotal] [money] NOT NULL,
	[comisionTotal] [money] NOT NULL,
	[tipoPlanilla] [int] NOT NULL,
	[categoriaPlanilla] [varchar](5) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[bloqueada] [char](1) NOT NULL,
	[enviado] [char](1) NOT NULL,
	[fecha_planilla] [datetime] NOT NULL,
	[numeroPlan] [varchar](5) NULL,
	[numeroEnvio] [varchar](20) NULL,
	[igssTotal] [money] NOT NULL,
	[usuario] [varchar](20) NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[terminal] [varchar](50) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[horasExtraTotal] [money] NULL,
 CONSTRAINT [PK_planillaTotal] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrecioProducto]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrecioProducto](
	[empresa] [smallint] NOT NULL,
	[idPrecProdServ] [int] IDENTITY(1,1) NOT NULL,
	[tipoPrecio] [char](10) NOT NULL,
	[idProducto] [int] NOT NULL,
	[precio] [money] NOT NULL,
	[precioMaximo] [money] NULL,
	[fechaVigencia] [datetime] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_PrecioProducto] PRIMARY KEY CLUSTERED 
(
	[idPrecProdServ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrecioServicio]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrecioServicio](
	[empresa] [smallint] NOT NULL,
	[idPrecServicio] [int] IDENTITY(1,1) NOT NULL,
	[tipoPrecio] [char](10) NOT NULL,
	[idServicio] [int] NOT NULL,
	[precio] [money] NOT NULL,
	[precioMaximo] [money] NOT NULL,
	[fechaVigencia] [datetime] NOT NULL,
 CONSTRAINT [PK_PrecioServicio] PRIMARY KEY CLUSTERED 
(
	[idPrecServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Producto](
	[empresa] [smallint] NOT NULL,
	[tipoProducto] [int] NOT NULL,
	[idProd] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[descripcion] [nvarchar](150) NULL,
	[codigoBarras] [varchar](50) NULL,
	[codigoSAP] [varchar](50) NULL,
	[idMarca] [char](10) NULL,
	[imagenRef] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[idProd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductoProveedor]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductoProveedor](
	[empresa] [smallint] NULL,
	[idProducto] [int] NOT NULL,
	[idProveedor] [int] NOT NULL,
	[ultimaCompra] [datetime] NULL,
	[fechaing] [datetime] NOT NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[eliminado] [char](1) NOT NULL,
 CONSTRAINT [PK_ProductoProveedor] PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC,
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Propina]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Propina](
	[empresa] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idPropina] [int] IDENTITY(1,1) NOT NULL,
	[idDetalleOrdenServicio] [int] NULL,
	[cantidad] [money] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Propina] PRIMARY KEY CLUSTERED 
(
	[idPropina] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SalidaEfectivoCaja]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SalidaEfectivoCaja](
	[empresa] [smallint] NOT NULL,
	[idSalidaEfectivo] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[fechaHoraSEC] [datetime] NOT NULL,
	[motivoSalidaEfectivo] [char](10) NOT NULL,
	[monto] [money] NOT NULL,
	[moneda] [char](10) NULL,
	[idAutorizacion] [int] NOT NULL,
	[idCierreCaja] [int] NULL,
	[confirmaCierreCaja] [int] NULL,
	[idDoc] [int] NULL,
	[idFacturaFormaPago] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_SalidaEfectivoCaja] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSalidaEfectivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SerieFactura]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SerieFactura](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idSerieFactura] [int] IDENTITY(1,1) NOT NULL,
	[terminal] [varchar](50) NOT NULL,
	[tipoCorrelativo] [char](10) NOT NULL,
	[serie] [varchar](50) NOT NULL,
	[rangoInicio] [int] NOT NULL,
	[rangoFinal] [int] NOT NULL,
	[noFactura] [int] NOT NULL,
	[fechaVigencia] [datetime] NOT NULL,
	[estRegistro] [char](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_SerieFactura_1] PRIMARY KEY CLUSTERED 
(
	[idSerieFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Servicio]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Servicio](
	[empresa] [smallint] NOT NULL,
	[tipoServicio] [int] NOT NULL,
	[idServicio] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[descripcion] [nvarchar](150) NULL,
	[duracionServicio] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Servicio_1] PRIMARY KEY CLUSTERED 
(
	[idServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServicioEmpleado]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ServicioEmpleado](
	[empresa] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idServicio] [int] NOT NULL,
	[idEmpleado] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_ServicioEmpleado] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idServicio] ASC,
	[idEmpleado] ASC,
	[fechaing] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServicioPlan]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ServicioPlan](
	[empresa] [smallint] NULL,
	[idServicioPlan] [int] NULL,
	[idSucursal] [int] NULL,
	[idCliente] [int] NULL,
	[montoTotal] [money] NULL,
	[descuento] [money] NULL,
	[cuotas] [money] NULL,
	[plazo] [char](10) NULL,
	[periodo] [char](10) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SucursalServicio]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SucursalServicio](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idServicio] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_SucursalServicio] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idServicio] ASC,
	[fechaing] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoProducto]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoProducto](
	[empresa] [smallint] NOT NULL,
	[idTipoProducto] [int] IDENTITY(1,1) NOT NULL,
	[clasificacionTP] [char](10) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[descripcion] [nvarchar](150) NULL,
	[padre] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_TipoProducto] PRIMARY KEY CLUSTERED 
(
	[idTipoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoServicio]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoServicio](
	[empresa] [smallint] NOT NULL,
	[idTipoServicio] [int] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[descripcion] [nvarchar](150) NULL,
	[padre] [int] NULL,
	[coordinacion] [char](10) NOT NULL,
	[cuentaSAP] [nvarchar](50) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_TipoServicio_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idTipoServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ubicacion]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Ubicacion](
	[empresa] [smallint] NULL,
	[idSucursal] [int] NULL,
	[idUbicacion] [int] NULL,
	[descripcion] [varchar](250) NULL,
	[idDireccion] [int] NULL,
	[idEncargado] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UbicacionAtributo]    Script Date: 16/06/2016 11:41:52 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UbicacionAtributo](
	[empresa] [smallint] NULL,
	[idUbicacion] [int] NULL,
	[nombre] [varchar](30) NULL,
	[descripcion] [varchar](100) NULL,
	[valor] [varchar](20) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Descuento]  WITH CHECK ADD  CONSTRAINT [FK_Descuento_Documento] FOREIGN KEY([idDoc])
REFERENCES [dbo].[Documento] ([idDoc])
GO
ALTER TABLE [dbo].[Descuento] CHECK CONSTRAINT [FK_Descuento_Documento]
GO
ALTER TABLE [dbo].[Descuento]  WITH CHECK ADD  CONSTRAINT [FK_Descuento_Movimiento] FOREIGN KEY([idMov])
REFERENCES [dbo].[Movimiento] ([idMov])
GO
ALTER TABLE [dbo].[Descuento] CHECK CONSTRAINT [FK_Descuento_Movimiento]
GO
ALTER TABLE [dbo].[DetalleCita]  WITH CHECK ADD  CONSTRAINT [FK_DetalleCita_Cita] FOREIGN KEY([idCita])
REFERENCES [dbo].[Cita] ([idCita])
GO
ALTER TABLE [dbo].[DetalleCita] CHECK CONSTRAINT [FK_DetalleCita_Cita]
GO
ALTER TABLE [dbo].[DetalleOrdenProducto]  WITH CHECK ADD  CONSTRAINT [FK_DetalleOrdenProducto_OrdenCliente] FOREIGN KEY([idOrdenCliente])
REFERENCES [dbo].[OrdenCliente] ([idOrdenCliente])
GO
ALTER TABLE [dbo].[DetalleOrdenProducto] CHECK CONSTRAINT [FK_DetalleOrdenProducto_OrdenCliente]
GO
ALTER TABLE [dbo].[DetalleOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_DetalleOrdenServicio_OrdenCliente] FOREIGN KEY([idOrdenCliente])
REFERENCES [dbo].[OrdenCliente] ([idOrdenCliente])
GO
ALTER TABLE [dbo].[DetalleOrdenServicio] CHECK CONSTRAINT [FK_DetalleOrdenServicio_OrdenCliente]
GO
ALTER TABLE [dbo].[DetCatalogo]  WITH CHECK ADD  CONSTRAINT [FK_DetCatalogo_CabCatalogo] FOREIGN KEY([cd_IdCatalogo])
REFERENCES [dbo].[CabCatalogo] ([cc_IdCatalogo])
GO
ALTER TABLE [dbo].[DetCatalogo] CHECK CONSTRAINT [FK_DetCatalogo_CabCatalogo]
GO
ALTER TABLE [dbo].[Documento]  WITH CHECK ADD  CONSTRAINT [FK_Documento_SerieFactura] FOREIGN KEY([idSerieFactura])
REFERENCES [dbo].[SerieFactura] ([idSerieFactura])
GO
ALTER TABLE [dbo].[Documento] CHECK CONSTRAINT [FK_Documento_SerieFactura]
GO
ALTER TABLE [dbo].[FacturaActualCaja]  WITH CHECK ADD  CONSTRAINT [FK_FacturaActualCaja_Documento] FOREIGN KEY([idDoc])
REFERENCES [dbo].[Documento] ([idDoc])
GO
ALTER TABLE [dbo].[FacturaActualCaja] CHECK CONSTRAINT [FK_FacturaActualCaja_Documento]
GO
ALTER TABLE [dbo].[FacturaFormaPago]  WITH CHECK ADD  CONSTRAINT [FK_FacturaFormaPago_Documento] FOREIGN KEY([idDoc])
REFERENCES [dbo].[Documento] ([idDoc])
GO
ALTER TABLE [dbo].[FacturaFormaPago] CHECK CONSTRAINT [FK_FacturaFormaPago_Documento]
GO
ALTER TABLE [dbo].[Movimiento]  WITH CHECK ADD  CONSTRAINT [FK_Movimiento_Documento] FOREIGN KEY([idDoc])
REFERENCES [dbo].[Documento] ([idDoc])
GO
ALTER TABLE [dbo].[Movimiento] CHECK CONSTRAINT [FK_Movimiento_Documento]
GO
ALTER TABLE [dbo].[Movimiento]  WITH CHECK ADD  CONSTRAINT [FK_Movimiento_OrdenCliente] FOREIGN KEY([idOrdenCliente])
REFERENCES [dbo].[OrdenCliente] ([idOrdenCliente])
GO
ALTER TABLE [dbo].[Movimiento] CHECK CONSTRAINT [FK_Movimiento_OrdenCliente]
GO
ALTER TABLE [dbo].[MovimientoCuentaXCobrar]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoCuentaXCobrar_CuentaXCobrar] FOREIGN KEY([idCuentaXCobrar])
REFERENCES [dbo].[CuentaXCobrar] ([idCuentaXCobrar])
GO
ALTER TABLE [dbo].[MovimientoCuentaXCobrar] CHECK CONSTRAINT [FK_MovimientoCuentaXCobrar_CuentaXCobrar]
GO
ALTER TABLE [dbo].[PrecioProducto]  WITH CHECK ADD  CONSTRAINT [FK_PrecioProducto_Producto] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Producto] ([idProd])
GO
ALTER TABLE [dbo].[PrecioProducto] CHECK CONSTRAINT [FK_PrecioProducto_Producto]
GO
ALTER TABLE [dbo].[PrecioServicio]  WITH CHECK ADD  CONSTRAINT [FK_PrecioServicio_Servicio] FOREIGN KEY([idServicio])
REFERENCES [dbo].[Servicio] ([idServicio])
GO
ALTER TABLE [dbo].[PrecioServicio] CHECK CONSTRAINT [FK_PrecioServicio_Servicio]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [FK_Producto_TipoProducto] FOREIGN KEY([tipoProducto])
REFERENCES [dbo].[TipoProducto] ([idTipoProducto])
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [FK_Producto_TipoProducto]
GO
ALTER TABLE [dbo].[ProductoProveedor]  WITH CHECK ADD  CONSTRAINT [FK_ProductoProveedor_Producto] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Producto] ([idProd])
GO
ALTER TABLE [dbo].[ProductoProveedor] CHECK CONSTRAINT [FK_ProductoProveedor_Producto]
GO
ALTER TABLE [dbo].[Propina]  WITH CHECK ADD  CONSTRAINT [FK_Propina_DetalleOrdenServicio] FOREIGN KEY([idDetalleOrdenServicio])
REFERENCES [dbo].[DetalleOrdenServicio] ([idDetalleOrdenServicio])
GO
ALTER TABLE [dbo].[Propina] CHECK CONSTRAINT [FK_Propina_DetalleOrdenServicio]
GO
USE [master]
GO
ALTER DATABASE [new_ortodental] SET  READ_WRITE 
GO


