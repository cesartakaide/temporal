/****** Object:  Table [dbo].[Paquete]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Paquete_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idPaquete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[ArqueoCaja]    Script Date: 09/06/2016 12:03:46 a.m. ******/
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
	[eliminado] char(1) not null,
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

/****** Object:  Table [dbo].[CierreCaja]    Script Date: 09/06/2016 12:03:46 a.m. ******/
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
	[eliminado] char(1) not null,
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


/****** Object:  Table [dbo].[DetalleCierreCaja]    Script Date: 09/06/2016 12:03:46 a.m. ******/
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
	[eliminado] char(1) not null,
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




/****** Object:  Table [dbo].[CierreDiario]    Script Date: 09/06/2016 12:03:46 a.m. ******/
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
	[eliminado] char(1) not null,
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

/****** Object:  Table [dbo].[CierreMensualDocumentoPromo]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[eliminado] char(1) not null,
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


/****** Object:  Table [dbo].[CitaActual]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cita](
	[empresa] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idCitaActual] [int] NOT NULL,
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
	[eliminado] char(1) not null,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_CitaActual_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idCitaActual] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DetalleCitaActual]    Script Date: 09/06/2016 12:03:46 a.m. ******/
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
	[idDetalleCita] [int] NOT NULL,
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
	[eliminado] char(1) not null,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_DetalleCitaActual] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idCitaActual] ASC,
	[idDetalleCitaActual] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[CuentaContable]    Script Date: 09/06/2016 12:03:46 a.m. ******/
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
	[eliminado] char(1) not null,
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






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CuentaXCobrar](
	[empresa] [smallint] NOT NULL,
	[idCuentaXCobrar] [int] NOT NULL,
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
	[eliminado] char(1) not null,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_CuentaXCobrar_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idCuentaXCobrar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Descuento](
	[empresa] [smallint] NOT NULL,
	[idDescuento] [int] NOT NULL,
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
	[eliminado] char(1) not null,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Descuento] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idDescuento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[Despacho]    Script Date: 09/06/2016 12:03:46 a.m. ******/
/*
NO SE VA A MANEJAR ESTA TABLA.
EN SU LUGAR, SE VA A DEFINIR UNA TABLA DE UBICACION.

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Despacho](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idDespacho] [int] NOT NULL,
	[idOrdenServicio] [int] NOT NULL,
	[idDetalleOrdenServicio] [int] NOT NULL,
	[noBoletaDespacho] [int] NULL,
	[idEmpleado] [int] NOT NULL,
	[estDespacho] [char](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Despacho] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idDespacho] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetalleDespacho](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idDespacho] [int] NOT NULL,
	[idDetalleDespacho] [int] NOT NULL,
	[idProducto] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[estDetalleDespacho] [char](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_DetalleDespacho] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idDespacho] ASC,
	[idDetalleDespacho] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
*/

