USE [master]
GO
/****** Object:  Database [ortodental]    Script Date: 16/06/2016 09:36:54 p.m. ******/
CREATE DATABASE [ortodental]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ortodental.mdf' , SIZE = 1384448KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10240KB )
 LOG ON 
( NAME = N'OD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ortodental_log.ldf' , SIZE = 278784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ortodental] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ortodental].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ortodental] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ortodental] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ortodental] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ortodental] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ortodental] SET ARITHABORT OFF 
GO
ALTER DATABASE [ortodental] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ortodental] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ortodental] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ortodental] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ortodental] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ortodental] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ortodental] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ortodental] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ortodental] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ortodental] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ortodental] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ortodental] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ortodental] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ortodental] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ortodental] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ortodental] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ortodental] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ortodental] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ortodental] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ortodental] SET  MULTI_USER 
GO
ALTER DATABASE [ortodental] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ortodental] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ortodental] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ortodental] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ortodental]
GO
/****** Object:  User [UserOD]    Script Date: 16/06/2016 09:36:56 p.m. ******/
CREATE USER [UserOD] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [UserOD]
GO
ALTER ROLE [db_datareader] ADD MEMBER [UserOD]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [UserOD]
GO
/****** Object:  StoredProcedure [dbo].[AGENDACOBROS]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/************************ VER AGENDACOBROS **********************************/
/********* USAR DESPUES DE GENCOBROSAGENDA **********************************/
CREATE PROCEDURE [dbo].[AGENDACOBROS]
@ValFecha int,
@Area int,
@Terminal int
AS
BEGIN
SET NOCOUNT ON
SELECT     Horario.*, A.*,B.*,C.*,D.*,E.*,F.*,G.*,H.* 
FROM         Horario 
LEFT OUTER JOIN
	(
		select HoraVal as AHoraVal, Cliente as ACliente, Nombre as ANombre, TipoTx as ATipoTx, Des as ADes,
		Des2 as AFueLlamado, Monto1 as ATot  
		from tcobrosagenda
		Where Sillon='A'
		And Terminal=@Terminal                     
	) 	AS A ON  Horario.HoraVal = A.AHORAVAL 
LEFT OUTER JOIN
	(
		select HoraVal as BHoraVal, Cliente as BCliente, Nombre as BNombre, TipoTx as BTipoTx, Des as BDes,
		Des2 as BFueLlamado, Monto1 as BTot  
		from tcobrosagenda
		Where Sillon='B'
		And Terminal=@Terminal                     
	) 	AS B ON  Horario.HoraVal = B.BHORAVAL 
LEFT OUTER JOIN
	(
		select HoraVal as CHoraVal, Cliente as CCliente, Nombre as CNombre, TipoTx as CTipoTx, Des as CDes,
		Des2 as CFueLlamado, Monto1 as CTot  
		from tcobrosagenda
		Where Sillon='C'
		And Terminal=@Terminal                  
	) 	AS C ON  Horario.HoraVal = C.CHORAVAL 
LEFT OUTER JOIN
	(
		select HoraVal as DHoraVal, Cliente as DCliente, Nombre as DNombre, TipoTx as DTipoTx, Des as DDes,
		Des2 as DFueLlamado, Monto1 as DTot  
		from tcobrosagenda
		Where Sillon='D'
		And Terminal=@Terminal                     
	) 	AS D ON  Horario.HoraVal = D.DHORAVAL 
LEFT OUTER JOIN
	(
		select HoraVal as EHoraVal, Cliente as ECliente, Nombre as ENombre, TipoTx as ETipoTx, Des as EDes,
		Des2 as EFueLlamado, Monto1 as ETot  
		from tcobrosagenda
		Where Sillon='E'
		And Terminal=@Terminal                     
	) 	AS E ON  Horario.HoraVal = E.EHORAVAL 
LEFT OUTER JOIN
	(
		select HoraVal as FHoraVal, Cliente as FCliente, Nombre as FNombre, TipoTx as FTipoTx, Des as FDes,
		Des2 as FFueLlamado, Monto1 as FTot  
		from tcobrosagenda
		Where Sillon='F'
		And Terminal=@Terminal                     
	) 	AS F ON  Horario.HoraVal = F.FHORAVAL 
LEFT OUTER JOIN
	(
		select HoraVal as GHoraVal, Cliente as GCliente, Nombre as GNombre, TipoTx as GTipoTx, Des as GDes,
		Des2 as GFueLlamado, Monto1 as GTot  
		from tcobrosagenda
		Where Sillon='G'
		And Terminal=@Terminal                     
	) 	AS G ON  Horario.HoraVal = G.GHORAVAL 
LEFT OUTER JOIN
	(
		select HoraVal as HHoraVal, Cliente as HCliente, Nombre as HNombre, TipoTx as HTipoTx, Des as HDes,
		Des2 as HFueLlamado, Monto1 as HTot  
		from tcobrosagenda
		Where Sillon='H'
		And Terminal=@Terminal                     
	) 	AS H ON  Horario.HoraVal = H.HHORAVAL 
WHERE Horario.FechaVal=@ValFecha and Horario.Area=@Area
ORDER BY Horario.Hora 
END
GO
/****** Object:  StoredProcedure [dbo].[AGENDADIARIA]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AGENDADIARIA]
@ValFecha int,
@Area int
AS
BEGIN
SET NOCOUNT ON
SELECT     Horario.*, A.*,B.*,C.*,D.*,E.*,F.*,G.*,H.*
FROM         Horario 
	LEFT OUTER JOIN
                          (SELECT     Cita.Fecha AS AFECHA, Cita.Hora AS AHORA, Cita.Area AS AAREA, Cita.Sillon AS ASILLON, Cita.Cliente AS ACLIENTE, Cita.Doctor AS ADOCTOR, 
                                                   Cita.Cumplida AS ACUMPLIDA, Cita.Bloqueada AS ABLOQUEADA, Cliente.Nombre AS ACLIENTEDES, Cliente.Telefono AS ACLIENTETEL, 
                                                   CASE WHEN Cita.Bloqueada = 1 THEN '(HORA BLOQUEADA)' ELSE COALESCE (TipoCita.Descripcion, '') END AS ATIPOCITADES, 
                                                   Usuario.Nombre AS AUSER, Doctor.Nombre AS ADOCTORDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqDes, '(HORA BLOQUEADA)') 
                                                   ELSE Cliente.Nombre END AS ADES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqTel, '') ELSE Cliente.Telefono END AS ATEL, 
                                                   CASE WHEN Cita.Cumplida = 0 THEN 'NO ASISTIO' WHEN cita.Cumplida = 5 THEN 'CANCELO' ELSE '' END AS AASIST, 
                                                   Usuario.TipoUsuario AS ATIPOUSUARIO, Cliente.Aviso AS AAVISO, Cliente.Info AS AINFO, CASE WHEN len(ltrim(rtrim(Cliente.Aviso))) 
                                                   > 1 THEN 'A' ELSE '' END AS AAVISODES, CASE WHEN len(ltrim(rtrim(Cliente.Archivo))) > 0 AND len(ltrim(rtrim(Cliente.IDFotos))) 
                                                   > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) + ' (' + COALESCE (Cliente.Archivo, '') + ')' WHEN len(ltrim(rtrim(Cliente.Archivo))) = 0 AND 
                                                   len(ltrim(rtrim(Cliente.IDFotos))) > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) ELSE '' END AS AINFODES, 
                                                   CASE WHEN TipoCita.Resaltar = 1 THEN COALESCE (TipoCita.Descripcion, '') ELSE '' END AS ARESAL, cita.FechaVal as AFechaVal, cita.HoraVal as AHoraVal
                            FROM             (Doctor RIGHT JOIN
                                                   (TipoCita RIGHT JOIN
                                                   (Cliente RIGHT JOIN
                                                   (Cita LEFT JOIN
                                                   Usuario ON Cita.Responsable = Usuario.Id) ON Cliente.Cliente = Cita.Cliente) ON TipoCita.TipoCita = Cita.TipoCita) ON Doctor.Doctor = Cita.Doctor) 
                            WHERE      Cita.FechaVal=@ValFecha and Cita.Area=@Area and Cita.Sillon = 'A'
		) AS A ON  Horario.Area = A.AAREA AND Horario.HoraVal = A.AHORAVAL AND Horario.FechaVal = A.AfechaVal
	LEFT OUTER JOIN
                          (SELECT     Cita.Fecha AS BFECHA, Cita.Hora AS BHORA, Cita.Area AS BAREA, Cita.Sillon AS BSILLON, Cita.Cliente AS BCLIENTE, Cita.Doctor AS BDOCTOR, 
                                                   Cita.Cumplida AS BCUMPLIDA, Cita.Bloqueada AS BBLOQUEADA, Cliente.Nombre AS BCLIENTEDES, Cliente.Telefono AS BCLIENTETEL, 
                                                   CASE WHEN Cita.Bloqueada = 1 THEN '(HORA BLOQUEADA)' ELSE COALESCE (TipoCita.Descripcion, '') END AS BTIPOCITADES, 
                                                   Usuario.Nombre AS BUSER, Doctor.Nombre AS BDOCTORDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqDes, '(HORA BLOQUEADA)') 
                                                   ELSE Cliente.Nombre END AS BDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqTel, '') ELSE Cliente.Telefono END AS BTEL, 
                                                   CASE WHEN Cita.Cumplida = 0 THEN 'NO ASISTIO' WHEN cita.Cumplida = 5 THEN 'CANCELO' ELSE '' END AS BASIST, 
                                                   Usuario.TipoUsuario AS BTIPOUSUARIO, Cliente.Aviso AS BAVISO, Cliente.Info AS BINFO, CASE WHEN len(ltrim(rtrim(Cliente.Aviso))) 
                                                   > 1 THEN 'A' ELSE '' END AS BAVISODES, CASE WHEN len(ltrim(rtrim(Cliente.Archivo))) > 0 AND len(ltrim(rtrim(Cliente.IDFotos))) 
                                                   > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) + ' (' + COALESCE (Cliente.Archivo, '') + ')' WHEN len(ltrim(rtrim(Cliente.Archivo))) = 0 AND 
                                                   len(ltrim(rtrim(Cliente.IDFotos))) > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) ELSE '' END AS BINFODES, 
                                                   CASE WHEN TipoCita.Resaltar = 1 THEN COALESCE (TipoCita.Descripcion, '') ELSE '' END AS BRESAL, cita.FechaVal AS BFechaVal, cita.HoraVal as BHoraVal
                            FROM             (Doctor RIGHT JOIN
                                                   (TipoCita RIGHT JOIN
                                                   (Cliente RIGHT JOIN
                                                   (Cita LEFT JOIN
                                                   Usuario ON Cita.Responsable = Usuario.Id) ON Cliente.Cliente = Cita.Cliente) ON TipoCita.TipoCita = Cita.TipoCita) ON Doctor.Doctor = Cita.Doctor) 
                            WHERE      Cita.FechaVal=@ValFecha and Cita.Area=@Area and Cita.Sillon = 'B'
		) AS B ON  Horario.Area = B.BAREA AND Horario.HoraVal = B.BHORAVAL AND Horario.FechaVal = B.BfechaVal
	LEFT OUTER JOIN
                          (SELECT     Cita.Fecha AS CFECHA, Cita.Hora AS CHORA, Cita.Area AS CAREA, Cita.Sillon AS CSILLON, Cita.Cliente AS CCLIENTE, Cita.Doctor AS CDOCTOR, 
                                                   Cita.Cumplida AS CCUMPLIDA, Cita.Bloqueada AS CBLOQUEADA, Cliente.Nombre AS CCLIENTEDES, Cliente.Telefono AS CCLIENTETEL, 
                                                   CASE WHEN Cita.Bloqueada = 1 THEN '(HORA BLOQUEADA)' ELSE COALESCE (TipoCita.Descripcion, '') END AS CTIPOCITADES, 
                                                   Usuario.Nombre AS CUSER, Doctor.Nombre AS CDOCTORDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqDes, '(HORA BLOQUEADA)') 
                                                   ELSE Cliente.Nombre END AS CDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqTel, '') ELSE Cliente.Telefono END AS CTEL, 
                                                   CASE WHEN Cita.Cumplida = 0 THEN 'NO ASISTIO' WHEN cita.Cumplida = 5 THEN 'CANCELO' ELSE '' END AS CASIST, 
                                                   Usuario.TipoUsuario AS CTIPOUSUARIO, Cliente.Aviso AS CAVISO, Cliente.Info AS CINFO, CASE WHEN len(ltrim(rtrim(Cliente.Aviso))) 
                                                   > 1 THEN 'A' ELSE '' END AS CAVISODES, CASE WHEN len(ltrim(rtrim(Cliente.Archivo))) > 0 AND len(ltrim(rtrim(Cliente.IDFotos))) 
                                                   > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) + ' (' + COALESCE (Cliente.Archivo, '') + ')' WHEN len(ltrim(rtrim(Cliente.Archivo))) = 0 AND 
                                                   len(ltrim(rtrim(Cliente.IDFotos))) > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) ELSE '' END AS CINFODES, 
                                                   CASE WHEN TipoCita.Resaltar = 1 THEN COALESCE (TipoCita.Descripcion, '') ELSE '' END AS CRESAL, cita.FechaVal AS CFechaVal, cita.HoraVal as CHoraVal
                            FROM             (Doctor RIGHT JOIN
                                                   (TipoCita RIGHT JOIN
                                                   (Cliente RIGHT JOIN
                                                   (Cita LEFT JOIN
                                                   Usuario ON Cita.Responsable = Usuario.Id) ON Cliente.Cliente = Cita.Cliente) ON TipoCita.TipoCita = Cita.TipoCita) ON Doctor.Doctor = Cita.Doctor) 
                            WHERE      Cita.FechaVal=@ValFecha and Cita.Area=@Area and Cita.Sillon = 'C'
		) AS C ON  Horario.Area = C.CAREA AND Horario.HoraVal = C.CHORAVAL AND Horario.FechaVal = C.CfechaVal
	LEFT OUTER JOIN
                          (SELECT     Cita.Fecha AS DFECHA, Cita.Hora AS DHORA, Cita.Area AS DAREA, Cita.Sillon AS DSILLON, Cita.Cliente AS DCLIENTE, Cita.Doctor AS DDOCTOR, 
                                                   Cita.Cumplida AS DCUMPLIDA, Cita.Bloqueada AS DBLOQUEADA, Cliente.Nombre AS DCLIENTEDES, Cliente.Telefono AS DCLIENTETEL, 
                                                   CASE WHEN Cita.Bloqueada = 1 THEN '(HORA BLOQUEADA)' ELSE COALESCE (TipoCita.Descripcion, '') END AS DTIPOCITADES, 
                                                   Usuario.Nombre AS DUSER, Doctor.Nombre AS DDOCTORDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqDes, '(HORA BLOQUEADA)') 
                                                   ELSE Cliente.Nombre END AS DDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqTel, '') ELSE Cliente.Telefono END AS DTEL, 
                                                   CASE WHEN Cita.Cumplida = 0 THEN 'NO ASISTIO' WHEN cita.Cumplida = 5 THEN 'CANCELO' ELSE '' END AS DASIST, 
                                                   Usuario.TipoUsuario AS DTIPOUSUARIO, Cliente.Aviso AS DAVISO, Cliente.Info AS DINFO, CASE WHEN len(ltrim(rtrim(Cliente.Aviso))) 
                                                   > 1 THEN 'A' ELSE '' END AS DAVISODES, CASE WHEN len(ltrim(rtrim(Cliente.Archivo))) > 0 AND len(ltrim(rtrim(Cliente.IDFotos))) 
                                                   > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) + ' (' + COALESCE (Cliente.Archivo, '') + ')' WHEN len(ltrim(rtrim(Cliente.Archivo))) = 0 AND 
                                                   len(ltrim(rtrim(Cliente.IDFotos))) > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) ELSE '' END AS DINFODES, 
                                                   CASE WHEN TipoCita.Resaltar = 1 THEN COALESCE (TipoCita.Descripcion, '') ELSE '' END AS DRESAL, cita.FechaVal AS DFechaVal, cita.HoraVal as DHoraVal
                            FROM             (Doctor RIGHT JOIN
                                                   (TipoCita RIGHT JOIN
                                                   (Cliente RIGHT JOIN
                                                   (Cita LEFT JOIN
                                                   Usuario ON Cita.Responsable = Usuario.Id) ON Cliente.Cliente = Cita.Cliente) ON TipoCita.TipoCita = Cita.TipoCita) ON Doctor.Doctor = Cita.Doctor) 
                            WHERE      Cita.FechaVal=@ValFecha and Cita.Area=@Area and Cita.Sillon = 'D'
		) AS D ON  Horario.Area = D.DAREA AND Horario.HoraVal = D.DHORAVAL AND Horario.FechaVal = D.DfechaVal
	LEFT OUTER JOIN
                          (SELECT     Cita.Fecha AS EFECHA, Cita.Hora AS EHORA, Cita.Area AS EAREA, Cita.Sillon AS ESILLON, Cita.Cliente AS ECLIENTE, Cita.Doctor AS EDOCTOR, 
                                                   Cita.Cumplida AS ECUMPLIDA, Cita.Bloqueada AS EBLOQUEADA, Cliente.Nombre AS ECLIENTEDES, Cliente.Telefono AS ECLIENTETEL, 
                                                   CASE WHEN Cita.Bloqueada = 1 THEN '(HORA BLOQUEADA)' ELSE COALESCE (TipoCita.Descripcion, '') END AS ETIPOCITADES, 
                                                   Usuario.Nombre AS EUSER, Doctor.Nombre AS EDOCTORDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqDes, '(HORA BLOQUEADA)') 
                                                   ELSE Cliente.Nombre END AS EDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqTel, '') ELSE Cliente.Telefono END AS ETEL, 
                                                   CASE WHEN Cita.Cumplida = 0 THEN 'NO ASISTIO' WHEN cita.Cumplida = 5 THEN 'CANCELO' ELSE '' END AS EASIST, 
                                                   Usuario.TipoUsuario AS ETIPOUSUARIO, Cliente.Aviso AS EAVISO, Cliente.Info AS EINFO, CASE WHEN len(ltrim(rtrim(Cliente.Aviso))) 
                                                   > 1 THEN 'A' ELSE '' END AS EAVISODES, CASE WHEN len(ltrim(rtrim(Cliente.Archivo))) > 0 AND len(ltrim(rtrim(Cliente.IDFotos))) 
                                                   > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) + ' (' + COALESCE (Cliente.Archivo, '') + ')' WHEN len(ltrim(rtrim(Cliente.Archivo))) = 0 AND 
                                                   len(ltrim(rtrim(Cliente.IDFotos))) > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) ELSE '' END AS EINFODES, 
                                                   CASE WHEN TipoCita.Resaltar = 1 THEN COALESCE (TipoCita.Descripcion, '') ELSE '' END AS ERESAL, cita.FechaVal AS EFechaVal, cita.HoraVal as EHoraVal
                            FROM             (Doctor RIGHT JOIN
                                                   (TipoCita RIGHT JOIN
                                                   (Cliente RIGHT JOIN
                                                   (Cita LEFT JOIN
                                                   Usuario ON Cita.Responsable = Usuario.Id) ON Cliente.Cliente = Cita.Cliente) ON TipoCita.TipoCita = Cita.TipoCita) ON Doctor.Doctor = Cita.Doctor) 
                            WHERE      Cita.FechaVal=@ValFecha and Cita.Area=@Area and Cita.Sillon = 'E'
		) AS E ON  Horario.Area = E.EAREA AND Horario.HoraVal = E.EHORAVAL AND Horario.FechaVal = E.EfechaVal
	LEFT OUTER JOIN
                          (SELECT     Cita.Fecha AS FFECHA, Cita.Hora AS FHORA, Cita.Area AS FAREA, Cita.Sillon AS FSILLON, Cita.Cliente AS FCLIENTE, Cita.Doctor AS FDOCTOR, 
                                                   Cita.Cumplida AS FCUMPLIDA, Cita.Bloqueada AS FBLOQUEADA, Cliente.Nombre AS FCLIENTEDES, Cliente.Telefono AS FCLIENTETEL, 
                                                   CASE WHEN Cita.Bloqueada = 1 THEN '(HORA BLOQUEADA)' ELSE COALESCE (TipoCita.Descripcion, '') END AS FTIPOCITADES, 
                                                   Usuario.Nombre AS FUSER, Doctor.Nombre AS FDOCTORDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqDes, '(HORA BLOQUEADA)') 
                                                   ELSE Cliente.Nombre END AS FDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqTel, '') ELSE Cliente.Telefono END AS FTEL, 
                                                   CASE WHEN Cita.Cumplida = 0 THEN 'NO ASISTIO' WHEN cita.Cumplida = 5 THEN 'CANCELO' ELSE '' END AS FASIST, 
                                                   Usuario.TipoUsuario AS FTIPOUSUARIO, Cliente.Aviso AS FAVISO, Cliente.Info AS FINFO, CASE WHEN len(ltrim(rtrim(Cliente.Aviso))) 
                                                   > 1 THEN 'A' ELSE '' END AS FAVISODES, CASE WHEN len(ltrim(rtrim(Cliente.Archivo))) > 0 AND len(ltrim(rtrim(Cliente.IDFotos))) 
                                                   > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) + ' (' + COALESCE (Cliente.Archivo, '') + ')' WHEN len(ltrim(rtrim(Cliente.Archivo))) = 0 AND 
                                                   len(ltrim(rtrim(Cliente.IDFotos))) > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) ELSE '' END AS FINFODES, 
                                                   CASE WHEN TipoCita.Resaltar = 1 THEN COALESCE (TipoCita.Descripcion, '') ELSE '' END AS FRESAL, cita.FechaVal AS FFechaVal, cita.HoraVal as FHoraVal
                            FROM             (Doctor RIGHT JOIN
                                                   (TipoCita RIGHT JOIN
                                                   (Cliente RIGHT JOIN
                                                   (Cita LEFT JOIN
                                                   Usuario ON Cita.Responsable = Usuario.Id) ON Cliente.Cliente = Cita.Cliente) ON TipoCita.TipoCita = Cita.TipoCita) ON Doctor.Doctor = Cita.Doctor) 
                            WHERE      Cita.FechaVal=@ValFecha and Cita.Area=@Area and Cita.Sillon = 'F'
		) AS F ON  Horario.Area = F.FAREA AND Horario.HoraVal = F.FHORAVAL AND Horario.FechaVal = F.FfechaVal
	LEFT OUTER JOIN
                          (SELECT     Cita.Fecha AS GFECHA, Cita.Hora AS GHORA, Cita.Area AS GAREA, Cita.Sillon AS GSILLON, Cita.Cliente AS GCLIENTE, Cita.Doctor AS GDOCTOR, 
                                                   Cita.Cumplida AS GCUMPLIDA, Cita.Bloqueada AS GBLOQUEADA, Cliente.Nombre AS GCLIENTEDES, Cliente.Telefono AS GCLIENTETEL, 
                                                   CASE WHEN Cita.Bloqueada = 1 THEN '(HORA BLOQUEADA)' ELSE COALESCE (TipoCita.Descripcion, '') END AS GTIPOCITADES, 
                                                   Usuario.Nombre AS GUSER, Doctor.Nombre AS GDOCTORDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqDes, '(HORA BLOQUEADA)') 
                                                   ELSE Cliente.Nombre END AS GDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqTel, '') ELSE Cliente.Telefono END AS GTEL, 
                                                   CASE WHEN Cita.Cumplida = 0 THEN 'NO ASISTIO' WHEN cita.Cumplida = 5 THEN 'CANCELO' ELSE '' END AS GASIST, 
                                                   Usuario.TipoUsuario AS GTIPOUSUARIO, Cliente.Aviso AS GAVISO, Cliente.Info AS GINFO, CASE WHEN len(ltrim(rtrim(Cliente.Aviso))) 
                                                   > 1 THEN 'A' ELSE '' END AS GAVISODES, CASE WHEN len(ltrim(rtrim(Cliente.Archivo))) > 0 AND len(ltrim(rtrim(Cliente.IDFotos))) 
                                                   > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) + ' (' + COALESCE (Cliente.Archivo, '') + ')' WHEN len(ltrim(rtrim(Cliente.Archivo))) = 0 AND 
                                                   len(ltrim(rtrim(Cliente.IDFotos))) > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) ELSE '' END AS GINFODES, 
                                                   CASE WHEN TipoCita.Resaltar = 1 THEN COALESCE (TipoCita.Descripcion, '') ELSE '' END AS GRESAL, cita.FechaVal AS GFechaVal, cita.HoraVal as GHoraVal
                            FROM             (Doctor RIGHT JOIN
                                                   (TipoCita RIGHT JOIN
                                                   (Cliente RIGHT JOIN
                                                   (Cita LEFT JOIN
                                                   Usuario ON Cita.Responsable = Usuario.Id) ON Cliente.Cliente = Cita.Cliente) ON TipoCita.TipoCita = Cita.TipoCita) ON Doctor.Doctor = Cita.Doctor) 
                            WHERE      Cita.FechaVal=@ValFecha and Cita.Area=@Area and Cita.Sillon = 'G'
		) AS G ON  Horario.Area = G.GAREA AND Horario.HoraVal = G.GHORAVAL AND Horario.FechaVal = G.GfechaVal
	LEFT OUTER JOIN
                          (SELECT     Cita.Fecha AS HFECHA, Cita.Hora AS HHORA, Cita.Area AS HAREA, Cita.Sillon AS HSILLON, Cita.Cliente AS HCLIENTE, Cita.Doctor AS HDOCTOR, 
                                                   Cita.Cumplida AS HCUMPLIDA, Cita.Bloqueada AS HBLOQUEADA, Cliente.Nombre AS HCLIENTEDES, Cliente.Telefono AS HCLIENTETEL, 
                                                   CASE WHEN Cita.Bloqueada = 1 THEN '(HORA BLOQUEADA)' ELSE COALESCE (TipoCita.Descripcion, '') END AS HTIPOCITADES, 
                                                   Usuario.Nombre AS HUSER, Doctor.Nombre AS HDOCTORDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqDes, '(HORA BLOQUEADA)') 
                                                   ELSE Cliente.Nombre END AS HDES, CASE WHEN Cita.Bloqueada = 1 THEN COALESCE (cita.BloqTel, '') ELSE Cliente.Telefono END AS HTEL, 
                                                   CASE WHEN Cita.Cumplida = 0 THEN 'NO ASISTIO' WHEN cita.Cumplida = 5 THEN 'CANCELO' ELSE '' END AS HASIST, 
                                                   Usuario.TipoUsuario AS HTIPOUSUARIO, Cliente.Aviso AS HAVISO, Cliente.Info AS HINFO, CASE WHEN len(ltrim(rtrim(Cliente.Aviso))) 
                                                   > 1 THEN 'A' ELSE '' END AS HAVISODES, CASE WHEN len(ltrim(rtrim(Cliente.Archivo))) > 0 AND len(ltrim(rtrim(Cliente.IDFotos))) 
                                                   > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) + ' (' + COALESCE (Cliente.Archivo, '') + ')' WHEN len(ltrim(rtrim(Cliente.Archivo))) = 0 AND 
                                                   len(ltrim(rtrim(Cliente.IDFotos))) > 0 THEN 'ID ' + ltrim(str(COALESCE (Cliente.IDFotos, ''))) ELSE '' END AS HINFODES, 
                                                   CASE WHEN TipoCita.Resaltar = 1 THEN COALESCE (TipoCita.Descripcion, '') ELSE '' END AS HRESAL, cita.FechaVal AS HFechaVal, cita.HoraVal as HHoraVal
                            FROM             (Doctor RIGHT JOIN
                                                   (TipoCita RIGHT JOIN
                                                   (Cliente RIGHT JOIN
                                                   (Cita LEFT JOIN
                                                   Usuario ON Cita.Responsable = Usuario.Id) ON Cliente.Cliente = Cita.Cliente) ON TipoCita.TipoCita = Cita.TipoCita) ON Doctor.Doctor = Cita.Doctor) 
                            WHERE      Cita.FechaVal=@ValFecha and Cita.Area=@Area and Cita.Sillon = 'H'
		) AS H ON  Horario.Area = H.HAREA AND Horario.HoraVal = H.HHORAVAL AND Horario.FechaVal = H.HfechaVal
WHERE Horario.FechaVal=@ValFecha and Horario.Area=@Area
ORDER BY Horario.Hora 
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarCobro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarCobro]
@Buscar NVARCHAR(50)
AS
BEGIN
SET NOCOUNT ON
SELECT Cobro.*,TipoCobro.Descripcion AS TIPOCOBRODES, Doctor.Nombre AS DOCTORDES, 
Cobro.Descripcion AS CORRESPONDES, 
COALESCE(Banco.Nombre,'')+ CASE WHEN len(ltrim(rtrim(coalesce(NumCheque,''))))>0 then ' #'+coalesce(numcheque,'') END
+CASE WHEN coalesce(Cobro.NumFactura,0)>0 then ' (Fact. '+coalesce(FacturaSerie,'')+ltrim(str(NumFactura))+')' ELSE '' END AS REFCHEQUEDES, 
COALESCE([Efectivo],0)+COALESCE([Cheque],0) AS TOT, 
Cliente.Nombre AS CLIENTEDES, Usuario.Nombre AS RESP, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Cheque,0)  END AS VNINGRESO,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0.00  END AS VNINGRESOTARJ,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END AS LIQUIDO ,
CASE WHEN (Cobro.HoraVal>=50400) then 2 else 1 END AS MT, 
CASE WHEN (DATEPART(WEEKDAY,Cobro.Fecha)-1)=0 THEN 7 ELSE DATEPART(WEEKDAY,Cobro.Fecha)-1 END AS diasem, 
Doctor.Utilidad, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (coalesce(Doctor.Utilidad ,0)/100.00) AS BRUTOCLINICA,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (1-(coalesce(Doctor.Utilidad ,0)/100.00)) AS BRUTODOCTOR,
Banco.Nombre AS BANCODES, 
Cliente.Archivo,Banco.EsTarjeta,
CASE WHEN Banco.EsTarjeta<>0 then ([VisaNetReal]/1.12)*(Banco.ComisionTarjeta/100.00) Else 0 END as VNCOMISION,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS VNNETO,
CASE WHEN Banco.Grupo=1 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS VISANET,
CASE WHEN Banco.Grupo=2 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS CREDOMATIC,
CASE WHEN Banco.Grupo=3 then COALESCE(Cheque,0) ELSE 0 END AS BIONLINE,
CASE WHEN Banco.Grupo=0 then COALESCE(Cheque,0) ELSE 0 END AS SOLOCHEQUE,
CASE WHEN Banco.Grupo=1 then COALESCE(VisanetReal,0) ELSE 0 END AS VISANET2,
CASE WHEN Banco.Grupo=2 then COALESCE(VisanetReal,0) ELSE 0 END AS CREDOMATIC2,
Banco.Grupo,
Producto.Descripcion as ProductoDes
FROM Banco RIGHT JOIN (FaseTratamiento RIGHT JOIN (TipoCobro INNER JOIN (((Usuario RIGHT JOIN ((( Cobro LEFT JOIN Doctor ON Cobro.Doctor=Doctor.Doctor) LEFT JOIN Servicio ON Cobro.Servicio=Servicio.Servicio) LEFT JOIN Cliente ON Cobro.Cliente=Cliente.Cliente) ON Usuario.Id=Cobro.Responsable) LEFT JOIN Cargo ON Cobro.Cargo=Cargo.Cargo) LEFT JOIN Producto ON Cobro.Producto=Producto.Producto) ON TipoCobro.TipoCobro=Cobro.TipoCobro) ON FaseTratamiento.FaseTratamiento=Cobro.FaseTratamiento) ON Banco.Banco=Cobro.Banco
WHERE CLIENTE.NOMBRE LIKE '%'+replace(@Buscar,' ','%')+'%'
order by Cobro.Fecha desc
/**************************************************/
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarCobroActivo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BuscarCobroActivo]
@Buscar NVARCHAR(50)
AS
BEGIN
SET NOCOUNT ON
SELECT Cobro.*,TipoCobro.Descripcion AS TIPOCOBRODES, Doctor.Nombre AS DOCTORDES, 
Cobro.Descripcion AS CORRESPONDES, 
COALESCE(Banco.Nombre,'')+ CASE WHEN len(ltrim(rtrim(coalesce(NumCheque,''))))>0 then ' #'+coalesce(numcheque,'') END
+CASE WHEN coalesce(Cobro.NumFactura,0)>0 then ' (Fact. '+coalesce(FacturaSerie,'')+ltrim(str(NumFactura))+')' ELSE '' END AS REFCHEQUEDES, 
COALESCE([Efectivo],0)+COALESCE([Cheque],0) AS TOT, 
Cliente.Nombre AS CLIENTEDES, Usuario.Nombre AS RESP, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Cheque,0)  END AS VNINGRESO,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0.00  END AS VNINGRESOTARJ,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END AS LIQUIDO ,
CASE WHEN (Cobro.HoraVal>=50400) then 2 else 1 END AS MT, 
CASE WHEN (DATEPART(WEEKDAY,Cobro.Fecha)-1)=0 THEN 7 ELSE DATEPART(WEEKDAY,Cobro.Fecha)-1 END AS diasem, 
Doctor.Utilidad, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (coalesce(Doctor.Utilidad ,0)/100.00) AS BRUTOCLINICA,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (1-(coalesce(Doctor.Utilidad ,0)/100.00)) AS BRUTODOCTOR,
Banco.Nombre AS BANCODES, 
Cliente.Archivo,Banco.EsTarjeta,
CASE WHEN Banco.EsTarjeta<>0 then ([VisaNetReal]/1.12)*(Banco.ComisionTarjeta/100.00) Else 0 END as VNCOMISION,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS VNNETO,
CASE WHEN Banco.Grupo=1 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS VISANET,
CASE WHEN Banco.Grupo=2 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS CREDOMATIC,
CASE WHEN Banco.Grupo=3 then COALESCE(Cheque,0) ELSE 0 END AS BIONLINE,
CASE WHEN Banco.Grupo=0 then COALESCE(Cheque,0) ELSE 0 END AS SOLOCHEQUE,
CASE WHEN Banco.Grupo=1 then COALESCE(VisanetReal,0) ELSE 0 END AS VISANET2,
CASE WHEN Banco.Grupo=2 then COALESCE(VisanetReal,0) ELSE 0 END AS CREDOMATIC2,
Banco.Grupo,
Producto.Descripcion as ProductoDes
FROM Banco RIGHT JOIN (FaseTratamiento RIGHT JOIN (TipoCobro INNER JOIN (((Usuario RIGHT JOIN ((( Cobro LEFT JOIN Doctor ON Cobro.Doctor=Doctor.Doctor) LEFT JOIN Servicio ON Cobro.Servicio=Servicio.Servicio) LEFT JOIN Cliente ON Cobro.Cliente=Cliente.Cliente) ON Usuario.Id=Cobro.Responsable) LEFT JOIN Cargo ON Cobro.Cargo=Cargo.Cargo) LEFT JOIN Producto ON Cobro.Producto=Producto.Producto) ON TipoCobro.TipoCobro=Cobro.TipoCobro) ON FaseTratamiento.FaseTratamiento=Cobro.FaseTratamiento) ON Banco.Banco=Cobro.Banco
WHERE CLIENTE.NOMBRE LIKE '%'+replace(@Buscar,' ','%')+'%'
AND Cobro.Activo<>0
and Cobro.Ingresado<>0
and Cobro.Pendiente=0
order by Cobro.Fecha desc
/**************************************************/
END

GO
/****** Object:  StoredProcedure [dbo].[CheckSillones]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*** QUE SE BLOQUEE AUTOMATCAMENTE LA AGENDA DE LA TARDE EN LA FECHA INDICADA ****/
CREATE PROCEDURE [dbo].[CheckSillones]
@FechaVal int,
@Area Int
AS
BEGIN
SET NOCOUNT ON

INSERT INTO Cita (Fecha, Hora, AREA, Sillon, Bloqueada, BloqDes, BloqTel, Responsable)
SELECT [BLOQ ESP SUB].Fecha, [BLOQ ESP SUB].Hora, [BLOQ ESP SUB].Area, [BLOQ ESP SUB].Sillon, 1 , 'BLOQUEADA' , '.' , 0 
FROM (
		SELECT Horario.*, Sillon.Sillon
		FROM Sillon
		INNER JOIN Horario ON Sillon.Area = Horario.Area
		WHERE Sillon.Sillon>'F'
		AND Horario.HoraVal>46800
		AND Sillon.Area=@Area
		AND Horario.Area=@Area
		AND Horario.FechaVal=@FechaVal
)[BLOQ ESP SUB]
LEFT JOIN Cita ON ([BLOQ ESP SUB].Sillon = Cita.Sillon) AND ([BLOQ ESP SUB].Area = Cita.Area) AND ([BLOQ ESP SUB].HoraVal = Cita.HoraVal) AND ([BLOQ ESP SUB].FechaVal = Cita.FechaVal)
WHERE Cita.Fecha IS NULL
END
GO
/****** Object:  StoredProcedure [dbo].[dt_adduserobject]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Add an object to the dtproperties table
*/
create procedure [dbo].[dt_adduserobject]
as
	set nocount on
	/*
	** Create the user object if it does not exist already
	*/
	begin transaction
		insert dbo.dtproperties (property) VALUES ('DtgSchemaOBJECT')
		update dbo.dtproperties set objectid=@@identity 
			where id=@@identity and property='DtgSchemaOBJECT'
	commit
	return @@identity

GO
/****** Object:  StoredProcedure [dbo].[dt_droppropertiesbyid]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Drop one or all the associated properties of an object or an attribute 
**
**	dt_dropproperties objid, null or '' -- drop all properties of the object itself
**	dt_dropproperties objid, property -- drop the property
*/
create procedure [dbo].[dt_droppropertiesbyid]
	@id int,
	@property varchar(64)
as
	set nocount on

	if (@property is null) or (@property = '')
		delete from dbo.dtproperties where objectid=@id
	else
		delete from dbo.dtproperties 
			where objectid=@id and property=@property


GO
/****** Object:  StoredProcedure [dbo].[dt_dropuserobjectbyid]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Drop an object from the dbo.dtproperties table
*/
create procedure [dbo].[dt_dropuserobjectbyid]
	@id int
as
	set nocount on
	delete from dbo.dtproperties where objectid=@id

GO
/****** Object:  StoredProcedure [dbo].[dt_generateansiname]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
**	Generate an ansi name that is unique in the dtproperties.value column 
*/ 
create procedure [dbo].[dt_generateansiname](@name varchar(255) output) 
as 
	declare @prologue varchar(20) 
	declare @indexstring varchar(20) 
	declare @index integer 
 
	set @prologue = 'MSDT-A-' 
	set @index = 1 
 
	while 1 = 1 
	begin 
		set @indexstring = cast(@index as varchar(20)) 
		set @name = @prologue + @indexstring 
		if not exists (select value from dtproperties where value = @name) 
			break 
		 
		set @index = @index + 1 
 
		if (@index = 10000) 
			goto TooMany 
	end 
 
Leave: 
 
	return 
 
TooMany: 
 
	set @name = 'DIAGRAM' 
	goto Leave 

GO
/****** Object:  StoredProcedure [dbo].[dt_getobjwithprop]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Retrieve the owner object(s) of a given property
*/
create procedure [dbo].[dt_getobjwithprop]
	@property varchar(30),
	@value varchar(255)
as
	set nocount on

	if (@property is null) or (@property = '')
	begin
		raiserror('Must specify a property name.',-1,-1)
		return (1)
	end

	if (@value is null)
		select objectid id from dbo.dtproperties
			where property=@property

	else
		select objectid id from dbo.dtproperties
			where property=@property and value=@value

GO
/****** Object:  StoredProcedure [dbo].[dt_getobjwithprop_u]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Retrieve the owner object(s) of a given property
*/
create procedure [dbo].[dt_getobjwithprop_u]
	@property varchar(30),
	@uvalue nvarchar(255)
as
	set nocount on

	if (@property is null) or (@property = '')
	begin
		raiserror('Must specify a property name.',-1,-1)
		return (1)
	end

	if (@uvalue is null)
		select objectid id from dbo.dtproperties
			where property=@property

	else
		select objectid id from dbo.dtproperties
			where property=@property and uvalue=@uvalue

GO
/****** Object:  StoredProcedure [dbo].[dt_getpropertiesbyid]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Retrieve properties by id's
**
**	dt_getproperties objid, null or '' -- retrieve all properties of the object itself
**	dt_getproperties objid, property -- retrieve the property specified
*/
create procedure [dbo].[dt_getpropertiesbyid]
	@id int,
	@property varchar(64)
as
	set nocount on

	if (@property is null) or (@property = '')
		select property, version, value, lvalue
			from dbo.dtproperties
			where  @id=objectid
	else
		select property, version, value, lvalue
			from dbo.dtproperties
			where  @id=objectid and @property=property

GO
/****** Object:  StoredProcedure [dbo].[dt_getpropertiesbyid_u]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Retrieve properties by id's
**
**	dt_getproperties objid, null or '' -- retrieve all properties of the object itself
**	dt_getproperties objid, property -- retrieve the property specified
*/
create procedure [dbo].[dt_getpropertiesbyid_u]
	@id int,
	@property varchar(64)
as
	set nocount on

	if (@property is null) or (@property = '')
		select property, version, uvalue, lvalue
			from dbo.dtproperties
			where  @id=objectid
	else
		select property, version, uvalue, lvalue
			from dbo.dtproperties
			where  @id=objectid and @property=property

GO
/****** Object:  StoredProcedure [dbo].[dt_setpropertybyid]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	If the property already exists, reset the value; otherwise add property
**		id -- the id in sysobjects of the object
**		property -- the name of the property
**		value -- the text value of the property
**		lvalue -- the binary value of the property (image)
*/
create procedure [dbo].[dt_setpropertybyid]
	@id int,
	@property varchar(64),
	@value varchar(255),
	@lvalue image
as
	set nocount on
	declare @uvalue nvarchar(255) 
	set @uvalue = convert(nvarchar(255), @value) 
	if exists (select * from dbo.dtproperties 
			where objectid=@id and property=@property)
	begin
		--
		-- bump the version count for this row as we update it
		--
		update dbo.dtproperties set value=@value, uvalue=@uvalue, lvalue=@lvalue, version=version+1
			where objectid=@id and property=@property
	end
	else
	begin
		--
		-- version count is auto-set to 0 on initial insert
		--
		insert dbo.dtproperties (property, objectid, value, uvalue, lvalue)
			values (@property, @id, @value, @uvalue, @lvalue)
	end


GO
/****** Object:  StoredProcedure [dbo].[dt_setpropertybyid_u]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	If the property already exists, reset the value; otherwise add property
**		id -- the id in sysobjects of the object
**		property -- the name of the property
**		uvalue -- the text value of the property
**		lvalue -- the binary value of the property (image)
*/
create procedure [dbo].[dt_setpropertybyid_u]
	@id int,
	@property varchar(64),
	@uvalue nvarchar(255),
	@lvalue image
as
	set nocount on
	-- 
	-- If we are writing the name property, find the ansi equivalent. 
	-- If there is no lossless translation, generate an ansi name. 
	-- 
	declare @avalue varchar(255) 
	set @avalue = null 
	if (@uvalue is not null) 
	begin 
		if (convert(nvarchar(255), convert(varchar(255), @uvalue)) = @uvalue) 
		begin 
			set @avalue = convert(varchar(255), @uvalue) 
		end 
		else 
		begin 
			if 'DtgSchemaNAME' = @property 
			begin 
				exec dbo.dt_generateansiname @avalue output 
			end 
		end 
	end 
	if exists (select * from dbo.dtproperties 
			where objectid=@id and property=@property)
	begin
		--
		-- bump the version count for this row as we update it
		--
		update dbo.dtproperties set value=@avalue, uvalue=@uvalue, lvalue=@lvalue, version=version+1
			where objectid=@id and property=@property
	end
	else
	begin
		--
		-- version count is auto-set to 0 on initial insert
		--
		insert dbo.dtproperties (property, objectid, value, uvalue, lvalue)
			values (@property, @id, @avalue, @uvalue, @lvalue)
	end

GO
/****** Object:  StoredProcedure [dbo].[dt_verstamp006]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	This procedure returns the version number of the stored
**    procedures used by legacy versions of the Microsoft
**	Visual Database Tools.  Version is 7.0.00.
*/
create procedure [dbo].[dt_verstamp006]
as
	select 7000

GO
/****** Object:  StoredProcedure [dbo].[dt_verstamp007]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	This procedure returns the version number of the stored
**    procedures used by the the Microsoft Visual Database Tools.
**	Version is 7.0.05.
*/
create procedure [dbo].[dt_verstamp007]
as
	select 7005

GO
/****** Object:  StoredProcedure [dbo].[FillTerminalParametro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[FillTerminalParametro]
AS
BEGIN
SET NOCOUNT ON

/******* FILL TPARAMETRO ****/
insert into TerminalParametro(Terminal,TParametro,Valor)
select Terminal, TParametro, TParametro.ValorDef
From ConeccionChat,TParametro
Where Not Exists(
	Select *
	From TerminalParametro
	Where TerminalParametro.Terminal=ConeccionChat.Terminal 
	And TerminalParametro.TParametro=TParametro.TParametro 
)

END


GO
/****** Object:  StoredProcedure [dbo].[FillTipoUsuarioComando]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[FillTipoUsuarioComando] AS
BEGIN
SET NOCOUNT ON
insert into [tipousuario Comando](TipoUsuario,Comando)
select Tipousuario, Comando
From TipoUsuario,Comando
Where Not Exists(
select *
from [tipousuario Comando]
Where [tipousuario Comando].Tipousuario=Tipousuario.Tipousuario
and [tipousuario Comando].Comando=Comando.Comando
)
END
GO
/****** Object:  StoredProcedure [dbo].[FixChequeAnulado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** FixChequeAnulado *************/
CREATE PROCEDURE [dbo].[FixChequeAnulado] AS
BEGIN
SET NOCOUNT ON
UPDATE Cheque SET Cheque.Ingresado = 0, Cheque.Monto = 0
WHERE (Cheque.Ingresado<>0 AND Cheque.Anulado<>0)
OR (Cheque.Monto<>0 AND Cheque.Anulado<>0);

UPDATE Trabajo Set Cheque=NULL
From Trabajo
LEFT join Cheque on Trabajo.Cheque=Cheque.Cheque
Where Trabajo.Cheque is not null and Cheque.Cheque is null or Cheque.Ingresado=0 or Cheque.Activo=0;

END

GO
/****** Object:  StoredProcedure [dbo].[FixPorCitar]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FixPorCitar]
AS
BEGIN
SET NOCOUNT ON

UPDATE Cita SET Cumplida =1
WHERE Cita.GenVersion>=( (year(getdate())-2000)*(12*31*24*60*60)+month(getdate())*(31*24*60*60)+day(getdate())*(24*60*60)+datepart(hour,getdate())*(60*60)+datepart(minute,getdate())*60+datepart(second,getdate()) ) - (5*24*60*60)
And Cumplida=-1

UPDATE Cita 
SET Cita.Contactar = 0, Cita.Respuesta = 2
FROM Cita LEFT JOIN RespuestaCita ON Cita.Respuesta=RespuestaCita.RespuestaCita
WHERE Cita.Genversion>=( (year(getdate())-2000)*(12*31*24*60*60)+month(getdate())*(31*24*60*60)+day(getdate())*(24*60*60)+datepart(hour,getdate())*(60*60)+datepart(minute,getdate())*60+datepart(second,getdate()) ) - (5*24*60*60)
AND Cita.Contactar=1
AND abs(coalesce(Cita.Cumplida,0))<>1
AND (Cita.Respuesta Is Null OR coalesce([ContactarDespues],1)=1) 
AND EXISTS( 
Select * 
From Cita C2 
where C2.cliente=cita.cliente 
and c2.fechaVal>cita.fechaVal 
)

UPDATE Cita SET Cita.Respuesta = 3, Cita.ContactoPor = Null, Cita.FechaContacto = Null
FROM Cita LEFT JOIN RespuestaCita ON Cita.Respuesta=RespuestaCita.RespuestaCita 
WHERE Cita.Genversion>=( (year(getdate())-2000)*(12*31*24*60*60)+month(getdate())*(31*24*60*60)+day(getdate())*(24*60*60)+datepart(hour,getdate())*(60*60)+datepart(minute,getdate())*60+datepart(second,getdate()) ) - (5*24*60*60) 
AND Cita.Contactar=1  
AND abs(coalesce(Cita.Cumplida,0))<>1 
AND (Cita.Respuesta=1 OR Cita.Respuesta=2 OR Cita.Respuesta is NULL)  
AND NOT EXISTS(  
Select *  
From Cita C2  
where C2.cliente=cita.cliente  
and c2.fechaVal>cita.fechaVal  
)

UPDATE Cita SET Cita.FechaRecontactar = Cita.Fecha
WHERE Cita.GenVersion>=( (year(getdate())-2000)*(12*31*24*60*60)+month(getdate())*(31*24*60*60)+day(getdate())*(24*60*60)+datepart(hour,getdate())*(60*60)+datepart(minute,getdate())*60+datepart(second,getdate()) ) - (5*24*60*60)
AND Cita.FechaRecontactar Is Null

Update PorCitar Set PorCitar.FaltasSeguidas=FaltasSeguidas.FaltasSeguidas
From PorCitar 
inner join FaltasSeguidas on PorCitar.Cliente=FaltasSeguidas.Cliente
Where Coalesce(PorCitar.FaltasSeguidas,-1)<>FaltasSeguidas.FaltasSeguidas

END
GO
/****** Object:  StoredProcedure [dbo].[FixPorCitarFULL]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FixPorCitarFULL]
AS
BEGIN
SET NOCOUNT ON

UPDATE Cita SET Cumplida =1
Where Cumplida=-1

UPDATE Cita 
SET Cita.Contactar = 0, Cita.Respuesta = 2
FROM Cita LEFT JOIN RespuestaCita ON Cita.Respuesta=RespuestaCita.RespuestaCita
WHERE Cita.Contactar=1
AND abs(coalesce(Cita.Cumplida,0))<>1
AND (Cita.Respuesta Is Null OR coalesce([ContactarDespues],1)=1) 
AND EXISTS( 
Select * 
From Cita C2 
where C2.cliente=cita.cliente 
and c2.fechaVal>cita.fechaVal 
)

UPDATE Cita SET Cita.Respuesta = 3, Cita.ContactoPor = Null, Cita.FechaContacto = Null
FROM Cita LEFT JOIN RespuestaCita ON Cita.Respuesta=RespuestaCita.RespuestaCita 
WHERE Cita.Contactar=1  
AND abs(coalesce(Cita.Cumplida,0))<>1 
AND (Cita.Respuesta=1 OR Cita.Respuesta=2 OR Cita.Respuesta is NULL)  
AND NOT EXISTS(  
Select *  
From Cita C2  
where C2.cliente=cita.cliente  
and c2.fechaVal>cita.fechaVal  
)

UPDATE Cita SET Cita.FechaRecontactar = Cita.Fecha
WHERE Cita.FechaRecontactar Is Null



Update PorCitar Set PorCitar.FaltasSeguidas=FaltasSeguidas.FaltasSeguidas
From PorCitar 
inner join FaltasSeguidas on PorCitar.Cliente=FaltasSeguidas.Cliente
Where Coalesce(PorCitar.FaltasSeguidas,-1)<>FaltasSeguidas.FaltasSeguidas

END
GO
/****** Object:  StoredProcedure [dbo].[FixRevaluaciones]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FixRevaluaciones]
AS
BEGIN
SET NOCOUNT ON
UPDATE Revaluacion SET Revaluacion.TieneCita = 1
WHERE Revaluacion.TieneCita=0 
AND Exists (
SELECT Cita.Fecha
FROM Cita
where Cita.Cliente=Revaluacion.Cliente
AND month(Cita.Fecha)=Revaluacion.Mes
and YEAR(CITA.FECHA)=Revaluacion.Anyo
and cita.doctor=revaluacion.doctor
)

UPDATE Revaluacion SET Revaluacion.TieneCita = 0
WHERE Revaluacion.TieneCita=1 
AND NOT Exists (
SELECT Cita.Fecha
FROM Cita
where Cita.Cliente=Revaluacion.Cliente
AND month(Cita.Fecha)=Revaluacion.Mes
and YEAR(CITA.FECHA)=Revaluacion.Anyo
and cita.doctor=revaluacion.doctor
)
END
GO
/****** Object:  StoredProcedure [dbo].[GenCobrosAgenda]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/** **/



/****************** GEN COBROS AGENDA *******************/
CREATE PROCEDURE [dbo].[GenCobrosAgenda]
@FechaVal int,
@Area int,
@Terminal int AS
BEGIN
SET NOCOUNT ON

delete from tcobrosagenda where Terminal=@Terminal

INSERT INTO tCobrosAgenda ( Fecha, Hora, Area, Sillon, Terminal, Cliente, FechaVal, HoraVal, Des2, Cumplida )
SELECT Cita.Fecha, Cita.Hora, Cita.Area, Cita.Sillon, @Terminal , Cita.Cliente, FechaVal, HoraVal, 'NO', Cita.Cumplida
FROM Cita
WHERE Cita.FechaVal =@FechaVal AND Cita.Area=@Area and cita.Cliente is not null

UPDATE tCobrosAgenda Set Des1=CASE WHEN Cliente.RecargoInfo=1 THEN '+R' ELSE '-R' END,
Nombre=Cliente.Nombre
FROM Cliente INNER JOIN tCobrosAgenda ON Cliente.Cliente = tCobrosAgenda.Cliente
WHERE tCobrosAgenda.Terminal=@Terminal

UPDATE tCobrosAgenda Set tCobrosAgenda.Monto1=SUB.TOT, TipoTx=SUB.TIPODES
FROM tCobrosAgenda
INNER JOIN (
SELECT Cobro.Cliente, SUM(coalesce([Efectivo],0)+coalesce([Cheque],0)) AS TOT, MAX(CatalogoTratamiento.Descripcion) AS TIPODES
FROM (Cobro
LEFT JOIN Tratamiento ON Cobro.Tratamiento = Tratamiento.Tratamiento)
LEFT JOIN CatalogoTratamiento ON Tratamiento.CatalogoTratamiento = CatalogoTratamiento.CatalogoTratamiento
WHERE Cobro.Ingresado= 1 AND Cobro.Activo=1 AND Cobro.Pendiente=0 AND Cobro.FechaVal=@FechaVal AND Cobro.Area=@Area
GROUP BY Cobro.Cliente
) AS SUB ON (tCobrosAgenda.Cliente = SUB.Cliente)
WHERE tCobrosAgenda.Terminal=@Terminal

update tCobrosAgenda Set Des2='SI'
FROM tCobrosAgenda INNER JOIN PlantaCliente ON tCobrosAgenda.Cliente = PlantaCliente.Cliente
WHERE PlantaCliente.FechaVal >=(@FechaVal-3)
AND tCobrosAgenda.Terminal=@Terminal

update tCobrosAgenda Set Des3=CASE WHEN Cobro.Pendiente=1 THEN '-BK' ELSE '+BK' END
FROM tCobrosAgenda INNER JOIN (Cobro INNER JOIN Servicio ON Cobro.Servicio = Servicio.Servicio) ON (tCobrosAgenda.Cliente = Cobro.Cliente) AND (tCobrosAgenda.FechaVal = Cobro.FechaVal)
WHERE Cobro.FechaVal=@FechaVal AND Cobro.Activo=1 AND Cobro.Ingresado=1 AND Servicio.Brackets=1
AND tCobrosAgenda.Terminal=@Terminal

update tCobrosAgenda Set Des4='+C'
FROM tCobrosAgenda INNER JOIN Email ON tCobrosAgenda.Cliente = Email.Cliente
WHERE Email.FechaVal<@FechaVal And Email.FechaVal>=(@FechaVal-8) AND Email.Enviado=1 AND Email.Des='RECORDATORIO 8 DIAS'
AND tCobrosAgenda.Terminal=@Terminal


update tCobrosAgenda Set Des5=CASE WHEN Cobro.Pendiente=1 THEN '-K' WHEN (Cobro.Pendiente=0 and Cobro.FechaVal=@FechaVal) THEN '+K' WHEN (Cobro.Pendiente=0 and Cobro.FechaVal<>@FechaVal) then '' end
From tCobrosAgenda INNER JOIN
(Cobro INNER JOIN 
(SELECT Max(Cobro.Cobro) AS ULTCOBRO, MAX(tCobrosAgenda.Nombre ) AS CLIENTEDES
FROM Cobro inner join tCobrosAgenda on tCobrosAgenda.Cliente = Cobro.Cliente 
WHERE Cobro.Activo=1 AND Cobro.Ingresado=1 AND Cobro.TipoCobro=3 AND Cobro.Doctor=10000002 AND Cobro.Cargo=3
AND tCobrosAgenda.Terminal=@Terminal
GROUP BY Cobro.Cliente) as ULTRECARGO
on Cobro.Cobro=ULTRECARGO.ULTCOBRO
) on tCobrosAgenda.Cliente=Cobro.Cliente

update tCobrosAgenda Set Des=coalesce(Des1,'')+coalesce(Des3,'')+coalesce(Des4,'')+coalesce(Des5,'')

END
GO
/****** Object:  StoredProcedure [dbo].[HayM]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[HayM] @ValFecha int, @Area int AS 
BEGIN
SET NOCOUNT ON
SELECT Horario.Hora
FROM Horario
WHERE Horario.HoraVal<43200 AND Horario.FechaVal=@ValFecha AND Horario.Area=@Area
END
GO
/****** Object:  StoredProcedure [dbo].[HaymVacios]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[HaymVacios] @ValFecha int, @Area int, @ValHora INT AS 
BEGIN
SET NOCOUNT ON
                          SELECT     dbo.Horario.Hora, dbo.Sillon.Sillon
                           FROM         dbo.Sillon INNER JOIN
                                                  dbo.Horario ON dbo.Sillon.Area = dbo.Horario.Area LEFT OUTER JOIN
                                                  dbo.Cita ON dbo.Horario.Area = dbo.Cita.Area AND dbo.Horario.Hora = dbo.Cita.Hora AND dbo.Horario.Fecha = dbo.Cita.Fecha AND 
                                                  dbo.Sillon.Sillon = dbo.Cita.Sillon
                           WHERE     Horario.FechaVal = @ValFecha AND Horario.HoraVal < @ValHora AND Horario.Area = @Area
                           ORDER BY Horario.Hora 
END
GO
/****** Object:  StoredProcedure [dbo].[Mantenimiento]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Mantenimiento]
AS
BEGIN
SET NOCOUNT ON

/**** QUE NO SE QUEDEN TRABADAS LAS CITAS ****/
DELETE from cita 
where cita.lock=1
and cita.bloqueada=0
and (cita.cliente is null or cita.doctor is null or tipocita is null)
and datediff(minute,coalesce(cita.FechaTran,0),getdate())>5
/*********************************************/


/******** REVALUACION CONTROL RETENEDORES ********/
INSERT INTO Revaluacion ( Cliente, Mes, Anyo, Descripcion, Responsable, Doctor, TipoRevaluacion )
SELECT UCEA.Cliente, UCEA.MES, UCEA.ANYO, 'CONTROL DE RETENEDORES' , 0 , 1 , 0 
FROM (
		SELECT Cita.Cliente, MAX(Cita.Fecha) AS FECHA, 
		MONTH(DateAdd(month,12, MAX(cita.Fecha))) AS MES, 
		YEAR(DateAdd(month,12, MAX(cita.Fecha))) AS ANYO
		FROM TipoCita
		INNER JOIN Cita ON TipoCita.TipoCita = Cita.TipoCita
		WHERE abs(Cita.[Cumplida])=1 AND Cita.Bloqueada=0 AND TipoCita.EliminarAparato<>0 AND Cita.Fecha<DateAdd(day,-1, GETDATE()) AND Cita.Fecha>DateAdd(day,-7, getDATE())
		GROUP BY Cita.Cliente
) AS UCEA 
LEFT JOIN (
		SELECT Revaluacion,Cliente,Anyo,Mes
		FROM Revaluacion
		WHERE Revaluacion.Doctor=1
		AND Revaluacion.Activo<>0 AND Revaluacion.Anyo>=Year(getDate())
) AS REVALUACIONESAUTO ON (UCEA.Cliente = REVALUACIONESAUTO.Cliente) AND (UCEA.MES = REVALUACIONESAUTO.Mes) AND (UCEA.ANYO = REVALUACIONESAUTO.Anyo)
WHERE REVALUACIONESAUTO.Revaluacion Is Null
/*****************************************************************/


/******** FINALIZAR TX **********************/
UPDATE Tratamiento 
SET Tratamiento.Terminado = 1, 
Tratamiento.TerminadoFecha = GETDATE(), 
Tratamiento.TerminadoPor = 0
WHERE Tratamiento.Terminado=0 
AND Tratamiento.Cliente IN (
		SELECT Cita.Cliente
		FROM TipoCita INNER JOIN Cita ON TipoCita.TipoCita = Cita.TipoCita
		WHERE ABS([Cita].[Cumplida])=1 AND Cita.Bloqueada=0 AND TipoCita.EliminarAparato<>0 AND Cita.Fecha<DateAdd(DAY,-1,getDate()) And Cita.Fecha>DateAdd(day,-30,getDate())
		GROUP BY Cita.Cliente
)
AND Tratamiento.Activo<>0 AND Tratamiento.Bloqueado<>0
/*************************************************************/

/******** ACTUALIZAR TITULO SILLON NULL **********************/
Update Sillon Set Titulo='SILLON ' + Sillon.Sillon 
Where Sillon.Titulo is null
/*************************************************************/

/******** ACTUALIZAR TITULO SILLON NULL **********************/
update Cliente
Set TipoCliente=0
Where TipoCliente is null
/*************************************************************/

/******** ACTUALIZAR DURACION EN PLANTA CLIENTE **********************/
Update PlantaCliente
Set PlantaCliente.Min =Planta.Min,
PlantaCliente.Seg =Planta.Seg,
PlantaCliente.TotSeg =Planta.TotSeg,
PlantaCliente.TotMin =Planta.TotMin 
From PlantaCliente
INNER JOIN Planta on Planta.ID =PlantaCliente.Planta 
Where PlantaCliente.TotSeg =0
And Planta.TotSeg >0
/*************************************************************/

/******** PONER COLOR ROJO A TODAS LAS CITAS ORTO MENOS A CONTROL **********************/
Update TipoCita
Set Resaltar=1
From TipoCita
inner join Cita on Cita.TipoCita =TipoCita.TipoCita 
Where Cita.Area =1
And TipoCita.Descripcion not like '%CONTROL%'
And TipoCita.Resaltar =0
And Cita.FechaVal >1007533 /** DESDE 01-ENE-2015 ****/
/*************************************************************/



/******** FIX CHEQUE O EFECTIVO NULL **********************/
Update Cobro
Set Efectivo =0
Where Efectivo is null

Update Cobro
Set Cheque =0
Where Cheque is null
/*************************************************************/


/******* FILL TPARAMETRO ****/
insert into TerminalParametro(Terminal,TParametro,Valor)
select Terminal, TParametro, TParametro.ValorDef
From ConeccionChat,TParametro
Where Not Exists(
	Select *
	From TerminalParametro
	Where TerminalParametro.Terminal=ConeccionChat.Terminal 
	And TerminalParametro.TParametro=TParametro.TParametro 
)

/*** BORRAR REGISTRO DE TRANSACCIONES INNECESARIAS ***/
Delete
from Transaccion
Where Permiso like 'VER%'
OR Permiso = 'INGRESAR_CITA'

END

GO
/****** Object:  StoredProcedure [dbo].[SetParamCliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************/


/****************** SetParamCliente *******************/
CREATE PROCEDURE [dbo].[SetParamCliente]
@Cliente int,
@Terminal int AS
BEGIN
SET NOCOUNT ON

declare @VersionActual int 
select @VersionActual=(year(getdate())-2000)*(12*31*24*60*60)+month(getdate())*(31*24*60*60)+day(getdate())*(24*60*60)+datepart(hour,getdate())*(60*60)+datepart(minute,getdate())*60+datepart(second,getdate())

update param set Cliente=null
where (@VersionActual-coalesce(GenVersion,0)>300) AND Terminal<>@Terminal

update param set GenVersion=@VersionActual, Cliente=@Cliente
where Terminal=@Terminal

END
GO
/****** Object:  StoredProcedure [dbo].[SetParamFecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****************** SetParamFecha *******************/
CREATE PROCEDURE [dbo].[SetParamFecha]
@FechaInicio int,
@FechaFin int,
@Terminal int AS
BEGIN
SET NOCOUNT ON

declare @VersionActual int 
select @VersionActual=(year(getdate())-2000)*(12*31*24*60*60)+month(getdate())*(31*24*60*60)+day(getdate())*(24*60*60)+datepart(hour,getdate())*(60*60)+datepart(minute,getdate())*60+datepart(second,getdate())

update param set GenVersion=@VersionActual, PFecha1=@FechaInicio, PFecha2=@FechaFin
where (@VersionActual-coalesce(GenVersion,0)>300) or Terminal=@Terminal

END
GO
/****** Object:  StoredProcedure [dbo].[sp_actualiza_asistencia]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_actualiza_asistencia]
    @i_corrPlanilla int
	,@i_corrEmpleado int
	,@i_dias_no_asistidos int
	,@i_categoria_planilla varchar(2)
	,@i_totalizar char(1) = 'S'
	,@o_descuento_inasistencia money=null output
	,@o_asistencia_base int=null output
AS
BEGIN
declare @w_error int
,@w_rowcount int
,@w_error_msg varchar(200)
,@w_asistencia int
,@w_corrPlanillaEmp int
,@w_sueldo_nominal money
,@w_asistencia_base int

	begin tran

	select @w_corrPlanillaEmp = correlativo
	from planilla_empleado
	where corrPlanilla = @i_corrPlanilla
	and corrEmpleado = @i_corrEmpleado

	if @w_corrPlanillaEmp is null
	begin
		select @w_error_msg = 'DETALLE DE PLANILLA NO ENCONTRADO'
		goto error
	end

	select @w_sueldo_nominal = sueldo_base
	from Empleado
	where Empleado = @i_corrEmpleado

	if @w_sueldo_nominal is null
	begin
		select @w_error_msg = 'EMPLEADO NO ENCONTRADO'
		goto error
	end

	if @i_categoria_planilla = 'SU'		   
	    select @w_asistencia_base = 15
	else
	    select @w_asistencia_base = 365

    select  @w_asistencia = @w_asistencia_base - @i_dias_no_asistidos
	select @o_descuento_inasistencia = round( @w_sueldo_nominal  * @i_dias_no_asistidos/@w_asistencia_base, 2)
	      

	update planilla_empleado
	set descuentoInasistencia = @o_descuento_inasistencia
	  ,asistencia = @w_asistencia
	where corrPlanilla = @i_corrPlanilla
	and corrEmpleado = @i_corrEmpleado

	select @w_error = @@error
		, @w_rowcount = @@rowcount

	if @w_error <> 0
	begin
		select @w_error_msg = 'ERROR AL ACTUALIZAR PLANILLA EMPLEADO'
		goto error
	end

	if @w_rowcount = 0
	begin
	    select @w_error_msg = 'NO SE ACTUALIZARON REGISTROS DE PLANILLA EMPLEADO'
		goto error
	end

	select @o_asistencia_base = @w_asistencia_base

	if @i_totalizar = 'S'
	begin
		exec sp_actualiza_totales_planilla
			@i_corrplanilla = @i_corrPlanilla
		   ,@i_corrEmpleado = @i_corrEmpleado
		select @w_error = @@error
		if @w_error > 0
		begin
			select @w_error_msg = 'ERROR AL ACTUALIZAR PLANILLA'
			goto error
		end
	end

	commit tran
	return 0

error:
    rollback tran
    RAISERROR (@w_error_msg,10,1)
	return -1
END

GO
/****** Object:  StoredProcedure [dbo].[sp_actualiza_totales_planilla]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_actualiza_totales_planilla]
@i_corrplanilla int
,@i_corrEmpleado int=null
,@i_aplicacion_general char(1)='S'
AS
BEGIN
declare @w_monto_total money
, @w_registros int
, @w_bonificacion_total money
, @w_descuento_total money
,@w_comision_total money
,@w_sueldo_total money
,@w_hora_extra_total money
,@w_igss_total money
,@w_error int
,@w_error_msg varchar(200)
,@w_rowcount int
,@w_bloqueada char(1)
,@w_igss_empleado money
,@w_descuento_inasistencia money

select @w_bloqueada = bloqueada
from planilla_total
where correlativo = @i_corrplanilla

if @w_bloqueada = 'S'
begin
    raiserror ('PLANILLA SE ENCUENTRA BLOQUEADA', 15, 1)
	return -1
end

if @i_corrEmpleado is not null
begin
    select @w_igss_empleado = igss
	, @w_bonificacion_total = bonificacion
	,@w_sueldo_total = sueldoBase
	, @w_descuento_inasistencia =descuentoInasistencia
	from planilla_empleado
	where corrPlanilla = @i_corrplanilla
	and corrEmpleado = @i_corrEmpleado

	select @w_comision_total = sum(isnull(pr.montoTotal,0.00)) 
	from planilla_empleado_rubro pr
	inner join planilla_empleado em on (em.correlativo = pr.corrPlanillaEmp)
	where em.corrPlanilla = @i_corrplanilla
	and em.corrEmpleado = @i_corrEmpleado
	and pr.rubro = 'COMISION'	

	select @w_hora_extra_total = sum(isnull(pr.montoTotal, 0.00))
	from planilla_empleado_rubro pr
	inner join planilla_empleado em on (em.correlativo = pr.corrPlanillaEmp)
	where em.corrPlanilla = @i_corrplanilla
	and em.corrEmpleado = @i_corrEmpleado
	and pr.rubro = 'HORA_EXTRA'

	select @w_descuento_total = sum(isnull(pr.montoTotal, 0.00))
	from planilla_empleado_rubro pr
	inner join planilla_empleado em on (em.correlativo = pr.corrPlanillaEmp)
	where em.corrPlanilla = @i_corrplanilla
	and em.corrEmpleado = @i_corrEmpleado
	and pr.rubro = 'DESCUENTO'

	select @w_monto_total = isnull(@w_sueldo_total,0.00) 
		+ isnull(@w_bonificacion_total, 0.00) 
		+ isnull(@w_hora_extra_total, 0.00)
		+ isnull(@w_comision_total,0.00) 
		- isnull(@w_descuento_total, 0.00)
		- isnull(@w_igss_empleado, 0.00)
		- isnull(@w_descuento_inasistencia, 0.00)

	update planilla_empleado
	set montoTotal = @w_monto_total 
		,comision = isnull(@w_comision_total,0.00)		
		,descuento = isnull(@w_descuento_total,0.00)
		,hora_extra = isnull(@w_hora_extra_total, 0.00)
	where corrPlanilla = @i_corrplanilla
	and corrEmpleado = @i_corrEmpleado


	select @w_error = @@error
	     , @w_rowcount = @@ROWCOUNT

    if @w_error <> 0
	begin
	   select @w_error_msg = 'ERROR AL TOTALIZAR REGISTROS (' + convert(varchar, @w_error ) + ')'
	   goto error
	end

	if @w_rowcount <> 1
	begin
	   select @w_error_msg = 'SE ACTUALIZARON (' + convert(varchar, @w_rowcount ) + ') REGISTROS DE LA PLANILLA'
	   goto error
	end
	
end

if @i_aplicacion_general = 'S'
begin
	select @w_registros = count(corrEmpleado) 
	from planilla_empleado
	where corrPlanilla = @i_corrplanilla

	select @w_comision_total = sum(isnull(comision,0.00))
	from planilla_empleado
	where corrPlanilla = @i_corrplanilla


	select @w_bonificacion_total = sum(isnull(bonificacion, 0.00))
	from planilla_empleado
	where corrPlanilla = @i_corrplanilla


	select @w_sueldo_total = sum(isnull(sueldoBase, 0.00))
	from planilla_empleado
	where corrPlanilla = @i_corrplanilla

	select @w_hora_extra_total = sum(isnull(hora_extra, 0.00))
	from planilla_empleado
	where corrPlanilla = @i_corrplanilla

	select @w_descuento_total = sum(isnull(descuento, 0.00))
	from planilla_empleado
	where corrPlanilla = @i_corrplanilla

	select @w_igss_total = sum(isnull(igss,0.00))
	from planilla_empleado
	where corrPlanilla = @i_corrplanilla
	
	select @w_monto_total = sum(isnull(montoTotal, 0.00))
	from planilla_empleado
	where corrPlanilla = @i_corrplanilla

	if @w_monto_total is null or @w_monto_total <= 0
	begin
		select @w_error_msg = 'MONTO TOTAL NO PUEDE SER NULO O MENOR A CERO - planilla (' + CONVERT(varchar, @i_corrplanilla) + ')'
		goto error
	end

	update planilla_total
	set montoTotal = @w_monto_total
		,comisionTotal = isnull(@w_comision_total, 0.00)
		,bonosTotal = isnull(@w_bonificacion_total, 0.00)
		,descuentoTotal = isnull(@w_descuento_total, 0.00)
		,horasExtraTotal = isnull(@w_hora_extra_total, 0.00)
		,igssTotal = isnull(@w_igss_total, 0.00)
		,registros	= @w_registros
	where correlativo = @i_corrplanilla
	and bloqueada = 'N'
	and enviado = 'N'

	select @w_error = @@error
		 , @w_rowcount = @@ROWCOUNT

	if @w_error <> 0
	begin
	   select @w_error_msg = 'ERROR AL TOTALIZAR REGISTROS (' + convert(varchar, @w_error ) + ')'
	   goto error
	end

	if @w_rowcount <> 1
	begin
	   select @w_error_msg = 'SE ACTUALIZARON (' + convert(varchar, @w_rowcount ) + ') REGISTROS DE LA PLANILLA'
	   goto error
	end
end
	
	return 0
error:
    RAISERROR (@w_error_msg,15,1)
	return -1  
END


GO
/****** Object:  StoredProcedure [dbo].[sp_asignar_noEnvio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_asignar_noEnvio]
	@i_corrPlanilla int
	,@o_numEnvio varchar(5)=null output
AS
BEGIN
declare @w_planilla_pendiente int
    ,@w_error_msg varchar(200)
	,@w_error int
	,@w_rowcount int
	,@w_noEnvioActual varchar(5)
	,@w_autorizada char(1)
	,@w_bloqueada char(1)
	,@w_enviada char(1)

   select @w_autorizada = autorizada
     , @w_bloqueada = bloqueada
	 , @w_enviada = enviado
   from planilla_total
   where correlativo = @i_corrPlanilla
   
   if @w_autorizada <> 'S'  or @w_bloqueada <> 'S'
   begin
       select @w_error_msg = 'PLANILLA DEBE ENCONTRARSE AUTORIZADA Y BLOQUEADA'
	   goto error
   end

   if @w_enviada = 'S'
   begin
	   select @w_error_msg = 'PLANILLA YA HA SIDO ENVIADA'
	   goto error
   end


--validar que no exista otra planilla autorizada y bloqueada
--pendiente de envio.
    select @w_planilla_pendiente = correlativo
    from planilla_total
	where enviado = 'N'
	and autorizada = 'S'
	and bloqueada = 'S'	
	and correlativo <> @i_corrPlanilla
	and numeroEnvio is not null

	if @w_planilla_pendiente is not null
	begin
		select @w_error_msg = 'PLANILLA (' + convert(varchar, @w_planilla_pendiente) + ') SE ENCUENTRA PENDIENTE DE ENVIO.'
		goto error
	end

	select @o_numEnvio = bacEnvio
	from _GRAL
	where GRAL = 1

	--validar que el numero no haya sido utilizado antes.
	if exists(select 1 from planilla_total
	where numeroEnvio = @o_numEnvio
	and enviado = 'S')
	begin
		select @w_error_msg = 'NUMERO DE ENVIO (' + @o_numEnvio + ') YA HA SIDO UTILIZADO'
		goto error
	end

	update planilla_total
	set numeroEnvio = @o_numenvio
	where correlativo = @i_corrPlanilla

	select @w_error = @@error
	      ,@w_rowcount = @@rowcount

    if @w_error <> 0
	begin
		select @w_error_msg = 'NO SE PUDO ACTUALIZAR REGISTRO'
		goto error
	end

	if @w_rowcount = 0
	begin
		select @w_error_msg = 'NO SE ACTUALIZO NINGUN REGISTRO'
		goto error
	end

	return 0

error:
    
    RAISERROR (@w_error_msg,15,1)
	return -1
END

GO
/****** Object:  StoredProcedure [dbo].[sp_calcula_descripcion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_calcula_descripcion]
   @i_corrPlanilla int
   ,@i_rubro varchar(5)
   ,@i_fecha_planilla datetime
   ,@o_descripcion varchar(200)=null output
AS
BEGIN
declare @w_error_msg varchar(200)	
	 ,@w_dia int
	 ,@w_mes int
	 ,@w_anio int
	
	--calcular la descripcion de una planilla.

	if @i_rubro = 'SU'
	begin
	    select @w_dia = DATEPART(day, @i_fecha_planilla)
		if @w_dia < 16 --primera quincena			
		   select @i_rubro = 'SU-Q1'
		else
		   select @i_rubro = 'SU-Q2' 
	end

	select @o_descripcion = descripcion
	from planilla_rubro_descripcion
	where rubro = @i_rubro

	if @o_descripcion is null
	begin
		select @w_error_msg = 'DESCRIPCION NO ENCONTRADA PARA LA CATEGORIA (' + @i_rubro + ')'
		goto error
	end

	select @w_mes = DATEPART(month, @i_fecha_planilla)
	select @o_descripcion = @o_descripcion + ' '
		+ case @w_mes
		when 1 then 'ENERO'
		when 2 then 'FEBRERO'
		when 3 then 'MARZO'
		when 4 then 'ABRIL'
		when 5 then 'MAYO'
		when 6 then 'JUNIO'
		when 7 then 'JULIO'
		when 8 then 'AGOSTO'
		when 9 then 'SEPTIEMBRE'
		when 10 then 'OCTUBRE'
		when 11 then 'NOVIEMBRE'
		when 12 then 'DICIEMBRE'
		END


	select @w_anio = DATEPART(year, @i_fecha_planilla)

	select @o_descripcion = @o_descripcion + ' ' + convert(varchar, @w_anio)

	return 0

error:
    RAISERROR (@w_error_msg,-1,-1)
	return -1   
END


GO
/****** Object:  StoredProcedure [dbo].[sp_cambio_estado_planilla]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_cambio_estado_planilla]
	@i_corrPlanilla int
	,@i_usuario varchar(20)
	,@i_operacion varchar(20)
	,@o_secEnvio_nuevo int=null output
AS
BEGIN
declare @w_enviada char(1)
	, @w_autorizada char(1)
	, @w_bloqueada char(1)
	, @w_error_msg varchar(200)
	, @w_error int
	, @w_rowcount int
	, @w_tipo_usuario varchar(30)
	, @w_noEnvio varchar(10)
	, @w_retorno int
	begin tran

	select @w_tipo_usuario = tp.Descripcion
	from TipoUsuario tp
	inner join login l on (l.tipoUsuario = tp.TipoUsuario)
	where l.login = @i_usuario

	if @w_tipo_usuario is null
	begin
		select @w_error_msg = 'USUARIO NO EXISTE O NO TIENE ASIGNADO UN TIPO'
		goto error
	end

	if not exists(select 1 from planilla_total where correlativo = @i_corrPlanilla)
	begin
		select @w_error_msg = 'PLANILLA NO EXISTE'
		goto error
	end

	select @w_enviada = pt.enviado
	, @w_autorizada = pt.autorizada
	, @w_bloqueada = pt.bloqueada
	from planilla_total pt
	where pt.correlativo = @i_corrPlanilla

	if @i_operacion = 'BLQ' --bloquear
	begin
		if @w_bloqueada = 'S'
		begin
			select @w_error_msg = 'PLANILLA YA SE ENCUENTRA BLOQUEADA'
			goto error
		end

		if @w_enviada = 'S' or @w_autorizada = 'S'
		begin
			select @w_error_msg = 'PLANILLA YA HA SIDO ENVIADA O AUTORIZADA.'
			goto error
		end

		update planilla_total
		set bloqueada = 'S'
		where correlativo = @i_corrPlanilla

		select @w_error = @@error
		     ,@w_rowcount = @@rowcount
	end

	if @i_operacion = 'DBLQ' --desbloquear
	begin
	    if @w_enviada = 'S'
		begin
			select @w_error_msg = 'PLANILLA YA HA SIDO ENVIADA, ESTADO NO SE PUEDE CAMBIAR'
			goto error
		end

		if @w_bloqueada = 'N'
		begin
			select @w_error_msg = 'PLANILLA YA ESTA DESBLOQUEADA'
			goto error
		end

		if @w_autorizada = 'S'
		begin
			select @w_error_msg = 'PLANILLA SE ENCUENTRA AUTORIZADA'
			goto error
		end

		update planilla_total
		set bloqueada = 'N'
		where correlativo = @i_corrPlanilla

		select @w_error = @@error
		     ,@w_rowcount = @@rowcount

		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL ACTUALIZAR REGISTRO'
			goto error
		end

		if @w_rowcount <> 1
		begin
			select @w_error_msg = 'SE ACTUALIZARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
			goto error
		end
	end

	if @i_operacion = 'AUT' --autorizar
	begin

	    if @w_enviada = 'S'
		begin
			select @w_error_msg = 'PLANILLA YA HA SIDO ENVIADA, ESTADO NO SE PUEDE CAMBIAR'
			goto error
		end

		if @w_bloqueada = 'N'
		begin
			select @w_error_msg = 'PLANILLA DEBE ESTAR BLOQUEADA'
			goto error
		end


		if @w_autorizada = 'S'
		begin
			select @w_error_msg = 'PLANILLA YA ESTA AUTORIZADA'
			goto error			
		end

		update planilla_total
		set autorizada = 'S'
		where correlativo = @i_corrPlanilla

		select @w_error = @@error
		     ,@w_rowcount = @@rowcount

		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL ACTUALIZAR REGISTRO'
			goto error
		end

		if @w_rowcount <> 1
		begin
			select @w_error_msg = 'SE ACTUALIZARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
			goto error
		end
	end

	if @i_operacion = 'DAUT' --desautorizar
	begin

	   if @w_enviada = 'S'
		begin
			select @w_error_msg = 'PLANILLA YA HA SIDO ENVIADA, ESTADO NO SE PUEDE CAMBIAR'
			goto error
		end

		if @w_bloqueada = 'N'
		begin
			select @w_error_msg = 'PLANILLA DEBE ESTAR BLOQUEADA'
			goto error
		end

		if @w_autorizada = 'N'
		begin
			select @w_error_msg = 'PLANILLA YA ESTA DESAUTORIZADA'
			goto error			
		end

		update planilla_total
		set autorizada = 'N'
		where correlativo = @i_corrPlanilla

		select @w_error = @@error
		     ,@w_rowcount = @@rowcount

		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL ACTUALIZAR REGISTRO'
			goto error
		end

		if @w_rowcount <> 1
		begin
			select @w_error_msg = 'SE ACTUALIZARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
			goto error
		end
	end

	if @i_operacion = 'ENV' --enviar
	begin
		if @w_autorizada <> 'S' and @w_bloqueada <> 'S'
		begin
			select @w_error_msg = 'PLANILLA DEBE ESTAR AUTORIZADA Y BLOQUEADA'
			goto error
		end

		if @w_enviada = 'S'
		begin
			select @w_error_msg = 'PLANILLA YA HA SIDO ENVIADA'
			goto error
		end

		select @w_noEnvio = numeroEnvio
		from planilla_total
		where correlativo = @i_corrPlanilla

		if @w_noEnvio is null
		begin
			select @w_error_msg = 'NUMERO DE ENVIO NO ASIGNADO'
			goto error
		end

		update planilla_total
		set enviado = 'S'
		where correlativo = @i_corrPlanilla

		select @w_error = @@error
		     ,@w_rowcount = @@rowcount

		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL ACTUALIZAR REGISTRO'
			goto error
		end

		if @w_rowcount <> 1
		begin
			select @w_error_msg = 'SE ACTUALIZARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
			goto error
		end

		exec @w_retorno = sp_crea_movimientos_pago
			@i_corrPlanilla = @i_corrPlanilla
			,@i_usuario = @i_usuario
		select @w_error = @@error
		if @w_retorno <> 0 or @w_error <> 0
		begin
		    select @w_error_msg = 'ERROR AL CREAR MOVIMIENTO DE PAGO'
			goto error
		end

	    update _GRAL
		set BacEnvio = BacEnvio +1
		where  GRAL=1

		select @w_error = @@error
		     ,@w_rowcount = @@rowcount

		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL ACTUALIZAR REGISTRO'
			goto error
		end

		if @w_rowcount <> 1
		begin
			select @w_error_msg = 'SE ACTUALIZARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
			goto error
		end

	    select @o_secEnvio_nuevo = BacEnvio
		from _GRAL
		where GRAL=1
	end


	commit tran
	return 0

error:
    rollback tran
    RAISERROR (@w_error_msg,15,1)
	return -1  
END


GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_cheque]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_consulta_cheque]
	@i_fecha1 datetime=null,
	@i_fecha2 datetime=null,
	@i_corrPlanilla int=0,
	@i_filas int=1000,
	@o_correlativo int=0 output
AS
BEGIN   
	if @i_fecha1 is not null and @i_fecha2 is not null
	begin
	    set rowcount 10000

		select cq.*, em.Nombre from Cheque cq		
		left join Empleado em on (cq.Proveedor = em.Proveedor)
		where cq.fecha between @i_fecha1 and @i_fecha2
		and cq.Cheque > @o_correlativo
		and cq.TipoCheque = 1

		return 0
	end
	if @i_corrPlanilla > 0
	begin
	    select cq.*, em.Nombre from Cheque cq
		inner join Empleado em on (cq.Proveedor = em.Proveedor)
		where cq.Planilla = @i_corrPlanilla
		return 0
	end
END

GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_control_asistencia]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_consulta_control_asistencia]    
	@i_corrEmpleado int
AS
BEGIN
	select * from control_asistencia
	where corrEmpleado = @i_corrEmpleado

END


GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_email]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_consulta_email]
@i_operacion char(2)=null
,@i_Email	int=null
,@i_pendientes char(1)=null
,@i_todos char(1)=null
,@i_fecha1 datetime=null
,@i_fecha2 datetime=null
,@i_filas int=100
,@i_ultimo_secuencial int=0 output
,@i_aplicaRowcount char(1)='S'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	if (@i_aplicaRowcount = 'S')
		set rowcount 100

	if @i_Email is not null and @i_Email > 0 ---busqueda puntual.
	begin
		select e.Email
				,e.Fecha
				,e.Hora
				,'TO'=e.[To]
				,e.Cc
				,e.Bcc
				,e.Asunto
				,e.Mensaje
				,e.Enviado
				,'EnviadoStr'=case e.Enviado
				when -1 then 'N'
				else  'S'
				end
				,e.FechaSent
				,e.HoraSent
				,e.Cliente
				,e.Des
				,e.CitaFecha
				,e.CitaHora
				,e.CitaArea
				,e.GenVersion
				,e.FechaVal
				,e.HoraVal 
				,e.mensajeError
				,e.intentos
		from Email e 
		where e.Email = @i_Email
		
		return 0
	end

	if @i_pendientes = 'S'	
	begin
		select e.Email
			,e.Fecha
			,e.Hora
			,'TO'=e.[To]
			,e.Cc
			,e.Bcc
			,e.Asunto
			,e.Mensaje
			,e.Enviado
			,'EnviadoStr'=case e.Enviado
				when -1 then 'N'
				else  'S'
				end
			,e.FechaSent
			,e.HoraSent
			,e.Cliente
			,e.Des
			,e.CitaFecha
			,e.CitaHora
			,e.CitaArea
			,e.GenVersion
			,e.FechaVal
			,e.HoraVal 
			,e.mensajeError
			,e.intentos
		from Email e
		where e.enviado = -1	
		and e.Email > @i_ultimo_secuencial	

		return 0
	end


	if @i_todos = 'S'
	begin
	    print 'MOSTRANDO TODOS'
		if @i_fecha1 is null
		begin
			raiserror('PRIMERA FECHA NO INGRESADA',15,1)
			return -1
		end

		if @i_fecha2 is null
		begin
			raiserror('SEGUNDA FECHA NO INGRESADA',15,1)
			return -1
		end

		select  e.Email
				,e.Fecha
				,e.Hora
				,'TO'=e.[To]
				,e.Cc
				,e.Bcc
				,e.Asunto
				,e.Mensaje
				,e.Enviado
				,'EnviadoStr'=case e.Enviado
				when -1 then 'N'
				else  'S'
				end
				,e.FechaSent
				,e.HoraSent
				,e.Cliente
				,e.Des
				,e.CitaFecha
				,e.CitaHora
				,e.CitaArea
				,e.GenVersion
				,e.FechaVal
				,e.HoraVal  
				,e.mensajeError
				,e.intentos
		from Email e
		where e.Fecha between @i_fecha1 and @i_fecha2
		and e.Email > @i_ultimo_secuencial

		return 0
	end

END



GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_empleado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_consulta_empleado]
@i_Operacion char(1) = null --P puntual L listado.
,@i_correlativo int
AS
BEGIN
	
	if @i_Operacion = 'P'
	begin
	   select Empleado	
			,Codigo	
			,Clave	
			,Nombre	
			,Direccion	
			,Telefono	
			,TipoEmpleado	
			,NoCuenta	
			,InicioLabores	
			,Activo	
			,Proveedor	
			,TipoPlanilla	
			,TieneIGSS	
			,GenVersion	
			,sueldo_base	
			,bonificacion_sueldo	
			,hora_extra_costo	
			,rowVersion	
			,aplicaIgss	
			,estado	
		from Empleado
		where Empleado = @i_correlativo
		and eliminado = 'N'
	
	end

	if @i_Operacion = 'L'
	begin
	   select Empleado	
			,Codigo	
			,Clave	
			,Nombre	
			,Direccion	
			,Telefono	
			,TipoEmpleado	
			,NoCuenta	
			,InicioLabores	
			,Activo	
			,Proveedor	
			,TipoPlanilla	
			,TieneIGSS	
			,GenVersion	
			,sueldo_base	
			,bonificacion_sueldo	
			,hora_extra_costo	
			,rowVersion	
			,aplicaIgss	
			,estado	
		from Empleado
		where eliminado = 'N'
	end


END


GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_factura_temp]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_consulta_factura_temp]
   @i_num_factura varchar(20)
   ,@i_serie_factura varchar(5)  
   ,@i_fecha1 datetime=null
   ,@i_fecha2 datetime=null
   ,@i_cliente int=null
   ,@i_operacion char(1) = 'P' -- P - PUNTUAL, D - detalle de factura   
AS
BEGIN
declare @w_correlativo_cobro int

	if @i_operacion = 'P'
	begin
	    select @w_correlativo_cobro = Cobro
		from Cobro
		where FacturaSerie = @i_serie_factura
		and NumFactura = @i_num_factura --? averiguar sobre este campo.

		if @w_correlativo_cobro is null
		begin
			RAISERROR ('FACTURA NO ENCONTRADA',15,1)
			return -1
		end

		select co.Cobro	--int
			,co.Fecha	
			,co.Tratamiento	--int
			,co.Monto	--float
			,co.TipoCobro	--int
			,co.TotalDebido	--float
			,co.Efectivo	--float
			,co.Cheque	--float
			,co.NumCheque	--nvarchar
			,co.Banco	--int
			,co.Pendiente	--smallint
			,co.FechaPendiente	--datetime
			,co.Doctor	--int
			,co.Facturado	--smallint
			,co.Activo	--smallint
			,co.Ingresado	--smallint
			,co.Cargo	--float
			,co.Producto	--int
			,co.Cantidad	--int
			,co.NumFactura	--int
			,co.FacturaSerie
			,co.VisaNetReal	--float
			, cli.Cliente	--int
			, cli.Nombre	--nvarchar
			, cli.Direccion	--nvarchar
			, cli.Telefono	--nvarchar
			, cli.Nit	--nvarchar
		from Cobro co
		inner join Cliente cli on (co.Cliente = cli.Cliente)
		where co.FacturaSerie = @i_serie_factura
		and co.NumFactura = @i_num_factura --? averiguar sobre este campo.

		--detalle de factura.
		select FacturaCliente	--int
			,Cobro	--int
			,Descripcion	--nvarchar
			,Monto	--float
		from FacturaCliente
		where Cobro = @w_correlativo_cobro

	end

	if @i_operacion = 'L'
	begin
		select co.Cobro	--int
			,co.Fecha	
			,co.Tratamiento	--int
			,co.Monto	--float
			,co.TipoCobro	--int
			,co.TotalDebido	--float
			,co.Efectivo	--float
			,co.Cheque	--float
			,co.NumCheque	--nvarchar
			,co.Banco	--int
			,co.Pendiente	--smallint
			,co.FechaPendiente	--datetime
			,co.Doctor	--int
			,co.Facturado	--smallint
			,co.Activo	--smallint
			,co.Ingresado	--smallint
			,co.Cargo	--float
			,co.Producto	--int
			,co.Cantidad	--int
			,co.NumFactura	--int
			,co.FacturaSerie
			,co.VisaNetReal	--float
			, cli.Cliente	--int
			, cli.Nombre	--nvarchar
			, cli.Direccion	--nvarchar
			, cli.Telefono	--nvarchar
			, cli.Nit	--nvarchar
		from Cobro co
		inner join Cliente cli on (co.Cliente = cli.Cliente)
		where co.Fecha between @i_fecha1 and @i_fecha2
	end
	
END

GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_login]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_consulta_login]
    @i_login varchar(30) = null
AS
BEGIN
    if @i_login is null
	begin
		select correlativo
			,login
			,passWord
			,tipoUsuario
			,activo
			,fechaUltAcceso
			,usuario_modifica
			,fecha_creacion
			,fecha_ult_mod
			,rowVersion
			,eliminado
			,restaurado
		from login
	end
	else
		select correlativo
			,login
			,passWord
			,tipoUsuario
			,activo
			,fechaUltAcceso
			,usuario_modifica
			,fecha_creacion
			,fecha_ult_mod
			,rowVersion
			,eliminado
			,restaurado
		from login
		where login = @i_login
END

GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_planilla]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_consulta_planilla]
    @i_operacion char(1)='C',  --P consulta puntual L listado  E detalle x empleado.
    @i_correlativo int=null,
	@i_fecha1 datetime=null,
	@i_fecha2 datetime=null,
    @i_enviadas char(1)=null,
	@i_bloqueadas char(1)=null,
	@i_autorizadas char(1)=null,
	@i_mostrarTodos char(1)=null,
	@i_categoria_planilla varchar(5)=null,
	@i_tipo_planilla int=null
AS
BEGIN

    if @i_operacion = 'U' --ultima planilla generada pendiente.
	begin
		select top 1 correlativo	
			,fecha_creacion	
			,usuario	
			,autorizada	
			,montoTotal	
			,registros	
			,descuentoTotal	
			,bonosTotal	
			,comisionTotal	
			,tipoPlanilla	
			,categoriaPlanilla
			,descripcion
			,igssTotal
		from planilla_total
		where enviado = 'N'
		and bloqueada = 'N'
	end

	if @i_operacion = 'P'
	begin
	    select pt.correlativo	
			,pt.fecha_creacion	
			,pt.usuario	
			,pt.autorizada	
			,pt.montoTotal	
			,pt.registros	
			,pt.descuentoTotal	
			,pt.bonosTotal	
			,pt.comisionTotal	
			,pt.tipoPlanilla
			,'descripcionTipo'=tp.Descripcion
			,pt.categoriaPlanilla	
			,pt.descripcion
			,pt.bloqueada
			,pt.enviado
			,pt.autorizada
			,pt.fecha_planilla
			,pt.numeroPlan
			,pt.numeroEnvio
			,pt.igssTotal
		from planilla_total pt
		inner join TipoPlanilla tp on (pt.tipoPlanilla = tp.TipoPlanilla)
		where pt.correlativo = @i_correlativo


		select pe.corrPlanilla
			,pe.corrEmpleado
			,e.Nombre
			,e.NoCuenta
			,pe.montoTotal
			,pe.descripcion
			,pe.fecha_creacion
			,pe.bonificacion
			,pe.sueldoBase
			,pe.descuento
			,pe.descuentoInasistencia
			,pe.comision
			,pe.hora_extra
			,pe.descripcion			
			,pe.igss
			,pe.asistencia
		from planilla_empleado pe
		inner join Empleado e on (e.Empleado = pe.corrEmpleado) 
		where pe.corrPlanilla = @i_correlativo
		order by e.Nombre
	end

	if @i_operacion = 'L'
	begin	    
		if @i_mostrarTodos = 'S'
		begin
			select pt.correlativo	
				,pt.fecha_creacion	
				,pt.usuario
				,pt.bloqueada	
				,pt.autorizada	
				,pt.enviado
				,pt.montoTotal	
				,pt.registros	
				,pt.descuentoTotal	
				,pt.bonosTotal	
				,pt.comisionTotal	
				,pt.tipoPlanilla	
				,tp.Descripcion
				,pt.categoriaPlanilla
				,pt.descripcion
				,pt.igssTotal
				,pt.fecha_planilla
			from planilla_total pt
			inner join TipoPlanilla tp on (pt.tipoPlanilla = tp.TipoPlanilla)
			where pt.eliminado = 'N'
			and (@i_fecha1 is null or @i_fecha1 is not null and pt.fecha_planilla >= @i_fecha1)
			and (@i_fecha2 is null or @i_fecha2 is not null and pt.fecha_planilla <= @i_fecha2)
			and tp.TipoPlanilla = @i_tipo_planilla
		end
		else
		begin
			select pt.correlativo	
				,pt.fecha_creacion	
				,pt.usuario	
				,pt.autorizada	
				,pt.montoTotal	
				,pt.registros	
				,pt.descuentoTotal	
				,pt.bonosTotal	
				,pt.comisionTotal	
				,pt.tipoPlanilla	
				,tp.Descripcion
				,pt.categoriaPlanilla
				,pt.descripcion
				,pt.igssTotal
				,pt.fecha_planilla
			from planilla_total pt
			inner join TipoPlanilla tp on (pt.tipoPlanilla = tp.TipoPlanilla)
			where pt.eliminado = 'N'
			and (@i_fecha1 is null or @i_fecha1 is not null and pt.fecha_planilla >= @i_fecha1)
			and (@i_fecha2 is null or @i_fecha2 is not null and pt.fecha_planilla <= @i_fecha2)
			and (@i_enviadas is null or @i_enviadas is not null and pt.enviado = @i_enviadas)
			and (@i_bloqueadas is null or @i_bloqueadas is not null and pt.bloqueada = @i_bloqueadas)
			and (@i_autorizadas is null or @i_autorizadas is not null and pt.autorizada = @i_autorizadas)
			and (@i_categoria_planilla is null or @i_categoria_planilla is not null and pt.categoriaPlanilla = @i_categoria_planilla)
			and (@i_tipo_planilla is null or  @i_tipo_planilla is not null and pt.tipoPlanilla = @i_tipo_planilla)
		end
	end

END
GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_planilla_detalle]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_consulta_planilla_detalle]
@i_corrPlanilla int
,@i_corrEmpleado int=null
,@i_rubro varchar(20)=null
,@o_monto_total money=null output
AS
BEGIN
    select *
	from planilla_empleado
	where correlativo = @i_corrPlanilla
	and eliminado = 'N'

	select pd.correlativo	--int
		,pd.corrPlanilla	--int
		,pd.corrEmpleado	--int
		,em.Nombre
		,pd.rubro	--varchar
		,pd.cantidad	--int
		,pd.costoUnitario	--money
		,pd.montoTotal	--money
		,pd.signo	--char
		,pd.rowVersion	--int
		,pd.eliminado	--char		
		,pd.descripcion
		,pd.asistencia
	from planilla_empleado_detalle pd
	inner join Empleado em on (pd.corrEmpleado = em.Empleado)
	where pd.corrPlanilla = @i_corrPlanilla
	and (@i_corrEmpleado is null or (@i_corrEmpleado is not null and pd.corrEmpleado = @i_corrEmpleado))
	and (@i_rubro is null or (@i_rubro is not null and pd.rubro = @i_rubro))
	and pd.eliminado = 'N'

	select @o_monto_total = ISNULL(sum(pd.montoTotal), 0.00)
	from planilla_empleado_detalle pd
	inner join Empleado em on (pd.corrEmpleado = em.Empleado)
	where pd.corrPlanilla = @i_corrPlanilla
	and (@i_corrEmpleado is null or (@i_corrEmpleado is not null and pd.corrEmpleado = @i_corrEmpleado))
	and (@i_rubro is null or (@i_rubro is not null and pd.rubro = @i_rubro))
	and pd.eliminado = 'N'
END


GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_planilla_empleado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_consulta_planilla_empleado]
@i_corrPlanilla int
,@i_corrEmpleado int=null
,@i_rubro varchar(10)=null
AS
BEGIN
    if @i_corrEmpleado = 0
	begin
	    select @i_corrEmpleado = null
	end

    select 
		pe.corrPlanilla
		,pt.tipoPlanilla
		,pt.categoriaPlanilla
		,pe.corrEmpleado
		,em.Nombre
		,em.InicioLabores
	    ,pe.montoTotal
		,pe.descripcion
		,pe.fecha_creacion
		,pe.bonificacion
		,pe.sueldoBase
		,pe.descuento
		,pe.comision
		,pe.hora_extra
		,pe.costo_hora_extra
		,pe.descripcion
		,pe.asistencia
		,pe.descuentoInasistencia
	from planilla_empleado pe
	inner join Empleado em on (em.Empleado = pe.corrEmpleado)
	inner join planilla_total pt on (pt.correlativo = pe.corrPlanilla)
	where pe.corrPlanilla = @i_corrPlanilla
	and (@i_corrEmpleado is null or @i_corrEmpleado is not null and pe.corrEmpleado =@i_corrEmpleado)
	order by em.Nombre

	select pd.correlativo	--int
		,pe.corrPlanilla	--int
		,pe.corrEmpleado	--int
		,em.Nombre
		,pd.rubro	--varchar
		,pd.cantidad	--int
		,pd.costoUnitario	--money
		,pd.montoTotal	--money
		,pd.signo	--char
		,pd.rowVersion	--int	
		,pd.descripcion			
	from planilla_empleado_rubro pd
	inner join planilla_empleado pe on (pd.corrPlanillaEmp = pe.correlativo)
	inner join Empleado em on (pe.corrEmpleado = em.Empleado)
	where pe.corrPlanilla = @i_corrPlanilla
	and (@i_corrEmpleado is null or (@i_corrEmpleado is not null and pe.corrEmpleado = @i_corrEmpleado))	
	and (@i_rubro is null or (@i_rubro is not null and pd.rubro = @i_rubro))
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_planilla_empleado_rubro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_consulta_planilla_empleado_rubro]
@i_corrPlanilla int
,@i_corrEmpleado int
,@i_rubro varchar(20)=null
,@o_monto_total money=null output
AS
BEGIN


	select pd.correlativo	--int
		,pe.corrPlanilla	--int
		,pe.corrEmpleado	--int
		,em.Nombre
		,pd.rubro	--varchar
		,pd.cantidad	--int
		,pd.costoUnitario	--money
		,pd.montoTotal	--money
		,pd.signo	--char
		,pd.rowVersion	--int
	from planilla_empleado_rubro pd
	inner join planilla_empleado pe on (pd.corrPlanillaEmp = pe.correlativo)
	inner join Empleado em on (pe.corrEmpleado = em.Empleado)
	where pe.corrPlanilla = @i_corrPlanilla
	and (@i_corrEmpleado is null or (@i_corrEmpleado is not null and pe.corrEmpleado = @i_corrEmpleado))
	and (@i_rubro is null or (@i_rubro is not null and pd.rubro = @i_rubro))
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_crea_movimientos_pago]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_crea_movimientos_pago] 
	@i_corrPlanilla int
	,@i_usuario varchar(20)
AS
BEGIN
declare @w_error int
       ,@w_error_msg varchar(200)
	   ,@w_rowcount int	   
	   ,@w_corrEmpleado int
	   ,@w_tipoPlanilla int
	   ,@w_proveedor int
	   ,@w_referencia varchar(2000)
	   ,@w_monto money
	   ,@w_noEnvio varchar(10)
	   ,@w_enviado char(1)
	   ,@w_autorizado char(1)
	   ,@w_bloqueado char(1)
	   ,@w_descripcion varchar(300)
	   ,@w_sec_actual int
	   ,@w_responsable int
	   ,@w_categoriaPlanilla varchar(5)
	   ,@w_nombreEmpleado varchar(50)
	   ,@w_transaccional char(1)

    if @@trancount = 0
	   select @w_transaccional = 'S'
	else
	   select @w_transaccional = 'N'

	if @w_transaccional = 'S'
       begin tran

	select @w_sec_actual = max(Cheque)
	from Cheque

	select @w_responsable = Id
	from usuario
	where Nombre = @i_usuario

	if @w_responsable is null
	begin
	    select @w_error_msg = 'USUARIO NO DEFINIDO'
		goto error
	end

	--validar estatus de la planilla
	select @w_enviado = enviado
	     , @w_autorizado = autorizada
		 , @w_bloqueado = bloqueada
		 , @w_noEnvio = numeroEnvio
		 , @w_tipoPlanilla = tipoPlanilla
		 , @w_categoriaPlanilla = categoriaPlanilla
	from planilla_total
	where correlativo = @i_corrPlanilla

	if @w_enviado <> 'S'
	begin
		select @w_error_msg = 'PLANILLA ESTA PENDIENTE DE ENVIO'
		goto error
	end

	if @w_autorizado <> 'S' or @w_bloqueado <> 'S'
	begin
		select @w_error_msg = 'PLANILLA NO HA SIDO AUTORIZADA O NO ESTA BLOQUEADA'
		goto error
	end

	if @w_noEnvio is null
	begin
		select @w_error_msg = 'NUMERO DE ENVIO NO ASIGNADO'
		goto error
	end

	declare cursor_planilla_empleado  cursor for
    select pe.corrEmpleado
	     , em.Proveedor
		 , em.Nombre
		 , pe.montoTotal
		 , pe.descripcion
	from planilla_empleado pe
	inner join Empleado em on (pe.corrEmpleado = em.Empleado)	
	where pe.corrPlanilla = @i_corrPlanilla

	open cursor_planilla_empleado
	
	fetch next from cursor_planilla_empleado
	into @w_corrEmpleado 	 
	   ,@w_proveedor 	
	   ,@w_nombreEmpleado 
	   ,@w_monto 	   	   
	   ,@w_descripcion 

	while @@FETCH_STATUS = 0
	begin
	    select @w_referencia = 'PAGO A ' + @w_nombreEmpleado 
			+ ' CORRESPONDIENTE A ' + @w_descripcion 
			+ ' POR LA CANTIDAD DE Q.' + convert(varchar, @w_monto)
	    select @w_sec_actual = @w_sec_actual + 1

	    insert into Cheque (
		    Cheque	     ,Fecha	        ,NumCheque       ,TipoCheque  ,ConceptoCheque  
           ,Proveedor    ,Referencia    ,Monto	         ,Ingresado   ,Anulado         
           ,Activo       ,Eliminado     ,Responsable     ,AnuladoPor  ,EliminadoPor	   
           ,TipoGasto    ,NoNegociable  ,Pendiente       ,Planilla	  ,Contribuyente   --?
           ,TipoPlanilla	 ,ClavePago	  ,NumDoc	     ,DesClavePago ,EsDetallado	
		   ,Seleccion	     ,ClaveDeCheque	)
		values (
		    @w_sec_actual ,getdate()     ,@w_noEnvio      ,1           ,7
		   ,@w_proveedor  ,@w_referencia ,@w_monto        ,1           ,0
		   ,1             ,0             ,@w_responsable  ,null        ,null
		   ,1             ,0             ,0               ,@i_corrPlanilla ,null
		   ,@w_tipoPlanilla, null        ,null            ,null        ,0
		   ,null          ,null)        
	   select @w_error = @@error
	   if @w_error <> 0
	   begin
	       select @w_error_msg = 'ERROR AL INSERTAR MOVIMIENTO (' + convert(varchar, @w_error) + ')'
		   goto error
	   end

	   fetch next from cursor_planilla_empleado
	   into @w_corrEmpleado 	 
	      ,@w_proveedor 	
		  ,@w_nombreEmpleado 
	      ,@w_monto 	   	   
	      ,@w_descripcion 

   end

   CLOSE cursor_planilla_empleado
   DEALLOCATE cursor_planilla_empleado

   if @w_transaccional = 'S'
      commit tran

   return 0

error:
    if @w_transaccional = 'S'
       rollback tran

    RAISERROR (@w_error_msg,15,1)
	return -1  
    
END

GO
/****** Object:  StoredProcedure [dbo].[sp_factura_impresa_temp]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_factura_impresa_temp]
    @i_correlativo int
	,@i_impreso char(1)
	,@i_mensaje_error varchar(250) = null
AS
BEGIN
	update Cobro
	set impreso = @i_impreso
	, mensajeError = @i_mensaje_error
	where Cobro = @i_correlativo


END

GO
/****** Object:  StoredProcedure [dbo].[sp_genera_planilla]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_genera_planilla]
@i_categoria_planilla char(2) --SU - sueldo, AG - aguinaldo, BN- bono 14.
, @i_tipo_planilla int=0
, @i_usuario varchar(20)=null
, @i_terminal varchar(30)=null
, @i_fecha datetime=null
,@i_operacion char(1)='G'
,@i_corrPlanilla int =0
, @o_correlativo int =null output
, @o_planilla_nueva char(1)='S' output
AS
BEGIN
declare @w_error int
,@w_error_msg varchar(100)
,@w_rowcount int
,@w_retorno int
,@w_planilla_anterior int
,@w_descripcion varchar(100)
,@w_bac_plan varchar(5)
,@w_igss_pct float
,@w_enviada char(1)
,@w_autorizada char(1)
,@w_bloqueada char(1)
,@w_return int
,@w_corrEmpleado int
, @w_bonificacion money
, @w_sueldoBase money
, @w_fechaInicioLabores datetime
, @w_aplicaIGSS char(1)
, @w_cursorCreado char(1)
, @w_montoIGSS money
, @w_corrPlanillaEmp int
, @i_dias_no_asistidos int

if @i_operacion = 'G'
begin
    begin tran

    select @w_igss_pct = Igss
	from _Config
	where ID= 1


    select @w_bac_plan = g.BacPlan
    from _GRAL g
    where g.GRAL = 1

	if @w_bac_plan is null
	begin
		select @w_error_msg = 'CODIGO DE PLAN O DE ENVIO ESTA NULO'
		goto error
	end

	if @i_fecha is null
	begin
		select @w_error_msg = 'FECHA NO DEFINIDA'
		goto error
	end

    if @i_tipo_planilla is null
	begin
		select @w_error_msg = 'TIPO DE PLANILLA NO PUEDE SER NULO'
		goto error
	end

    if not exists(select 1 from TipoPlanilla t where t.TipoPlanilla = @i_tipo_planilla)
	begin
		select @w_error_msg = 'TIPO DE PLANILLA (' + convert(varchar, @i_tipo_planilla) + ') NO EXISTE.'		
		goto error
	end


    if @i_categoria_planilla not in ('SU','AG','BN')
	begin
	    select @w_error_msg = 'CATEGORIA DE PLANILLA NO VALIDO'
		goto error
	end
	

	--validar que la fecha no haya sido utilizada.
	select @w_planilla_anterior = pe.correlativo
	from planilla_total pe
	where pe.tipoPlanilla = @i_tipo_planilla
	and pe.categoriaPlanilla = @i_categoria_planilla
	and convert(varchar(10), pe.fecha_planilla,103) = convert(varchar(10), @i_fecha, 103)
	and enviado = 'S'
	and autorizada = 'S'
	and bloqueada = 'S'

	if @w_planilla_anterior is not null
	begin
		select @w_error_msg = 'YA HA SIDO ENVIADA UNA PLANILLA ' + convert(varchar, @w_planilla_anterior) + ' CON LA FECHA INGRESADA'
		goto error
	end

    --validar si ya hay una planilla generada que no haya sido enviada.
	select @o_correlativo = max(pe.correlativo)
	from planilla_total pe
	where pe.tipoPlanilla = @i_tipo_planilla
	and pe.categoriaPlanilla = @i_categoria_planilla
	and enviado = 'N'

	if @o_correlativo is not null
	begin
	    rollback tran
	    select @w_error_msg = 'YA SE ENCONTRO UNA PLANILLA PREVIAMENTE GENERADA QUE NO HA SIDO ENVIADA'
		print @w_error_msg
		select @o_planilla_nueva = 'N'
		return 0
	end

	---validar que la fecha de la planilla sea correcta.
	--pendiente.
	
	set identity_insert planilla_total off

	insert into planilla_total 
	   (fecha_creacion	
		,usuario	
		,terminal
		,autorizada	
		,montoTotal	
		,registros	
		,descuentoTotal	
		,bonosTotal	
		,comisionTotal	
		,tipoPlanilla	
		,rowVersion	
		,eliminado	
		,enviado	
		,fecha_planilla							
		,bloqueada
		,categoriaPlanilla
		,numeroPlan
		,numeroEnvio
		,igssTotal		
	) values (
		getdate()
		,@i_usuario
		,@i_terminal
		,'N'
		,0
		,0
		,0
		,0
		,0
		,@i_tipo_planilla
		,1
		,'N'
		,'N'
		,@i_fecha
		,'N'
		,@i_categoria_planilla
		,@w_bac_plan
		,null
		,0
	 )
	 select @w_error = @@error
	 if @w_error > 0
	 begin
		select @w_error_msg = 'ERROR AL INSERTAR CABECERA DE PLANILLA'
		goto error
	 end

	 select @o_correlativo = @@IDENTITY
	 
	exec sp_calcula_descripcion
		@i_corrPlanilla = @o_correlativo
		,@i_rubro = @i_categoria_planilla
		,@i_fecha_planilla = @i_fecha
        ,@o_descripcion =@w_descripcion output
	select @w_error = @@error

	if @w_error > 0
	begin
		select @w_error_msg = 'ERROR AL CALCULAR DESCRIPCION'
		goto error
	end

	if @w_descripcion is null
	begin
		select @w_error_msg = 'DESCRIPCION DE LA PLANILLA NO PUEDE SER NULA'
		goto error
	end

	update planilla_total
	set descripcion = @w_descripcion
	where correlativo = @o_correlativo

	select @w_error = @@error
	if @w_error > 0
	begin
		select @w_error_msg = 'ERROR AL ACTUALIZAR DESCRIPCION'
		goto error
	end

	declare cursor_planilla_emp  cursor for
	select em.Empleado
		, isnull(em.bonificacion_sueldo, 0.00)
		, em.sueldo_base
		, em.InicioLabores
		, em.aplicaIgss
	from Empleado em
	where em.eliminado = 'N'
	and em.estado = 'A'	
	and em.NoCuenta is not null
	and em.NoCuenta <> ''
	and em.TipoPlanilla = @i_tipo_planilla
	and em.sueldo_base is not null

	open cursor_planilla_emp

	select @w_cursorCreado = 'S'

	fetch next from cursor_planilla_emp
	into @w_corrEmpleado 
		, @w_bonificacion 
		, @w_sueldoBase 
		, @w_fechaInicioLabores 
		, @w_aplicaIGSS 

	while @@FETCH_STATUS = 0
	begin

		---barrer las tablas de empleados.
		--tomar todos los empleados activos y aplicar
		--los calculos respectivos por empleado.
		if @i_categoria_planilla = 'SU'
		begin
		    if @w_aplicaIgss = 'S'
				select @w_montoIGSS = round(isnull(@w_sueldoBase,0.00) * @w_igss_pct / 100, 2)
			else
				select @w_montoIGSS = 0.00
			
			select @i_dias_no_asistidos = 15 - datediff(day, @w_fechaInicioLabores, @i_fecha)

			if @i_dias_no_asistidos < 0
			    select @i_dias_no_asistidos = 0

			set identity_insert planilla_empleado off

			insert into planilla_empleado(
				corrPlanilla	--int
				,corrEmpleado	--int
				,montoTotal	--money
				,descripcion	--varchar
				,fecha_creacion	--datetime
				,asistencia
				,bonificacion
				,sueldoBase
				,comision	
				,costo_hora_extra	
				,igss	
				,descuento
				,hora_extra				
			)values(
			   @o_correlativo
			   ,@w_corrEmpleado
			   ,0
			   ,@w_descripcion
			   ,getdate()
			   ,15
			   ,@w_bonificacion
			   ,@w_sueldoBase  
			   ,0
			   ,round(isnull(@w_sueldoBase, 0.00) /15 / 8  * 1.5,2) 
			   ,@w_montoIGSS
			   ,0
			   ,0			   
			)

			select @w_error = @@error
			if @w_error > 0
			begin
				select @w_error_msg = 'ERROR AL GENERAR DETALLE DE PLANILLA DE SUELDOS'
				goto error
			end

			select @w_corrPlanillaEmp = @@IDENTITY
			if @i_dias_no_asistidos > 0
			begin
				exec sp_actualiza_asistencia
					@i_corrPlanilla = @o_correlativo
					,@i_corrEmpleado = @w_corrEmpleado
					,@i_dias_no_asistidos = @i_dias_no_asistidos
					,@i_categoria_planilla = @i_categoria_planilla
					,@i_totalizar  = 'N'
				select @w_error = @@error
				if @w_error > 0
				begin
					select @w_error_msg = 'ERROR AL ACTUALIZAR ASISTENCIA'
					goto error
				end
			end

			SET IDENTITY_INSERT planilla_empleado_rubro off
			insert into planilla_empleado_rubro (
				corrPlanillaEmp
				,rubro	--varchar
				,cantidad	--int
				,costoUnitario	--money
				,montoTotal	--money
				,signo	--char
				,rowVersion	--int
			) values(
			   @w_corrPlanillaEmp
			   ,'SUELDO_BASE'
			   ,1
			   ,@w_sueldoBase
			   ,@w_sueldoBase
			   ,'+'
			   ,1
			)

			 select @w_error = @@error
			 if @w_error > 0
			 begin
				select @w_error_msg = 'ERROR AL GENERAR DETALLE DE PLANILLA DE SUELDOS'
				goto error
			 end

			 insert into planilla_empleado_rubro (
				corrPlanillaEmp
				,rubro	--varchar
				,cantidad	--int
				,costoUnitario	--money
				,montoTotal	--money
				,signo	--char
				,rowVersion	--int
			)values(
			   @w_corrPlanillaEmp
			   ,'BONIFICACION'
			   ,1
			   ,@w_bonificacion
			   ,@w_bonificacion
			   ,'+'
			   ,1
			)

			select @w_error = @@error
			if @w_error > 0
			begin
				select @w_error_msg = 'ERROR AL GENERAR DETALLE DE PLANILLA DE SUELDOS'
				goto error
			end

			--actualiza totales.

			exec @w_retorno= sp_actualiza_totales_planilla
				@i_corrplanilla = @o_correlativo
				,@i_corrEmpleado = @w_corrEmpleado
				,@i_aplicacion_general = 'N'

			select @w_error = @@error
			if @w_error > 0 or @w_retorno < 0
			begin
				select @w_error_msg = 'ERROR AL ACTUALIZAR TOTALES'
				goto error
			end

		end

		if @i_categoria_planilla in ( 'AG', 'BN') --aguinaldo o bono 14.
		begin
		    select @w_sueldoBase = @w_sueldoBase * 2

			select @i_dias_no_asistidos = 360 - datediff(day, @w_fechaInicioLabores, @i_fecha)
			if @i_dias_no_asistidos < 0
			    select @i_dias_no_asistidos = 0
		    
			if @w_aplicaIgss = 'S'
				select @w_montoIGSS = round(isnull(@w_sueldoBase,0.00) * @w_igss_pct / 100, 2)
			else
				select @w_montoIGSS = 0.00

            SET IDENTITY_INSERT planilla_empleado off
			insert into planilla_empleado(
				corrPlanilla	--int
				,corrEmpleado	--int
				,montoTotal	--money
				,descripcion	--varchar
				,fecha_creacion	--datetime
				,asistencia
				,bonificacion
				,sueldoBase
				,comision
				,igss
				,descuento
				,hora_extra				
			)values(
			   @o_correlativo
			   ,@w_corrEmpleado
			   ,@w_sueldoBase --round(em.sueldo_base * dbo.calcularProporcion(em.InicioLabores, @i_fecha, 365), 2)
			   ,@w_descripcion
			   ,getdate()
			   ,0
			   ,0
			   ,@w_sueldoBase 
			   ,0
			   ,@w_montoIGSS
			   ,0
			   ,0			   
			)

			select @w_error = @@error
			if @w_error > 0
			begin
				select @w_error_msg = 'ERROR AL GENERAR DETALLE DE PLANILLA DE SUELDOS'
				goto error
			end

			select @w_corrPlanillaEmp = @@IDENTITY

			if @i_dias_no_asistidos > 0
			begin
				exec sp_actualiza_asistencia
					@i_corrPlanilla = @o_correlativo
					,@i_corrEmpleado = @w_corrEmpleado
					,@i_dias_no_asistidos = @i_dias_no_asistidos
					,@i_categoria_planilla = @i_categoria_planilla
					,@i_totalizar  = 'N'
				select @w_error = @@error
				if @w_error > 0
				begin
					select @w_error_msg = 'ERROR AL ACTUALIZAR ASISTENCIA'
					goto error
				end
			end

			SET IDENTITY_INSERT planilla_empleado_rubro off
			insert into planilla_empleado_rubro (
				corrPlanillaEmp
				,rubro	--varchar
				,cantidad	--int
				,costoUnitario	--money
				,montoTotal	--money
				,signo	--char
				,rowVersion	--int
			)values(
			   @w_corrPlanillaEmp
			   ,@i_tipo_planilla
			   ,1
			   ,@w_sueldoBase
			   ,@w_sueldoBase
			   ,'+'
			   ,1
			)

			select @w_error = @@error
			if @w_error > 0
			begin
				select @w_error_msg = 'ERROR AL GENERAR DETALLE DE PLANILLA DE SUELDOS'
				goto error
			end

			exec @w_retorno= sp_actualiza_totales_planilla
				@i_corrplanilla = @o_correlativo
				,@i_corrEmpleado = @w_corrEmpleado
				,@i_aplicacion_general = 'N'

			select @w_error = @@error
			if @w_error > 0 or @w_retorno < 0
			begin
				select @w_error_msg = 'ERROR AL ACTUALIZAR TOTALES'
				goto error
			end
		end

		fetch next from cursor_planilla_emp
		into @w_corrEmpleado 
			, @w_bonificacion 
			, @w_sueldoBase 
			, @w_fechaInicioLabores 
			, @w_aplicaIGSS 
	end

	CLOSE cursor_planilla_emp
	DEALLOCATE cursor_planilla_emp

	print 'planilla generada'

	exec @w_return= sp_actualiza_totales_planilla
		@i_corrplanilla = @o_correlativo
    select @w_error = @@error
	if @w_error > 0
	begin
	    select @w_error_msg = 'ERROR AL TOTALIZAR REGISTROS'
	    goto error
	end
	if @w_return = -1
	begin
		select @w_error_msg = 'ERROR AL TOTALIZAR REGISTROS (-1)'
		goto error
	end


	commit tran

	return 0
end

if @i_operacion = 'D' --eliminar todo
begin
	begin tran

	--validaciones.
	select @w_enviada = enviado 
	     , @w_autorizada =autorizada
		 , @w_bloqueada = bloqueada
	from planilla_total
	where correlativo = @i_corrPlanilla

	if @w_enviada = 'S'
	begin
		select @w_error_msg = 'PLANILLA HA SIDO ENVIADA'
		goto error
	end

	if @w_autorizada = 'S' or @w_bloqueada = 'S'
	begin
		select @w_error_msg = 'PLANILLA NO PUEDE ESTAR AUTORIZADA NI BLOQUEADA PARA QUE SE PUEDA ELIMINAR'
		goto error
	end

	delete planilla_empleado_rubro 
	from planilla_empleado_rubro per
	inner join planilla_empleado pe on (per.corrPlanillaEmp = pe.correlativo)
	where pe.corrPlanilla = @i_corrPlanilla
	select @w_error = @@error
	if @w_error > 0
	begin
	    select @w_error_msg = 'ERROR AL ELIMINAR RUBROS POR EMPLEADO PLANILLA'
	    goto error
	end


	delete from planilla_empleado
	where corrPlanilla = @i_corrPlanilla
	select @w_error = @@error
	if @w_error > 0
	begin
	    select @w_error_msg = 'ERROR AL ELIMINAR REGISTRO DE EMPLEADO PLANILLA'
	    goto error
	end

	delete from planilla_total
	where correlativo = @i_corrPlanilla
	select @w_error = @@error
	if @w_error > 0
	begin
	    select @w_error_msg = 'ERROR AL ELIMINAR PLANILLA'
	    goto error
	end	

	print 'PLANILLA ELIMINADA EXITOSAMENTE'
	commit tran

	return 0
end


error:

if @w_cursorCreado = 'S'
begin
   	CLOSE cursor_planilla_emp
	DEALLOCATE cursor_planilla_emp
end

rollback tran
RAISERROR (@w_error_msg,15,1)
return -1
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ingresa_comision]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_ingresa_comision]
   @i_operacion char(1) = 'I'
   ,@i_corrPlanilla int
   ,@i_corrEmpleado int
   ,@i_comision money
   ,@i_usuario varchar(20)=null
   ,@i_terminal varchar(20)   
   ,@i_descripcion varchar(100)=null
   ,@o_correlativo int=null output
AS
BEGIN
declare @w_error int
     ,@w_error_msg varchar(200)
	 ,@w_return int
	 ,@w_corrPlanillaEmp int

	select @w_corrPlanillaEmp = correlativo
	from planilla_empleado
	where corrPlanilla = @i_corrPlanilla
	and   corrEmpleado = @i_corrEmpleado
	begin tran
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	if @i_operacion = 'I'
	begin

		insert into planilla_empleado_rubro (
			corrPlanillaEmp
			,rubro	--varchar
			,cantidad	--int
			,costoUnitario	--money
			,montoTotal	--money
			,signo	--char
			,rowVersion	--int
			,descripcion
		) values (
			@w_corrPlanillaEmp
			,'COMISION'
			,1
			,@i_comision
			,@i_comision
			,'+'
			,1			
			,@i_descripcion
		)

		select @w_error = @@error
		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL INSERTAR COMISION'
			goto error
		end

		select @o_correlativo = @@identity
	end
	if @i_operacion = 'E'
	begin
		delete from planilla_empleado_rubro
		where correlativo = @o_correlativo

		select @w_error = @@error
		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL ELIMINAR COMISION'
			goto error
		end
	end

	exec @w_return= sp_actualiza_totales_planilla
			@i_corrPlanilla = @i_corrPlanilla
			,@i_corrEmpleado = @i_corrEmpleado

	select @w_error = @@error
	if @w_error <> 0 or @w_return < 0
	begin
		select @w_error_msg = 'ERROR AL ACTUALIZAR TOTALES'
		goto error
	end

	commit tran
	return 0

error:
    rollback tran
    RAISERROR (@w_error_msg,15,1)
	return -1  
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ingresa_descuento]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_ingresa_descuento]
   @i_operacion char(1) = 'N'
   ,@i_corrPlanilla int
   ,@i_corrEmpleado int
   ,@i_descuento money
   ,@i_usuario int
   ,@i_terminal varchar(20)  
   ,@i_descripcion varchar(100)=null
   ,@o_correlativo int=null output
AS
BEGIN	
declare @w_error int
     ,@w_error_msg varchar(200)
	 ,@w_return int
	,@w_corrPlanillaEmp int

	select @w_corrPlanillaEmp = correlativo
	from planilla_empleado
	where corrPlanilla = @i_corrPlanilla
	and   corrEmpleado = @i_corrEmpleado

	begin tran
	if @i_operacion = 'I'
	begin
		insert into planilla_empleado_rubro (
			corrPlanillaEmp
			,rubro	--varchar
			,cantidad	--int
			,costoUnitario	--money
			,montoTotal	--money
			,descripcion
			,signo	--char
			,rowVersion	--int			
		) values (
			@w_corrPlanillaEmp
			,'DESCUENTO'
			,1
			,@i_descuento
			,@i_descuento 
			,@i_descripcion
			,'-'
			,1						
		)

		select @w_error = @@error
		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL INSERTAR COMISION'
			goto error
		end

		select @o_correlativo = @@identity
	end
	if @i_operacion = 'E'
	begin
		delete from planilla_empleado_rubro
		where correlativo = @o_correlativo

		select @w_error = @@error
		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL INSERTAR COMISION'
			goto error
		end
	end

	exec @w_return= sp_actualiza_totales_planilla
		@i_corrPlanilla = @i_corrPlanilla
		,@i_corrEmpleado = @i_corrEmpleado

	select @w_error = @@error
	if @w_error <> 0 or @w_return < 0
	begin
		select @w_error_msg = 'ERROR AL ACTUALIZAR TOTALES'
		goto error
	end

	commit tran

	return 0

error:
    rollback tran
    RAISERROR (@w_error_msg,-1,-1)
	return -1      
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ingresa_horaextra]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_ingresa_horaextra]
   @i_operacion char(1) = 'N'   
   ,@i_corrPlanilla int
   ,@i_corrEmpleado int
   ,@i_hora_extra int
   ,@i_usuario int=null
   ,@i_terminal varchar(20)   
   ,@o_correlativo int=null output
   ,@o_monto_hora_extra money=null output
AS
BEGIN
declare @w_error int
     ,@w_error_msg varchar(200)
	,@w_return int
	,@w_costo_hora_extra float
	,@w_corrPlanillaEmp int

	begin tran

	select @w_corrPlanillaEmp = correlativo
	from planilla_empleado
	where corrPlanilla = @i_corrPlanilla
	and   corrEmpleado = @i_corrEmpleado

	--la hora extra debe ser calculada, en base a 
	--a los criterios del ministerio de trabajo en base
	--al salario base.
	select @w_costo_hora_extra =  e.costo_hora_extra
	from planilla_empleado e
	where e.corrEmpleado = @i_corrEmpleado
	and e.corrPlanilla = @i_corrPlanilla
	
	if @w_costo_hora_extra is null or @w_costo_hora_extra = 0
	begin
		select @w_error_msg = 'SALARIO BASE NO DEFINIDO'
		goto error
	end	

	if exists(select 1 from planilla_empleado_rubro where corrPlanillaEmp = @w_corrPlanillaEmp
		and rubro = 'HORA_EXTRA')
	begin
		select @i_operacion = 'U'
	end

	select @o_monto_hora_extra = round(@w_costo_hora_extra * @i_hora_extra, 2)

    	
	if @i_operacion = 'I'
	begin
		insert into planilla_empleado_rubro (
		    corrPlanillaEmp
			,rubro	--varchar
			,cantidad	--int
			,costoUnitario	--money
			,montoTotal	--money
			,signo	--char
			,rowVersion	--int			
		) values (
			@w_corrPlanillaEmp
			,'HORA_EXTRA'
			,@i_hora_extra
			,@w_costo_hora_extra
			,@o_monto_hora_extra
			,'+'
			,1						
		)

		select @w_error = @@error
		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL INSERTAR COMISION'
			goto error
		end

		select @o_correlativo = @@identity
	end

	if @i_operacion = 'U'
	begin
		update planilla_empleado_rubro
		set cantidad = @i_hora_extra
		, costoUnitario = @w_costo_hora_extra
		, montoTotal = @w_costo_hora_extra * @i_hora_extra
		where corrPlanillaEmp = @w_corrPlanillaEmp
		and rubro = 'HORA_EXTRA'

		select @w_error = @@error
		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL INSERTAR COMISION'
			goto error
		end

		select @o_correlativo = correlativo
		from planilla_empleado_rubro
        where corrPlanillaEmp = @w_corrPlanillaEmp
		and rubro = 'HORA_EXTRA'

	end

	if @i_operacion = 'E'
	begin
		delete from planilla_empleado_rubro
		where corrPlanillaEmp = @w_corrPlanillaEmp

		select @w_error = @@error
		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL INSERTAR COMISION'
			goto error
		end
	end

	exec @w_return= sp_actualiza_totales_planilla
		@i_corrPlanilla = @i_corrPlanilla
		,@i_corrEmpleado = @i_corrEmpleado

	select @w_error = @@error
	if @w_error <> 0 or @w_return < 0
	begin
		select @w_error_msg = 'ERROR AL ACTUALIZAR TOTALES'
		goto error
	end

	commit tran
	return 0

error:
	rollback tran

    RAISERROR (@w_error_msg,15,1)
	return -1  
END


GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_control_asistencia]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_mantto_control_asistencia]
@i_operacion char(1)
,@i_corrEmpleado	int
,@i_fecha	datetime=null
,@i_rowVersion	int=0
,@i_usuario_crea	varchar=null
,@i_ausencia char(1)='N'
,@i_motivo varchar(200)=null
,@o_correlativo int=0 output
AS
BEGIN
declare @w_error int
 
   if @i_operacion = 'I'
   begin
	  SET IDENTITY_INSERT control_asistencia off
	
	   insert into control_asistencia(
		  corrEmpleado	--int
		  ,fecha	--datetime
		  ,rowVersion	--int
		  ,eliminado	--char
		  ,usuario_crea 
		  ,ausencia
		  ,motivo
	   ) values (	--varchar
           @i_corrEmpleado	
          ,@i_fecha	
          ,@i_rowVersion	
		  ,'N'
          ,@i_usuario_crea	          
		  ,@i_ausencia
		  ,@i_motivo
	   ) 
	   select @w_error = @@error
	   if @w_error <> 0
	   begin
	       raiserror (30000, -1, -1, 'ERROR AL INSERTAR')
		   RETURN -1
	   end	   
	end

	if @i_operacion = 'D'
	begin
		delete from control_asistencia where correlativo = @o_correlativo

       select @w_error = @@error
	   if @w_error <> 0
	   begin
	       raiserror ( 'ERROR AL ELIMINAR',-1, -1)
		   RETURN -1
	   end	 
	end

	return 0
END


GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_email]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_mantto_email]
@i_operacion char(2)
,@i_Email	int=null
,@i_Fecha	datetime=null
,@i_Hora	datetime=null
,@i_To	nvarchar(500)=null
,@i_Cc	nvarchar(500)=null
,@i_Bcc	nvarchar(500)=null
,@i_Asunto	nvarchar(500)=null
,@i_Mensaje	nvarchar(500)=null
,@i_Cliente	int=null
,@i_Des	nvarchar(100)=null
,@i_CitaFecha	datetime=null
,@i_CitaHora	datetime=null
,@i_CitaArea	int=null
,@i_mensajeError varchar(300)=null
,@i_intentos int=0
,@o_FechaVal	int=null output
,@o_HoraVal	int=null output
,@o_GenVersion	int=null output
AS
BEGIN
declare @w_error int
    ,@w_mensaje varchar(200)
	,@w_rowcount int
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    if @i_operacion = 'I'
	begin
		insert into Email (	Fecha,	
			Hora,	
			[To]	,
			Cc	,
			Bcc	,
			Asunto	,
			Mensaje	,
			Enviado	,
			FechaSent,	
			HoraSent	,
			Cliente	,
			Des	,
			CitaFecha	,
			CitaHora	,
			CitaArea) 
		values (
			getdate()
			,getdate()
			,@i_To
			,@i_Cc
			,@i_Bcc
			,@i_Asunto
			,@i_Mensaje
			,-1
			,null
			,null
			,@i_Cliente
			,@i_Des
			,@i_CitaFecha
			,@i_CitaHora
			,@i_CitaArea			
		)
		
		select @w_error = @@error
		if @w_error <> 0
		begin
			raiserror('ERROR AL INSERTAR EN TABLA',15,1)
			RETURN -1
		end
	end

	if @i_operacion = 'E' --marcar como enviado.
	begin
	    update Email
		set enviado = 1
		   ,fechaSent = getdate()
		   ,horaSent = getdate()
		   ,intentos = @i_intentos
		   ,mensajeError = null
		where email = @i_Email

		select @w_error = @@error
		     ,@w_rowcount = @@rowcount

		if @w_error <> 0
		begin
			raiserror('ERROR AL ACTUALIZAR TABLA',15,1)
			RETURN -1
		end

		if @w_rowcount = 0
		begin
			raiserror('NO SE ACTUALIZO NINGUN REGISTRO',15,1)
			return -1
		end
	end

	if @i_operacion = 'ER'  --marcar con error
	begin
	    update Email
		set enviado = -1
		   ,fechaSent = getdate()
		   ,horaSent = getdate()
		   ,intentos = @i_intentos
		   , mensajeError = @i_mensajeError
		where email = @i_Email

		select @w_error = @@error
		     ,@w_rowcount = @@rowcount

		if @w_error <> 0
		begin
			raiserror('ERROR AL ACTUALIZAR TABLA',15,1)
			RETURN -1
		end

		if @w_rowcount = 0
		begin
			raiserror('NO SE ACTUALIZO NINGUN REGISTRO',15,1)
			return -1
		end
	    
	end

	
	return 0
END



GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_empleado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[sp_mantto_empleado]
@i_operacion char(1) = null
,@i_Codigo	varchar(20)=null
,@i_Clave	nvarchar(100)=null
,@i_Nombre	nvarchar(100)=null
,@i_Direccion	nvarchar(100)=null
,@i_Telefono	nvarchar(20)=null
,@i_TipoEmpleado	int=null
,@i_NoCuenta	nvarchar(16)=null
,@i_InicioLabores	datetime
,@i_estado	char(1)=null  ---A activo , I inactivo
,@i_Proveedor	int=null
,@i_TipoPlanilla	int=null
,@i_aplicaIgss	char(1)=null
,@i_sueldo_base	money=null
,@i_bonificacion_sueldo	money=null
,@o_secuencial int=null output
,@o_rowVersion	int=null output
AS
BEGIN
declare @w_error int
,@w_error_msg varchar(200)
,@w_rowversion int
,@w_eliminado char(1)
,@w_restaurado char(1)

    if @i_operacion = 'I'
	begin
	    --validar si ya existe, pero como bajo ELIMINACION LOGICA.
		if @o_secuencial is not null and @o_secuencial <> 0
		begin
			select @w_eliminado = eliminado
			from Empleado
			where Empleado = @o_secuencial

			if @w_eliminado = 'S'
			begin
				select @w_restaurado = 'S'
				     ,@i_operacion = 'U'
			    goto actualizar
			end
			else
			begin
			   select @w_error_msg = 'REGISTRO NO PUEDE SER RESTAURADO'
			   goto error
			end
		end

	    SET IDENTITY_INSERT Empleado off

	    insert into Empleado (			
			Codigo	--nvarchar
			,Clave	--nvarchar
			,Nombre	--nvarchar
			,Direccion	--nvarchar
			,Telefono	--nvarchar
			,TipoEmpleado	--int
			,NoCuenta	--nvarchar
			,InicioLabores	--datetime
			,Proveedor	--int
			,TipoPlanilla	--int
			,sueldo_base	--money
			,bonificacion_sueldo	--money			
			,rowVersion	--int
			,estado	--varchar
			,aplicaIgss	--char
			,eliminado
		)values (
		    @i_Codigo	
			,@i_Clave	
			,@i_Nombre	
			,@i_Direccion	
			,@i_Telefono
			,@i_TipoEmpleado
			,@i_NoCuenta
			,@i_InicioLabores			
			,@i_Proveedor	
			,@i_TipoPlanilla	
			,@i_sueldo_base	
			,@i_bonificacion_sueldo					
			,1
			,'A'
			,@i_aplicaIgss
			,'N'
		)
		select @w_error = @@error

		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL INSERTAR EN TABLA (' + convert(varchar, @w_error) + ')'
			goto error
		end
		select @o_secuencial = @@IDENTITY

	end

actualizar:
	if @i_operacion = 'U'
	begin
	    select @w_rowversion = rowVersion	
		     , @w_eliminado = eliminado	  
		from Empleado
		where Empleado = @o_secuencial

		if @w_rowversion is null
		begin
			select @w_error_msg = 'EMPLEADO NO ENCONTRADO'
			goto error
		end

		if @w_rowversion <> @o_rowVersion
		begin
			select @w_error_msg = 'ERROR DE CONCURRENCIA, VERSION DE LAS FILAS ES DISTINTA'
			goto error
		end

		if @w_eliminado = 'S' and @w_restaurado = 'N'
		begin
			select @w_error_msg = 'REGISTRO HA SIDO ELIMINADO'
			goto error
		end

		select @w_rowversion = @o_rowVersion + 1

		update Empleado
		set Codigo	= isnull(@i_Codigo, em.Codigo)
			,Clave	= isnull(@i_Clave, em.Clave)
			,Nombre	 = isnull(@i_Nombre, em.Nombre)
			,Direccion	= isnull(@i_Direccion, em.Direccion)
			,Telefono   = isnull(@i_Telefono, em.Telefono)
			,TipoEmpleado	= isnull(@i_TipoEmpleado, em.TipoEmpleado)
			,NoCuenta	= isnull(@i_NoCuenta, em.NoCuenta)
			,InicioLabores	= isnull(@i_InicioLabores, em.InicioLabores)
			,Proveedor	= isnull(@i_Proveedor, em.Proveedor)
			,TipoPlanilla	= isnull(@i_TipoPlanilla, em.TipoPlanilla)
			,sueldo_base	= isnull(@i_sueldo_base, em.sueldo_base)
			,bonificacion_sueldo	= isnull(@i_bonificacion_sueldo, em.bonificacion_sueldo)
			,estado	= isnull(@i_estado, em.estado)
			,aplicaIgss	= isnull(@i_aplicaIgss, em.aplicaIgss)
			,rowVersion = @w_rowversion
		from Empleado em
		where em.Empleado = @o_secuencial

		select @w_error = @@error
		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL INSERTAR EN TABLA (' + convert(varchar, @w_error) + ')'
			goto error
		end
	end

	if @i_operacion = 'D'
	begin
	    select @w_rowversion = rowVersion
		from Empleado
		where Empleado = @o_secuencial

		if @w_rowversion is null
		begin
			select @w_error_msg = 'EMPLEADO NO ENCONTRADO'
			goto error
		end

		if @w_rowversion <> @o_rowVersion
		begin
			select @w_error_msg = 'ERROR DE CONCURRENCIA, VERSION DE LAS FILAS ES DISTINTA'
			goto error
		end

		update Empleado
		set eliminado = 'S'
		where Empleado = @o_secuencial

		select @w_error = @@error
		if @w_error <> 0
		begin
			select @w_error_msg = 'ERROR AL INSERTAR EN TABLA (' + convert(varchar, @w_error) + ')'
			goto error
		end
	end
	
	return 0


error:
    RAISERROR (@w_error_msg,15,1)
	return -1
END


GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_login]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_login]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_tipoUsuario int = null   
,  @i_usuario_modifica varchar(30) = null   
,  @i_login varchar(50) = null   
,  @i_fechaUltAcceso datetime = null   
,  @i_passWord varchar(100) = null   
,  @i_activo char(1) = null   
, @o_rowVersion int = null output
, @o_correlativo int = null output
, @o_restaurado char(1) = null output
as
begin
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
     , @w_eliminado char(1)
     , @w_rowVersion int

select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
    
if @w_tran_iniciada = 'N'    
    begin tran    

     if @i_operacion = 'I' --insercion
     begin
          select @o_restaurado = null
          --validar si ya fue eliminado "logicamente".        
          --solo aplica para eliminaciones logicas.
          select @w_eliminado = eliminado
          from login
          where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert login off  --solo aplica si tiene identity


          insert into  login (
              tipoUsuario
              ,login
              ,fechaUltAcceso
              ,passWord
              ,activo
              ,fecha_creacion
              ,usuario_modifica
              ,fecha_ult_mod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_tipoUsuario
              ,@i_login
              ,@i_fechaUltAcceso
              ,@i_passWord
              ,@i_activo
              ,getdate()
              ,null
              ,null
              ,1
              ,'N'
          )        
          
          select @w_error = @@error
          if @w_error <> 0
          begin
               select @w_error_msg = 'ERROR AL INSERTAR EN TABLA'
               goto error
          end
          
          select @o_correlativo = @@identity --solo aplica si tiene identity
          select @o_rowVersion = 1
     end




actualizacion:
     if @i_operacion = 'U' --actualizacion
     begin
         --validar rowVersion y si esta eliminado.
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica.
      from login
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_rowVersion
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @o_restaurado is null or @o_restaurado = 'N'
         begin
             if @w_eliminado = 'S'
             begin
                 select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
                 goto error
             end             
         end
         
         
         if @o_restaurado = 'S'
         begin
             update login
             set restaurado = 'S'
                ,eliminado = 'N'
             from login 
             where correlativo = @o_correlativo
         end
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update login
         set
              tipoUsuario = isnull(@i_tipoUsuario, t.tipoUsuario)
              ,login = isnull(@i_login, t.login)
              ,fechaUltAcceso = isnull(@i_fechaUltAcceso, t.fechaUltAcceso)
              ,passWord = isnull(@i_passWord, t.passWord)
              ,activo = isnull(@i_activo, t.activo)
              ,usuario_modifica = @i_usuario_modifica 
              ,fecha_ult_mod = getdate()
              ,rowVersion = @w_rowVersion
          from login t
          where t.correlativo = @o_correlativo 
        
          select @w_error = @@error
                  ,@w_rowcount = @@rowcount
          if @w_error <> 0
          begin
               select @w_error_msg = 'ERROR AL INSERTAR EN TABLA'
               goto error
          end
          
          if @w_rowcount <> 1
          begin
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion
                     
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from login
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_rowVersion
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_rowVersion) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'   --solo eliminacion logica
         begin             
             select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
             goto error            
         end
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update login                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fecha_ult_mod = getdate()
            , usuario_modifica = @i_usuario_modifica
         where correlativo = @o_correlativo
         
          select @w_error = @@error
                ,@w_rowcount = @@rowcount
          if @w_error <> 0
          begin
               select @w_error_msg = 'ERROR AL INSERTAR EN TABLA'
               goto error
          end
          
          if @w_rowcount <> 1
          begin
               select @w_error_msg = 'SE ELIMINARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end         
          select @o_rowVersion = @w_rowVersion --fin eliminacion logica
    end




    
    
if @w_tran_iniciada = 'N'
    commit tran
     
return 0

error:
if @w_tran_iniciada = 'N'
    rollback tran
    
RAISERROR (@w_error_msg,15,1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[spULTIMO_TX]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spULTIMO_TX]
@Cliente int
AS
BEGIN
SET NOCOUNT ON
SELECT Cobro.Tratamiento, Cobro.fecha
FROM Cobro INNER JOIN (Tratamiento INNER JOIN CatalogoTratamiento ON Tratamiento.CatalogoTratamiento = CatalogoTratamiento.CatalogoTratamiento) ON (Cobro.Tratamiento = Tratamiento.Tratamiento) AND (Cobro.Area = Tratamiento.Area)
WHERE Cobro.Activo=1
AND Cobro.Ingresado=1
AND Cobro.Cliente=@Cliente
AND Cobro.Tratamiento Is Not Null
AND CatalogoTratamiento.EsAparato=0
AND Cobro.Pendiente=0
AND NOT EXISTS(
select c2.Cobro 
FROM Cobro c2 INNER JOIN (Tratamiento T2 INNER JOIN CatalogoTratamiento CT ON T2.CatalogoTratamiento = ct.CatalogoTratamiento) ON (c2.Tratamiento = t2.Tratamiento) AND (c2.Area = t2.Area)
where C2.Cliente=@Cliente
AND C2.Activo =1
AND C2.Ingresado =1
AND C2.Pendiente =0
AND C2.FechaVal>Cobro.fechaVal
AnD C2.Cobro<>Cobro.Cobro
AND c2.Tratamiento Is Not Null
AND CatalogoTratamiento.EsAparato=0
)
END
GO
/****** Object:  StoredProcedure [dbo].[VerPlantaSinLlamadas]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VerPlantaSinLlamadas]
@Fecha Datetime
AS
BEGIN
SET NOCOUNT ON
Select HorarioPlanta.Fecha, HorarioPlanta.mHORA, HorarioPlanta.DIASEM, coalesce(PlantaxHora.NumLlamadas,0) as NumLlamadas
From
(	Select MAX(Fecha) AS Fecha,datepart(HOUR,Hora) AS mHORA,FechaVal,MAX(datepart(dw,Fecha)) as DIASEM
	From Cita
	Where Cita.FechaVal>=Year(@Fecha)*500+Month(@Fecha)*32+Day(@Fecha) 
	And Cita.FechaVal<Year(GETDATE())*500+Month(GETDATE())*32+Day(GETDATE())
	Group By Cita.FechaVal, datepart(HOUR,Hora)
) AS HorarioPlanta
LEFT JOIN 
(	select  FechaVal, MIN(Fecha) as mFecha,MIN(Day(Fecha))as mDIA, datepart(HOUR,Hora) AS mHORA, Count(*) as NumLlamadas
	from Planta
	group by FechaVal, datepart(HOUR,Hora)
) AS PlantaxHora
	ON HorarioPlanta.FechaVal = PlantaxHora.FechaVal And HorarioPlanta.mHORA =PlantaxHora.mHORA
Where coalesce(PlantaxHora.NumLlamadas,0)<10
And HorarioPlanta.mHORA>=8
And HorarioPlanta.mHORA<18
Order by HorarioPlanta.FechaVal, HorarioPlanta.mHORA
END
GO
/****** Object:  UserDefinedFunction [dbo].[calcularProporcion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[calcularProporcion]
(
	-- Add the parameters for the function here
	@i_fechaInicio datetime
	,@i_fechaPlanilla datetime
	,@i_base int
)
RETURNS numeric(10,2)
AS
BEGIN
	declare @w_diferencia_dias numeric(10,2)
	, @w_proporcion numeric(10,2)

	select @w_diferencia_dias = DATEDIFF(day, @i_fechaInicio, @i_fechaPlanilla)

	if @w_diferencia_dias < @i_base
		select @w_proporcion = @w_diferencia_dias / @i_base
	else
		select @w_proporcion = 1

	return round(@w_proporcion,2)
END















GO
/****** Object:  Table [dbo].[_Cargar_al_Inicio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_Cargar_al_Inicio](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Formulario] [nvarchar](50) NULL,
	[Formato] [int] NULL,
	[Error] [nvarchar](50) NULL,
	[Accion] [int] NULL,
	[Cerrar] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK__Cargar_al_Inicio_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[_Config]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_Config](
	[ID] [int] NOT NULL,
	[ConeccionActual] [nvarchar](255) NULL,
	[SucursalID] [int] NULL,
	[SucursalNombre] [nvarchar](100) NULL,
	[Path] [nvarchar](255) NULL,
	[SucursalTel] [nvarchar](80) NULL,
	[TituloVentanas] [nvarchar](80) NULL,
	[CamaraFotos] [nvarchar](255) NULL,
	[Modulo] [int] NULL,
	[Igss] [float] NULL,
	[GenVersion] [int] NULL,
	[UltImpSemanal] [datetime] NULL,
	[UltBackUpVal] [int] NULL,
	[ForceShutDown] [smallint] NULL,
	[RestartTV] [smallint] NULL,
 CONSTRAINT [PK__Config_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[_GRAL]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_GRAL](
	[GRAL] [int] NOT NULL,
	[CerrarPrograma] [smallint] NULL,
	[Des] [nvarchar](50) NULL,
	[PresupuestoComparar] [int] NULL,
	[ImpChRechazados] [datetime] NULL,
	[ImpChRechazadosAgenda] [int] NULL,
	[MailsCumples] [datetime] NULL,
	[Status1] [nvarchar](255) NULL,
	[Status2] [nvarchar](255) NULL,
	[Status3] [nvarchar](255) NULL,
	[Status4] [nvarchar](255) NULL,
	[GenVersion] [int] NULL,
	[BacPlan] [nvarchar](4) NULL,
	[Formato] [int] NULL,
	[BacEvio] [int] NULL,
	[BacEnvio] [int] NULL,
 CONSTRAINT [PK__GRAL_GRAL] PRIMARY KEY CLUSTERED 
(
	[GRAL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[_ImprimirDetallado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ImprimirDetallado](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Cobro] [int] NULL,
	[Cantidad1] [int] NULL,
	[Descripcion1] [nvarchar](200) NULL,
	[Precio1] [float] NULL,
	[Uni1] [float] NULL,
	[Cantidad2] [int] NULL,
	[Descripcion2] [nvarchar](200) NULL,
	[Precio2] [float] NULL,
	[Uni2] [float] NULL,
	[Cantidad3] [int] NULL,
	[Descripcion3] [nvarchar](200) NULL,
	[Precio3] [float] NULL,
	[Uni3] [float] NULL,
	[Cantidad4] [int] NULL,
	[Descripcion4] [nvarchar](200) NULL,
	[Precio4] [float] NULL,
	[Uni4] [float] NULL,
	[Cantidad5] [int] NULL,
	[Descripcion5] [nvarchar](200) NULL,
	[Precio5] [float] NULL,
	[Uni5] [float] NULL,
	[Cantidad6] [int] NULL,
	[Descripcion6] [nvarchar](200) NULL,
	[Precio6] [float] NULL,
	[Uni6] [float] NULL,
	[Cantidad7] [int] NULL,
	[Descripcion7] [nvarchar](200) NULL,
	[Precio7] [float] NULL,
	[Uni7] [float] NULL,
	[Cantidad8] [int] NULL,
	[Descripcion8] [nvarchar](200) NULL,
	[Precio8] [float] NULL,
	[Uni8] [float] NULL,
	[Cantidad9] [int] NULL,
	[Descripcion9] [nvarchar](200) NULL,
	[Precio9] [float] NULL,
	[Uni9] [float] NULL,
	[Cantidad10] [int] NULL,
	[Descripcion10] [nvarchar](200) NULL,
	[Precio10] [float] NULL,
	[Uni10] [float] NULL,
	[Cantidad11] [int] NULL,
	[Descripcion11] [nvarchar](200) NULL,
	[Precio11] [float] NULL,
	[Uni11] [float] NULL,
	[Cantidad12] [int] NULL,
	[Descripcion12] [nvarchar](200) NULL,
	[Precio12] [float] NULL,
	[Uni12] [float] NULL,
	[Cantidad13] [int] NULL,
	[Descripcion13] [nvarchar](200) NULL,
	[Precio13] [float] NULL,
	[Uni13] [float] NULL,
	[Cantidad14] [int] NULL,
	[Descripcion14] [nvarchar](200) NULL,
	[Precio14] [float] NULL,
	[Uni14] [float] NULL,
	[Cantidad15] [int] NULL,
	[Descripcion15] [nvarchar](200) NULL,
	[Precio15] [float] NULL,
	[Uni15] [float] NULL,
	[Cantidad16] [int] NULL,
	[Descripcion16] [nvarchar](200) NULL,
	[Precio16] [float] NULL,
	[Uni16] [float] NULL,
	[Cantidad17] [int] NULL,
	[Descripcion17] [nvarchar](200) NULL,
	[Precio17] [float] NULL,
	[Uni17] [float] NULL,
	[Cantidad18] [int] NULL,
	[Descripcion18] [nvarchar](200) NULL,
	[Precio18] [float] NULL,
	[Uni18] [float] NULL,
	[Cantidad19] [int] NULL,
	[Descripcion19] [nvarchar](200) NULL,
	[Precio19] [float] NULL,
	[Uni19] [float] NULL,
	[Cantidad20] [int] NULL,
	[Descripcion20] [nvarchar](200) NULL,
	[Precio20] [float] NULL,
	[Uni20] [float] NULL,
	[Cantidad21] [int] NULL,
	[Descripcion21] [nvarchar](200) NULL,
	[Precio21] [float] NULL,
	[Uni21] [float] NULL,
	[Cantidad22] [int] NULL,
	[Descripcion22] [nvarchar](200) NULL,
	[Precio22] [float] NULL,
	[Uni22] [float] NULL,
	[Cantidad23] [int] NULL,
	[Descripcion23] [nvarchar](200) NULL,
	[Precio23] [float] NULL,
	[Uni23] [float] NULL,
	[Cantidad24] [int] NULL,
	[Descripcion24] [nvarchar](200) NULL,
	[Precio24] [float] NULL,
	[Uni24] [float] NULL,
	[Cantidad25] [int] NULL,
	[Descripcion25] [nvarchar](200) NULL,
	[Precio25] [float] NULL,
	[Uni25] [float] NULL,
	[Cantidad26] [int] NULL,
	[Descripcion26] [nvarchar](200) NULL,
	[Precio26] [float] NULL,
	[Uni26] [float] NULL,
	[Cantidad27] [int] NULL,
	[Descripcion27] [nvarchar](200) NULL,
	[Precio27] [float] NULL,
	[Uni27] [float] NULL,
	[Cantidad28] [int] NULL,
	[Descripcion28] [nvarchar](200) NULL,
	[Precio28] [float] NULL,
	[Uni28] [float] NULL,
	[Total] [float] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK__ImprimirDetallado_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[_Status]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_Status](
	[ID] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Mensajes] [nvarchar](max) NULL,
	[Status] [nvarchar](255) NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK__Status_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[_StatusSincro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_StatusSincro](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Descripcion] [nvarchar](255) NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK__StatusSincro_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Acreditacion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Acreditacion](
	[TipoUsuario] [int] NOT NULL,
	[Permiso] [nvarchar](50) NOT NULL,
	[Permitir] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Acreditacion_TipoUsuarioPermiso] PRIMARY KEY CLUSTERED 
(
	[TipoUsuario] ASC,
	[Permiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ArchTemporal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArchTemporal](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Terminal] [int] NULL,
	[Archivo] [nvarchar](255) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_ArchTemporal_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Area]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area](
	[Area] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[EsOrto] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Area_Area] PRIMARY KEY CLUSTERED 
(
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Banco]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banco](
	[Banco] [int] NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Abreviado] [nvarchar](10) NULL,
	[Activo] [smallint] NULL,
	[ComisionCliente] [float] NULL,
	[ComisionTarjeta] [float] NULL,
	[EsTarjeta] [smallint] NULL,
	[NumCuotas] [int] NULL,
	[GenVersion] [int] NULL,
	[Grupo] [int] NULL,
 CONSTRAINT [PK_Banco_Banco] PRIMARY KEY CLUSTERED 
(
	[Banco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BitacoraCartaEsp]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BitacoraCartaEsp](
	[BitacoraCartaEsp] [int] IDENTITY(1,1) NOT NULL,
	[CartaEsp] [int] NULL,
	[CartaEspDes] [nvarchar](50) NULL,
	[Cliente] [int] NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[FechaCarta] [datetime] NULL,
	[Nombre] [nvarchar](200) NULL,
	[Contenido] [nvarchar](max) NULL,
	[Firma] [nvarchar](50) NULL,
	[Usuario] [int] NULL,
	[DocImprimir] [nvarchar](50) NULL,
	[Titulo1] [nvarchar](255) NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_BitacoraCartaEsp_BitacoraCartaEsp] PRIMARY KEY CLUSTERED 
(
	[BitacoraCartaEsp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BloqueoEsp]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BloqueoEsp](
	[Area] [int] NULL,
	[Hora] [datetime] NULL,
	[Sillon] [nvarchar](1) NULL,
	[Des] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
	[HoraVal] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BloqueoSillones]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BloqueoSillones](
	[BloqueoSillones] [int] IDENTITY(1,1) NOT NULL,
	[Area] [int] NULL,
	[FechaIni] [datetime] NULL,
	[FechaFin] [datetime] NULL,
	[Lu] [smallint] NULL,
	[Ma] [smallint] NULL,
	[Mi] [smallint] NULL,
	[Ju] [smallint] NULL,
	[Vi] [smallint] NULL,
	[Sa] [smallint] NULL,
	[SillonA] [smallint] NULL,
	[SillonB] [smallint] NULL,
	[SillonC] [smallint] NULL,
	[SillonD] [smallint] NULL,
	[SillonE] [smallint] NULL,
	[SIllonF] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_BloqueoSillones_BloqueoSillones] PRIMARY KEY CLUSTERED 
(
	[BloqueoSillones] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bodega]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bodega](
	[Bodega] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Bodega_Bodega] PRIMARY KEY CLUSTERED 
(
	[Bodega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BracketDespegados]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BracketDespegados](
	[BracketDespegados] [int] NOT NULL,
	[Cliente] [int] NULL,
	[Fecha] [datetime] NULL,
	[Cantidad] [int] NULL,
	[Monto] [float] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
 CONSTRAINT [PK_BracketDespegados_BracketDespegados] PRIMARY KEY CLUSTERED 
(
	[BracketDespegados] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BuscarCita]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BuscarCita](
	[BuscarCita] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Buscar] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_BuscarCita_BuscarCita] PRIMARY KEY CLUSTERED 
(
	[BuscarCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CambioDatos]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CambioDatos](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Anterior] [nvarchar](255) NULL,
	[Nuevo] [nvarchar](255) NULL,
	[Tipo] [nvarchar](255) NULL,
	[Usuario] [int] NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_CambioDatos_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cargo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cargo](
	[Cargo] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Cargo_Cargo] PRIMARY KEY CLUSTERED 
(
	[Cargo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CartaEsp]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartaEsp](
	[CartaEsp] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[TextoRecibo] [nvarchar](120) NULL,
	[Texto] [nvarchar](max) NULL,
	[TextoMenor] [nvarchar](max) NULL,
	[Firma] [nvarchar](50) NULL,
	[MostrarEnMenu] [smallint] NULL,
	[DocImprimir] [nvarchar](50) NULL,
	[Titulo1] [nvarchar](255) NULL,
	[PedirParametros] [nvarchar](255) NULL,
	[EjecutarWord] [nvarchar](255) NULL,
	[EjecutarWordMenor] [nvarchar](255) NULL,
	[GenVersion] [int] NULL,
	[ImprimeSinWord] [smallint] NOT NULL,
 CONSTRAINT [PK_CartaEsp_CartaEsp] PRIMARY KEY CLUSTERED 
(
	[CartaEsp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CatalogoPrecio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CatalogoPrecio](
	[CatalogoPrecio] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[PagoInicial] [float] NULL,
	[Registros] [float] NULL,
	[Retenedores] [float] NULL,
	[Mensualidad] [float] NULL,
	[Nota] [nvarchar](max) NULL,
	[EsAparato] [smallint] NULL,
	[PagoFinal] [float] NULL,
	[Activo] [smallint] NULL,
	[DescripcionDescuento] [nvarchar](50) NULL,
	[EsPrecioEspecial] [smallint] NULL,
	[CompararCon] [int] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_CatalogoPrecio_CatalogoPrecio] PRIMARY KEY CLUSTERED 
(
	[CatalogoPrecio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CatalogoPrecio_Servicio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CatalogoPrecio_Servicio](
	[CatalogoPrecio] [int] NOT NULL,
	[Servicio] [int] NOT NULL,
	[Precio] [float] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_CatalogoPrecio_Servicio_CatalogoPrecioServicio] PRIMARY KEY CLUSTERED 
(
	[CatalogoPrecio] ASC,
	[Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CatalogoTratamiento]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CatalogoTratamiento](
	[CatalogoTratamiento] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[TituloContrato] [nvarchar](50) NULL,
	[PagoInicial] [float] NULL,
	[Registros] [float] NULL,
	[Retenedores] [float] NULL,
	[Mensualidad] [float] NULL,
	[Nota] [nvarchar](max) NULL,
	[EsAparato] [smallint] NULL,
	[PagoFinal] [float] NULL,
	[Activo] [smallint] NULL,
	[Facturado] [smallint] NULL,
	[MostrarReportes] [smallint] NULL,
	[TxConFactura] [int] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_CatalogoTratamiento_CatalogoTratamiento] PRIMARY KEY CLUSTERED 
(
	[CatalogoTratamiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Chat]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat](
	[Chat] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Origen] [int] NULL,
	[Destino] [int] NULL,
	[TerminalOrigen] [int] NULL,
	[TerminalDestino] [int] NULL,
	[Mensaje] [nvarchar](max) NULL,
	[Leido] [smallint] NULL,
	[Activo] [smallint] NULL,
	[Limpiar] [smallint] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
	[Cliente] [int] NULL,
 CONSTRAINT [PK_Chat_Chat] PRIMARY KEY CLUSTERED 
(
	[Chat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChatCommon]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatCommon](
	[ChatCommon] [int] NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_ChatCommon_ChatCommon] PRIMARY KEY CLUSTERED 
(
	[ChatCommon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cheque]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cheque](
	[Cheque] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[NumCheque] [nvarchar](20) NULL,
	[TipoCheque] [int] NULL,
	[ConceptoCheque] [int] NULL,
	[Proveedor] [int] NULL,
	[Referencia] [nvarchar](max) NULL,
	[Monto] [float] NULL,
	[Ingresado] [smallint] NULL,
	[Anulado] [smallint] NULL,
	[Activo] [smallint] NULL,
	[Eliminado] [smallint] NULL,
	[Responsable] [int] NULL,
	[AnuladoPor] [int] NULL,
	[EliminadoPor] [int] NULL,
	[TipoGasto] [int] NULL,
	[NoNegociable] [smallint] NULL,
	[Pendiente] [smallint] NULL,
	[Planilla] [int] NULL,
	[Contribuyente] [int] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[TipoPlanilla] [int] NULL,
	[ClavePago] [int] NULL,
	[NumDoc] [nvarchar](50) NULL,
	[DesClavePago] [nvarchar](max) NULL,
	[EsDetallado] [smallint] NOT NULL,
	[Seleccion] [int] NULL,
	[ClaveDeCheque] [int] NULL,
 CONSTRAINT [PK_Cheque_Cheque] PRIMARY KEY CLUSTERED 
(
	[Cheque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cita]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cita](
	[Fecha] [datetime] NOT NULL,
	[Hora] [datetime] NOT NULL,
	[Area] [int] NOT NULL,
	[Sillon] [nvarchar](1) NOT NULL,
	[Cliente] [int] NULL,
	[TipoCita] [int] NULL,
	[Observaciones] [nvarchar](max) NULL,
	[Cumplida] [int] NULL,
	[Bloqueada] [smallint] NULL,
	[Responsable] [int] NULL,
	[Doctor] [int] NULL,
	[BloqDes] [nvarchar](120) NULL,
	[BloqTel] [nvarchar](50) NULL,
	[EsAnterior] [smallint] NULL,
	[AnteriorNombre] [nvarchar](50) NULL,
	[AnteriorTel] [nvarchar](50) NULL,
	[AnteriorTx] [nvarchar](50) NULL,
	[Lock] [smallint] NULL,
	[Terminal] [int] NULL,
	[Contactar] [smallint] NULL,
	[Respuesta] [int] NULL,
	[FechaRecontactar] [datetime] NULL,
	[FechaContacto] [datetime] NULL,
	[ContactoPor] [int] NULL,
	[FechaTran] [datetime] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
	[FaltasSeguidas] [int] NULL,
	[CitaId] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Cita_FechaHoraAreaSillon] PRIMARY KEY CLUSTERED 
(
	[Fecha] ASC,
	[Hora] ASC,
	[Area] ASC,
	[Sillon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CitasBorradas]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CitasBorradas](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Area] [int] NULL,
	[Sillon] [nvarchar](1) NULL,
	[Cliente] [int] NULL,
	[TipoCita] [int] NULL,
	[Observaciones] [nvarchar](255) NULL,
	[Cumplida] [smallint] NULL,
	[Bloqueada] [smallint] NULL,
	[Responsable] [int] NULL,
	[Doctor] [int] NULL,
	[BloqDes] [nvarchar](120) NULL,
	[BloqTel] [nvarchar](50) NULL,
	[EsAnterior] [smallint] NULL,
	[AnteriorNombre] [nvarchar](50) NULL,
	[AnteriorTel] [nvarchar](50) NULL,
	[AnteriorTx] [nvarchar](50) NULL,
	[Lock] [smallint] NULL,
	[Terminal] [int] NULL,
	[EliminadaPor] [int] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
	[FechaTrans] [datetime] NOT NULL,
 CONSTRAINT [PK_CitasBorradas_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClaseFotos]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClaseFotos](
	[ClaseFotos] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_ClaseFotos_ClaseFotos] PRIMARY KEY CLUSTERED 
(
	[ClaseFotos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[Cliente] [int] NOT NULL,
	[Nombre] [nvarchar](120) NULL,
	[Direccion] [nvarchar](255) NULL,
	[Telefono] [nvarchar](80) NULL,
	[Nit] [nvarchar](15) NULL,
	[Email] [nvarchar](80) NULL,
	[Foto] [nvarchar](255) NULL,
	[Revaluacion] [datetime] NULL,
	[ReferidoPor] [int] NULL,
	[ReferidoDoctor] [int] NULL,
	[ReferidoOtro] [int] NULL,
	[FechaExamen] [datetime] NULL,
	[Problema] [nvarchar](255) NULL,
	[FechaNac] [datetime] NULL,
	[EstudiaTrabaja] [nvarchar](100) NULL,
	[GradoPuesto] [nvarchar](100) NULL,
	[Carrera] [nvarchar](100) NULL,
	[DireccionTrabajo] [nvarchar](255) NULL,
	[TelefonoTrabajo] [nvarchar](50) NULL,
	[Dentista] [nvarchar](80) NULL,
	[CambioGrave] [nvarchar](200) NULL,
	[Medicamento] [nvarchar](120) NULL,
	[Embarazo] [smallint] NULL,
	[EnfermedadGrave] [nvarchar](250) NULL,
	[Observacion] [nvarchar](255) NULL,
	[UltimoCheckeo] [nvarchar](50) NULL,
	[TratamientoTerminado] [nvarchar](50) NULL,
	[Accidente] [nvarchar](200) NULL,
	[Habito] [nvarchar](120) NULL,
	[PrimeraCita] [smallint] NULL,
	[SegundaOpinion] [smallint] NULL,
	[OrtoAnteriormente] [smallint] NULL,
	[FamiliaSimilar] [smallint] NULL,
	[Expectativa] [nvarchar](255) NULL,
	[Padre] [nvarchar](120) NULL,
	[OcupacionPadre] [nvarchar](100) NULL,
	[Madre] [nvarchar](120) NULL,
	[OcupacionMadre] [nvarchar](100) NULL,
	[NecesidadOdontologica] [nvarchar](255) NULL,
	[DescripcionProblema] [nvarchar](255) NULL,
	[PosibleTx] [nvarchar](255) NULL,
	[Activo] [smallint] NULL,
	[Facturar] [nvarchar](120) NULL,
	[Area] [int] NULL,
	[Responsable] [int] NULL,
	[EliminadoPor] [int] NULL,
	[FechaIngreso] [datetime] NULL,
	[HoraIngreso] [datetime] NULL,
	[TipoCliente] [int] NULL,
	[Nemotec] [uniqueidentifier] NULL,
	[Carpeta] [nvarchar](120) NULL,
	[GradoColegio] [int] NULL,
	[Seccion] [nvarchar](5) NULL,
	[Aviso] [nvarchar](120) NULL,
	[Info] [smallint] NULL,
	[TelActualizado] [datetime] NULL,
	[TelActualizdoPor] [int] NULL,
	[FacturaDireccion] [nvarchar](100) NULL,
	[FacturaTel] [nvarchar](50) NULL,
	[FechaDigitalizado] [datetime] NULL,
	[BloquearOdon] [smallint] NULL,
	[AvisoInasistencia] [int] NULL,
	[ProxAvisoInasistencia] [datetime] NULL,
	[EmailPadres] [nvarchar](200) NULL,
	[ErrorMail] [datetime] NULL,
	[ClaseFotos] [int] NULL,
	[IDFotos] [int] IDENTITY(1,1) NOT NULL,
	[RecargoInfo] [smallint] NULL,
	[RecargoInfoResp] [int] NULL,
	[RecargoInfoFecha] [datetime] NULL,
	[FixMailFecha] [datetime] NULL,
	[FixMailResp] [int] NULL,
	[FechaTran] [datetime] NULL,
	[Archivo] [nvarchar](100) NULL,
	[GenVersion] [int] NULL,
	[ArchID] [int] NULL,
	[SMSCel] [nvarchar](50) NULL,
	[InfoInterno] [nvarchar](max) NULL,
 CONSTRAINT [PK_Cliente_Cliente] PRIMARY KEY CLUSTERED 
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClienteDigital]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClienteDigital](
	[ClienteDigital] [int] IDENTITY(1,1) NOT NULL,
	[Cliente] [int] NULL,
	[Imagen] [nvarchar](255) NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Activo] [smallint] NULL,
	[Usuario] [int] NULL,
	[EliminadoPor] [int] NULL,
	[FechaEliminado] [datetime] NULL,
	[HoraEliminado] [datetime] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_ClienteDigital_ClienteDigital] PRIMARY KEY CLUSTERED 
(
	[ClienteDigital] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClienteEnfermedad]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClienteEnfermedad](
	[Cliente] [int] NOT NULL,
	[Enfermedad] [int] NOT NULL,
	[Seleccion] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_ClienteEnfermedad_ClienteEnfermedad] PRIMARY KEY CLUSTERED 
(
	[Cliente] ASC,
	[Enfermedad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClienteHistorial]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClienteHistorial](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FechaTran] [datetime] NULL,
	[HoraTran] [datetime] NULL,
	[Cliente] [int] NULL,
	[ArchivoAnt] [nvarchar](50) NULL,
	[ArchivoAct] [nvarchar](50) NULL,
	[NombreAnt] [nvarchar](255) NULL,
	[NombreAct] [nvarchar](255) NULL,
	[Responsable] [int] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_ClienteHistorial_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Clock]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clock](
	[Clock] [int] IDENTITY(1,1) NOT NULL,
	[IDClock] [int] NULL,
	[Usuario] [int] NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[FechaFull] [datetime] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_Clock] PRIMARY KEY CLUSTERED 
(
	[Clock] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cobro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cobro](
	[Cobro] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Cliente] [int] NULL,
	[Tratamiento] [int] NULL,
	[Monto] [float] NULL,
	[TipoCobro] [int] NULL,
	[FaseTratamiento] [int] NULL,
	[Servicio] [int] NULL,
	[Area] [int] NULL,
	[TotalDebido] [float] NULL,
	[Efectivo] [float] NULL,
	[Cheque] [float] NULL,
	[NumCheque] [nvarchar](20) NULL,
	[Banco] [int] NULL,
	[Pendiente] [smallint] NULL,
	[FechaPendiente] [datetime] NULL,
	[Doctor] [int] NULL,
	[Facturado] [smallint] NULL,
	[Activo] [smallint] NULL,
	[Ingresado] [smallint] NULL,
	[BracketCant] [int] NULL,
	[Rechazado] [smallint] NULL,
	[OldSystem] [smallint] NULL,
	[EsAnterior] [smallint] NULL,
	[DesAnterior] [nvarchar](255) NULL,
	[Responsable] [int] NULL,
	[EliminadoPor] [int] NULL,
	[FechaIngreso] [datetime] NULL,
	[HoraIngreso] [datetime] NULL,
	[Cargo] [float] NULL,
	[Producto] [int] NULL,
	[Cantidad] [int] NULL,
	[NumFactura] [int] NULL,
	[EsAparato] [smallint] NULL,
	[VisaNetReal] [float] NULL,
	[FechaEliminado] [datetime] NULL,
	[HoraEliminado] [datetime] NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Piezas] [nvarchar](150) NULL,
	[Abono] [float] NULL,
	[Saldo] [float] NULL,
	[mcargo] [int] NULL,
	[Presupuesto] [int] NULL,
	[FechaRechazado] [datetime] NULL,
	[Anyo] [int] NULL,
	[CobroTran2] [int] NULL,
	[Contar] [smallint] NULL,
	[MontoFactura] [float] NULL,
	[FacturaTipo] [int] NULL,
	[CobroTran] [int] IDENTITY(1,1) NOT NULL,
	[Contribuyente] [int] NULL,
	[FacturaSerie] [nvarchar](10) NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
	[PCosto] [float] NULL,
 CONSTRAINT [PK_Cobro_Cobro] PRIMARY KEY CLUSTERED 
(
	[Cobro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Codigo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Codigo](
	[Codigo] [nvarchar](10) NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Codigo_Codigo] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comando]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comando](
	[Comando] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Argumento] [nvarchar](50) NULL,
	[Argumento2] [int] NULL,
	[TipoComando] [int] NULL,
	[Param] [nvarchar](20) NULL,
	[Panel] [int] NULL,
	[Configurable] [smallint] NULL,
	[Orden] [int] NULL,
	[Instalar] [smallint] NULL,
	[Borrar] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Comando_Comando] PRIMARY KEY CLUSTERED 
(
	[Comando] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConceptoCheque]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConceptoCheque](
	[ConceptoCheque] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_ConceptoCheque_ConceptoCheque] PRIMARY KEY CLUSTERED 
(
	[ConceptoCheque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConeccionChat]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConeccionChat](
	[Terminal] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Usuario] [int] NULL,
	[Conectado] [smallint] NULL,
	[Recepcion] [smallint] NULL,
	[DirRed] [nvarchar](255) NULL,
	[ConeccionFecha] [datetime] NULL,
	[ConeccionHora] [datetime] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_ConeccionChat_Terminal] PRIMARY KEY CLUSTERED 
(
	[Terminal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Contribuyente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contribuyente](
	[Contribuyente] [int] NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Nit] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[Leyenda] [nvarchar](200) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Contribuyente_Contribuyente] PRIMARY KEY CLUSTERED 
(
	[Contribuyente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DescuentoEspecial]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DescuentoEspecial](
	[DescuentoEspecial] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[Porcentaje] [float] NULL,
	[Cantidad] [float] NULL,
	[Reporte] [nvarchar](120) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_DescuentoEspecial_DescuentoEspecial] PRIMARY KEY CLUSTERED 
(
	[DescuentoEspecial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DiaSemana]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiaSemana](
	[DiaSemana] [int] NOT NULL,
	[Descripcion] [nvarchar](12) NULL,
	[Abr] [nvarchar](3) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_DiaSemana_DiaSemana] PRIMARY KEY CLUSTERED 
(
	[DiaSemana] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DIR]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIR](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DIR] [int] NULL,
	[Nombre] [nvarchar](255) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_DIR_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[Doctor] [int] NOT NULL,
	[Nombre] [nvarchar](80) NULL,
	[Direccion] [nvarchar](255) NULL,
	[Telefono] [nvarchar](120) NULL,
	[Nit] [nvarchar](15) NULL,
	[Email] [nvarchar](80) NULL,
	[Activo] [smallint] NULL,
	[Titulo] [nvarchar](10) NULL,
	[VerOrtodoncia] [smallint] NULL,
	[VerOdontologia] [smallint] NULL,
	[Utilidad] [int] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Doctor_Doctor] PRIMARY KEY CLUSTERED 
(
	[Doctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DoctorRef]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorRef](
	[DoctorRef] [int] NOT NULL,
	[Nombre] [nvarchar](80) NULL,
	[Direccion] [nvarchar](255) NULL,
	[Telefono] [nvarchar](80) NULL,
	[Titulo] [nvarchar](20) NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_DoctorRef_DoctorRef] PRIMARY KEY CLUSTERED 
(
	[DoctorRef] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DoctorRefCliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorRefCliente](
	[DoctorRefCliente] [int] NOT NULL,
	[Nombre] [nvarchar](80) NULL,
	[Direccion] [nvarchar](255) NULL,
	[Telefono] [nvarchar](80) NULL,
	[EMail] [nvarchar](100) NULL,
	[Cumpleaños] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_DoctorRefCliente_DoctorRefCliente] PRIMARY KEY CLUSTERED 
(
	[DoctorRefCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DoctorUsuario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorUsuario](
	[Doctor] [int] NOT NULL,
	[Usuario] [int] NOT NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_DoctorUsuario_DoctorUsuario] PRIMARY KEY CLUSTERED 
(
	[Doctor] ASC,
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Email]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Email](
	[Email] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[To] [nvarchar](255) NULL,
	[Cc] [nvarchar](255) NULL,
	[Bcc] [nvarchar](255) NULL,
	[Asunto] [nvarchar](255) NULL,
	[Enviado] [smallint] NULL,
	[FechaSent] [datetime] NULL,
	[HoraSent] [datetime] NULL,
	[Cliente] [int] NULL,
	[Des] [nvarchar](50) NULL,
	[CitaFecha] [datetime] NULL,
	[CitaHora] [datetime] NULL,
	[CitaArea] [int] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
	[mensaje] [varchar](4000) NULL,
	[mensajeError] [varchar](300) NULL,
	[intentos] [int] NULL,
 CONSTRAINT [PK_Email_Email] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleado](
	[Empleado] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [nvarchar](10) NULL,
	[Clave] [nvarchar](50) NULL,
	[Nombre] [nvarchar](50) NULL,
	[Direccion] [nvarchar](255) NULL,
	[Telefono] [nvarchar](50) NULL,
	[TipoEmpleado] [int] NULL,
	[NoCuenta] [nvarchar](50) NULL,
	[InicioLabores] [datetime] NULL,
	[Activo] [smallint] NULL,
	[Proveedor] [int] NULL,
	[SueldoBase] [float] NULL,
	[Bonificacion] [float] NULL,
	[TipoPlanilla] [int] NULL,
	[TieneIGSS] [smallint] NULL,
	[GenVersion] [int] NULL,
	[sueldo_base] [money] NULL,
	[bonificacion_sueldo] [money] NULL,
	[horaextra_costo] [money] NULL,
	[rowVersion] [int] NULL,
	[hora_extra_costo] [money] NULL,
	[estado] [char](1) NULL,
	[aplicaIgss] [char](1) NULL,
	[eliminado] [char](1) NULL,
 CONSTRAINT [PK_Empleado_Empleado] PRIMARY KEY CLUSTERED 
(
	[Empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Enfermedad]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enfermedad](
	[Enfermedad] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Enfermedad_Enfermedad] PRIMARY KEY CLUSTERED 
(
	[Enfermedad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EstadoTrabajo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadoTrabajo](
	[EstadoTrabajo] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_EstadoTrabajo_EstadoTrabajo] PRIMARY KEY CLUSTERED 
(
	[EstadoTrabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Eti]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Eti](
	[Etiqueta] [int] NOT NULL,
	[Eti01] [nvarchar](255) NULL,
	[Eti02] [nvarchar](255) NULL,
	[Eti03] [nvarchar](255) NULL,
	[Eti04] [nvarchar](255) NULL,
	[Eti05] [nvarchar](255) NULL,
	[Eti06] [nvarchar](255) NULL,
	[Eti07] [nvarchar](255) NULL,
	[Eti08] [nvarchar](255) NULL,
	[Eti09] [nvarchar](255) NULL,
	[Eti10] [nvarchar](255) NULL,
	[Eti11] [nvarchar](255) NULL,
	[Eti12] [nvarchar](255) NULL,
	[Eti13] [nvarchar](255) NULL,
	[Eti14] [nvarchar](255) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Eti_Etiqueta] PRIMARY KEY CLUSTERED 
(
	[Etiqueta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Etiqueta]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Etiqueta](
	[Etiqueta] [int] IDENTITY(1,1) NOT NULL,
	[OrdenEtiqueta] [int] NULL,
	[Texto] [nvarchar](255) NULL,
	[ID] [int] NULL,
	[Imprimir] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Etiqueta_Etiqueta] PRIMARY KEY CLUSTERED 
(
	[Etiqueta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Extension]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Extension](
	[Extension] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Extension_Extension] PRIMARY KEY CLUSTERED 
(
	[Extension] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FacturaCliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturaCliente](
	[FacturaCliente] [int] IDENTITY(1,1) NOT NULL,
	[Cobro] [int] NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Monto] [float] NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_FacturaCliente_FacturaCliente] PRIMARY KEY CLUSTERED 
(
	[FacturaCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FaseTratamiento]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FaseTratamiento](
	[FaseTratamiento] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Especial] [smallint] NULL,
	[Activo] [smallint] NULL,
	[ImportadoOld] [smallint] NULL,
	[CreadoPor] [int] NULL,
	[Abono] [smallint] NULL,
	[FechaCreado] [datetime] NULL,
	[EsNuevo] [smallint] NULL,
	[EsAparato] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_FaseTratamiento_FaseTratamiento] PRIMARY KEY CLUSTERED 
(
	[FaseTratamiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FechaEspecial]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FechaEspecial](
	[FechaEspecial] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[TipoFechaEspecial] [int] NULL,
	[HoraInicio] [datetime] NULL,
	[HoraFin] [datetime] NULL,
	[Activo] [smallint] NULL,
	[EliminadoFecha] [datetime] NULL,
	[EliminadoHora] [datetime] NULL,
	[EliminadoPor] [int] NULL,
	[CreadoFecha] [datetime] NULL,
	[CreadoHora] [datetime] NULL,
	[Bloqueado] [smallint] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
 CONSTRAINT [PK_FechaEspecial_FechaEspecial] PRIMARY KEY CLUSTERED 
(
	[FechaEspecial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FechaEspecialBloquearHora]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FechaEspecialBloquearHora](
	[FechaEspecialBloquearHora] [int] IDENTITY(1,1) NOT NULL,
	[Hora] [datetime] NULL,
	[Todos] [smallint] NULL,
	[abc] [smallint] NULL,
	[def] [smallint] NULL,
	[TipoFechaEspecial] [int] NULL,
	[Bloquear] [smallint] NULL,
	[Desbloquear] [smallint] NULL,
	[TipoDiaSemana] [int] NULL,
	[GenVersion] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_FechaEspecialBloquearHora_FechaEspecialBloquearHora] PRIMARY KEY CLUSTERED 
(
	[FechaEspecialBloquearHora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[fechas_planilla]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fechas_planilla](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[tipoPlanilla] [varchar](5) NOT NULL,
 CONSTRAINT [PK_fechas_planilla] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Formato]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Formato](
	[Formato] [int] NOT NULL,
	[CartaDoctorSaludo] [nvarchar](max) NULL,
	[CartaDoctorDespedida] [nvarchar](max) NULL,
	[CartaDoctorFirma] [nvarchar](50) NULL,
	[CartaClienteSaludo] [nvarchar](max) NULL,
	[CartaClienteDespedida] [nvarchar](max) NULL,
	[CartaClienteFirma] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Formato_Formato] PRIMARY KEY CLUSTERED 
(
	[Formato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GenerarAuto]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenerarAuto](
	[GenerarAuto] [int] IDENTITY(1,1) NOT NULL,
	[Tipo] [int] NULL,
	[Cliente] [int] NULL,
	[Fecha] [datetime] NULL,
	[MensajePredef] [int] NULL,
	[Costo] [float] NULL,
	[Servicio] [int] NULL,
	[Cantidad] [int] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
 CONSTRAINT [PK_GenerarAuto_GenerarAuto] PRIMARY KEY CLUSTERED 
(
	[GenerarAuto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GradoColegio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GradoColegio](
	[GradoColegio] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_GradoColegio_GradoColegio] PRIMARY KEY CLUSTERED 
(
	[GradoColegio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoraExtra]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoraExtra](
	[HoraExtra] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Empleado] [int] NULL,
	[Horas] [float] NULL,
	[Usuario] [int] NULL,
	[Ingresado] [smallint] NULL,
	[Responsable] [int] NULL,
	[EliminadoPor] [int] NULL,
	[TipoExtra] [int] NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Monto] [float] NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[GeneradoPor] [int] NULL,
	[DescontarAnyo] [int] NULL,
	[DescontarMes] [int] NULL,
	[DescontarQuincena] [int] NULL,
	[GeneradoFecha] [datetime] NULL,
 CONSTRAINT [PK_HoraExtra_HoraExtra] PRIMARY KEY CLUSTERED 
(
	[HoraExtra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Horario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Horario](
	[Fecha] [datetime] NOT NULL,
	[Hora] [datetime] NOT NULL,
	[Area] [int] NOT NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_Horario_FechaHoraArea] PRIMARY KEY CLUSTERED 
(
	[Fecha] ASC,
	[Hora] ASC,
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Impresora]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Impresora](
	[Impresora] [int] NOT NULL,
	[ImpresoraDes] [nvarchar](50) NULL,
	[TipoImpresora] [int] NULL,
	[Host] [nvarchar](50) NULL,
	[Local] [nvarchar](50) NULL,
	[Red] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
 CONSTRAINT [PK_Impresora] PRIMARY KEY CLUSTERED 
(
	[Impresora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Laboratorio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laboratorio](
	[Laboratorio] [int] NOT NULL,
	[Nombre] [nvarchar](80) NULL,
	[Direccion] [nvarchar](255) NULL,
	[Telefono] [nvarchar](80) NULL,
	[Contacto] [nvarchar](80) NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Laboratorio_Laboratorio] PRIMARY KEY CLUSTERED 
(
	[Laboratorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Linea]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Linea](
	[Linea] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Linea_Linea] PRIMARY KEY CLUSTERED 
(
	[Linea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Listado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Listado](
	[Listado] [int] IDENTITY(1,1) NOT NULL,
	[TipoListado] [int] NULL,
	[Cliente] [int] NULL,
	[Terminal] [int] NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Doctor] [int] NULL,
	[IngresoPor] [int] NULL,
	[FechaIngreso] [datetime] NULL,
	[AtendidoPor] [int] NULL,
	[MinEspera] [int] NULL,
	[FechaAtendido] [datetime] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
	[TipoCita] [int] NULL,
 CONSTRAINT [PK_Listado_Listado] PRIMARY KEY CLUSTERED 
(
	[Listado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[login]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[login](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[login] [varchar](50) NOT NULL,
	[passWord] [varchar](100) NULL,
	[tipoUsuario] [int] NULL,
	[activo] [char](1) NULL,
	[fechaUltAcceso] [datetime] NULL,
	[usuario_modifica] [varchar](30) NULL,
	[fecha_creacion] [datetime] NULL,
	[fecha_ult_mod] [datetime] NULL,
	[rowVersion] [int] NULL,
	[eliminado] [char](1) NULL,
	[restaurado] [char](1) NULL,
 CONSTRAINT [PK_login] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MailErrorFiles]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MailErrorFiles](
	[MailErrorFiles] [int] IDENTITY(1,1) NOT NULL,
	[Archivo] [nvarchar](255) NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Cliente] [int] NULL,
	[Mail] [nvarchar](255) NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_MailErrorFiles_MailErrorFiles] PRIMARY KEY CLUSTERED 
(
	[MailErrorFiles] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MensajePredef]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MensajePredef](
	[MensajePredef] [int] NOT NULL,
	[Boton] [nvarchar](50) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[PedirCantidad] [smallint] NULL,
	[PedirTexto] [nvarchar](50) NULL,
	[Seleccion] [smallint] NULL,
	[CostoUni] [float] NULL,
	[Servicio] [int] NULL,
	[Cantidad] [int] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_MensajePredef_MensajePredef] PRIMARY KEY CLUSTERED 
(
	[MensajePredef] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Mes]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mes](
	[Mes] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Abr] [nvarchar](3) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Mes_Mes] PRIMARY KEY CLUSTERED 
(
	[Mes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MesPlanilla]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MesPlanilla](
	[Mes] [int] NOT NULL,
	[Descripcion] [nvarchar](20) NULL,
	[Abr] [nvarchar](10) NULL,
	[Orden] [int] NULL,
 CONSTRAINT [PK_MesPlanilla] PRIMARY KEY CLUSTERED 
(
	[Mes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MovimientoProducto]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientoProducto](
	[MovimientoProducto] [int] NOT NULL,
	[TipoMovimientoProducto] [int] NULL,
	[Doctor] [int] NULL,
	[Cliente] [int] NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Usuario] [int] NULL,
	[Activo] [smallint] NULL,
	[Vale] [int] NULL,
	[Descripcion] [nvarchar](255) NULL,
	[FechaEliminado] [datetime] NULL,
	[HoraEliminado] [datetime] NULL,
	[EliminadoPor] [int] NULL,
	[Ingresado] [smallint] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
	[MPBodega] [int] NULL,
 CONSTRAINT [PK_MovimientoProducto_MovimientoProducto] PRIMARY KEY CLUSTERED 
(
	[MovimientoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MovimientoProductoDetalle]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientoProductoDetalle](
	[MovimientoProductoDetalle] [int] IDENTITY(1,1) NOT NULL,
	[MovimientoProducto] [int] NULL,
	[Producto] [int] NULL,
	[Ingreso] [float] NULL,
	[Salida] [float] NULL,
	[Contar] [smallint] NULL,
	[Activo] [smallint] NULL,
	[EliminadoPor] [int] NULL,
	[FechaEliminado] [datetime] NULL,
	[HoraEliminado] [datetime] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_MovimientoProductoDetalle_MovimientoProductoDetalle] PRIMARY KEY CLUSTERED 
(
	[MovimientoProductoDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrtodonciaTx]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrtodonciaTx](
	[OrtodonciaTX] [int] IDENTITY(1,1) NOT NULL,
	[Cliente] [int] NULL,
	[Fecha] [datetime] NULL,
	[NumCita] [int] NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Activo] [smallint] NULL,
	[Responsable] [int] NULL,
	[ProxCita] [nvarchar](max) NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
 CONSTRAINT [PK_OrtodonciaTx_OrtodonciaTX] PRIMARY KEY CLUSTERED 
(
	[OrtodonciaTX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PagoPlanilla]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PagoPlanilla](
	[Planilla] [int] NOT NULL,
	[Empleado] [int] NOT NULL,
	[Bonificacion] [float] NULL,
	[Sueldo] [float] NULL,
	[Extra] [int] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_PagoPlanilla_PlanillaEmpleado] PRIMARY KEY CLUSTERED 
(
	[Planilla] ASC,
	[Empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Panel]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Panel](
	[Panel] [int] NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Default] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Panel_Panel] PRIMARY KEY CLUSTERED 
(
	[Panel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Param]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Param](
	[Terminal] [int] NOT NULL,
	[Cliente] [int] NULL,
	[PFecha1] [int] NULL,
	[PFecha2] [int] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Param_Terminal] PRIMARY KEY CLUSTERED 
(
	[Terminal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Permiso]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permiso](
	[Permiso] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](100) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Permiso_Permiso] PRIMARY KEY CLUSTERED 
(
	[Permiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pieza]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pieza](
	[Pieza] [nvarchar](3) NOT NULL,
	[Descripcion1] [nvarchar](50) NULL,
	[Descripcion2] [nvarchar](50) NULL,
	[Especial] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Pieza_Pieza] PRIMARY KEY CLUSTERED 
(
	[Pieza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Planilla]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Planilla](
	[Planilla] [int] NOT NULL,
	[FechaInicio] [datetime] NULL,
	[FechaFin] [datetime] NULL,
	[Quincena] [int] NULL,
	[Mes] [int] NULL,
	[Anyo] [int] NULL,
	[Bloqueado] [smallint] NULL,
	[GenVersion] [int] NULL,
	[TieneDebito] [smallint] NULL,
	[Envio] [int] NULL,
	[Generada] [datetime] NULL,
	[GeneradaPor] [int] NULL,
	[BloqueadoTX] [nvarchar](50) NULL,
 CONSTRAINT [PK_Planilla_Planilla] PRIMARY KEY CLUSTERED 
(
	[Planilla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[planilla_empleado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
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
/****** Object:  Table [dbo].[planilla_empleado_rubro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
/****** Object:  Table [dbo].[planilla_rubro_descripcion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
/****** Object:  Table [dbo].[planilla_total]    Script Date: 16/06/2016 09:36:57 p.m. ******/
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
/****** Object:  Table [dbo].[PlanillaDetalle]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanillaDetalle](
	[PlanillaDetalle] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NULL,
	[Planilla] [int] NULL,
	[NumOrden] [int] NULL,
	[Nombre] [nvarchar](50) NULL,
	[Codigo] [nvarchar](50) NULL,
	[Cargo] [nvarchar](50) NULL,
	[SueldoBase] [float] NULL,
	[Bonificacion] [float] NULL,
	[Adelantos] [float] NULL,
	[Extras] [float] NULL,
	[NumExtras] [float] NULL,
	[Total] [float] NULL,
	[Liquido] [float] NULL,
	[Mostrar] [smallint] NULL,
	[Igss] [float] NULL,
	[Aguinaldo] [float] NULL,
	[InicioLabores] [datetime] NULL,
	[MesesTrabajados] [float] NULL,
	[Orden] [int] NULL,
	[NumHorasExtras] [float] NULL,
	[NumHorasExtrasFeriados] [float] NULL,
	[QNumHorasExtrasFeriados] [float] NULL,
	[SueldoHoraExtra] [float] NULL,
	[Dias] [float] NULL,
	[CalcularDias] [int] NULL,
	[Comision] [float] NULL,
	[Descuento] [float] NULL,
	[Descripcion] [nvarchar](max) NULL,
	[TipoPlanilla] [int] NULL,
	[GenVersion] [int] NULL,
	[Vacaciones] [float] NULL,
	[VacacionesP] [float] NULL,
	[VacacionesG] [float] NULL,
 CONSTRAINT [PK_PlanillaDetalle_PlanillaDetalle] PRIMARY KEY CLUSTERED 
(
	[PlanillaDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlanillaDias]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanillaDias](
	[PlanillaDias] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NOT NULL,
	[Planilla] [int] NULL,
	[Dias] [float] NULL,
	[Vacaciones] [float] NULL,
	[VacacionesP] [float] NULL,
	[VacacionesG] [float] NULL,
	[Suspension] [float] NULL,
 CONSTRAINT [PK_PlanillaDias] PRIMARY KEY CLUSTERED 
(
	[PlanillaDias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Planta]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Planta](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Extension] [int] NULL,
	[Linea] [int] NULL,
	[Telefono] [nvarchar](100) NULL,
	[Duracion] [nvarchar](50) NULL,
	[Codigo] [nvarchar](10) NULL,
	[Min] [int] NULL,
	[Seg] [int] NULL,
	[TotSeg] [int] NULL,
	[TotMin] [int] NULL,
	[vTelefono] [int] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_Planta_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlantaCliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantaCliente](
	[Planta] [int] NOT NULL,
	[Cliente] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Extension] [int] NULL,
	[Linea] [int] NULL,
	[Telefono] [nvarchar](100) NULL,
	[Codigo] [nvarchar](10) NULL,
	[Duracion] [nvarchar](50) NULL,
	[Min] [int] NULL,
	[Seg] [int] NULL,
	[TotSeg] [int] NULL,
	[TotMin] [int] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_PlantaCliente_PlantaCliente] PRIMARY KEY CLUSTERED 
(
	[Planta] ASC,
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Presupuesto]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Presupuesto](
	[Presupuesto] [int] NOT NULL,
	[Area] [int] NULL,
	[Cliente] [int] NULL,
	[Doctor] [int] NULL,
	[Fecha] [datetime] NULL,
	[PagoInicial] [float] NULL,
	[NumCuotas] [int] NULL,
	[MontoCuota] [float] NULL,
	[Descuento] [float] NULL,
	[Registros] [float] NULL,
	[Retenedores] [float] NULL,
	[Costo] [float] NULL,
	[Total] [float] NULL,
	[CatalogoPrecio] [int] NULL,
	[ConFactura] [smallint] NULL,
	[Responsable] [int] NULL,
	[EliminadoPor] [int] NULL,
	[EsAparato] [smallint] NULL,
	[PagoFinal] [float] NULL,
	[Activo] [smallint] NULL,
	[3cuotas] [smallint] NULL,
	[6cuotas] [smallint] NULL,
	[10cuotas] [smallint] NULL,
	[12cuotas] [smallint] NULL,
	[DescuentoEspecial] [int] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
 CONSTRAINT [PK_Presupuesto_Presupuesto] PRIMARY KEY CLUSTERED 
(
	[Presupuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PresupuestoDetalle]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PresupuestoDetalle](
	[PresupuestoDetalle] [int] IDENTITY(1,1) NOT NULL,
	[Presupuesto] [int] NULL,
	[Cantidad] [int] NULL,
	[Servicio] [int] NULL,
	[Costo] [float] NULL,
	[Pieza] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_PresupuestoDetalle_PresupuestoDetalle] PRIMARY KEY CLUSTERED 
(
	[PresupuestoDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Producto]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[Producto] [int] NOT NULL,
	[Descripcion] [nvarchar](100) NULL,
	[Activo] [smallint] NULL,
	[Responsable] [int] NULL,
	[Precio] [float] NULL,
	[Costo] [float] NULL,
	[MostrarEnVenta] [smallint] NULL,
	[Bodega] [int] NULL,
	[Area] [int] NULL,
	[EliminadoPor] [int] NULL,
	[EliminadoFecha] [datetime] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Producto_Producto] PRIMARY KEY CLUSTERED 
(
	[Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Proveedor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedor](
	[Proveedor] [int] NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Empresa] [nvarchar](50) NULL,
	[Telefono] [nvarchar](50) NULL,
	[Direccion] [nvarchar](200) NULL,
	[Activo] [smallint] NULL,
	[Mensual] [smallint] NULL,
	[PagueseA] [nvarchar](50) NULL,
	[MensualDes] [nvarchar](255) NULL,
	[MensualMonto] [float] NULL,
	[MensualConcepto] [int] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Proveedor_Proveedor] PRIMARY KEY CLUSTERED 
(
	[Proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Recordatorio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recordatorio](
	[Recordatorio] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Usuario] [int] NULL,
	[Mensaje] [nvarchar](255) NULL,
	[NoMostrar] [smallint] NULL,
	[Activo] [smallint] NULL,
	[Responsable] [int] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
 CONSTRAINT [PK_Recordatorio_Recordatorio] PRIMARY KEY CLUSTERED 
(
	[Recordatorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Referencia]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Referencia](
	[Referencia] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[DoctorRef] [int] NULL,
	[Cliente] [int] NULL,
	[Doctor] [int] NULL,
	[Observaciones] [nvarchar](255) NULL,
	[Responsable] [int] NULL,
	[EliminadoPor] [int] NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
 CONSTRAINT [PK_Referencia_Referencia] PRIMARY KEY CLUSTERED 
(
	[Referencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReferenciaDetalle]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferenciaDetalle](
	[Referencia] [int] NOT NULL,
	[TratamientoRef] [int] NOT NULL,
	[Seleccion] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_ReferenciaDetalle_ReferenciaTratamientoRef] PRIMARY KEY CLUSTERED 
(
	[Referencia] ASC,
	[TratamientoRef] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReferenciaPieza]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferenciaPieza](
	[Referencia] [int] NOT NULL,
	[TratamientoRef] [int] NOT NULL,
	[Pieza] [nvarchar](3) NOT NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_ReferenciaPieza_ReferenciaTratamientoRefPieza] PRIMARY KEY CLUSTERED 
(
	[Referencia] ASC,
	[TratamientoRef] ASC,
	[Pieza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RefOtro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefOtro](
	[RefOtro] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[TipoRefOtro] [int] NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_RefOtro_RefOtro] PRIMARY KEY CLUSTERED 
(
	[RefOtro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RegCortes]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegCortes](
	[Fecha] [datetime] NOT NULL,
	[Ejecutor] [int] NULL,
	[Ejecutado] [smallint] NULL,
	[Hora] [datetime] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_RegCortes_Fecha] PRIMARY KEY CLUSTERED 
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RegCortesM]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegCortesM](
	[Fecha] [datetime] NOT NULL,
	[Ejecutor] [int] NULL,
	[Ejecutado] [smallint] NULL,
	[Hora] [datetime] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_RegCortesM_Fecha] PRIMARY KEY CLUSTERED 
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RegFixMail]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegFixMail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Cliente] [int] NULL,
	[Anterior] [nvarchar](255) NULL,
	[Actual] [nvarchar](255) NULL,
	[Usuario] [int] NULL,
	[Estado] [int] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_RegFixMail_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reporte Clientes Config]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporte Clientes Config](
	[ID] [int] NOT NULL,
	[Fechas] [smallint] NULL,
	[Consulta] [nvarchar](max) NULL,
	[PedirDatos] [nvarchar](120) NULL,
	[Descripcion] [nvarchar](max) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Reporte_Clientes_Config_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReporteClientes]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReporteClientes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Terminal] [int] NULL,
	[Cliente] [int] NULL,
	[Nombre] [nvarchar](200) NULL,
	[Telefono] [nvarchar](100) NULL,
	[Direccion] [nvarchar](250) NULL,
	[CampoFinal] [nvarchar](50) NULL,
	[TituloCampoFinal] [nvarchar](50) NULL,
	[Titulo] [nvarchar](200) NULL,
	[Fechas] [nvarchar](250) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_ReporteClientes_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Requerimiento]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requerimiento](
	[Requerimiento] [int] NOT NULL,
	[Tipo] [int] NULL,
	[Cliente] [int] NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[ResponsableCobro] [int] NULL,
	[Usuario] [int] NULL,
	[Observacion] [nvarchar](max) NULL,
	[Hecho] [smallint] NULL,
	[FechaHecho] [datetime] NULL,
	[HechoPor] [int] NULL,
	[Pendiente] [smallint] NULL,
	[RazonPendiente] [nvarchar](255) NULL,
	[Activo] [smallint] NULL,
	[EliminadoPor] [int] NULL,
	[FechaEliminado] [datetime] NULL,
	[HoraEliminado] [datetime] NULL,
	[AutorizadoPor] [int] NULL,
	[AutorizadoFecha] [datetime] NULL,
	[AutorizadoHora] [datetime] NULL,
	[AutorizadoTerminal] [int] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_Requerimiento_Requerimiento] PRIMARY KEY CLUSTERED 
(
	[Requerimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RequestDetalle]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestDetalle](
	[RequestDetalle] [int] IDENTITY(1,1) NOT NULL,
	[Request] [int] NULL,
	[ID1] [int] NULL,
	[ID2] [int] NULL,
	[ID3] [int] NULL,
	[ID4] [int] NULL,
	[ID5] [int] NULL,
	[Texto1] [nvarchar](255) NULL,
	[Texto2] [nvarchar](255) NULL,
	[Texto3] [nvarchar](255) NULL,
	[Texto4] [nvarchar](255) NULL,
	[Texto5] [nvarchar](255) NULL,
	[Monto1] [float] NULL,
	[Monto2] [float] NULL,
	[Monto3] [float] NULL,
	[Monto4] [float] NULL,
	[Monto5] [float] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_RequestDetalle_RequestDetalle] PRIMARY KEY CLUSTERED 
(
	[RequestDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RespuestaCita]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RespuestaCita](
	[RespuestaCita] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[ContactarDespues] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_RespuestaCita_RespuestaCita] PRIMARY KEY CLUSTERED 
(
	[RespuestaCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Revaluacion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Revaluacion](
	[Revaluacion] [int] IDENTITY(1,1) NOT NULL,
	[Cliente] [int] NULL,
	[Mes] [int] NULL,
	[Anyo] [int] NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Activo] [smallint] NULL,
	[TieneCita] [smallint] NULL,
	[Responsable] [int] NULL,
	[CitadoPor] [int] NULL,
	[FechaCreado] [datetime] NULL,
	[HoraCreado] [datetime] NULL,
	[Doctor] [int] NULL,
	[TipoRevaluacion] [int] NULL,
	[FechaCitadoPor] [datetime] NULL,
	[HoraCitadoPor] [datetime] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Revaluacion_Revaluacion] PRIMARY KEY CLUSTERED 
(
	[Revaluacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[roles]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[roles](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[rol] [varchar](30) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_roles] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SelDoctor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SelDoctor](
	[SelDoctor] [int] IDENTITY(1,1) NOT NULL,
	[Terminal] [int] NULL,
	[Doctor] [int] NULL,
	[Seleccion] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_SelDoctor_SelDoctor] PRIMARY KEY CLUSTERED 
(
	[SelDoctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SelUsuario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SelUsuario](
	[SelUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Terminal] [int] NULL,
	[Usuario] [int] NULL,
	[Seleccion] [smallint] NULL,
 CONSTRAINT [PK_SelUsuario] PRIMARY KEY CLUSTERED 
(
	[SelUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServerIndex]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerIndex](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Tipo] [int] NULL,
	[TipoDes] [nvarchar](50) NULL,
	[Clave1] [int] NULL,
	[Clave2] [int] NULL,
	[Long1] [int] NULL,
	[Long2] [int] NULL,
	[Double1] [float] NULL,
	[Double2] [float] NULL,
	[Texto1] [nvarchar](255) NULL,
	[Texto2] [nvarchar](255) NULL,
	[Fecha1] [datetime] NULL,
	[Fecha2] [datetime] NULL,
	[Hora1] [datetime] NULL,
	[Hora2] [datetime] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_ServerIndex_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Servicio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servicio](
	[Servicio] [int] NOT NULL,
	[Area] [int] NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Costo] [float] NULL,
	[Brackets] [smallint] NULL,
	[Activo] [smallint] NULL,
	[Especial] [smallint] NULL,
	[OldService] [smallint] NULL,
	[Registros] [smallint] NULL,
	[Retenedores] [smallint] NULL,
	[CreadoPor] [int] NULL,
	[FechaCreado] [datetime] NULL,
	[EsNuevo] [smallint] NULL,
	[EliminadoPor] [int] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Servicio_Servicio] PRIMARY KEY CLUSTERED 
(
	[Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sesion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sesion](
	[Sesion] [int] NOT NULL,
	[Cliente] [int] NULL,
	[Serie] [nvarchar](50) NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Observaciones] [nvarchar](255) NULL,
	[TipoSerie] [int] NULL,
	[TipoSesion] [int] NULL,
	[FechaDesbloqueado] [datetime] NULL,
	[HoraDesbloqueado] [datetime] NULL,
	[DesbloqueadoPor] [int] NULL,
	[Foto1] [nvarchar](255) NULL,
	[Foto2] [nvarchar](255) NULL,
	[Foto3] [nvarchar](255) NULL,
	[Foto4] [nvarchar](255) NULL,
	[Foto5] [nvarchar](255) NULL,
	[Foto6] [nvarchar](255) NULL,
	[Foto7] [nvarchar](255) NULL,
	[Foto8] [nvarchar](255) NULL,
	[Foto9] [nvarchar](255) NULL,
	[Foto10] [nvarchar](255) NULL,
	[Foto11] [nvarchar](255) NULL,
	[Foto12] [nvarchar](255) NULL,
	[Foto13] [nvarchar](255) NULL,
	[Foto14] [nvarchar](255) NULL,
	[Foto15] [nvarchar](255) NULL,
	[Foto16] [nvarchar](255) NULL,
	[Foto17] [nvarchar](255) NULL,
	[Foto18] [nvarchar](255) NULL,
	[Foto19] [nvarchar](255) NULL,
	[Foto20] [nvarchar](255) NULL,
	[Foto21] [nvarchar](255) NULL,
	[Foto22] [nvarchar](255) NULL,
	[Foto23] [nvarchar](255) NULL,
	[Foto24] [nvarchar](255) NULL,
	[Foto25] [nvarchar](255) NULL,
	[Foto26] [nvarchar](255) NULL,
	[Foto27] [nvarchar](255) NULL,
	[Foto28] [nvarchar](255) NULL,
	[Foto29] [nvarchar](255) NULL,
	[Foto30] [nvarchar](255) NULL,
	[Foto31] [nvarchar](255) NULL,
	[Foto32] [nvarchar](255) NULL,
	[Grabado] [smallint] NULL,
	[Activo] [smallint] NULL,
	[SerieCompleta] [smallint] NULL,
	[Tit1] [nvarchar](30) NULL,
	[Tit2] [nvarchar](30) NULL,
	[Tit3] [nvarchar](30) NULL,
	[Tit4] [nvarchar](30) NULL,
	[Tit5] [nvarchar](30) NULL,
	[Tit6] [nvarchar](30) NULL,
	[Tit7] [nvarchar](30) NULL,
	[Tit8] [nvarchar](30) NULL,
	[Tit9] [nvarchar](30) NULL,
	[Tit10] [nvarchar](30) NULL,
	[Tit11] [nvarchar](30) NULL,
	[Tit12] [nvarchar](30) NULL,
	[Tit13] [nvarchar](30) NULL,
	[Tit14] [nvarchar](30) NULL,
	[Tit15] [nvarchar](30) NULL,
	[Tit16] [nvarchar](30) NULL,
	[Tit17] [nvarchar](30) NULL,
	[Tit18] [nvarchar](30) NULL,
	[Tit19] [nvarchar](30) NULL,
	[Tit20] [nvarchar](30) NULL,
	[Tit21] [nvarchar](30) NULL,
	[Tit22] [nvarchar](30) NULL,
	[Tit23] [nvarchar](30) NULL,
	[Tit24] [nvarchar](30) NULL,
	[Tit25] [nvarchar](30) NULL,
	[Tit26] [nvarchar](30) NULL,
	[Tit27] [nvarchar](30) NULL,
	[Tit28] [nvarchar](30) NULL,
	[Tit29] [nvarchar](30) NULL,
	[Tit30] [nvarchar](30) NULL,
	[Tit31] [nvarchar](30) NULL,
	[Tit32] [nvarchar](30) NULL,
	[Temporal] [nvarchar](255) NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_Sesion_Sesion] PRIMARY KEY CLUSTERED 
(
	[Sesion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sillon]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sillon](
	[Sillon] [nvarchar](1) NOT NULL,
	[Area] [int] NOT NULL,
	[Color] [int] NULL,
	[DoctorExclusivo] [int] NULL,
	[GenVersion] [int] NULL,
	[Titulo] [nvarchar](50) NULL,
	[Mostrar] [smallint] NOT NULL,
 CONSTRAINT [PK_Sillon_SillonArea] PRIMARY KEY CLUSTERED 
(
	[Sillon] ASC,
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tCobrosAgenda]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCobrosAgenda](
	[Fecha] [datetime] NOT NULL,
	[Hora] [datetime] NOT NULL,
	[Area] [int] NOT NULL,
	[Sillon] [nvarchar](1) NOT NULL,
	[Terminal] [int] NOT NULL,
	[Cliente] [int] NULL,
	[Cumplida] [int] NULL,
	[Nombre] [nvarchar](250) NULL,
	[TipoTx] [nvarchar](50) NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
	[Des] [nvarchar](20) NULL,
	[Des1] [nvarchar](20) NULL,
	[Des2] [nvarchar](20) NULL,
	[Des3] [nvarchar](20) NULL,
	[Des4] [nvarchar](20) NULL,
	[Des5] [nvarchar](20) NULL,
	[Monto1] [float] NULL,
	[Monto2] [float] NULL,
 CONSTRAINT [PK_tCobrosAgenda_FechaHoraAreaSillonTerminal] PRIMARY KEY CLUSTERED 
(
	[Fecha] ASC,
	[Hora] ASC,
	[Area] ASC,
	[Sillon] ASC,
	[Terminal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Temp]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temp](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Long01] [int] NULL,
	[Long02] [int] NULL,
	[Long03] [int] NULL,
	[Double01] [float] NULL,
	[Double02] [float] NULL,
	[Texto01] [nvarchar](255) NULL,
	[Texto02] [nvarchar](255) NULL,
	[Texto03] [nvarchar](255) NULL,
	[GenVersion] [int] NULL,
	[Terminal] [int] NULL,
	[Fecha1] [datetime] NULL,
	[Fecha2] [datetime] NULL,
	[Fecha3] [datetime] NULL,
	[Fecha4] [datetime] NULL,
	[Hora1] [datetime] NULL,
	[Hora2] [datetime] NULL,
	[Hora3] [datetime] NULL,
	[Hora4] [datetime] NULL,
 CONSTRAINT [PK_Temp_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TempArchivo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempArchivo](
	[TempArchivo] [int] IDENTITY(1,1) NOT NULL,
	[Cliente] [int] NULL,
	[Archivo] [nvarchar](20) NULL,
	[FechaTran] [datetime] NULL,
	[HoraTran] [datetime] NULL,
	[Updated] [smallint] NULL,
	[HoraUpd] [datetime] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TempArchivo_TempArchivo] PRIMARY KEY CLUSTERED 
(
	[TempArchivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TerminalParametro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TerminalParametro](
	[Terminal] [int] NOT NULL,
	[TParametro] [nvarchar](50) NOT NULL,
	[Valor] [nvarchar](50) NULL,
	[ValorN] [real] NULL,
 CONSTRAINT [PK_TerminalParametro] PRIMARY KEY CLUSTERED 
(
	[Terminal] ASC,
	[TParametro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Termino]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Termino](
	[Termino] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Abreviado] [nvarchar](50) NULL,
	[Mostrar] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Termino_Termino] PRIMARY KEY CLUSTERED 
(
	[Termino] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoCheque]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCheque](
	[TipoCheque] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Activo] [tinyint] NOT NULL,
 CONSTRAINT [PK_TipoCheque] PRIMARY KEY CLUSTERED 
(
	[TipoCheque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoCita]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCita](
	[TipoCita] [int] NOT NULL,
	[Descripcion] [nvarchar](100) NULL,
	[Activo] [smallint] NULL,
	[Especial] [smallint] NULL,
	[EliminarAparato] [smallint] NULL,
	[Retenedor] [smallint] NULL,
	[Resaltar] [smallint] NULL,
	[ParaFotos] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoCita_TipoCita] PRIMARY KEY CLUSTERED 
(
	[TipoCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoCitaEspecial]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCitaEspecial](
	[TipoCitaEspecial] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoCitaEspecial_TipoCitaEspecial] PRIMARY KEY CLUSTERED 
(
	[TipoCitaEspecial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoCitaEspecial_TipoCita]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCitaEspecial_TipoCita](
	[TipoCita] [int] NOT NULL,
	[TipoCitaEspecial] [int] NOT NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoCitaEspecial_TipoCita_TipoCitaTipoCitaEspecial] PRIMARY KEY CLUSTERED 
(
	[TipoCita] ASC,
	[TipoCitaEspecial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoCitaExcepcion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCitaExcepcion](
	[TipoCitaExcepcion] [int] IDENTITY(1,1) NOT NULL,
	[TipoCita] [int] NULL,
 CONSTRAINT [PK_TipoCitaExcepcion] PRIMARY KEY CLUSTERED 
(
	[TipoCitaExcepcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoCliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCliente](
	[TipoCliente] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoCliente_TipoCliente] PRIMARY KEY CLUSTERED 
(
	[TipoCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoCobro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCobro](
	[TipoCobro] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Especial] [smallint] NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoCobro_TipoCobro] PRIMARY KEY CLUSTERED 
(
	[TipoCobro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoComando]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoComando](
	[TipoComando] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoComando_TipoComando] PRIMARY KEY CLUSTERED 
(
	[TipoComando] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoEmpleado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoEmpleado](
	[TipoEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[EsMesero] [smallint] NULL,
	[SueldoBase] [float] NULL,
	[Bonificacion] [float] NULL,
	[SueldoHora] [float] NULL,
	[SueldoHoraFeriado] [float] NULL,
	[SueldoHoraExtra] [float] NULL,
	[HorasDiarias] [float] NULL,
	[EsSueldoBase] [smallint] NULL,
	[EsSueldoHora] [smallint] NULL,
	[Orden] [int] NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoEmpleado_TipoEmpleado] PRIMARY KEY CLUSTERED 
(
	[TipoEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoExtra]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoExtra](
	[TipoExtra] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Factor] [int] NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoExtra_TipoExtra] PRIMARY KEY CLUSTERED 
(
	[TipoExtra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoFechaEspecial]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoFechaEspecial](
	[TipoFechaEspecial] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Titulo] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoFechaEspecial_TipoFechaEspecial] PRIMARY KEY CLUSTERED 
(
	[TipoFechaEspecial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoGasto]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoGasto](
	[TipoGasto] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoGasto_TipoGasto] PRIMARY KEY CLUSTERED 
(
	[TipoGasto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoHorario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoHorario](
	[TipoHorario] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[DiaIni] [int] NULL,
	[MesIni] [int] NULL,
	[DiaFin] [int] NULL,
	[MesFin] [int] NULL,
	[Especial] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoHorario_TipoHorario] PRIMARY KEY CLUSTERED 
(
	[TipoHorario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoMovimientoProducto]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovimientoProducto](
	[TipoMovimientoProducto] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoMovimientoProducto_TipoMovimientoProducto] PRIMARY KEY CLUSTERED 
(
	[TipoMovimientoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoPlanilla]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoPlanilla](
	[TipoPlanilla] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoPlanilla_TipoPlanilla] PRIMARY KEY CLUSTERED 
(
	[TipoPlanilla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoRefOtro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoRefOtro](
	[TipoRefOtro] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoRefOtro_TipoRefOtro] PRIMARY KEY CLUSTERED 
(
	[TipoRefOtro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoRevaluacion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoRevaluacion](
	[TipoRevaluacion] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Area] [int] NULL,
	[TipoCita] [int] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoRevaluacion_TipoRevaluacion] PRIMARY KEY CLUSTERED 
(
	[TipoRevaluacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoSesion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoSesion](
	[TipoSesion] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[NumFotos] [int] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoSesion_TipoSesion] PRIMARY KEY CLUSTERED 
(
	[TipoSesion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoSesionFotos]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoSesionFotos](
	[TipoSesionFotos] [int] IDENTITY(1,1) NOT NULL,
	[TipoSesion] [int] NULL,
	[NumFoto] [int] NULL,
	[Orden] [int] NULL,
	[Sup] [float] NULL,
	[Izq] [float] NULL,
	[Ancho] [float] NULL,
	[Alto] [float] NULL,
	[Titulo] [nvarchar](50) NULL,
	[FlipH] [smallint] NULL,
	[FlipV] [smallint] NULL,
	[FlipD] [smallint] NULL,
	[FlipI] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoSesionFotos_TipoSesionFotos] PRIMARY KEY CLUSTERED 
(
	[TipoSesionFotos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoTratamiento]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoTratamiento](
	[TipoTratamiento] [int] NOT NULL,
	[Area] [int] NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Especial] [smallint] NULL,
	[Activo] [smallint] NULL,
	[CreadoPor] [int] NULL,
	[EliminadoPor] [int] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoTratamiento_TipoTratamiento] PRIMARY KEY CLUSTERED 
(
	[TipoTratamiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoUsuario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoUsuario](
	[TipoUsuario] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[DBA] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoUsuario_TipoUsuario] PRIMARY KEY CLUSTERED 
(
	[TipoUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoUsuario Comando]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoUsuario Comando](
	[TipoUsuario] [int] NOT NULL,
	[Comando] [int] NOT NULL,
	[Seleccion] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TipoUsuario_Comando_TipoUsuarioComando] PRIMARY KEY CLUSTERED 
(
	[TipoUsuario] ASC,
	[Comando] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TParametro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TParametro](
	[TParametro] [nvarchar](50) NOT NULL,
	[Tipo] [nvarchar](12) NULL,
	[ValorDef] [nvarchar](255) NULL,
	[EsImpresora] [smallint] NULL,
	[EsArchivo] [smallint] NULL,
	[EsCarpeta] [smallint] NULL,
	[Menu] [int] NULL,
	[TParametroDes] [nvarchar](50) NULL,
	[Orden] [int] NULL,
 CONSTRAINT [PK_TParametro] PRIMARY KEY CLUSTERED 
(
	[TParametro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Trabajo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trabajo](
	[Trabajo] [int] NOT NULL,
	[Laboratorio] [int] NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Cliente] [int] NULL,
	[Doctor] [int] NULL,
	[Costo] [float] NULL,
	[Estado] [int] NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Cheque] [int] NULL,
	[Activo] [smallint] NULL,
	[Responsable] [int] NULL,
	[Ingresado] [smallint] NULL,
	[DebloqueadoPor] [int] NULL,
	[FechaDesbloqueado] [datetime] NULL,
	[HoraDesbloqueado] [datetime] NULL,
	[EliminadoPor] [int] NULL,
	[FechaEliminado] [datetime] NULL,
	[HoraEliminado] [datetime] NULL,
	[Seleccion] [int] NULL,
	[NumFactura] [nvarchar](20) NULL,
	[PreSeleccion] [smallint] NULL,
	[ClavePago] [int] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
	[NumDoc] [nvarchar](50) NULL,
	[ClavePagoConceptoCh] [int] NULL,
	[EsClavePago] [smallint] NULL,
	[ListoParaCheque] [smallint] NULL,
 CONSTRAINT [PK_Trabajo_Trabajo] PRIMARY KEY CLUSTERED 
(
	[Trabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transaccion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaccion](
	[Transaccion] [int] IDENTITY(1,1) NOT NULL,
	[Permiso] [nvarchar](50) NULL,
	[Usuario] [int] NULL,
	[Ejecutor] [int] NULL,
	[Descripcion] [nvarchar](250) NULL,
	[Fecha] [datetime] NULL,
	[Hora] [datetime] NULL,
	[Monto] [float] NULL,
	[Ref1] [int] NULL,
	[Ref2] [int] NULL,
	[Ref3] [int] NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
	[HoraVal] [int] NULL,
 CONSTRAINT [PK_Transaccion_Transaccion] PRIMARY KEY CLUSTERED 
(
	[Transaccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tratamiento]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tratamiento](
	[Tratamiento] [int] NOT NULL,
	[Area] [int] NOT NULL,
	[Cliente] [int] NULL,
	[Doctor] [int] NULL,
	[Fecha] [datetime] NULL,
	[Finalizacion] [datetime] NULL,
	[Costo] [float] NULL,
	[Descuento] [float] NULL,
	[Facturado] [smallint] NULL,
	[Total] [float] NULL,
	[ProxVisita] [datetime] NULL,
	[PagoInicial] [float] NULL,
	[NumCuotas] [float] NULL,
	[MontoCuota] [float] NULL,
	[Retenedores] [float] NULL,
	[Registros] [int] NULL,
	[Activo] [smallint] NULL,
	[Bloqueado] [smallint] NULL,
	[TipoTratamiento] [int] NULL,
	[Descripcion] [nvarchar](255) NULL,
	[OldSystem] [smallint] NULL,
	[Responsable] [int] NULL,
	[EliminadoPor] [int] NULL,
	[FechaIngreso] [datetime] NULL,
	[HoraIngreso] [datetime] NULL,
	[DesbloqueadoPor] [int] NULL,
	[PreguntarFacturado] [smallint] NULL,
	[EsAparato] [smallint] NULL,
	[PagoFinal] [float] NULL,
	[CatalogoTratamiento] [int] NULL,
	[Terminado] [smallint] NULL,
	[TerminadoPor] [int] NULL,
	[TerminadoFecha] [datetime] NULL,
	[TerminadoHora] [datetime] NULL,
	[Resumen] [nvarchar](max) NULL,
	[GenVersion] [int] NULL,
	[FechaVal] [int] NULL,
 CONSTRAINT [PK_Tratamiento_TratamientoArea] PRIMARY KEY CLUSTERED 
(
	[Tratamiento] ASC,
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TratamientoRef]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TratamientoRef](
	[TratamientoRef] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Activo] [smallint] NULL,
	[Responsable] [int] NULL,
	[EsNuevo] [smallint] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_TratamientoRef_TratamientoRef] PRIMARY KEY CLUSTERED 
(
	[TratamientoRef] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](30) NULL,
	[Password] [nvarchar](12) NULL,
	[TipoUsuario] [int] NULL,
	[Recepcionista] [smallint] NULL,
	[Activo] [smallint] NULL,
	[GenVersion] [int] NULL,
	[MaxRegistros] [int] NULL,
 CONSTRAINT [PK_Usuario_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UsuarioBodega]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioBodega](
	[Usuario] [int] NOT NULL,
	[Bodega] [int] NOT NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_UsuarioBodega_UsuarioBodega] PRIMARY KEY CLUSTERED 
(
	[Usuario] ASC,
	[Bodega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usuarios](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[usuario] [varchar](50) NOT NULL,
	[password] [varchar](300) NOT NULL,
	[rol] [varchar](50) NOT NULL,
	[fechaIngreso] [datetime] NOT NULL,
 CONSTRAINT [PK_usuarios] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios Grafica temp]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios Grafica temp](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Terminal] [int] NULL,
	[Titulo] [nvarchar](200) NULL,
	[EjeY] [nvarchar](50) NULL,
	[Valor] [float] NULL,
	[Descripcion] [nvarchar](100) NULL,
	[TextoValor] [nvarchar](150) NULL,
	[Max] [float] NULL,
	[GenVersion] [int] NULL,
 CONSTRAINT [PK_Usuarios_Grafica_temp_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WSComando]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WSComando](
	[Comando] [int] NOT NULL,
	[Panel] [int] NULL,
	[TipoComando] [int] NULL,
	[ComandoDes] [nvarchar](50) NULL,
	[Argumento1] [nvarchar](50) NULL,
	[Argumento2] [nvarchar](50) NULL,
	[Configurable] [smallint] NOT NULL,
	[Activo] [smallint] NOT NULL,
 CONSTRAINT [PK_WSComando] PRIMARY KEY CLUSTERED 
(
	[Comando] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WSPanel]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WSPanel](
	[Panel] [int] NOT NULL,
	[PanelDes] [nvarchar](50) NULL,
	[Activo] [smallint] NOT NULL,
 CONSTRAINT [PK_WSPanel] PRIMARY KEY CLUSTERED 
(
	[Panel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WSTipoUsuarioComando]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WSTipoUsuarioComando](
	[TipoUsuario] [int] NOT NULL,
	[Comando] [int] NOT NULL,
	[Seleccion] [smallint] NOT NULL,
 CONSTRAINT [PK_WSTipoUsuarioComando] PRIMARY KEY CLUSTERED 
(
	[TipoUsuario] ASC,
	[Comando] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[GR INICIARON TX]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GR INICIARON TX] AS
SELECT Min(Cobro.Fecha) AS MínDeFecha,Min(Cobro.FechaVal) as FechaVal, Cliente.Cliente, Min(Cliente.Nombre) AS PrimeroDeNombre, Min(Cliente.Direccion) AS PrimeroDeDireccion, Min(Cliente.Telefono) AS PrimeroDeTelefono
FROM (Cliente INNER JOIN Cobro ON Cliente.Cliente=Cobro.Cliente) LEFT JOIN (Tratamiento LEFT JOIN CatalogoTratamiento ON Tratamiento.CatalogoTratamiento=CatalogoTratamiento.CatalogoTratamiento) ON Cobro.Tratamiento=Tratamiento.Tratamiento
WHERE Cliente.Activo<>0 
And Cobro.Activo<>0 
And Cobro.Ingresado<>0
And Cobro.Pendiente=0 
And Cobro.TipoCobro=1 
And Cobro.Area=1
And Cobro.FaseTratamiento=-10 
And Cliente.TipoCliente>=0 
And Cobro.Fecha Is Not Null
And coalesce(CatalogoTratamiento.MostrarReportes,1)<>0
GROUP BY Cliente.Cliente

GO
/****** Object:  View [dbo].[GR TERMINARON TX]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GR TERMINARON TX] AS
SELECT Cliente.Cliente, Cliente.Nombre, Cliente.Direccion, Cliente.Telefono, Tratamiento.TerminadoFecha,
Year(Tratamiento.TerminadoFecha)*500+Month(Tratamiento.TerminadoFecha)*32+day(Tratamiento.TerminadoFecha) as FechaVal
FROM (Cliente INNER JOIN Tratamiento ON Cliente.Cliente=Tratamiento.Cliente) LEFT JOIN CatalogoTratamiento ON Tratamiento.CatalogoTratamiento=CatalogoTratamiento.CatalogoTratamiento
WHERE Cliente.Activo<>0 
And Tratamiento.Area=1 
And Tratamiento.Terminado<>0 
And Tratamiento.Activo<>0 
And Tratamiento.Bloqueado<>0 
And Cliente.TipoCliente>=0 
And COALESCE(CatalogoTratamiento.MostrarReportes,1)<>0

GO
/****** Object:  View [dbo].[GR TRATAMIENTOS]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[GR TRATAMIENTOS] as
SELECT [GR INICIARON TX].MínDeFecha AS FECHA, [GR INICIARON TX].Cliente, [GR INICIARON TX].PrimeroDeNombre AS NOMBRE, [GR INICIARON TX].PrimeroDeDireccion AS DIRECCION, [GR INICIARON TX].PrimeroDeTelefono AS TELEFONO, 'INICIARON TRATAMIENTO' AS TIPODES, 1 AS TIPO, 1 AS VALOR, FechaVal
FROM [GR INICIARON TX]
UNION ALL
SELECT [GIT].MínDeFecha AS FECHA, [GIT].Cliente, [GIT].PrimeroDeNombre AS NOMBRE, [GIT].PrimeroDeDireccion AS DIRECCION, [GIT].PrimeroDeTelefono AS TELEFONO, 'INICIARON TRATAMIENTO' AS TIPODES, 2 AS TIPO, 0 AS VALOR, FechaVal
FROM [GR INICIARON TX] GIT
UNION ALL 
SELECT [GR TERMINARON TX].TerminadoFecha, [GR TERMINARON TX].Cliente, [GR TERMINARON TX].Nombre, [GR TERMINARON TX].Direccion, [GR TERMINARON TX].Telefono, 'TERMINARON TRATAMIENTO' AS Expr1, 2 AS EXP2, 1 AS VALOR, FechaVal
FROM [GR TERMINARON TX]
UNION ALL 
SELECT [GTT].TerminadoFecha, [GTT].Cliente, [GTT].Nombre, [GTT].Direccion, [GTT].Telefono, 'TERMINARON TRATAMIENTO' AS Expr1, 1 AS EXP2, 0 AS VALOR, FechaVal
FROM [GR TERMINARON TX] GTT

GO
/****** Object:  View [dbo].[GR INICIARON TX18]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GR INICIARON TX18] AS
SELECT Min(Cobro.Fecha) AS MínDeFecha, Min(Cobro.FechaVal) as FechaVal,  Cliente.Cliente, Min(Cliente.Nombre) AS PrimeroDeNombre, Min(Cliente.Direccion) AS PrimeroDeDireccion, Min(Cliente.Telefono) AS PrimeroDeTelefono
FROM (Cliente INNER JOIN Cobro ON Cliente.Cliente=Cobro.Cliente) LEFT JOIN (Tratamiento LEFT JOIN CatalogoTratamiento ON Tratamiento.CatalogoTratamiento=CatalogoTratamiento.CatalogoTratamiento) ON Cobro.Tratamiento=Tratamiento.Tratamiento
WHERE Cliente.Activo<>0 
And Cobro.Activo<>0 
And Cobro.Ingresado<>0
And Cobro.Pendiente=0 
And Cobro.TipoCobro=1 
And Cobro.Area=1
And Cobro.FaseTratamiento=-10 
And Cliente.TipoCliente=-1 
And Cobro.Fecha Is Not Null
And coalesce(CatalogoTratamiento.MostrarReportes,1)<>0
GROUP BY Cliente.Cliente

GO
/****** Object:  View [dbo].[GR TERMINARON TX18]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GR TERMINARON TX18] AS
SELECT Cliente.Cliente, Cliente.Nombre, Cliente.Direccion, Cliente.Telefono, Tratamiento.TerminadoFecha, 
Year(Tratamiento.TerminadoFecha)*500+Month(Tratamiento.TerminadoFecha)*32+day(Tratamiento.TerminadoFecha) as FechaVal
FROM (Cliente INNER JOIN Tratamiento ON Cliente.Cliente=Tratamiento.Cliente) LEFT JOIN CatalogoTratamiento ON Tratamiento.CatalogoTratamiento=CatalogoTratamiento.CatalogoTratamiento
WHERE Cliente.Activo<>0 
And Tratamiento.Area=1 
And Tratamiento.Terminado<>0 
And Tratamiento.Activo<>0 
And Tratamiento.Bloqueado<>0 
And Cliente.TipoCliente=-1 
And COALESCE(CatalogoTratamiento.MostrarReportes,1)<>0

GO
/****** Object:  View [dbo].[GR TRATAMIENTOS18]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[GR TRATAMIENTOS18] as
SELECT MínDeFecha AS FECHA, Cliente, PrimeroDeNombre AS NOMBRE, PrimeroDeDireccion AS DIRECCION, [GR INICIARON TX18].PrimeroDeTelefono AS TELEFONO, 'INICIARON TRATAMIENTO' AS TIPODES, 1 AS TIPO, 1 AS VALOR, FechaVal
FROM [GR INICIARON TX18]
UNION ALL
SELECT [GIT].MínDeFecha AS FECHA, [GIT].Cliente, [GIT].PrimeroDeNombre AS NOMBRE, [GIT].PrimeroDeDireccion AS DIRECCION, [GIT].PrimeroDeTelefono AS TELEFONO, 'INICIARON TRATAMIENTO' AS TIPODES, 2 AS TIPO, 0 AS VALOR, FechaVal
FROM [GR INICIARON TX18] GIT
UNION ALL 
SELECT [GR TERMINARON TX18].TerminadoFecha, [GR TERMINARON TX18].Cliente, [GR TERMINARON TX18].Nombre, [GR TERMINARON TX18].Direccion, [GR TERMINARON TX18].Telefono, 'TERMINARON TRATAMIENTO' AS Expr1, 2 AS EXP2, 1 AS VALOR, FechaVal
FROM [GR TERMINARON TX18]
UNION ALL 
SELECT [GTT].TerminadoFecha, [GTT].Cliente, [GTT].Nombre, [GTT].Direccion, [GTT].Telefono, 'TERMINARON TRATAMIENTO' AS Expr1, 1 AS EXP2, 0 AS VALOR, FechaVal
FROM [GR TERMINARON TX18] GTT

GO
/****** Object:  View [dbo].[CUOTASTEMP]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CUOTASTEMP] AS
SELECT Cobro.Cliente as Cliente, [EFECTIVO]+[CHEQUE] AS Monto, Count(Cobro.Cobro) AS Cantidad
FROM Cobro
WHERE Cobro.Cliente is not null and Cobro.FaseTratamiento>=1 And Cobro.FaseTratamiento<=13 AND Cobro.Activo=1 AND Cobro.Ingresado=1 AND Cobro.Pendiente=0
GROUP BY Cobro.Cliente, [EFECTIVO]+[CHEQUE]

GO
/****** Object:  View [dbo].[REP_CUOTAS_CLIENTES]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[REP_CUOTAS_CLIENTES] AS
SELECT RCC1.*
FROM CUOTASTEMP AS RCC1
WHERE NOT EXISTS( 
SELECT RCC2.* 
FROM [CUOTASTEMP] AS RCC2 
WHERE RCC1.CLIENTE=RCC2.CLIENTE
AND RCC2.CANTIDAD>RCC1.CANTIDAD 
)

GO
/****** Object:  View [dbo].[WSTipoUsuarioPermisoAux]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[WSTipoUsuarioPermisoAux]
AS
SELECT     dbo.TipoUsuario.TipoUsuario, dbo.Permiso.Permiso
FROM         dbo.TipoUsuario CROSS JOIN
                      dbo.Permiso

GO
/****** Object:  View [dbo].[WSFillAcreditacion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[WSFillAcreditacion]
AS
SELECT     dbo.WSTipoUsuarioPermisoAux.TipoUsuario, dbo.WSTipoUsuarioPermisoAux.Permiso
FROM         dbo.WSTipoUsuarioPermisoAux LEFT OUTER JOIN
                      dbo.Acreditacion ON dbo.WSTipoUsuarioPermisoAux.Permiso = dbo.Acreditacion.Permiso AND 
                      dbo.WSTipoUsuarioPermisoAux.TipoUsuario = dbo.Acreditacion.TipoUsuario
WHERE     (dbo.Acreditacion.TipoUsuario IS NULL)

GO
/****** Object:  View [dbo].[WSTipoUsuarioComandoAux]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[WSTipoUsuarioComandoAux]
AS
SELECT     dbo.TipoUsuario.TipoUsuario, dbo.WSComando.Comando
FROM         dbo.TipoUsuario CROSS JOIN
                      dbo.WSComando

GO
/****** Object:  View [dbo].[WSFillTipoUsuarioComando]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[WSFillTipoUsuarioComando]
AS
SELECT     dbo.WSTipoUsuarioComandoAux.TipoUsuario, dbo.WSTipoUsuarioComandoAux.Comando
FROM         dbo.WSTipoUsuarioComandoAux LEFT OUTER JOIN
                      dbo.WSTipoUsuarioComando ON dbo.WSTipoUsuarioComandoAux.TipoUsuario = dbo.WSTipoUsuarioComando.TipoUsuario AND 
                      dbo.WSTipoUsuarioComandoAux.Comando = dbo.WSTipoUsuarioComando.Comando
WHERE     (dbo.WSTipoUsuarioComando.TipoUsuario IS NULL)

GO
/****** Object:  View [dbo].[TxSaldo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***************** TxSaldo *******************************/
CREATE VIEW [dbo].[TxSaldo] AS
SELECT Tratamiento.Tratamiento, min(Tratamiento.Cliente) as Cliente, min(Tratamiento.Fecha) as Fecha,
min(Tratamiento.Costo) as Costo, min(Tratamiento.facturado) as Facturado, min(Tratamiento.PagoInicial) as PagoInicial,
min(Tratamiento.NumCuotas) as NumCuotas, min(Tratamiento.MontoCuota) as MontoCuota, min(Tratamiento.Retenedores) as Retenedores,
min(Tratamiento.Registros) as Registros, min(Tratamiento.PagoFinal) as PagoFinal, min(Tratamiento.CatalogoTratamiento) as CatalogoTratamiento,
min(Tratamiento.EsAparato) as EsAparato, min(Tratamiento.Terminado) as Terminado,
MIN(Tratamiento.Area) as AREA,
CASE WHEN Max(coalesce(Tratamiento.Costo,0))-Sum(Cobro.Efectivo+Cobro.Cheque)>0 then Max(coalesce(Tratamiento.Costo,0))-Sum(Cobro.Efectivo+Cobro.Cheque) else 0 END AS SALDO,
Sum(Cobro.Efectivo+Cobro.Cheque) AS ABONADO
FROM Tratamiento INNER JOIN Cobro ON (Tratamiento.Cliente = Cobro.Cliente) AND (Tratamiento.Tratamiento = Cobro.Tratamiento)
Where Tratamiento.Activo <> 0 And Tratamiento.Bloqueado <> 0 And Cobro.Ingresado <> 0 And Cobro.Activo <> 0 And Cobro.Pendiente = 0
GROUP BY Tratamiento.Tratamiento

GO
/****** Object:  View [dbo].[TxSaldoCliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*********************************************************/


/****************** TxSaldoCliente ************************/
CREATE VIEW [dbo].[TxSaldoCliente] as
SELECT MIN(Cliente) as Cliente, SUM(COALESCE(SALDO,0)) AS SALDO,
Min(Tratamiento) as TratamientoMin,
Max(Tratamiento) as TratamientoMax
FROM TxSaldo
Group By Cliente

GO
/****** Object:  View [dbo].[MovimientoProductoDetalleTOT]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[MovimientoProductoDetalleTOT] AS
SELECT MovimientoProductoDetalle.Producto, MovimientoProductoDetalle.Ingreso, MovimientoProductoDetalle.Salida, 1 AS TIPOOR, MovimientoProducto.TipoMovimientoProducto AS ID0, MovimientoProducto.MovimientoProducto, MovimientoProductoDetalle.MovimientoProductoDetalle AS IDDET, MovimientoProducto.Fecha, MovimientoProducto.Vale AS TRANS, MovimientoProducto.Usuario AS USERID, MovimientoProducto.Cliente, MovimientoProducto.Hora, MovimientoProducto.FechaVal
FROM MovimientoProducto INNER JOIN MovimientoProductoDetalle ON MovimientoProducto.MovimientoProducto = MovimientoProductoDetalle.MovimientoProducto
WHERE MovimientoProductoDetalle.Contar<>0 AND MovimientoProductoDetalle.Activo<>0 AND MovimientoProducto.Activo<>0 AND MovimientoProducto.Ingresado<>0
UNION ALL
SELECT Cobro.Producto, 0 AS Ingreso, Cobro.Cantidad AS Salida, 2 AS TIPOOR, Null AS ID0, Null AS MovimientoProducto, Cobro.Cobro AS IDDET, Cobro.Fecha, Cobro.Cobro AS TRANS, Cobro.Responsable AS USERID, Cobro.Cliente, Cobro.Hora, Cobro.FechaVal 
FROM Cobro
WHERE Cobro.Producto Is Not Null AND Cobro.Activo<>0 AND Cobro.Ingresado<>0 AND Cobro.Contar<>0


GO
/****** Object:  View [dbo].[INVENTARIO]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[INVENTARIO] AS
SELECT Producto.*, 
coalesce([TOTIN],0) AS [IN], 
coalesce([TOTOUT],0) AS OUT, 
coalesce([EXISTENCIA],0) AS EXISTENCIAACTUAL
FROM Producto LEFT JOIN (
	SELECT MovimientoProductoDetalleTOT.Producto, Sum(MovimientoProductoDetalleTOT.Ingreso) AS TOTIN, Sum(MovimientoProductoDetalleTOT.Salida) AS TOTOUT, Sum([Ingreso]-[Salida]) AS EXISTENCIA
	FROM MovimientoProductoDetalleTOT
	GROUP BY MovimientoProductoDetalleTOT.Producto
) as INVENTARIO00 ON Producto.Producto = INVENTARIO00.Producto
WHERE Producto.Activo<>0








GO
/****** Object:  View [dbo].[ParamFecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**** VIEWS DE PARAMS *************/
create View [dbo].[ParamFecha] as 
select Min(PFecha1) as ValFechaIni, Max(PFecha2) as ValFechaFin from Param
GO
/****** Object:  View [dbo].[REP COBROS]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*************** REP COBROS *************************/
CREATE VIEW [dbo].[REP COBROS] AS
SELECT Cobro.*,TipoCobro.Descripcion AS TIPOCOBRODES, Doctor.Nombre AS DOCTORDES, 
Cobro.Descripcion AS CORRESPONDES, 
COALESCE(Banco.Nombre,'')+ CASE WHEN len(ltrim(rtrim(coalesce(NumCheque,''))))>0 then ' #'+coalesce(numcheque,'') ELSE ''  END
+CASE WHEN coalesce(Cobro.NumFactura,0)>0 then ' (Fact. '+coalesce(FacturaSerie,'')+ltrim(str(NumFactura))+')' ELSE '' END AS REFCHEQUEDES, 
COALESCE([Efectivo],0)+COALESCE([Cheque],0) AS TOT, 
Cliente.Nombre AS CLIENTEDES, Usuario.Nombre AS RESP, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Cheque,0)  END AS VNINGRESO,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0.00  END AS VNINGRESOTARJ,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END AS LIQUIDO ,
CASE WHEN (Cobro.HoraVal>=50400) then 2 else 1 END AS MT, 
CASE WHEN (DATEPART(WEEKDAY,Cobro.Fecha)-1)=0 THEN 1 ELSE DATEPART(WEEKDAY,Cobro.Fecha)-0 END AS diasem, 
Doctor.Utilidad, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (coalesce(Doctor.Utilidad ,0)/100.00) AS BRUTOCLINICA,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (1-(coalesce(Doctor.Utilidad ,0)/100.00)) AS BRUTODOCTOR,
Banco.Nombre AS BANCODES, 
Cliente.Archivo, Banco.EsTarjeta,
CASE WHEN Banco.EsTarjeta<>0 then ([VisaNetReal]/1.12)*(Banco.ComisionTarjeta/100.00) Else 0 END as VNCOMISION,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS VNNETO,
CASE WHEN Banco.Grupo=1 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS VISANET,
CASE WHEN Banco.Grupo=2 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS CREDOMATIC,
CASE WHEN Banco.Grupo=3 then COALESCE(Cheque,0) ELSE 0 END AS BIONLINE,
CASE WHEN Banco.Grupo=0 then COALESCE(Cheque,0) ELSE 0 END AS SOLOCHEQUE,
CASE WHEN Banco.Grupo=1 then COALESCE(VisanetReal,0) ELSE 0 END AS VISANET2,
CASE WHEN Banco.Grupo=2 then COALESCE(VisanetReal,0) ELSE 0 END AS CREDOMATIC2,
CASE WHEN Banco.EsTarjeta<>0 then COALESCE(VisanetReal,0) ELSE coalesce(Cobro.Cheque,0)  END AS VNINGRESOREAL,
Banco.Grupo,
Producto.Descripcion as ProductoDes
FROM Banco RIGHT JOIN (FaseTratamiento RIGHT JOIN (TipoCobro INNER JOIN (((Usuario RIGHT JOIN ((( (select Cobro.* from Cobro,ParamFecha where Cobro.FechaVal>=ParamFecha.ValFechaIni and Cobro.FechaVal<=ParamFecha.ValFechaFin) as Cobro LEFT JOIN Doctor ON Cobro.Doctor=Doctor.Doctor) LEFT JOIN Servicio ON Cobro.Servicio=Servicio.Servicio) LEFT JOIN Cliente ON Cobro.Cliente=Cliente.Cliente) ON Usuario.Id=Cobro.Responsable) LEFT JOIN Cargo ON Cobro.Cargo=Cargo.Cargo) LEFT JOIN Producto ON Cobro.Producto=Producto.Producto) ON TipoCobro.TipoCobro=Cobro.TipoCobro) ON FaseTratamiento.FaseTratamiento=Cobro.FaseTratamiento) ON Banco.Banco=Cobro.Banco
WHERE Cobro.Activo<>0 AND Cobro.Ingresado<>0 AND Cobro.Pendiente=0




GO
/****** Object:  View [dbo].[ParamCliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ParamCliente] AS
select Cliente
from param
Where Cliente is not null
group by Cliente
GO
/****** Object:  View [dbo].[REP COBROS CLIENTE]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/**************************************************/


/*************** REP COBROS CLIENTE *************************/
CREATE VIEW [dbo].[REP COBROS CLIENTE] AS
SELECT Cobro.*,TipoCobro.Descripcion AS TIPOCOBRODES, Doctor.Nombre AS DOCTORDES, 
Cobro.Descripcion AS CORRESPONDES, 
COALESCE(Banco.Nombre,'')+ CASE WHEN len(ltrim(rtrim(coalesce(NumCheque,''))))>0 then ' #'+coalesce(numcheque,'') ELSE ''  END
+CASE WHEN coalesce(Cobro.NumFactura,0)>0 then ' (Fact. '+coalesce(FacturaSerie,'')+ltrim(str(NumFactura))+')' ELSE '' END AS REFCHEQUEDES, 
COALESCE([Efectivo],0)+COALESCE([Cheque],0) AS TOT, 
Cliente.Nombre AS CLIENTEDES, Usuario.Nombre AS RESP, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Cheque,0)  END AS VNINGRESO,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0.00  END AS VNINGRESOTARJ,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END AS LIQUIDO ,
CASE WHEN (Cobro.HoraVal>=50400) then 2 else 1 END AS MT, 
CASE WHEN (DATEPART(WEEKDAY,Cobro.Fecha)-1)=0 THEN 1 ELSE DATEPART(WEEKDAY,Cobro.Fecha)-0 END AS diasem, 
Doctor.Utilidad, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (coalesce(Doctor.Utilidad ,0)/100.00) AS BRUTOCLINICA,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (1-(coalesce(Doctor.Utilidad ,0)/100.00)) AS BRUTODOCTOR,
Banco.Nombre AS BANCODES, 
Cliente.Archivo, Banco.EsTarjeta,
CASE WHEN Banco.EsTarjeta<>0 then ([VisaNetReal]/1.12)*(Banco.ComisionTarjeta/100.00) Else 0 END as VNCOMISION,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS VNNETO,
CASE WHEN Banco.Grupo=1 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS VISANET,
CASE WHEN Banco.Grupo=2 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS CREDOMATIC,
CASE WHEN Banco.Grupo=3 then COALESCE(Cheque,0) ELSE 0 END AS BIONLINE,
CASE WHEN Banco.Grupo=0 then COALESCE(Cheque,0) ELSE 0 END AS SOLOCHEQUE,
CASE WHEN Banco.Grupo=1 then COALESCE(VisanetReal,0) ELSE 0 END AS VISANET2,
CASE WHEN Banco.Grupo=2 then COALESCE(VisanetReal,0) ELSE 0 END AS CREDOMATIC2,
CASE WHEN Banco.EsTarjeta<>0 then COALESCE(VisanetReal,0) ELSE coalesce(Cobro.Cheque,0)  END AS VNINGRESOREAL,
Banco.Grupo,
Producto.Descripcion as ProductoDes
FROM Banco RIGHT JOIN (FaseTratamiento RIGHT JOIN (TipoCobro INNER JOIN (((Usuario RIGHT JOIN ((( (select Cobro.* from Cobro inner join ParamCliente on Cobro.Cliente=ParamCliente.Cliente) as Cobro LEFT JOIN Doctor ON Cobro.Doctor=Doctor.Doctor) LEFT JOIN Servicio ON Cobro.Servicio=Servicio.Servicio) LEFT JOIN Cliente ON Cobro.Cliente=Cliente.Cliente) ON Usuario.Id=Cobro.Responsable) LEFT JOIN Cargo ON Cobro.Cargo=Cargo.Cargo) LEFT JOIN Producto ON Cobro.Producto=Producto.Producto) ON TipoCobro.TipoCobro=Cobro.TipoCobro) ON FaseTratamiento.FaseTratamiento=Cobro.FaseTratamiento) ON Banco.Banco=Cobro.Banco
WHERE Cobro.Activo<>0 AND Cobro.Ingresado<>0 AND Cobro.Pendiente=0


GO
/****** Object:  View [dbo].[CobroActivo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[CobroActivo] as
SELECT Cobro.*, Servicio.Brackets, Servicio.Registros, Servicio.Retenedores
FROM Cobro LEFT JOIN Servicio ON Cobro.Servicio = Servicio.Servicio
WHERE Cobro.Activo<>0 AND Cobro.Ingresado<>0 and Cobro.pendiente=0


GO
/****** Object:  View [dbo].[CLIENTES ACTIVOS]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CLIENTES ACTIVOS] AS
SELECT Cliente.*
FROM Cliente
WHERE Cliente.Activo<>0
AND Cliente.TipoCliente>=0
AND Exists (
     SELECT CA1.Cobro
     FROM CobroActivo CA1
     WHERE CA1.FaseTratamiento=-10
     AND CA1.Cliente=Cliente.Cliente
) 
AND NOT Exists (
     SELECT CA2.Cobro
     FROM CobroActivo CA2
     WHERE CA2.Retenedores<>0
     AND CA2.Cliente=Cliente.Cliente
)
AND Exists (
     SELECT CA3.Cobro
     FROM CobroActivo CA3
     WHERE CA3.Fecha>=dateadd(month,-3,Getdate())
     AND CA3.Cliente=Cliente.Cliente
)


GO
/****** Object:  View [dbo].[CLIENTES SOLO REGISTROS]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CLIENTES SOLO REGISTROS] AS
SELECT Cliente.*
FROM Cliente
WHERE Cliente.Activo<>0
AND Cliente.TipoCliente>=0
AND EXISTS(
SELECT CA1.Cobro
FROM CobroActivo CA1
WHERE CA1.Registros<>0
AND CA1.Cliente=Cliente.Cliente
)
AND NOT EXISTS(
SELECT CA2.Cobro
FROM CobroActivo CA2
WHERE CA2.FaseTratamiento=-10
AND CA2.Cliente=Cliente.Cliente
)


GO
/****** Object:  View [dbo].[PorCitar]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[PorCitar] AS
SELECT Cita.*
FROM Cita
WHERE year(FechaRecontactar)*500+month(FechaRecontactar)*32+day(FechaRecontactar)<year(GetDate())*500+month(GetDate())*32+day(GetDate()) 
And coalesce(cita.respuesta,-1)=3 
AND ABS(coalesce(Cita.Cumplida,0))<>1
And Cita.Contactar=1
GO
/****** Object:  View [dbo].[COMPROBAR PORCITAR]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [dbo].[COMPROBAR PORCITAR] AS
SELECT PorCitar.*, Cliente.Nombre AS CLIENTEDES, Cliente.Telefono AS CLIENTETEL, CASE WHEN Bloqueada = 1 THEN '(HORA BLOQUEADA)' ELSE COALESCE (TipoCita.Descripcion, '') END AS TIPOCITADES, Doctor.Nombre AS DOCTORDES, CASE WHEN Bloqueada = 1 THEN COALESCE (BloqDes, '(HORA BLOQUEADA)') ELSE Cliente.Nombre END AS DES, CASE WHEN Bloqueada = 1 THEN COALESCE (BloqTel, '') ELSE Cliente.Telefono END AS TEL, CASE WHEN Cumplida = 5 THEN 'CANCELO' ELSE '' END AS CANCELODES, Area.Descripcion AS AREADES, Usuario.Nombre AS [ USER], 1 AS RCFALTANTES, DATEDIFF(YEAR,CLIENTE.FechaNac,getdate()) AS EDADCLIENTE, Cliente.FechaNac
FROM (((Doctor
RIGHT JOIN (Cliente
RIGHT JOIN (AREA
INNER JOIN PorCitar ON Area.Area=PorCitar.Area) ON Cliente.Cliente=PorCitar.Cliente) ON Doctor.Doctor=PorCitar.Doctor)
LEFT JOIN TipoCita ON PorCitar.TipoCita=TipoCita.TipoCita)
LEFT JOIN RespuestaCita ON PorCitar.Respuesta=RespuestaCita.RespuestaCita)
LEFT JOIN Usuario ON PorCitar.Responsable=Usuario.Id
WHERE COALESCE(PorCitar.Respuesta,3)=3
AND EXISTS(
	Select *
	From Cita
	where cita.FechaVal>PorCitar.FechaVal
	And cita.Cliente=PorCitar.Cliente
)

GO
/****** Object:  View [dbo].[CLIENTES TIENEN APARATOS]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CLIENTES TIENEN APARATOS] AS
SELECT Cliente.*
FROM Cliente
WHERE Cliente.Activo<>0
AND Cliente.TipoCliente>=0
AND Exists (
     SELECT CA1.Cobro
     FROM CobroActivo CA1
     WHERE CA1.FaseTratamiento=-20
     AND CA1.Cliente=Cliente.Cliente
) 
AND NOT Exists (
     SELECT CA1.Cobro
     FROM CobroActivo CA1
     WHERE CA1.FaseTratamiento=-19
     AND CA1.Cliente=Cliente.Cliente
)


GO
/****** Object:  View [dbo].[REP CHEQUES]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[REP CHEQUES] AS
SELECT Cheque.FechaVal,Cheque.Cheque, Cheque.Fecha, Cheque.NumCheque, Cheque.Referencia, Cheque.Monto, 
coalesce(ConceptoCheque.Descripcion,'(SIN CONCEPTO)') AS CONCEPTO, 
coalesce(Proveedor.Nombre,'(SIN PROVEEDOR)') AS PROVEEDOR, Cheque.Monto AS LIQUIDO, Cheque.ConceptoCheque,
coalesce(TipoCheque.Descripcion,'')+' '+coalesce(Cheque.NumCheque   ,'') AS NumChequeDes
FROM Cheque
LEFT JOIN ConceptoCheque ON ConceptoCheque.ConceptoCheque = Cheque.ConceptoCheque
LEFT JOIN Proveedor ON Proveedor.Proveedor = Cheque.Proveedor
LEFT JOIN TipoCheque ON Cheque.TipoCheque =TipoCheque.TipoCheque  
WHERE Cheque.Ingresado<>0 AND Cheque.Activo<>0


GO
/****** Object:  View [dbo].[REP COBROS FULL]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*************** REP COBROS FULL*************************/
CREATE VIEW [dbo].[REP COBROS FULL] AS
SELECT Cobro.*,TipoCobro.Descripcion AS TIPOCOBRODES, Doctor.Nombre AS DOCTORDES, 
Cobro.Descripcion AS CORRESPONDES, 
COALESCE(Banco.Nombre,'')+ CASE WHEN len(ltrim(rtrim(coalesce(NumCheque,''))))>0 then ' #'+coalesce(numcheque,'') ELSE '' END
+CASE WHEN coalesce(Cobro.NumFactura,0)>0 then ' (Fact. '+coalesce(FacturaSerie,'')+ltrim(str(NumFactura))+')' ELSE '' END AS REFCHEQUEDES, 
COALESCE([Efectivo],0)+COALESCE([Cheque],0) AS TOT, 
Cliente.Nombre AS CLIENTEDES, Usuario.Nombre AS RESP, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Cheque,0)  END AS VNINGRESO,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0.00  END AS VNINGRESOTARJ,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END AS LIQUIDO ,
CASE WHEN (Cobro.HoraVal>=50400) then 2 else 1 END AS MT, 
CASE WHEN (DATEPART(WEEKDAY,Cobro.Fecha)-1)=0 THEN 1 ELSE DATEPART(WEEKDAY,Cobro.Fecha)-0 END AS diasem, 
Doctor.Utilidad, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (coalesce(Doctor.Utilidad ,0)/100.00) AS BRUTOCLINICA,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (1-(coalesce(Doctor.Utilidad ,0)/100.00)) AS BRUTODOCTOR,
Banco.Nombre AS BANCODES, 
Cliente.Archivo,Banco.EsTarjeta,
CASE WHEN Banco.EsTarjeta<>0 then ([VisaNetReal]/1.12)*(Banco.ComisionTarjeta/100.00) Else 0 END as VNCOMISION,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS VNNETO,
CASE WHEN Banco.Grupo=1 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS VISANET,
CASE WHEN Banco.Grupo=2 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS CREDOMATIC,
CASE WHEN Banco.Grupo=3 then COALESCE(Cheque,0) ELSE 0 END AS BIONLINE,
CASE WHEN Banco.Grupo=0 then COALESCE(Cheque,0) ELSE 0 END AS SOLOCHEQUE,
CASE WHEN Banco.Grupo=1 then COALESCE(VisanetReal,0) ELSE 0 END AS VISANET2,
CASE WHEN Banco.Grupo=2 then COALESCE(VisanetReal,0) ELSE 0 END AS CREDOMATIC2,
CASE WHEN Banco.EsTarjeta<>0 then COALESCE(VisanetReal,0) ELSE coalesce(Cobro.Cheque,0)  END AS VNINGRESOREAL,
Banco.Grupo,
Producto.Descripcion as ProductoDes
FROM Banco RIGHT JOIN (FaseTratamiento RIGHT JOIN (TipoCobro INNER JOIN (((Usuario RIGHT JOIN ((( Cobro LEFT JOIN Doctor ON Cobro.Doctor=Doctor.Doctor) LEFT JOIN Servicio ON Cobro.Servicio=Servicio.Servicio) LEFT JOIN Cliente ON Cobro.Cliente=Cliente.Cliente) ON Usuario.Id=Cobro.Responsable) LEFT JOIN Cargo ON Cobro.Cargo=Cargo.Cargo) LEFT JOIN Producto ON Cobro.Producto=Producto.Producto) ON TipoCobro.TipoCobro=Cobro.TipoCobro) ON FaseTratamiento.FaseTratamiento=Cobro.FaseTratamiento) ON Banco.Banco=Cobro.Banco
WHERE Cobro.Activo<>0 AND Cobro.Ingresado<>0 AND Cobro.Pendiente=0



GO
/****** Object:  View [dbo].[LIQUIDACION]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[LIQUIDACION] AS
SELECT Fecha, Efectivo, Cheque, TOT,LIQUIDO, 1 AS TIPO, Cobro, FechaVal
FROM [REP COBROS FULL]
UNION ALL 
SELECT [REP CHEQUES].Fecha, 0 AS Efectivo, 0 AS Cheque, [REP CHEQUES].Monto as TOT, [REP CHEQUES].Monto *(-1) as LIQUIDO, -1 AS TIPO,[REP Cheques].Cheque AS Cobro, FechaVal
FROM [REP CHEQUES]

GO
/****** Object:  View [dbo].[AgendaHoy]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[AgendaHoy] as
SELECT right('00'+CONVERT(varchar,DATEPART(hour,Cita.Hora)),2)+':'+right('00'+CONVERT(varchar,DATEPART(minute,Cita.Hora)),2) AS MiHora, coalesce(Cliente.Nombre,'') + ' (' + coalesce(Cliente.Archivo,'') + ')' AS ClienteDes, Doctor.Nombre AS DoctorDes, TipoCita.Descripcion AS Tx, Cliente.Telefono, Cita.Area
FROM Cita 
INNER JOIN Cliente ON Cliente.Cliente = Cita.Cliente
LEFT JOIN Doctor ON Doctor.Doctor = Cita.Doctor
LEFT JOIN TipoCita ON TipoCita.TipoCita = Cita.TipoCita
WHERE Cita.FechaVal=Year(GETDate())*500+Month(GETDATE())*32+Day(GETDATE())
GO
/****** Object:  View [dbo].[ArchID Disponibles]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE View [dbo].[ArchID Disponibles] as 
select max(ArchID)+1 as ArchID
From Cliente
Where ArchID is not null
and ArchID<34000
AND Not Exists(
	Select *
	From Cliente C2
	Where C2.ArchId=Cliente.ArchId+1
)






GO
/****** Object:  View [dbo].[Citastemp]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[Citastemp] as
Select *
from cita
Where FechaVal>=1006893
GO
/****** Object:  View [dbo].[COBROS APARATOS PI]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[COBROS APARATOS PI] AS 
SELECT Cobro.*
FROM Cobro
WHERE Cobro.Area=1
AND Cobro.FaseTratamiento=-20
AND Cobro.Activo<>0
AND Cobro.Ingresado<>0
AND Cobro.Pendiente=0



GO
/****** Object:  View [dbo].[COBROS CLIENTE FECHAS]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[COBROS CLIENTE FECHAS] AS
SELECT Cobro.Cliente, Sum([EFECTIVO]+[CHEQUE]) AS TOT, 
Sum(case WHEN COALESCE(DOCTOR,-1)=1 THEN coalesce([EFECTIVO],0)+coalesce([CHEQUE],0) ELSE 0 END) AS TOTORTO, 
Sum(case WHEN COALESCE(DOCTOR,-1)<>1 THEN coalesce([EFECTIVO],0)+coalesce([CHEQUE],0) ELSE 0 END) AS TOTODON
FROM Cobro
WHERE Cobro.Ingresado=1 AND Cobro.Activo=1 AND Cobro.Pendiente=0
GROUP BY Cobro.Cliente


GO
/****** Object:  View [dbo].[COBROS REGISTROS]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[COBROS REGISTROS] AS 
SELECT Cobro.*
FROM Cobro INNER JOIN Servicio ON Cobro.Servicio = Servicio.Servicio
WHERE Cobro.Area=1 AND Cobro.Activo<>0 AND Cobro.Ingresado<>0 AND Servicio.Registros<>0 and Cobro.Pendiente=0

GO
/****** Object:  View [dbo].[COBROS RETENEDORES]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[COBROS RETENEDORES] AS
SELECT Cobro.Cliente, Max(Cobro.Fecha) AS MáxDeFecha
FROM Cobro INNER JOIN Servicio ON Cobro.Servicio = Servicio.Servicio
WHERE Cobro.Activo<>0 AND Servicio.Retenedores<>0 AND Cobro.Ingresado<>0 and Cobro.Pendiente=0
GROUP BY Cobro.Cliente


GO
/****** Object:  View [dbo].[DispArchID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/******* CREANDO LA VISTA *******************/
CREATE View [dbo].[DispArchID] as 
select max(ArchID)+1 as ArchID
From Cliente
Where ArchID is not null
and ArchID<34000
AND Not Exists(
	Select *
	From Cliente C2
	Where C2.ArchId=Cliente.ArchId+1
)





GO
/****** Object:  View [dbo].[FACTURA RESUMEN]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/************** FACTURA CLIENTE TOT ****************/
CREATE VIEW [dbo].[FACTURA RESUMEN] AS
SELECT FacturaCliente.Cobro, Sum(FacturaCliente.Monto) AS TOTAL
FROM FacturaCliente
WHERE FacturaCliente.Activo=1
AND Cobro is not null
GROUP BY FacturaCliente.Cobro

GO
/****** Object:  View [dbo].[FaltasSeguidas]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FaltasSeguidas] AS
Select Cita.Cliente as Cliente, Count(Fecha) as FaltasSeguidas
From Cita inner join
(
	Select Cliente, coalesce(Max(CASE WHEN Abs(Cumplida)=1 THEN Fecha ELSE 0 END),0) as UltimaCitaAsistio
	From Cita
	Where year(Fecha)*500+month(Fecha)*32+day(Fecha)<year(GetDate())*500+month(GetDate())*32+day(GetDate()) 
	group by Cliente
) as UltAsis on UltAsis.Cliente=Cita.Cliente
Where (year(Fecha)*500+month(Fecha)*32+day(Fecha))>(year(UltimaCitaAsistio)*500+month(UltimaCitaAsistio)*32+day(UltimaCitaAsistio))
and Abs(Cita.Cumplida)<>1
Group By Cita.Cliente
GO
/****** Object:  View [dbo].[FECHA ULTIMO COBRO]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[FECHA ULTIMO COBRO] AS
SELECT Cobro.Cliente, Max(Cobro.Fecha) AS MáxDeFecha
FROM Cobro
WHERE Cobro.Activo<>0 AND Cobro.Ingresado<>0 AND Cobro.Pendiente =0
GROUP BY Cobro.Cliente


GO
/****** Object:  View [dbo].[FixTipoCita]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FixTipoCita] AS
SELECT min(TipoCita) as TipoCita,Descripcion, Count(TipoCita) as Cuenta
FROM tipocita 
Where Activo=1
group by Descripcion
GO
/****** Object:  View [dbo].[IMPRIMIR REFERENCIA]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IMPRIMIR REFERENCIA] as
SELECT Referencia.Referencia, Referencia.Fecha, DoctorRef.Nombre AS DOCTORREFDES, Cliente.Nombre AS PACIENTE,  
coalesce(Doctor.Titulo,'')+' '+ coalesce(Doctor.Nombre,'') AS DOCTORDES, 
Referencia.Observaciones, REFDETALLE.TRATAMIENTODES, REFDETALLE.PIEZADES, REFDETALLE.TratamientoRef, REFDETALLE.Pieza, 
case when Len(coalesce([Observaciones],''))<2 then '' else 'Observaciones:' end AS OBSETI
FROM DoctorRef
RIGHT JOIN (((Referencia
LEFT JOIN Doctor ON Referencia.Doctor=Doctor.Doctor)
LEFT JOIN Cliente ON Referencia.Cliente=Cliente.Cliente)
LEFT JOIN (
		SELECT REFDETALLESUB.TRATAMIENTODES, 
		CASE WHEN Especial<>0 THEN PIEZA ELSE '' END + ' ' + COALESCE(Descripcion1,'') AS PIEZADES, 
		REFDETALLESUB.TratamientoRef, REFDETALLESUB2.Pieza, REFDETALLESUB2.Descripcion1, REFDETALLESUB.Referencia
		FROM (
				SELECT TratamientoRef.Descripcion AS TRATAMIENTODES, ReferenciaDetalle.Referencia, ReferenciaDetalle.TratamientoRef
				FROM TratamientoRef INNER JOIN ReferenciaDetalle ON TratamientoRef.TratamientoRef = ReferenciaDetalle.TratamientoRef
		) as REFDETALLESUB 
		LEFT JOIN (
				SELECT ReferenciaPieza.Referencia, ReferenciaPieza.TratamientoRef, ReferenciaPieza.Pieza, Pieza.Descripcion1, Pieza.Especial
				FROM Pieza INNER JOIN ReferenciaPieza ON Pieza.Pieza = ReferenciaPieza.Pieza	
		) AS REFDETALLESUB2 ON (REFDETALLESUB.Referencia = REFDETALLESUB2.Referencia) AND (REFDETALLESUB.TratamientoRef = REFDETALLESUB2.TratamientoRef)
		
) as REFDETALLE ON Referencia.Referencia=REFDETALLE.Referencia) ON DoctorRef.DoctorRef=Referencia.DoctorRef
GO
/****** Object:  View [dbo].[LISTASERVICIOS]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[LISTASERVICIOS] AS
Select Area.Descripcion as AREADES,Servicio.Descripcion as Servicio, Servicio.Costo 
from Servicio 
inner join Area on Servicio.Area =Area.Area 
Where Activo <> 0 


GO
/****** Object:  View [dbo].[PRIMER COBRO]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[PRIMER COBRO] AS
SELECT Cobro.Cliente, Min(Cobro.Fecha) AS PRIMERCOBRO, Min(Cobro.FechaVal) as PRIMERCOBROVAL
FROM Cobro
WHERE Cobro.Ingresado=1 AND Cobro.Activo=1 AND Cobro.Pendiente=0
GROUP BY Cobro.Cliente

GO
/****** Object:  View [dbo].[REP CHEQUES TOT]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*********************************************************/


CREATE VIEW [dbo].[REP CHEQUES TOT] AS
SELECT Cheque.Cheque, Cheque.Fecha, Cheque.NumCheque, Cheque.Referencia, Cheque.Monto, ConceptoCheque.Descripcion AS CONCEPTO, Proveedor.Nombre AS PROVEEDOR, Cheque.Monto AS LIQUIDO, 
CASE WHEN Anulado<>0 THEN 'ANULADO' ELSE 'AUTORIZADO' END AS STATUSCHEQUE, 
CASE WHEN ISNUMERIC(NumCheque)<>0 THEN CAST(NumCheque as float) else 0 END AS VALORNUMCHEQUE,
coalesce(TipoCheque.Descripcion,'')+' '+coalesce(Cheque.NumCheque   ,'') AS NumChequeDes
FROM Cheque
LEFT JOIN ConceptoCheque ON ConceptoCheque.ConceptoCheque = Cheque.ConceptoCheque
LEFT JOIN Proveedor ON Proveedor.Proveedor = Cheque.Proveedor
LEFT JOIN TipoCheque ON Cheque.TipoCheque =TipoCheque.TipoCheque  
WHERE (Ingresado<>0 Or Anulado<>0) AND Cheque.Activo<>0


GO
/****** Object:  View [dbo].[REP COBROS PENDIENTES]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************** REP COBROS PENDIENTES*************************/
CREATE VIEW [dbo].[REP COBROS PENDIENTES] AS
SELECT Cobro.*,TipoCobro.Descripcion AS TIPOCOBRODES, Doctor.Nombre AS DOCTORDES, 
Cobro.Descripcion AS CORRESPONDES, 
COALESCE(Banco.Nombre,'')+ CASE WHEN len(ltrim(rtrim(coalesce(NumCheque,''))))>0 then ' #'+coalesce(numcheque,'') END
+CASE WHEN coalesce(Cobro.NumFactura,0)>0 then ' (Fact. '+coalesce(FacturaSerie,'')+ltrim(str(NumFactura))+')' ELSE '' END AS REFCHEQUEDES, 
COALESCE([Efectivo],0)+COALESCE([Cheque],0) AS TOT, 
Cliente.Nombre AS CLIENTEDES, Usuario.Nombre AS RESP, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Cheque,0)  END AS VNINGRESO,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0.00  END AS VNINGRESOTARJ,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END AS LIQUIDO ,
CASE WHEN (Cobro.HoraVal>=50400) then 2 else 1 END AS MT, 
CASE WHEN (DATEPART(WEEKDAY,Cobro.Fecha)-1)=0 THEN 7 ELSE DATEPART(WEEKDAY,Cobro.Fecha)-1 END AS diasem, 
Doctor.Utilidad, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (coalesce(Doctor.Utilidad ,0)/100.00) AS BRUTOCLINICA,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (1-(coalesce(Doctor.Utilidad ,0)/100.00)) AS BRUTODOCTOR,
Banco.Nombre AS BANCODES, 
Cliente.Archivo,Banco.EsTarjeta,
CASE WHEN Banco.EsTarjeta<>0 then ([VisaNetReal]/1.12)*(Banco.ComisionTarjeta/100.00) Else 0 END as VNCOMISION,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS VNNETO,
CASE WHEN Banco.Grupo=1 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS VISANET,
CASE WHEN Banco.Grupo=2 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0 END AS CREDOMATIC,
CASE WHEN Banco.Grupo=3 then COALESCE(Cheque,0) ELSE 0 END AS BIONLINE,
CASE WHEN Banco.Grupo=0 then COALESCE(Cheque,0) ELSE 0 END AS SOLOCHEQUE,
CASE WHEN Banco.Grupo=1 then COALESCE(VisanetReal,0) ELSE 0 END AS VISANET2,
CASE WHEN Banco.Grupo=2 then COALESCE(VisanetReal,0) ELSE 0 END AS CREDOMATIC2,
Banco.Grupo,
Producto.Descripcion as ProductoDes
FROM Banco RIGHT JOIN (FaseTratamiento RIGHT JOIN (TipoCobro INNER JOIN (((Usuario RIGHT JOIN ((( Cobro LEFT JOIN Doctor ON Cobro.Doctor=Doctor.Doctor) LEFT JOIN Servicio ON Cobro.Servicio=Servicio.Servicio) LEFT JOIN Cliente ON Cobro.Cliente=Cliente.Cliente) ON Usuario.Id=Cobro.Responsable) LEFT JOIN Cargo ON Cobro.Cargo=Cargo.Cargo) LEFT JOIN Producto ON Cobro.Producto=Producto.Producto) ON TipoCobro.TipoCobro=Cobro.TipoCobro) ON FaseTratamiento.FaseTratamiento=Cobro.FaseTratamiento) ON Banco.Banco=Cobro.Banco
WHERE Cobro.Activo<>0 AND Cobro.Ingresado<>0 AND Cobro.Pendiente<>0

GO
/****** Object:  View [dbo].[REP COBROS RECHAZADO]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************** REP COBROS RECHAZADO*************************/
CREATE VIEW [dbo].[REP COBROS RECHAZADO] AS
SELECT Cobro.*,TipoCobro.Descripcion AS TIPOCOBRODES, Doctor.Nombre AS DOCTORDES, 
Cobro.Descripcion AS CORRESPONDES, 
COALESCE(Banco.Nombre,'')+ CASE WHEN len(ltrim(rtrim(NumCheque)))>0 then ' #'+numcheque ELSE '' END
+CASE WHEN coalesce(Cobro.NumFactura,0)>0 then ' (Fact. '+coalesce(FacturaSerie,'')+ltrim(str(NumFactura))+')' END AS REFCHEQUEDES, 
COALESCE([Efectivo],0)+COALESCE([Cheque],0) AS TOT, 
Cliente.Nombre AS CLIENTEDES, Usuario.Nombre AS RESP, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Cheque,0)  END AS VNINGRESO,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE 0.00  END AS VNINGRESOTARJ,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END AS LIQUIDO ,
CASE WHEN (Cobro.HoraVal>=50400) then 2 else 1 END AS MT, 
CASE WHEN (DATEPART(WEEKDAY,Cobro.Fecha)-1)=0 THEN 7 ELSE DATEPART(WEEKDAY,Cobro.Fecha)-1 END AS diasem, 
Doctor.Utilidad, 
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (coalesce(Doctor.Utilidad ,0)/100.00) AS BRUTOCLINICA,
CASE WHEN Banco.EsTarjeta<>0 then (COALESCE([Efectivo],0)+COALESCE(VisanetReal,0)*(1.00-((coalesce(Banco.ComisionTarjeta,0)+(45.00/28.00) )/100.00)) ) ELSE coalesce(Cobro.Efectivo,0)+coalesce(Cobro.Cheque,0)  END * (1-(coalesce(Doctor.Utilidad ,0)/100.00)) AS BRUTODOCTOR,
CASE WHEN Banco.EsTarjeta<>0 then COALESCE(VisanetReal,0) ELSE coalesce(Cobro.Cheque,0)  END AS VNINGRESOREAL,
Banco.Nombre AS BANCODES, 
Cliente.Archivo
FROM Banco RIGHT JOIN (FaseTratamiento RIGHT JOIN (TipoCobro INNER JOIN (((Usuario RIGHT JOIN ((( Cobro LEFT JOIN Doctor ON Cobro.Doctor=Doctor.Doctor) LEFT JOIN Servicio ON Cobro.Servicio=Servicio.Servicio) LEFT JOIN Cliente ON Cobro.Cliente=Cliente.Cliente) ON Usuario.Id=Cobro.Responsable) LEFT JOIN Cargo ON Cobro.Cargo=Cargo.Cargo) LEFT JOIN Producto ON Cobro.Producto=Producto.Producto) ON TipoCobro.TipoCobro=Cobro.TipoCobro) ON FaseTratamiento.FaseTratamiento=Cobro.FaseTratamiento) ON Banco.Banco=Cobro.Banco
WHERE Cobro.Activo<>0 AND Cobro.Ingresado<>0 AND Cobro.FechaRechazado is not null

GO
/****** Object:  View [dbo].[SMSCONTACTOS]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**************************************************/


/*********************** SMSCONTACTO ****************/
CREATE VIEW [dbo].[SMSCONTACTOS] AS
SELECT MAX(SMSCel) as CELULAR, MAX(left(Cliente.Nombre ,29)) as NOMBRE
FROM Cita 	INNER JOIN Cliente ON Cita.Cliente = Cliente.Cliente 
				INNER JOIN Param ON Cita.FechaVal = Param.PFecha1
Where Param.Terminal =-1
AND Cita.Area <>90
AND len(SMSCel)>7
group by Cliente.Cliente

GO
/****** Object:  View [dbo].[SMSMensaje01]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/************ SMS MENSAJE01 ************************/
CREATE VIEW [dbo].[SMSMensaje01] as
select Texto01 as CELULAR, Texto03 as MENSAJE 
from TEMP 
Where Terminal=-1
And len(Texto03)>1
GO
/****** Object:  View [dbo].[tBorrarla]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[tBorrarla] as
Select *
from Cobro
Where Cobro=384407
GO
/****** Object:  View [dbo].[tFixFechaValTablas]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[tFixFechaValTablas] as
SELECT TABLE_NAME AS Tabla, 
MAX(CASE WHEN COLUMN_NAME='FechaVal' THEN 1 ELSE 0 END) AS TieneFechaVal,
MAX(CASE WHEN COLUMN_NAME='HoraVal' THEN 1 ELSE 0 END) AS TieneHoraVal
FROM INFORMATION_SCHEMA.COLUMNS
INNER JOIN 
		(SELECT name as Tabla
		FROM "OD"."sys"."objects"
		WHERE "type" IN ('U')) AS SoloTablas ON INFORMATION_SCHEMA.COLUMNS.TABLE_NAME=SoloTablas.Tabla
WHERE TABLE_CATALOG='OD' 
AND COLUMN_NAME='FechaVal'
OR  COLUMN_NAME='HoraVal'
group by TABLE_NAME



GO
/****** Object:  View [dbo].[TipoCitaRepetidos]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TipoCitaRepetidos] AS
select Min(TipoCita) as TipoCita, Descripcion,Count(TipoCita) as Cuenta
from TipoCita
Where Activo<>0
group by Descripcion
having Count(TipoCita)>1

GO
/****** Object:  View [dbo].[TxActivo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*********************************************************/

/********************** TX ACTIVO *************************/
CREATE VIEW [dbo].[TxActivo] as
SELECT Tratamiento.Tratamiento, min(Tratamiento.Cliente) as Cliente, min(Tratamiento.Fecha) as Fecha,
min(Tratamiento.Costo) as Costo, min(Tratamiento.facturado) as Facturado, min(Tratamiento.PagoInicial) as PagoInicial,
min(Tratamiento.NumCuotas) as NumCuotas, min(Tratamiento.MontoCuota) as MontoCuota, min(Tratamiento.Retenedores) as Retenedores,
min(Tratamiento.Registros) as Registros, min(Tratamiento.PagoFinal) as PagoFinal, min(Tratamiento.CatalogoTratamiento) as CatalogoTratamiento,
min(Tratamiento.EsAparato) as EsAparato, min(Tratamiento.Terminado) as Terminado,
MIN(Tratamiento.Area) as AREA,
CASE WHEN Max(coalesce(Tratamiento.Costo,0))-Sum(Cobro.Efectivo+Cobro.Cheque)>0 then Max(coalesce(Tratamiento.Costo,0))-Sum(Cobro.Efectivo+Cobro.Cheque) else 0 END AS SALDO,
Sum(Cobro.Efectivo+Cobro.Cheque) AS ABONADO
FROM Tratamiento INNER JOIN Cobro ON (Tratamiento.Cliente = Cobro.Cliente) AND (Tratamiento.Tratamiento = Cobro.Tratamiento)
INNER JOIN (
	SELECT Tratamiento.Cliente, Max(Tratamiento) as Tratamiento
	From Tratamiento
	Where Activo <> 0 And Bloqueado <> 0 and Terminado=0
	group by Tratamiento.Cliente
) as UltTx On Tratamiento.Tratamiento=UltTx.Tratamiento
Where Tratamiento.Activo <> 0 And Tratamiento.Bloqueado <> 0 And Cobro.Ingresado <> 0 And Cobro.Activo <> 0 And Cobro.Pendiente = 0
GROUP BY Tratamiento.Tratamiento

GO
/****** Object:  View [dbo].[ULTIMA CITA]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ULTIMA CITA] AS
SELECT Max(Cita.Fecha) AS FECHA, Cita.Cliente
FROM Cita
WHERE Cita.Cumplida<>0
GROUP BY Cita.Cliente

GO
/****** Object:  View [dbo].[VerClaseFotos]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VerClaseFotos] AS
SELECT Cliente.ClaseFotos, Min(ClaseFotos.Descripcion) as Descripcion
from cliente
inner join ClaseFotos on Cliente.ClaseFotos =ClaseFotos.ClaseFotos
Where Cliente.Activo<>0
and Cliente.ClaseFotos is not null
and ClaseFotos.Activo<>0
group by Cliente.ClaseFotos

GO
/****** Object:  View [dbo].[VerClavePago]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VerClavePago] AS
Select Cheque.Cheque as ID,  ClavePago,  'CH' as Tipo
From Cheque
Where ClavePago is not null
Union ALL
Select Trabajo.Trabajo as ID, ClavePago, 'LAB' as Tipo
From trabajo
Where ClavePago is not null



GO
/****** Object:  View [dbo].[vExamenesConCita]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************* INDICA SI LA CITA DE EXAMEN TIENE ALGUNA CITA POSTERIOR O COBRO ******************/
CREATE VIEW [dbo].[vExamenesConCita] as
SELECT Min(cita.Fecha) as Fecha, cita.fechaVal, cita.Cliente, cita.Doctor
		FROM TipoCita
		INNER JOIN cita ON cita.Tipocita=TipoCita.TipoCita
		WHERE cita.Area <> 1 
		AND descripcion LIKE '%examen%' 
		AND cita.doctor<>1 AND cita.doctor<>2 AND cita.doctor<>10000001 AND cita.doctor<>10000002
		AND( 
			Exists(
				Select *
				From cita C2
				Where C2.Cliente=cita.Cliente
				And C2.Doctor=cita.Doctor
				And C2.FechaVal>cita.FechaVal
				And Abs(C2.Cumplida)=1
			)
		OR Exists(
				Select *
				From cobro C3
				Where C3.Cliente=cita.cliente
				And C3.Doctor=cita.Doctor
				And C3.FechaVal>cita.FechaVal
				And C3.Activo<>0 and C3.Ingresado<>0 and C3.Pendiente=0
			)
		)
Group By cita.FechaVal,cita.Cliente, cita.Doctor
/**********************************************************************************************************/

GO
/****** Object:  View [dbo].[vLlavesPrimarias]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vLlavesPrimarias] AS
SELECT K.TABLE_NAME AS Tabla, K.COLUMN_NAME as Columna, K.ORDINAL_POSITION AS Posicion
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS C
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS K ON C.CONSTRAINT_NAME = K.CONSTRAINT_NAME AND K.TABLE_CATALOG='OD' 
WHERE C.CONSTRAINT_TYPE IN ('PRIMARY KEY', 'UNIQUE')

GO
/****** Object:  View [dbo].[vSillon]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vSillon] AS
Select Sillon
from Sillon
group by Sillon


GO
/****** Object:  View [dbo].[WSMenu]    Script Date: 16/06/2016 09:36:57 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[WSMenu] AS
SELECT WSComando.Comando, WSComando.ComandoDes, WSComando.Argumento1, WSComando.Argumento2, Usuario.Id, Usuario.Id AS Usuario, WSComando.TipoComando, WSComando.Panel
FROM (WSTipoUsuarioComando INNER JOIN WSComando ON WSTipoUsuarioComando.Comando = WSComando.Comando) INNER JOIN Usuario ON WSTipoUsuarioComando.TipoUsuario = Usuario.TipoUsuario
WHERE WSComando.Activo<>0 AND WSTipoUsuarioComando.Seleccion<>0
GO
/****** Object:  Index [Idx__Cargar_al_Inicio_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__Cargar_al_Inicio_GenVersion] ON [dbo].[_Cargar_al_Inicio]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__Cargar_al_Inicio_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__Cargar_al_Inicio_ID] ON [dbo].[_Cargar_al_Inicio]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__Config_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__Config_GenVersion] ON [dbo].[_Config]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__Config_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__Config_ID] ON [dbo].[_Config]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__Config_SucursalID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__Config_SucursalID] ON [dbo].[_Config]
(
	[SucursalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__GRAL_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__GRAL_GenVersion] ON [dbo].[_GRAL]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__ImprimirDetallado_Cobro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__ImprimirDetallado_Cobro] ON [dbo].[_ImprimirDetallado]
(
	[Cobro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__ImprimirDetallado_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__ImprimirDetallado_GenVersion] ON [dbo].[_ImprimirDetallado]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__ImprimirDetallado_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__ImprimirDetallado_ID] ON [dbo].[_ImprimirDetallado]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__Status_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__Status_FechaVal] ON [dbo].[_Status]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__Status_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__Status_GenVersion] ON [dbo].[_Status]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__Status_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__Status_HoraVal] ON [dbo].[_Status]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__Status_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__Status_ID] ON [dbo].[_Status]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__StatusSincro_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__StatusSincro_FechaVal] ON [dbo].[_StatusSincro]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__StatusSincro_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__StatusSincro_GenVersion] ON [dbo].[_StatusSincro]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__StatusSincro_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__StatusSincro_HoraVal] ON [dbo].[_StatusSincro]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx__StatusSincro_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx__StatusSincro_ID] ON [dbo].[_StatusSincro]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Acreditacion_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Acreditacion_GenVersion] ON [dbo].[Acreditacion]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_Acreditacion_Permiso]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Acreditacion_Permiso] ON [dbo].[Acreditacion]
(
	[Permiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Acreditacion_TipoUsuario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Acreditacion_TipoUsuario] ON [dbo].[Acreditacion]
(
	[TipoUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ArchTemporal_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ArchTemporal_GenVersion] ON [dbo].[ArchTemporal]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ArchTemporal_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ArchTemporal_ID] ON [dbo].[ArchTemporal]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ArchTemporal_Terminal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ArchTemporal_Terminal] ON [dbo].[ArchTemporal]
(
	[Terminal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Area_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Area_GenVersion] ON [dbo].[Area]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Banco_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Banco_GenVersion] ON [dbo].[Banco]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Banco_Grupo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Banco_Grupo] ON [dbo].[Banco]
(
	[Grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_BitacoraCartaEsp_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_BitacoraCartaEsp_FechaVal] ON [dbo].[BitacoraCartaEsp]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_BitacoraCartaEsp_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_BitacoraCartaEsp_GenVersion] ON [dbo].[BitacoraCartaEsp]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_BitacoraCartaEsp_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_BitacoraCartaEsp_HoraVal] ON [dbo].[BitacoraCartaEsp]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_BloqueoEsp_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_BloqueoEsp_GenVersion] ON [dbo].[BloqueoEsp]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_BloqueoEsp_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_BloqueoEsp_HoraVal] ON [dbo].[BloqueoEsp]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_BloqueoSillones_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_BloqueoSillones_GenVersion] ON [dbo].[BloqueoSillones]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Bodega_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Bodega_GenVersion] ON [dbo].[Bodega]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_BracketDespegados_BracketDespegados]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_BracketDespegados_BracketDespegados] ON [dbo].[BracketDespegados]
(
	[BracketDespegados] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_BracketDespegados_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_BracketDespegados_Fecha] ON [dbo].[BracketDespegados]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_BracketDespegados_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_BracketDespegados_FechaVal] ON [dbo].[BracketDespegados]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_BracketDespegados_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_BracketDespegados_GenVersion] ON [dbo].[BracketDespegados]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_BuscarCita_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_BuscarCita_GenVersion] ON [dbo].[BuscarCita]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CambioDatos_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CambioDatos_FechaVal] ON [dbo].[CambioDatos]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CambioDatos_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CambioDatos_GenVersion] ON [dbo].[CambioDatos]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CambioDatos_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CambioDatos_HoraVal] ON [dbo].[CambioDatos]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CambioDatos_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CambioDatos_ID] ON [dbo].[CambioDatos]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cargo_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cargo_GenVersion] ON [dbo].[Cargo]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CartaEsp_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CartaEsp_GenVersion] ON [dbo].[CartaEsp]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CatalogoPrecio_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CatalogoPrecio_GenVersion] ON [dbo].[CatalogoPrecio]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CatalogoPrecio_Servicio_CatalogoPrecio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CatalogoPrecio_Servicio_CatalogoPrecio] ON [dbo].[CatalogoPrecio_Servicio]
(
	[CatalogoPrecio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CatalogoPrecio_Servicio_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CatalogoPrecio_Servicio_GenVersion] ON [dbo].[CatalogoPrecio_Servicio]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CatalogoPrecio_Servicio_Servicio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CatalogoPrecio_Servicio_Servicio] ON [dbo].[CatalogoPrecio_Servicio]
(
	[Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CatalogoTratamiento_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CatalogoTratamiento_GenVersion] ON [dbo].[CatalogoTratamiento]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Chat_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Chat_Cliente] ON [dbo].[Chat]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Chat_Destino]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Chat_Destino] ON [dbo].[Chat]
(
	[Destino] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Chat_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Chat_FechaVal] ON [dbo].[Chat]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Chat_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Chat_GenVersion] ON [dbo].[Chat]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Chat_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Chat_HoraVal] ON [dbo].[Chat]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Chat_Origen]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Chat_Origen] ON [dbo].[Chat]
(
	[Origen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ChatCommon_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ChatCommon_GenVersion] ON [dbo].[ChatCommon]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cheque_ClaveDeCheque]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cheque_ClaveDeCheque] ON [dbo].[Cheque]
(
	[ClaveDeCheque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cheque_ClavePago]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cheque_ClavePago] ON [dbo].[Cheque]
(
	[ClavePago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cheque_ConceptoCheque]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cheque_ConceptoCheque] ON [dbo].[Cheque]
(
	[ConceptoCheque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cheque_EliminadoPor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cheque_EliminadoPor] ON [dbo].[Cheque]
(
	[EliminadoPor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cheque_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cheque_Fecha] ON [dbo].[Cheque]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cheque_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cheque_FechaVal] ON [dbo].[Cheque]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cheque_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cheque_GenVersion] ON [dbo].[Cheque]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cheque_Proveedor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cheque_Proveedor] ON [dbo].[Cheque]
(
	[Proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cheque_Responsable]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cheque_Responsable] ON [dbo].[Cheque]
(
	[Responsable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cheque_Seleccion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cheque_Seleccion] ON [dbo].[Cheque]
(
	[Seleccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cheque_TipoGasto]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cheque_TipoGasto] ON [dbo].[Cheque]
(
	[TipoGasto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoCheque]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoCheque] ON [dbo].[Cheque]
(
	[TipoCheque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cita_Area]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cita_Area] ON [dbo].[Cita]
(
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cita_CitaId]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [Idx_Cita_CitaId] ON [dbo].[Cita]
(
	[CitaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cita_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cita_Cliente] ON [dbo].[Cita]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cita_Doctor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cita_Doctor] ON [dbo].[Cita]
(
	[Doctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cita_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cita_Fecha] ON [dbo].[Cita]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cita_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cita_FechaVal] ON [dbo].[Cita]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cita_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cita_GenVersion] ON [dbo].[Cita]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cita_Hora]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cita_Hora] ON [dbo].[Cita]
(
	[Hora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cita_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cita_HoraVal] ON [dbo].[Cita]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cita_Responsable]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cita_Responsable] ON [dbo].[Cita]
(
	[Responsable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cita_Respuesta]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cita_Respuesta] ON [dbo].[Cita]
(
	[Respuesta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_Cita_Sillon]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cita_Sillon] ON [dbo].[Cita]
(
	[Sillon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CitasBorradas_Area]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CitasBorradas_Area] ON [dbo].[CitasBorradas]
(
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CitasBorradas_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CitasBorradas_Cliente] ON [dbo].[CitasBorradas]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CitasBorradas_Doctor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CitasBorradas_Doctor] ON [dbo].[CitasBorradas]
(
	[Doctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CitasBorradas_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CitasBorradas_Fecha] ON [dbo].[CitasBorradas]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CitasBorradas_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CitasBorradas_FechaVal] ON [dbo].[CitasBorradas]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CitasBorradas_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CitasBorradas_GenVersion] ON [dbo].[CitasBorradas]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CitasBorradas_Hora]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CitasBorradas_Hora] ON [dbo].[CitasBorradas]
(
	[Hora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CitasBorradas_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CitasBorradas_HoraVal] ON [dbo].[CitasBorradas]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CitasBorradas_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CitasBorradas_ID] ON [dbo].[CitasBorradas]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_CitasBorradas_Responsable]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CitasBorradas_Responsable] ON [dbo].[CitasBorradas]
(
	[Responsable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_CitasBorradas_Sillon]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_CitasBorradas_Sillon] ON [dbo].[CitasBorradas]
(
	[Sillon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ClaseFotos_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ClaseFotos_GenVersion] ON [dbo].[ClaseFotos]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cliente_ArchID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cliente_ArchID] ON [dbo].[Cliente]
(
	[ArchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cliente_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cliente_GenVersion] ON [dbo].[Cliente]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cliente_IDFotos]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cliente_IDFotos] ON [dbo].[Cliente]
(
	[IDFotos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_Cliente_Nombre]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cliente_Nombre] ON [dbo].[Cliente]
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cliente_Revaluacion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cliente_Revaluacion] ON [dbo].[Cliente]
(
	[Revaluacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ClienteDigital_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ClienteDigital_FechaVal] ON [dbo].[ClienteDigital]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ClienteDigital_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ClienteDigital_GenVersion] ON [dbo].[ClienteDigital]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ClienteDigital_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ClienteDigital_HoraVal] ON [dbo].[ClienteDigital]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ClienteEnfermedad_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ClienteEnfermedad_GenVersion] ON [dbo].[ClienteEnfermedad]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ClienteHistorial_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ClienteHistorial_GenVersion] ON [dbo].[ClienteHistorial]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ClienteHistorial_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ClienteHistorial_ID] ON [dbo].[ClienteHistorial]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Clock_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Clock_Fecha] ON [dbo].[Clock]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Clock_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Clock_FechaVal] ON [dbo].[Clock]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Clock_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Clock_HoraVal] ON [dbo].[Clock]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Clock_IDCLock]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Clock_IDCLock] ON [dbo].[Clock]
(
	[IDClock] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Clock_Usuario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Clock_Usuario] ON [dbo].[Clock]
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_Area]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_Area] ON [dbo].[Cobro]
(
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_Banco]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_Banco] ON [dbo].[Cobro]
(
	[Banco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_Cliente] ON [dbo].[Cobro]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_Doctor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_Doctor] ON [dbo].[Cobro]
(
	[Doctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_Fecha] ON [dbo].[Cobro]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_FechaVal] ON [dbo].[Cobro]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_GenVersion] ON [dbo].[Cobro]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_Hora]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_Hora] ON [dbo].[Cobro]
(
	[Hora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_HoraVal] ON [dbo].[Cobro]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_NumFactura]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_NumFactura] ON [dbo].[Cobro]
(
	[NumFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_Responsable]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_Responsable] ON [dbo].[Cobro]
(
	[Responsable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_Servicio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_Servicio] ON [dbo].[Cobro]
(
	[Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_TipoCobro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_TipoCobro] ON [dbo].[Cobro]
(
	[TipoCobro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Cobro_Tratamiento]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Cobro_Tratamiento] ON [dbo].[Cobro]
(
	[Tratamiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Codigo_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Codigo_GenVersion] ON [dbo].[Codigo]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Comando_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Comando_GenVersion] ON [dbo].[Comando]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Comando_Panel]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Comando_Panel] ON [dbo].[Comando]
(
	[Panel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ConceptoCheque_ConceptoCheque]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ConceptoCheque_ConceptoCheque] ON [dbo].[ConceptoCheque]
(
	[ConceptoCheque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ConceptoCheque_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ConceptoCheque_GenVersion] ON [dbo].[ConceptoCheque]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ConeccionChat_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ConeccionChat_GenVersion] ON [dbo].[ConeccionChat]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Contribuyente_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Contribuyente_GenVersion] ON [dbo].[Contribuyente]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_DescuentoEspecial_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_DescuentoEspecial_GenVersion] ON [dbo].[DescuentoEspecial]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_DiaSemana_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_DiaSemana_GenVersion] ON [dbo].[DiaSemana]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_DIR_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_DIR_GenVersion] ON [dbo].[DIR]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_DIR_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_DIR_ID] ON [dbo].[DIR]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Doctor_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Doctor_GenVersion] ON [dbo].[Doctor]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_Doctor_Nombre]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Doctor_Nombre] ON [dbo].[Doctor]
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_DoctorRef_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_DoctorRef_GenVersion] ON [dbo].[DoctorRef]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_DoctorRefCliente_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_DoctorRefCliente_GenVersion] ON [dbo].[DoctorRefCliente]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Email_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Email_FechaVal] ON [dbo].[Email]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Email_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Email_GenVersion] ON [dbo].[Email]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Email_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Email_HoraVal] ON [dbo].[Email]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_Empleado_Clave]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Empleado_Clave] ON [dbo].[Empleado]
(
	[Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_Empleado_Codigo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Empleado_Codigo] ON [dbo].[Empleado]
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Empleado_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Empleado_GenVersion] ON [dbo].[Empleado]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_Empleado_Nombre]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Empleado_Nombre] ON [dbo].[Empleado]
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Empleado_TipoEmpleado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Empleado_TipoEmpleado] ON [dbo].[Empleado]
(
	[TipoEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Enfermedad_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Enfermedad_GenVersion] ON [dbo].[Enfermedad]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_EstadoTrabajo_EstadoTrabajo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_EstadoTrabajo_EstadoTrabajo] ON [dbo].[EstadoTrabajo]
(
	[EstadoTrabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_EstadoTrabajo_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_EstadoTrabajo_GenVersion] ON [dbo].[EstadoTrabajo]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Eti_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Eti_GenVersion] ON [dbo].[Eti]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Etiqueta_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Etiqueta_GenVersion] ON [dbo].[Etiqueta]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Etiqueta_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Etiqueta_ID] ON [dbo].[Etiqueta]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Etiqueta_OrdenEtiqueta]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Etiqueta_OrdenEtiqueta] ON [dbo].[Etiqueta]
(
	[OrdenEtiqueta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Extension_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Extension_GenVersion] ON [dbo].[Extension]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_FacturaCliente_Cobro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_FacturaCliente_Cobro] ON [dbo].[FacturaCliente]
(
	[Cobro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_FacturaCliente_Descripcion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_FacturaCliente_Descripcion] ON [dbo].[FacturaCliente]
(
	[Descripcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_FacturaCliente_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_FacturaCliente_GenVersion] ON [dbo].[FacturaCliente]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_FaseTratamiento_CreadoPor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_FaseTratamiento_CreadoPor] ON [dbo].[FaseTratamiento]
(
	[CreadoPor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_FaseTratamiento_FaseTratamiento]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_FaseTratamiento_FaseTratamiento] ON [dbo].[FaseTratamiento]
(
	[FaseTratamiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_FaseTratamiento_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_FaseTratamiento_GenVersion] ON [dbo].[FaseTratamiento]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_FechaEspecial_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_FechaEspecial_FechaVal] ON [dbo].[FechaEspecial]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_FechaEspecial_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_FechaEspecial_GenVersion] ON [dbo].[FechaEspecial]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_FechaEspecialBloquearHora_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_FechaEspecialBloquearHora_GenVersion] ON [dbo].[FechaEspecialBloquearHora]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_FechaEspecialBloquearHora_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_FechaEspecialBloquearHora_HoraVal] ON [dbo].[FechaEspecialBloquearHora]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Formato_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Formato_GenVersion] ON [dbo].[Formato]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_GenerarAuto_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_GenerarAuto_FechaVal] ON [dbo].[GenerarAuto]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_GenerarAuto_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_GenerarAuto_GenVersion] ON [dbo].[GenerarAuto]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_GradoColegio_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_GradoColegio_GenVersion] ON [dbo].[GradoColegio]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_HoraExtra_Empleado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_HoraExtra_Empleado] ON [dbo].[HoraExtra]
(
	[Empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_HoraExtra_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_HoraExtra_FechaVal] ON [dbo].[HoraExtra]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_HoraExtra_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_HoraExtra_GenVersion] ON [dbo].[HoraExtra]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_HoraExtra_TipoExtra]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_HoraExtra_TipoExtra] ON [dbo].[HoraExtra]
(
	[TipoExtra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Horario_Area]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Horario_Area] ON [dbo].[Horario]
(
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Horario_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Horario_Fecha] ON [dbo].[Horario]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Horario_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Horario_FechaVal] ON [dbo].[Horario]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Horario_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Horario_GenVersion] ON [dbo].[Horario]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Horario_Hora]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Horario_Hora] ON [dbo].[Horario]
(
	[Hora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Horario_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Horario_HoraVal] ON [dbo].[Horario]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Laboratorio_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Laboratorio_GenVersion] ON [dbo].[Laboratorio]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Linea_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Linea_GenVersion] ON [dbo].[Linea]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Listado_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Listado_Cliente] ON [dbo].[Listado]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Listado_Doctor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Listado_Doctor] ON [dbo].[Listado]
(
	[Doctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Listado_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Listado_Fecha] ON [dbo].[Listado]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Listado_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Listado_FechaVal] ON [dbo].[Listado]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Listado_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Listado_GenVersion] ON [dbo].[Listado]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Listado_Hora]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Listado_Hora] ON [dbo].[Listado]
(
	[Hora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Listado_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Listado_HoraVal] ON [dbo].[Listado]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Listado_TipoCita]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Listado_TipoCita] ON [dbo].[Listado]
(
	[TipoCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MailErrorFiles_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MailErrorFiles_FechaVal] ON [dbo].[MailErrorFiles]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MailErrorFiles_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MailErrorFiles_GenVersion] ON [dbo].[MailErrorFiles]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MailErrorFiles_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MailErrorFiles_HoraVal] ON [dbo].[MailErrorFiles]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MensajePredef_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MensajePredef_GenVersion] ON [dbo].[MensajePredef]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_Mes_Descripcion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Mes_Descripcion] ON [dbo].[Mes]
(
	[Descripcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Mes_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Mes_GenVersion] ON [dbo].[Mes]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Mes_Mes]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Mes_Mes] ON [dbo].[Mes]
(
	[Mes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MovimientoProducto_Bodega]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MovimientoProducto_Bodega] ON [dbo].[MovimientoProducto]
(
	[MPBodega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MovimientoProducto_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MovimientoProducto_Cliente] ON [dbo].[MovimientoProducto]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MovimientoProducto_Doctor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MovimientoProducto_Doctor] ON [dbo].[MovimientoProducto]
(
	[Doctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MovimientoProducto_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MovimientoProducto_Fecha] ON [dbo].[MovimientoProducto]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MovimientoProducto_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MovimientoProducto_FechaVal] ON [dbo].[MovimientoProducto]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MovimientoProducto_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MovimientoProducto_GenVersion] ON [dbo].[MovimientoProducto]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MovimientoProducto_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MovimientoProducto_HoraVal] ON [dbo].[MovimientoProducto]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MovimientoProductoDetalle_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MovimientoProductoDetalle_GenVersion] ON [dbo].[MovimientoProductoDetalle]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MovimientoProductoDetalle_MovimientoProducto]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MovimientoProductoDetalle_MovimientoProducto] ON [dbo].[MovimientoProductoDetalle]
(
	[MovimientoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_MovimientoProductoDetalle_Producto]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_MovimientoProductoDetalle_Producto] ON [dbo].[MovimientoProductoDetalle]
(
	[Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_OrtodonciaTx_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_OrtodonciaTx_Cliente] ON [dbo].[OrtodonciaTx]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_OrtodonciaTx_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_OrtodonciaTx_Fecha] ON [dbo].[OrtodonciaTx]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_OrtodonciaTx_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_OrtodonciaTx_FechaVal] ON [dbo].[OrtodonciaTx]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_OrtodonciaTx_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_OrtodonciaTx_GenVersion] ON [dbo].[OrtodonciaTx]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_OrtodonciaTx_Responsable]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_OrtodonciaTx_Responsable] ON [dbo].[OrtodonciaTx]
(
	[Responsable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PagoPlanilla_Empleado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PagoPlanilla_Empleado] ON [dbo].[PagoPlanilla]
(
	[Empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PagoPlanilla_Extra]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PagoPlanilla_Extra] ON [dbo].[PagoPlanilla]
(
	[Extra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PagoPlanilla_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PagoPlanilla_GenVersion] ON [dbo].[PagoPlanilla]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PagoPlanilla_Planilla]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PagoPlanilla_Planilla] ON [dbo].[PagoPlanilla]
(
	[Planilla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Panel_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Panel_GenVersion] ON [dbo].[Panel]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Panel_Panel]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Panel_Panel] ON [dbo].[Panel]
(
	[Panel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_Permiso_Descripcion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Permiso_Descripcion] ON [dbo].[Permiso]
(
	[Descripcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Permiso_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Permiso_GenVersion] ON [dbo].[Permiso]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_Permiso_Permiso]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Permiso_Permiso] ON [dbo].[Permiso]
(
	[Permiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Pieza_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Pieza_GenVersion] ON [dbo].[Pieza]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Planilla_FechaFin]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Planilla_FechaFin] ON [dbo].[Planilla]
(
	[FechaFin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Planilla_FechaInicio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Planilla_FechaInicio] ON [dbo].[Planilla]
(
	[FechaInicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Planilla_GeneradaPor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Planilla_GeneradaPor] ON [dbo].[Planilla]
(
	[GeneradaPor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Planilla_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Planilla_GenVersion] ON [dbo].[Planilla]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PlanillaDetalle_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlanillaDetalle_GenVersion] ON [dbo].[PlanillaDetalle]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PlanillaDetalle_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlanillaDetalle_ID] ON [dbo].[PlanillaDetalle]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PlanillaDetalle_Planilla]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlanillaDetalle_Planilla] ON [dbo].[PlanillaDetalle]
(
	[Planilla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PlanillaDias]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [IX_PlanillaDias] ON [dbo].[PlanillaDias]
(
	[Planilla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_Planta_Codigo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Planta_Codigo] ON [dbo].[Planta]
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Planta_Extension]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Planta_Extension] ON [dbo].[Planta]
(
	[Extension] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Planta_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Planta_Fecha] ON [dbo].[Planta]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Planta_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Planta_FechaVal] ON [dbo].[Planta]
(
	[FechaVal] ASC
)
INCLUDE ( 	[Hora]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Planta_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Planta_GenVersion] ON [dbo].[Planta]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Planta_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Planta_HoraVal] ON [dbo].[Planta]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Planta_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Planta_ID] ON [dbo].[Planta]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Planta_Linea]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Planta_Linea] ON [dbo].[Planta]
(
	[Linea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PlantaCliente_Aux01]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlantaCliente_Aux01] ON [dbo].[PlantaCliente]
(
	[TotSeg] ASC
)
INCLUDE ( 	[Planta],
	[Cliente]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PlantaCliente_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlantaCliente_Cliente] ON [dbo].[PlantaCliente]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_PlantaCliente_Codigo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlantaCliente_Codigo] ON [dbo].[PlantaCliente]
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PlantaCliente_Extension]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlantaCliente_Extension] ON [dbo].[PlantaCliente]
(
	[Extension] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PlantaCliente_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlantaCliente_Fecha] ON [dbo].[PlantaCliente]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PlantaCliente_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlantaCliente_FechaVal] ON [dbo].[PlantaCliente]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PlantaCliente_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlantaCliente_GenVersion] ON [dbo].[PlantaCliente]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PlantaCliente_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlantaCliente_HoraVal] ON [dbo].[PlantaCliente]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PlantaCliente_Linea]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlantaCliente_Linea] ON [dbo].[PlantaCliente]
(
	[Linea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PlantaCliente_Planta]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PlantaCliente_Planta] ON [dbo].[PlantaCliente]
(
	[Planta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Presupuesto_Area]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Presupuesto_Area] ON [dbo].[Presupuesto]
(
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Presupuesto_CatalogoPrecio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Presupuesto_CatalogoPrecio] ON [dbo].[Presupuesto]
(
	[CatalogoPrecio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Presupuesto_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Presupuesto_Cliente] ON [dbo].[Presupuesto]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Presupuesto_Doctor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Presupuesto_Doctor] ON [dbo].[Presupuesto]
(
	[Doctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Presupuesto_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Presupuesto_Fecha] ON [dbo].[Presupuesto]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Presupuesto_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Presupuesto_FechaVal] ON [dbo].[Presupuesto]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Presupuesto_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Presupuesto_GenVersion] ON [dbo].[Presupuesto]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Presupuesto_Presupuesto]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Presupuesto_Presupuesto] ON [dbo].[Presupuesto]
(
	[Presupuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PresupuestoDetalle_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PresupuestoDetalle_GenVersion] ON [dbo].[PresupuestoDetalle]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PresupuestoDetalle_Presupuesto]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PresupuestoDetalle_Presupuesto] ON [dbo].[PresupuestoDetalle]
(
	[Presupuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PresupuestoDetalle_PresupuestoDetalle]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PresupuestoDetalle_PresupuestoDetalle] ON [dbo].[PresupuestoDetalle]
(
	[PresupuestoDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_PresupuestoDetalle_Servicio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_PresupuestoDetalle_Servicio] ON [dbo].[PresupuestoDetalle]
(
	[Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Producto_Bodega]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Producto_Bodega] ON [dbo].[Producto]
(
	[Bodega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Producto_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Producto_GenVersion] ON [dbo].[Producto]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Producto_Responsable]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Producto_Responsable] ON [dbo].[Producto]
(
	[Responsable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Proveedor_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Proveedor_GenVersion] ON [dbo].[Proveedor]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Recordatorio_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Recordatorio_FechaVal] ON [dbo].[Recordatorio]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Recordatorio_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Recordatorio_GenVersion] ON [dbo].[Recordatorio]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Referencia_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Referencia_Cliente] ON [dbo].[Referencia]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Referencia_Doctor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Referencia_Doctor] ON [dbo].[Referencia]
(
	[Doctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Referencia_DoctorRef]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Referencia_DoctorRef] ON [dbo].[Referencia]
(
	[DoctorRef] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Referencia_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Referencia_Fecha] ON [dbo].[Referencia]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Referencia_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Referencia_FechaVal] ON [dbo].[Referencia]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Referencia_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Referencia_GenVersion] ON [dbo].[Referencia]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ReferenciaDetalle_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ReferenciaDetalle_GenVersion] ON [dbo].[ReferenciaDetalle]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ReferenciaPieza_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ReferenciaPieza_GenVersion] ON [dbo].[ReferenciaPieza]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RefOtro_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RefOtro_GenVersion] ON [dbo].[RefOtro]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RegCortes_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RegCortes_FechaVal] ON [dbo].[RegCortes]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RegCortes_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RegCortes_GenVersion] ON [dbo].[RegCortes]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RegCortes_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RegCortes_HoraVal] ON [dbo].[RegCortes]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RegCortesM_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RegCortesM_FechaVal] ON [dbo].[RegCortesM]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RegCortesM_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RegCortesM_GenVersion] ON [dbo].[RegCortesM]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RegCortesM_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RegCortesM_HoraVal] ON [dbo].[RegCortesM]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RegFixMail_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RegFixMail_FechaVal] ON [dbo].[RegFixMail]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RegFixMail_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RegFixMail_GenVersion] ON [dbo].[RegFixMail]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RegFixMail_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RegFixMail_HoraVal] ON [dbo].[RegFixMail]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RegFixMail_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RegFixMail_ID] ON [dbo].[RegFixMail]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Reporte_Clientes_Config_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Reporte_Clientes_Config_GenVersion] ON [dbo].[Reporte Clientes Config]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Reporte_Clientes_Config_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Reporte_Clientes_Config_ID] ON [dbo].[Reporte Clientes Config]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ReporteClientes_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ReporteClientes_GenVersion] ON [dbo].[ReporteClientes]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ReporteClientes_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ReporteClientes_ID] ON [dbo].[ReporteClientes]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ReporteClientes_Terminal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ReporteClientes_Terminal] ON [dbo].[ReporteClientes]
(
	[Terminal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Requerimiento_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Requerimiento_FechaVal] ON [dbo].[Requerimiento]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Requerimiento_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Requerimiento_GenVersion] ON [dbo].[Requerimiento]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Requerimiento_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Requerimiento_HoraVal] ON [dbo].[Requerimiento]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RequestDetalle_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RequestDetalle_GenVersion] ON [dbo].[RequestDetalle]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RequestDetalle_ID1]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RequestDetalle_ID1] ON [dbo].[RequestDetalle]
(
	[ID1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RequestDetalle_ID2]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RequestDetalle_ID2] ON [dbo].[RequestDetalle]
(
	[ID2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RequestDetalle_ID3]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RequestDetalle_ID3] ON [dbo].[RequestDetalle]
(
	[ID3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RequestDetalle_ID4]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RequestDetalle_ID4] ON [dbo].[RequestDetalle]
(
	[ID4] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RequestDetalle_ID5]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RequestDetalle_ID5] ON [dbo].[RequestDetalle]
(
	[ID5] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RequestDetalle_Request]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RequestDetalle_Request] ON [dbo].[RequestDetalle]
(
	[Request] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_RespuestaCita_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_RespuestaCita_GenVersion] ON [dbo].[RespuestaCita]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Revaluacion_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Revaluacion_GenVersion] ON [dbo].[Revaluacion]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Revaluacion_TipoRevaluacion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Revaluacion_TipoRevaluacion] ON [dbo].[Revaluacion]
(
	[TipoRevaluacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_SelDoctor_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_SelDoctor_GenVersion] ON [dbo].[SelDoctor]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_SelDoctor_Terminal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_SelDoctor_Terminal] ON [dbo].[SelDoctor]
(
	[Terminal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_SelUsuario_Terminal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_SelUsuario_Terminal] ON [dbo].[SelUsuario]
(
	[Terminal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_SelUsuario_Usuario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_SelUsuario_Usuario] ON [dbo].[SelUsuario]
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ServerIndex_Clave1]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ServerIndex_Clave1] ON [dbo].[ServerIndex]
(
	[Clave1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ServerIndex_Clave2]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ServerIndex_Clave2] ON [dbo].[ServerIndex]
(
	[Clave2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ServerIndex_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ServerIndex_GenVersion] ON [dbo].[ServerIndex]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_ServerIndex_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_ServerIndex_ID] ON [dbo].[ServerIndex]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Servicio_Area]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Servicio_Area] ON [dbo].[Servicio]
(
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Servicio_CreadoPor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Servicio_CreadoPor] ON [dbo].[Servicio]
(
	[CreadoPor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Servicio_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Servicio_GenVersion] ON [dbo].[Servicio]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Sesion_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Sesion_Cliente] ON [dbo].[Sesion]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Sesion_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Sesion_Fecha] ON [dbo].[Sesion]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Sesion_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Sesion_FechaVal] ON [dbo].[Sesion]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Sesion_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Sesion_GenVersion] ON [dbo].[Sesion]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Sesion_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Sesion_HoraVal] ON [dbo].[Sesion]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Sesion_Sesion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Sesion_Sesion] ON [dbo].[Sesion]
(
	[Sesion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Sesion_TipoSerie]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Sesion_TipoSerie] ON [dbo].[Sesion]
(
	[TipoSerie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Sesion_TipoSesion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Sesion_TipoSesion] ON [dbo].[Sesion]
(
	[TipoSesion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Sillon_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Sillon_GenVersion] ON [dbo].[Sillon]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_tCobrosAgenda_Area]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_tCobrosAgenda_Area] ON [dbo].[tCobrosAgenda]
(
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_tCobrosAgenda_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_tCobrosAgenda_Cliente] ON [dbo].[tCobrosAgenda]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_tCobrosAgenda_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_tCobrosAgenda_Fecha] ON [dbo].[tCobrosAgenda]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_tCobrosAgenda_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_tCobrosAgenda_FechaVal] ON [dbo].[tCobrosAgenda]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_tCobrosAgenda_Hora]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_tCobrosAgenda_Hora] ON [dbo].[tCobrosAgenda]
(
	[Hora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_tCobrosAgenda_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_tCobrosAgenda_HoraVal] ON [dbo].[tCobrosAgenda]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_tCobrosAgenda_Sillon]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_tCobrosAgenda_Sillon] ON [dbo].[tCobrosAgenda]
(
	[Sillon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_tCobrosAgenda_Terminal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_tCobrosAgenda_Terminal] ON [dbo].[tCobrosAgenda]
(
	[Terminal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Temp_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Temp_GenVersion] ON [dbo].[Temp]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Temp_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Temp_ID] ON [dbo].[Temp]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TEMP_Terminal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TEMP_Terminal] ON [dbo].[Temp]
(
	[Terminal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TempArchivo_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TempArchivo_GenVersion] ON [dbo].[TempArchivo]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Termino_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Termino_GenVersion] ON [dbo].[Termino]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoCita_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoCita_GenVersion] ON [dbo].[TipoCita]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoCitaEspecial_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoCitaEspecial_GenVersion] ON [dbo].[TipoCitaEspecial]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoCitaEspecial_TipoCita_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoCitaEspecial_TipoCita_GenVersion] ON [dbo].[TipoCitaEspecial_TipoCita]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoCitaExcepcion_TipoCita]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoCitaExcepcion_TipoCita] ON [dbo].[TipoCitaExcepcion]
(
	[TipoCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoCliente_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoCliente_GenVersion] ON [dbo].[TipoCliente]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoCobro_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoCobro_GenVersion] ON [dbo].[TipoCobro]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoCobro_TipoCobro]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoCobro_TipoCobro] ON [dbo].[TipoCobro]
(
	[TipoCobro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoComando_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoComando_GenVersion] ON [dbo].[TipoComando]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoEmpleado_Bonificacion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoEmpleado_Bonificacion] ON [dbo].[TipoEmpleado]
(
	[Bonificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_TipoEmpleado_Descripcion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoEmpleado_Descripcion] ON [dbo].[TipoEmpleado]
(
	[Descripcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoEmpleado_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoEmpleado_GenVersion] ON [dbo].[TipoEmpleado]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoEmpleado_SueldoBase]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoEmpleado_SueldoBase] ON [dbo].[TipoEmpleado]
(
	[SueldoBase] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoExtra_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoExtra_GenVersion] ON [dbo].[TipoExtra]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoFechaEspecial_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoFechaEspecial_GenVersion] ON [dbo].[TipoFechaEspecial]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoGasto_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoGasto_GenVersion] ON [dbo].[TipoGasto]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoHorario_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoHorario_GenVersion] ON [dbo].[TipoHorario]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoMovimientoProducto_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoMovimientoProducto_GenVersion] ON [dbo].[TipoMovimientoProducto]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoPlanilla_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoPlanilla_GenVersion] ON [dbo].[TipoPlanilla]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoRefOtro_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoRefOtro_GenVersion] ON [dbo].[TipoRefOtro]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoRevaluacion_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoRevaluacion_GenVersion] ON [dbo].[TipoRevaluacion]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoSesion_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoSesion_GenVersion] ON [dbo].[TipoSesion]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoSesionFotos_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoSesionFotos_GenVersion] ON [dbo].[TipoSesionFotos]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoTratamiento_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoTratamiento_GenVersion] ON [dbo].[TipoTratamiento]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoUsuario_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoUsuario_GenVersion] ON [dbo].[TipoUsuario]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoUsuario_TipoUsuario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoUsuario_TipoUsuario] ON [dbo].[TipoUsuario]
(
	[TipoUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoUsuario_Comando_Comando]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoUsuario_Comando_Comando] ON [dbo].[TipoUsuario Comando]
(
	[Comando] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoUsuario_Comando_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoUsuario_Comando_GenVersion] ON [dbo].[TipoUsuario Comando]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TipoUsuario_Comando_TipoUsuario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TipoUsuario_Comando_TipoUsuario] ON [dbo].[TipoUsuario Comando]
(
	[TipoUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Trabajo_Cheque]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Trabajo_Cheque] ON [dbo].[Trabajo]
(
	[Cheque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Trabajo_ClavePago]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Trabajo_ClavePago] ON [dbo].[Trabajo]
(
	[ClavePago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Trabajo_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Trabajo_Cliente] ON [dbo].[Trabajo]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Trabajo_Estado]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Trabajo_Estado] ON [dbo].[Trabajo]
(
	[Estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Trabajo_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Trabajo_Fecha] ON [dbo].[Trabajo]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Trabajo_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Trabajo_FechaVal] ON [dbo].[Trabajo]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Trabajo_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Trabajo_GenVersion] ON [dbo].[Trabajo]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Trabajo_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Trabajo_HoraVal] ON [dbo].[Trabajo]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Trabajo_Laboratorio]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Trabajo_Laboratorio] ON [dbo].[Trabajo]
(
	[Laboratorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Trabajo_Trabajo]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Trabajo_Trabajo] ON [dbo].[Trabajo]
(
	[Trabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Transaccion_Ejecutor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Transaccion_Ejecutor] ON [dbo].[Transaccion]
(
	[Ejecutor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Transaccion_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Transaccion_Fecha] ON [dbo].[Transaccion]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Transaccion_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Transaccion_FechaVal] ON [dbo].[Transaccion]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Transaccion_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Transaccion_GenVersion] ON [dbo].[Transaccion]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Transaccion_HoraVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Transaccion_HoraVal] ON [dbo].[Transaccion]
(
	[HoraVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Idx_Transaccion_Permiso]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Transaccion_Permiso] ON [dbo].[Transaccion]
(
	[Permiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Transaccion_Usuario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Transaccion_Usuario] ON [dbo].[Transaccion]
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Tratamiento_Area]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Tratamiento_Area] ON [dbo].[Tratamiento]
(
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Tratamiento_CatalogoTratamiento]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Tratamiento_CatalogoTratamiento] ON [dbo].[Tratamiento]
(
	[CatalogoTratamiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Tratamiento_Cliente]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Tratamiento_Cliente] ON [dbo].[Tratamiento]
(
	[Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Tratamiento_Doctor]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Tratamiento_Doctor] ON [dbo].[Tratamiento]
(
	[Doctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Tratamiento_Fecha]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Tratamiento_Fecha] ON [dbo].[Tratamiento]
(
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Tratamiento_FechaVal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Tratamiento_FechaVal] ON [dbo].[Tratamiento]
(
	[FechaVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Tratamiento_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Tratamiento_GenVersion] ON [dbo].[Tratamiento]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Tratamiento_ProxVisita]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Tratamiento_ProxVisita] ON [dbo].[Tratamiento]
(
	[ProxVisita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Tratamiento_TipoTratamiento]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Tratamiento_TipoTratamiento] ON [dbo].[Tratamiento]
(
	[TipoTratamiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_TratamientoRef_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_TratamientoRef_GenVersion] ON [dbo].[TratamientoRef]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Usuario_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Usuario_GenVersion] ON [dbo].[Usuario]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Usuario_Id]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Usuario_Id] ON [dbo].[Usuario]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Usuario_TipoUsuario]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Usuario_TipoUsuario] ON [dbo].[Usuario]
(
	[TipoUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_UsuarioBodega_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_UsuarioBodega_GenVersion] ON [dbo].[UsuarioBodega]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Usuarios_Grafica_temp_GenVersion]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Usuarios_Grafica_temp_GenVersion] ON [dbo].[Usuarios Grafica temp]
(
	[GenVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Usuarios_Grafica_temp_ID]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Usuarios_Grafica_temp_ID] ON [dbo].[Usuarios Grafica temp]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_Usuarios_Grafica_temp_Terminal]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_Usuarios_Grafica_temp_Terminal] ON [dbo].[Usuarios Grafica temp]
(
	[Terminal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Idx_WSComando_Panel]    Script Date: 16/06/2016 09:36:57 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_WSComando_Panel] ON [dbo].[WSComando]
(
	[Panel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_Cargar_al_Inicio] ADD  DEFAULT (NULL) FOR [Formato]
GO
ALTER TABLE [dbo].[_Cargar_al_Inicio] ADD  DEFAULT (NULL) FOR [Accion]
GO
ALTER TABLE [dbo].[_Cargar_al_Inicio] ADD  DEFAULT ((0)) FOR [Cerrar]
GO
ALTER TABLE [dbo].[_Cargar_al_Inicio] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[_Config] ADD  DEFAULT (NULL) FOR [ID]
GO
ALTER TABLE [dbo].[_Config] ADD  DEFAULT ((0)) FOR [SucursalID]
GO
ALTER TABLE [dbo].[_Config] ADD  DEFAULT (NULL) FOR [Modulo]
GO
ALTER TABLE [dbo].[_Config] ADD  DEFAULT ((0)) FOR [Igss]
GO
ALTER TABLE [dbo].[_Config] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[_Config] ADD  CONSTRAINT [DF__Config_ForceShutDown]  DEFAULT ((0)) FOR [ForceShutDown]
GO
ALTER TABLE [dbo].[_Config] ADD  CONSTRAINT [DF__Config_RestartTV]  DEFAULT ((0)) FOR [RestartTV]
GO
ALTER TABLE [dbo].[_GRAL] ADD  DEFAULT (NULL) FOR [GRAL]
GO
ALTER TABLE [dbo].[_GRAL] ADD  DEFAULT ((0)) FOR [CerrarPrograma]
GO
ALTER TABLE [dbo].[_GRAL] ADD  DEFAULT (NULL) FOR [PresupuestoComparar]
GO
ALTER TABLE [dbo].[_GRAL] ADD  DEFAULT (NULL) FOR [ImpChRechazadosAgenda]
GO
ALTER TABLE [dbo].[_GRAL] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[_GRAL] ADD  DEFAULT (NULL) FOR [Formato]
GO
ALTER TABLE [dbo].[_GRAL] ADD  DEFAULT (NULL) FOR [BacEvio]
GO
ALTER TABLE [dbo].[_GRAL] ADD  DEFAULT (NULL) FOR [BacEnvio]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cobro]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad1]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio1]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni1]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad2]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio2]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni2]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad3]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio3]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni3]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad4]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio4]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni4]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad5]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio5]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni5]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad6]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio6]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni6]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad7]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio7]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni7]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad8]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio8]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni8]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad9]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio9]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni9]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad10]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio10]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni10]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad11]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio11]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni11]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad12]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio12]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni12]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad13]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio13]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni13]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad14]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio14]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni14]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad15]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio15]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni15]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad16]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio16]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni16]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad17]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio17]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni17]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad18]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio18]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni18]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad19]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio19]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni19]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad20]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio20]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni20]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad21]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio21]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni21]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad22]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio22]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni22]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad23]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio23]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni23]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad24]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio24]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni24]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad25]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio25]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni25]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad26]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio26]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni26]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad27]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio27]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni27]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Cantidad28]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Precio28]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT (NULL) FOR [Uni28]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT ((0)) FOR [Total]
GO
ALTER TABLE [dbo].[_ImprimirDetallado] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[_Status] ADD  DEFAULT (NULL) FOR [ID]
GO
ALTER TABLE [dbo].[_Status] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[_Status] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[_Status] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[_StatusSincro] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[_StatusSincro] ADD  DEFAULT (getdate()) FOR [Hora]
GO
ALTER TABLE [dbo].[_StatusSincro] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[_StatusSincro] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[_StatusSincro] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Acreditacion] ADD  DEFAULT (NULL) FOR [TipoUsuario]
GO
ALTER TABLE [dbo].[Acreditacion] ADD  DEFAULT ((0)) FOR [Permitir]
GO
ALTER TABLE [dbo].[Acreditacion] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[ArchTemporal] ADD  DEFAULT (NULL) FOR [Terminal]
GO
ALTER TABLE [dbo].[ArchTemporal] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Area] ADD  CONSTRAINT [DF__Area__Area__7C4F7684]  DEFAULT ((0)) FOR [Area]
GO
ALTER TABLE [dbo].[Area] ADD  CONSTRAINT [DF_Area_EsOrto]  DEFAULT ((0)) FOR [EsOrto]
GO
ALTER TABLE [dbo].[Area] ADD  CONSTRAINT [DF__Area__GenVersion__7D439ABD]  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Banco] ADD  DEFAULT (NULL) FOR [Banco]
GO
ALTER TABLE [dbo].[Banco] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Banco] ADD  DEFAULT ((0)) FOR [ComisionCliente]
GO
ALTER TABLE [dbo].[Banco] ADD  DEFAULT ((0)) FOR [ComisionTarjeta]
GO
ALTER TABLE [dbo].[Banco] ADD  DEFAULT ((0)) FOR [EsTarjeta]
GO
ALTER TABLE [dbo].[Banco] ADD  DEFAULT ((1)) FOR [NumCuotas]
GO
ALTER TABLE [dbo].[Banco] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Banco] ADD  DEFAULT ((0)) FOR [Grupo]
GO
ALTER TABLE [dbo].[BitacoraCartaEsp] ADD  DEFAULT (NULL) FOR [CartaEsp]
GO
ALTER TABLE [dbo].[BitacoraCartaEsp] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[BitacoraCartaEsp] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[BitacoraCartaEsp] ADD  DEFAULT (getdate()) FOR [Hora]
GO
ALTER TABLE [dbo].[BitacoraCartaEsp] ADD  DEFAULT (NULL) FOR [Usuario]
GO
ALTER TABLE [dbo].[BitacoraCartaEsp] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[BitacoraCartaEsp] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[BitacoraCartaEsp] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[BloqueoEsp] ADD  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[BloqueoEsp] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[BloqueoEsp] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [Area]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [Lu]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [Ma]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [Mi]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [Ju]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [Vi]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [Sa]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [SillonA]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [SillonB]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [SillonC]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [SillonD]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [SillonE]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [SIllonF]
GO
ALTER TABLE [dbo].[BloqueoSillones] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Bodega] ADD  DEFAULT (NULL) FOR [Bodega]
GO
ALTER TABLE [dbo].[Bodega] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[BracketDespegados] ADD  DEFAULT (NULL) FOR [BracketDespegados]
GO
ALTER TABLE [dbo].[BracketDespegados] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[BracketDespegados] ADD  DEFAULT ((0)) FOR [Cantidad]
GO
ALTER TABLE [dbo].[BracketDespegados] ADD  DEFAULT ((0)) FOR [Monto]
GO
ALTER TABLE [dbo].[BracketDespegados] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[BracketDespegados] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[BuscarCita] ADD  DEFAULT (NULL) FOR [BuscarCita]
GO
ALTER TABLE [dbo].[BuscarCita] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[BuscarCita] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[CambioDatos] ADD  DEFAULT (NULL) FOR [Usuario]
GO
ALTER TABLE [dbo].[CambioDatos] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[CambioDatos] ADD  DEFAULT (getdate()) FOR [Hora]
GO
ALTER TABLE [dbo].[CambioDatos] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[CambioDatos] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[CambioDatos] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Cargo] ADD  DEFAULT (NULL) FOR [Cargo]
GO
ALTER TABLE [dbo].[Cargo] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[CartaEsp] ADD  CONSTRAINT [DF__CartaEsp__CartaE__40F9A68C]  DEFAULT (NULL) FOR [CartaEsp]
GO
ALTER TABLE [dbo].[CartaEsp] ADD  CONSTRAINT [DF__CartaEsp__Mostra__41EDCAC5]  DEFAULT ((0)) FOR [MostrarEnMenu]
GO
ALTER TABLE [dbo].[CartaEsp] ADD  CONSTRAINT [DF__CartaEsp__DocImp__42E1EEFE]  DEFAULT (N'CartaEsp') FOR [DocImprimir]
GO
ALTER TABLE [dbo].[CartaEsp] ADD  CONSTRAINT [DF__CartaEsp__GenVer__43D61337]  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[CartaEsp] ADD  CONSTRAINT [DF_CartaEsp_ImprimeSinWord]  DEFAULT ((0)) FOR [ImprimeSinWord]
GO
ALTER TABLE [dbo].[CatalogoPrecio] ADD  DEFAULT (NULL) FOR [CatalogoPrecio]
GO
ALTER TABLE [dbo].[CatalogoPrecio] ADD  DEFAULT ((0)) FOR [PagoInicial]
GO
ALTER TABLE [dbo].[CatalogoPrecio] ADD  DEFAULT ((0)) FOR [Registros]
GO
ALTER TABLE [dbo].[CatalogoPrecio] ADD  DEFAULT ((0)) FOR [Retenedores]
GO
ALTER TABLE [dbo].[CatalogoPrecio] ADD  DEFAULT ((0)) FOR [Mensualidad]
GO
ALTER TABLE [dbo].[CatalogoPrecio] ADD  DEFAULT ((0)) FOR [EsAparato]
GO
ALTER TABLE [dbo].[CatalogoPrecio] ADD  DEFAULT ((0)) FOR [PagoFinal]
GO
ALTER TABLE [dbo].[CatalogoPrecio] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[CatalogoPrecio] ADD  DEFAULT ((0)) FOR [EsPrecioEspecial]
GO
ALTER TABLE [dbo].[CatalogoPrecio] ADD  DEFAULT (NULL) FOR [CompararCon]
GO
ALTER TABLE [dbo].[CatalogoPrecio] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[CatalogoPrecio_Servicio] ADD  DEFAULT (NULL) FOR [CatalogoPrecio]
GO
ALTER TABLE [dbo].[CatalogoPrecio_Servicio] ADD  DEFAULT (NULL) FOR [Servicio]
GO
ALTER TABLE [dbo].[CatalogoPrecio_Servicio] ADD  DEFAULT ((0)) FOR [Precio]
GO
ALTER TABLE [dbo].[CatalogoPrecio_Servicio] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[CatalogoTratamiento] ADD  DEFAULT (NULL) FOR [CatalogoTratamiento]
GO
ALTER TABLE [dbo].[CatalogoTratamiento] ADD  DEFAULT ((0)) FOR [PagoInicial]
GO
ALTER TABLE [dbo].[CatalogoTratamiento] ADD  DEFAULT ((0)) FOR [Registros]
GO
ALTER TABLE [dbo].[CatalogoTratamiento] ADD  DEFAULT ((0)) FOR [Retenedores]
GO
ALTER TABLE [dbo].[CatalogoTratamiento] ADD  DEFAULT ((0)) FOR [Mensualidad]
GO
ALTER TABLE [dbo].[CatalogoTratamiento] ADD  DEFAULT ((0)) FOR [EsAparato]
GO
ALTER TABLE [dbo].[CatalogoTratamiento] ADD  DEFAULT ((0)) FOR [PagoFinal]
GO
ALTER TABLE [dbo].[CatalogoTratamiento] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[CatalogoTratamiento] ADD  DEFAULT ((0)) FOR [Facturado]
GO
ALTER TABLE [dbo].[CatalogoTratamiento] ADD  DEFAULT ((1)) FOR [MostrarReportes]
GO
ALTER TABLE [dbo].[CatalogoTratamiento] ADD  DEFAULT (NULL) FOR [TxConFactura]
GO
ALTER TABLE [dbo].[CatalogoTratamiento] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT (getdate()) FOR [Hora]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT (NULL) FOR [Origen]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT (NULL) FOR [Destino]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT (NULL) FOR [TerminalOrigen]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT (NULL) FOR [TerminalDestino]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT ((0)) FOR [Leido]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT ((0)) FOR [Limpiar]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Chat] ADD  CONSTRAINT [DF_Chat_Cliente]  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[ChatCommon] ADD  DEFAULT (NULL) FOR [ChatCommon]
GO
ALTER TABLE [dbo].[ChatCommon] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[ChatCommon] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Cheque__1C5231C2]  DEFAULT (NULL) FOR [Cheque]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Fecha__1D4655FB]  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF_Cheque_TipoCheque]  DEFAULT ((0)) FOR [TipoCheque]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Concepto__1E3A7A34]  DEFAULT (NULL) FOR [ConceptoCheque]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Proveedo__1F2E9E6D]  DEFAULT (NULL) FOR [Proveedor]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Monto__2022C2A6]  DEFAULT ((0)) FOR [Monto]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Ingresad__2116E6DF]  DEFAULT ((0)) FOR [Ingresado]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Anulado__220B0B18]  DEFAULT ((0)) FOR [Anulado]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Activo__22FF2F51]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Eliminad__23F3538A]  DEFAULT ((0)) FOR [Eliminado]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Responsa__24E777C3]  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__AnuladoP__25DB9BFC]  DEFAULT (NULL) FOR [AnuladoPor]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Eliminad__26CFC035]  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__TipoGast__27C3E46E]  DEFAULT ((1)) FOR [TipoGasto]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__NoNegoci__28B808A7]  DEFAULT ((0)) FOR [NoNegociable]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Pendient__29AC2CE0]  DEFAULT ((0)) FOR [Pendiente]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Planilla__2AA05119]  DEFAULT (NULL) FOR [Planilla]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__Contribu__2B947552]  DEFAULT (NULL) FOR [Contribuyente]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__GenVersi__2C88998B]  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__FechaVal__2D7CBDC4]  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF__Cheque__TipoPlan__4A23E96A]  DEFAULT (NULL) FOR [TipoPlanilla]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF_Cheque_ClavePago]  DEFAULT (NULL) FOR [ClavePago]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF_Cheque_EsDetallado]  DEFAULT ((0)) FOR [EsDetallado]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF_Cheque_Seleccion]  DEFAULT (NULL) FOR [Seleccion]
GO
ALTER TABLE [dbo].[Cheque] ADD  CONSTRAINT [DF_Cheque_ClaveDeCheque]  DEFAULT (NULL) FOR [ClaveDeCheque]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT (NULL) FOR [TipoCita]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT ((1)) FOR [Cumplida]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT ((0)) FOR [Bloqueada]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT (NULL) FOR [Doctor]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT ((0)) FOR [EsAnterior]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT ((0)) FOR [Lock]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT (NULL) FOR [Terminal]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT ((1)) FOR [Contactar]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT (NULL) FOR [Respuesta]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT (NULL) FOR [ContactoPor]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT (getdate()) FOR [FechaTran]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Cita] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Cita] ADD  CONSTRAINT [DF_Cita_FaltasSeguidas]  DEFAULT ((0)) FOR [FaltasSeguidas]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorra__Area__7849DB76]  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorr__Clien__793DFFAF]  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorr__TipoC__7A3223E8]  DEFAULT (NULL) FOR [TipoCita]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorr__Cumpl__7B264821]  DEFAULT ((0)) FOR [Cumplida]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorr__Bloqu__7C1A6C5A]  DEFAULT ((0)) FOR [Bloqueada]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorr__Respo__7D0E9093]  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorr__Docto__7E02B4CC]  DEFAULT (NULL) FOR [Doctor]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorr__EsAnt__7EF6D905]  DEFAULT ((0)) FOR [EsAnterior]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorra__Lock__7FEAFD3E]  DEFAULT ((0)) FOR [Lock]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorr__Termi__00DF2177]  DEFAULT (NULL) FOR [Terminal]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorr__Elimi__01D345B0]  DEFAULT (NULL) FOR [EliminadaPor]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorr__GenVe__02C769E9]  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorr__Fecha__03BB8E22]  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF__CitasBorr__HoraV__04AFB25B]  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[CitasBorradas] ADD  CONSTRAINT [DF_CitasBorradas_FechaTrans]  DEFAULT (getdate()) FOR [FechaTrans]
GO
ALTER TABLE [dbo].[ClaseFotos] ADD  DEFAULT (NULL) FOR [ClaseFotos]
GO
ALTER TABLE [dbo].[ClaseFotos] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[ClaseFotos] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (NULL) FOR [ReferidoPor]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (NULL) FOR [ReferidoDoctor]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (NULL) FOR [ReferidoOtro]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [Embarazo]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [PrimeraCita]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [SegundaOpinion]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [OrtoAnteriormente]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [FamiliaSimilar]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (getdate()) FOR [FechaIngreso]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (getdate()) FOR [HoraIngreso]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [TipoCliente]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((-99)) FOR [GradoColegio]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [Info]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (NULL) FOR [TelActualizdoPor]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (getdate()) FOR [FechaDigitalizado]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [BloquearOdon]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [AvisoInasistencia]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [ClaseFotos]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [RecargoInfo]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (NULL) FOR [RecargoInfoResp]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (NULL) FOR [FixMailResp]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (getdate()) FOR [FechaTran]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (NULL) FOR [ArchID]
GO
ALTER TABLE [dbo].[ClienteDigital] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[ClienteDigital] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[ClienteDigital] ADD  DEFAULT (getdate()) FOR [Hora]
GO
ALTER TABLE [dbo].[ClienteDigital] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[ClienteDigital] ADD  DEFAULT (NULL) FOR [Usuario]
GO
ALTER TABLE [dbo].[ClienteDigital] ADD  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[ClienteDigital] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[ClienteDigital] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[ClienteDigital] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[ClienteEnfermedad] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[ClienteEnfermedad] ADD  DEFAULT (NULL) FOR [Enfermedad]
GO
ALTER TABLE [dbo].[ClienteEnfermedad] ADD  DEFAULT ((0)) FOR [Seleccion]
GO
ALTER TABLE [dbo].[ClienteEnfermedad] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[ClienteHistorial] ADD  DEFAULT (getdate()) FOR [FechaTran]
GO
ALTER TABLE [dbo].[ClienteHistorial] ADD  DEFAULT (getdate()) FOR [HoraTran]
GO
ALTER TABLE [dbo].[ClienteHistorial] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[ClienteHistorial] ADD  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[ClienteHistorial] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Clock] ADD  CONSTRAINT [DF_Clock_IDClock]  DEFAULT (NULL) FOR [IDClock]
GO
ALTER TABLE [dbo].[Clock] ADD  CONSTRAINT [DF_Clock_Usuario]  DEFAULT (NULL) FOR [Usuario]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [Cobro]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (getdate()) FOR [Hora]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [Tratamiento]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [Monto]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [TipoCobro]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [FaseTratamiento]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [Servicio]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [TotalDebido]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [Efectivo]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [Cheque]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [Banco]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [Pendiente]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [Doctor]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [Facturado]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [Ingresado]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((1)) FOR [BracketCant]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [Rechazado]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [OldSystem]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [EsAnterior]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (getdate()) FOR [FechaIngreso]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (getdate()) FOR [HoraIngreso]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [Cargo]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [Producto]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((1)) FOR [Cantidad]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [NumFactura]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [EsAparato]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [VisaNetReal]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [Abono]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [Saldo]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [mcargo]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [Presupuesto]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [Anyo]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [CobroTran2]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((1)) FOR [Contar]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [MontoFactura]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [FacturaTipo]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [Contribuyente]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Cobro] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Cobro] ADD  CONSTRAINT [DF_Cobro_PCosto]  DEFAULT ((0)) FOR [PCosto]
GO
ALTER TABLE [dbo].[Codigo] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Comando] ADD  DEFAULT ((0)) FOR [Argumento2]
GO
ALTER TABLE [dbo].[Comando] ADD  DEFAULT ((0)) FOR [TipoComando]
GO
ALTER TABLE [dbo].[Comando] ADD  DEFAULT (NULL) FOR [Panel]
GO
ALTER TABLE [dbo].[Comando] ADD  DEFAULT ((1)) FOR [Configurable]
GO
ALTER TABLE [dbo].[Comando] ADD  DEFAULT ((0)) FOR [Orden]
GO
ALTER TABLE [dbo].[Comando] ADD  DEFAULT ((0)) FOR [Instalar]
GO
ALTER TABLE [dbo].[Comando] ADD  DEFAULT ((0)) FOR [Borrar]
GO
ALTER TABLE [dbo].[Comando] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[ConceptoCheque] ADD  DEFAULT (NULL) FOR [ConceptoCheque]
GO
ALTER TABLE [dbo].[ConceptoCheque] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[ConceptoCheque] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[ConeccionChat] ADD  DEFAULT (NULL) FOR [Terminal]
GO
ALTER TABLE [dbo].[ConeccionChat] ADD  DEFAULT (NULL) FOR [Usuario]
GO
ALTER TABLE [dbo].[ConeccionChat] ADD  DEFAULT ((0)) FOR [Conectado]
GO
ALTER TABLE [dbo].[ConeccionChat] ADD  DEFAULT ((0)) FOR [Recepcion]
GO
ALTER TABLE [dbo].[ConeccionChat] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Contribuyente] ADD  DEFAULT (NULL) FOR [Contribuyente]
GO
ALTER TABLE [dbo].[Contribuyente] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Contribuyente] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[DescuentoEspecial] ADD  DEFAULT (NULL) FOR [DescuentoEspecial]
GO
ALTER TABLE [dbo].[DescuentoEspecial] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[DescuentoEspecial] ADD  DEFAULT ((0)) FOR [Porcentaje]
GO
ALTER TABLE [dbo].[DescuentoEspecial] ADD  DEFAULT ((0)) FOR [Cantidad]
GO
ALTER TABLE [dbo].[DescuentoEspecial] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[DiaSemana] ADD  DEFAULT ((0)) FOR [DiaSemana]
GO
ALTER TABLE [dbo].[DiaSemana] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[DIR] ADD  DEFAULT ((0)) FOR [DIR]
GO
ALTER TABLE [dbo].[DIR] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Doctor] ADD  DEFAULT (NULL) FOR [Doctor]
GO
ALTER TABLE [dbo].[Doctor] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Doctor] ADD  DEFAULT ((0)) FOR [VerOrtodoncia]
GO
ALTER TABLE [dbo].[Doctor] ADD  DEFAULT ((1)) FOR [VerOdontologia]
GO
ALTER TABLE [dbo].[Doctor] ADD  DEFAULT ((0)) FOR [Utilidad]
GO
ALTER TABLE [dbo].[Doctor] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[DoctorRef] ADD  DEFAULT (NULL) FOR [DoctorRef]
GO
ALTER TABLE [dbo].[DoctorRef] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[DoctorRef] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[DoctorRefCliente] ADD  DEFAULT (NULL) FOR [DoctorRefCliente]
GO
ALTER TABLE [dbo].[DoctorRefCliente] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[DoctorRefCliente] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[DoctorUsuario] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Email] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Email] ADD  DEFAULT (getdate()) FOR [Hora]
GO
ALTER TABLE [dbo].[Email] ADD  DEFAULT ((0)) FOR [Enviado]
GO
ALTER TABLE [dbo].[Email] ADD  DEFAULT ((0)) FOR [Cliente]
GO
ALTER TABLE [dbo].[Email] ADD  DEFAULT (NULL) FOR [CitaArea]
GO
ALTER TABLE [dbo].[Email] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Email] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Email] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Empleado] ADD  DEFAULT (NULL) FOR [TipoEmpleado]
GO
ALTER TABLE [dbo].[Empleado] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Empleado] ADD  DEFAULT (NULL) FOR [Proveedor]
GO
ALTER TABLE [dbo].[Empleado] ADD  DEFAULT ((0)) FOR [SueldoBase]
GO
ALTER TABLE [dbo].[Empleado] ADD  DEFAULT ((125.05)) FOR [Bonificacion]
GO
ALTER TABLE [dbo].[Empleado] ADD  DEFAULT (NULL) FOR [TipoPlanilla]
GO
ALTER TABLE [dbo].[Empleado] ADD  DEFAULT ((0)) FOR [TieneIGSS]
GO
ALTER TABLE [dbo].[Empleado] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Enfermedad] ADD  DEFAULT (NULL) FOR [Enfermedad]
GO
ALTER TABLE [dbo].[Enfermedad] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[EstadoTrabajo] ADD  DEFAULT (NULL) FOR [EstadoTrabajo]
GO
ALTER TABLE [dbo].[EstadoTrabajo] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Eti] ADD  DEFAULT (NULL) FOR [Etiqueta]
GO
ALTER TABLE [dbo].[Eti] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Etiqueta] ADD  DEFAULT (NULL) FOR [OrdenEtiqueta]
GO
ALTER TABLE [dbo].[Etiqueta] ADD  DEFAULT (NULL) FOR [ID]
GO
ALTER TABLE [dbo].[Etiqueta] ADD  DEFAULT ((0)) FOR [Imprimir]
GO
ALTER TABLE [dbo].[Etiqueta] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Extension] ADD  DEFAULT (NULL) FOR [Extension]
GO
ALTER TABLE [dbo].[Extension] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[FacturaCliente] ADD  DEFAULT (NULL) FOR [Cobro]
GO
ALTER TABLE [dbo].[FacturaCliente] ADD  DEFAULT ((0)) FOR [Monto]
GO
ALTER TABLE [dbo].[FacturaCliente] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[FacturaCliente] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[FaseTratamiento] ADD  DEFAULT (NULL) FOR [FaseTratamiento]
GO
ALTER TABLE [dbo].[FaseTratamiento] ADD  DEFAULT ((0)) FOR [Especial]
GO
ALTER TABLE [dbo].[FaseTratamiento] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[FaseTratamiento] ADD  DEFAULT ((0)) FOR [ImportadoOld]
GO
ALTER TABLE [dbo].[FaseTratamiento] ADD  DEFAULT (NULL) FOR [CreadoPor]
GO
ALTER TABLE [dbo].[FaseTratamiento] ADD  DEFAULT ((1)) FOR [Abono]
GO
ALTER TABLE [dbo].[FaseTratamiento] ADD  DEFAULT (getdate()) FOR [FechaCreado]
GO
ALTER TABLE [dbo].[FaseTratamiento] ADD  DEFAULT ((1)) FOR [EsNuevo]
GO
ALTER TABLE [dbo].[FaseTratamiento] ADD  DEFAULT ((0)) FOR [EsAparato]
GO
ALTER TABLE [dbo].[FaseTratamiento] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[FechaEspecial] ADD  DEFAULT (NULL) FOR [TipoFechaEspecial]
GO
ALTER TABLE [dbo].[FechaEspecial] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[FechaEspecial] ADD  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[FechaEspecial] ADD  DEFAULT (getdate()) FOR [CreadoFecha]
GO
ALTER TABLE [dbo].[FechaEspecial] ADD  DEFAULT (getdate()) FOR [CreadoHora]
GO
ALTER TABLE [dbo].[FechaEspecial] ADD  DEFAULT ((1)) FOR [Bloqueado]
GO
ALTER TABLE [dbo].[FechaEspecial] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[FechaEspecial] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[FechaEspecialBloquearHora] ADD  DEFAULT ((0)) FOR [Todos]
GO
ALTER TABLE [dbo].[FechaEspecialBloquearHora] ADD  DEFAULT ((0)) FOR [abc]
GO
ALTER TABLE [dbo].[FechaEspecialBloquearHora] ADD  DEFAULT ((0)) FOR [def]
GO
ALTER TABLE [dbo].[FechaEspecialBloquearHora] ADD  DEFAULT (NULL) FOR [TipoFechaEspecial]
GO
ALTER TABLE [dbo].[FechaEspecialBloquearHora] ADD  DEFAULT ((0)) FOR [Bloquear]
GO
ALTER TABLE [dbo].[FechaEspecialBloquearHora] ADD  DEFAULT ((0)) FOR [Desbloquear]
GO
ALTER TABLE [dbo].[FechaEspecialBloquearHora] ADD  DEFAULT (NULL) FOR [TipoDiaSemana]
GO
ALTER TABLE [dbo].[FechaEspecialBloquearHora] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[FechaEspecialBloquearHora] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Formato] ADD  DEFAULT (NULL) FOR [Formato]
GO
ALTER TABLE [dbo].[Formato] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[GenerarAuto] ADD  DEFAULT (NULL) FOR [Tipo]
GO
ALTER TABLE [dbo].[GenerarAuto] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[GenerarAuto] ADD  DEFAULT (NULL) FOR [MensajePredef]
GO
ALTER TABLE [dbo].[GenerarAuto] ADD  DEFAULT ((0)) FOR [Costo]
GO
ALTER TABLE [dbo].[GenerarAuto] ADD  DEFAULT (NULL) FOR [Servicio]
GO
ALTER TABLE [dbo].[GenerarAuto] ADD  DEFAULT ((0)) FOR [Cantidad]
GO
ALTER TABLE [dbo].[GenerarAuto] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[GenerarAuto] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[GradoColegio] ADD  DEFAULT (NULL) FOR [GradoColegio]
GO
ALTER TABLE [dbo].[GradoColegio] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[GradoColegio] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF__HoraExtra__Fecha__30242045]  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF__HoraExtra__Emple__3118447E]  DEFAULT (NULL) FOR [Empleado]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF__HoraExtra__Horas__320C68B7]  DEFAULT ((0)) FOR [Horas]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF__HoraExtra__Usuar__33008CF0]  DEFAULT (NULL) FOR [Usuario]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF__HoraExtra__Ingre__33F4B129]  DEFAULT ((0)) FOR [Ingresado]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF__HoraExtra__Respo__34E8D562]  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF__HoraExtra__Elimi__35DCF99B]  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF__HoraExtra__TipoE__36D11DD4]  DEFAULT (NULL) FOR [TipoExtra]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF__HoraExtra__Monto__37C5420D]  DEFAULT ((0)) FOR [Monto]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF__HoraExtra__Activ__38B96646]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF__HoraExtra__GenVe__39AD8A7F]  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF__HoraExtra__Fecha__3AA1AEB8]  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF_HoraExtra_GeneradoPor]  DEFAULT (NULL) FOR [GeneradoPor]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF_HoraExtra_DescontarAnyo]  DEFAULT (NULL) FOR [DescontarAnyo]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF_HoraExtra_DescontarMes]  DEFAULT (NULL) FOR [DescontarMes]
GO
ALTER TABLE [dbo].[HoraExtra] ADD  CONSTRAINT [DF_HoraExtra_DescontarQuincena]  DEFAULT (NULL) FOR [DescontarQuincena]
GO
ALTER TABLE [dbo].[Horario] ADD  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[Horario] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Horario] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Horario] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Impresora] ADD  CONSTRAINT [DF_Table_1_Tipo]  DEFAULT ((0)) FOR [TipoImpresora]
GO
ALTER TABLE [dbo].[Impresora] ADD  CONSTRAINT [DF_Impresora_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Laboratorio] ADD  DEFAULT (NULL) FOR [Laboratorio]
GO
ALTER TABLE [dbo].[Laboratorio] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Laboratorio] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Linea] ADD  DEFAULT (NULL) FOR [Linea]
GO
ALTER TABLE [dbo].[Linea] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT (NULL) FOR [TipoListado]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT (NULL) FOR [Terminal]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT (NULL) FOR [Fecha]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT (NULL) FOR [Hora]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT (NULL) FOR [Doctor]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT (NULL) FOR [IngresoPor]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT (NULL) FOR [FechaIngreso]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT (NULL) FOR [AtendidoPor]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT ((0)) FOR [MinEspera]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT (NULL) FOR [FechaAtendido]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Listado] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[MailErrorFiles] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[MailErrorFiles] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[MailErrorFiles] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[MailErrorFiles] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[MensajePredef] ADD  DEFAULT (NULL) FOR [MensajePredef]
GO
ALTER TABLE [dbo].[MensajePredef] ADD  DEFAULT ((0)) FOR [PedirCantidad]
GO
ALTER TABLE [dbo].[MensajePredef] ADD  DEFAULT ((0)) FOR [Seleccion]
GO
ALTER TABLE [dbo].[MensajePredef] ADD  DEFAULT ((0)) FOR [CostoUni]
GO
ALTER TABLE [dbo].[MensajePredef] ADD  DEFAULT (NULL) FOR [Servicio]
GO
ALTER TABLE [dbo].[MensajePredef] ADD  DEFAULT ((0)) FOR [Cantidad]
GO
ALTER TABLE [dbo].[MensajePredef] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Mes] ADD  DEFAULT (NULL) FOR [Mes]
GO
ALTER TABLE [dbo].[Mes] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[MesPlanilla] ADD  CONSTRAINT [DF_MesPlanilla_Orden]  DEFAULT ((99)) FOR [Orden]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT (NULL) FOR [MovimientoProducto]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT (NULL) FOR [TipoMovimientoProducto]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT (NULL) FOR [Doctor]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT (getdate()) FOR [Hora]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT (NULL) FOR [Usuario]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT (NULL) FOR [Vale]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT ((0)) FOR [Ingresado]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[MovimientoProducto] ADD  CONSTRAINT [DF_MovimientoProducto_MPBodega]  DEFAULT (NULL) FOR [MPBodega]
GO
ALTER TABLE [dbo].[MovimientoProductoDetalle] ADD  DEFAULT (NULL) FOR [MovimientoProducto]
GO
ALTER TABLE [dbo].[MovimientoProductoDetalle] ADD  DEFAULT (NULL) FOR [Producto]
GO
ALTER TABLE [dbo].[MovimientoProductoDetalle] ADD  DEFAULT ((0)) FOR [Ingreso]
GO
ALTER TABLE [dbo].[MovimientoProductoDetalle] ADD  DEFAULT ((0)) FOR [Salida]
GO
ALTER TABLE [dbo].[MovimientoProductoDetalle] ADD  DEFAULT ((1)) FOR [Contar]
GO
ALTER TABLE [dbo].[MovimientoProductoDetalle] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[MovimientoProductoDetalle] ADD  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[MovimientoProductoDetalle] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[OrtodonciaTx] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[OrtodonciaTx] ADD  DEFAULT (NULL) FOR [NumCita]
GO
ALTER TABLE [dbo].[OrtodonciaTx] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[OrtodonciaTx] ADD  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[OrtodonciaTx] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[OrtodonciaTx] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[PagoPlanilla] ADD  DEFAULT (NULL) FOR [Planilla]
GO
ALTER TABLE [dbo].[PagoPlanilla] ADD  DEFAULT (NULL) FOR [Empleado]
GO
ALTER TABLE [dbo].[PagoPlanilla] ADD  DEFAULT ((0)) FOR [Bonificacion]
GO
ALTER TABLE [dbo].[PagoPlanilla] ADD  DEFAULT ((0)) FOR [Sueldo]
GO
ALTER TABLE [dbo].[PagoPlanilla] ADD  DEFAULT (NULL) FOR [Extra]
GO
ALTER TABLE [dbo].[PagoPlanilla] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Panel] ADD  DEFAULT (NULL) FOR [Panel]
GO
ALTER TABLE [dbo].[Panel] ADD  DEFAULT ((0)) FOR [Default]
GO
ALTER TABLE [dbo].[Panel] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Param] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[Param] ADD  DEFAULT (NULL) FOR [PFecha1]
GO
ALTER TABLE [dbo].[Param] ADD  DEFAULT (NULL) FOR [PFecha2]
GO
ALTER TABLE [dbo].[Permiso] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Pieza] ADD  DEFAULT ((0)) FOR [Especial]
GO
ALTER TABLE [dbo].[Pieza] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Planilla] ADD  DEFAULT (NULL) FOR [Planilla]
GO
ALTER TABLE [dbo].[Planilla] ADD  DEFAULT (NULL) FOR [Quincena]
GO
ALTER TABLE [dbo].[Planilla] ADD  DEFAULT (NULL) FOR [Mes]
GO
ALTER TABLE [dbo].[Planilla] ADD  DEFAULT (NULL) FOR [Anyo]
GO
ALTER TABLE [dbo].[Planilla] ADD  DEFAULT ((0)) FOR [Bloqueado]
GO
ALTER TABLE [dbo].[Planilla] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Planilla] ADD  DEFAULT ((0)) FOR [TieneDebito]
GO
ALTER TABLE [dbo].[Planilla] ADD  CONSTRAINT [DF_Planilla_Envio]  DEFAULT (NULL) FOR [Envio]
GO
ALTER TABLE [dbo].[Planilla] ADD  CONSTRAINT [DF_Planilla_BloqueadoTX]  DEFAULT ('0000000000') FOR [BloqueadoTX]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaDeta__ID__190BB0C3]  DEFAULT ((0)) FOR [ID]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Plani__19FFD4FC]  DEFAULT (NULL) FOR [Planilla]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__NumOr__1AF3F935]  DEFAULT ((0)) FOR [NumOrden]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Sueld__1BE81D6E]  DEFAULT ((0)) FOR [SueldoBase]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Bonif__1CDC41A7]  DEFAULT ((0)) FOR [Bonificacion]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Adela__1DD065E0]  DEFAULT ((0)) FOR [Adelantos]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Extra__1EC48A19]  DEFAULT ((0)) FOR [Extras]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__NumEx__1FB8AE52]  DEFAULT ((0)) FOR [NumExtras]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Total__20ACD28B]  DEFAULT ((0)) FOR [Total]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Liqui__21A0F6C4]  DEFAULT ((0)) FOR [Liquido]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Mostr__22951AFD]  DEFAULT ((1)) FOR [Mostrar]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaDe__Igss__23893F36]  DEFAULT ((0)) FOR [Igss]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Aguin__247D636F]  DEFAULT ((0)) FOR [Aguinaldo]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Meses__257187A8]  DEFAULT ((0)) FOR [MesesTrabajados]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Orden__2665ABE1]  DEFAULT ((99999)) FOR [Orden]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__NumHo__2759D01A]  DEFAULT ((0)) FOR [NumHorasExtras]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__NumHo__284DF453]  DEFAULT ((0)) FOR [NumHorasExtrasFeriados]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__QNumH__2942188C]  DEFAULT ((0)) FOR [QNumHorasExtrasFeriados]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Sueld__2A363CC5]  DEFAULT ((0)) FOR [SueldoHoraExtra]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaDe__Dias__2B2A60FE]  DEFAULT ((15)) FOR [Dias]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Calcu__2C1E8537]  DEFAULT ((15)) FOR [CalcularDias]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Comis__2D12A970]  DEFAULT ((0)) FOR [Comision]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__Descu__2E06CDA9]  DEFAULT ((0)) FOR [Descuento]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__TipoP__2EFAF1E2]  DEFAULT ((0)) FOR [TipoPlanilla]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF__PlanillaD__GenVe__2FEF161B]  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF_PlanillaDetalle_Vacaciones]  DEFAULT ((0)) FOR [Vacaciones]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF_PlanillaDetalle_VacacionesP]  DEFAULT ((0)) FOR [VacacionesP]
GO
ALTER TABLE [dbo].[PlanillaDetalle] ADD  CONSTRAINT [DF_PlanillaDetalle_VacacionesG]  DEFAULT ((0)) FOR [VacacionesG]
GO
ALTER TABLE [dbo].[PlanillaDias] ADD  CONSTRAINT [DF_PlanillaDias_Dias]  DEFAULT ((15)) FOR [Dias]
GO
ALTER TABLE [dbo].[PlanillaDias] ADD  CONSTRAINT [DF_PlanillaDias_Vacaciones]  DEFAULT ((0)) FOR [Vacaciones]
GO
ALTER TABLE [dbo].[PlanillaDias] ADD  CONSTRAINT [DF_PlanillaDias_VacacionesP]  DEFAULT ((0)) FOR [VacacionesP]
GO
ALTER TABLE [dbo].[PlanillaDias] ADD  CONSTRAINT [DF_PlanillaDias_VacacionesG]  DEFAULT ((0)) FOR [VacacionesG]
GO
ALTER TABLE [dbo].[PlanillaDias] ADD  CONSTRAINT [DF_PlanillaDias_Suspension]  DEFAULT ((0)) FOR [Suspension]
GO
ALTER TABLE [dbo].[Planta] ADD  DEFAULT ((0)) FOR [Extension]
GO
ALTER TABLE [dbo].[Planta] ADD  DEFAULT ((0)) FOR [Linea]
GO
ALTER TABLE [dbo].[Planta] ADD  DEFAULT ((0)) FOR [Min]
GO
ALTER TABLE [dbo].[Planta] ADD  DEFAULT ((0)) FOR [Seg]
GO
ALTER TABLE [dbo].[Planta] ADD  DEFAULT ((0)) FOR [TotSeg]
GO
ALTER TABLE [dbo].[Planta] ADD  DEFAULT ((0)) FOR [TotMin]
GO
ALTER TABLE [dbo].[Planta] ADD  DEFAULT (NULL) FOR [vTelefono]
GO
ALTER TABLE [dbo].[Planta] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Planta] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Planta] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[PlantaCliente] ADD  DEFAULT (NULL) FOR [Planta]
GO
ALTER TABLE [dbo].[PlantaCliente] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[PlantaCliente] ADD  DEFAULT ((0)) FOR [Extension]
GO
ALTER TABLE [dbo].[PlantaCliente] ADD  DEFAULT ((0)) FOR [Linea]
GO
ALTER TABLE [dbo].[PlantaCliente] ADD  DEFAULT ((0)) FOR [Min]
GO
ALTER TABLE [dbo].[PlantaCliente] ADD  DEFAULT ((0)) FOR [Seg]
GO
ALTER TABLE [dbo].[PlantaCliente] ADD  DEFAULT ((0)) FOR [TotSeg]
GO
ALTER TABLE [dbo].[PlantaCliente] ADD  DEFAULT ((0)) FOR [TotMin]
GO
ALTER TABLE [dbo].[PlantaCliente] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[PlantaCliente] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[PlantaCliente] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT (NULL) FOR [Presupuesto]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT (NULL) FOR [Doctor]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [PagoInicial]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [NumCuotas]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [MontoCuota]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [Descuento]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [Registros]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [Retenedores]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [Costo]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [Total]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT (NULL) FOR [CatalogoPrecio]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [ConFactura]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [EsAparato]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [PagoFinal]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [3cuotas]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [6cuotas]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [10cuotas]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [12cuotas]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT (NULL) FOR [DescuentoEspecial]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Presupuesto] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[PresupuestoDetalle] ADD  DEFAULT (NULL) FOR [Presupuesto]
GO
ALTER TABLE [dbo].[PresupuestoDetalle] ADD  DEFAULT ((1)) FOR [Cantidad]
GO
ALTER TABLE [dbo].[PresupuestoDetalle] ADD  DEFAULT (NULL) FOR [Servicio]
GO
ALTER TABLE [dbo].[PresupuestoDetalle] ADD  DEFAULT ((0)) FOR [Costo]
GO
ALTER TABLE [dbo].[PresupuestoDetalle] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Producto] ADD  CONSTRAINT [DF__Producto__Produc__6CF8245B]  DEFAULT (NULL) FOR [Producto]
GO
ALTER TABLE [dbo].[Producto] ADD  CONSTRAINT [DF__Producto__Activo__6DEC4894]  DEFAULT ((0)) FOR [Activo]
GO
ALTER TABLE [dbo].[Producto] ADD  CONSTRAINT [DF__Producto__Respon__6EE06CCD]  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[Producto] ADD  CONSTRAINT [DF_Producto_Precio]  DEFAULT ((0)) FOR [Precio]
GO
ALTER TABLE [dbo].[Producto] ADD  CONSTRAINT [DF__Producto__Costo__6FD49106]  DEFAULT ((0)) FOR [Costo]
GO
ALTER TABLE [dbo].[Producto] ADD  CONSTRAINT [DF__Producto__Mostra__70C8B53F]  DEFAULT ((1)) FOR [MostrarEnVenta]
GO
ALTER TABLE [dbo].[Producto] ADD  CONSTRAINT [DF__Producto__Bodega__71BCD978]  DEFAULT (NULL) FOR [Bodega]
GO
ALTER TABLE [dbo].[Producto] ADD  CONSTRAINT [DF_Producto_Area]  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[Producto] ADD  CONSTRAINT [DF_Producto_EliminadoPor]  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[Producto] ADD  CONSTRAINT [DF_Producto_EliminadoFecha]  DEFAULT (NULL) FOR [EliminadoFecha]
GO
ALTER TABLE [dbo].[Producto] ADD  CONSTRAINT [DF__Producto__GenVer__72B0FDB1]  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Proveedor] ADD  DEFAULT (NULL) FOR [Proveedor]
GO
ALTER TABLE [dbo].[Proveedor] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Proveedor] ADD  DEFAULT ((0)) FOR [Mensual]
GO
ALTER TABLE [dbo].[Proveedor] ADD  DEFAULT ((0)) FOR [MensualMonto]
GO
ALTER TABLE [dbo].[Proveedor] ADD  DEFAULT (NULL) FOR [MensualConcepto]
GO
ALTER TABLE [dbo].[Proveedor] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Recordatorio] ADD  DEFAULT (NULL) FOR [Usuario]
GO
ALTER TABLE [dbo].[Recordatorio] ADD  DEFAULT ((0)) FOR [NoMostrar]
GO
ALTER TABLE [dbo].[Recordatorio] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Recordatorio] ADD  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[Recordatorio] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Recordatorio] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Referencia] ADD  DEFAULT (NULL) FOR [Referencia]
GO
ALTER TABLE [dbo].[Referencia] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Referencia] ADD  DEFAULT (NULL) FOR [DoctorRef]
GO
ALTER TABLE [dbo].[Referencia] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[Referencia] ADD  DEFAULT (NULL) FOR [Doctor]
GO
ALTER TABLE [dbo].[Referencia] ADD  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[Referencia] ADD  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[Referencia] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Referencia] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Referencia] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[ReferenciaDetalle] ADD  DEFAULT (NULL) FOR [Referencia]
GO
ALTER TABLE [dbo].[ReferenciaDetalle] ADD  DEFAULT (NULL) FOR [TratamientoRef]
GO
ALTER TABLE [dbo].[ReferenciaDetalle] ADD  DEFAULT ((0)) FOR [Seleccion]
GO
ALTER TABLE [dbo].[ReferenciaDetalle] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[ReferenciaPieza] ADD  DEFAULT (NULL) FOR [Referencia]
GO
ALTER TABLE [dbo].[ReferenciaPieza] ADD  DEFAULT (NULL) FOR [TratamientoRef]
GO
ALTER TABLE [dbo].[ReferenciaPieza] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[RefOtro] ADD  DEFAULT (NULL) FOR [RefOtro]
GO
ALTER TABLE [dbo].[RefOtro] ADD  DEFAULT (NULL) FOR [TipoRefOtro]
GO
ALTER TABLE [dbo].[RefOtro] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[RefOtro] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[RegCortes] ADD  DEFAULT (NULL) FOR [Ejecutor]
GO
ALTER TABLE [dbo].[RegCortes] ADD  DEFAULT ((0)) FOR [Ejecutado]
GO
ALTER TABLE [dbo].[RegCortes] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[RegCortes] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[RegCortes] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[RegCortesM] ADD  DEFAULT (NULL) FOR [Ejecutor]
GO
ALTER TABLE [dbo].[RegCortesM] ADD  DEFAULT ((0)) FOR [Ejecutado]
GO
ALTER TABLE [dbo].[RegCortesM] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[RegCortesM] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[RegCortesM] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[RegFixMail] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[RegFixMail] ADD  DEFAULT (getdate()) FOR [Hora]
GO
ALTER TABLE [dbo].[RegFixMail] ADD  DEFAULT ((0)) FOR [Cliente]
GO
ALTER TABLE [dbo].[RegFixMail] ADD  DEFAULT (NULL) FOR [Usuario]
GO
ALTER TABLE [dbo].[RegFixMail] ADD  DEFAULT (NULL) FOR [Estado]
GO
ALTER TABLE [dbo].[RegFixMail] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[RegFixMail] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[RegFixMail] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Reporte Clientes Config] ADD  DEFAULT (NULL) FOR [ID]
GO
ALTER TABLE [dbo].[Reporte Clientes Config] ADD  DEFAULT ((0)) FOR [Fechas]
GO
ALTER TABLE [dbo].[Reporte Clientes Config] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[ReporteClientes] ADD  DEFAULT (NULL) FOR [Terminal]
GO
ALTER TABLE [dbo].[ReporteClientes] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[ReporteClientes] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (NULL) FOR [Requerimiento]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (NULL) FOR [Tipo]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (getdate()) FOR [Hora]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (NULL) FOR [ResponsableCobro]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (NULL) FOR [Usuario]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT ((0)) FOR [Hecho]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (NULL) FOR [HechoPor]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT ((0)) FOR [Pendiente]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (NULL) FOR [AutorizadoPor]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (NULL) FOR [AutorizadoTerminal]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Requerimiento] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[RequestDetalle] ADD  DEFAULT (NULL) FOR [Request]
GO
ALTER TABLE [dbo].[RequestDetalle] ADD  DEFAULT (NULL) FOR [ID1]
GO
ALTER TABLE [dbo].[RequestDetalle] ADD  DEFAULT (NULL) FOR [ID2]
GO
ALTER TABLE [dbo].[RequestDetalle] ADD  DEFAULT (NULL) FOR [ID3]
GO
ALTER TABLE [dbo].[RequestDetalle] ADD  DEFAULT (NULL) FOR [ID4]
GO
ALTER TABLE [dbo].[RequestDetalle] ADD  DEFAULT (NULL) FOR [ID5]
GO
ALTER TABLE [dbo].[RequestDetalle] ADD  DEFAULT ((0)) FOR [Monto1]
GO
ALTER TABLE [dbo].[RequestDetalle] ADD  DEFAULT ((0)) FOR [Monto2]
GO
ALTER TABLE [dbo].[RequestDetalle] ADD  DEFAULT ((0)) FOR [Monto3]
GO
ALTER TABLE [dbo].[RequestDetalle] ADD  DEFAULT ((0)) FOR [Monto4]
GO
ALTER TABLE [dbo].[RequestDetalle] ADD  DEFAULT ((0)) FOR [Monto5]
GO
ALTER TABLE [dbo].[RequestDetalle] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[RespuestaCita] ADD  DEFAULT (NULL) FOR [RespuestaCita]
GO
ALTER TABLE [dbo].[RespuestaCita] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[RespuestaCita] ADD  DEFAULT ((0)) FOR [ContactarDespues]
GO
ALTER TABLE [dbo].[RespuestaCita] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Revaluacion] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[Revaluacion] ADD  DEFAULT (datepart(month,dateadd(month,(6),getdate()))) FOR [Mes]
GO
ALTER TABLE [dbo].[Revaluacion] ADD  DEFAULT (datepart(year,dateadd(month,(6),getdate()))) FOR [Anyo]
GO
ALTER TABLE [dbo].[Revaluacion] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Revaluacion] ADD  DEFAULT ((0)) FOR [TieneCita]
GO
ALTER TABLE [dbo].[Revaluacion] ADD  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[Revaluacion] ADD  DEFAULT (NULL) FOR [CitadoPor]
GO
ALTER TABLE [dbo].[Revaluacion] ADD  DEFAULT (getdate()) FOR [FechaCreado]
GO
ALTER TABLE [dbo].[Revaluacion] ADD  DEFAULT (getdate()) FOR [HoraCreado]
GO
ALTER TABLE [dbo].[Revaluacion] ADD  DEFAULT (NULL) FOR [Doctor]
GO
ALTER TABLE [dbo].[Revaluacion] ADD  DEFAULT (NULL) FOR [TipoRevaluacion]
GO
ALTER TABLE [dbo].[Revaluacion] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[SelDoctor] ADD  DEFAULT (NULL) FOR [Terminal]
GO
ALTER TABLE [dbo].[SelDoctor] ADD  DEFAULT (NULL) FOR [Doctor]
GO
ALTER TABLE [dbo].[SelDoctor] ADD  DEFAULT ((0)) FOR [Seleccion]
GO
ALTER TABLE [dbo].[SelDoctor] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[SelUsuario] ADD  CONSTRAINT [DF_SelUsuario_Seleccion]  DEFAULT ((0)) FOR [Seleccion]
GO
ALTER TABLE [dbo].[ServerIndex] ADD  DEFAULT (NULL) FOR [Tipo]
GO
ALTER TABLE [dbo].[ServerIndex] ADD  DEFAULT (NULL) FOR [Clave1]
GO
ALTER TABLE [dbo].[ServerIndex] ADD  DEFAULT (NULL) FOR [Clave2]
GO
ALTER TABLE [dbo].[ServerIndex] ADD  DEFAULT (NULL) FOR [Long1]
GO
ALTER TABLE [dbo].[ServerIndex] ADD  DEFAULT (NULL) FOR [Long2]
GO
ALTER TABLE [dbo].[ServerIndex] ADD  DEFAULT ((0)) FOR [Double1]
GO
ALTER TABLE [dbo].[ServerIndex] ADD  DEFAULT ((0)) FOR [Double2]
GO
ALTER TABLE [dbo].[ServerIndex] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT (NULL) FOR [Servicio]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT ((0)) FOR [Costo]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT ((0)) FOR [Brackets]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT ((0)) FOR [Especial]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT ((0)) FOR [OldService]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT ((0)) FOR [Registros]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT ((0)) FOR [Retenedores]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT (NULL) FOR [CreadoPor]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT (getdate()) FOR [FechaCreado]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT ((1)) FOR [EsNuevo]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[Servicio] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT (NULL) FOR [Sesion]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT (getdate()) FOR [Hora]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT (NULL) FOR [TipoSerie]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT (NULL) FOR [TipoSesion]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT (NULL) FOR [DesbloqueadoPor]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT ((0)) FOR [Grabado]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT ((1)) FOR [SerieCompleta]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Sesion] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Sillon] ADD  CONSTRAINT [DF__Sillon__Area__2042BE37]  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[Sillon] ADD  CONSTRAINT [DF__Sillon__Color__2136E270]  DEFAULT ((16777215)) FOR [Color]
GO
ALTER TABLE [dbo].[Sillon] ADD  CONSTRAINT [DF__Sillon__DoctorEx__222B06A9]  DEFAULT (NULL) FOR [DoctorExclusivo]
GO
ALTER TABLE [dbo].[Sillon] ADD  CONSTRAINT [DF__Sillon__GenVersi__231F2AE2]  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Sillon] ADD  CONSTRAINT [DF_Sillon_Mostrar]  DEFAULT ((1)) FOR [Mostrar]
GO
ALTER TABLE [dbo].[tCobrosAgenda] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[tCobrosAgenda] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[tCobrosAgenda] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[tCobrosAgenda] ADD  DEFAULT ((0)) FOR [Monto1]
GO
ALTER TABLE [dbo].[tCobrosAgenda] ADD  DEFAULT ((0)) FOR [Monto2]
GO
ALTER TABLE [dbo].[Temp] ADD  DEFAULT (NULL) FOR [Long01]
GO
ALTER TABLE [dbo].[Temp] ADD  DEFAULT (NULL) FOR [Long02]
GO
ALTER TABLE [dbo].[Temp] ADD  DEFAULT (NULL) FOR [Long03]
GO
ALTER TABLE [dbo].[Temp] ADD  DEFAULT ((0)) FOR [Double01]
GO
ALTER TABLE [dbo].[Temp] ADD  DEFAULT ((0)) FOR [Double02]
GO
ALTER TABLE [dbo].[Temp] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Temp] ADD  DEFAULT (NULL) FOR [Terminal]
GO
ALTER TABLE [dbo].[TempArchivo] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[TempArchivo] ADD  DEFAULT (getdate()) FOR [FechaTran]
GO
ALTER TABLE [dbo].[TempArchivo] ADD  DEFAULT (getdate()) FOR [HoraTran]
GO
ALTER TABLE [dbo].[TempArchivo] ADD  DEFAULT ((0)) FOR [Updated]
GO
ALTER TABLE [dbo].[TempArchivo] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Termino] ADD  DEFAULT ((1)) FOR [Mostrar]
GO
ALTER TABLE [dbo].[Termino] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoCheque] ADD  CONSTRAINT [DF_TipoCheque_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TipoCita] ADD  DEFAULT (NULL) FOR [TipoCita]
GO
ALTER TABLE [dbo].[TipoCita] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TipoCita] ADD  DEFAULT ((0)) FOR [Especial]
GO
ALTER TABLE [dbo].[TipoCita] ADD  DEFAULT ((0)) FOR [EliminarAparato]
GO
ALTER TABLE [dbo].[TipoCita] ADD  DEFAULT ((0)) FOR [Retenedor]
GO
ALTER TABLE [dbo].[TipoCita] ADD  DEFAULT ((0)) FOR [Resaltar]
GO
ALTER TABLE [dbo].[TipoCita] ADD  DEFAULT ((0)) FOR [ParaFotos]
GO
ALTER TABLE [dbo].[TipoCita] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoCitaEspecial] ADD  DEFAULT (NULL) FOR [TipoCitaEspecial]
GO
ALTER TABLE [dbo].[TipoCitaEspecial] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TipoCitaEspecial] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoCitaEspecial_TipoCita] ADD  DEFAULT (NULL) FOR [TipoCita]
GO
ALTER TABLE [dbo].[TipoCitaEspecial_TipoCita] ADD  DEFAULT (NULL) FOR [TipoCitaEspecial]
GO
ALTER TABLE [dbo].[TipoCitaEspecial_TipoCita] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoCliente] ADD  DEFAULT (NULL) FOR [TipoCliente]
GO
ALTER TABLE [dbo].[TipoCliente] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoCobro] ADD  DEFAULT (NULL) FOR [TipoCobro]
GO
ALTER TABLE [dbo].[TipoCobro] ADD  DEFAULT ((0)) FOR [Especial]
GO
ALTER TABLE [dbo].[TipoCobro] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TipoCobro] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoComando] ADD  DEFAULT ((0)) FOR [TipoComando]
GO
ALTER TABLE [dbo].[TipoComando] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoEmpleado] ADD  DEFAULT ((0)) FOR [EsMesero]
GO
ALTER TABLE [dbo].[TipoEmpleado] ADD  DEFAULT ((0)) FOR [SueldoBase]
GO
ALTER TABLE [dbo].[TipoEmpleado] ADD  DEFAULT ((125.05)) FOR [Bonificacion]
GO
ALTER TABLE [dbo].[TipoEmpleado] ADD  DEFAULT ((0)) FOR [SueldoHora]
GO
ALTER TABLE [dbo].[TipoEmpleado] ADD  DEFAULT ((0)) FOR [SueldoHoraFeriado]
GO
ALTER TABLE [dbo].[TipoEmpleado] ADD  DEFAULT ((0)) FOR [SueldoHoraExtra]
GO
ALTER TABLE [dbo].[TipoEmpleado] ADD  DEFAULT ((8)) FOR [HorasDiarias]
GO
ALTER TABLE [dbo].[TipoEmpleado] ADD  DEFAULT ((1)) FOR [EsSueldoBase]
GO
ALTER TABLE [dbo].[TipoEmpleado] ADD  DEFAULT ((0)) FOR [EsSueldoHora]
GO
ALTER TABLE [dbo].[TipoEmpleado] ADD  DEFAULT ((999999)) FOR [Orden]
GO
ALTER TABLE [dbo].[TipoEmpleado] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TipoEmpleado] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoExtra] ADD  DEFAULT (NULL) FOR [TipoExtra]
GO
ALTER TABLE [dbo].[TipoExtra] ADD  DEFAULT ((0)) FOR [Factor]
GO
ALTER TABLE [dbo].[TipoExtra] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TipoExtra] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoFechaEspecial] ADD  DEFAULT (NULL) FOR [TipoFechaEspecial]
GO
ALTER TABLE [dbo].[TipoFechaEspecial] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoGasto] ADD  DEFAULT (NULL) FOR [TipoGasto]
GO
ALTER TABLE [dbo].[TipoGasto] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoHorario] ADD  DEFAULT (NULL) FOR [TipoHorario]
GO
ALTER TABLE [dbo].[TipoHorario] ADD  DEFAULT (NULL) FOR [DiaIni]
GO
ALTER TABLE [dbo].[TipoHorario] ADD  DEFAULT (NULL) FOR [MesIni]
GO
ALTER TABLE [dbo].[TipoHorario] ADD  DEFAULT (NULL) FOR [DiaFin]
GO
ALTER TABLE [dbo].[TipoHorario] ADD  DEFAULT (NULL) FOR [MesFin]
GO
ALTER TABLE [dbo].[TipoHorario] ADD  DEFAULT ((0)) FOR [Especial]
GO
ALTER TABLE [dbo].[TipoHorario] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoMovimientoProducto] ADD  DEFAULT (NULL) FOR [TipoMovimientoProducto]
GO
ALTER TABLE [dbo].[TipoMovimientoProducto] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TipoMovimientoProducto] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoPlanilla] ADD  DEFAULT (NULL) FOR [TipoPlanilla]
GO
ALTER TABLE [dbo].[TipoPlanilla] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TipoPlanilla] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoRefOtro] ADD  DEFAULT (NULL) FOR [TipoRefOtro]
GO
ALTER TABLE [dbo].[TipoRefOtro] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TipoRefOtro] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoRevaluacion] ADD  DEFAULT (NULL) FOR [TipoRevaluacion]
GO
ALTER TABLE [dbo].[TipoRevaluacion] ADD  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[TipoRevaluacion] ADD  DEFAULT (NULL) FOR [TipoCita]
GO
ALTER TABLE [dbo].[TipoRevaluacion] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoSesion] ADD  DEFAULT (NULL) FOR [TipoSesion]
GO
ALTER TABLE [dbo].[TipoSesion] ADD  DEFAULT ((0)) FOR [NumFotos]
GO
ALTER TABLE [dbo].[TipoSesion] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoSesionFotos] ADD  DEFAULT (NULL) FOR [TipoSesion]
GO
ALTER TABLE [dbo].[TipoSesionFotos] ADD  DEFAULT (NULL) FOR [NumFoto]
GO
ALTER TABLE [dbo].[TipoSesionFotos] ADD  DEFAULT ((0)) FOR [Orden]
GO
ALTER TABLE [dbo].[TipoSesionFotos] ADD  DEFAULT ((0)) FOR [Sup]
GO
ALTER TABLE [dbo].[TipoSesionFotos] ADD  DEFAULT ((0)) FOR [Izq]
GO
ALTER TABLE [dbo].[TipoSesionFotos] ADD  DEFAULT ((0)) FOR [Ancho]
GO
ALTER TABLE [dbo].[TipoSesionFotos] ADD  DEFAULT ((0)) FOR [Alto]
GO
ALTER TABLE [dbo].[TipoSesionFotos] ADD  DEFAULT ((0)) FOR [FlipH]
GO
ALTER TABLE [dbo].[TipoSesionFotos] ADD  DEFAULT ((0)) FOR [FlipV]
GO
ALTER TABLE [dbo].[TipoSesionFotos] ADD  DEFAULT ((0)) FOR [FlipD]
GO
ALTER TABLE [dbo].[TipoSesionFotos] ADD  DEFAULT ((0)) FOR [FlipI]
GO
ALTER TABLE [dbo].[TipoSesionFotos] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoTratamiento] ADD  DEFAULT ((0)) FOR [TipoTratamiento]
GO
ALTER TABLE [dbo].[TipoTratamiento] ADD  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[TipoTratamiento] ADD  DEFAULT ((0)) FOR [Especial]
GO
ALTER TABLE [dbo].[TipoTratamiento] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TipoTratamiento] ADD  DEFAULT (NULL) FOR [CreadoPor]
GO
ALTER TABLE [dbo].[TipoTratamiento] ADD  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[TipoTratamiento] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoUsuario] ADD  DEFAULT (NULL) FOR [TipoUsuario]
GO
ALTER TABLE [dbo].[TipoUsuario] ADD  DEFAULT ((0)) FOR [DBA]
GO
ALTER TABLE [dbo].[TipoUsuario] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TipoUsuario Comando] ADD  DEFAULT (NULL) FOR [TipoUsuario]
GO
ALTER TABLE [dbo].[TipoUsuario Comando] ADD  DEFAULT (NULL) FOR [Comando]
GO
ALTER TABLE [dbo].[TipoUsuario Comando] ADD  DEFAULT ((1)) FOR [Seleccion]
GO
ALTER TABLE [dbo].[TipoUsuario Comando] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[TParametro] ADD  CONSTRAINT [DF_TParametro_Tipo]  DEFAULT (N'TEXTO') FOR [Tipo]
GO
ALTER TABLE [dbo].[TParametro] ADD  CONSTRAINT [DF_TParametro_EsImpresora]  DEFAULT ((0)) FOR [EsImpresora]
GO
ALTER TABLE [dbo].[TParametro] ADD  CONSTRAINT [DF_TParametro_EsArchivo]  DEFAULT ((0)) FOR [EsArchivo]
GO
ALTER TABLE [dbo].[TParametro] ADD  CONSTRAINT [DF_TParametro_EsCarpeta]  DEFAULT ((0)) FOR [EsCarpeta]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Trabajo__3508D0F3]  DEFAULT (NULL) FOR [Trabajo]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Laborat__35FCF52C]  DEFAULT (NULL) FOR [Laboratorio]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Fecha__36F11965]  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Cliente__37E53D9E]  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Doctor__38D961D7]  DEFAULT (NULL) FOR [Doctor]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Costo__39CD8610]  DEFAULT ((0)) FOR [Costo]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Estado__3AC1AA49]  DEFAULT ((0)) FOR [Estado]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Cheque__3BB5CE82]  DEFAULT (NULL) FOR [Cheque]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Activo__3CA9F2BB]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Respons__3D9E16F4]  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Ingresa__3E923B2D]  DEFAULT ((0)) FOR [Ingresado]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Debloqu__3F865F66]  DEFAULT (NULL) FOR [DebloqueadoPor]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Elimina__407A839F]  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__Selecci__416EA7D8]  DEFAULT (NULL) FOR [Seleccion]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__PreSele__4262CC11]  DEFAULT ((0)) FOR [PreSeleccion]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF_Trabajo_ClavePago]  DEFAULT (NULL) FOR [ClavePago]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__GenVers__4356F04A]  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__FechaVa__444B1483]  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF__Trabajo__HoraVal__453F38BC]  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF_Trabajo_ClavePagoConceptoCh]  DEFAULT (NULL) FOR [ClavePagoConceptoCh]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF_Trabajo_EsClavePago]  DEFAULT ((0)) FOR [EsClavePago]
GO
ALTER TABLE [dbo].[Trabajo] ADD  CONSTRAINT [DF_Trabajo_ListoParaCheque]  DEFAULT ((0)) FOR [ListoParaCheque]
GO
ALTER TABLE [dbo].[Transaccion] ADD  DEFAULT (NULL) FOR [Usuario]
GO
ALTER TABLE [dbo].[Transaccion] ADD  DEFAULT (NULL) FOR [Ejecutor]
GO
ALTER TABLE [dbo].[Transaccion] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Transaccion] ADD  DEFAULT (getdate()) FOR [Hora]
GO
ALTER TABLE [dbo].[Transaccion] ADD  DEFAULT (NULL) FOR [Monto]
GO
ALTER TABLE [dbo].[Transaccion] ADD  DEFAULT (NULL) FOR [Ref1]
GO
ALTER TABLE [dbo].[Transaccion] ADD  DEFAULT (NULL) FOR [Ref2]
GO
ALTER TABLE [dbo].[Transaccion] ADD  DEFAULT (NULL) FOR [Ref3]
GO
ALTER TABLE [dbo].[Transaccion] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Transaccion] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[Transaccion] ADD  DEFAULT (NULL) FOR [HoraVal]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (NULL) FOR [Tratamiento]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (NULL) FOR [Area]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (NULL) FOR [Cliente]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (NULL) FOR [Doctor]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [Costo]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [Descuento]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [Facturado]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [Total]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [PagoInicial]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [NumCuotas]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [MontoCuota]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [Retenedores]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [Registros]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [Bloqueado]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (NULL) FOR [TipoTratamiento]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [OldSystem]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (NULL) FOR [EliminadoPor]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (getdate()) FOR [FechaIngreso]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (getdate()) FOR [HoraIngreso]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (NULL) FOR [DesbloqueadoPor]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [PreguntarFacturado]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [EsAparato]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [PagoFinal]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (NULL) FOR [CatalogoTratamiento]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [Terminado]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (NULL) FOR [TerminadoPor]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Tratamiento] ADD  DEFAULT (NULL) FOR [FechaVal]
GO
ALTER TABLE [dbo].[TratamientoRef] ADD  DEFAULT (NULL) FOR [TratamientoRef]
GO
ALTER TABLE [dbo].[TratamientoRef] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TratamientoRef] ADD  DEFAULT (NULL) FOR [Responsable]
GO
ALTER TABLE [dbo].[TratamientoRef] ADD  DEFAULT ((1)) FOR [EsNuevo]
GO
ALTER TABLE [dbo].[TratamientoRef] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF__Usuario__TipoUsu__7AA72534]  DEFAULT (NULL) FOR [TipoUsuario]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_Recepcionista]  DEFAULT ((0)) FOR [Recepcionista]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF__Usuario__Activo__7B9B496D]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF__Usuario__GenVers__7C8F6DA6]  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_MaxRegistros]  DEFAULT ((50)) FOR [MaxRegistros]
GO
ALTER TABLE [dbo].[UsuarioBodega] ADD  DEFAULT (NULL) FOR [Usuario]
GO
ALTER TABLE [dbo].[UsuarioBodega] ADD  DEFAULT (NULL) FOR [Bodega]
GO
ALTER TABLE [dbo].[UsuarioBodega] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[Usuarios Grafica temp] ADD  DEFAULT (NULL) FOR [Terminal]
GO
ALTER TABLE [dbo].[Usuarios Grafica temp] ADD  DEFAULT ((0)) FOR [Valor]
GO
ALTER TABLE [dbo].[Usuarios Grafica temp] ADD  DEFAULT ((0)) FOR [Max]
GO
ALTER TABLE [dbo].[Usuarios Grafica temp] ADD  DEFAULT ((0)) FOR [GenVersion]
GO
ALTER TABLE [dbo].[WSComando] ADD  CONSTRAINT [DF_WSComando_Configurable]  DEFAULT ((1)) FOR [Configurable]
GO
ALTER TABLE [dbo].[WSComando] ADD  CONSTRAINT [DF_WSComando_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[WSPanel] ADD  CONSTRAINT [DF_WSPanel_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[WSTipoUsuarioComando] ADD  CONSTRAINT [DF_WSTipoUsuarioComando_Seleccion]  DEFAULT ((1)) FOR [Seleccion]
GO
ALTER TABLE [dbo].[planilla_empleado]  WITH CHECK ADD  CONSTRAINT [FK_planilla_empleado_Empleado] FOREIGN KEY([corrEmpleado])
REFERENCES [dbo].[Empleado] ([Empleado])
GO
ALTER TABLE [dbo].[planilla_empleado] CHECK CONSTRAINT [FK_planilla_empleado_Empleado]
GO
ALTER TABLE [dbo].[planilla_empleado]  WITH CHECK ADD  CONSTRAINT [FK_planilla_empleado_planilla_total] FOREIGN KEY([corrPlanilla])
REFERENCES [dbo].[planilla_total] ([correlativo])
GO
ALTER TABLE [dbo].[planilla_empleado] CHECK CONSTRAINT [FK_planilla_empleado_planilla_total]
GO
ALTER TABLE [dbo].[planilla_empleado_rubro]  WITH CHECK ADD  CONSTRAINT [FK_planilla_empleado_rubro_planilla_empleado] FOREIGN KEY([corrPlanillaEmp])
REFERENCES [dbo].[planilla_empleado] ([correlativo])
GO
ALTER TABLE [dbo].[planilla_empleado_rubro] CHECK CONSTRAINT [FK_planilla_empleado_rubro_planilla_empleado]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'ConeccionActual'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'ConeccionActual'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3240 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'ConeccionActual'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'SucursalID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'SucursalID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1125 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'SucursalID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'SucursalNombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'SucursalNombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1620 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'SucursalNombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'Path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'Path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1425 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'Path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'SucursalTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'SucursalTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'SucursalTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'TituloVentanas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'TituloVentanas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1470 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'TituloVentanas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'CamaraFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'CamaraFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1665 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'CamaraFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'Modulo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'Modulo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'Modulo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'Igss'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'Igss'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'Igss'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'UltImpSemanal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'UltImpSemanal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'UltImpSemanal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'UltBackUpVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'UltBackUpVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1395 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'UltBackUpVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'ForceShutDown'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'ForceShutDown'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1560 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'ForceShutDown'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'RestartTV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'RestartTV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config', @level2type=N'COLUMN',@level2name=N'RestartTV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'Mensajes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'Mensajes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'Mensajes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1950 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2400 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2400 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=10035 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_StatusSincro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal', @level2type=N'COLUMN',@level2name=N'Archivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal', @level2type=N'COLUMN',@level2name=N'Archivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3120 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal', @level2type=N'COLUMN',@level2name=N'Archivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArchTemporal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2610 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'BitacoraCartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'BitacoraCartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'BitacoraCartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'CartaEspDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'CartaEspDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'CartaEspDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2400 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'FechaCarta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'FechaCarta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'FechaCarta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Contenido'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Contenido'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Contenido'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Firma'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Firma'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Firma'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'DocImprimir'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'DocImprimir'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'DocImprimir'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Titulo1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Titulo1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3945 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'Titulo1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BitacoraCartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2400 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'Des'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'Des'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'Des'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BloqueoEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega', @level2type=N'COLUMN',@level2name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega', @level2type=N'COLUMN',@level2name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega', @level2type=N'COLUMN',@level2name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1590 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'BuscarCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'BuscarCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1140 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'BuscarCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2715 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'Buscar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'Buscar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'Buscar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuscarCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo', @level2type=N'COLUMN',@level2name=N'Cargo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo', @level2type=N'COLUMN',@level2name=N'Cargo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo', @level2type=N'COLUMN',@level2name=N'Cargo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2745 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cargo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3660 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'TextoRecibo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'TextoRecibo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=4590 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'TextoRecibo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'Texto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'Texto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3495 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'Texto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'TextoMenor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'TextoMenor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'TextoMenor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'Firma'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'Firma'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'Firma'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'MostrarEnMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'MostrarEnMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'MostrarEnMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'DocImprimir'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'DocImprimir'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'DocImprimir'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'Titulo1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'Titulo1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'Titulo1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'PedirParametros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'PedirParametros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=4425 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'PedirParametros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'EjecutarWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'EjecutarWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=5940 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'EjecutarWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'EjecutarWordMenor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'EjecutarWordMenor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=4920 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'EjecutarWordMenor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'ImprimeSinWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'ImprimeSinWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp', @level2type=N'COLUMN',@level2name=N'ImprimeSinWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_RowHeight', @value=1740 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=1000000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CartaEsp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Chat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Chat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Chat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Origen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Origen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Origen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Destino'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Destino'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Destino'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'TerminalOrigen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'TerminalOrigen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'TerminalOrigen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'TerminalDestino'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'TerminalDestino'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'TerminalDestino'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Mensaje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Mensaje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Mensaje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Leido'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Leido'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Leido'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Limpiar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Limpiar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'Limpiar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'Chat.Chat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=1000000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Cheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Cheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Cheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2400 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'NumCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'NumCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1245 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'NumCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'TipoCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'TipoCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1200 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'TipoCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'ConceptoCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'ConceptoCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1665 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'ConceptoCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Proveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Proveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1035 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Proveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Referencia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Referencia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=7065 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Referencia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Monto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Monto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=870 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Monto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Ingresado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Ingresado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1020 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Ingresado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Anulado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Anulado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=885 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Anulado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=705 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Eliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Eliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1035 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Eliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1305 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'AnuladoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'AnuladoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'AnuladoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'TipoGasto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'TipoGasto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1065 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'TipoGasto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'NoNegociable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'NoNegociable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1380 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'NoNegociable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Pendiente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Pendiente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1050 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Pendiente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Planilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Planilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=810 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Planilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Contribuyente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Contribuyente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'Contribuyente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1005 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'TipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'TipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1170 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'TipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'ClavePago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'ClavePago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1095 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'ClavePago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'NumDoc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'NumDoc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=990 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'NumDoc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'DesClavePago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'DesClavePago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'DesClavePago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'EsDetallado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'EsDetallado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque', @level2type=N'COLUMN',@level2name=N'EsDetallado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Observaciones'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Observaciones'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Observaciones'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Cumplida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Cumplida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Cumplida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Bloqueada'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Bloqueada'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Bloqueada'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'BloqDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'BloqDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'BloqDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'BloqTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'BloqTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'BloqTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'EsAnterior'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'EsAnterior'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'EsAnterior'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'AnteriorNombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'AnteriorNombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'AnteriorNombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'AnteriorTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'AnteriorTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'AnteriorTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'AnteriorTx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'AnteriorTx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'AnteriorTx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Contactar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Contactar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Contactar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Respuesta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Respuesta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'Respuesta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'FechaRecontactar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'FechaRecontactar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'FechaRecontactar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'FechaContacto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'FechaContacto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'FechaContacto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'ContactoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'ContactoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'ContactoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'FechaTran'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'FechaTran'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'FechaTran'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'Cita.Area' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=1000000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Observaciones'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Observaciones'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=750 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Observaciones'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Cumplida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Cumplida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Cumplida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Bloqueada'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Bloqueada'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Bloqueada'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'BloqDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'BloqDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'BloqDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'BloqTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'BloqTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'BloqTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'EsAnterior'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'EsAnterior'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'EsAnterior'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'AnteriorNombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'AnteriorNombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'AnteriorNombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'AnteriorTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'AnteriorTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'AnteriorTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'AnteriorTx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'AnteriorTx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'AnteriorTx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'EliminadaPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'EliminadaPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'EliminadaPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'FechaTrans'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'FechaTrans'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3285 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas', @level2type=N'COLUMN',@level2name=N'FechaTrans'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CitasBorradas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos', @level2type=N'COLUMN',@level2name=N'ClaseFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos', @level2type=N'COLUMN',@level2name=N'ClaseFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos', @level2type=N'COLUMN',@level2name=N'ClaseFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=4050 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ClaseFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=4170 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Direccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Direccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Direccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Telefono'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Telefono'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Telefono'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Nit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Nit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Nit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Foto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Foto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Foto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Revaluacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Revaluacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Revaluacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ReferidoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ReferidoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ReferidoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ReferidoDoctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ReferidoDoctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ReferidoDoctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ReferidoOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ReferidoOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ReferidoOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaExamen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaExamen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaExamen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Problema'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Problema'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Problema'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaNac'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaNac'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaNac'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'EstudiaTrabaja'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'EstudiaTrabaja'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'EstudiaTrabaja'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'GradoPuesto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'GradoPuesto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'GradoPuesto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Carrera'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Carrera'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Carrera'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'DireccionTrabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'DireccionTrabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'DireccionTrabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TelefonoTrabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TelefonoTrabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TelefonoTrabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Dentista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Dentista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Dentista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'CambioGrave'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'CambioGrave'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'CambioGrave'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Medicamento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Medicamento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Medicamento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Embarazo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Embarazo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Embarazo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'EnfermedadGrave'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'EnfermedadGrave'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'EnfermedadGrave'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Observacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Observacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Observacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'UltimoCheckeo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'UltimoCheckeo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'UltimoCheckeo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TratamientoTerminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TratamientoTerminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TratamientoTerminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Accidente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Accidente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Accidente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Habito'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Habito'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Habito'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'PrimeraCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'PrimeraCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'PrimeraCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'SegundaOpinion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'SegundaOpinion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'SegundaOpinion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'OrtoAnteriormente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'OrtoAnteriormente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'OrtoAnteriormente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FamiliaSimilar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FamiliaSimilar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FamiliaSimilar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Expectativa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Expectativa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Expectativa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Padre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Padre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Padre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'OcupacionPadre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'OcupacionPadre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'OcupacionPadre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Madre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Madre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Madre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'OcupacionMadre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'OcupacionMadre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'OcupacionMadre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'NecesidadOdontologica'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'NecesidadOdontologica'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'NecesidadOdontologica'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'DescripcionProblema'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'DescripcionProblema'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'DescripcionProblema'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'PosibleTx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'PosibleTx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'PosibleTx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Facturar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Facturar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Facturar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaIngreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaIngreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaIngreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'HoraIngreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'HoraIngreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'HoraIngreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TipoCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TipoCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TipoCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Nemotec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Nemotec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Nemotec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Carpeta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Carpeta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Carpeta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'GradoColegio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'GradoColegio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'GradoColegio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Seccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Seccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Seccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Aviso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Aviso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Aviso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TelActualizado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TelActualizado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TelActualizado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TelActualizdoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TelActualizdoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'TelActualizdoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FacturaDireccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FacturaDireccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FacturaDireccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FacturaTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FacturaTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FacturaTel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaDigitalizado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaDigitalizado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaDigitalizado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'BloquearOdon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'BloquearOdon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'BloquearOdon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'AvisoInasistencia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'AvisoInasistencia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'AvisoInasistencia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ProxAvisoInasistencia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ProxAvisoInasistencia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ProxAvisoInasistencia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'EmailPadres'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'EmailPadres'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'EmailPadres'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ErrorMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ErrorMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ErrorMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ClaseFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ClaseFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ClaseFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'IDFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'IDFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'IDFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'RecargoInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'RecargoInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'RecargoInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'RecargoInfoResp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'RecargoInfoResp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'RecargoInfoResp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'RecargoInfoFecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'RecargoInfoFecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'RecargoInfoFecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FixMailFecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FixMailFecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FixMailFecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FixMailResp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FixMailResp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FixMailResp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaTran'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaTran'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'FechaTran'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Archivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Archivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'Archivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ArchID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ArchID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'ArchID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'SMSCel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'SMSCel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente', @level2type=N'COLUMN',@level2name=N'SMSCel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'Cliente.Cliente' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=1000000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Comando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Comando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Comando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3825 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Argumento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Argumento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3300 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Argumento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Argumento2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Argumento2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Argumento2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'TipoComando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'TipoComando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'TipoComando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Param'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Param'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Param'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Panel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Panel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Panel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Configurable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Configurable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Configurable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Orden'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Orden'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Orden'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Instalar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Instalar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Instalar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Borrar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Borrar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'Borrar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=1000000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3150 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Conectado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Conectado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Conectado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Recepcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Recepcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'Recepcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'DirRed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'DirRed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'DirRed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'ConeccionFecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'ConeccionFecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2400 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'ConeccionFecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'ConeccionHora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'ConeccionHora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'ConeccionHora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=1000000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConeccionChat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3900 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Direccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Direccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Direccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Telefono'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Telefono'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Telefono'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Nit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Nit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Nit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Titulo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Titulo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Titulo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'VerOrtodoncia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'VerOrtodoncia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'VerOrtodoncia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'VerOdontologia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'VerOdontologia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'VerOdontologia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Utilidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Utilidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'Utilidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2040 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2730 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=1000000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DoctorUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension', @level2type=N'COLUMN',@level2name=N'Extension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension', @level2type=N'COLUMN',@level2name=N'Extension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension', @level2type=N'COLUMN',@level2name=N'Extension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=4395 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Extension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'FacturaCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'FacturaCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'FacturaCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'Cobro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'Cobro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'Cobro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=4845 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'Monto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'Monto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'Monto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FacturaCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Impresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Impresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Impresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'ImpresoraDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'ImpresoraDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3630 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'ImpresoraDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'TipoImpresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'TipoImpresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2070 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'TipoImpresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Host'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Host'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1455 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Host'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Local'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Local'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Local'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Red'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Red'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Red'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Impresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Listado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Listado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Listado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'TipoListado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'TipoListado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'TipoListado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2025 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2400 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'IngresoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'IngresoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'IngresoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'FechaIngreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'FechaIngreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2400 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'FechaIngreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'AtendidoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'AtendidoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'AtendidoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'MinEspera'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'MinEspera'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'MinEspera'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'FechaAtendido'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'FechaAtendido'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'FechaAtendido'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=1000000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Listado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'MailErrorFiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'MailErrorFiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'MailErrorFiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Archivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Archivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2445 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Archivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Mail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Mail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3570 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'Mail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MailErrorFiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'MensajePredef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'MensajePredef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'MensajePredef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Boton'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Boton'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3360 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Boton'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Mensaje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Mensaje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=5820 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Mensaje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'PedirCantidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'PedirCantidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'PedirCantidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'PedirTexto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'PedirTexto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'PedirTexto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Seleccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Seleccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Seleccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'CostoUni'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'CostoUni'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'CostoUni'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Servicio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Servicio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Servicio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Cantidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Cantidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'Cantidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MensajePredef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'MovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'MovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1935 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'MovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'TipoMovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'TipoMovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'TipoMovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2400 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Vale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Vale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Vale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'FechaEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'FechaEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'FechaEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'HoraEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'HoraEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'HoraEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Ingresado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Ingresado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'Ingresado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'MovimientoProductoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'MovimientoProductoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2535 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'MovimientoProductoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'MovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'MovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1935 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'MovimientoProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Producto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Producto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Producto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Ingreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Ingreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Ingreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Salida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Salida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Salida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Contar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Contar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Contar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'FechaEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'FechaEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'FechaEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'HoraEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'HoraEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'HoraEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MovimientoProductoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso', @level2type=N'COLUMN',@level2name=N'Permiso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso', @level2type=N'COLUMN',@level2name=N'Permiso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=4635 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso', @level2type=N'COLUMN',@level2name=N'Permiso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=7755 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'Permiso.Permiso' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Permiso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Producto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Producto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Producto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=7560 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Costo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Costo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Costo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'MostrarEnVenta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'MostrarEnVenta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'MostrarEnVenta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'EliminadoFecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'EliminadoFecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'EliminadoFecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Producto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Proveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Proveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Proveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=5085 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Empresa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Empresa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Empresa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Telefono'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Telefono'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Telefono'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Direccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Direccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Direccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Mensual'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Mensual'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'Mensual'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'PagueseA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'PagueseA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'PagueseA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'MensualDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'MensualDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'MensualDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'MensualMonto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'MensualMonto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'MensualMonto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'MensualConcepto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'MensualConcepto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'MensualConcepto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'Proveedor.Nombre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Proveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Recordatorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Recordatorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Recordatorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Mensaje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Mensaje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=7320 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Mensaje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'NoMostrar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'NoMostrar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'NoMostrar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_RowHeight', @value=540 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Recordatorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'RefOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'RefOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'RefOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3870 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'TipoRefOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'TipoRefOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'TipoRefOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RefOtro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'Ejecutor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'Ejecutor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'Ejecutor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'Ejecutado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'Ejecutado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'Ejecutado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2400 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RegCortes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'Fechas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'Fechas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'Fechas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'Consulta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'Consulta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3690 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'Consulta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'PedirDatos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'PedirDatos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=6465 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'PedirDatos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=1000000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reporte Clientes Config'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'RespuestaCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'RespuestaCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'RespuestaCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2820 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'ContactarDespues'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'ContactarDespues'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'ContactarDespues'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RespuestaCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Color'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Color'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Color'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'DoctorExclusivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'DoctorExclusivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'DoctorExclusivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Titulo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Titulo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1755 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Titulo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Mostrar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Mostrar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon', @level2type=N'COLUMN',@level2name=N'Mostrar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'Sillon.Area' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sillon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3855 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Especial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Especial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Especial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'EliminarAparato'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'EliminarAparato'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'EliminarAparato'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Retenedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Retenedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Retenedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Resaltar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Resaltar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'Resaltar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'ParaFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'ParaFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'ParaFotos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCita'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'TipoHorario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'TipoHorario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'TipoHorario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=4170 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'DiaIni'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'DiaIni'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'DiaIni'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'MesIni'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'MesIni'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'MesIni'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'DiaFin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'DiaFin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'DiaFin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'MesFin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'MesFin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'MesFin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'Especial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'Especial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'Especial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoHorario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla', @level2type=N'COLUMN',@level2name=N'TipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla', @level2type=N'COLUMN',@level2name=N'TipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla', @level2type=N'COLUMN',@level2name=N'TipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3225 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario', @level2type=N'COLUMN',@level2name=N'TipoUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario', @level2type=N'COLUMN',@level2name=N'TipoUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario', @level2type=N'COLUMN',@level2name=N'TipoUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2235 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario', @level2type=N'COLUMN',@level2name=N'DBA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario', @level2type=N'COLUMN',@level2name=N'DBA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario', @level2type=N'COLUMN',@level2name=N'DBA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'TParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'TParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1995 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'TParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'Tipo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'Tipo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1740 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'Tipo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'ValorDef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'ValorDef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2160 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'ValorDef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'EsImpresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'EsImpresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'EsImpresora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'EsArchivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'EsArchivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'EsArchivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'EsCarpeta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'EsCarpeta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'EsCarpeta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'Menu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'Menu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'Menu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'TParametroDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'TParametroDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3645 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'TParametroDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'Orden'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'Orden'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro', @level2type=N'COLUMN',@level2name=N'Orden'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'TParametro.Orden' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Trabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Trabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Trabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Laboratorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Laboratorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Laboratorio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2400 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Cliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Doctor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Costo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Costo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Costo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Estado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Estado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Estado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1950 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Cheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Cheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Cheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Responsable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Ingresado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Ingresado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Ingresado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'DebloqueadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'DebloqueadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'DebloqueadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'FechaDesbloqueado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'FechaDesbloqueado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'FechaDesbloqueado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'HoraDesbloqueado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'HoraDesbloqueado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'HoraDesbloqueado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'EliminadoPor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'FechaEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'FechaEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'FechaEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'HoraEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'HoraEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'HoraEliminado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Seleccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Seleccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'Seleccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'NumFactura'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'NumFactura'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'NumFactura'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'PreSeleccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'PreSeleccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'PreSeleccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'ClavePago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'ClavePago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'ClavePago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'NumDoc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'NumDoc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'NumDoc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'ClavePagoConceptoCh'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'ClavePagoConceptoCh'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2160 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'ClavePagoConceptoCh'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'EsClavePago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'EsClavePago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'EsClavePago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'ListoParaCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'ListoParaCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1665 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo', @level2type=N'COLUMN',@level2name=N'ListoParaCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Trabajo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Transaccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Transaccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Transaccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Permiso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Permiso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2925 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Permiso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Ejecutor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Ejecutor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Ejecutor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Monto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Monto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Monto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Ref1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Ref2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Ref3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Ref3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'Ref3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'FechaVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion', @level2type=N'COLUMN',@level2name=N'HoraVal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3345 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'TipoUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'TipoUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1650 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'TipoUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Recepcionista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Recepcionista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Recepcionista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'Activo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'MaxRegistros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'MaxRegistros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario', @level2type=N'COLUMN',@level2name=N'MaxRegistros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'Usuario.Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=1000000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2250 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega', @level2type=N'COLUMN',@level2name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega', @level2type=N'COLUMN',@level2name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega', @level2type=N'COLUMN',@level2name=N'Bodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega', @level2type=N'COLUMN',@level2name=N'GenVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=100000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UsuarioBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[18] 2[23] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WSTipoUsuarioPermisoAux"
            Begin Extent = 
               Top = 6
               Left = 21
               Bottom = 141
               Right = 181
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Acreditacion"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 147
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'WSFillAcreditacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'WSFillAcreditacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WSTipoUsuarioComandoAux"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 147
               Right = 286
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WSTipoUsuarioComando"
            Begin Extent = 
               Top = 6
               Left = 328
               Bottom = 110
               Right = 579
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'WSFillTipoUsuarioComando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'WSFillTipoUsuarioComando'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TipoUsuario"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WSComando"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 125
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'WSTipoUsuarioComandoAux'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'WSTipoUsuarioComandoAux'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[21] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TipoUsuario"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Permiso"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 139
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'WSTipoUsuarioPermisoAux'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'WSTipoUsuarioPermisoAux'
GO
USE [master]
GO
ALTER DATABASE [ortodental] SET  READ_WRITE 
GO