/****** Object:  Table [dbo].[OrdenServicio]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrdenCliente](
	[empresa] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idOrdenCliente] [int] NOT NULL,
	[cliente] [int] NOT NULL,
	[fecha] [date] NULL,
	[dia] [int] NULL,
	[horaInicio] [char](8) NULL,
	[horaFin] [char](8) NULL,
	[estRegistro] [char](2) NOT NULL,
	--[idOrdenPago] [int] NOT NULL,
	[idCitaActual] [int] NULL,
	[comentariosCita] [varchar](300) NULL,
	[comentarios] [varchar](300) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_OrdenServicio] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idOrdenCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[DetalleOrdenServicio]    Script Date: 09/06/2016 12:03:46 a.m. ******/
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
	[idDetalleOrdenServicio] [int] NOT NULL,
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
	[eliminado] char(1) not null,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_DetalleOrdenServicio] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idOrdenServicio] ASC,
	[idDetalleOrdenServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

create table DetalleOrdenProducto(
    empresa smallint not null,
	idSucursal int not null,
    idOrdenCliente int not null,
	idDetalleOrdenProducto int not null,
    idProducto int not null,
    cantidad int not null,
    costoUnitario money not null,
    montoTotal money not null,
    estado varchar(10) not null,
    [fechaing] [datetime] NOT NULL,
    [fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [timestamp] NOT NULL,  
	CONSTRAINT [PK_DetalleOrdenServicio] PRIMARY KEY CLUSTERED (
	   empresa asc
	   ,idOrdenProducto asc
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]




/****** Object:  Table [dbo].[Documento]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Documento](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idDoc] [int] NOT NULL,
	[tipoDocumento] [char](10) NOT NULL,
	[tipoAsociado] [char](10) NULL,
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
	[eliminado] char(1) not null,
	[rowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Documento] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idDoc] ASC,
	[tipoDocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentoPromo]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Tarjeta_1] PRIMARY KEY CLUSTERED 
(
	[idDocumentoPromo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DocumentoPromoPaquete]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[eliminado] char(1) not null,
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
/****** Object:  Table [dbo].[DocumentoPromoProducto]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_DocumentoPromoProducto] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idDocumentoPromo] ASC,
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[eliminado] char(1) not null,
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


/****** Object:  Table [dbo].[FacturaActualCaja]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_FacturaActualCaja] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[terminal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[FacturaFormaPago]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacturaFormaPago](
	[empresa] [smallint] NOT NULL,
	[idFacturaFormaPago] [int] NOT NULL,
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_FacturaFormaPago] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idFacturaFormaPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO



/****** Object:  Table [dbo].[Movimiento]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movimiento](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idMov] [int] NOT NULL,
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Movimiento] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idMov] ASC,
	[tipoMovimiento] ASC,
	[idDoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovimientoCuentaXCobrar]    Script Date: 09/06/2016 12:03:46 a.m. ******/
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_MovimientoCuentaXCobrar] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idCuentaXCobrar] ASC,
	[idMovCuentaXCobrar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovimientoDocumentoPromo]    Script Date: 09/06/2016 12:03:46 a.m. ******/
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
	[eliminado] char(1) not null,
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




/****** Object:  Table [dbo].[NitFactura]    Script Date: 09/06/2016 12:03:46 a.m. ******/
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_NitFactura] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[nit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO



/****** Object:  Table [dbo].[OrdenPago]    Script Date: 09/06/2016 12:03:46 a.m. ******/
--ESTE CONCEPTO YA NO SE VA A UTILIZAR.
/*SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrdenPago](
	[empresa] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idOrdenPago] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[cliente] [int] NOT NULL,
	[estRegistro] [char](2) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_OrdenPago] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idOrdenPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
*/



/****** Object:  Table [dbo].[Producto]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Producto](
	[empresa] [smallint] NOT NULL,
	[tipoProducto] [int] NOT NULL,
	[idProd] [int] NOT NULL,
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Producto_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tipoProducto] ASC,
	[idProd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[PrecioProductoServicio]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrecioProductoServicio](
	[empresa] [smallint] NOT NULL,
	[idPrecProdServ] [int] NOT NULL,
	[tipoPrecio] [char](10) NOT NULL,
	[idProdServ] [int] NOT NULL,
	[precio] [money] NOT NULL,
	[precioMaximo] [money] NULL,
	[fechaVigencia] [datetime] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_PrecioProductoServicio] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idPrecProdServ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[TipoProducto]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoProducto](
	[empresa] [smallint] NOT NULL,
	[idTipoProducto] [int] NOT NULL,
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_TipoProducto_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idTipoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO



/****** Object:  Table [dbo].[Servicio]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servicio](
	[empresa] [smallint] NOT NULL,
	[tipoServicio] [int] NOT NULL,
	[idServicio] [int] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[descripcion] [nvarchar](150) NULL,
	[duracionServicio] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Servicio] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[TipoServicio]    Script Date: 09/06/2016 12:03:46 a.m. ******/
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_TipoServicio_1] PRIMARY KEY CLUSTERED 
(
	[ts_empresa] ASC,
	[ts_IdTipoServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[LoteDocumentoPromo]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_LoteDocumentoPromo_1] PRIMARY KEY CLUSTERED 
(
	[ld_empresa] ASC,
	[ld_IdLoteDocumentoPromo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET

/*
solo aplica a empleados.
no se va a aplicar por el momento.

CREATE TABLE [dbo].[Prestamo](
	[empresa] [smallint] NOT NULL,
	[idPrestamo] [int] NOT NULL,
	[tipoPrestamo] [char](10) NOT NULL,
	[idEmpleado] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[monto] [money] NOT NULL,
	[plazo] [int] NOT NULL,
	[tasaInteres] [money] NOT NULL,
	[saldo] [money] NOT NULL,
	[idGestion] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Prestamo] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[IdPrestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetallePrestamo](
	[empresa] [smallint] NOT NULL,
	[idPrestamo] [int] NOT NULL,
	[idDetallePrestamo] [int] NOT NULL,
	[mes] [int] NOT NULL,
	[anio] [int] NOT NULL,
	[descripcion] [varchar](200) NULL,
	[monto] [money] NULL,
	[estDetallePrestamo] [char](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_DetallePrestamo] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idPrestamo] ASC,
	[idDetallePrestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

*/

/****** Object:  Table [dbo].[Propina]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Propina](
	[empresa] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idPropina] [int] NOT NULL,
	--[idOrdenPago] [int] NOT NULL,
	[idOrdenServicio] [int] NOT NULL,
	[idDetalleOrdenServicio] [int] NULL,
	[cantidad] [money] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Propina] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSucursal] ASC,
	[idPropina] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_SalidaEfectivoCaja] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSalidaEfectivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



/****** Object:  Table [dbo].[SerieFactura]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SerieFactura](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idSerieFactura] [int] NOT NULL,
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
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_SerieFactura] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idSerieFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



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
	[eliminado] char(1) not null,
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



/****** Object:  Table [dbo].[ServicioTraslape]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServicioTraslape](
	[empresa] [int] NOT NULL,
	[idServicioOrigen] [int] NOT NULL,
	[idServicioTraslape] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] char(1) not null,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_ServicioTraslape] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idServicioOrigen] ASC,
	[idServicioTraslape] ASC,
	[fechaing] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[SucursalServicio]    Script Date: 09/06/2016 12:03:46 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[eliminado] char(1) not null,
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


create table ServicioPlan(
empresa smallint
, idServicioPlan int  (PK)
, idSucursal int
, idCliente int
, montoTotal money
, descuento money
, cuotas money
, plazo char(10)
, periodo char(10)
,	[fechaing] [datetime] NOT NULL
,	[fechamod] [datetime] NULL
,	[usuarioing] [nvarchar](50) NOT NULL
,	[usuariomod] [nvarchar](50) NULL
,	[maquinaing] [nvarchar](50) NOT NULL
,	[maquinamod] [nvarchar](50) NULL
,	[eliminado] char(1) not null
,	[rowVersion] [int] NOT NULL
)


create table DetalleServicioPlan (
empresa
,idSucursal int
,idServicioPlan int (fk, pk)
,idServicio int (fk, pk)
,montoServicio money
,descuento money
,fechaInicio datetime
,sesiones int
,	[fechaing] [datetime] NOT NULL
,	[fechamod] [datetime] NULL
,	[usuarioing] [nvarchar](50) NOT NULL
,	[usuariomod] [nvarchar](50) NULL
,	[maquinaing] [nvarchar](50) NOT NULL
,	[maquinamod] [nvarchar](50) NULL
,	[eliminado] char(1) not null
,	[rowVersion] [int] NOT NULL
)


create table Ubicacion(
empresa
,idSucursal int
,idUbicacion int PK
,descripcion varchar(250)
,idDireccion int
,idEncargado int
,	[fechaing] [datetime] NOT NULL
,	[fechamod] [datetime] NULL
,	[usuarioing] [nvarchar](50) NOT NULL
,	[usuariomod] [nvarchar](50) NULL
,	[maquinaing] [nvarchar](50) NOT NULL
,	[maquinamod] [nvarchar](50) NULL
,	[eliminado] char(1) not null
,	[rowVersion] [int] NOT NULL
)

create table UbicacionAtributo (
empresa int
,idUbicacion int      FK, pk
,nombre varchar(30)   pk
,descripcion varchar(100)
,valor varchar(20)
,	[fechaing] [datetime] NOT NULL
,	[fechamod] [datetime] NULL
,	[usuarioing] [nvarchar](50) NOT NULL
,	[usuariomod] [nvarchar](50) NULL
,	[maquinaing] [nvarchar](50) NOT NULL
,	[maquinamod] [nvarchar](50) NULL
,	[eliminado] char(1) not null
,	[rowVersion] [int] NOT NULL
)

create table ProductoProveedor(
 empresa int
 ,idProducto int (FK, PK)
 ,idProveedor int (FK, PK)
 ,ultimaCompra datetime  
,	[fechaing] [datetime] NOT NULL
,	[usuarioing] [nvarchar](50) NOT NULL
,	[maquinaing] [nvarchar](50) NOT NULL
,	[eliminado] char(1) not null
)


