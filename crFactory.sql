USE [master]
GO
/****** Object:  Database [creditfactory]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE DATABASE [creditfactory]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'creditfactory', FILENAME = N'C:\Program Files\Microsoft SQL Server 2012\MSSQL11.SQLSERVER2012\MSSQL\DATA\creditfactory.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'creditfactory_log', FILENAME = N'C:\Program Files\Microsoft SQL Server 2012\MSSQL11.SQLSERVER2012\MSSQL\DATA\creditfactory_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [creditfactory] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [creditfactory].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [creditfactory] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [creditfactory] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [creditfactory] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [creditfactory] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [creditfactory] SET ARITHABORT OFF 
GO
ALTER DATABASE [creditfactory] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [creditfactory] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [creditfactory] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [creditfactory] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [creditfactory] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [creditfactory] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [creditfactory] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [creditfactory] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [creditfactory] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [creditfactory] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [creditfactory] SET  DISABLE_BROKER 
GO
ALTER DATABASE [creditfactory] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [creditfactory] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [creditfactory] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [creditfactory] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [creditfactory] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [creditfactory] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [creditfactory] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [creditfactory] SET RECOVERY FULL 
GO
ALTER DATABASE [creditfactory] SET  MULTI_USER 
GO
ALTER DATABASE [creditfactory] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [creditfactory] SET DB_CHAINING OFF 
GO
ALTER DATABASE [creditfactory] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [creditfactory] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'creditfactory', N'ON'
GO
USE [creditfactory]
GO
/****** Object:  UserDefinedDataType [dbo].[estado]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE TYPE [dbo].[estado] FROM [char](2) NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[etapa]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE TYPE [dbo].[etapa] FROM [char](5) NOT NULL
GO
/****** Object:  StoredProcedure [dbo].[bowpi_desembolso_altas_persona]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bowpi_desembolso_altas_persona]
	
    @nombre1              VARCHAR (20) ,
    @nombre2              VARCHAR (20) ,
    @apellido1            VARCHAR (20) ,
    @apellido2            VARCHAR (20) ,
    @apellido_casada      VARCHAR (20) ,
    @fecha_nacimiento     DATETIME     ,
    @genero               CHAR (1)     ,
    @nacionalidad         VARCHAR (20) ,
    @profesion            INT          ,   
    @cedula_orden         CHAR (3)     ,
    @cedula_registro      INT          ,
    @nit                  VARCHAR (15) ,
	@estado_civil         CHAR (1)     ,
    @num_dependientes     SMALLINT     ,
	@cui                  VARCHAR (13) ,
    @cod_empresa          TINYINT
AS

declare @cod_persona INT


select @cod_persona = max(cod_persona) + 1 from [dbo].[pe_persona];

	INSERT INTO [dbo].[pe_persona] (
    [cod_persona]          ,
    [nombre1]              ,
    [nombre2]              ,
    [apellido1]            ,
    [apellido2]            ,
    [apellido_casada]      ,
    [fecha_nacimiento]     ,
    [genero]               ,
    [nacionalidad]         ,
    [profesion]            ,
    [cedula_orden]         ,
    [cedula_registro]      ,    
    [nit]                  ,
    [estado_civil]         ,
    [num_dependientes]     ,    
    [cui]                  ,
    [cod_empresa]          
)
VALUES
(    @cod_persona         ,
    @nombre1             ,
    @nombre2             ,
    @apellido1           ,
    @apellido2           ,
    @apellido_casada     ,
    @fecha_nacimiento    ,
    @genero              ,
    @nacionalidad        ,
    @profesion           ,    
    @cedula_orden        ,
    @cedula_registro     ,    
    @nit                 ,
    @estado_civil        ,
    @num_dependientes    ,    
    @cui                 ,
    @cod_empresa         
)



RETURN 0


GO
/****** Object:  StoredProcedure [dbo].[sp_asignacion_emision]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_asignacion_emision]  
		 
@i_tipoProducto	varchar(5)
,@i_origen	        varchar(5)
,@i_canalCaptura	 varchar(10) = null
,@i_reestructuracion char(1) = null
,@i_limiteCredito money = null
--action
,@o_secuencia int = null output
,@o_califica char(1) = null output
,@o_codigoEmision varchar(10) = null output --,inTO.setCodigoEmision("$param");	
,@o_descripcionEmision varchar(200) = null output --inTO.setDescripcionEmision("$param");	
,@o_campoRechazado varchar(200) = null output
--inTO.addCampoRechazado("$param");


as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int

begin
	  
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
    
    if @i_tipoProducto = 'PRE'
	begin
	    if @i_origen = 'SIPSA'
		begin
		   if @i_limiteCredito > 1001
		   begin
		      select @o_califica = 'S'
		   end
		   else
		   begin
		      select @o_califica = 'N'
			        , @o_campoRechazado = 'LIMITE DE CREDITO BAJO'
		   end
		end
	end
	


return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end	

GO
/****** Object:  StoredProcedure [dbo].[sp_asignacion_etapas_flujo_persona]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_asignacion_etapas_flujo_persona]  
		 
	@i_tipoProducto	 varchar(4) = null
	,@i_secuencia	 int = null
	,@i_origen	     varchar(10) = null
	,@i_canalCaptura	 varchar(20) = null	
	,@i_campania	     varchar(10) = null
	,@i_promocion	 varchar(10) = null
	,@i_rol	         varchar(30) = null
	,@i_montoCredito  money = null
    --Actions
	,@o_descripcion   varchar(100) = null output
    ,@o_secuencia     int = null output

as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
	  
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'

begin       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
    
	/* ESTO NO APLICA, NO SE ESTAN GESTIONANDO TRAMITES DE BANRURAL.
	if @i_tipoProducto  = 'PRE' and @i_origen = 'BANRURAL' and @i_canalCaptura = 'MENSAJE_COLA'
	begin
	    if @i_secuencia = 5001
	    begin
		    
		end
	end
*/
    create table #temp (
	   etapa varchar(10)
	   , valor varchar(10)
	)
    if @i_tipoProducto  = 'PRE' and @i_origen = 'SIPSA' and @i_canalCaptura = 'MANUAL'
	begin
	    if @i_rol = 'SOLICITANTE'
		begin
		   select @o_descripcion = 'Solicitud de prestamos microfinanzas'
		         ,@o_secuencia   = 7000				 
			insert into #temp (etapa, valor) values ('SAT', '2|15')
			insert into #temp (etapa, valor) values ('POI', '3|15')	
			insert into #temp (etapa, valor) values ('OFC', '4|15')
			insert into #temp (etapa, valor) values ('LTN', '5|15')
			insert into #temp (etapa, valor) values ('AFR', '6|15')
			insert into #temp (etapa, valor) values ('BPTC', '8|15')
			insert into #temp (etapa, valor) values ('BSP', '9|15')
			insert into #temp (etapa, valor) values ('BBR', '10|15')
			insert into #temp (etapa, valor) values ('TRN', '13|15')
			insert into #temp (etapa, valor) values ('CRD', '14|15')     
		end
		
		if @i_rol = 'FIADOR'
		begin
		   select @o_secuencia = 7001
           insert into #temp (etapa, valor) values ('SAT', '2|15')
			insert into #temp (etapa, valor) values ('POI', '3|15')	
			insert into #temp (etapa, valor) values ('OFC', '4|15')
			insert into #temp (etapa, valor) values ('LTN', '5|15')
			insert into #temp (etapa, valor) values ('AFR', '6|15')
			insert into #temp (etapa, valor) values ('BPTC', '8|15')
			insert into #temp (etapa, valor) values ('BSP', '9|15')
			insert into #temp (etapa, valor) values ('BBR', '10|15')
			insert into #temp (etapa, valor) values ('TRN', '13|15')
			insert into #temp (etapa, valor) values ('CRD', '14|15')
		end
		
		if @i_rol = 'ADICIONALES'
		begin
		   select @o_secuencia = 7002
           insert into #temp (etapa, valor) values ('OFC', '4|15')
		   insert into #temp (etapa, valor) values ('LTN', '5|15')		   
		end
		
		if @i_rol = 'REFERENCIA'
		begin
		    select @o_secuencia = 7003
			insert into #temp (etapa, valor) values ('OFC', '4|15')
			insert into #temp (etapa, valor) values ('LTN', '5|15')			
		end
		
		if @i_rol = 'CONYUGUE'
		begin
		   select @o_secuencia = 7004
           insert into #temp (etapa, valor) values ('OFC', '4|15')
			insert into #temp (etapa, valor) values ('LTN', '5|15')			
		end
		
		if @i_rol = 'FAMILIAR'
		begin
           select @o_secuencia = 7005
		   insert into #temp (etapa, valor) values ('OFC', '4|15')
			insert into #temp (etapa, valor) values ('LTN', '5|15')		   
		end
		
		if @i_rol = 'PREAUTORIZACION'
		begin		
		   select @o_secuencia = 7010
		   	insert into #temp (etapa, valor) values ('SAT', '2|15')
			insert into #temp (etapa, valor) values ('POI', '3|15')	
			insert into #temp (etapa, valor) values ('OFC', '4|15')
			insert into #temp (etapa, valor) values ('LTN', '5|15')
			insert into #temp (etapa, valor) values ('AFR', '6|15')
			insert into #temp (etapa, valor) values ('BPTC', '8|15')
			insert into #temp (etapa, valor) values ('BSP', '9|15')
			insert into #temp (etapa, valor) values ('BBR', '10|15')
			insert into #temp (etapa, valor) values ('TRN', '13|15')
			insert into #temp (etapa, valor) values ('CRD', '14|15')
			insert into #temp (etapa, valor) values ('ASLC', '7|15')
		    
		end
		select * from #temp
		drop table #temp
	end

return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end	

GO
/****** Object:  StoredProcedure [dbo].[sp_asignacion_etapas_flujo_solicitud]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_asignacion_etapas_flujo_solicitud]  
		 
@i_tipoProducto	varchar(5)
,@i_origen	        varchar(5)
,@i_canalCaptura	 varchar(10) = null
,@i_reestructuracion char(1) = null

--action
,@o_secuencia int = null output


as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
	  
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
begin
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
    
	/* ESTO NO APLICA, NO SE ESTAN GESTIONANDO TRAMITES DE BANRURAL.
	if @i_tipoProducto  = 'PRE' and @i_origen = 'BANRURAL' and @i_canalCaptura = 'MENSAJE_COLA'
	begin
	    if @i_secuencia = 5001
	    begin
		    
		end
	end
*/
    create table #temp (
	   etapa varchar(10)
	   , valor varchar(10)
	)
    if @i_tipoProducto = 'PRE' and	@i_origen = 'SIPSA'
	begin
	   if @i_reestructuracion = 'N'
	   begin
	      select @o_secuencia = 7000
		  
		  insert into #temp (etapa, valor) values ('BCF', '2|15')
		  insert into #temp (etapa, valor) values ('ASLC', '3|15')
		  insert into #temp (etapa, valor) values ('FORK', '4|15')	
		  insert into #temp (etapa, valor) values ('PREAU', '5|15')	
		  insert into #temp (etapa, valor) values ('VDOCS', '6|15')
		  insert into #temp (etapa, valor) values ('INVT', '7|15')
		  insert into #temp (etapa, valor) values ('INVC', '7|15')	
		  insert into #temp (etapa, valor) values ('RINV', '8|15')	
		  insert into #temp (etapa, valor) values ('CNFC', '15|15')	
		  insert into #temp (etapa, valor) values ('AUTR', '20|15')
		  		  
	   end
	   else
	   begin
	      select @o_secuencia = 7011
          insert into #temp (etapa, valor) values ('CNFC', '15|15')	

	   end
	   select * from #temp
	   drop table #temp

	end
 

return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end	

GO
/****** Object:  StoredProcedure [dbo].[sp_asignacion_lc_multifactor]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_asignacion_lc_multifactor]  
@i_origen varchar(10) 
,@i_categoriaProducto varchar(10)
,@i_tipoRelacionLaboral varchar(20) 
,@i_ingreso money = null
,@i_antiguedadLaboral int = null
,@i_edad int = null
,@i_tienePuestoMercado char(1) = null
,@i_tienePrestamosComunales char(1) = null

,@o_califica char(1) = null output
,@o_factorTipoRelacion money = null output --inTO.asignarFactor($param,"FACTOR_TIPORELACION"); 
,@o_montoMaximo money = null output --inTO.setMontoMaximo($param); 
,@o_factorIngreso money = null output --inTO.asignarFactor($param,"FACTOR_INGRESO"); 
,@o_factorAntiguedad money = null output --inTO.asignarFactor($param,"FACTOR_ANTIGUEDAD");
,@o_factorEdad money= null output --inTO.asignarFactor($param,"FACTOR_EDAD"); 
,@o_campoRechazado varchar(100) = null output --inTO.setCalifica($param); inTO.addCampoRechazado("$param");

as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int

begin
   
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
    
 if @i_origen = 'SIPSA' 
 begin
  if @i_tipoRelacionLaboral = 'PROPIETARIO_FORMAL'
  begin
     select @o_factorTipoRelacion = 1
     if @i_ingreso < 1199.99
     begin
        --rechazado
        select @o_califica = 'N'
           , @o_campoRechazado = 'INGRESO POR DEBAJO DEL MINIMO'
        return 0
     end
     --ingreso >= $1 ingreso <= $1                   inTO.setMontoMaximo($param);   factor  califica
     --1200.00 1999.99        4500.00 0.50             0.50    true           
     if @i_ingreso between 1200 and 1999.99
     begin
        select @o_montoMaximo = 4500
           ,@o_factorIngreso = 0.5
           ,@o_califica = 'S'
        return 0
     end
     --condiciones                                                        --aciones
     --ingreso in (#, #)   antiguedadLaboral in (#,#)  edad in (#,#)     inTO.setMontoMaximo($param);   factor   factor edad    factor antiguedad     califica
     --2000.00,3499.99                                          6000.00                                 1.00                                                           true    
     if @i_ingreso between 2000 and 3499.99    
        select @o_montoMaximo = 6000
              ,@o_factorIngreso = 1
              ,@o_califica = 'S'         
     
     --3500.00,4999.99                                          7500.00                                 1.50                                                          true
     if @i_ingreso between 3500 and 4999.99     
        select @o_montoMaximo = 7500
           ,@o_factorIngreso = 1.5
           ,@o_califica = 'S'              
     
           --5000.00                                         10000.00                                   2.00                                                                true
     if @i_ingreso >= 5000     
        select @o_montoMaximo = 10000
           ,@o_factorIngreso = 2
           ,@o_califica = 'S'      
     
     --                       1,2                                                                                               0.00  
     if @i_antiguedadLaboral between 1 and 2     
         select @o_factorAntiguedad = 0
     
     --                       2,3                                                                                               0.60  
     if @i_antiguedadLaboral between 2 and 3     
         select @o_factorAntiguedad = 0.60
          
     --                       3,5                                                                                               0.80  
     if @i_antiguedadLaboral between 3 and 5     
         select @o_factorAntiguedad = 0.8
         
     --                       5                                                                                                 1.00  
   if @i_antiguedadLaboral > 5   
         select @o_factorAntiguedad = 1
        
   --                                                 19,20                                                         -0.15 
   if @i_edad between 19 and 20
       select @o_factorEdad = 0.15
   --                                                 20,25                                                         -0.10 
   if @i_edad between 20 and 24
       select @o_factorEdad = 0.10
   --                                                 25,30                                                          0.00 
   if @i_edad between 25 and 29
       select @o_factorEdad = 0.0      
   --                                                 30,50                                                          0.00 
   if @i_edad between 30 and 49
       select @o_factorEdad = 0.0   
   --                                                 50,60                                                         -0.10 
   if @i_edad between 50 and 59
       select @o_factorEdad = -0.10   
   --                                                    60                                                         -0.15 
   if @i_edad >= 60
       select @o_factorEdad = -0.15   

  end
  if @i_tipoRelacionLaboral = 'PROPIETARIO_INFORMAL'
  begin
      select @o_factorTipoRelacion = 0.8      
      if @i_ingreso < 1199.99
      begin
        --rechazado
        select @o_califica = 'N'
           , @o_campoRechazado = 'INGRESO POR DEBAJO DEL MINIMO'
        return 0
   end
   --condiciones                                                        --aciones
      --ingreso in (#, #)   antiguedadLaboral in (#,#)  edad in (#,#)     inTO.setMontoMaximo($param);   factorIngreso   factor edad    factor antiguedad     califica
      --1200.00,1999.99                                                   3500.00                        0.40                                                 true 
	  if @i_ingreso between 1200 and 1999.99    
        select @o_montoMaximo = 3500
              ,@o_factorIngreso = 0.4
              ,@o_califica = 'S'         
      --2000.00,3499.99                                                   5000.00                        0.80                                                 true 
	  if @i_ingreso between 2000 and 3499.99    
        select @o_montoMaximo = 5000
              ,@o_factorIngreso = 0.8
              ,@o_califica = 'S'    	  	  
      --3500.00,4999.99                                                   6500.00                        1.20                                                 true 
	  if @i_ingreso between 3500 and 4999.99    
        select @o_montoMaximo = 6500
              ,@o_factorIngreso = 1.20
              ,@o_califica = 'S'    	  
      --5000.00                                                           10000.00                       1.60                                                 true 
	  if @i_ingreso >= 5000
        select @o_montoMaximo = 10000
              ,@o_factorIngreso = 1.60
              ,@o_califica = 'S'    	  
      --                           1,2                                                                                                  0.00   
	  if @i_antiguedadLaboral between 1 and 2     
         select @o_factorAntiguedad = 0
      --                           2,3                                                                                                  0.40   
     if @i_antiguedadLaboral between 2 and 3     
         select @o_factorAntiguedad = 0.40
      --                           3,5                                                                                                  0.60   
     if @i_antiguedadLaboral between 3 and 5     
         select @o_factorAntiguedad = 0.6	  
      --                             5                                                                                                  0.80   
	  if @i_antiguedadLaboral > 5
	     select @o_factorAntiguedad = 0.8	  
      --                                                 19,20                                                           -0.15  
	  if @i_edad between 19 and 20
	     select @o_factorEdad = -0.15
      --                                                 20,25                                                           -0.10  
	  if @i_edad between 20 and 25
	     select @o_factorEdad = -0.10	  
      --                                                 25,30                                                            0.00  
	  if @i_edad between 25 and 30
	     select @o_factorEdad = 0	  
      --                                                 30,50                                                            0.00  
	  if @i_edad between 30 and 50
	     select @o_factorEdad = 0
      --                                                 50,60                                                           -0.10  
	  if @i_edad between 50 and 60
	     select @o_factorEdad = -0.10	  
      --                                                    60                                                           -0.15  
      if @i_edad > 60
	     select @o_factorEdad = -0.15	  
  end
  if @i_tipoRelacionLaboral = 'ASALARIADO_FORMAL'
  begin
    --factor tipo relacion 0.60      
	select @o_factorTipoRelacion = 0.6
    --condiciones                                                        --aciones
      --ingreso in (#, #)   antiguedadLaboral in (#,#)  edad in (#,#)     inTO.setMontoMaximo($param);   factorIngreso   factor edad    factor antiguedad     califica   
      --1199.99                                                                                                                                               false     INGRESO POR DEBAJO DEL MINIMO
	  if @i_ingreso < 1199.99
      begin
        --rechazado
        select @o_califica = 'N'
           , @o_campoRechazado = 'INGRESO POR DEBAJO DEL MINIMO'
        return 0
      end
      --1200.00,1999.99                                                   4000.00                        0.30                                                 true 
	    if @i_ingreso between 1200 and 1999.99    
           select @o_montoMaximo = 4000
              ,@o_factorIngreso = 0.3
              ,@o_califica = 'S'  
        --2000.00,3499.99                                                   5500.00                        0.60                                                 true 
		if @i_ingreso between 2000 and 3499.99    
          select @o_montoMaximo = 5500
              ,@o_factorIngreso = 0.6
              ,@o_califica = 'S'  	  
        --3500.00,4999.99                                                   7000.00                        0.90                                                 true 
        if @i_ingreso between 3500 and 4999.99    
          select @o_montoMaximo = 7000
              ,@o_factorIngreso = 0.9
              ,@o_califica = 'S'  	  
	  
        --5000.00                                                           10000.00                       1.20                                                 true 
		if @i_ingreso >= 5000.00
        select @o_montoMaximo = 10000
              ,@o_factorIngreso = 1.20
              ,@o_califica = 'S'  	  
        --                             1, 2                                                                                               0.60   
	  	if @i_antiguedadLaboral between 1 and 2     
           select @o_factorAntiguedad = 0.6
        --                             2, 3                                                                                               0.80   
	  	if @i_antiguedadLaboral between 2 and 3
           select @o_factorAntiguedad = 0.8		
        --                             3, 5                                                                                               1.00   
	  	if @i_antiguedadLaboral between 3 and 5
           select @o_factorAntiguedad = 1.0		
        --                             5                                                                                                  1.00   
	  	if @i_antiguedadLaboral >= 5     
           select @o_factorAntiguedad = 1
        --                                                19, 20                                                           -0.15  
	    if @i_edad between 19 and 20
	       select @o_factorEdad = -0.15	  		
        --                                                20, 25                                                           -0.10  
	    if @i_edad between 20 and 25
	       select @o_factorEdad = -0.10	  				
        --                                                25, 30                                                            0.00  
	    if @i_edad between 25 and 30
	       select @o_factorEdad = 0
        --                                                30, 50                                                            0.00  
	    if @i_edad between 30 and 50
	       select @o_factorEdad = 0
        --                                                50, 60                                                           -0.10  
	    if @i_edad between 50 and 60
	       select @o_factorEdad = -0.10	  				
        --                                                    60                                                           -0.15  
	    if @i_edad > 60
	       select @o_factorEdad = -0.15	  				

  end
  if @i_tipoRelacionLaboral = 'ASALARIADO_INFORMAL'
  begin
   --factor tipo relacion  0.40      
   select @o_factorTipoRelacion = 0.40
   --condiciones                                                          --acciones
      --ingreso in (#, #)   antiguedadLaboral in (#,#)  edad in (#,#)     inTO.setMontoMaximo($param);   factorIngreso   factor edad    factor antiguedad     califica    	  
      --1199.99                                                                                                                                               false     INGRESO POR DEBAJO DEL MINIMO
	  if @i_ingreso < 1199.99
      begin
        --rechazado
        select @o_califica = 'N'
           , @o_campoRechazado = 'INGRESO POR DEBAJO DEL MINIMO'
        return 0
      end
      --1200.00,1999.99                                                   1500.00                        0.20                                                 true 
	  if @i_ingreso between 1200 and 1999.99    
        select @o_montoMaximo = 4000
              ,@o_factorIngreso = 0.2
              ,@o_califica = 'S'  
      --2000.00,3499.99                                                   3000.00                        0.40                                                 true 
	  if @i_ingreso between 2000 and 3499.99    
        select @o_montoMaximo = 3000
              ,@o_factorIngreso = 0.4
              ,@o_califica = 'S'  	  
      --3500.00,4999.99                                                   4500.00                        0.60                                                 true 
	  if @i_ingreso between 3500 and 4999.99    
        select @o_montoMaximo = 4500
              ,@o_factorIngreso = 0.6
              ,@o_califica = 'S'  	  
      --5000.00                                                           5000.00                        0.80                                                 true 
	  if @i_ingreso > 5000
        select @o_montoMaximo = 5000
              ,@o_factorIngreso = 0.8
              ,@o_califica = 'S'  	  
      --                              1,2                                                                                               0.40   
	  if @i_antiguedadLaboral between 1 and 2     
           select @o_factorAntiguedad = 0.4	  
      --                              2,3                                                                                               0.50   
	  if @i_antiguedadLaboral between 2 and 3     
           select @o_factorAntiguedad = 0.5	  
      --                              3,5                                                                                               0.60   
	  if @i_antiguedadLaboral between 3 and 5     
           select @o_factorAntiguedad = 0.6 
      --                               5                                                                                                 0.70   
	  if @i_antiguedadLaboral > 5
           select @o_factorAntiguedad = 0.7
      --                                                19,20                                                            -0.15  
	  if @i_edad between 19 and 20
	       select @o_factorEdad = -0.15	  		
        --                                                20, 25                                                           -0.10  
	  if @i_edad between 20 and 25
	       select @o_factorEdad = -0.10	  				
        --                                                25, 30                                                            0.00  
	  if @i_edad between 25 and 30
	       select @o_factorEdad = 0
        --                                                30, 50                                                            0.00  
	  if @i_edad between 30 and 50
	       select @o_factorEdad = 0
        --                                                50, 60                                                           -0.10  
	  if @i_edad between 50 and 60
	       select @o_factorEdad = -0.10	  				
        --                                                    60                                                           -0.15  
	  if @i_edad > 60
	       select @o_factorEdad = -0.15	  				
  
  end
  if @i_tienePuestoMercado  = 'S' or @i_tienePrestamosComunales  = 'S'
     select @o_montoMaximo = 3000
 end  

  
 
return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end 

GO
/****** Object:  StoredProcedure [dbo].[sp_asignacion_limite_credito]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_asignacion_limite_credito]  
   
@i_origen  varchar(10) = null
,@i_categoriaProducto  varchar(10) = null
,@i_tipoRelacionLaboral varchar(10) = null
,@i_totalIngresos money = null

--inTO.setCalifica($param); 
,@o_califica char(1) = null output
--inTO.setFactorDeuda($1); 
,@o_factorDeuda money = null output
--inTO.addCampoRechazado("$param");
,@o_campoRechazado varchar(100) = null output 
--inTO.addCampoAceptado("$param"); 
,@o_campoAceptado varchar(100) = null output
--inTO.setExposicionMaximaDeuda($param); 
,@o_exposicionMaximaDeuda money = null output
--inTO.setExposicionMaximaCuota($param);
,@o_exposicionMaximaCuota money = null output

as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
begin
   
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'

    if @i_origen = 'SIPSA' 
    begin
       if @i_categoriaProducto = 'PERSONAL'
       begin 
       select @o_exposicionMaximaDeuda= 15000.00
                 ,@o_exposicionMaximaCuota = 0.25
          --condiciones                                                          acciones
          --totalIngresos in (#,#)  totalIngresos > #   totalIngresos < #        califica    factor deuda  msgRechazo               msgAceptacion            expMaximaDeuda    expMaximaCUota
          --1200, 2499.99                                                        true        2.50                                   Ingreso cae dentro 
                                                                                                                                    --del rango 1200, 2499.99  
          if @i_totalIngresos >= 1200 and @i_totalIngresos < 2499.99
          begin
		      select @o_califica = 'S'
			        ,@o_factorDeuda = 2.50
					,@o_campoAceptado = 'Ingreso cae dentro del rango 1200, 2499.99'
          end		  
          --2500, 4999.99                                                        true        3.00                                   Ingreso cae dentro 
                                                                                                                                    --del rango 2500, 4999.99  
          if @i_totalIngresos >= 2500 and @i_totalIngresos < 4999.99
          begin
		      select @o_califica = 'S'
			        ,@o_factorDeuda = 3
					,@o_campoAceptado = 'Ingreso cae dentro del rango 2500, 4999.99'
          end																															  
          --5000.00                                                               true        4.00                                 Ingreso esta por 
                                                                                                                                  --arriba de 5000  
          if @i_totalIngresos >= 5000
          begin
		      select @o_califica = 'S'
			        ,@o_factorDeuda = 4
					,@o_campoAceptado = 'Ingreso esta por arriba de 5000'
          end	          
          --1200.00                                                               false                     Ingreso es menor a 1200.   
          if @i_totalIngresos < 1200
          begin
		      select @o_califica = 'N'
					,@o_campoAceptado = 'Ingreso es menor a 1200.'
          end         
       end    
       if @i_categoriaProducto = 'CONSUMO'
       begin
       select @o_exposicionMaximaDeuda= 15000.00
                 ,@o_exposicionMaximaCuota = 0.25 
          --condiciones                                                          acciones
          --totalIngresos in (#,#)  totalIngresos > #   totalIngresos < #        califica    factor deuda  msgRechazo               msgAceptacion            expMaximaDeuda    expMaximaCUota
          --1200, 2499.99                                                        true        2.50                                   Ingreso cae dentro 
                                                                                                                                    --del rango 1200, 2499.99  
          if @i_totalIngresos >= 1200 and @i_totalIngresos < 2499.99
          begin
		      select @o_califica = 'S'
			        ,@o_factorDeuda = 2.50
					,@o_campoAceptado = 'Ingreso cae dentro del rango 1200, 2499.99'
          end		  
          --2500, 4999.99                                                        true        3.00                                   Ingreso cae dentro 
                                                                                                                                    --del rango 2500, 4999.99  
          if @i_totalIngresos >= 2500 and @i_totalIngresos < 4999.99
          begin
		      select @o_califica = 'S'
			        ,@o_factorDeuda = 3
					,@o_campoAceptado = 'Ingreso cae dentro del rango 2500, 4999.99'
          end																															  
          --5000.00                                                               true        4.00                                 Ingreso esta por 
                                                                                                                                  --arriba de 5000  
          if @i_totalIngresos >= 5000
          begin
		      select @o_califica = 'S'
			        ,@o_factorDeuda = 4
					,@o_campoAceptado = 'Ingreso esta por arriba de 5000'
          end	          
          --1200.00                                                               false                     Ingreso es menor a 1200.   
          if @i_totalIngresos < 1200
          begin
		      select @o_califica = 'N'
					,@o_campoAceptado = 'Ingreso es menor a 1200.'
          end 
  
    end
 end


return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end 

GO
/****** Object:  StoredProcedure [dbo].[sp_buro_banco]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_buro_banco]  
		 
@i_origen	     varchar(10) = null
,@i_tipoProducto	 varchar(5) = null
,@i_status	       varchar(2) = null
,@i_campania	varchar(5) = null
,@i_prestamosVigentes	int = null
,@i_prestamosCancelados	int = null
,@i_estaAlDiaPagos	   char(1) = null
,@i_secuenciaAsignada		int = null
,@i_moras60por3meses		char(1) = null
,@i_moras60por12meses		char(1) = null
,@i_moras90por12meses		char(1) = null
,@i_moras120		char(1) = null

--action
--inTO.setCalifica($param);	
,@o_califica char(1) = null output
--inTO.addCampoAceptado("$param");
,@o_msgAceptado varchar(100) = null output	
--inTO.addCampoRechazado("$param");	
,@o_msgRechazado varchar(100) = null output
--inTO.setProcesoManual($param);
,@o_procesoManual char(1) = null output

as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
	  
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'

	create table #mensajeAceptado ( msg varchar(100))
	create table #mensajeRechazo  ( msg varchar(100))
    
if @i_origen = 'SIPSA' 
begin
   if @i_tipoProducto  = 'PRE'
   begin
      if @i_origen = 'SIPSA'
	  begin
         if @i_tipoProducto = 'PRE'
		 begin
		    if @i_status = '00'
			begin
   --condiciones                                                                                                                                                            acciones                            
   --status campania prestamosVigentes prestamosCancelados estaAlDiaPagos estaAlDiaPagos secuenciaAsignada  moras60por3meses  moras60por12meses moras90por12meses  moras120 califica  msgAceptado               msgRechazado     procesoManual
   --00                                                    true                                             false             false             false              false    true    
               if @i_estaAlDiaPagos = 'S'
			   begin
			      select @o_califica = 'S'
				  insert #mensajeAceptado (msg) values ('Esta al dia con los pagos')
			   end
   --00                                                    true                                                                                                             true      Esta al dia con los pagos  
   --00                                                                                                     false                                                                     No tiene moras 60 por 3 meses  
               if @i_moras60por3meses = 'N'
			   begin
			      insert #mensajeAceptado (msg) values ('No tiene moras 60 por 3 meses')
			   end
   --00                                                                                                                          false                                                No tiene moras 60 por 12 meses  
               if @i_moras60por12meses = 'N'
			   begin
			       insert #mensajeAceptado (msg) values ('No tiene moras 60 por 12 meses')
			   end
   --00                                                                                                                                            false                              No tiene moras 90 por 12 meses  
               if @i_moras90por12meses = 'N'
			   begin
			       insert #mensajeAceptado (msg) values ('No tiene moras 60 por 12 meses')
			   end
   --00                                                                                                                                                            false              No tiene moras 120  
               if @i_moras120 = 'N'
			   begin
			       insert #mensajeAceptado (msg) values ('No tiene moras 120')
			   end
   --00                                                    false                                                                                                            false                                No esta al dia con los pagos 
               if @i_estaAlDiaPagos = 'N'
			   begin
			      select @o_califica = 'N'
				  insert #mensajeRechazo (msg) values ('No esta al dia con los pagos')			   
			   end
   --00                                                                                                     true                                                            false                                tiene moras 60 por 3 meses
               if @i_moras60por3meses = 'S'
			   begin
			      select @o_califica = 'N'
				  insert #mensajeRechazo (msg) values ('tiene moras 60 por 3 meses')			   			       
			   end
   --00                                                                                                                       true                                          false                                tiene moras 60 por 12 meses 
               if @i_moras60por12meses = 'S'
			   begin
			      select @o_califica = 'N'
				  insert #mensajeRechazo (msg) values ('tiene moras 60 por 12 meses ')			   			       
			   end
   --00                                                                                                                                          true                       false                                tiene moras 90 por 12 meses 
               if @i_moras90por12meses = 'S'
			   begin
			      select @o_califica = 'N'
				  insert #mensajeRechazo (msg) values ('tiene moras 90 por 12 meses')			   			       			   
			   end			   
   --00                                                                                                                                                            true     false                                tiene moras 120 			
               if @i_moras120 = 'S'
			   begin
			      select @o_califica = 'N'
				  insert #mensajeRechazo (msg) values ('tiene moras 120')			   			       
			   end      
			end
			--20               true  cliente no registrado  
			if @i_status = '20'
			begin
               select @o_califica = 'S'
			   insert #mensajeAceptado (msg) values ('cliente no registrado')               
            end
            --21               true    
            if @i_status = '21'
			begin
			   select @o_califica = 'S'
			end
		    --23               false   multiples match true			
			if @i_status = '23'
			begin
               select @o_califica = 'S'
			   insert #mensajeRechazo (msg) values ('multiples match true')               			
			end
		 end
		 
      end
   end

	select * from #mensajeAceptado
	select * from #mensajeRechazo 
	
	drop table #mensajeAceptado
	drop table #mensajeRechazo 

return 0

error:

    
--select @w_error_msg = '[' + @w_sp_name + ']' + @w_error_msg
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end 

GO
/****** Object:  StoredProcedure [dbo].[sp_buro_crediref]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_buro_crediref]  

@i_tipoProducto	 varchar(5) = null
,@i_estaAlDiaPago	 char(1) = null
,@i_moras60por3meses	 char(1) = null
,@i_moras60por12meses	 char(1) = null
,@i_moras90por12meses	 char(1) = null
,@i_moras120	 char(1) = null
,@i_cuentasCobroJudicial	 char(1) = null
,@i_cuentaIncobrable	 char(1) = null
,@i_enProcesoProrroga	 char(1) = null
,@i_canceladoRenovacion	 char(1) = null
,@i_canceladoPorIncobrable	 char(1) = null
,@i_canceladoPorEjecucionJudicial	 char(1) = null
,@i_saldoReestructurado	 char(1) = null
,@i_comparteInformacion char(1) = null
--	inTO.setCalifica($param);
,@o_califica char(1) = null output



as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
	  
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
begin
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'

 create table #mensajeAceptado ( msg varchar(100))
 create table #mensajeRechazo  ( msg varchar(100))
    
--true false false false false false false false false false false false true true
if @i_estaAlDiaPago = 'S'
   and @i_moras60por3meses = 'N'
   and @i_moras60por12meses  = 'N'
   and @i_moras90por12meses  = 'N'
   and @i_moras120 = 'N'
   and @i_cuentasCobroJudicial = 'N'
   and @i_cuentaIncobrable  = 'N'
   and @i_enProcesoProrroga = 'N'
   and @i_canceladoRenovacion = 'N'
   and @i_canceladoPorIncobrable = 'N'
   and @i_canceladoPorEjecucionJudicial = 'N'
   and @i_saldoReestructurado  = 'N'
   and @i_comparteInformacion = 'S'
begin
   select @o_califica = 'S'   
end   

   if @i_estaAlDiaPago = 'S'
       insert into #mensajeAceptado (msg) values ('Esta al dia con los pagos')
	   
   if  @i_moras60por3meses = 'N'
       insert into #mensajeAceptado (msg) values ('No tiene moras 60 por 3 meses')
	   
   if  @i_moras60por12meses  = 'N'
       insert into #mensajeAceptado (msg) values ('No tiene moras 60 por 12 meses')
	   
   if  @i_moras90por12meses  = 'N'
       insert into #mensajeAceptado (msg) values ('No tiene moras 90')
	   
   if  @i_moras120 = 'N'
       insert into #mensajeAceptado (msg) values ('No tiene moras 120')
	   
   if  @i_cuentasCobroJudicial = 'N'
       insert into #mensajeAceptado (msg) values ('No tiene cobros judiciales')
   
   if  @i_cuentaIncobrable  = 'N'
       insert into #mensajeAceptado (msg) values ('No tiene cuentas incobrables')
	   
   if  @i_enProcesoProrroga = 'N'
       insert into #mensajeAceptado (msg) values ('No tiene cuentas en proceso de prorroga')
    
   if  @i_canceladoRenovacion = 'N'
       insert into #mensajeAceptado (msg) values ('No tiene cuentas canceladas por renovacion')
	   
   if  @i_canceladoPorIncobrable = 'N'
       insert into #mensajeAceptado (msg) values ('No tiene cuentas canceladas por incobrable')
	   
   if  @i_canceladoPorEjecucionJudicial = 'N'
       insert into #mensajeAceptado (msg) values ('No tiene cuentas canceladas por ejecucion judicial')
   
   if  @i_saldoReestructurado  = 'N'
       insert into #mensajeAceptado (msg) values ('No tiene cuentas con saldo reestructurado')
	   
   if  @i_comparteInformacion = 'S'
       insert into #mensajeAceptado (msg) values ('Comparte Informacion')
	   
	   
--condiciones de rechazo
   if @i_estaAlDiaPago = 'N'
   begin
       insert into #mensajeRechazo (msg) values ('no esta al dia con los pagos')
	   select @o_califica = 'N'
   end	   
	   
   if  @i_moras60por3meses = 'S'
   begin
       insert into #mensajeRechazo (msg) values ('tiene moras 60 por 3 meses')
	   select @o_califica = 'N'
   end	   
	   
   if  @i_moras60por12meses  = 'S'
   begin
       insert into #mensajeRechazo (msg) values ('tiene moras 60 por 12 meses')
	   select @o_califica = 'N'
   end
	   
   if  @i_moras90por12meses  = 'S'
   begin
       insert into #mensajeRechazo (msg) values ('tiene moras 90')
	   select @o_califica = 'N'
   end   
   
   if  @i_moras120 = 'S'
   begin
       insert into #mensajeRechazo (msg) values ('tiene moras 120')
	   select @o_califica = 'N'
   end	   
   
   if  @i_cuentasCobroJudicial = 'S'
   begin
       insert into #mensajeRechazo (msg) values ('tiene cobros judiciales')
	   select @o_califica = 'N'
   end   
   
   if  @i_cuentaIncobrable  = 'S'
   begin
       insert into #mensajeRechazo (msg) values ('tiene cuentas incobrables')
	   select @o_califica = 'N'
   end
	
   if  @i_enProcesoProrroga = 'S'
   begin
       insert into #mensajeRechazo (msg) values ('tiene cuentas en proceso de prorroga')
	   select @o_califica = 'N'
   end    

   if  @i_canceladoRenovacion = 'S'
   begin
       insert into #mensajeRechazo (msg) values ('tiene cuentas canceladas por renovacion')
	   select @o_califica = 'N'
   end	   

   if  @i_canceladoPorIncobrable = 'S'
   begin
       insert into #mensajeRechazo (msg) values ('tiene cuentas canceladas por incobrable')
	   select @o_califica = 'N'
   end
	   
   if  @i_canceladoPorEjecucionJudicial = 'S'
   begin
       insert into #mensajeRechazo (msg) values ('tiene cuentas canceladas por ejecucion judicial')
	   select @o_califica = 'N'
   end
   
   if  @i_saldoReestructurado  = 'S'
   begin
       insert into #mensajeRechazo (msg) values ('tiene cuentas con saldo reestructurado')
	   select @o_califica = 'N'
   end
   
   if  @i_comparteInformacion = 'N'
   begin
       insert into #mensajeRechazo (msg) values ('no comparte Informacion')
	   select @o_califica = 'N'
   end	 

   
return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end 

GO
/****** Object:  StoredProcedure [dbo].[sp_buro_infornet]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_buro_infornet]  
		 
@i_tipoProducto	 varchar(5) = null
,@i_tieneCreditosEdoMalo	 char(1) = null
,@i_tieneCreditosClasifMala	char(1) = null
,@i_juiciosGrado2 int = null
,@i_duracionJuiciosGrado0 int = 0
,@i_duracionJuiciosGrado1 int = 0
--inTO.setCalifica($param);	
,@o_califica char(1) = null output

as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
   
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'

	create table #mensajeAceptado (msg varchar(100))
	create table #mensajeRechazo  (msg varchar(100))
    
--tipoProducto tieneCreditosEdoMalo tieneCreditosClasifMala tieneCreditosClasifMala  calificacion juicios   duracion juicios   duracion juicios   inTO.setCalifica($param); inTO.addCampoAceptado("$param"); inTO.addCampoRechazado("$param");
--PRE          false                false                                            2                      0,2                1,2                true  
  if @i_tipoProducto = 'PRE'
  begin
     if @i_tieneCreditosEdoMalo = 'N'
	    and @i_tieneCreditosClasifMala = 'N'
		and @i_juiciosGrado2 < 2
		and @i_duracionJuiciosGrado0 < 2
		and @i_duracionJuiciosGrado1 < 2
	 begin
        select @o_califica = 'S'		      	 
	    if @i_tieneCreditosEdoMalo = 'N'
	       insert into #mensajeAceptado (msg) values ('no tiene malas clasificaciones ')
		 
	    if @i_tieneCreditosClasifMala = 'N'
	       insert into #mensajeAceptado (msg) values ('no tiene malas calificaciones ')
	 
	    if @i_juiciosGrado2 < 2
	       insert into #mensajeAceptado (msg) values ('No tiene juicios que sobrepasen el grado 2 ')
		 
	    if @i_duracionJuiciosGrado0 >= 2
	       insert into #mensajeAceptado (msg) values ('No tiene juicios 0 con menos de 2 años ')
		 
	    if @i_duracionJuiciosGrado1 >= 2
	       insert into #mensajeAceptado (msg) values ('No tiene juicios 1 con menos de 2 años ')
     end
     else
     begin	 
	    select @o_califica = 'N'		
        --mensajes de rechazo.
	    if @i_tieneCreditosEdoMalo = 'S'	    
	       insert into #mensajeRechazo (msg) values ('tiene malas clasificaciones ')		   
	     	 
	    if @i_tieneCreditosClasifMala = 'S'	 
	       insert into #mensajeRechazo (msg) values ('tiene malas calificaciones ')	
	 
	    if @i_juiciosGrado2 >= 2	 
	       insert into #mensajeRechazo (msg) values ('tiene juicios que sobrepasen el grado 2 ')
			 
	    if @i_duracionJuiciosGrado0 < 2	
	       insert into #mensajeRechazo (msg) values ('tiene juicios 0 con menos de 2 años ')	
		 
	    if @i_duracionJuiciosGrado1 < 2	 
	       insert into #mensajeRechazo (msg) values ('tiene juicios 1 con menos de 2 años ')	 
	
  end

select * from #mensajeAceptado 
select * from #mensajeRechazo

drop table #mensajeAceptado 
drop table #mensajeRechazo

return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end 

GO
/****** Object:  StoredProcedure [dbo].[sp_buro_infornet_prdcond_juicios]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_buro_infornet_prdcond_juicios]  
		 
@i_descripcionClaseJuicio	varchar(50) = null
--inTO.setImportanciaDemandado($param);
,@o_importanciaDemandado int = null output

as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
begin
	  
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'

    if @i_descripcionClaseJuicio in (
		'EJECUTIVO'	--9
		,'SUMARIO'	--9
		,'EJECUTIVO VIA APREMIO'	--9
		,'ESTAFA MEDIANTE CHEQUE'	--9
		,'PLAGIO O SECUESTRO'	--9
		,'COMERCIO TRAFICO Y ALMA. ILICITO DE DROGAS')	--9
	    select @o_importanciaDemandado = 9

	if @i_descripcionClaseJuicio in ('ROBO AGRAVADO')--	6
	    select @o_importanciaDemandado = 6

    if @i_descripcionClaseJuicio in ('HURTO AGRAVADO' --	5
        ,'ESTAFA PROPIA'	--5
        ,'APROPIACION Y RETENCION INDEBIDAS'	--5
        ,'NEGACION DE ASISTENCIA ECONOMICA'	--5
        ,'SUSTRACCION PROPIA'	--5
        ,'ASESINATO')	--5
		select @o_importanciaDemandado = 5

    if @i_descripcionClaseJuicio in ('CASOS ESPECIALES DE ESTAFA')	--4
	    select @o_importanciaDemandado = 4

    if @i_descripcionClaseJuicio in ('ROBO'	--3
        ,'HOMICIDIO'	--3
        ,'FALSEDAD MATERIAL'  --3
        ,'AMENAZAS'	--3
        ,'PORTACION ILEGAL DE ARMAS'	--3
        ,'ALLANAMIENTO'	--3
        ,'COACCION'	--3
        ,'USURPACION'	--3
        ,'HOMICIDIO CULPOSO'	--3
        ,'ORAL'	--3
        ,'JUICIO DE CUENTAS'	--3
        ,'PRUEBA ANTICIPADA'	--3
        ,'DELITO CONTRA RECURSOS FORESTALES')	--3
	    select @o_importanciaDemandado = 3	

    if @i_descripcionClaseJuicio in ('POSESION PARA EL CONSUMO'	--2
        ,'HURTO'	--2
        ,'VIOLACION'	--2
        ,'COHECHO ACTIVO'	--2
        ,'USO DE DOCUMENTOS FALSIFICADOS'	--2
        ,'ATENTADO')	--2
		select @o_importanciaDemandado = 2

    if @i_descripcionClaseJuicio in ('ORDINARIO'	--1
        ,'LESIONES LEVES'	--1
        ,'DA\O'	--1
        ,'LESIONES'	--1
        ,'RESPONSABILIDAD DE CONDUCTORES'	--1
        ,'DENUNCIA'	--1
        ,'FALTAS')	--1
		select @o_importanciaDemandado = 1

    if @i_descripcionClaseJuicio in ('CONSIGNACION'	--0
        ,'SOBRE AVERIGUAR'	--0
        ,'LESIONES CULPOSAS'	--0
        ,'VOLUNTARIO'	--0
        ,'TITULACION SUPLETORIA'	--0
        ,'NO DESCRITO'	--0
        ,'INCIDENTES'	--0
        ,'PROCESO SUCESORIO'	--0
        ,'AMPARO, APELACION O CONSTITUCIONAL'	--0
        ,'PUNITIVO')	--0
		select @o_importanciaDemandado = 0


return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end	

GO
/****** Object:  StoredProcedure [dbo].[sp_buro_infornet_precondicion]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_buro_infornet_precondicion]  
		 
@i_estadoCredito           varchar(10) = null
,@i_clasificacionCredito   varchar(5) = null

--inTO.setCalificacionEstadoCredito("$param");
,@o_calificacionEstadoCredito  varchar(10) = null output
--inTO.setCalificacionClasificacionCredito("$param");
,@o_calificacionClasificacionCredito varchar(10) = null output

as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
begin
	  
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
    
	if (@i_estadoCredito in ('AC'	,'C'    ,'CA'   ,'CACC'	
                          ,'CACT'	,'CADI'	,'CANE'	,'CARE'	
                          ,'CARO'	,'I'	,'INA'	,'NW'
                          ,'NWDI'	,'NWEC'	,'RORO'	,'UN'))
        select @o_calificacionEstadoCredito = 'BUENO'						  

    
    if (@i_estadoCredito in ('AD'	,'CAEJ'	 ,'CAFA'	,'CAIL'	
                          ,'CAMO'	,'CARC'	 ,'CASB'	,'CASG'	
                          ,'CASR'	,'CJ'	 ,'CJIL'	,'CJSR'	
                          ,'IN'	    ,'J'	 ,'JR'	    ,'M'	
                          ,'MO'	    ,'MO00'	 ,'MR'	    ,'NR'	
                          ,'PJ'	    ,'RN'	 ,'RO'	    ,'SRMO'	
                          ,'SRSR'	,'SR00'	,'SU'	    ,'V'	))
        select @o_calificacionEstadoCredito = 'MALO'


    if 	@i_clasificacionCredito in ('A'	  ,'AB'	 ,'B'	,'BC')
        select @o_calificacionClasificacionCredito = 'BUENO'
	
    if 	@i_clasificacionCredito in ('C', 'CD' ,  'D', 'DA', 'M'	, 'R'	,'Z')
	    select @o_calificacionClasificacionCredito = 'MALO'
		
return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end	

GO
/****** Object:  StoredProcedure [dbo].[sp_buro_juicios_transunion]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_buro_juicios_transunion]  
		 
@i_codigoJuicio	varchar(10) = null
--inTO.setClasificacion($param);	
,@o_clasificacion int = null output
--inTO.setCalifica($param);
,@o_califica char(1) = null output

as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
	  
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
begin
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
    
	if @i_codigoJuicio in ( '299',
		'234',
		'150',
		'474',
		'10',
		'551',
		'356',
		'8',
		'722',
		'115',
		'738',
		'724',
		'9',
		'125',
		'153',
		'233',
		'460',
		'420',
		'66',
		'220',
		'185',
		'232',
		'131',
		'59',
		'491',
		'388',
		'479',
		'5',
		'78',
		'718',
		'56',
		'337',
		'168',
		'586',
		'335',
		'662')
	begin
	   select @o_clasificacion  = 9  --clasif 9
	   --inTO.setCalifica($param);
			 ,@o_califica = 'N'
	end   



	if @i_codigoJuicio in ('41'
		,'284'
		,'576'
		,'47')
	begin
	select @o_clasificacion  = 6  --clasif 6
	   --inTO.setCalifica($param);
			 ,@o_califica = 'N'
	end



	if @i_codigoJuicio in (	'481'
		,'261'
		,'45'
		,'522'
		,'321'
		,'501'
		,'315'
		,'267'
		,'19'
		,'60'
		,'183'
		,'138'
		,'18'
		,'323'
		,'326'
		,'37'
		,'33'
		,'64'
		,'544'
		,'725'
		,'71'
		,'88'
		,'675'
		,'565'
		,'196'
		,'316'
		,'67')
	begin
	   select @o_clasificacion  = 5  --clasif 5
	   --inTO.setCalifica($param);
			 ,@o_califica = 'N'
	end



	if @i_codigoJuicio in (	'433'
		,'29'
		,'25'
		,'226'
		,'480'
		,'384'
		,'50'
		,'272'
		,'35'
		,'696'
		,'252'
		,'265'
		,'212'
		,'51'
		,'243'
		,'44'
		,'483'
		,'188'
		,'688'
		,'173'
		,'40'
		,'713'
		,'72'
		,'57'
		,'151') 
	begin
	   select @o_clasificacion  = 3 --clasif 3
			 ,@o_califica = 'N'
	end

	if @i_codigoJuicio in ('599'
		,'395'
		,'192'
		,'600'
		,'601'
		,'602'
		,'93'
		,'719'
		,'230'
		,'147'
		,'720'
		,'499'
		,'693'
		,'671'
		,'244'
		,'590'
		,'430'
		,'349'
		,'186'
		,'94'
		,'55'
		,'612'
		,'729'
		,'277'
		,'73'
		,'158'
		,'20'
		,'207'
		,'542'
		,'34'
		,'117'
		,'112'
		,'116'
		,'136'
		,'428'
		,'102'
		,'708'
		,'578'
		,'62'
		,'198'
		,'694'
		,'379'
		,'325'
		,'143'
		,'100'
		,'221'
		,'441'
		,'211'
		,'24'
		,'99'
		,'87'
		,'305'
		,'17'
		,'165'
		,'118'
		,'393'
		,'332'
		,'307'
		,'702'
		,'530'
		,'493'
		,'336'
		,'469'
		,'476'
		,'322'
		,'251'
		,'154'
		,'500'
		,'587'
		,'554'
		,'258'
		,'210'
		,'137'
		,'249'
		,'86'
		,'248'
		,'327'
		,'96'
		,'296'
		,'58'
		,'75'
		,'213'
		,'85'
		,'471'
		,'692'
		,'380'
		,'281'
		,'677'
		,'68'
		,'363'
		,'682'
		,'524'
		,'76'
		,'193'
		,'119'
		,'227'
		,'679'
		,'178'
		,'187'
		,'222'
		,'223'
		,'23'
		,'108'
		,'745'
		,'396'
		,'65'
		,'523'
		,'537'
		,'517'
		,'750'
		,'529'
		,'304'
		,'110'
		,'32'
		,'711'
		,'438'
		,'228'
		,'541'
		,'229'
		,'218'
		,'219'
		,'274'
		,'170'
		,'593'
		,'568'
		,'737'
		,'107'
		,'508'
		,'169'
		,'149'
		,'667'
		,'703'
		,'129'
		,'744'
		,'130'
		,'487'
		,'309'
		,'548'
		,'148'
		,'373'
		,'177'
		,'342'
		,'142'
		,'63'
		,'485'
		,'421'
		,'572'
		,'80'
		,'288'
		,'353'
		,'709'
		,'69'
		,'135'
		,'717'
		,'176'
		,'573'
		,'683'
		,'533'
		,'521'
		,'473'
		,'660'
		,'7'
		,'352'
		,'680'
		,'155'
		,'686'
		,'202'
		,'279'
		,'404'
		,'189'
		,'182'
		,'545'
		,'46'
		,'383'
		,'424'
		,'324'
		,'385'
		,'250'
		,'97'
		,'397'
		,'569'
		,'534'
		,'588'
		,'592'
		,'689'
		,'563'
		,'477'
		,'319'
		,'510'
		,'4'
		,'28'
		,'16'
		,'331'
		,'330'
		,'583'
		,'145'
		,'126'
		,'560'
		,'266'
		,'591'
		,'580'
		,'180'
		,'577'
		,'31'
		,'382'
		,'310'
		,'134'
		,'489'
		,'401'
		,'317'
		,'486'
		,'494'
		,'509'
		,'503'
		,'341'
		,'38'
		,'289'
		,'301'
		,'334'
		,'295'
		,'61'
		,'208'
		,'504'
		,'79'
		,'570'
		,'684'
		,'144'
		,'555'
		,'664'
		,'707'
		,'459'
		,'36'
		,'141'
		,'49'
		,'472'
		,'287'
		,'53'
		,'290'
		,'91'
		,'123')
	begin
	   select @o_clasificacion  = 2 ----clasif 2
			 ,@o_califica = 'N'    
	end

    if @i_codigoJuicio in ('697'
		,'98'
		,'84'
		,'14'
		,'205'
		,'113'
		,'547'
		,'286'
		,'140'
		,'106'
		,'698'
		,'21'
		,'386'
		,'271'
		,'114'
		,'303'
		,'1'
		,'721'
		,'285'
		,'695'
		,'39'
		,'90'
		,'74'
		,'120'
		,'338'
		,'195'
		,'81'
		,'184'
		,'256'
		,'678'
		,'95'
		,'214'
		,'133'
		,'160'
		,'464'
		,'343'
		,'681'
		,'275'
		,'224'
		,'552'
		,'2'
		,'191'
		,'392'
		,'511'
		,'26'
		,'339'
		,'461'
		,'302'
		,'42'
		,'175'
		,'333'
		,'320'
		,'710'
		,'216'
		,'163'
		,'6'
		,'495'
		,'128'
		,'346'
		,'366'
		,'374'
		,'399'
		,'376'
		,'368'
		,'359'
		,'345'
		,'658'
		,'362'
		,'105'
		,'54'
		,'92'
		,'27'
		,'174'
		,'259'
		,'124')
	begin
	   select @o_clasificacion  = 1 --clasif 1
			 ,@o_califica = 'N'    
	end


	if @i_codigoJuicio in ('340'
		,'466'
		,'103'
		,'190'
		,'294'
		,'389'
		,'171'
		,'372'
		,'348'
		,'201'
		,'329'
		,'156'
		,'475'
		,'714'
		,'199'
		,'706'
		,'736'
		,'502'
		,'589'
		,'655'
		,'278'
		,'215'
		,'206'
		,'659'
		,'152'
		,'11'
		,'559'
		,'564'
		,'253'
		,'162'
		,'127'
		,'225'
		,'427'
		,'121'
		,'89'
		,'350'
		,'400'
		,'365'
		,'354'
		,'351'
		,'357'
		,'735'
		,'440'
		,'361'
		,'355'
		,'181'
		,'161'
		,'179'
		,'139'
		,'70'
		,'546'
		,'543'
		,'101'
		,'111'
		,'431'
		,'507'
		,'432'
		,'519'
		,'13'
		,'561'
		,'425'
		,'159'
		,'550'
		,'518'
		,'378'
		,'197'
		,'146'
		,'132'
		,'723'
		,'497'
		,'242'
		,'237'
		,'12'
		,'77'
		,'52'
		,'405'
		,'700'
		,'292'
		,'167'
		,'48'
		,'166'
		,'293'
		,'297'
		,'670'
		,'506'
		,'387'
		,'308'
		,'394'
		,'273'
		,'676'
		,'747'
		,'104'
		,'347'
		,'3'
		,'484'
		,'122'
		,'657'
		,'231'
		,'200'
		,'674'
		,'369'
		,'367'
		,'579'
		,'726'
		,'371'
		,'370'
		,'540')
	begin
	   select @o_clasificacion  = 0 --clasif 0
			 ,@o_califica = 'N'    
	end


return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end	


GO
/****** Object:  StoredProcedure [dbo].[sp_buro_politicas_ingreso]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_buro_politicas_ingreso]  
   
@i_tipoProducto  varchar(5) = null
,@i_origen varchar(10) = null
,@i_relacionDependencia varchar(30) = null
,@i_edad    int = null -->= $1 
,@i_ingreso money = null
,@i_tiempoLaborarEmpleoActual int = null -->= $1
 
--inTO.setCalifica($param);
,@o_califica char(1) = null output
as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
begin
   
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
	
	create table #mensajeAceptado (msg varchar(100))
	create table #mensajeRechazo  (msg varchar(100))
    
if @i_tipoProducto = 'PRE'
begin
    if @i_origen  = 'SIPSA'    
    begin
       --ASALARIADO_FORMAL 19  65  1800  12  true
	   if @i_relacionDependencia = 'ASALARIADO_FORMAL'
	   begin
	      if (@i_edad >= 19 and @i_edad <= 65
		     and @i_ingreso >= 1800
		     and @i_tiempoLaborarEmpleoActual >= 12)
	      begin
	         select @o_califica = 'S'
		  
		     if @i_edad >= 19
		        insert into #mensajeAceptado (msg) values ('Cumple edad minima')
			 
             if @i_edad <= 65
		        insert into #mensajeAceptado (msg) values ('cumple edad maxima')
			 
		     if @i_ingreso >= 1800
		        insert into #mensajeAceptado (msg) values ('cumple ingreso minimo')
			 
		     if @i_tiempoLaborarEmpleoActual >= 12
		        insert into #mensajeAceptado (msg) values ('cumple tiempo de laborar')			 		  
		  end
		  else
		  begin
		     select @o_califica = 'N'
		     if @i_edad < 19
		        insert into #mensajeRechazo (msg) values ('no Cumple edad minima')
			 
             if @i_edad > 65
		        insert into #mensajeRechazo (msg) values ('no cumple edad maxima')
			 
		     if @i_ingreso < 1800
		        insert into #mensajeRechazo (msg) values ('no cumple ingreso minimo')
			 
		     if @i_tiempoLaborarEmpleoActual < 12
		        insert into #mensajeRechazo (msg) values ('no cumple tiempo de laborar')			 		  			 
		  end
	   end
	   
       --ASALARIADO_INFORMAL 19  65  1800  12  true
	   if @i_relacionDependencia = 'ASALARIADO_INFORMAL'	   
	   begin
	      if  (@i_edad >= 19 and @i_edad <= 65
		     and @i_ingreso >= 1800
		     and @i_tiempoLaborarEmpleoActual >= 12)
		  begin
	         select @o_califica = 'S'
		  
		     if @i_edad >= 19
		        insert into #mensajeAceptado (msg) values ('Cumple edad minima')
			 
             if @i_edad <= 65
		        insert into #mensajeAceptado (msg) values ('cumple edad maxima')
			 
		     if @i_ingreso >= 1800
		        insert into #mensajeAceptado (msg) values ('cumple ingreso minimo')
			 
		     if @i_tiempoLaborarEmpleoActual >= 12
		        insert into #mensajeAceptado (msg) values ('cumple tiempo de laborar')
		   end
		   else
		   begin
		     select @o_califica = 'N'  
		     if @i_edad < 19
		        insert into #mensajeRechazo (msg) values ('no Cumple edad minima')
			 
             if @i_edad > 65
		        insert into #mensajeRechazo (msg) values ('no cumple edad maxima')
			 
		     if @i_ingreso < 1800
		        insert into #mensajeRechazo (msg) values ('no cumple ingreso minimo')
			 
		     if @i_tiempoLaborarEmpleoActual < 12
		        insert into #mensajeRechazo (msg) values ('no cumple tiempo de laborar')			 		  			 			 
		   end
	   end
	   
       --PROPIETARIO_INFORMAL 21  65  1200  24  true
	   if @i_relacionDependencia = 'PROPIETARIO_INFORMAL'
	   begin
	      if (@i_edad >= 21 and @i_edad <= 65
		     and @i_ingreso >= 1200
		     and @i_tiempoLaborarEmpleoActual >= 24)
		  begin
		     select @o_califica = 'S'
		     if @i_edad >= 21
		        insert into #mensajeAceptado (msg) values ('Cumple edad minima')
			 
             if @i_edad <= 65
		        insert into #mensajeAceptado (msg) values ('cumple edad maxima')
			 
		     if @i_ingreso >= 1200
		        insert into #mensajeAceptado (msg) values ('cumple ingreso minimo')
			 
		     if @i_tiempoLaborarEmpleoActual >= 24
		        insert into #mensajeAceptado (msg) values ('cumple tiempo de laborar')			 	         
		end
		else
		begin
		   select @o_califica = 'N'
		   if @i_edad < 21
		      insert into #mensajeRechazo (msg) values ('no Cumple edad minima')
			 
           if @i_edad > 65
		      insert into #mensajeRechazo (msg) values ('no cumple edad maxima')
			 
		   if @i_ingreso < 1200
		      insert into #mensajeRechazo (msg) values ('no cumple ingreso minimo')
			 
		   if @i_tiempoLaborarEmpleoActual < 24
		      insert into #mensajeRechazo (msg) values ('no cumple tiempo de laborar')		   
		end
	   end
		
       --PROPIETARIO_FORMAL 21  65  1200  24  true
	   if @i_relacionDependencia = 'PROPIETARIO_FORMAL'
	   begin
	      if  (@i_edad >= 21 and @i_edad <= 65
		     and @i_ingreso >= 1200
		     and @i_tiempoLaborarEmpleoActual >= 24)
		  begin		
		     select @o_califica = 'S'
		     if @i_edad >= 21
		        insert into #mensajeAceptado (msg) values ('Cumple edad minima')
			 
             if @i_edad <= 65
		        insert into #mensajeAceptado (msg) values ('cumple edad maxima')
			 
		     if @i_ingreso >= 1200
		        insert into #mensajeAceptado (msg) values ('cumple ingreso minimo')
			 
		     if @i_tiempoLaborarEmpleoActual >= 24
		        insert into #mensajeAceptado (msg) values ('cumple tiempo de laborar')					        
		  end
		  else
		  begin
		     select @o_califica = 'N'
		     if @i_edad < 21
		        insert into #mensajeRechazo (msg) values ('no Cumple edad minima')
			 
             if @i_edad > 65
		        insert into #mensajeRechazo (msg) values ('no cumple edad maxima')
			 
		     if @i_ingreso < 1200
		        insert into #mensajeRechazo (msg) values ('no cumple ingreso minimo')
			 
		     if @i_tiempoLaborarEmpleoActual < 24
		        insert into #mensajeRechazo (msg) values ('no cumple tiempo de laborar')					        			 
		  end
	   end
       --REMESAS 19  65  1200    true       
	   if @i_relacionDependencia = 'REMESAS'
	   begin
	      if (@i_edad >= 19 and @i_edad <= 65
		     and @i_ingreso >= 1200)
		  begin
		     if @i_edad >= 19
		        insert into #mensajeAceptado (msg) values ('Cumple edad minima')
			 
             if @i_edad <= 65
		        insert into #mensajeAceptado (msg) values ('cumple edad maxima')
			 
		     if @i_ingreso >= 1200
		        insert into #mensajeAceptado (msg) values ('cumple ingreso minimo')	
		
	         select @o_califica = 'S'
		   end
		   else
		   begin
		      select @o_califica = 'N'
		     if @i_edad < 19
		        insert into #mensajeRechazo (msg) values ('no Cumple edad minima')
			 
             if @i_edad > 65
		        insert into #mensajeRechazo (msg) values ('no cumple edad maxima')
			 
		     if @i_ingreso < 1200
		        insert into #mensajeRechazo (msg) values ('no cumple ingreso minimo')				  
		   end
		end
    end	
 end
 
 	select * from #mensajeAceptado
	select * from #mensajeRechazo 

	drop table #mensajeAceptado
	drop table #mensajeRechazo 

return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end 

GO
/****** Object:  StoredProcedure [dbo].[sp_buro_ptc]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_buro_ptc]  

--tipoProducto		 
@i_tipoProducto	varchar(5)
,@i_estatus varchar(5) = null --(inTO.estatusDentroDe($param))	
,@i_aumentoLimiteCredito char(1) = null  --aumentoLimiteCredito	
,@i_antiguedad int = null   --antiguedad >$1	antiguedad <= $1	
,@i_saldo money = null   --saldo	saldo > $1	
,@i_pagoAlDia char(1) = null  --pagoAlDia		
,@i_moras60por3meses int = null  --moras60por3meses <= $1	moras60por3meses > $1	
,@i_moras60por12meses int = null  --moras60por12meses <= $1	moras60por12meses > $1	
,@i_moras90por12meses int = null  --moras90por12meses <= $1	moras90por12meses > $1	
,@i_moras120 int = null  --moras120 <= $1	moras120 > $1	
,@i_tieneCobroJudicial char(1) = null --tieneCobroJudicial	
,@i_tieneSaldoReestructurado char(1) = null --tieneSaldoReestructurado		
,@i_tieneCuentasSobregiradas char(1) = null   --tieneCuentasSobregiradas	

--action
,@o_califica char(1) = null output  --	inTO.setCalifica($param);

as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
	  
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
    
	create table #mensajeAceptado ( msg varchar(100))
	create table #mensajeRechazo  ( msg varchar(100))
	
--tipoProducto	
    if @i_tipoProducto = 'PRE'
	begin
	   --eval(inTO.estatusDentroDe($param))	
      if @i_estatus  in ( 'CA','IN','AC','NE','NU'	) 
--aumentoLimiteCredito	
--antiguedad >$1	
--antiguedad <= $1	
--saldo	
--saldo > $1	
--pagoAlDia	
        and @i_pagoAlDia = 'S'
--moras60por3meses <= $1	
        and @i_moras60por3meses = 0
--moras60por3meses > $1	
        and @i_moras60por12meses <= 1        
--moras60por12meses > $1	
        and @i_moras90por12meses <= 0	
--moras90por12meses > $1	
        and @i_moras120 <= 0
--moras120 > $1		
        and @i_tieneCobroJudicial	 = 'N'
        and @i_tieneSaldoReestructurado	= 'N'
        and @i_tieneCuentasSobregiradas = 'N'
	begin
       --inTO.setCalifica($param);
	   select @o_califica = 'S'
    end
	
	if @i_pagoAlDia = 'S'
       insert into #mensajeAceptado (msg) values ('Esta al dia con los pagos')	
	   
    if @i_moras60por3meses = 0
	   insert into #mensajeAceptado (msg) values ('No tiene moras 60 por 3 meses')	

    if @i_moras60por12meses <= 1     
       insert into #mensajeAceptado (msg) values ('Tiene menos de 2 moras 60 por 12 meses')	
	   
    if @i_moras90por12meses <= 0	
	   insert into #mensajeAceptado (msg) values ('No tiene moras 90')	
	   
    if @i_moras120 <= 0
	   insert into #mensajeAceptado (msg) values ('No tiene moras 120')	

	if @i_tieneCobroJudicial	 = 'N'
	   insert into #mensajeAceptado (msg) values ('No tiene cobros judiciales')	
	   
    if @i_tieneSaldoReestructurado	= 'N'
	   insert into #mensajeAceptado (msg) values ('No tiene saldo reestructurado')	
	   
    if @i_tieneCuentasSobregiradas = 'N'
	   insert into #mensajeAceptado (msg) values ('No tiene cuentas sobregiradas')	
					
    --condiciones de rechazo
	if @i_estatus in ('MO','CM','CJ','SR','CO')
	begin
	   select @o_califica = 'N'
	   insert into #mensajeRechazo (msg) values ('Estatus no valido')	
	end

	if @i_pagoAlDia = 'N'
       insert into #mensajeRechazo (msg) values ('Pago no esta al dia')	
	   
    if @i_moras60por3meses > 0
	   insert into #mensajeRechazo (msg) values ('tiene moras 60')	

    if @i_moras60por12meses > 1     
       insert into #mensajeRechazo (msg) values (' tiene moras 60 por 12 meses')	
	   
    if @i_moras90por12meses > 0	
	   insert into #mensajeRechazo (msg) values ('tiene moras 90')	
	   
    if @i_moras120 > 0
	   insert into #mensajeRechazo (msg) values ('tiene moras 120')	

	if @i_tieneCobroJudicial	 = 'S'
	   insert into #mensajeRechazo (msg) values ('tiene cobros judiciales')	
	   
    if @i_tieneSaldoReestructurado	= 'S'
	   insert into #mensajeRechazo (msg) values ('tiene saldo reestructurado')	
	   
    if @i_tieneCuentasSobregiradas = 'S'
	   insert into #mensajeRechazo (msg) values ('tiene cuentas sobregiradas')		



return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end 

GO
/****** Object:  StoredProcedure [dbo].[sp_buro_sipsa]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_buro_sipsa]  

@i_tipoProducto varchar(5) 
,@i_estado  varchar(5) = null --al(inTO.estatusDentroDe($param)) 
,@i_pagosAlDia char(1) = null
,@i_tieneSaldoReestructurado char(1) = null
,@i_cuotasAtrasadas6meses int = null
,@i_cuotasAtrasadas12meses int = null
,@i_cuotasAtrasadasHistoricas int = null
 
 --inTO.setCalifica($param); 
,@o_califica int = null output


as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
begin   
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
	create table #mensajeAceptado ( msg varchar(100))
	create table #mensajeRechazo  ( msg varchar(100))	   
	   
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
	if @i_tipoProducto = 'PRE'
	begin
       --pagosAlDia  tieneSaldoReestructurado  cuotasAtrasadas6meses <= $1   cuotasAtrasadas12meses <= $1  cuotasAtrasadasHistoricas <= $1
	   if @i_pagosAlDia = 'S' and @i_cuotasAtrasadas6meses <= 0 and @i_cuotasAtrasadas12meses <= 1 and @i_cuotasAtrasadasHistoricas <= 0
	   begin
          select @o_califica = 'S'
       end
	   
	   if @i_pagosAlDia = 'S'
	   begin
	      insert into #mensajeAceptado (msg) values ('Esta al dia con los pagos')
	   end
	   
	   if @i_tieneSaldoReestructurado = 'N'
	   begin
	      insert into #mensajeAceptado (msg) values ('No tiene saldo reestructurado')
	   end	   
	   
	   if @i_cuotasAtrasadas6meses <= 0
	   begin
	      insert into #mensajeAceptado (msg) values ('no tiene cuotas atrasadas 6 meses')
	   end	   
	   
	   if @i_cuotasAtrasadas12meses <= 1
	   begin
	      insert into #mensajeAceptado (msg) values ('no tiene cuotas atrasadas 12 meses')
	   end
	   
	   if @i_cuotasAtrasadasHistoricas <= 0
	   begin
	      insert into #mensajeAceptado (msg) values ('no tiene cuotas atrasadas historicos')
	   end	   
	   
       --condiciones de rechazo.
	   if @i_pagosAlDia = 'N'
	   begin
	      select @o_califica = 'N'
	      insert into #mensajeRechazo (msg) values ('Esta al dia con los pagos')
	   end
	   
	   if @i_tieneSaldoReestructurado = 'S'
	   begin
	      select @o_califica = 'N'
	      insert into #mensajeRechazo (msg) values ('No tiene saldo reestructurado')
	   end	   
	   
	   if @i_cuotasAtrasadas6meses > 0
	   begin
	      select @o_califica = 'N'
	      insert into #mensajeRechazo (msg) values ('tiene cuotas atrasadas 6 meses')
	   end	   
	   
	   if @i_cuotasAtrasadas12meses > 1
	   begin
	      select @o_califica = 'N'
	      insert into #mensajeRechazo (msg) values ('tiene cuotas atrasadas 12 meses')
	   end
	   
	   if @i_cuotasAtrasadasHistoricas > 0
	   begin
	      select @o_califica = 'N'
	      insert into #mensajeRechazo (msg) values ('tiene cuotas atrasadas historicos')
	   end	   	   
    end

	
	select * from #mensajeAceptado
	select * from #mensajeRechazo 
	
	drop table #mensajeAceptado
	drop table #mensajeRechazo 
	
return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end 

GO
/****** Object:  StoredProcedure [dbo].[sp_buro_transunion]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_buro_transunion]  
		 
@i_tipoProducto	    varchar(3) = null
,@i_tieneRefComercialesMalas	char(1) = null 
,@i_tieneRefCrediticiasMalas	char(1) = null
,@i_NJuicios2 int = null
,@i_NJuicios0a2 int = null
,@i_NJuicios1a2 int = null
,@i_moras30a1mes char(1) = null
,@i_moras30a2meses  char(1) = null
,@i_moras60por3meses  char(1) = null
,@i_moras60por12meses  char(1) = null
,@i_moras90por12meses char(1) = null
,@i_moras120  char(1) = null
,@i_cuentasCobroJudicial char(1) = null
,@i_cuentasSaldoReestructurado	char(1) = null 
,@i_cuentaIncobrable  char(1) = null
,@i_reNegociacion	 char(1) = null
,@i_retencionDelBien	 char(1) = null
,@i_cobroAdministrativo	 char(1) = null
,@i_comparteInformacion	 char(1) = null

--inTO.setCalifica($param);	
,@o_califica char(1) = null output


as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
	  
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'

begin
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
  
create table #mensajeAceptado ( msg varchar(100))
create table #mensajeRechazo  ( msg varchar(100))  
  
--false	false	0		1		1		false	false	false	2		false	false	false	false	false	false	false	false	true	true
if  (@i_tieneRefComercialesMalas = 'N'
    and @i_tieneRefCrediticiasMalas	 = 'N'
	and (@i_NJuicios2 <= 0)
 and (@i_NJuicios0a2 <= 1)
    and (@i_NJuicios1a2 <= 1)
    and @i_moras30a1mes = 'N'
 and @i_moras30a2meses = 'N'
 and @i_moras60por3meses = 'N'
 and (@i_moras60por12meses <= 2) 
 and @i_moras90por12meses = 'N'
 and @i_moras120  = 'N'
 and @i_cuentasCobroJudicial  = 'N'
 and @i_cuentasSaldoReestructurado = 'N' 
 and @i_cuentaIncobrable  = 'N'
 and @i_reNegociacion  = 'N'
 and @i_retencionDelBien  = 'N'
 and @i_cobroAdministrativo  = 'N'
 and @i_comparteInformacion  = 'S')
begin   
   select @o_califica = 'S'
   
   if @i_tieneRefComercialesMalas = 'N'
      insert into #mensajeAceptado ( msg) values ('NO TIENE REFERENCIAS COMERCIALES MALAS')      
   
   if @i_tieneRefCrediticiasMalas  = 'N'
      insert into #mensajeAceptado ( msg) values ('NO TIENE REFERENCIAS CREDITICIAS MALAS')
	  
   if (@i_NJuicios2 <= 0)
      insert into #mensajeAceptado ( msg) values ('NO TIENE JUICIOS 2')
	  
   if (@i_NJuicios0a2 <= 1)
      insert into #mensajeAceptado ( msg) values ('TIENE 1 O MENOS JUICIOS 0 A 2 AÑOS')
	  
   if (@i_NJuicios1a2 <= 1)
      insert into #mensajeAceptado ( msg) values ('TIENE 1 O MENOS JUICIOS 1 A 2 AÑOS')
	  
   if @i_moras30a1mes = 'N'
      insert into #mensajeAceptado ( msg) values ('NO TIENE MORAS 30 A 1 MES')
	  
   if @i_moras30a2meses = 'N'
      insert into #mensajeAceptado ( msg) values ('NO TIENE MORAS 30 A 2 MESES')
	  
   if @i_moras60por3meses = 'N'
      insert into #mensajeAceptado ( msg) values ('NO TIENE MORAS 60 POR 3 MESES')
	  
   if (@i_moras60por12meses <= 2) 
      insert into #mensajeAceptado ( msg) values ('TIENE 2 O MENOS MORAS 60 POR 12 MESES')   
	  
   if @i_moras90por12meses = 'N'
      insert into #mensajeAceptado ( msg) values ('NO TIENE MORAS 90')
	  
   if  @i_moras120  = 'N'
      insert into #mensajeAceptado ( msg) values ('NO TIENE MORAS 120')
	  
   if  @i_cuentasCobroJudicial  = 'N'
      insert into #mensajeAceptado ( msg) values ('NO TIENE CUENTAS CON COBRO JUDICIAL')
	  
   if  @i_cuentasSaldoReestructurado = 'N' 
      insert into #mensajeAceptado ( msg) values ('NO TIENE CUENTAS CON SALDO REESTRUCTURADO')
	  
   if  @i_cuentaIncobrable  = 'N'
      insert into #mensajeAceptado ( msg) values ('NO TIENE CUENTAS INCOBRABLES')
	  
   if  @i_reNegociacion  = 'N'
      insert into #mensajeAceptado ( msg) values ('NO TIENE CUENTAS EN RENEGOCIACION')
	  
   if  @i_retencionDelBien  = 'N'
      insert into #mensajeAceptado ( msg) values ('NO TIENE RETENCION DE BIENES')
	  
   if  @i_cobroAdministrativo  = 'N'
      insert into #mensajeAceptado ( msg) values ('NO TIENE COBROS ADMINISTRATIVOS')
	  
   if  @i_comparteInformacion  = 'S'
      insert into #mensajeAceptado ( msg) values ('COMPARTE INFORMACION')
end
else
begin	  
   --mensajes de rechazo
   select @o_califica = 'N'
   
   if @i_tieneRefComercialesMalas = 'S'
      insert into #mensajeRechazo ( msg) values ('NO TIENE REFERENCIAS COMERCIALES MALAS')      
   
   if @i_tieneRefCrediticiasMalas  = 'S'
      insert into #mensajeRechazo ( msg) values ('NO TIENE REFERENCIAS CREDITICIAS MALAS')
	  
   if (@i_NJuicios2 > 0)
      insert into #mensajeRechazo ( msg) values ('NO TIENE JUICIOS 2')
	  
   if (@i_NJuicios0a2 > 1)
      insert into #mensajeRechazo ( msg) values ('TIENE MAS DE UN JUICIO 0 A 2 AÑOS')
	  
   if (@i_NJuicios1a2 > 1)
      insert into #mensajeRechazo ( msg) values ('TIENE MAS DE UN JUICIO 1 A 2 AÑOS')
	  
   if @i_moras30a1mes = 'S'
      insert into #mensajeRechazo ( msg) values ('TIENE MORAS 30 A 1 MES')
	  
   if @i_moras30a2meses = 'S'
      insert into #mensajeRechazo ( msg) values ('TIENE MORAS 30 A 2 MESES')
	  
   if @i_moras60por3meses = 'S'
      insert into #mensajeRechazo ( msg) values ('TIENE MORAS 60 POR 3 MESES')
	  
   if (@i_moras60por12meses > 2) 
      insert into #mensajeRechazo ( msg) values ('TIENE MAS DE 2 MORAS 60 POR 12 MESES')   
	  
   if @i_moras90por12meses = 'S'
      insert into #mensajeRechazo ( msg) values ('TIENE MORAS 90')
	  
   if  @i_moras120  = 'S'
      insert into #mensajeRechazo ( msg) values ('TIENE MORAS 120')
	  
   if  @i_cuentasCobroJudicial  = 'S'
      insert into #mensajeRechazo ( msg) values ('TIENE CUENTAS CON COBRO JUDICIAL')
	  
   if  @i_cuentasSaldoReestructurado = 'S' 
      insert into #mensajeRechazo ( msg) values ('TIENE CUENTAS CON SALDO REESTRUCTURADO')
	  
   if  @i_cuentaIncobrable  = 'S'
      insert into #mensajeRechazo ( msg) values ('TIENE CUENTAS INCOBRABLES')
	  
   if  @i_reNegociacion  = 'S'
      insert into #mensajeRechazo ( msg) values ('TIENE CUENTAS EN RENEGOCIACION')
	  
   if  @i_retencionDelBien  = 'S'
      insert into #mensajeRechazo ( msg) values ('TIENE RETENCION DE BIENES')
	  
   if  @i_cobroAdministrativo  = 'S'
      insert into #mensajeRechazo ( msg) values ('TIENE COBROS ADMINISTRATIVOS')
	  
   if  @i_comparteInformacion  = 'N'
      insert into #mensajeRechazo ( msg) values ('COMPARTE INFORMACION')   
end

select * from #mensajeAceptado 
select * from #mensajeRechazo

return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end 

GO
/****** Object:  StoredProcedure [dbo].[sp_busquedaClienteListaNegra]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_busquedaClienteListaNegra]
(
@IdProceso			int = null,
@IdClaseProceso		int = null,
@CodigoObjeto		nvarchar(255)= null,
@RefBase			nvarchar(255)= null,
@primerNombre		varchar(100),
@segundoNombre		varchar(100),
@tercerNombre		varchar(100),
@primerApellido		varchar(100),
@segundoApellido	varchar(100),
@apellidoCasada		varchar(100),
@nit				varchar(100),
@ordenCedula		varchar(100),
@registroCedula		varchar(100),
@dpi				varchar(100),
@matchNombre		float output,
@idRespuestaLN		int output,
@motivo				varchar(250) output
)
as



Declare @cedula varchar(100), @nombreCompleto varchar(250)

BEGIN TRY

set @cedula = @ordenCedula + ' ' + LTRIM(rtrim(@registroCedula))
set @cedula = LTRIM(RTRIM(REPLACE(REPLACE(replace(replace(replace(@cedula,'   ',''),'  ',''),' ',''),'-',''),'_','') ))

--nit
set @nit = ltrim(rtrim(REPLACE(REPLACE(@nit,' ',''),'-','')))

--dpi
set @dpi = ltrim(rtrim(REPLACE(REPLACE(@dpi,' ',''),'-','')))

--Calculo de Nombre Completo
set @nombreCompleto		=	ltrim(rtrim(isnull(@primerApellido,''))) + ' ' + 
							ltrim(rtrim(isnull(@segundoApellido,''))) + ' ' + 
							ltrim(rtrim(isnull(@apellidoCasada,''))) + ' ' + 
							ltrim(rtrim(isnull(@primerNombre,''))) + ' ' + 
							ltrim(rtrim(isnull(@segundoNombre,''))) + ' ' + 
							ltrim(rtrim(isnull(@tercerNombre,'')))

set @nombreCompleto		=	ltrim(rtrim(replace(replace(replace(replace(@nombreCompleto,'     ',' '),'    ',' '),'   ',' '),'  ',' ')))


/*MATCH POR IDENTIFICACIONES*/

	select  numeroId, primerNombre, segundoNombre, tercerNombre, primerApellido, segundoApellido, tercerApellido,
			ltrim(rtrim(replace(replace(replace(replace(
			ltrim(rtrim(isnull(primerApellido,''))) + ' ' + 
			ltrim(rtrim(isnull(segundoApellido,''))) + ' ' + 
			ltrim(rtrim(isnull(tercerApellido,''))) + ' ' + 
			ltrim(rtrim(isnull(primerNombre,''))) + ' ' + 
			ltrim(rtrim(isnull(segundoNombre,''))) + ' ' + 
			ltrim(rtrim(isnull(tercerNombre,'')))
			,'     ',' '),'    ',' '),'   ',' '),'  ',' '))) as NombreCompleto,
			MOTIVO
	into	#tempCliente
	from	ListaNegra
	where	LTRIM(RTRIM(REPLACE(REPLACE(replace(replace(replace(numeroId,'   ',''),'  ',''),' ',''),'-',''),'_','') )) in (@nit,@cedula,@dpi)
			and estado = 'V' and ltrim(rtrim(numeroId)) <> ''
	
	alter table #tempCliente add matchNombre float
	Update #tempCliente set matchNombre = (dbo.fnIndiceBigramas(@nombreCompleto, NombreCompleto))
		

	if (select COUNT(*) from #tempCliente WHERE matchNombre >= 0.85) = 0
	Begin
	set @idRespuestaLN = 1 set @motivo = 'Sujeto no encontrado en lista negra'
	End
			
	if (select COUNT(*) from #tempCliente where matchNombre >= 0.85) = 1
	Begin
	select @matchNombre = matchNombre, @idRespuestaLN = 0, @motivo = motivo from #tempCliente
	End
	
	if (select COUNT(*) from #tempCliente where matchNombre >= 0.85) > 1
	Begin
	--set @idRespuestaLN = 2 set @motivo = 'Sujeto Existe Mas de una vez'
    --## JCRODAS: 03/10/2013 02:41 PM, Arreglo temporal para que no      ##
    --## llegue a manual los casos cuando existe mas de una coincidencia ##
      set @idRespuestaLN = 0 set @motivo = 'Sujeto Existe Mas de una vez'
	End

	
	
	
END TRY
BEGIN CATCH
set @idRespuestaLN = 3
END CATCH


GO
/****** Object:  StoredProcedure [dbo].[sp_busquedaClienteOFAC]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_busquedaClienteOFAC]
(
@IdProceso			int = null,
@IdClaseProceso		int = null,
@CodigoObjeto		nvarchar(255)= null,
@RefBase			nvarchar(255)= null,
@primerNombre		varchar(100),
@segundoNombre		varchar(100),
@tercerNombre		varchar(100),
@primerApellido		varchar(100),
@segundoApellido	varchar(100),
@apellidoCasada		varchar(100),
@matchNombre		float output,
@idRespuestaOFAC	int output,
@motivo				varchar(100) output,
@coincidencia1		varchar(250) output,
@coincidencia2		varchar(250) output
)
as



Declare @nombreCompleto varchar(250), @nombres varchar(250), @apellidos varchar(250), @uid int
select @coincidencia1 = '', @coincidencia2 = ''

BEGIN TRY


--Calculo de Nombre Completo
set @nombreCompleto		=	ltrim(rtrim(isnull(@primerApellido,''))) + ' ' + 
							ltrim(rtrim(isnull(@segundoApellido,''))) + ' ' + 
							ltrim(rtrim(isnull(@apellidoCasada,''))) + ' ' + 							
							ltrim(rtrim(isnull(@primerNombre,''))) + ' ' + 
							ltrim(rtrim(isnull(@segundoNombre,''))) + ' ' + 
							ltrim(rtrim(isnull(@tercerNombre,'')))
set @nombreCompleto		=	isnull(ltrim(rtrim(replace(replace(replace(replace(@nombreCompleto,'     ',' '),'    ',' '),'   ',' '),'  ',' '))),'')

--Calculo Nombres
set @nombres			=	ltrim(rtrim(isnull(@primerNombre,''))) + ' ' + 
							ltrim(rtrim(isnull(@segundoNombre,''))) + ' ' + 
							ltrim(rtrim(isnull(@tercerNombre,'')))
set @nombres			=	isnull(ltrim(rtrim(replace(replace(replace(replace(@nombres,'     ',' '),'    ',' '),'   ',' '),'  ',' '))),'')

--Calculo Apellidos
set @apellidos			=	ltrim(rtrim(isnull(@primerApellido,''))) + ' ' + 
							ltrim(rtrim(isnull(@segundoApellido,''))) + ' ' + 
							ltrim(rtrim(isnull(@apellidoCasada,'')))
set @apellidos			=	isnull(ltrim(rtrim(replace(replace(replace(replace(@apellidos,'     ',' '),'    ',' '),'   ',' '),'  ',' '))),'')



select isnull(nombre,'')+' '+isnull(apellido,'') as NombreCompleto, uid
INTO #tempCliente2
from OFCEntes 
where (nombre in (@nombres, @apellidos) or apellido in (@nombres, @apellidos))


select	*, dbo.fnIndiceBigramas(NombreCompleto,@nombreCompleto) as matchNombre
INTO	#tempCliente 
from	#tempCliente2 
where	dbo.fnIndiceBigramas(NombreCompleto,@nombreCompleto) > 0.75


	if (select COUNT(*) from #tempCliente WHERE matchNombre >= 0.75) = 0
	Begin
		set @idRespuestaOFAC= 1 set @motivo = 'Sujeto no encontrado en OFAC'
	End
			
	if (select COUNT(*) from #tempCliente where matchNombre >= 0.75) = 1
	Begin
	
		select	@matchNombre = matchNombre, @idRespuestaOFAC = 2, @motivo = 'Sujeto se encuentra en OFAC',
				@coincidencia1 = 'NombreCompleto: ' + isnull(NombreCompleto,'') + ' - Uid: ' + isnull(cast(uid as varchar(25)),'') + ' - %Match: ' + cast(matchNombre as varchar(25)) + ''
		from	#tempCliente
	
	End
	
	if (select COUNT(*) from #tempCliente where matchNombre >= 0.75) > 1
	Begin
		set @idRespuestaOFAC = 2 set @motivo = 'Sujeto Existe Mas de una vez'
		
		--coincidencia1
		select	top 1 
				@coincidencia1 = 'NombreCompleto: ' + isnull(NombreCompleto,'') + ' - Uid: ' + isnull(cast(uid as varchar(25)),'') + ' - %Match: ' + cast(matchNombre as varchar(25)) + '',
				@uid = uid
		from	#tempCliente
		--coincidencia2
		select top 1
				@coincidencia2 = 'NombreCompleto: ' + isnull(NombreCompleto,'') + ' - Uid: ' + isnull(cast(uid as varchar(25)),'') + ' - %Match: ' + cast(matchNombre as varchar(25)) + ''
		from	#tempCliente
		where	uid <> @uid
		order by matchNombre desc
	
	End


END TRY
BEGIN CATCH
set @idRespuestaOFAC = 3 set @motivo = 'Error en consulta'
END CATCH







GO
/****** Object:  StoredProcedure [dbo].[sp_calificacion_buro_sipsa]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_calificacion_buro_sipsa]  
		 
@i_antiguedadCliente int = null 
,@i_pagoAlDia	char(1) = null
,@i_porcentajeCancelacion int = null
,@i_porcentajePlazo  int = null
,@i_estadoCredito	char(2) = null
,@i_lapsoUltimoEstado  int = null
,@i_moras30	 int = null
,@i_moras60	 int = null
,@i_moras90 int = null
,@i_moras120 int = null
,@i_moras180 int = null
,@i_calificacionAnterior varchar(10) = null
--accion
,@o_calificacionAsignada varchar(10) = null output

as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
	  
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'

begin
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
    
 --antiguedadCliente > $param   pagoAlDia   porcentajeCancelacion > $param   porcentajePlazo > $param   estadoCredito   lapsoUltimoEstado < $param   moras30  calificacion anterior   inTO.setCalificacionAsignada("$param");
 --12                           true        50                               50                         AC                                                                             AAA
    if  @i_antiguedadCliente = 12 
	   and @i_pagoAlDia = 'S' 
	   and @i_porcentajeCancelacion > 50
	   and @i_porcentajePlazo > 50
	   and @i_estadoCredito = 'AC'
	begin
	   select @o_calificacionAsignada = 'AAA'
	end
 --12                           true        50                               50                         CN              3                                                              AAA
   if  @i_antiguedadCliente = 12 
	   and @i_pagoAlDia = 'S' 
	   and @i_porcentajeCancelacion > 50
	   and @i_porcentajePlazo > 50
	   and @i_estadoCredito = 'CN'
	   and @i_lapsoUltimoEstado < 3
	begin
	   select @o_calificacionAsignada = 'AAA'
	end
	
 --12                           true        50                               50                         AC                                           1                                 AA
    if  @i_antiguedadCliente = 12 
	   and @i_pagoAlDia = 'S' 
	   and @i_porcentajeCancelacion > 50
	   and @i_porcentajePlazo > 50
	   and @i_estadoCredito = 'AC'
	   and @i_moras30 = 1
	begin
	   select @o_calificacionAsignada = 'AA'
	end
	
 --12                           true        50                               50                         CN              3                            1                                 AA
    if  @i_antiguedadCliente = 12 
	   and @i_pagoAlDia = 'S' 
	   and @i_porcentajeCancelacion > 50
	   and @i_porcentajePlazo > 50
	   and @i_estadoCredito = 'CN'
	   and @i_lapsoUltimoEstado < 3
	   and @i_moras30 = 1
	begin
	   select @o_calificacionAsignada = 'AA'
	end 
 
 --6                            true        50                               50                         AC                                           2                                 A
    if  @i_antiguedadCliente = 12 
	   and @i_pagoAlDia = 'S' 
	   and @i_porcentajeCancelacion > 50
	   and @i_porcentajePlazo > 50
	   and @i_estadoCredito = 'AC'
	   and @i_moras30 = 2
	begin
	   select @o_calificacionAsignada = 'A'
	end
	
 --6                            true        50                               50                         CN              3                            2                                 A
    if  @i_antiguedadCliente = 12 
	   and @i_pagoAlDia = 'S' 
	   and @i_porcentajeCancelacion > 50
	   and @i_porcentajePlazo > 50
	   and @i_estadoCredito = 'AC'
	   and @i_lapsoUltimoEstado < 3
	   and @i_moras30 = 2
	begin
	   select @o_calificacionAsignada = 'A'
	end	   


return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end 

GO
/****** Object:  StoredProcedure [dbo].[sp_configuracion_formulario]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_configuracion_formulario]
	-- Add the parameters for the stored procedure here
	@i_idFormulario int
	,@i_etapa varchar(5)
AS
declare @w_rowcount int
BEGIN
    if not exists(select 1 from formulario
	   where correlativo = @i_idFormulario
	   and etapa = @i_etapa)
	begin
       raiserror ('FORMULARIO NO EXISTE', 15, 1)
	   return -1
	end

    --detalle de formulario
	select * from formulario
	where correlativo = @i_idFormulario
	and etapa = @i_etapa

	-- preguntas
	if not exists(select 1 from preguntas
	    where idFormulario = @i_idFormulario)
	begin
       raiserror ('FORMULARIO NO TIENE PREGUNTAS ASOCIADAS', 15, 1)
	   return -1
	end

	select * from preguntas
	where idFormulario = @i_idFormulario


	--respuestas
	select r.* from respuesta r
	inner join preguntas p on (p.correlativo = r.idPregunta)
    inner join formulario f on (f.correlativo = p.idFormulario)
	where f.correlativo = @i_idFormulario
	and f.etapa = @i_etapa

	select @w_rowcount = @@ROWCOUNT
	if @w_rowcount = 0
	begin
       raiserror ('FORMULARIO NO TIENE RESPUESTAS ASOCIADAS', 15, 1)
	   return -1	   
	end

	--resultado
	select rs.*
	from resultado_formulario rs
	inner join formulario f on (f.correlativo = rs.idFormulario)
	where f.correlativo = @i_idFormulario
	and f.etapa = @i_etapa

	select rsd.*
	from resultado_formulario_detalle rsd
	inner join resultado_formulario rs on (rs.correlativo = rsd.idResultado)
	inner join formulario f on (f.correlativo = rs.idFormulario)
	where f.correlativo = @i_idFormulario
	and f.etapa = @i_etapa
END

GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_etapa_a_procesar]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_consulta_etapa_a_procesar] 
	@i_corrtramite	int
	,@i_inmediata_anterior char(1) = 'N'
	,@i_etapa_siguiente char(1) = 'S'
	,@o_etapa		etapa = null output
	,@o_estado		estado = null output
	,@o_orden		int = null output
AS
declare @w_error_msg varchar(500)
	,@w_estadotramite estado
BEGIN
	--verificar si el tramite tiene un flujo asociado.
	if not exists (select 1 from tramiteflujo where corrtramite = @i_corrtramite)
	begin
		--raiserror 30000 'TRAMITE NO TIENE ASOCIADO FLUJO'
		raiserror ('TRAMITE NO TIENE ASOCIAADO FLUJO',1,16)
		return 1
	end

	if @i_inmediata_anterior = 'S'
	begin
		select top 1 @o_etapa	= etapa
					,@o_estado	= estatus
					,@o_orden	= orden
		from tramiteflujo 
		where corrtramite = @i_corrtramite		
		and etapa not in (@o_etapa)
		and orden < @o_orden
		order by orden

		return 0
	end
	else
	begin
		if @i_etapa_siguiente = 'S'
		begin							
			select top 1 @o_etapa	= etapa
					,@o_estado	= estatus
					,@o_orden	= orden
			from tramiteflujo 
			where corrtramite = @i_corrtramite
			and estatus = 'PE'
			order by orden
		end
		else
		begin
			select @w_estadotramite = estadoProceso
			from tramiteprocesos
			where corrtramite = @i_corrtramite

			if @@rowcount = 0
			begin
				raiserror ('NO SE ENCONTRO TRAMITE [%1]',18,16, @i_corrtramite)
				return 1
			end
			
			if @w_estadotramite in ('SP','ER')
				select top 1 @o_etapa	= etapa
						,@o_estado	= estatus
						,@o_orden	= orden
				from tramiteflujo 
				where corrtramite = @i_corrtramite
				and estatus = @w_estadotramite
				order by orden	

			if @@rowcount = 0
			--si no hay suspendidas, halar las que estan RECHAZADAS, CANCELADAS, o DEVUELTAS.
				select top 1 @o_etapa	= etapa
						,@o_estado	= estatus
						,@o_orden	= orden
				from tramiteflujo 
				where corrtramite = @i_corrtramite
				and estatus in ('RE','CN','DV')
				order by orden	
		end
	end
END



GO
/****** Object:  StoredProcedure [dbo].[sp_corrtramite_Dinamico]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--
-- sp_corrtramite_Dinamico
--
CREATE PROCEDURE [dbo].[sp_corrtramite_Dinamico]
(
    @origen          varchar(20)--, @prueba varchar(20)
)
as
begin
	-- Elimina temporal 
	if  (object_id('tempdb..#Temp1') is not null) drop table #Temp
     
	-- Verifica que la tabla tengo el la ultima fecha procesada
	DELETE FROM TramiteDinamico   WHERE Fecha <  convert(date,getdate()); 
 
 Begin tran; 
	-- Query en general 
	SELECT  TOP 1
			ct.corrtramite, 
			ct.etapa,  
			tp.categoriaProducto,
			tp.promocion,
			tp.campania,
			ct.resultadoAprobaciontotal, 
			ct.observacionResultadoAprobacionTotal, 
			s.codigoVendedor, 
			s.oficina, 
	--             'nombre_agencia'=(select ag.nombre_agencia from operacion..agencias ag where tp.origen = 'SIPSA' and ag.cod_agencia *= s.oficina and ag.cod_empresa= 1 
	--                 union select ca.descripcion from ptc..ca_oficina ca where tp.origen = 'PTC' and ca.codigo *= s.oficina) , 
			'nombre_agencia'=(select ag.nombre_agencia from operacion..agencias ag where tp.origen = 'SIPSA' and ag.cod_agencia = s.oficina and ag.cod_empresa= 1 
				union select ca.descripcion from ptc..ca_oficina ca where tp.origen = 'PTC' and ca.codigo = s.oficina) , 
		tp.usuario, 
			ct.url, 
			tp.origen, 
			'fechaCreacionFormulario'=ct.fechaIngreso, 
			'ultima Fecha Modificacion formulario'=ct.fechaUltModificacion, 
			'fecha ingreso tramite'= ts.fechaIngreso,ts.corrsolicitud 
	into #temp
	FROM    cuestionariotramite ct with (NOLOCK), 
			tramitesolicitud ts    with (NOLOCK), 
			tramiteprocesos tp     with (NOLOCK), 
			solicitud s            with (NOLOCK) 
	WHERE   ct.resultadoAprobacionTotal in ('PC','PE') 
			AND ct.corrtramite = ts.corrtramite 
			AND tp.corrtramite = ts.corrtramite 
			AND tp.estadoProceso = 'SP' 
			AND tp.estadoOperativo = 'EP' 
			AND ts.corrsolicitud = s.correlativo 
			AND tp.origen = case when @origen is null then tp.origen else @origen End
			AND not exists (select 1 
			                  from TramiteDinamico xx
							 where xx.corrTramite = ts.corrtramite
							   and xx.origen      = tp.origen)
	ORDER BY ts.fechaIngreso desc;

	-- Insert a los consultados en el dia. 
	 INSERT INTO [dbo].[TramiteDinamico] 
	          ([corrSolicitud],[corrTramite],[fecha],[origen])
     select corrSolicitud,corrtramite,convert(date,getdate()),origen
	   from #temp ;   

     select * from #temp;

 commit tran;

end 	



GO
/****** Object:  StoredProcedure [dbo].[sp_corrtramite_formularios_pendientes]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--
-- sp_sabana_datos_formularios_pendientes.sql
--
Create PROCEDURE [dbo].[sp_corrtramite_formularios_pendientes]
(
    @origen          varchar(20), --, @prueba varchar(20)
	@corrtramite     integer 
)
as
begin
     SELECT  TOP 5000
             ct.corrtramite, 
             ct.etapa,  
             tp.categoriaProducto,
             tp.promocion,
             tp.campania,
             ct.resultadoAprobaciontotal, 
             ct.observacionResultadoAprobacionTotal, 
             s.codigoVendedor, 
             s.oficina, 
--             'nombre_agencia'=(select ag.nombre_agencia from operacion..agencias ag where tp.origen = 'SIPSA' and ag.cod_agencia *= s.oficina and ag.cod_empresa= 1 
--                 union select ca.descripcion from ptc..ca_oficina ca where tp.origen = 'PTC' and ca.codigo *= s.oficina) , 
             'nombre_agencia'=(select ag.nombre_agencia from operacion..agencias ag where tp.origen = 'SIPSA' and ag.cod_agencia = s.oficina and ag.cod_empresa= 1 
                 union select ca.descripcion from ptc..ca_oficina ca where tp.origen = 'PTC' and ca.codigo = s.oficina) , 
            tp.usuario, 
             ct.url, 
             tp.origen, 
             'fechaCreacionFormulario'=ct.fechaIngreso, 
             'ultima Fecha Modificacion formulario'=ct.fechaUltModificacion, 
             'fecha ingreso tramite'= ts.fechaIngreso 
     FROM    cuestionariotramite ct with (NOLOCK), 
             tramitesolicitud ts  with (NOLOCK), 
             tramiteprocesos tp  with (NOLOCK), 
             solicitud s  with (NOLOCK) 
     WHERE   ct.corrtramite = @corrtramite
	         AND ct.resultadoAprobacionTotal in ('PC','PE') 
             AND ct.corrtramite = ts.corrtramite 
             AND tp.corrtramite = ts.corrtramite 
             AND tp.estadoProceso = 'SP' 
             AND tp.estadoOperativo = 'EP' 
			 AND ts.corrsolicitud = s.correlativo 
             AND tp.origen = case when @origen is null then tp.origen else @origen End
     ORDER BY ts.fechaIngreso
end




GO
/****** Object:  StoredProcedure [dbo].[sp_corrtramite_tramite_persona]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- sp_sabana_datos_tramite_persona.sql
--
CREATE PROCEDURE [dbo].[sp_corrtramite_tramite_persona]
(
    @origen            varchar(20),
	@corrtramite       integer
)
as
begin


      SELECT  tp.corrtramite,
              tpi.idTramite,
              tpi.secuencialBanru,
              tp.estadoOperativo,
              tp.estadoProceso,   
              tp.producto,   
              tp.origen,   
              tp.campania,
              tp.promocion,
              tp.fechaIngreso,  
              tp.fechaultmodif,    
              c.primerNombre, 
              c.segundoNombre,  
              c.primerApellido, 
              c.segundoApellido,   
              c.apellidoCasada,  
              c.numdocid,   
              c.nit,   
              c.cui, 
              tp.codigoFlujo, 
              tpi.oficina,  
              tp.usuario,  
              enHistorico='N', 
              'descripcionAgencia'= dbo.descripcionOficina(tpi.oficina, tp.origen), 
              'categoriaRechazo'=dbo.categoriasRechazo(tp.corrtramite, 'N'),
              tf.etapa,
              tf.estatus, 
              tf.ultSecuencialGenerado, 
              'horafinal'=isnull( bb.horaFinal , tp.fechaultmodif),   
              'añoIngresoEtapa'= datepart(yyyy,bb.horaInicio),	 
              'mesIngresoEtapa'= datepart(month,bb.horaInicio), 
              'semanaIngresoEtapa'= datepart(ww,bb.horaInicio), 
              'observaciones'=convert(varchar(8000),bb.observaciones), 
              'duracionMinutos'=datediff (minute, tp.fechaingreso, tp.fechaultmodif),
              'duracionDias'=datediff (day, tp.fechaingreso, tp.fechaultmodif),
              'diaFinalizacion'= datepart(day, isnull( bb.horaFinal , tp.fechaultmodif)), 
              'semanaFinalizacion'= datepart(week, isnull( bb.horaFinal , tp.fechaultmodif)), 
              'mesFinalizacion'=datepart(month, isnull( bb.horaFinal , tp.fechaultmodif)), 
              'anioFinalizacion'=datepart(year, isnull( bb.horaFinal , tp.fechaultmodif)), 
              'ultima etapa'= isnull(tf.etapa, dbo.ultimaEtapaAprobada (tp.corrtramite, tp.estadoOperativo, 'N')), 
              tp.corrPreautorizacion
     FROM     tramiteprocesos tp WITH (NOLOCK)
     INNER JOIN     tramitepersonaindividual tpi WITH (NOLOCK) ON (tpi.corrtramite = tp.corrtramite )
     INNER JOIN     cliente c WITH (NOLOCK) ON (tpi.corrcliente = c.correlativo)
     LEFT JOIN      tramiteflujo tf WITH(NOLOCK) ON (tf.corrtramite = tp.corrtramite
                    AND (tp.estadoOperativo IN ('DV','RE','CN') AND (tp.estadoOperativo = tf.estatus OR tf.estatus = 'SP')
                    OR (tp.estadoOperativo IN ('EP') AND tp.estadoProceso IN ('SP', 'EP', 'ER') AND tf.estatus = tp.estadoProceso)))
     LEFT JOIN      bitacoraetapas bb ON (bb.secuencialGenerado = tf.ultsecuencialgenerado  
                    AND bb.corrtramite= tp.corrtramite  
                    AND bb.etapa = tf.etapa)  
     WHERE      tp.estramitepersona = 'S'
				AND tp.origen = case WHEN @origen IS NULL THEN tp.origen ELSE @origen END
				AND tp.corrTramite = @corrtramite



     --UNION 
     --    SELECT   tp.corrtramite,
     --             tpi.idTramite,
     --             tpi.secuencialBanru,
     --             tp.estadoOperativo,    
     --             tp.estadoProceso,   
     --             tp.producto,   
     --             tp.origen, 
     --             tp.campania,  
     --             tp.promocion,
     --             tp.fechaIngreso,  
     --             tp.fechaultmodif,    
     --             c.primerNombre, 
     --             c.segundoNombre,  
     --             c.primerApellido, 
     --             c.segundoApellido,   
     --             c.apellidoCasada,  
     --             c.numdocid,   
     --             c.nit,   
     --             c.cui, 
     --             tp.codigoFlujo, 
     --             tpi.oficina,  
     --             tp.usuario,  
     --             enHistorico='S', 
     --             'descripcionAgencia'= dbo.descripcionOficina(tpi.oficina, tp.origen), 
     --             'categoriaRechazo'=dbo.categoriasRechazo(tp.corrtramite, 'S'),
     --             tf.etapa,
     --             tf.estatus, 
     --             tf.ultSecuencialGenerado, 
     --             'horafinal'=isnull( bb.horaFinal , tp.fechaultmodif),   
     --             'añoIngresoEtapa'= datepart(yyyy,bb.horaInicio),	 
     --             'mesIngresoEtapa'= datepart(month,bb.horaInicio), 
     --             'semanaIngresoEtapa'= datepart(ww,bb.horaInicio), 
     --             'observaciones'=convert(varchar(8000),bb.observaciones), 
     --             'duracionMinutos'=datediff (minute, tp.fechaingreso, tp.fechaultmodif),
     --             'duracionDias'=datediff (day, tp.fechaingreso, tp.fechaultmodif),
     --             'diaFinalizacion'= datepart(day, isnull( bb.horaFinal , tp.fechaultmodif)), 
     --             'semanaFinalizacion'= datepart(week, isnull( bb.horaFinal , tp.fechaultmodif)), 
     --             'mesFinalizacion'=datepart(month, isnull( bb.horaFinal , tp.fechaultmodif)), 
     --             'anioFinalizacion'=datepart(year, isnull( bb.horaFinal , tp.fechaultmodif)), 
     --             'ultima etapa'= isnull(tf.etapa, dbo.ultimaEtapaAprobada (tp.corrtramite, tp.estadoOperativo, 'S')), 
     --             tp.corrPreautorizacion

     --    FROM creditfactoryhis..tramiteprocesos tp WITH (NOLOCK)
     --    INNER JOIN creditfactoryhis..tramitepersonaindividual tpi WITH (NOLOCK) ON (tpi.corrtramite = tp.corrtramite )
     --    INNER JOIN creditfactoryhis..cliente c WITH (NOLOCK) ON (tpi.corrcliente = c.correlativo)
     --    LEFT JOIN  creditfactoryhis..tramiteflujo tf WITH (NOLOCK) ON (tf.corrtramite = tp.corrtramite
     --           AND (tp.estadoOperativo IN ('DV','RE','CN') AND (tp.estadoOperativo = tf.estatus OR tf.estatus = 'SP')
     --           OR (tp.estadoOperativo IN ('EP') AND tp.estadoProceso IN ('SP', 'EP', 'ER') AND tf.estatus = tp.estadoProceso)))
     --    LEFT JOIN creditfactoryhis..bitacoraetapas bb ON (bb.secuencialGenerado = tf.ultsecuencialgenerado  
     --           AND bb.corrtramite= tp.corrtramite  
     --           AND bb.etapa = tf.etapa)  

     --    WHERE  tp.estramitepersona = 'S'
     --           AND tp.origen = case WHEN @origen IS NULL THEN tp.origen ELSE @origen END
     --           AND tp.fechaIngreso >= case WHEN @fechaIni IS NULL THEN tp.fechaIngreso ELSE @fechaIni END
     --           AND tp.fechaIngreso < case WHEN @fechaFin IS NULL THEN tp.fechaIngreso ELSE @fechaFin END

     --           AND tp.estadoOperativo = case WHEN @estadoTramite = 'AP' OR @estadoTramite = 'RE' OR @estadoTramite = 'CN' OR @estadoTramite = 'DV' OR @estadoTramite = 'EP' OR @estadoTramite = 'PM' THEN  @estadoTramite ELSE tp.estadoOperativo END
     --           AND tp.estadoProceso = case WHEN @estadoTramite = 'ER' THEN  @estadoTramite ELSE tp.estadoProceso END

     --           AND tp.codigoflujo = case WHEN @flujo IS NOT NULL AND @flujo  != '' THEN @flujo ELSE tp.codigoflujo END
     ORDER BY tp.fechaingreso
END


GO
/****** Object:  StoredProcedure [dbo].[sp_corrtramite_tramite_solicitud]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- sp_sabana_datos_tramite_solicitud.sql
--
CREATE PROCEDURE [dbo].[sp_corrtramite_tramite_solicitud]
(
    @origen            varchar(20),
    @corrtramite       integer
)
as
begin
         SELECT      tp.corrtramite,    
                     tp.fechaIngreso,   
                     horaIngreso=convert(varchar,getdate(), 108),  
                     añoIngreso=datepart(yyyy, tp.fechaIngreso),   
                     mesIngreso=datepart(month, tp.fechaIngreso),  
                     semanaIngreso=datepart(ww, tp.fechaingreso),  
                     tp.corrtramite,  
                     s.oficina,  
                     'descripcionAgencia'= dbo.descripcionOficina(s.oficina, tp.origen),  
                     s.codigoVendedor,   
                     'usuario'=tp.usuario,   
                     s.categoriaProducto,    
                     'destinoProducto'=tp.producto,    
                     tp.estadoOperativo,     
                     tp.estadoProceso,   
                     s.montoCredito,   
                     tp.montoActual,   
                     s.cuotaPrestamo,    
                     tp.cuotaActual,    
                     s.periodicidadCuotas,  
                     correlativoCliente =c.correlativo,   
                     s.correlativoExterno,   
                     ingresoTotal=dbo.getIngresoNeto(c.correlativo, c.ingresomensualotr, c.ingresomensualremesas, c.ingresoformulario, 'N'),
                     c.primerNombre,     
                     c.segundonombre,  
                     c.primerapellido,  
                     c.segundoapellido,  
                     c.apellidocasada,  
                     c.numdocid,    
                     c.NIT,   
                     c.fechanacimiento,    
                     c.cui, 
                     tp.codigoFlujo,   
                     'numeroCredito'=char(39) + s.numcredito,  
                     tp.emision,  
                     'categoriaRechazo'= 
                     case WHEN ( dbo.categoriasRechazo(tp.corrtramite, 'N') <> '' and @origen like 'PTC' and tf.estatus in ('RE','DV') and  tf.etapa in ('FTCR','AUTCR'))
                        then (dbo.categoriasRechazo(tp.corrtramite, 'N') + ' : ')  else dbo.categoriasRechazo(tp.corrtramite, 'N') end
                        +
                      case WHEN (@origen like 'PTC' and tf.estatus in ('RE','DV') and  tf.etapa in ('FTCR','AUTCR')) 
                          THEN ((select top 1  cuestionario.respuestaAbierta from CuestionarioTramitePreguntas as cuestionario
                                        where (cuestionario.respuestaabierta is not null and ltrim(rtrim(cuestionario.respuestaabierta)) <> '') 
                                        and cuestionario.pregunta like 'MOTIVO DE AUTORIZACION'
                                        and cuestionario.corrCuestionario in (
                                         select cpersona.correlativo from CuestionarioTramitePersona as cpersona
                                         where cpersona.corrPrincipal in (
                                                select top 1 ctramite.correlativo from cuestionariotramite ctramite
                                                where ctramite.corrTramite = tp.corrtramite
                                                and ctramite.etapa = tf.etapa
                                                order by ctramite.correlativo desc
                                            )
                                        )
                                    ) 
                             )
                         ELSE '' END,  
                      enHistorico='N', 
                      'NOMBRE VENDEDOR'=s.descripcionVendedor,   
                      tf.etapa,  
                      tf.estatus,  
                      tf.ultSecuencialGenerado,  
                      horafinal=isnull( bb.horaFinal , tp.fechaultmodif),   
                     'añoIngresoEtapa'= datepart(yyyy,bb.horaInicio),	 
                     'mesIngresoEtapa'= datepart(month,bb.horaInicio), 
                     'semanaIngresoEtapa'= datepart(ww,bb.horaInicio), 
                      'duracionMinutos'= datediff (minute, tp.fechaingreso, tp.fechaultmodif), 
                      'duracionDias'= datediff (day, tp.fechaingreso, tp.fechaultmodif),  
                      'diaFinalizacion'= datepart(day, isnull( bb.horaFinal , tp.fechaultmodif)), 
                      'semanaFinalizacion'= datepart(week, isnull( bb.horaFinal , tp.fechaultmodif)), 
                      'mesFinalizacion'=datepart(month, isnull( bb.horaFinal , tp.fechaultmodif)), 
                      'anioFinalizacion'=datepart(year, isnull( bb.horaFinal , tp.fechaultmodif)), 
                      'ultima etapa'= isnull(tf.etapa, dbo.ultimaEtapaAprobada (tp.corrtramite, tp.estadoOperativo, 'N')), 
                      c.montodeudaacumulada, 
                      c.montocuotaacumulada
         FROM         tramiteprocesos tp  WITH (NOLOCK)  
         INNER JOIN   tramitesolicitud ts  WITH (NOLOCK) ON (ts.corrtramite = tp.corrtramite)  
         INNER JOIN   solicitud s  WITH (NOLOCK) ON (ts.corrsolicitud = s.correlativo)  
         INNER JOIN   cliente c  WITH (NOLOCK) ON (s.corrclientesolicitante = c.correlativo)  
         LEFT JOIN    tramiteflujo tf  WITH (NOLOCK) ON (tf.corrtramite = tp.corrtramite   
              AND (tp.estadoOperativo IN ('DV','RE','CN') AND (tp.estadoOperativo = tf.estatus OR tf.estatus = 'SP')  
              OR (tp.estadoOperativo IN ('EP') AND tp.estadoProceso IN ('SP', 'EP', 'ER') AND tf.estatus = tp.estadoProceso)))  
         LEFT JOIN bitacoraetapas bb  WITH(NOLOCK) ON (bb.secuencialGenerado = tf.ultsecuencialgenerado  
              AND bb.corrtramite= tp.corrtramite  
              AND bb.etapa = tf.etapa)  
         WHERE tp.estramitesolicitud = 'S'

                    AND tp.origen = case WHEN @origen IS NULL THEN tp.origen ELSE @origen END
					AND tp.corrTramite = @corrtramite
                   

         --UNION 
         --    SELECT      tp.corrtramite,    
         --                tp.fechaIngreso,   
         --                horaIngreso=convert(varchar,getdate(), 108),  
         --                añoIngreso=datepart(yyyy, tp.fechaIngreso),   
         --                mesIngreso=datepart(month, tp.fechaIngreso),  
         --                semanaIngreso=datepart(ww, tp.fechaingreso),  
         --                tp.corrtramite,  
         --                s.oficina,  
         --                'descripcionAgencia'= dbo.descripcionOficina(s.oficina, tp.origen),  
         --                s.codigoVendedor,   
         --                'usuario'=tp.usuario,   
         --                s.categoriaProducto,    
         --                'destinoProducto'=tp.producto,    
         --                tp.estadoOperativo,     
         --                tp.estadoProceso,   
         --                s.montoCredito,   
         --                tp.montoActual,   
         --                s.cuotaPrestamo,    
         --                tp.cuotaActual,    
         --                s.periodicidadCuotas,  
         --                correlativoCliente =c.correlativo,   
         --                s.correlativoExterno,   
         --                ingresoTotal=dbo.getIngresoNeto(c.correlativo, c.ingresomensualotr, c.ingresomensualremesas, c.ingresoformulario, 'S'), 
         --                c.primerNombre,     
         --                c.segundonombre,  
         --                c.primerapellido,  
         --                c.segundoapellido,  
         --                c.apellidocasada,  
         --                c.numdocid,    
         --                c.NIT,   
         --                c.fechanacimiento,    
         --                c.cui, 
         --                tp.codigoFlujo,   
         --                'numeroCredito'=char(39) + s.numcredito,  
         --                tp.emision,  
         --            'categoriaRechazo'= 
         --            case WHEN ( dbo.categoriasRechazo(tp.corrtramite, 'S') <> '' and @origen like 'PTC' and tf.estatus in ('RE','DV') and  tf.etapa in ('FTCR','AUTCR'))
         --               then (dbo.categoriasRechazo(tp.corrtramite, 'S') + ' : ')  else dbo.categoriasRechazo(tp.corrtramite, 'S') end
         --               +
         --             case WHEN (@origen like 'PTC' and tf.estatus in ('RE','DV') and  tf.etapa in ('FTCR','AUTCR')) 
         --                 THEN ((select  top 1 cuestionario.respuestaAbierta from CuestionarioTramitePreguntas as cuestionario
         --                               where (cuestionario.respuestaabierta is not null and ltrim(rtrim(cuestionario.respuestaabierta)) <> '') 
         --                               and  cuestionario.pregunta like 'MOTIVO DE AUTORIZACION'
         --                               and cuestionario.corrCuestionario in (
         --                                select cpersona.correlativo from CuestionarioTramitePersona as cpersona
         --                                where cpersona.corrPrincipal in (
         --                                       select top 1 ctramite.correlativo from cuestionariotramite ctramite
         --                                       where ctramite.corrTramite = tp.corrtramite
         --                                       and ctramite.etapa = tf.etapa
         --                                       order by ctramite.correlativo desc
         --                                   )
         --                               )
         --                           ) 
         --                    )
         --                ELSE '' END,  
         --                enHistorico='S', 
         --                'NOMBRE VENDEDOR'=s.descripcionVendedor,   
         --                tf.etapa,  
         --                tf.estatus,  
         --                tf.ultSecuencialGenerado,  
         --                horafinal=isnull( bb.horaFinal , tp.fechaultmodif),   
         --                'añoIngresoEtapa'= datepart(yyyy,bb.horaInicio),	 
         --                'mesIngresoEtapa'= datepart(month,bb.horaInicio), 
         --                'semanaIngresoEtapa'= datepart(ww,bb.horaInicio), 
         --                'duracionMinutos'= datediff (minute, tp.fechaingreso, tp.fechaultmodif), 
         --                'duracionDias'= datediff (day, tp.fechaingreso, tp.fechaultmodif),  
         --                'diaFinalizacion'= datepart(day, isnull( bb.horaFinal , tp.fechaultmodif)), 
         --                'semanaFinalizacion'= datepart(week, isnull( bb.horaFinal , tp.fechaultmodif)), 
         --                'mesFinalizacion'=datepart(month, isnull( bb.horaFinal , tp.fechaultmodif)), 
         --                'anioFinalizacion'=datepart(year, isnull( bb.horaFinal , tp.fechaultmodif)), 
         --                'ultima etapa'= isnull(tf.etapa, dbo.ultimaEtapaAprobada (tp.corrtramite, tp.estadoOperativo, 'S')), 
         --                c.montodeudaacumulada, 
         --                c.montocuotaacumulada 
         --    FROM        creditfactoryhis..tramiteprocesos tp  WITH (NOLOCK)  
         --    INNER JOIN creditfactoryhis..tramitesolicitud ts WITH (NOLOCK) ON (ts.corrtramite = tp.corrtramite)  
         --    INNER JOIN creditfactoryhis..solicitud s WITH (NOLOCK) ON (ts.corrsolicitud = s.correlativo)  
         --    INNER JOIN creditfactoryhis..cliente c WITH (NOLOCK) ON (s.corrclientesolicitante = c.correlativo)  
         --    LEFT JOIN creditfactoryhis..tramiteflujo tf WITH (NOLOCK) ON (tf.corrtramite = tp.corrtramite   
         --         AND (tp.estadoOperativo IN ('DV','RE','CN') AND (tp.estadoOperativo = tf.estatus OR tf.estatus = 'SP')  
         --         OR (tp.estadoOperativo IN ('EP') AND tp.estadoProceso IN ('SP', 'EP', 'ER') AND tf.estatus = tp.estadoProceso)))  
         --    LEFT JOIN creditfactoryhis..bitacoraetapas bb ON (bb.secuencialGenerado = tf.ultsecuencialgenerado  
         --         AND bb.corrtramite= tp.corrtramite  
         --         AND bb.etapa = tf.etapa)  
         --    WHERE tp.estramitesolicitud = 'S'  

         --               AND tp.origen = case WHEN @origen IS NULL THEN tp.origen ELSE @origen END
         --               AND tp.fechaIngreso >= case WHEN @fechaIni IS NULL THEN tp.fechaIngreso ELSE @fechaIni END
         --               AND tp.fechaIngreso < case WHEN @fechaFin IS NULL THEN tp.fechaIngreso ELSE @fechaFin END

         --               AND tp.estadoOperativo = case WHEN @estadoTramite = 'AP' OR @estadoTramite = 'RE' OR @estadoTramite = 'CN' OR @estadoTramite = 'DV' OR @estadoTramite = 'EP' OR @estadoTramite = 'PM' THEN  @estadoTramite ELSE tp.estadoOperativo END
         --               AND tp.estadoProceso = case WHEN @estadoTramite = 'ER' THEN  @estadoTramite ELSE tp.estadoProceso END

         --               AND tp.codigoflujo = case WHEN @flujo IS NOT NULL AND @flujo  <> '' THEN @flujo ELSE tp.codigoflujo END
         --               AND s.campaña = case WHEN @campaña IS NOT NULL AND @campaña  <> '' THEN @campaña ELSE s.campaña END

         ORDER BY tp.fechaingreso
end


GO
/****** Object:  StoredProcedure [dbo].[sp_eliminacion_tramites]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_eliminacion_tramites]
@i_corrtramite int = null
,@i_origen  varchar(10)
AS
declare @w_corrtramite int
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	declare cur_tramites_eliminacion cursor for
		select corrtramite from CreditFactoryhis..tramiteprocesos
		where origen = @i_origen
		and (corrtramite = @i_corrtramite or @i_corrtramite is null)
	
    open cur_tramites_eliminacion

	fetch cur_tramites_eliminacion into @w_corrtramite

	while (@@fetch_status = 0)
	begin
		--eliminando tablas independientes.
		--direccion
		--medios contacto
		--empresa
		--cliente

		fetch cur_tramites_eliminacion into @w_corrtramite
	end
		
	close cur_tramites_eliminacion
	deallocate cur_tramites_eliminacion
END



GO
/****** Object:  StoredProcedure [dbo].[sp_emisiones_excluidas]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_emisiones_excluidas]  
		 
@i_emision varchar(5) = null

--action
,@o_excluida char(1) = null output
as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int

begin
	  
select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
    
	if @i_emision in ('1', '10', '11', '12', '31', '80', '90')
        select @o_excluida = 'S'


return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end	

GO
/****** Object:  StoredProcedure [dbo].[sp_end_forking]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[sp_end_forking]
	@i_corrtramite int	
	,@o_estado_etapa varchar(5) = null out
AS
declare @w_estado_subtramite varchar(5)
BEGIN
	if not exists(select 1 from tramitepersonaindividual where corrsolicitud = @i_corrtramite)
	begin
		--raiserror 30000 'TRAMITE NO TIENE ASOCIADOS SUBTRAMITES'
		raiserror ('TRAMITE NO TIENE ASOCIADOS SUBTRAMITES',1,16)
		return 1
	end
	--verificar si todos los subtramites estan terminados.
	--si todos ya estan terminados, entonces verificar los que estan
	--rechazados, devueltos o cancelados. Estos definen el estado final del tramite.
	select top 1 @w_estado_subtramite = tp.estadoOperativo from tramiteprocesos tp
			inner join tramitepersonaindividual tpi on (tp.corrtramite = tpi.corrtramite
				and tpi.corrsolicitud = @i_corrtramite)
			where tp.estadoOperativo in ('CN','DV','RE')			

	if @w_estado_subtramite is not null
		select @o_estado_etapa = @w_estado_subtramite
	else
	begin	
		--Si no se haya ninguno y TODOS estan aprobados, entonces
		--aprobar etapa FORK y proseguir con la siguiente.
		if exists(select 1 from tramiteprocesos tp
			inner join tramitepersonaindividual tpi on (tp.corrtramite = tpi.corrtramite
				and tpi.corrsolicitud =@i_corrtramite )
			where tp.estadoOperativo not in ('AP'))
			select @o_estado_etapa = 'SP'
		else
			select @o_estado_etapa = 'AP'
	end
	if @o_estado_etapa is null
	begin
		--raiserror 30000 'ESTADO FINAL ETAPA FORK NO DEFINIDO'
		raiserror ('ESTADO FINAL ETAPA FORK NO DEFINIDO',1,16)
		return 1
	end
END



GO
/****** Object:  StoredProcedure [dbo].[sp_enmascaraTcBitacora]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_enmascaraTcBitacora]
as

begin

declare @bin varchar(10), @sql varchar(max), @i int
select bin, CAST(0 as int)procesado into #temp from binesTC


while (select COUNT(*) from #temp where procesado = 0) > 0
	begin
		
		select top 1 @bin = bin from #temp where procesado = 0
		update #temp set procesado = 1 where bin = @bin	
		set @i = 0
		
		while @i < 6
			begin
				set @sql =	'update	bitacoraetapas 
					set		observaciones = case
												when ISNUMERIC(SUBSTRING(observaciones, CHARINDEX(''' + @bin + ''', observaciones, 0)+4,8)) = 1 
												then substring(observaciones,0,CHARINDEX('''+@bin +''', observaciones, 0)+4) + ''' + '-XXXX-XXXX-' + ''' + RIGHT(cast(observaciones as varchar(max)), LEN(cast(observaciones as varchar(max)))-CHARINDEX('''+@bin+''', observaciones, 0)-11)
												else observaciones 
											end
					where	estado = ''' + 'RE' +'''
							and observaciones like ''%' + @bin + '%'''
				exec (@sql)
				set @i = @i+1
			end	
		update #temp set procesado = 2 where bin = @bin					
	end					
end



GO
/****** Object:  StoredProcedure [dbo].[sp_estado_crediticio]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_estado_crediticio]  
		 
@i_omitido	char(1) = 'N'
--moras30hace1mes > $1	
,@i_moras30hace1mes int = 0
--moras30hace2meses > $1	
,@i_moras30hace2meses int = 0
--moras30hace3meses  > $1	
,@i_moras30hace3meses int = 0
--moras30hace6meses > $1	
,@i_moras30hace6meses int = 0
--moras30hace12meses > $1	
,@i_moras30hace12meses int = 0
--moras30Historicas > $1	
,@i_moras30Historicas int = 0
--moras60hace3meses > $1	
,@i_moras60hace3meses int = 0
--moras60hace6meses > $1	
,@i_moras60hace6meses int = 0
--moras60hace12meses > $1	
,@i_moras60hace12meses int = 0
--moras60Historicas > $1	
,@i_moras60Historicas int = 0
--moras90hace3meses > $1	
,@i_moras90hace3meses int = 0
--moras90hace6meses > $1	
,@i_moras90hace6meses int = 0
--moras90hace12meses > $1	
,@i_moras90hace12meses int = 0
--moras90Historico > $1	
,@i_moras90Historico int = 0
--moras120hace6meses > $1	
,@i_moras120hace6meses int = 0
--moras150hace6meses > $1	
,@i_moras150hace6meses int = 0
--moras180hace6meses > $1	
,@i_moras180hace6meses int = 0
--moras120Historico > $1	
,@i_moras120Historico int = 0
--moras180Historico > $1	
,@i_moras180Historico int = 0
--eval(inTO.cumpleEstatus($param))
,@i_estatus varchar(20) = null
,@o_califica char(1) = 'S' output


as 
--variables reservadas
declare @w_error int
      , @w_error_msg varchar(200)
      , @w_trancount int
      , @w_tran_iniciada char(1)
      , @w_rowcount int
	  
begin

select @w_trancount = @@trancount
       ,@w_tran_iniciada = 'N'
       
if @w_trancount > 0
    select @w_tran_iniciada = 'S'
else
    select @w_tran_iniciada = 'N'
    
create table #temp (msg varchar(100))

if @i_moras30hace1mes > 0
begin
   insert #temp (msg) values ('MORAS 30 POR 1 MES')
   select @o_califica = 'N'
end

if @i_moras30hace2meses = 0
begin
   insert #temp (msg) values ('MORAS 30 POR 2 MESES')
   select @o_califica = 'N'
end   

if @i_moras30hace3meses > 0
begin
   insert #temp (msg) values ('MORAS 30 POR 3 MESES')
   select @o_califica = 'N'
end   
	
if @i_moras30hace6meses > 0
begin
   insert #temp (msg) values ('MORAS 30 POR 6 MESES')
   select @o_califica = 'N'
end
	
if @i_moras30hace12meses > 2
begin
   insert #temp (msg) values ('MORAS 30 POR 12 MESES')
   select @o_califica = 'N'
end

--if @i_moras30Historicas int = 0

if @i_moras60hace3meses > 0
begin
   insert #temp (msg) values ('MORAS 60 POR 3 MESES')
   select @o_califica = 'N'
end
	
if @i_moras60hace6meses > 0
begin
	insert #temp (msg) values ('MORAS 60 POR 6 MESES')
    select @o_califica = 'N'
end	
if @i_moras60hace12meses > 0
begin
	insert #temp (msg) values ('MORAS 60 POR 12 MESES')
    select @o_califica = 'N'
end	
--if @i_moras60Historicas int = 0

if @i_moras90hace3meses > 0
begin
   insert #temp (msg) values ('MORAS 90 POR 3 MESES')
   select @o_califica = 'N'
end

if @i_moras90hace6meses > 0
begin
   insert #temp (msg) values ('MORAS 90 POR 6 MESES')
   select @o_califica = 'N'
end

if @i_moras90hace12meses > 0
begin
   insert #temp (msg) values ('MORAS 90 POR 12 MESES')
   select @o_califica = 'N'
end

if @i_moras90Historico > 0
begin
   insert #temp (msg) values ('MORAS 90 HISTORICO')
   select @o_califica = 'N'
end

if @i_moras120hace6meses > 0
begin
   insert #temp (msg) values ('MORAS 120 POR 6 MESES')
   select @o_califica = 'N'
end

if @i_moras150hace6meses > 0
begin
   insert #temp (msg) values ('MORAS 150 POR 6 MESES')
   select @o_califica = 'N'
end

if @i_moras180hace6meses > 0
begin
   insert #temp (msg) values ('MORAS 180 POR 6 MESES')
   select @o_califica = 'N'
end

if @i_moras120Historico > 0
begin
   insert #temp (msg) values ('MORAS 120 HISTORICO')
   select @o_califica = 'N'
end

if @i_moras180Historico > 0
begin
   insert #temp (msg) values ('MORAS 180 HISTORICO')
   select @o_califica = 'N'
end

if @i_estatus = 'CUENTAS_COBRO_JUDICIAL' 
begin
   insert #temp (msg) values ('CUENTAS COBRO JUDICIAL')
   select @o_califica = 'N'
end		
if @i_estatus = 'CUENTA_INCOBRABLE' 	
begin
   insert #temp (msg) values ('CUENTA_INCOBRABLE')
   select @o_califica = 'N'
end		
	
if @i_estatus = 'EN_PROCESO_PRORROGA' 	
begin
   insert #temp (msg) values ('EN_PROCESO_PRORROGA')
   select @o_califica = 'N'
end		

if @i_estatus = 'CANCELADO_POR_RENOVACION' 	
begin
   insert #temp (msg) values ('CANCELADO_POR_RENOVACION')
   select @o_califica = 'N'
end		
	
if @i_estatus = 'CANCELADO_POR_INCOBRABLE'  	
begin
   insert #temp (msg) values ('CANCELADO_POR_INCOBRABLE')
   select @o_califica = 'N'
end		
	
if @i_estatus = 'CANCELADO_POR_EJECUCION_JUDICIAL' 	
begin
   insert #temp (msg) values ('CANCELADO_POR_EJECUCION_JUDICIAL')
   select @o_califica = 'N'
end		
	
if @i_estatus = 'SALDO_REESTRUCTURADO'	 
begin
   insert #temp (msg) values ('SALDO_REESTRUCTURADO')
   select @o_califica = 'N'
end		
	
if @i_estatus = 'CUENTA_SOBREGIRADA'	 	
begin
   insert #temp (msg) values ('CUENTA_SOBREGIRADA')
   select @o_califica = 'N'
end		
	
if @i_estatus = 'COBRO_ADMINISTRATIVO'	 	
begin
   insert #temp (msg) values ('COBRO_ADMINISTRATIVO')
   select @o_califica = 'N'
end		
	
if @i_estatus = 'CUENTA_CONGELADA'	 
begin
   insert #temp (msg) values ('CUENTA_CONGELADA')
   select @o_califica = 'N'
end		
	
if @i_estatus = 'CUENTA_EN_MORA'	 
begin
   insert #temp (msg) values ('CUENTA_EN_MORA')
   select @o_califica = 'N'
end		
	
if @i_estatus = 'CUENTA_RENEGOCIACION'	 
begin
   insert #temp (msg) values ('CUENTA_RENEGOCIACION')
   select @o_califica = 'N'
end			
	
if @i_estatus = 'RETENCION_DEL_BIEN'	 
begin
   insert #temp (msg) values ('RETENCION_DEL_BIEN')
   select @o_califica = 'N'
end		
   
return 0

error:

    
raiserror (@w_error_msg, 15, 1)
return -1
        
end	

GO
/****** Object:  StoredProcedure [dbo].[sp_postprocesamiento_multiplexor]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_postprocesamiento_multiplexor]
	 @i_corrtramite int
	,@i_etapa etapa
	,@i_estado estado
	,@i_ingresomanual char(1)
	,@i_tieneAdvertencias	char(1) = null
	,@i_ejecuciones	int = null
	,@i_aprobacionforzada	char(1) = null

	--datos relacionados con la bitacora.
	,@i_observaciones text = null
	,@i_notacorta text = null
	,@i_mensajeerror text = null
	,@i_usuario varchar(20) = null
	,@i_correlativomensaje int = null
	,@o_pasa_siguiente_etapa char(1) = 'N' output
	,@o_tramite_cerrado char(1) = 'N' output
	,@o_estado_proceso_tramite estado = null output
	,@o_estado_operativo_tramite estado = null output
AS
declare @w_error int
	,@w_rowcount int
	,@w_error_msg varchar(500)
	,@w_estado_etapa estado
	,@w_orden int
	,@w_secuencial int
	,@w_horafinal datetime
	,@w_retorno int
	,@w_raiserror_code int
	,@w_actualizar_etapa char(1)
	,@w_ejecuciones_anteriores int
	,@w_ejecuciones_maximas int
BEGIN
	select @w_raiserror_code = 18
		  ,@w_actualizar_etapa = 'S'

	select @w_estado_etapa = estatus
		  ,@w_orden = orden
		  ,@w_secuencial = ultSecuencialGenerado
		  ,@w_ejecuciones_anteriores = ejecuciones
	from tramiteflujo
	where corrtramite = @i_corrtramite
	and etapa = @i_etapa

	if @@rowcount = 0
	begin
		raiserror ('NO SE ENCONTRO ETAPA [%s] TRAMITE [%d]',@w_raiserror_code,16, @i_etapa, @i_corrtramite)
		return 1
	end

	select @o_estado_proceso_tramite = estadoproceso
	from tramiteprocesos
	where corrtramite = @i_corrtramite

	if @o_estado_proceso_tramite is null
	begin
		raiserror ('NO SE ENCONTRO TRAMITE [%1]',@w_raiserror_code,16, @i_corrtramite)
		return 1		
	end

	if @o_estado_proceso_tramite not in ('EP','SP', 'TE')
	begin
		raiserror ('ESTADO NO VALIDO PARA TRAMITE [%d] [%s]', @i_corrtramite, @o_estado_proceso_tramite)
		return 1
	end
	--verificar si tiene etapas pendientes de procesamiento.
	if (@i_estado = 'AP')
	begin
		--si el tramite no esta terminado,
		--verificar etapas en paralelo.
		if  @o_estado_proceso_tramite <> 'TE'
		begin
			--verificar si hay 
			--etapas suspendidas
			if (exists(select 1 from tramiteflujo 
				where corrtramite = @i_corrtramite
				and estatus = 'ER'
				and etapa <> @i_etapa))
				select @o_estado_proceso_tramite = 'ER'
					  ,@o_estado_operativo_tramite = 'EP'
					  ,@o_pasa_siguiente_etapa = 'N'
			else
				if (exists(select 1 from tramiteflujo 
					where corrtramite = @i_corrtramite
					and estatus = 'SP'
					and etapa <> @i_etapa))
						select @o_estado_proceso_tramite = 'SP'
							,@o_estado_operativo_tramite = 'EP'
							,@o_pasa_siguiente_etapa = 'N'
				else
					select @o_estado_proceso_tramite = 'EP'
							,@o_estado_operativo_tramite = 'EP'
							,@o_pasa_siguiente_etapa = 'S'

		end
		else
			select @o_pasa_siguiente_etapa = 'N'
	end
	
	if @i_estado in ('DV','CN','RE')
		select @o_estado_proceso_tramite = 'TE'
		  	  ,@o_estado_operativo_tramite = @i_estado
			  ,@o_pasa_siguiente_etapa = 'N'

	if @i_estado = 'ER'
		select @o_estado_proceso_tramite = 'ER'
		  	  ,@o_estado_operativo_tramite = 'EP'
			  ,@o_pasa_siguiente_etapa = 'N'	

	if @i_estado = 'SP'
	begin
		select @o_estado_proceso_tramite = 'SP'
		  	  ,@o_estado_operativo_tramite = 'EP'
			  ,@o_pasa_siguiente_etapa = 'N'	
		
		--verificar si hay mas etapas pendientes con ese mismo numero de orden.
		if exists(select 1 from tramiteflujo where corrtramite = @i_corrtramite
					and orden = @w_orden
					and estatus = 'PE'
					and etapa not in (@i_etapa))		
			select @o_estado_proceso_tramite = 'EP'
		  		,@o_estado_operativo_tramite = 'EP'
				,@o_pasa_siguiente_etapa = 'S'		
		else	
			select @o_estado_proceso_tramite = 'SP'
		  		,@o_estado_operativo_tramite = 'EP'
				,@o_pasa_siguiente_etapa = 'N'			
	end

	if @i_estado = 'RP'
	begin
		exec @w_retorno = sp_repetir_etapa
			 @i_corrtramite		= @i_corrtramite
			,@i_etapa			= @i_etapa
			,@i_secuencial		= @w_secuencial

		if @@error <> 0 or @w_retorno <> 0
		begin
			raiserror ('ERROR AL REPETIR ETAPA [%s] [%d]',@w_raiserror_code,1,@i_etapa, @@error)
			return 1
		end
		select @o_estado_proceso_tramite = 'EP'
		  	,@o_estado_operativo_tramite = 'EP'
			,@o_pasa_siguiente_etapa = 'S'	
	end
	else
	begin
		if @w_actualizar_etapa = 'S'
		begin
			select @w_horafinal = getdate()
			exec @w_retorno = sp_actualizacion_tramiteflujo
				 @i_corrTramite				= @i_corrtramite
				,@i_ultSecuencialGenerado	= @w_secuencial
				,@i_etapa	                = @i_etapa
				,@i_estado					= @i_estado
				,@i_ingresomanual			= @i_ingresomanual
				,@i_tieneAdvertencias		= @i_tieneAdvertencias
				,@i_ejecuciones				= @i_ejecuciones
				,@i_aprobacionforzada		= @i_aprobacionforzada			
				,@i_horafinal				= @w_horafinal
				,@i_observaciones			= @i_observaciones
				,@i_notacorta				= @i_notacorta
				,@i_mensajeerror			= @i_mensajeerror
				,@i_usuario					= @i_usuario
				,@i_correlativomensaje		= @i_correlativomensaje
				,@i_actualizarbitacora		= 'S'
			if @@error <> 0 or @w_retorno <> 0
			begin
				raiserror ('ERROR AL ACTUALIZAR ETAPA [%s] [%d]',@w_raiserror_code,1,@i_etapa, @@error)
				return 1			
			end
		end
	end
	--print 'PASA SIGUIENTE ETAPA :' + @o_pasa_siguiente_etapa


	--cerrar el tramite si ya no hay mas etapas por procesar.

	update tramiteprocesos
	set estadoOperativo = @o_estado_operativo_tramite
		,estadoProceso = @o_estado_proceso_tramite
		,fechaultmodif = getdate()
	where corrtramite = @i_corrtramite

	if @@error <> 0 
	begin
		raiserror ('ERROR AL ACTUALIZAR TRAMITEPROCESOS [%d]',@w_raiserror_code,1, @@error)
		return 1
	end

	if @o_estado_operativo_tramite in ('DV','RE','CN')
		select @o_tramite_cerrado = 'S'
	else
		select @o_tramite_cerrado = 'N'
END



GO
/****** Object:  StoredProcedure [dbo].[sp_preprocesamiento_multiplexor]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_preprocesamiento_multiplexor]
	@i_corrtramite int    
   ,@i_secuencial_generado int
   ,@o_etapa etapa = null output
   ,@o_estado_etapa estado = null output
   ,@o_tramite_cerrado char(1) = null output
AS
declare  @w_error_msg varchar(500)
		,@w_error int
		,@w_rowcount int
		,@w_estado_proceso estado
		,@w_etapa_anterior etapa
		,@w_estado_etapa_anterior estado
		,@w_retorno int
BEGIN
	select @w_estado_proceso = estadoproceso
	from tramiteprocesos
	where corrtramite = @i_corrtramite

	if @w_estado_proceso is null
	begin
		select @w_error_msg = 'TRAMITE NO ENCONTRADO'
		goto error
	end

	if @w_estado_proceso not in ('EP','ER', 'SP')
	begin
		select @w_error_msg = 'TRAMITE NO ESTA EN ESTADO VALIDO [EP ER SP]'
		goto error
	end


	if @w_estado_proceso in ( 'ER','SP')
		exec sp_consulta_etapa_a_procesar
			 @i_corrtramite		= @i_corrtramite
			,@i_etapa_siguiente = 'N'
			,@i_inmediata_anterior = 'N'
			,@o_etapa			= @o_etapa output
			,@o_estado			= @o_estado_etapa output
	else
		exec sp_consulta_etapa_a_procesar
			 @i_corrtramite		= @i_corrtramite
			,@i_etapa_siguiente = 'S'
			,@i_inmediata_anterior = 'N'
			,@o_etapa			= @o_etapa output
			,@o_estado			= @o_estado_etapa output

	--if (etapaActual != null) {					
	if (@o_etapa is not null)
	begin	
		--verificar que la etapa inmediata anterior este terminada.
		--si la etapa esta todavia en proceso o suspendida,
		--generar un error. No debe ser una etapa PARALELA.
		--EtapaTO etapaAnterior = tramiteProceso.getTramiteFlujo().etapaInmediataAnterior(etapaActual);			
		
		exec sp_consulta_etapa_a_procesar
			@i_corrtramite		= @i_corrtramite
		   ,@i_inmediata_anterior = 'S'
		   ,@o_etapa			= @w_etapa_anterior output
		   ,@o_estado			= @w_estado_etapa_anterior output

		if @@error <> 0	
		begin
			select @w_error_msg = 'ERROR AL CONSULTAR ETAPA INMEDIATA ANTERIOR'
			goto error
		end

		--if (etapaAnterior != null && !etapaAnterior.getEstado().equals(EstadosEtapaTramite.APROBADO)){		
		if @w_etapa_anterior is not null and @w_estado_etapa_anterior <> 'AP'		
		begin
			--	throw new Exception("ETAPA ANTERIOR [" + etapaAnterior + "] NO HA SIDO APROBADA [" + etapaAnterior.getEstado() + "]");
			select @w_error_msg = 'ETAPA ANTERIOR [' + @w_etapa_anterior + '] NO HA SIDO APROBADA [' + @w_estado_etapa_anterior + ']'
			goto error			
		end		
		select  @o_tramite_cerrado = 'N'

		--abrir etapa tramite.
		exec @w_retorno = sp_abrir_etapa_tramite
			 @i_corrtramite			= @i_corrtramite
			,@i_secuencial_generado = @i_secuencial_generado
			,@i_etapa				= @o_etapa

		if @@error <> 0 or @w_retorno <> 0
		begin
			select @w_error_msg = 'ERROR AL ABRIR ETAPA TRAMITE'
			goto error
		end

		select @o_tramite_cerrado = 'N'
	end
	else
	begin
		--cerrar tramite.
		--antes de cerrar un tramite, verificar que no tenga etapas que NO esten aprobadas.
		if exists(select 1 from tramiteflujo 
			where corrtramite = @i_corrtramite
			and estatus not in ('AP','EL'))
		begin
			select @w_error_msg = 'TRAMITE NO TIENE TODAS LAS ETAPAS APROBADAS'
			goto error
		end

		update tramiteprocesos
		set estadoOperativo = 'AP'
		   ,estadoproceso = 'TE'
		where corrtramite = @i_corrtramite

		if @@error <> 0
		begin
			select @w_error_msg = 'ERROR AL ACTUALIZAR TRAMITE'
			goto error
		end
	
		select @o_tramite_cerrado = 'S'
	end	

	return 0
error:
	--raiserror 30000 @w_error_msg
	raiserror (@w_error_msg,1,16)
	return 1
END



GO
/****** Object:  StoredProcedure [dbo].[sp_repetir_etapa]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[sp_repetir_etapa]
	@i_corrtramite int
	,@i_etapa_que_origina etapa = null
	,@i_etapa etapa
	,@i_secuencial int
AS
declare @w_error int
, @w_rowcount int
, @w_estado_etapa etapa
, @w_observaciones varchar(300)
BEGIN
	select @w_estado_etapa = estatus
	from tramiteflujo
	where corrtramite = @i_corrtramite
	and etapa = @i_etapa
	
	if @@rowcount = 0
	begin
		raiserror ('ETAPA [%1] NO ENCONTRADA PARA TRAMITE [%2]',1,1, @i_etapa, @i_corrtramite)
		return 1
	end	

	if @i_etapa_que_origina is not null
		if @w_estado_etapa <> 'AP'
		begin
			raiserror ('ETAPA [%1] NO SE ENCUENTRA APROBADA [%2]',1,1, @i_etapa, @w_estado_etapa)
			return 1			
		end

	--insertar en bitacora que la etapa se mando a repetir.
	if @i_etapa_que_origina is not null
		select @w_observaciones = 'ETAPA [' + @i_etapa + '] SE MANDA A REPETIR DESDE ETAPA [' 
			+ @i_etapa_que_origina + '] TRAMITE [' + convert(varchar, @i_corrtramite) + ']'
	else
		select @w_observaciones = 'ETAPA REPETIDA'
		
	insert into bitacoraetapas (
		corrTramite
		,estado
		,etapa
		,observaciones
		,fecha
		,secuencialGenerado)
	values (
		 @i_corrtramite
		,'PE'
		,@i_etapa
		,@w_observaciones
		,getdate()
		,@i_secuencial
	)
	if @@error <> 0
	begin
		raiserror ('ERROR AL INSERTAR EN BITACORA [%1]',1,1, @@error)
		return 1
	end

	exec sp_actualizacion_tramiteflujo 
		@i_corrTramite	 = @i_corrtramite
		,@i_ultSecuencialGenerado	= 0
		,@i_etapa	 = @i_etapa	
		,@i_estado	 = 'PE'
		,@i_ejecuciones = 0
	if @@error <> 0
	begin
		raiserror ('ERROR AL ACTUALIZAR ETAPA [%1] TRAMITE [%2]',1,1, @i_etapa, @i_corrtramite)
		return 1
	end
END



GO
/****** Object:  StoredProcedure [dbo].[sp_reporte_diario_invt_sipsa]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_reporte_diario_invt_sipsa]
AS
  begin
    declare  @fechaConsulta datetime,
             @fechaConsultaStr varchar(12) ,
             @origen varchar(10),
             @etapa varchar(8)

    set @fechaConsulta    = (getDate() - 1)--N'2012-11-07'
    set @fechaConsultaStr = convert(varchar, @fechaConsulta, 112)
    set @origen           = 'SIPSA'
    set @etapa            = 'VDOCS'

    (select 
        a.usuario Usuario, a.corrTramite CorrTramite, e.nombre_agencia Agencia, a.estado Estado, 
        a.horaInicio FechaIni, a.horaInicio HoraIni, a.horaFinal FechaFinal
     from 
        TramiteProcesos     b with (nolock) inner join 
        BitacoraEtapas      a with (nolock) on (a.corrTramite = b.corrTramite) left join 
        operacion..agencias e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
     where 
        a.etapa   = @etapa   and 
        b.origen  = @origen  and 
        a.estado != 'SP'     and 
        convert(varchar, a.horaFinal, 112) = @fechaConsultaStr )
    union
    (select 
        d.usuario Usuario, c.corrTramite CorrTramite, e.nombre_agencia Agencia, 'PC' Estado, 
        c.fechaIngreso FechaIni, c.fechaIngreso HoraIni, d.fecha FechaFinal
     from 
        TramiteProcesos      b with (nolock) inner join 
        CuestionarioTramite  c with (nolock) on (b.corrTramite = c.corrTramite) inner join 
        BitacoraCuestionario d with (nolock) on (c.correlativo = d.corrcuestionario) left join 
        operacion..agencias  e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
     where 
        b.origen = @origen and 
        c.etapa  = @etapa  and 
        d.resultadoaprobaciontotal = 'PC' and 
        convert(varchar, d.fecha, 112) = @fechaConsultaStr) 
    order by Usuario, HoraFinal
  end



GO
/****** Object:  StoredProcedure [dbo].[sp_reporteEtapasSipsa]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_reporteEtapasSipsa]

(
@año	int,
@mes	int,
@etapa	varchar(20)
)

as
BEGIN
	
	DECLARE @usuario VARCHAR(200), 
			@corrTramite INT, 
			@nombre_agencia VARCHAR(300), 
			@estado VARCHAR(3), 
			@fechaIngreso DATETIME,
			@horaInicio DATETIME, 
			@horaFinal DATETIME,
			@observ1 VARCHAR(MAX),
			@observ2 VARCHAR(MAX),
			@mensajeRespuesta VARCHAR(MAX),
			@corrCuestionario INT ,
			@respuesta1 VARCHAR(MAX),
			@respuesta2 VARCHAR(MAX)




	IF  NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[#MyTempTable]'))
	begin
	CREATE TABLE #MyTempTable (
			usuario VARCHAR(200), 
			corrTramite INT, 
			nombre_agencia VARCHAR(300), 
			estado VARCHAR(3), 
			fechaIngreso DATETIME, 
			horaInicio DATETIME, 
			horaFinal DATETIME,
			observ1 VARCHAR(MAX),
			observ2 VARCHAR(MAX),
			corrCuestionario INT
	);
	end


	  DECLARE @xml xml

	--INSERT INTO #MyTempTable VALUES (1);

if @etapa = 'VDOCS'
BEGIN

	DECLARE db_cursor CURSOR FOR  
	  (select distinct

			a.usuario Usuario, a.corrTramite CorrTramite, e.nombre_agencia Agencia, a.estado Estado, 
			a.horaInicio FechaIni, a.horaInicio HoraIni, a.horaFinal FechaFinal, 0
		 from 
			TramiteProcesos     b with (nolock) inner join 
			BitacoraEtapas      a with (nolock) on (a.corrTramite = b.corrTramite) left join 
			operacion..agencias e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
		 where 
			a.etapa   = 'VDOCS'   and 
			b.origen  = 'SIPSA'  and 
			a.estado != 'SP'     and 
			year(a.horaFinal) = @año and
			month(a.horaFinal) = @mes		
		union 
		select  distinct
			d.usuario Usuario, c.corrTramite CorrTramite, e.nombre_agencia Agencia, 'PC' Estado, 
			c.fechaIngreso FechaIni, c.fechaIngreso HoraIni, d.fecha FechaFinal, c.correlativo
		 from 
			TramiteProcesos      b with (nolock) inner join 
			CuestionarioTramite  c with (nolock) on (b.corrTramite = c.corrTramite) inner join 
			BitacoraCuestionario d with (nolock) on (c.correlativo = d.corrcuestionario) left join 
			operacion..agencias  e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
			left join CuestionarioTramitePreguntas  p with(nolock) on p.corrCuestionario = c.correlativo
			left join CuestionarioTramiteRespuestas r with(nolock) on r.corrPregunta = p.correlativo
		 where 
		   -- r.seleccionada in ('S','N') and
			b.origen = 'SIPSA' and         
			c.etapa  = 'VDOCS' and 
			d.resultadoaprobaciontotal = 'PC' and 
			year(d.fecha) = @año and
			month(d.fecha) = @mes
	)


	--2955994
	OPEN db_cursor  
	FETCH NEXT FROM db_cursor INTO  @usuario, @corrTramite, @nombre_agencia, @estado, @fechaIngreso, @horaInicio, @horaFinal, @corrCuestionario

	WHILE @@FETCH_STATUS = 0  
	BEGIN  


		 -- print 'Dato: ' + convert(varchar, @corrTramite)
		   select @respuesta1 = ''
		   select @respuesta2 = ''  

		   select top 1  @mensajeRespuesta = formularioTO 
				 from    BitacoraCuestionario with(nolock)
				where    corrCuestionario = (
									select top 1 correlativo 
									  from CuestionarioTramite 
									 where corrTramite = @corrTramite
									   and etapa = 'VDOCS'
								  order by correlativo desc
				)
				--@corrCuestionario--2210408-- @corrCuestionario


			  --  print @mensajeRespuesta
		  select @xml = convert(XML, @mensajeRespuesta)
		  --select @xml
	 

		 select @respuesta1 =  Feld.N.value('(respuestaAbierta/text())[1]','varchar(max)')
		   from @xml.nodes('/com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioTramiteTO/cuestionarios/com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioPersonaTO/preguntas') as Felder(N)  cross apply Felder.N.nodes('com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioPreguntaTO') as Feld(N)
		  where Feld.N.value('(textoPregunta/text())[1]','varchar(max)')  = 'OBSERVACIONES' 
	      

		 select @respuesta2 =  Feld.N.value('(respuestaAbierta/text())[1]','varchar(max)')
		   from @xml.nodes('/com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioTramiteTO/cuestionarios/com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioPersonaTO/preguntas') as Felder(N)  cross apply Felder.N.nodes('com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioPreguntaTO') as Feld(N)
		  where Feld.N.value('(textoPregunta/text())[1]','varchar(max)')  = 'OBSERVACIONES 2'

	--print 'temp: ' + isnull(@respuesta1, 'NULL')
	--print 'temp: ' + isnull(@respuesta2, 'NULL')
	--INSERT INTO #MyTempTable VALUES (@corrTramite,@etapa,@fecha,@nomora,@mora30_1mes,@mora60_3mes,@mora90_3mes,@mora120_3mes,@mora120_6mes,@estado);

		INSERT INTO #MyTempTable 
				(usuario,  corrTramite , nombre_agencia , estado ,  fechaIngreso , horaInicio, horaFinal, observ1,  observ2, corrCuestionario)
		VALUES (@usuario, @corrTramite, @nombre_agencia, @estado, @fechaIngreso, @horaInicio, @horaFinal, @respuesta1,@respuesta2, @corrCuestionario);

		   FETCH NEXT FROM db_cursor INTO @usuario, @corrTramite, @nombre_agencia, @estado, @fechaIngreso, @horaInicio, @horaFinal, @corrCuestionario
	END  

	CLOSE db_cursor  
	DEALLOCATE db_cursor 
END --IF ETAPA


if @etapa = 'INVT'
BEGIN

	DECLARE db_cursor CURSOR FOR  
	  (select distinct
			a.usuario Usuario, a.corrTramite CorrTramite, e.nombre_agencia Agencia, a.estado Estado, 
			a.horaInicio FechaIni, a.horaInicio HoraIni, a.horaFinal FechaFinal, 0
		 from 
			TramiteProcesos     b with (nolock) inner join 
			BitacoraEtapas      a with (nolock) on (a.corrTramite = b.corrTramite) left join 
			operacion..agencias e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
		 where 
			a.etapa   = 'INVT'   and 
			b.origen  = 'SIPSA'  and 
			a.estado != 'SP'     and 
			year(a.horaFinal) = @año and
			month(a.horaFinal) = @mes		
		union 
		select distinct
			d.usuario Usuario, c.corrTramite CorrTramite, e.nombre_agencia Agencia, 'PC' Estado, 
			c.fechaIngreso FechaIni, c.fechaIngreso HoraIni, d.fecha FechaFinal, c.correlativo
		 from 
			TramiteProcesos      b with (nolock) inner join 
			CuestionarioTramite  c with (nolock) on (b.corrTramite = c.corrTramite) inner join 
			BitacoraCuestionario d with (nolock) on (c.correlativo = d.corrcuestionario) left join 
			operacion..agencias  e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
			left join CuestionarioTramitePreguntas  p with(nolock) on p.corrCuestionario = c.correlativo
			left join CuestionarioTramiteRespuestas r with(nolock) on r.corrPregunta = p.correlativo
		 where 
		   -- r.seleccionada in ('S','N') and
			b.origen = 'SIPSA' and         
			c.etapa  = 'INVT' and 
			d.resultadoaprobaciontotal = 'PC' and 
			year(d.fecha) = @año and
			month(d.fecha) = @mes
	)


	--2955994
	OPEN db_cursor  
	FETCH NEXT FROM db_cursor INTO  @usuario, @corrTramite, @nombre_agencia, @estado, @fechaIngreso, @horaInicio, @horaFinal, @corrCuestionario

	WHILE @@FETCH_STATUS = 0  
	BEGIN  


		 -- print 'Dato: ' + convert(varchar, @corrTramite)
		   select @respuesta1 = ''
		   select @respuesta2 = ''  

		   select top 1  @mensajeRespuesta = formularioTO 
				 from    BitacoraCuestionario with(nolock)
				where    corrCuestionario = (
									select top 1 correlativo 
									  from CuestionarioTramite 
									 where corrTramite = @corrTramite
									   and etapa = 'INVT'
								  order by correlativo desc
				)
				--@corrCuestionario--2210408-- @corrCuestionario


			  --  print @mensajeRespuesta
		  select @xml = convert(XML, @mensajeRespuesta)
		  --select @xml
	 

		 select @respuesta1 =  Feld.N.value('(respuestaAbierta/text())[1]','varchar(max)')
		   from @xml.nodes('/com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioTramiteTO/cuestionarios/com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioPersonaTO/preguntas') as Felder(N)  cross apply Felder.N.nodes('com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioPreguntaTO') as Feld(N)
		  where Feld.N.value('(textoPregunta/text())[1]','varchar(max)')  = 'OBSERVACIONES' 
	      

		 select @respuesta2 =  Feld.N.value('(respuestaAbierta/text())[1]','varchar(max)')
		   from @xml.nodes('/com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioTramiteTO/cuestionarios/com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioPersonaTO/preguntas') as Felder(N)  cross apply Felder.N.nodes('com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioPreguntaTO') as Feld(N)
		  where Feld.N.value('(textoPregunta/text())[1]','varchar(max)')  = 'OBSERVACIONES 2'

	--print 'temp: ' + isnull(@respuesta1, 'NULL')
	--print 'temp: ' + isnull(@respuesta2, 'NULL')
	--INSERT INTO #MyTempTable VALUES (@corrTramite,@etapa,@fecha,@nomora,@mora30_1mes,@mora60_3mes,@mora90_3mes,@mora120_3mes,@mora120_6mes,@estado);

		INSERT INTO #MyTempTable 
				(usuario,  corrTramite , nombre_agencia , estado ,  fechaIngreso , horaInicio, horaFinal, observ1,  observ2, corrCuestionario)
		VALUES (@usuario, @corrTramite, @nombre_agencia, @estado, @fechaIngreso, @horaInicio, @horaFinal, @respuesta1,@respuesta2, @corrCuestionario);

		   FETCH NEXT FROM db_cursor INTO @usuario, @corrTramite, @nombre_agencia, @estado, @fechaIngreso, @horaInicio, @horaFinal, @corrCuestionario
	END  

	CLOSE db_cursor  
	DEALLOCATE db_cursor 
END



	select * from #MyTempTable order by usuario desc

	truncate  table #MyTempTable


	drop  table #MyTempTable

END


GO
/****** Object:  StoredProcedure [dbo].[sp_sabana_datos_formularios_pendientes]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--
-- sp_sabana_datos_formularios_pendientes.sql
--
CREATE PROCEDURE [dbo].[sp_sabana_datos_formularios_pendientes]
(
    @origen          varchar(20)--, @prueba varchar(20)
)
as
begin
     SELECT  TOP 5000
             ct.corrtramite, 
             ct.etapa,  
             tp.categoriaProducto,
             tp.promocion,
             tp.campania,
             ct.resultadoAprobaciontotal, 
             ct.observacionResultadoAprobacionTotal, 
             s.codigoVendedor, 
             s.oficina, 
--             'nombre_agencia'=(select ag.nombre_agencia from operacion..agencias ag where tp.origen = 'SIPSA' and ag.cod_agencia *= s.oficina and ag.cod_empresa= 1 
--                 union select ca.descripcion from ptc..ca_oficina ca where tp.origen = 'PTC' and ca.codigo *= s.oficina) , 
             'nombre_agencia'=(select ag.nombre_agencia from operacion..agencias ag where tp.origen = 'SIPSA' and ag.cod_agencia = s.oficina and ag.cod_empresa= 1 
                 union select ca.descripcion from ptc..ca_oficina ca where tp.origen = 'PTC' and ca.codigo = s.oficina) , 
            tp.usuario, 
             ct.url, 
             tp.origen, 
             'fechaCreacionFormulario'=ct.fechaIngreso, 
             'ultima Fecha Modificacion formulario'=ct.fechaUltModificacion, 
             'fecha ingreso tramite'= ts.fechaIngreso 
     FROM    cuestionariotramite ct with (NOLOCK), 
             tramitesolicitud ts  with (NOLOCK), 
             tramiteprocesos tp  with (NOLOCK), 
             solicitud s  with (NOLOCK) 
     WHERE   ct.resultadoAprobacionTotal in ('PC','PE') 
             AND ct.corrtramite = ts.corrtramite 
             AND tp.corrtramite = ts.corrtramite 
             AND tp.estadoProceso = 'SP' 
             AND tp.estadoOperativo = 'EP' 
			 AND ts.corrsolicitud = s.correlativo 
             AND tp.origen = case when @origen is null then tp.origen else @origen End
     ORDER BY ts.fechaIngreso
end




GO
/****** Object:  StoredProcedure [dbo].[sp_sabana_datos_tramite_persona]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- sp_sabana_datos_tramite_persona.sql
--
CREATE PROCEDURE [dbo].[sp_sabana_datos_tramite_persona]
(
    @origen            varchar(20),
    @fechaIni          datetime,
    @fechaFin          datetime,
    @estadoTramite     char(2),
    @flujo             varchar(10)
)
as
begin


      SELECT  tp.corrtramite,
              tpi.idTramite,
              tpi.secuencialBanru,
              tp.estadoOperativo,
              tp.estadoProceso,   
              tp.producto,   
              tp.origen,   
              tp.campania,
              tp.promocion,
              tp.fechaIngreso,  
              tp.fechaultmodif,    
              c.primerNombre, 
              c.segundoNombre,  
              c.primerApellido, 
              c.segundoApellido,   
              c.apellidoCasada,  
              c.numdocid,   
              c.nit,   
              c.cui, 
              tp.codigoFlujo, 
              tpi.oficina,  
              tp.usuario,  
              enHistorico='N', 
              'descripcionAgencia'= dbo.descripcionOficina(tpi.oficina, tp.origen), 
              'categoriaRechazo'=dbo.categoriasRechazo(tp.corrtramite, 'N'),
              tf.etapa,
              tf.estatus, 
              tp.campania ultSecuencialGenerado,--tf.ultSecuencialGenerado, Ajuste por caso 8092  
              'horafinal'=isnull( bb.horaFinal , tp.fechaultmodif),   
              'añoIngresoEtapa'= datepart(yyyy,bb.horaInicio),	 
              'mesIngresoEtapa'= datepart(month,bb.horaInicio), 
              'semanaIngresoEtapa'= datepart(ww,bb.horaInicio), 
              'observaciones'=convert(varchar(8000),bb.observaciones), 
              'duracionMinutos'=datediff (minute, tp.fechaingreso, tp.fechaultmodif),
              'duracionDias'=datediff (day, tp.fechaingreso, tp.fechaultmodif),
              'diaFinalizacion'= datepart(day, isnull( bb.horaFinal , tp.fechaultmodif)), 
              'semanaFinalizacion'= datepart(week, isnull( bb.horaFinal , tp.fechaultmodif)), 
              'mesFinalizacion'=datepart(month, isnull( bb.horaFinal , tp.fechaultmodif)), 
              'anioFinalizacion'=datepart(year, isnull( bb.horaFinal , tp.fechaultmodif)), 
              'ultima etapa'= isnull(tf.etapa, dbo.ultimaEtapaAprobada (tp.corrtramite, tp.estadoOperativo, 'N')), 
              tp.corrPreautorizacion
     FROM     tramiteprocesos tp WITH (NOLOCK)
     INNER JOIN     tramitepersonaindividual tpi WITH (NOLOCK) ON (tpi.corrtramite = tp.corrtramite )
     INNER JOIN     cliente c WITH (NOLOCK) ON (tpi.corrcliente = c.correlativo)
     LEFT JOIN      tramiteflujo tf WITH(NOLOCK) ON (tf.corrtramite = tp.corrtramite
                    AND (tp.estadoOperativo IN ('DV','RE','CN') AND (tp.estadoOperativo = tf.estatus OR tf.estatus = 'SP')
                    OR (tp.estadoOperativo IN ('EP') AND tp.estadoProceso IN ('SP', 'EP', 'ER') AND tf.estatus = tp.estadoProceso)))
     LEFT JOIN      bitacoraetapas bb ON (bb.secuencialGenerado = tf.ultsecuencialgenerado  
                    AND bb.corrtramite= tp.corrtramite  
                    AND bb.etapa = tf.etapa)  
     WHERE      tp.estramitepersona = 'S'
				AND tp.origen = case WHEN @origen IS NULL THEN tp.origen ELSE @origen END
                AND tp.fechaIngreso >= case WHEN @fechaIni IS NULL THEN tp.fechaIngreso ELSE @fechaIni END
                AND tp.fechaIngreso < case WHEN @fechaFin IS NULL THEN tp.fechaIngreso ELSE @fechaFin END
                AND tp.estadoOperativo = case WHEN @estadoTramite = 'AP' OR @estadoTramite = 'RE' OR @estadoTramite = 'CN' OR @estadoTramite = 'DV' OR @estadoTramite = 'EP' OR @estadoTramite = 'PM' THEN  @estadoTramite ELSE tp.estadoOperativo END
                AND tp.estadoProceso = case WHEN @estadoTramite = 'ER' THEN  @estadoTramite ELSE tp.estadoProceso END
                AND tp.codigoflujo = case WHEN @flujo IS NOT NULL AND @flujo  != '' THEN @flujo ELSE tp.codigoflujo END



     --UNION 
     --    SELECT   tp.corrtramite,
     --             tpi.idTramite,
     --             tpi.secuencialBanru,
     --             tp.estadoOperativo,    
     --             tp.estadoProceso,   
     --             tp.producto,   
     --             tp.origen, 
     --             tp.campania,  
     --             tp.promocion,
     --             tp.fechaIngreso,  
     --             tp.fechaultmodif,    
     --             c.primerNombre, 
     --             c.segundoNombre,  
     --             c.primerApellido, 
     --             c.segundoApellido,   
     --             c.apellidoCasada,  
     --             c.numdocid,   
     --             c.nit,   
     --             c.cui, 
     --             tp.codigoFlujo, 
     --             tpi.oficina,  
     --             tp.usuario,  
     --             enHistorico='S', 
     --             'descripcionAgencia'= dbo.descripcionOficina(tpi.oficina, tp.origen), 
     --             'categoriaRechazo'=dbo.categoriasRechazo(tp.corrtramite, 'S'),
     --             tf.etapa,
     --             tf.estatus, 
     --             tf.ultSecuencialGenerado, 
     --             'horafinal'=isnull( bb.horaFinal , tp.fechaultmodif),   
     --             'añoIngresoEtapa'= datepart(yyyy,bb.horaInicio),	 
     --             'mesIngresoEtapa'= datepart(month,bb.horaInicio), 
     --             'semanaIngresoEtapa'= datepart(ww,bb.horaInicio), 
     --             'observaciones'=convert(varchar(8000),bb.observaciones), 
     --             'duracionMinutos'=datediff (minute, tp.fechaingreso, tp.fechaultmodif),
     --             'duracionDias'=datediff (day, tp.fechaingreso, tp.fechaultmodif),
     --             'diaFinalizacion'= datepart(day, isnull( bb.horaFinal , tp.fechaultmodif)), 
     --             'semanaFinalizacion'= datepart(week, isnull( bb.horaFinal , tp.fechaultmodif)), 
     --             'mesFinalizacion'=datepart(month, isnull( bb.horaFinal , tp.fechaultmodif)), 
     --             'anioFinalizacion'=datepart(year, isnull( bb.horaFinal , tp.fechaultmodif)), 
     --             'ultima etapa'= isnull(tf.etapa, dbo.ultimaEtapaAprobada (tp.corrtramite, tp.estadoOperativo, 'S')), 
     --             tp.corrPreautorizacion

     --    FROM creditfactoryhis..tramiteprocesos tp WITH (NOLOCK)
     --    INNER JOIN creditfactoryhis..tramitepersonaindividual tpi WITH (NOLOCK) ON (tpi.corrtramite = tp.corrtramite )
     --    INNER JOIN creditfactoryhis..cliente c WITH (NOLOCK) ON (tpi.corrcliente = c.correlativo)
     --    LEFT JOIN  creditfactoryhis..tramiteflujo tf WITH (NOLOCK) ON (tf.corrtramite = tp.corrtramite
     --           AND (tp.estadoOperativo IN ('DV','RE','CN') AND (tp.estadoOperativo = tf.estatus OR tf.estatus = 'SP')
     --           OR (tp.estadoOperativo IN ('EP') AND tp.estadoProceso IN ('SP', 'EP', 'ER') AND tf.estatus = tp.estadoProceso)))
     --    LEFT JOIN creditfactoryhis..bitacoraetapas bb ON (bb.secuencialGenerado = tf.ultsecuencialgenerado  
     --           AND bb.corrtramite= tp.corrtramite  
     --           AND bb.etapa = tf.etapa)  

     --    WHERE  tp.estramitepersona = 'S'
     --           AND tp.origen = case WHEN @origen IS NULL THEN tp.origen ELSE @origen END
     --           AND tp.fechaIngreso >= case WHEN @fechaIni IS NULL THEN tp.fechaIngreso ELSE @fechaIni END
     --           AND tp.fechaIngreso < case WHEN @fechaFin IS NULL THEN tp.fechaIngreso ELSE @fechaFin END

     --           AND tp.estadoOperativo = case WHEN @estadoTramite = 'AP' OR @estadoTramite = 'RE' OR @estadoTramite = 'CN' OR @estadoTramite = 'DV' OR @estadoTramite = 'EP' OR @estadoTramite = 'PM' THEN  @estadoTramite ELSE tp.estadoOperativo END
     --           AND tp.estadoProceso = case WHEN @estadoTramite = 'ER' THEN  @estadoTramite ELSE tp.estadoProceso END

     --           AND tp.codigoflujo = case WHEN @flujo IS NOT NULL AND @flujo  != '' THEN @flujo ELSE tp.codigoflujo END
     ORDER BY tp.fechaingreso
END


GO
/****** Object:  StoredProcedure [dbo].[sp_sabana_datos_tramite_solicitud]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- sp_sabana_datos_tramite_solicitud.sql
--
CREATE PROCEDURE [dbo].[sp_sabana_datos_tramite_solicitud]
(
    @origen            varchar(20),
    @fechaIni          datetime,
    @fechaFin          datetime,
    @estadoTramite     char(2),
    @flujo             varchar(10),
    @campaña           varchar(32)
)
as
begin
         SELECT      tp.corrtramite,    
                     tp.fechaIngreso,   
                     horaIngreso=convert(varchar,getdate(), 108),  
                     añoIngreso=datepart(yyyy, tp.fechaIngreso),   
                     mesIngreso=datepart(month, tp.fechaIngreso),  
                     semanaIngreso=datepart(ww, tp.fechaingreso),  
                     tp.corrtramite,  
                     s.oficina,  
                     'descripcionAgencia'= dbo.descripcionOficina(s.oficina, tp.origen),  
                     s.codigoVendedor,   
                     'usuario'=tp.usuario,   
                     s.categoriaProducto,    
                     'destinoProducto'=tp.producto,    
                     tp.estadoOperativo,     
                     tp.estadoProceso,   
                     s.montoCredito,   
                     tp.montoActual,   
                     s.cuotaPrestamo,    
                     tp.cuotaActual,    
                     s.periodicidadCuotas,  
                     correlativoCliente =c.correlativo,   
                     s.correlativoExterno,   
                     ingresoTotal=dbo.getIngresoNeto(c.correlativo, c.ingresomensualotr, c.ingresomensualremesas, c.ingresoformulario, 'N'),
                     c.primerNombre,     
                     c.segundonombre,  
                     c.primerapellido,  
                     c.segundoapellido,  
                     c.apellidocasada,  
                     c.numdocid,    
                     c.NIT,   
                     c.fechanacimiento,    
                     c.cui, 
                     tp.codigoFlujo,   
                     --'numeroCredito'=char(39) + s.numcredito,  
                     'numeroCredito'=CHAR(39) + case when ISNUMERIC(isnull(s.numcredito,'')) = 1 then SUBSTRING(isnull(s.numcredito,''),1,4) + '-XXXX-XXXX-' + SUBSTRING(isnull(s.numcredito,''),13,4) else s.numCredito end,
                     tp.emision,  
                     'categoriaRechazo'= 
                     case WHEN ( dbo.categoriasRechazo(tp.corrtramite, 'N') <> '' and @origen like 'PTC' and tf.estatus in ('RE','DV') and  tf.etapa in ('FTCR','AUTCR'))
                        then (dbo.categoriasRechazo(tp.corrtramite, 'N') + ' : ')  else dbo.categoriasRechazo(tp.corrtramite, 'N') end
                        +
                      case WHEN (@origen like 'PTC' and tf.estatus in ('RE','DV') and  tf.etapa in ('FTCR','AUTCR')) 
                          THEN ((select top 1  cuestionario.respuestaAbierta from CuestionarioTramitePreguntas as cuestionario
                                        where (cuestionario.respuestaabierta is not null and ltrim(rtrim(cuestionario.respuestaabierta)) <> '') 
                                        and cuestionario.pregunta like 'MOTIVO DE AUTORIZACION'
                                        and cuestionario.corrCuestionario in (
                                         select cpersona.correlativo from CuestionarioTramitePersona as cpersona
                                         where cpersona.corrPrincipal in (
                                                select top 1 ctramite.correlativo from cuestionariotramite ctramite
                                                where ctramite.corrTramite = tp.corrtramite
                                                and ctramite.etapa = tf.etapa
                                                order by ctramite.correlativo desc
                                            )
                                        )
                                    ) 
                             )
                         ELSE '' END,  
                      enHistorico='N', 
                      'NOMBRE VENDEDOR'=s.descripcionVendedor,   
                      tf.etapa,  
                      tf.estatus,  
                      tf.ultSecuencialGenerado,  
                      horafinal=isnull( bb.horaFinal , tp.fechaultmodif),   
                     'añoIngresoEtapa'= datepart(yyyy,bb.horaInicio),	 
                     'mesIngresoEtapa'= datepart(month,bb.horaInicio), 
                     'semanaIngresoEtapa'= datepart(ww,bb.horaInicio), 
                      'duracionMinutos'= datediff (minute, tp.fechaingreso, tp.fechaultmodif), 
                      'duracionDias'= datediff (day, tp.fechaingreso, tp.fechaultmodif),  
                      'diaFinalizacion'= datepart(day, isnull( bb.horaFinal , tp.fechaultmodif)), 
                      'semanaFinalizacion'= datepart(week, isnull( bb.horaFinal , tp.fechaultmodif)), 
                      'mesFinalizacion'=datepart(month, isnull( bb.horaFinal , tp.fechaultmodif)), 
                      'anioFinalizacion'=datepart(year, isnull( bb.horaFinal , tp.fechaultmodif)), 
                      'ultima etapa'= isnull(tf.etapa, dbo.ultimaEtapaAprobada (tp.corrtramite, tp.estadoOperativo, 'N')), 
                      c.montodeudaacumulada, 
                      c.montocuotaacumulada
         FROM         tramiteprocesos tp  WITH (NOLOCK)  
         INNER JOIN   tramitesolicitud ts  WITH (NOLOCK) ON (ts.corrtramite = tp.corrtramite)  
         INNER JOIN   solicitud s  WITH (NOLOCK) ON (ts.corrsolicitud = s.correlativo)  
         INNER JOIN   cliente c  WITH (NOLOCK) ON (s.corrclientesolicitante = c.correlativo)  
         LEFT JOIN    tramiteflujo tf  WITH (NOLOCK) ON (tf.corrtramite = tp.corrtramite   
              AND (tp.estadoOperativo IN ('DV','RE','CN') AND (tp.estadoOperativo = tf.estatus OR tf.estatus = 'SP')  
              OR (tp.estadoOperativo IN ('EP') AND tp.estadoProceso IN ('SP', 'EP', 'ER') AND tf.estatus = tp.estadoProceso)))  
         LEFT JOIN bitacoraetapas bb  WITH(NOLOCK) ON (bb.secuencialGenerado = tf.ultsecuencialgenerado  
              AND bb.corrtramite= tp.corrtramite  
              AND bb.etapa = tf.etapa)  
         WHERE tp.estramitesolicitud = 'S'

                    AND tp.origen = case WHEN @origen IS NULL THEN tp.origen ELSE @origen END
                    AND tp.fechaIngreso >= case WHEN @fechaIni IS NULL THEN tp.fechaIngreso ELSE @fechaIni END
                    AND tp.fechaIngreso < case WHEN @fechaFin IS NULL THEN tp.fechaIngreso ELSE @fechaFin END

                    AND tp.estadoOperativo = case WHEN @estadoTramite = 'AP' OR @estadoTramite = 'RE' OR @estadoTramite = 'CN' OR @estadoTramite = 'DV' OR @estadoTramite = 'EP' OR @estadoTramite = 'PM' THEN  @estadoTramite ELSE tp.estadoOperativo END
                    AND tp.estadoProceso = case WHEN @estadoTramite = 'ER' THEN  @estadoTramite ELSE tp.estadoProceso END

                    AND tp.codigoflujo = case WHEN @flujo IS NOT NULL AND @flujo  <> '' THEN @flujo ELSE tp.codigoflujo END
                    AND s.campaña = case WHEN @campaña IS NOT NULL AND @campaña  <> '' THEN @campaña ELSE s.campaña END

         --UNION 
         --    SELECT      tp.corrtramite,    
         --                tp.fechaIngreso,   
         --                horaIngreso=convert(varchar,getdate(), 108),  
         --                añoIngreso=datepart(yyyy, tp.fechaIngreso),   
         --                mesIngreso=datepart(month, tp.fechaIngreso),  
         --                semanaIngreso=datepart(ww, tp.fechaingreso),  
         --                tp.corrtramite,  
         --                s.oficina,  
         --                'descripcionAgencia'= dbo.descripcionOficina(s.oficina, tp.origen),  
         --                s.codigoVendedor,   
         --                'usuario'=tp.usuario,   
         --                s.categoriaProducto,    
         --                'destinoProducto'=tp.producto,    
         --                tp.estadoOperativo,     
         --                tp.estadoProceso,   
         --                s.montoCredito,   
         --                tp.montoActual,   
         --                s.cuotaPrestamo,    
         --                tp.cuotaActual,    
         --                s.periodicidadCuotas,  
         --                correlativoCliente =c.correlativo,   
         --                s.correlativoExterno,   
         --                ingresoTotal=dbo.getIngresoNeto(c.correlativo, c.ingresomensualotr, c.ingresomensualremesas, c.ingresoformulario, 'S'), 
         --                c.primerNombre,     
         --                c.segundonombre,  
         --                c.primerapellido,  
         --                c.segundoapellido,  
         --                c.apellidocasada,  
         --                c.numdocid,    
         --                c.NIT,   
         --                c.fechanacimiento,    
         --                c.cui, 
         --                tp.codigoFlujo,   
         --                'numeroCredito'=char(39) + s.numcredito,  
         --                tp.emision,  
         --            'categoriaRechazo'= 
         --            case WHEN ( dbo.categoriasRechazo(tp.corrtramite, 'S') <> '' and @origen like 'PTC' and tf.estatus in ('RE','DV') and  tf.etapa in ('FTCR','AUTCR'))
         --               then (dbo.categoriasRechazo(tp.corrtramite, 'S') + ' : ')  else dbo.categoriasRechazo(tp.corrtramite, 'S') end
         --               +
         --             case WHEN (@origen like 'PTC' and tf.estatus in ('RE','DV') and  tf.etapa in ('FTCR','AUTCR')) 
         --                 THEN ((select  top 1 cuestionario.respuestaAbierta from CuestionarioTramitePreguntas as cuestionario
         --                               where (cuestionario.respuestaabierta is not null and ltrim(rtrim(cuestionario.respuestaabierta)) <> '') 
         --                               and  cuestionario.pregunta like 'MOTIVO DE AUTORIZACION'
         --                               and cuestionario.corrCuestionario in (
         --                                select cpersona.correlativo from CuestionarioTramitePersona as cpersona
         --                                where cpersona.corrPrincipal in (
         --                                       select top 1 ctramite.correlativo from cuestionariotramite ctramite
         --                                       where ctramite.corrTramite = tp.corrtramite
         --                                       and ctramite.etapa = tf.etapa
         --                                       order by ctramite.correlativo desc
         --                                   )
         --                               )
         --                           ) 
         --                    )
         --                ELSE '' END,  
         --                enHistorico='S', 
         --                'NOMBRE VENDEDOR'=s.descripcionVendedor,   
         --                tf.etapa,  
         --                tf.estatus,  
         --                tf.ultSecuencialGenerado,  
         --                horafinal=isnull( bb.horaFinal , tp.fechaultmodif),   
         --                'añoIngresoEtapa'= datepart(yyyy,bb.horaInicio),	 
         --                'mesIngresoEtapa'= datepart(month,bb.horaInicio), 
         --                'semanaIngresoEtapa'= datepart(ww,bb.horaInicio), 
         --                'duracionMinutos'= datediff (minute, tp.fechaingreso, tp.fechaultmodif), 
         --                'duracionDias'= datediff (day, tp.fechaingreso, tp.fechaultmodif),  
         --                'diaFinalizacion'= datepart(day, isnull( bb.horaFinal , tp.fechaultmodif)), 
         --                'semanaFinalizacion'= datepart(week, isnull( bb.horaFinal , tp.fechaultmodif)), 
         --                'mesFinalizacion'=datepart(month, isnull( bb.horaFinal , tp.fechaultmodif)), 
         --                'anioFinalizacion'=datepart(year, isnull( bb.horaFinal , tp.fechaultmodif)), 
         --                'ultima etapa'= isnull(tf.etapa, dbo.ultimaEtapaAprobada (tp.corrtramite, tp.estadoOperativo, 'S')), 
         --                c.montodeudaacumulada, 
         --                c.montocuotaacumulada 
         --    FROM        creditfactoryhis..tramiteprocesos tp  WITH (NOLOCK)  
         --    INNER JOIN creditfactoryhis..tramitesolicitud ts WITH (NOLOCK) ON (ts.corrtramite = tp.corrtramite)  
         --    INNER JOIN creditfactoryhis..solicitud s WITH (NOLOCK) ON (ts.corrsolicitud = s.correlativo)  
         --    INNER JOIN creditfactoryhis..cliente c WITH (NOLOCK) ON (s.corrclientesolicitante = c.correlativo)  
         --    LEFT JOIN creditfactoryhis..tramiteflujo tf WITH (NOLOCK) ON (tf.corrtramite = tp.corrtramite   
         --         AND (tp.estadoOperativo IN ('DV','RE','CN') AND (tp.estadoOperativo = tf.estatus OR tf.estatus = 'SP')  
         --         OR (tp.estadoOperativo IN ('EP') AND tp.estadoProceso IN ('SP', 'EP', 'ER') AND tf.estatus = tp.estadoProceso)))  
         --    LEFT JOIN creditfactoryhis..bitacoraetapas bb ON (bb.secuencialGenerado = tf.ultsecuencialgenerado  
         --         AND bb.corrtramite= tp.corrtramite  
         --         AND bb.etapa = tf.etapa)  
         --    WHERE tp.estramitesolicitud = 'S'  

         --               AND tp.origen = case WHEN @origen IS NULL THEN tp.origen ELSE @origen END
         --               AND tp.fechaIngreso >= case WHEN @fechaIni IS NULL THEN tp.fechaIngreso ELSE @fechaIni END
         --               AND tp.fechaIngreso < case WHEN @fechaFin IS NULL THEN tp.fechaIngreso ELSE @fechaFin END

         --               AND tp.estadoOperativo = case WHEN @estadoTramite = 'AP' OR @estadoTramite = 'RE' OR @estadoTramite = 'CN' OR @estadoTramite = 'DV' OR @estadoTramite = 'EP' OR @estadoTramite = 'PM' THEN  @estadoTramite ELSE tp.estadoOperativo END
         --               AND tp.estadoProceso = case WHEN @estadoTramite = 'ER' THEN  @estadoTramite ELSE tp.estadoProceso END

         --               AND tp.codigoflujo = case WHEN @flujo IS NOT NULL AND @flujo  <> '' THEN @flujo ELSE tp.codigoflujo END
         --               AND s.campaña = case WHEN @campaña IS NOT NULL AND @campaña  <> '' THEN @campaña ELSE s.campaña END

         ORDER BY tp.fechaingreso
end


GO
/****** Object:  StoredProcedure [dbo].[sp_tramites_VDOCS]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec sp_tramites_VDOCS 1, '2016-09-01'
create proc [dbo].[sp_tramites_VDOCS] (
	@pp_empresa		smallint,
	@pp_fecha		datetime	= null,
	@cl_msgerr		varchar (200) = null output
) as

-- Reporte de Observaciones Sipsa_generacion_VDOCS --
	
DECLARE @usuario VARCHAR(200), 
        @corrTramite INT, 
        @nombre_agencia VARCHAR(300), 
        @estado VARCHAR(3), 
        @fechaIngreso DATETIME,
        @horaInicio DATETIME, 
        @horaFinal DATETIME,
        @observ1 VARCHAR(MAX),
        @observ2 VARCHAR(MAX),
        @mensajeRespuesta VARCHAR(MAX),
        @corrCuestionario INT ,
        @respuesta1 VARCHAR(MAX),
        @respuesta2 VARCHAR(MAX),
        @separador char(1),
        @path varchar (200),
        @exec varchar (max),
        @nombrearchivo varchar (200)

	IF  NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[#MyTempTable]'))
	begin
		CREATE TABLE #MyTempTable (
				usuario VARCHAR(200), 
				corrTramite INT, 
				nombre_agencia VARCHAR(300), 
				estado VARCHAR(3), 
				fechaIngreso DATETIME, 
				horaInicio DATETIME, 
				horaFinal DATETIME,
				observ1 VARCHAR(MAX),
				observ2 VARCHAR(MAX),
				corrCuestionario INT
				);
	end

	DECLARE @xml xml

	set  @pp_fecha = convert(datetime,dateadd(month,-1,dateadd(day,1,GETDATE())))
	
	set @separador	= '|'

	select 'Inicia del proceso    :' + convert(varchar,getdate(),109)
	
	select	@path   = pg_valor1 + ltrim(rtrim(em_descripcion)) + '\' + convert(varchar, @pp_fecha, 112) + '_archivos\'
        from	independiente..mt_param_general
		left outer join independiente..tc_empresa on pg_empresa = em_empresa 
		where pg_id = 'RUTAFILE' and pg_empresa = @pp_empresa
		if @path is null
			begin
				select 'No es factible crear el archivo Tramites_SIPSA_VDOCS.csv, no existe ruta en Parametros General (RUTAFILE)'
				return -1
			end 

	BEGIN TRY
	
		set @exec = ' EXEC xp_cmdshell ''md '+@path+''''
		exec(@exec)

		set @nombrearchivo = @path + 'Tramites_SIPSA_VDOCS.csv'
		
	DECLARE cursor_tramites_vdocs CURSOR FOR  
	  select
			a.usuario Usuario, a.corrTramite CorrTramite, e.nombre_agencia Agencia, a.estado Estado, 
			a.horaInicio FechaIni, a.horaInicio HoraIni, a.horaFinal FechaFinal, 0
		 from 
			TramiteProcesos     b with (nolock) inner join 
			BitacoraEtapas      a with (nolock) on (a.corrTramite = b.corrTramite) left join 
			operacion..agencias e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
		 where 
			a.etapa   = 'VDOCS'   and 
			b.origen  = 'SIPSA'  and 
			a.estado != 'SP'     and 
			year(a.horaFinal) = year(@pp_fecha) and
			month(a.horaFinal) = month(@pp_fecha)		
		union 
		select 
			d.usuario Usuario, c.corrTramite CorrTramite, e.nombre_agencia Agencia, 'PC' Estado, 
			c.fechaIngreso FechaIni, c.fechaIngreso HoraIni, d.fecha FechaFinal, c.correlativo
		 from 
			TramiteProcesos      b with (nolock) inner join 
			CuestionarioTramite  c with (nolock) on (b.corrTramite = c.corrTramite) inner join 
			BitacoraCuestionario d with (nolock) on (c.correlativo = d.corrcuestionario) left join 
			operacion..agencias  e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
			left join CuestionarioTramitePreguntas  p with(nolock) on p.corrCuestionario = c.correlativo
			left join CuestionarioTramiteRespuestas r with(nolock) on r.corrPregunta = p.correlativo
		 where 
			b.origen = 'SIPSA' and         
			c.etapa  = 'VDOCS' and 
			d.resultadoaprobaciontotal = 'PC' and 
			year(d.fecha) = year(@pp_fecha) and
			month(d.fecha) = month(@pp_fecha) 
	
	OPEN cursor_tramites_vdocs  
	FETCH NEXT FROM cursor_tramites_vdocs INTO  @usuario, @corrTramite, @nombre_agencia, @estado, @fechaIngreso, @horaInicio, @horaFinal, @corrCuestionario

	WHILE @@FETCH_STATUS = 0  
	BEGIN  

		   select @respuesta1 = ''
		   select @respuesta2 = ''  

		   select top 1  @mensajeRespuesta = formularioTO 
				 from    BitacoraCuestionario with(nolock)
				where    corrCuestionario = (
									select top 1 correlativo 
									  from CuestionarioTramite 
									 where corrTramite = @corrTramite
									   and etapa = 'VDOCS'
								  order by correlativo desc
				)

		  select @xml = convert(XML, @mensajeRespuesta)

		 select @respuesta1 =  Feld.N.value('(respuestaAbierta/text())[1]','varchar(max)')
		   from @xml.nodes('/com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioTramiteTO/cuestionarios/com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioPersonaTO/preguntas') as Felder(N)  cross apply Felder.N.nodes('com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioPreguntaTO') as Feld(N)
		  where Feld.N.value('(textoPregunta/text())[1]','varchar(max)')  = 'OBSERVACIONES' 
	      

		 select @respuesta2 =  Feld.N.value('(respuestaAbierta/text())[1]','varchar(max)')
		   from @xml.nodes('/com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioTramiteTO/cuestionarios/com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioPersonaTO/preguntas') as Felder(N)  cross apply Felder.N.nodes('com.procesa.creditfactory.tramite.cuestionario.to.CuestionarioPreguntaTO') as Feld(N)
		  where Feld.N.value('(textoPregunta/text())[1]','varchar(max)')  = 'OBSERVACIONES 2'

		INSERT INTO #MyTempTable 
				(usuario,  corrTramite , nombre_agencia , estado ,  fechaIngreso , horaInicio, horaFinal, observ1,  observ2, corrCuestionario)
		VALUES (@usuario, @corrTramite, @nombre_agencia, @estado, @fechaIngreso, @horaInicio, @horaFinal, @respuesta1,@respuesta2, @corrCuestionario);

		   FETCH NEXT FROM cursor_tramites_vdocs INTO @usuario, @corrTramite, @nombre_agencia, @estado, @fechaIngreso, @horaInicio, @horaFinal, @corrCuestionario
	end  
		 
	CLOSE cursor_tramites_vdocs  
	DEALLOCATE cursor_tramites_vdocs 

	if OBJECT_ID ('independiente..tramites_VDOCS') is not null 
	drop table  independiente..tramites_VDOCS

	create table independiente..tramites_VDOCS (contador int identity (1,1), Registro varchar (max))

	insert into independiente..tramites_VDOCS (registro)
		select Registro = 'usuario' + @separador + 'corrTramite' + @separador + 'nombre_agencia' + @separador + 'estado' + @separador + 'fechaIngreso' + @separador + 
						  'horaInicio' + @separador + 'horaFinal' + @separador + 'observ1' + @separador + 'observ2' + @separador + 'corrCuestionario' 
						  
	insert into independiente..tramites_VDOCS (registro)
		select Registro = convert(varchar,isnull(usuario,'')) +	
						  @separador +  
						  convert(varchar,isnull(corrTramite,0)) +
						  @separador + 
						  convert(varchar,isnull(nombre_agencia,'')) +
						  @separador + 
						  convert(varchar,isnull(estado,'')) +
						  @separador +  
						  convert(varchar,isnull(fechaIngreso,''),121) +
						  @separador + 
						  convert(varchar,isnull(horaInicio,''),121) +
						  @separador + 
						  convert(varchar,isnull(horaFinal,''),121) +
						  @separador + 
						  convert(varchar,isnull(observ1,'')) +
						  @separador +   
						  convert(varchar,isnull(observ2,'')) +
						  @separador + 
						  convert(varchar,isnull(corrCuestionario,''))		  
		 from #MyTempTable 
		 order by usuario desc

	update independiente..tramites_VDOCS set registro = replace (replace (replace(registro,'"',''),',',''),'|',',');
	
	/************************************************************************************
					** SE ESCRIBE A DISCO EL ARCHIVO CONSOLIDADO**																					
	************************************************************************************/
	
	set @exec = 'EXEC xp_cmdshell ''bcp "set nocount on;select Registro from independiente..tramites_VDOCS order by contador " queryout "'+@nombrearchivo+'" -c -CACP -T  -S'+@@SERVERNAME+' ''';
	exec (@exec)
			
	print convert (varchar (20),getdate  ())

	if ERROR_NUMBER () is null
		BEGIN
			select 'Fin del proceso    :' + convert(varchar,getdate(),109)
			select 'Se genero archivo: ' + @nombrearchivo
		END
	END TRY

	BEGIN CATCH 

					select @cl_msgerr = 'Error al intentar escribir en archivo: ' + isnull (@nombrearchivo,'')  
					select @cl_msgerr as 'Mensaje'
		select       ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;  
		return -1

END CATCH  

return 0


GO
/****** Object:  StoredProcedure [dbo].[sp_traslado_desde_operacion_AF]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_traslado_desde_operacion_AF]
AS
begin
   --dump tran creditfactory with no_log
   --dump tran creditfactory with truncate_only

   --AFParametros
   set identity_insert AFParametros on
   print 'AFParametros'
   insert creditfactory..AFParametros (correlativo,
	      fechaIngreso,
	      fechaModificacion,
	      Usuario,
	      estado,
	      rowVersion,
	      descripcion,
	      categoria) 
      select correlativo,
		fechaIngreso,
		fechaModificacion,
		Usuario,
		estado,
		rowVersion,
		descripcion,
		categoria
      from operacion..AFParametros
   set identity_insert AFParametros off
   

   --AFParametrosValor  
   PRINT 'AFParametrosValor'
   insert creditfactory..AFParametrosValor (corrParametro,
		valor,
		fechaIngreso,
		fechaModificacion,
		Usuario,
		estado,
		rowVersion,
		motivo )
    select corrParametro,
		valor,
		fechaIngreso,
		fechaModificacion,
		Usuario,
		estado,
		rowVersion,
		motivo
    from operacion..AFParametrosValor


end




GO
/****** Object:  StoredProcedure [dbo].[sp_traslado_desde_operacion_CM]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_traslado_desde_operacion_CM]
AS
BEGIN
	--TRASLADO DE CONSULTAS MANUALES.
   --dump tran creditfactory with no_log
   --dump tran creditfactory with truncate_only

   insert condBuroBanru (corrtramite,
		status,
		prestamosVigentes,
		prestamosCancelados,
		estaAlDiaPagos,
		moras60por30dias,
		moras60por12meses,
		moras90por12meses,
		moras120,
		cuota,
		deuda )
	 select corrtramite,
		status,
		prestamosVigentes,
		prestamosCancelados,
		estaAlDiaPagos,
		moras60por30dias,
		moras60por12meses,
		moras90por12meses,
		moras120,
		cuota,
		deuda
	from operacion..condBuroBanru
	print 'condBuroBanru'

	insert condCentralRiesgo (
		corrTramite,
		calificacion,
		deuda,
		cuota,
		tieneRegistros,
		estaAlDiaPagos )
	select corrTramite,
		calificacion,
		deuda,
		cuota,
		tieneRegistros,
		estaAlDiaPagos
	from operacion..condCentralRiesgo
	print 'condCentralRiesgo'

	insert condCrediref  (
		corrtramite,
		estaAlDiaPago,
		moras60por3meses,
		moras60por12meses,
		moras90por12meses,
		moras120,
		cuentasCobroJudicial,
		cuentaIncobrable,
		enProcesoProrroga,
		canceladoRenovacion,
		canceladoPorIncobrable,
		canceladoPorEjecucionJudicial,
		saldoReestructurado,
		totalDeudas,
		totalCuotas,
		tieneRegistros )
	select corrtramite,
		estaAlDiaPago,
		moras60por3meses,
		moras60por12meses,
		moras90por12meses,
		moras120,
		cuentasCobroJudicial,
		cuentaIncobrable,
		enProcesoProrroga,
		canceladoRenovacion,
		canceladoPorIncobrable,
		canceladoPorEjecucionJudicial,
		saldoReestructurado,
		totalDeudas,
		totalCuotas,
		tieneRegistros
	from operacion..condCrediref
	print 'condCrediref'

	insert condInfornet (
		corrTramite,
		tieneCreditosEdoMalo,
		tieneCreditosClasifMala,
		nJuicios2,
		nJuicios0a2,
		nJuicios1a2,
		tieneRegistros ) 
	select corrTramite,
		tieneCreditosEdoMalo,
		tieneCreditosClasifMala,
		nJuicios2,
		nJuicios0a2,
		nJuicios1a2,
		tieneRegistros
	from operacion..condInfornet
	print 'condInfornet'

	insert condTransunion  (
		corrTramite,
		tieneRefComercialesMalas,
		tieneRefCrediticiasMalas,
		nJuicios2,
		nJuicios0a2,
		nJuicios1a2,
		moras60por3meses,
		moras60por12meses,
		moras90por12meses,
		moras120,
		cuentasCobroJudicial,
		cuentasSaldoReestructurado,
		tieneRegistros,
		cuota,
		deuda ) 
	select corrTramite,
		tieneRefComercialesMalas,
		tieneRefCrediticiasMalas,
		nJuicios2,
		nJuicios0a2,
		nJuicios1a2,
		moras60por3meses,
		moras60por12meses,
		moras90por12meses,
		moras120,
		cuentasCobroJudicial,
		cuentasSaldoReestructurado,
		tieneRegistros,
		cuota,
		deuda
	from operacion..condTransunion
	print 'condTransunion'

end




GO
/****** Object:  StoredProcedure [dbo].[sp_traslado_desde_operacion_CND]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_traslado_desde_operacion_CND]
AS
BEGIN

--dump tran creditfactory with no_log
--dump tran creditfactory with truncate_only

set identity_insert logreglas on
insert LogReglas (
    correlativo        ,
    corrTramite        ,
    etapa              ,
    estado             ,
    fecha              ,
    secuencialGenerado ,
    nota               ,
    ruleTO             ,
    tieneAdvertencias  ) 
select     correlativo        ,
    corrTramite        ,
    etapa              ,
    estado             ,
    fecha              ,
    secuencialGenerado ,
    nota               ,
    ruleTO             ,
    tieneAdvertencias  
from operacion..logreglas
set identity_insert logreglas off
print 'logreglas'

set identity_insert logreglasaceptadas on
insert logreglasaceptadas (
    corrRegla   ,
    campo       ,
    valor       ,
    correlativo ,
    motivo      ,
    advertencia )
select     corrRegla   ,
    campo       ,
    valor       ,
    correlativo ,
    motivo      ,
    advertencia 
from operacion..logreglasaceptadas
set identity_insert logreglasaceptadas off
print 'logreglasaceptadas'

set identity_insert logreglasrechazos on
insert LogReglasRechazos (
    corrRegla   ,
    campo       ,
    condicion   ,
    motivo      ,
    correlativo ,
    valor       ,
    categoria   )
select corrRegla   ,
    campo       ,
    condicion   ,
    motivo      ,
    correlativo ,
    valor       ,
    categoria   
from operacion..logreglasrechazos
set identity_insert logreglasrechazos off
print 'logreglasrechazos'

	
END




GO
/****** Object:  StoredProcedure [dbo].[sp_traslado_desde_operacion_FRM]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_traslado_desde_operacion_FRM]
AS
BEGIN 
    --dump tran creditfactory with no_log
    --dump tran creditfactory with truncate_only

	set identity_insert cuestionariotramite on
	insert CuestionarioTramite (
	    correlativo                         ,
	    corrTramite                         ,
	    etapa                               ,
	    secuencialGenerado                  ,
	    fechaIngreso                        ,
	    fechaUltModificacion                ,
	    resultadoAprobacionTotal            ,
	    documentacionIncluida               ,
	    documentacionPorSolicitud           ,
	    documentacionPorPersona             ,
	    observacionResultadoAprobacionTotal ,
	    corrSolicitud                       ,
	    nota                                ,
	    url                                 ,
	    personaAsignada                     ,
	    usuario                             ,
	    formularioInvalidado                )
	select     correlativo                         ,
	    corrTramite                         ,
	    etapa                               ,
	    secuencialGenerado                  ,
	    fechaIngreso                        ,
	    fechaUltModificacion                ,
	    resultadoAprobacionTotal            ,
	    documentacionIncluida               ,
	    documentacionPorSolicitud           ,
	    documentacionPorPersona             ,
	    observacionResultadoAprobacionTotal ,
	    corrSolicitud                       ,
	    nota                                ,
	    url                                 ,
	    personaAsignada                     ,
	    usuario                             ,
	    formularioInvalidado                
	from operacion..cuestionariotramite
	set identity_insert cuestionariotramite off
	print 'cuestionariotramite'

	set identity_insert cuestionariotramitepersona on
	insert CuestionarioTramitePersona (
	    correlativo             ,
	    corrCliente             ,
	    fechaIngreso            ,
	    fechaUltModificacion    ,
	    motivoRechazo           ,
	    corrPrincipal           ,
	    nota                    ,
	    rol                     ,
	    preguntaCorrrelacionada )
	select correlativo             ,
	    corrCliente             ,
	    fechaIngreso            ,
	    fechaUltModificacion    ,
	    motivoRechazo           ,
	    corrPrincipal           ,
	    nota                    ,
	    rol                     ,
	    preguntaCorrrelacionada 
	from operacion..cuestionariotramitepersona
	set identity_insert cuestionariotramitepersona off
	if @@error != 0
	begin
	    print 'ERROR ['  + convert(varchar, @@error) + ']'
		return 1
	end
	print 'cuestionariotramitepersona'

	set identity_insert cuestionariotramitepreguntas on
	insert CuestionarioTramitePreguntas (
	    corrCuestionario  ,
	    pregunta          ,
	    estado            ,
	    correlativo       ,
	    respuestaAbierta  ,
	    esPreguntaCerrada ,
	    esPreguntaAbierta ,
	    esObligatoria     ,
	    tipoDatoPregunta  ,
	    esExcluyente      ,
	    esSubTitulo       ,
	    esNota            ) 
	select     corrCuestionario  ,
	    pregunta          ,
	    estado            ,
	    correlativo       ,
	    respuestaAbierta  ,
	    esPreguntaCerrada ,
	    esPreguntaAbierta ,
	    esObligatoria     ,
	    tipoDatoPregunta  ,
	    esExcluyente      ,
	    esSubTitulo       ,
	    esNota            
	from operacion..cuestionariotramitepreguntas
	set identity_insert cuestionariotramitepreguntas off
	print 'cuestionariotramitepreguntas'

	set identity_insert cuestionariotramiterespuestas on
	insert CuestionarioTramiteRespuestas (
	    corrPregunta     ,
	    respuestaCerrada ,
	    secuencial       ,
	    seleccionada     ) 
	select     corrPregunta     ,
	    respuestaCerrada ,
	    secuencial       ,
	    seleccionada     
	from operacion..cuestionariotramiterespuestas
	set identity_insert cuestionariotramiterespuestas off
	print 'cuestionariotramiterespuestas'

	set identity_insert bitacoracuestionario on
	insert BitacoraCuestionario (
	    correlativo   ,
	    corrCuestionario                    ,
	    resultadoAprobacionTotal            ,
	    observacionResultadoAprobacionTotal ,
	    formularioTO                        ,
	    fecha                               ,
	    usuario )
	select correlativo                         ,
	    corrCuestionario                    ,
	    resultadoAprobacionTotal            ,
	    observacionResultadoAprobacionTotal ,
	    formularioTO                        ,
	    fecha                               ,
	    usuario 
	from operacion..bitacoracuestionario
	set identity_insert bitacoracuestionario off
	print 'bitacoracuestionario'

	
END




GO
/****** Object:  StoredProcedure [dbo].[sp_traslado_desde_operacion_LTN]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_traslado_desde_operacion_LTN]
AS
BEGIN
	insert listanegra (
       correlativo,
		primerNombre,
		primerApellido,
		numeroId,
		motivo,
		usuario,
		fechaIngreso,
		fechaModificacion,
		estado,
		segundoNombre,
		segundoApellido,
		tercerNombre,
		tercerApellido ) 
	select 
		correlativo,
		primerNombre,
		primerApellido,
		numeroId,
		motivo,
		usuario,
		fechaIngreso,
		fechaModificacion,
		estado,
		segundoNombre,
		segundoApellido,
		tercerNombre,
		tercerApellido
	from operacion..listanegra

	print 'LISTA NEGRA'

END




GO
/****** Object:  StoredProcedure [dbo].[sp_traslado_desde_operacion_PER]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_traslado_desde_operacion_PER]
AS
BEGIN
    --dump tran creditfactory with no_log
    --dump tran creditfactory with truncate_only

 --   set identity_insert cliente on
	--insert Cliente (
	--    origenIngresos          --int           NULL,
	--    ,correlativo             --numeric(18,0) IDENTITY,
	--    ,primerNombre            --varchar(100)  NOT NULL,
	--    ,primerApellido          --varchar(100)  NOT NULL,
	--    ,segundoNombre           --varchar(100)  NULL,
	--    ,segundoApellido         --varchar(100)  NULL,
	--    ,usuario                 --varchar(50)   NOT NULL,
	--    ,fechaIngreso            --datetime      NOT NULL,
	--    ,fechaModificacion       --datetime      NULL,
	--    ,fechaNacimiento         --datetime      NULL,
	--    ,fechaFallecimiento      --datetime      NULL,
	--    ,estado                  --char(2)       NOT NULL,
	--    ,rowVersion              --int           NOT NULL,
	--    ,apellidoCasada          --varchar(50)   NULL,
	--    ,paisOrigen              --varchar(20)   NULL,
	--    ,profesion               --varchar(32)   NULL,
	--    ,sexo                    --varchar(20)   NULL,
	--    ,estadoCivil             --varchar(20)   NULL,
	--    ,numDependientes         --int           NULL,
	--    ,NIT                     --varchar(20)   NULL,
	--    ,MIS                     --int           NULL,
	--    ,carnetIGSS              --varchar(20)   NULL,
	--    ,corrDireccion           --numeric(18,0) NULL,
	--    ,puestoDesempenado       --varchar(50)   NULL,
	--    ,ingresoMensualOtr       --money         NULL,
	--    ,nIngresoMensualOtr      --int           NULL,
	--    ,egresoMensual           --money         NULL,
	--    ,nacionalidad            --varchar(50)   NULL,
	--    ,tieneNegocioPropio      --char(1)       NULL,
	--    ,poseeVehiculo           --char(1)       NULL,
	--    ,tercerApellido          --varchar(50)   NULL,
	--    ,tercerNombre            --varchar(50)   NULL,
	--    ,ingresoMensualRemesas   --money         NULL,
	--    ,tieneTramitesRechazados --char(1)       NULL,
	--    ,ultimoTramiteRechazado  --int           NULL,
	--    ,tipoDocId               --varchar(20)   NULL,
	--    ,numDocId                --varchar(50)   NULL,
	--    ,lugarDocId              --varchar(50)   NULL,
	--    ,ingresoFormulario       --money         NULL,
	--    ,corrFormularioAsociado  --int           NULL,
	--    ,esJubilado              --char(1)       NULL,
	--    ,clasificacion           --varchar(10)   NULL,
	--) select 
	--    origenIngresos          --int           NULL,
	--    ,correlativo             --numeric(18,0) IDENTITY,
	--    ,primerNombre            --varchar(100)  NOT NULL,
	--    ,primerApellido          --varchar(100)  NOT NULL,
	--    ,segundoNombre           --varchar(100)  NULL,
	--    ,segundoApellido         --varchar(100)  NULL,
	--    ,usuario                 --varchar(50)   NOT NULL,
	--    ,fechaIngreso            --datetime      NOT NULL,
	--    ,fechaModificacion       --datetime      NULL,
	--    ,fechaNacimiento         --datetime      NULL,
	--    ,fechaFallecimiento      --datetime      NULL,
	--    ,estado                  --char(2)       NOT NULL,
	--    ,rowVersion              --int           NOT NULL,
	--    ,apellidoCasada          --varchar(50)   NULL,
	--    ,paisOrigen              --varchar(20)   NULL,
	--    ,profesion               --varchar(32)   NULL,
	--    ,sexo                    --varchar(20)   NULL,
	--    ,estadoCivil             --varchar(20)   NULL,
	--    ,numDependientes         --int           NULL,
	--    ,NIT                     --varchar(20)   NULL,
	--    ,MIS                     --int           NULL,
	--    ,carnetIGSS              --varchar(20)   NULL,
	--    ,corrDireccion           --numeric(18,0) NULL,
	--    ,puestoDesempeñado       --varchar(50)   NULL,
	--    ,ingresoMensualOtr       --money         NULL,
	--    ,nIngresoMensualOtr      --int           NULL,
	--    ,egresoMensual           --money         NULL,
	--    ,nacionalidad            --varchar(50)   NULL,
	--    ,tieneNegocioPropio      --char(1)       NULL,
	--    ,poseeVehiculo           --char(1)       NULL,
	--    ,tercerApellido          --varchar(50)   NULL,
	--    ,tercerNombre            --varchar(50)   NULL,
	--    ,ingresoMensualRemesas   --money         NULL,
	--    ,tieneTramitesRechazados --char(1)       NULL,
	--    ,ultimoTramiteRechazado  --int           NULL,
	--    ,tipoDocId               --varchar(20)   NULL,
	--    ,numDocId                --varchar(50)   NULL,
	--    ,lugarDocId              --varchar(50)   NULL,
	--    ,ingresoFormulario       --money         NULL,
	--    ,corrFormularioAsociado  --int           NULL,
	--    ,esJubilado              --char(1)       NULL,
	--    ,clasificacion           --varchar(10)   NULL,
	--from operacion..cliente
	--set identity_insert cliente off
	--print 'CLIENTE'



	set identity_insert empresa on
	insert Empresa (
	    correlativo              ,
	    nombreComercial          ,
	    sectorEconomico          ,
	    nombreRepresentanteLegal ,
	    fechaCreacion            ,
	    fechaCierre              ,
	    razonSocial              ,
	    descripcionNegocio       ,
	    corrDireccion            ,
	    numPatente               ,
	    NIT                      ,
	    fechaInicioOperaciones   ,
	    actividadEconomica ) 
	select correlativo       ,
	    nombreComercial          ,
	    sectorEconomico          ,
	    nombreRepresentanteLegal ,
	    fechaCreacion            ,
	    fechaCierre              ,
	    razonSocial              ,
	    descripcionNegocio       ,
	    corrDireccion            ,
	    numPatente               ,
	    NIT                      ,
	    fechaInicioOperaciones   ,
	    actividadEconomica 
	from operacion..empresa
	set identity_insert empresa off
	print 'EMPRESA'


	set identity_insert direccion on
	insert Direccion (
	    correlativo       ,
	    municipio         ,
	    pais              ,
	    departamento      ,
	    rowVersion        ,
	    calle             ,
	    avenida           ,
	    numeroCasa        ,
	    colonia           ,
	    sector            ,
	    manzana           ,
	    zona              ,
	    ciudad            ,
	    cuotaAlquiler     ,
	    tipoVivienda      ,
	    tiempoResidencia  ,
	    fechaModificacion ,
	    fechaIngreso      ,
	    fechaInicio       ,
	    aldea             ,
	    otroDato     )
	select   correlativo  ,
	    municipio         ,
	    pais              ,
	    departamento      ,
	    rowVersion        ,
	    calle             ,
	    avenida           ,
	    numeroCasa        ,
	    colonia           ,
	    sector            ,
	    manzana           ,
	    zona              ,
	    ciudad            ,
	    cuotaAlquiler     ,
	    tipoVivienda      ,
	    tiempoResidencia  ,
	    fechaModificacion ,
	    fechaIngreso      ,
	    fechaInicio       ,
	    aldea             ,
	    otroDato     
	from operacion..direccion
	set identity_insert direccion off
	print 'EMPRESA'
	    
	set identity_insert medioscontacto on
	insert MediosContacto (
	    correlativo   ,
	    valor         ,
	    descripcion   ,
	    fechaIngreso  ,
	    fechaUltModif ,
	    tipoMedio     )  
	select correlativo   ,
	    valor         ,
	    descripcion   ,
	    fechaIngreso  ,
	    fechaUltModif ,
	    tipoMedio   
	from operacion..medioscontacto
	set identity_insert medioscontacto off
	print 'MEDIOS CONTACTO'


	set identity_insert ocupacion on
	insert Ocupacion (
	    corrCliente          ,
	    tipoRelacionLaboral  ,
	    ingreso              ,
	    fechaIngreso         ,
	    correoTrabajo        ,
	    fechaInicioLabores   ,
	    bonificacion         ,
	    salarioBase          ,
	    corrEmpresa          ,
	    actividadEconomica   ,
	    sectorEconomico      ,
	    fechaFinTrabajo      ,
	    puestoDesempeniado   ,
	    nombreJefeInmediato  ,
	    cedulaJefeInmediato  ,
	    fechaUltModif        ,
	    esOcupacionPrincipal ,
	    correlativo  )  
	select    corrCliente          ,
	    tipoRelacionLaboral  ,
	  ingreso              ,
	    fechaIngreso         ,
	    correoTrabajo        ,
	    fechaInicioLabores   ,
	    bonificacion         ,
	    salarioBase          ,
	    corrEmpresa          ,
	    actividadEconomica   ,
	    sectorEconomico      ,
	    fechaFinTrabajo      ,
	    puestoDesempeniado   ,
	    nombreJefeInmediato  ,
	    cedulaJefeInmediato  ,
	    fechaUltModif        ,
	    esOcupacionPrincipal ,
	    correlativo 
	from operacion..ocupacion
	print 'OCUPACION'
	set identity_insert ocupacion off

	insert PersonaTelefono (
		corrCliente,
		corrTelefono)  
	select 	corrCliente,
		corrTelefono
	from operacion..personatelefono
	print 'PERSONA TELEFONO'



	insert EmpresaTelefono (
	    corrEmpresa  ,
	    corrTelefono )
	select corrEmpresa  ,
	    corrTelefono
	from operacion..empresatelefono
	print 'EMPRESA TELEFONO'

      
END




GO
/****** Object:  StoredProcedure [dbo].[sp_traslado_desde_operacion_PRM]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_traslado_desde_operacion_PRM]
AS
BEGIN
--dump tran creditfactory with no_log
--dump tran creditfactory with truncate_only

insert Servicio 
(
    codigo        ,
    nombre        ,
    identificador ,
    fechaIng      ,
    usuario       ,
    rowVersion    ,
    fechaMod      ) 
select     codigo        ,
    nombre        ,
    identificador ,
    fechaIng      ,
    usuario       ,
    rowVersion    ,
    fechaMod      
from operacion..Servicio

insert ServicioParametros (
    codigoServicio ,
    parametro      ,
    valorStr       ,
    valorInt       ,
    fechaIng       ,
    fechaMod       ,
    rowVersion     )
select     codigoServicio ,
    parametro      ,
    valorStr       ,
    valorInt       ,
    fechaIng       ,
    fechaMod       ,
    rowVersion     
from operacion..servicioparametros

insert Tabla (
    codigo      ,
    nombre      ,
    descripcion ,
    estado      ,
    fecha  )
select     codigo      ,
    nombre      ,
    descripcion ,
    estado      ,
    fecha  
from operacion..tabla

insert DetalleTabla (
    tabla       ,
    codigo      ,
    descripcion ,
    fecha     )
select     tabla       ,
    codigo      ,
    descripcion ,
    fecha  
from operacion..detalletabla
        
END




GO
/****** Object:  StoredProcedure [dbo].[sp_traslado_desde_operacion_SOL]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_traslado_desde_operacion_SOL]
AS
BEGIN
    --dump tran creditfactory with no_log
    --dump tran creditfactory with truncate_only

 --   set identity_insert solicitud on
	--insert Solicitud (
	--    tipoSolicitud          ,
	--    codigoVendedor         ,
	--    correlativo            ,
	--    fechaIngreso           ,
	--    fechaModificacion      ,
	--    oficina                ,
	--    rowVersion             ,
	--    tipoTarjeta            ,
	--    producto               ,
	--    empresaOrigen          ,
	--    limiteRecomendado      ,
	--    campaña                ,
	--    promocion              ,
	--    limiteCredito          ,
	--    emisionAsignada        ,
	--    corrDireccion          ,
	--    corrClienteSolicitante ,
	--    corrClienteConyugue    ,
	--    montoCredito           ,
	--    origen                 ,
	--    plazoSolicitado        ,
	--    tieneCtaMonetaria      ,
	--    tieneCtaAhorro         ,
	--    cuotaPrestamo          ,
	--    microfinanzas          ,
	--    descripcionPrestamo    ,
	--    correoANotificar       ,
	--    correlativoExterno     ,
	--    ingresoMinimoGeneral   ,
	--    numCredito             ,
	--    periodicidadCuotas     ,
	--    fiadoresObligatorios   ,
	--    categoriaProducto      ,
	--    destinoProducto        ,
	--    afiliado               ,
	--    nombreOficina          ,
	--    tasa                   ,
	--    xmlTO                  ,
	--    capturaCanal           )
	--select     tipoSolicitud          ,
	--    codigoVendedor         ,
	--    correlativo            ,
	--    fechaIngreso           ,
	--    fechaModificacion      ,
	--    oficina                ,
	--    rowVersion             ,
	--    tipoTarjeta            ,
	--    producto               ,
	--    empresaOrigen          ,
	--    limiteRecomendado      ,
	--    campaña                ,
	--    promocion              ,
	--    limiteCredito          ,
	--    emisionAsignada        ,
	--    corrDireccion          ,
	--    corrClienteSolicitante ,
	--    corrClienteConyugue    ,
	--    montoCredito           ,
	--    origen                 ,
	--    plazoSolicitado        ,
	--    tieneCtaMonetaria      ,
	--    tieneCtaAhorro         ,
	--    cuotaPrestamo          ,
	--    microfinanzas          ,
	--    descripcionPrestamo    ,
	--    correoANotificar       ,
	--    correlativoExterno     ,
	--    ingresoMinimoGeneral   ,
	--    numCredito             ,
	--    periodicidadCuotas     ,
	--    fiadoresObligatorios   ,
	--    categoriaProducto      ,
	--    destinoProducto        ,
	--    afiliado               ,
	--    nombreOficina          ,
	--    tasa                   ,
	--    xmlTO                  ,
	--    capturaCanal 
	--from operacion..solicitud
	--set identity_insert solicitud off
	--print 'solicitud'

	insert EmpresaSolicitud (
	    corrEmpresa   ,
	    corrSolicitud ,
	    fecha         ) 
	select corrEmpresa   ,
	    corrSolicitud ,
	    fecha         
	from operacion..empresasolicitud
	print 'empresasolicitud'

    
	set identity_insert referenciaspersonales on
	insert ReferenciasPersonales (
	    corrSolicitud   ,
	    primerNombre    ,
	    primerApellido  ,
	    telefono        ,
	    tipoRelacion    ,
	    correlativo     ,
	    segundoNombre   ,
	    segundoApellido ,
	    apellidoCasada  ,
	    cedula          ,
	    NIT             ) 
	select     corrSolicitud   ,
	    primerNombre    ,
	    primerApellido  ,
	    telefono        ,
	    tipoRelacion    ,
	    correlativo     ,
	    segundoNombre   ,
	    segundoApellido ,
	    apellidoCasada  ,
	    cedula          ,
	    NIT             
	from operacion..referenciaspersonales
	set identity_insert referenciaspersonales off
	print 'refrenciaspersonales'

	insert DocumentosAdjuntos (
	    corrSolicitud  ,
	    tipoDoc        ,
	    descripcionDoc ,
	    imagen         ,
	    corrCliente    ,
	    observaciones  ,
	    estado         ,
	    etapa          )
	select     corrSolicitud  ,
	    tipoDoc        ,
	    descripcionDoc ,
	    imagen         ,
	   corrCliente    ,
	    observaciones  ,
	    estado         ,
	    etapa          
	from operacion..documentosadjuntos
	print 'documentos adjuntos'

	set identity_insert otrascuentas on
	insert OtrasCuentas (
	    correlativo      ,
	    corrSolicitud    ,
	    empresaEmisora   ,
	    numeroTarjeta    ,
	    limiteAutorizado ,
	    fechaVencimiento ,
	    rowVersion       )
	select correlativo      ,
	    corrSolicitud    ,
	    empresaEmisora   ,
	    numeroTarjeta    ,
	    limiteAutorizado ,
	    fechaVencimiento ,
	    rowVersion       
	from operacion..otrascuentas
	set identity_insert otrascuentas off
	print 'otras cuentas'

	insert ClienteAdicional (
	    corrCliente             ,
	    corrSolicitud           ,
	    relacionTarjetaHabiente ,
	    otroTipo                ,
	    nombreTarjeta     )
    select 	corrCliente        ,
	    corrSolicitud           ,
	    relacionTarjetaHabiente ,
	    otroTipo                ,
	    nombreTarjeta     
    from operacion..clienteadicional				      
	print 'cliente adicional'

	insert ClienteFiador (
	    corrCliente   ,
	    corrSolicitud ,
	    fecha         )
	select  corrCliente   ,
	    corrSolicitud ,
	    fecha         
	from operacion..clientefiador
	print 'cliente fiador'

end




GO
/****** Object:  StoredProcedure [dbo].[sp_traslado_desde_operacion_TRM]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_traslado_desde_operacion_TRM]
AS
BEGIN
    --dump tran creditfactory with no_log
    --dump tran creditfactory with truncate_only

	set identity_insert tramiteprocesos on
	insert TramiteProcesos (
	    corrTramite           ,
	    fechaIngreso          ,
	    fechaUltModif         ,
	    estadoOperativo       ,
	    esTramitePersona      ,
	    esTramiteSolicitud    ,
	    rowVersion            ,
	    tieneAdvertencias     ,
	    origen                ,
	    codigoFlujo           ,
	    producto              ,
	    forzamientoHabilitado ,
	    estadoProceso         ,
	    montoAcumulado        ,
	    montoActual           ,
	    cuotaAcumulada        ,
	    cuotaActual           ,
	    actualizarMonto       ,
	    actualizarCuota       ,
	    preautorizacion       ,
	    corrPreautorizacion   ,
	    corrLote              ,
	    categoriaProducto     ,
	    destinoProducto       ,
	    codigoVendedor        ,
	    tasaInteres           ,
	    plazo                 ,
	    plazoActual           ,
	    corrTramiteAnterior   ,
	    agenciaDescripcion    ,
	    emision               ,
	    canalCaptura          ,
	    oficina               ,
	    oficinaDescripcion    ,
	    usuario               ,
	    descripcionEmision    ,
	    descripcionProducto   ,
	    nota                  ,
	    periodicidad     ) 
	select     corrTramite           ,
	    fechaIngreso          ,
	    fechaUltModif         ,
	    estadoOperativo       ,
	    esTramitePersona      ,
	    esTramiteSolicitud    ,
	    rowVersion            ,
	    tieneAdvertencias     ,
	    origen                ,
	    codigoFlujo           ,
	    producto              ,
	    forzamientoHabilitado ,
	    estadoProceso         ,
	    montoAcumulado        ,
	    montoActual           ,
	    cuotaAcumulada        ,
	    cuotaActual           ,
	    actualizarMonto       ,
	    actualizarCuota       ,
	    preautorizacion       ,
	    corrPreautorizacion   ,
	    corrLote              ,
	    categoriaProducto     ,
	    destinoProducto       ,
	    codigoVendedor        ,
	    tasaInteres           ,
	    plazo                 ,
	    plazoActual           ,
	    corrTramiteAnterior   ,
	    agenciaDescripcion    ,
	    emision               ,
	    canalCaptura          ,
	    oficina               ,
	    oficinaDescripcion    ,
	    usuario               ,
	    descripcionEmision    ,
	    descripcionProducto   ,
	    nota                  ,
	    periodicidad     
	from operacion..tramiteprocesos		     
	set identity_insert tramiteprocesos off
	print 'tramiteprocesos'


	insert TramiteFlujo (
	    etapa                 ,
	    corrTramite           ,
	    fechaCreacion         ,
	    estatus               ,
	    orden                 ,
	    ingresomanual         ,
	    tieneAdvertencias     ,
	    ejecuciones           ,
	    ejecucionParalelo     ,
	    ultSecuencialGenerado )
	select     etapa                 ,
	    corrTramite           ,
	    fechaCreacion         ,
	    estatus               ,
	    orden                 ,
	    ingresomanual         ,
	    tieneAdvertencias     ,
	    ejecuciones           ,
	    ejecucionParalelo     ,
	    ultSecuencialGenerado 
	from operacion..tramiteflujo
	print 'tramite flujo'

	set identity_insert bitacoraetapas on
	insert BitacoraEtapas (
	    corrTramite         ,
	    estado              ,
	    etapa               ,
	    observaciones       ,
	    fecha               ,
	    secuencialGenerado  ,
	    horaInicio          ,
	    correlativo         ,
	    horaFinal           ,
	    correlativoMensaje  ,
	    mensajeErrorSistema ,
	    tieneAdvertencias   ,
	    notaCorta           ,
	    usuario             )
	select     corrTramite         ,
	    estado              ,
	    etapa               ,
	    observaciones       ,
	    fecha               ,
	    secuencialGenerado  ,
	    horaInicio          ,
	    correlativo         ,
	    horaFinal           ,
	    correlativoMensaje  ,
	    mensajeErrorSistema ,
	 tieneAdvertencias   ,
	    notaCorta           ,
	    usuario             
	from operacion..bitacoraetapas
	set identity_insert bitacoraetapas off
	print 'bitacora etapas'

	insert TramitePersonaIndividual (
	    corrTramite       ,
	    corrCliente       ,
	    oficina           ,
	    secuencialBanru   ,
	 idTramite         ,
	    montoSolicitado   ,
	    plazoSolicitado   ,
	    tipoCredito       ,
	    ctaDepMonet       ,
	    ctaAhorro         ,
	    cuotaPrestamo     ,
	    microFinanzas     ,
	    mensajeTramite    ,
	    rolEnSolicitud    ,
	    corrSolicitud     ,
	    tieneAdvertencias )
	select     corrTramite       ,
	    corrCliente       ,
	    oficina           ,
	    secuencialBanru   ,
	    idTramite         ,
	    montoSolicitado   ,
	    plazoSolicitado   ,
	    tipoCredito       ,
	    ctaDepMonet       ,
	    ctaAhorro         ,
	    cuotaPrestamo     ,
	    microFinanzas     ,
	    mensajeTramite    ,
	    rolEnSolicitud    ,
	    corrSolicitud     ,
	    tieneAdvertencias
	from operacion..tramitepersonaindividual
	print 'tramite persona individual'


	insert  TramiteSolicitud (
	    corrSolicitud ,
	    corrTramite   ,
	    nota          ,
	    oficina       ,
	    usuario       ,
	    rowVersion    ,
	    fechaIngreso  ,
	    preautorizado )
	select     corrSolicitud ,
	    corrTramite   ,
	    nota          ,
	    oficina       ,
	    usuario       ,
	    rowVersion    ,
	    fechaIngreso  ,
	    preautorizado 
	from operacion..tramitesolicitud
	print 'tramite solicitud'

	set identity_insert datosmutables on
	insert DatosMutables (
	    corrTramite        ,
	    nombreDato         ,
	    tipoValor          ,
	    valorI             ,
	    valorM             ,
	    secuencialGenerado ,
	    etapa              ,
	    nota               ,
	    correlativo        ,
	    fecha              ,
	    valorIAnterior     ,
	    valorMAnterior     )
	select     corrTramite        ,
	    nombreDato         ,
	    tipoValor          ,
	    valorI             ,
	    valorM             ,
	    secuencialGenerado ,
	    etapa              ,
	    nota               ,
	    correlativo        ,
	    fecha              ,
	    valorIAnterior     ,
	    valorMAnterior     
	from operacion..datosmutables
	set identity_insert datosmutables off
	print 'datos mutables'

/*
	insert BitacoraCambiosEntidad (
	    correlativo        ,
	    entidad            ,
	    etapa              ,
	    fecha              ,
	    usuario            ,
	    rol                ,
	    secuencialGenerado )
	select     correlativo        ,
	    entidad            ,
	    etapa              ,
	    fecha              ,
	    usuario            ,
	    rol                ,
	    secuencialGenerado 
	from operacion..bitacoracambiosentidad
	print 'bitacoracambios entidad'

	insert BitacoraCambiosCampo (
	    correlativo       ,
	    campo             ,
	    tipoValor         ,
	    valorINuevo       ,
	    valorIAnterior    ,
	    valorLNuevo       ,
	    valorLAnterior    ,
	    valorMNuevo       ,
	    valorMAnterior    ,
	    valorANuevo       ,
	    valorAAnterior    ,
	    valorTNuevo       ,
	    valorTAnterior    ,
	    usuario           ,
	    corrEntidadCambio ,
	    valorCAnterior    ,
	    valorCNuevo       )
	select     correlativo       ,
	    campo             ,
	    tipoValor         ,
	    valorINuevo       ,
	    valorIAnterior    ,
	    valorLNuevo       ,
	    valorLAnterior    ,
	    valorMNuevo       ,
	    valorMAnterior    ,
	    valorANuevo       ,
	    valorAAnterior    ,
	    valorTNuevo       ,
	    valorTAnterior    ,
	    usuario           ,
	    corrEntidadCambio ,
	    valorCAnterior    ,
	    valorCNuevo       
	from operacion..bitacoracambioscampo
	print 'bitacoracambioscampo'
*/
	--insert BitacoraMensajes (
	--    secuencial        ,
	-- corrTramite       ,
	--    etapa             ,
	--    fecha             ,
	--    resultado         ,
	--    mensaje           ,
	--    operacion         ,
	--    descripcion       ,
	--    mensajeRespuesta  ,
	--    otrasReferencias1 ,
	--    otrasReferencias2 ,
	--    otrasReferencias3 ,
	--    otrasReferencias4 ,
	--    replyQueue        ,
	--    corrCliente       ,
	--    vigente           ,
	--    signoInvertido    ,
	--    resultadoParseo   ,
	--    otrasReferencias5 ,
	--    otrasReferencias6 )
	--select     secuencial      ,
	--    corrTramite       ,
	--    etapa             ,
	--    fecha             ,
	--    resultado         ,
	--    mensaje           ,
	--    operacion         ,
	--    descripcion       ,
	--    mensajeRespuesta  ,
	--    otrasReferencias1 ,
	--    otrasReferencias2 ,
	--    otrasReferencias3 ,
	--    otrasReferencias4 ,
	--    replyQueue        ,
	--    corrCliente       ,
	--    vigente           ,
	--    signoInvertido    ,
	--    resultadoParseo   ,
	--    otrasReferencias5 ,
	--    otrasReferencias6 
	--from operacion..bitacoramensajes
	--print 'bitacoramensajes'




        
END




GO
/****** Object:  StoredProcedure [dbo].[usp_AP_ClsMsj_ActivadosPorMensaje_Get]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE           PROCEDURE [dbo].[usp_AP_ClsMsj_ActivadosPorMensaje_Get]
	@IdMensaje int = null,
	@IdEstadoClaseProcesoIniciar int,
	@IdEstadoClaseProcesoContinuar int,
	@IdEstadoMensajeCreado int,
	@IdTipoEventoIntermedioMsg int,
	@IdTipoEventoIntermedioCombinado int,
	@IdTipoEventoEnTareaPersonalMsg int,
	@IdTipoEventoEnTareaPersonalCombinado int,
	@IdGeneroEventoMensajeIntermedio int,
	@IdGeneroEventoCombinadoIntermedio int,
	@IdGeneroEventoMensajeEnTareaPersonal int,
	@IdGeneroEventoCombinadoEnTareaPersonal int,
	@IdGeneroEventoMensajeInicio int,
	@IdGeneroEventoCombinadoInicio int,
	@IdEstadoEvIntPendiente int,
	@TipoEventoMsgFormulario int,
	@TipoEventoMsgPatron int,
	@EstadoProcesoIniciado int,
	@TipoAnexoSQL int,
	@TipoCampoListaRegistros int,
	@TipoRegistrosReferencias int,
	@CategoriaEM int,
	@CategoriaEX int,
	@CategoriaTPM int,
	@CategoriaTPX int,
	@TipoBloqueoAsociado int,
	@IdEstadoClaseProcesoDesarrollo int
AS
	DECLARE @PreProcessedDateTreshold as DateTime
	SET @PreProcessedDateTreshold = DATEADD(HOUR, -3, GETUTCDATE())

	SELECT Top(50) Msg.ID as IdMensaje,
		ClsEvMsg.ID,
		ClsEvMsg.IdProcesoAsc,
		Msg.IdProceso as IdProceso,
		ISNULL(EvInt.[ID],0) as IdEventoIntermedio,
		ISNULL(EvInt.TipoEvento, 0) as TipoEvento,
		Msg.IdCreador as IdCreadorMsg,
		ClsEvMsg.TipoDatosFormulario as TipoDatosFormulario,
		ISNULL (ClsEventoCombinado.[ID], 0) as IdClaseEventoCombinado,
		ISNULL(EvInt.IdBloqueoAsc, 0) as IdBloqueoAsc,
		------------ Set priority ------------
		(CASE
			WHEN ClsEvMsg.IdProcesoAsc = 21 THEN 1	-- COB-21.1
			WHEN ClsEvMsg.IdProcesoAsc = 20 THEN 2	-- PTC-14.3
			WHEN ClsEvMsg.IdProcesoAsc = 18 THEN 3	-- SIB-18.1
			WHEN ClsEvMsg.IdProcesoAsc = 19 THEN 3	-- PTC-14.2
			WHEN ClsEvMsg.IdProcesoAsc = 14 THEN 3	-- PTC-14.1
			WHEN ClsEvMsg.IdProcesoAsc = 15 THEN 4	-- -15.1
			WHEN ClsEvMsg.IdProcesoAsc = 10 THEN 4	-- Vul-10.1
			ELSE 5
		END) AS Priority
		---------- End set priority ----------
	FROM AP__BPM_Mensajes Msg WITH(NOLOCK) INNER JOIN
		AP__BPM_EventosMensajeClases ClsEvMsg WITH(NOLOCK)
		 ON 
			(
				(ClsEvMsg.TipoDatosFormulario = @TipoEventoMsgFormulario AND ClsEvMsg.IdFormularioAsc = Msg.IdFormularioAsc)
				 OR
				(ClsEvMsg.TipoDatosFormulario = @TipoEventoMsgPatron AND ClsEvMsg.[ID] = Msg.IdClaseMensaje)
			)
			INNER JOIN
		AP__BPM_ProcesosClases_Objetos Objeto WITH(NOLOCK) ON ClsEvMsg.IdProcesoAsc = Objeto.IdClaseProceso AND ClsEvMsg.CodigoClase = Objeto.CodigoObjeto AND ClsEvMsg.PaginaClase = Objeto.NombrePagina
			INNER JOIN
		AP__BPM_ProcesosClases Pro WITH(NOLOCK) ON Pro.ID = ClsEvMsg.IdProcesoAsc LEFT OUTER JOIN
		AP__BPM_EventoIntermedio EvInt WITH(NOLOCK) ON
			EvInt.IdEstado = @IdEstadoEvIntPendiente and
			EvInt.IdClaseEventoMsg = ClsEvMsg.[ID] and
			EvInt.IdProceso = Msg.IdProceso and
			(
				(ClsEvMsg.IdGeneroAsc = @IdGeneroEventoMensajeIntermedio AND EvInt.TipoEvento = @IdTipoEventoIntermedioMsg)
				OR
				(ClsEvMsg.IdGeneroAsc = @IdGeneroEventoMensajeIntermedio AND EvInt.TipoEvento = @IdTipoEventoIntermedioCombinado)
				OR
				(ClsEvMsg.IdGeneroAsc = @IdGeneroEventoMensajeEnTareaPersonal AND EvInt.TipoEvento = @IdTipoEventoEnTareaPersonalMsg)
				OR
				(ClsEvMsg.IdGeneroAsc = @IdGeneroEventoMensajeEnTareaPersonal AND EvInt.TipoEvento = @IdTipoEventoEnTareaPersonalCombinado)
			) LEFT OUTER JOIN
		AP__BPM_BloqueoProceso Bloqueo WITH(NOLOCK) ON
			(
				(ClsEvMsg.TipoDatosFormulario = @TipoEventoMsgFormulario)
				OR
				(ClsEvMsg.TipoDatosFormulario = @TipoEventoMsgPatron)
			) AND
			Bloqueo.IdElemento = EvInt.[ID] AND
			Bloqueo.IdProceso = EvInt.IdProceso AND
			(
				Bloqueo.CategoriaElemento = @CategoriaEM OR
				Bloqueo.CategoriaElemento = @CategoriaEX OR
				(Bloqueo.CategoriaElemento = @CategoriaTPM AND Bloqueo.TipoBloqueo = @TipoBloqueoAsociado) OR
				(Bloqueo.CategoriaElemento = @CategoriaTPX AND Bloqueo.TipoBloqueo = @TipoBloqueoAsociado)
			) LEFT OUTER JOIN
		AP__BPM_Procesos Proceso WITH(NOLOCK) ON
			Proceso.[ID] = EvInt.IdProceso LEFT OUTER JOIN
		AP__BPM_EventoCombinadoClases ClsEventoCombinado WITH(NOLOCK) ON
			ClsEvMsg.[ID] = ClsEventoCombinado.IdClaseEventoMensajeAsc
	WHERE
		-- Un Id de mensaje o todos
		((@IdMensaje IS NULL) OR (Msg.ID = @IdMensaje)) and

		-- Mensajes creados
		Msg.Estado = @IdEstadoMensajeCreado and
			
		-- Objetos que no están en la papelera
		(Objeto.EnPapelera = 0)	and

		-- Procesos que se pueden iniciar o continuar
		(
			(
				(EvInt.[ID] IS NULL)
				 and
				((Pro.IdEstadoClaseProceso & @IdEstadoClaseProcesoIniciar) <> 0)
				and
				(
					(Pro.IdEstadoClaseProceso <> @IdEstadoClaseProcesoDesarrollo)
					or
					(
						(Pro.IdEstadoClaseProceso = @IdEstadoClaseProcesoDesarrollo)
						and
						(Pro.StartProcess = 1)
					)
				)
			)
			or
			(
				(EvInt.[ID] IS NOT NULL)
				 and
				((Pro.IdEstadoClaseProceso & @IdEstadoClaseProcesoContinuar) <> 0)
				 and
				(Proceso.IdEstado = @EstadoProcesoIniciado)
			)
		) and

		-- Clase de eventos de inicio o intermedios con evento intermedio creado
		(
			-- Clase de evento de inicio de proceso
			ClsEvMsg.IdGeneroAsc = @IdGeneroEventoMensajeInicio
			or

			-- Clase de evento combinado de inicio de proceso
			ClsEvMsg.IdGeneroAsc = @IdGeneroEventoCombinadoInicio
			or			

			-- Clase de evento intermedio
			(
				ClsEvMsg.IdGeneroAsc = @IdGeneroEventoMensajeIntermedio
				and
				Bloqueo.ID is not null
			)

			or
			-- Clase de evento combinado intermedio
			(
				ClsEventoCombinado.IdGeneroAsc = @IdGeneroEventoCombinadoIntermedio
				and
				Bloqueo.ID is not null
			)

			or
			-- Evento incrustado en tarea personal
			(
				ClsEvMsg.IdGeneroAsc = @IdGeneroEventoMensajeEnTareaPersonal
				and
				Bloqueo.ID is not null
			)
			or
			-- Evento combinado incrustado en tarea personal
			(
				ClsEvMsg.IdGeneroAsc = @IdGeneroEventoCombinadoEnTareaPersonal
				and
				Bloqueo.ID is not null
			)
		)

	ORDER BY Priority ASC, IdMensaje ASC




GO
/****** Object:  UserDefinedFunction [dbo].[categoriasRechazo]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[categoriasRechazo](@corrTramite int, @enHistorico char) returns varchar(2048)
AS
begin
    declare @corrSubTramite as int
           ,@estadoSubTramite as char(2)
           ,@strSubTramite as varchar(500)
           ,@esTramiteSolicitud as char(1)
           ,@estadoTramiteSolicitud as char(2)
           ,@substr as varchar(2048)
           ,@str as varchar(2048)
		   ,@observaciones as varchar(2048)
	select @str = ''
    
	if @enHistorico = 'N'
	begin
		--si es un tramite solicitud, y fue rechazado en FORK.
		select @esTramiteSolicitud = v.esTramiteSolicitud 
			 , @estadoTramiteSolicitud = v.estadoOperativo
		from tramiteprocesos v where corrtramite = @corrtramite

		if (@estadoTramiteSolicitud <> 'RE')
		begin    
			return ''
		end
	    
		select @str = @str  +  isnull (lgs.categoria , '')
		from logreglas lr with(nolock)
             inner join logreglasrechazos lgs with(nolock) on lr.correlativo = lgs.corrRegla
 		where lr.corrtramite = @corrtramite
		group by lgs.categoria

		--print 'CATEGORIAS:' + @str + ' CORRTRAMITE:' + convert(varchar, @corrtramite)
	    
		--print @esTramiteSolicitud + ',' +  @estadoTramiteSolicitud

		if (@esTramiteSolicitud = 'S' and @estadoTramiteSolicitud = 'RE')
		begin
			--print 'es tramite solicitud'
			--VERIFICAR SI ESTA RECHAZADO EN FORK.
			if exists(select 1 from tramiteflujo where corrtramite = @corrtramite and etapa = 'FORK' and estatus = 'SP')
			begin
				declare cur_subtramites cursor for
				select tpi.corrtramite, tp.estadoOperativo
				  from tramitepersonaindividual tpi 
				        inner join tramiteprocesos tp on tpi.corrtramite = tp.corrtramite and tp.estadoOperativo = 'RE'
				where tpi.corrsolicitud = @corrtramite
				

				open cur_subtramites

				fetch cur_subtramites into @corrSubtramite, @estadoSubTramite

				while (@@fetch_status = 0)
				begin
					select @substr = dbo.categoriasRechazo(@corrSubtramite, @enHistorico)

					select @str = @str + '[' + convert(varchar, @corrSubtramite) + '][' + @substr + ']' 

					fetch cur_subtramites into @corrSubtramite, @estadoSubTramite
				end

				close cur_subtramites
				deallocate cur_subtramites
			end
		end

		if @str = ''
		begin
			--set rowcount 1
			select top (1)
				 @str = convert(varchar(2048), b.observaciones )
			from bitacoraetapas b
			inner join tramiteflujo tf on (b.corrtramite = tf.corrtramite and b.etapa = tf.etapa and 
                                           b.secuencialGenerado = tf.ultSecuencialGenerado and tf.estatus = 'RE')
			where b.corrtramite = @corrtramite
			--set rowcount 0
		end
	end
	else --buscar en historicos
	begin
		--si es un tramite solicitud, y fue rechazado en FORK.
		select @esTramiteSolicitud = v.esTramiteSolicitud 
			 , @estadoTramiteSolicitud = v.estadoOperativo
		from creditfactoryhis..tramiteprocesos v where corrtramite = @corrtramite

		if (@estadoTramiteSolicitud <> 'RE')
		begin    
			return ''
		end
	    
		select @str = @str  +  isnull (lgs.categoria , '')
		from creditfactoryhis..logreglas lr with(nolock)
			 inner join creditfactoryhis..logreglasrechazos lgs with(nolock) on lr.correlativo = lgs.corrRegla
 		where lr.corrtramite = @corrtramite
		group by lgs.categoria

		--print 'CATEGORIAS:' + @str + ' CORRTRAMITE:' + convert(varchar, @corrtramite)
	    
		--print @esTramiteSolicitud + ',' +  @estadoTramiteSolicitud

		if (@esTramiteSolicitud = 'S' and @estadoTramiteSolicitud = 'RE')
		begin
			--print 'es tramite solicitud'
			--VERIFICAR SI ESTA RECHAZADO EN FORK.
			if exists(select 1 from creditfactoryhis..tramiteflujo where corrtramite = @corrtramite and etapa = 'FORK' and estatus = 'SP')
			begin
				declare cur_subtramites cursor for
				select tpi.corrtramite, tp.estadoOperativo
				from creditfactoryhis..tramitepersonaindividual tpi 
				     inner join creditfactoryhis..tramiteprocesos tp on tpi.corrtramite = tp.corrtramite and tp.estadoOperativo = 'RE'
				where tpi.corrsolicitud = @corrtramite
				  
				open cur_subtramites

				fetch cur_subtramites into @corrSubtramite, @estadoSubTramite

				while (@@fetch_status = 0)
				begin
					select @substr = dbo.categoriasRechazo(@corrSubtramite, @enHistorico)

					select @str = @str + '[' + convert(varchar, @corrSubtramite) + '][' + @substr + ']' 

					fetch cur_subtramites into @corrSubtramite, @estadoSubTramite
				end

				close cur_subtramites
				deallocate cur_subtramites
			end
		end

		if @str = ''
		begin
			--set rowcount 1
			select top (1) @str = convert(varchar(2048), b.observaciones )
			from creditfactoryhis..bitacoraetapas b
			     inner join creditfactoryhis..tramiteflujo tf on (b.corrtramite = tf.corrtramite and b.etapa = tf.etapa
                                                              and b.secuencialGenerado = tf.ultSecuencialGenerado and tf.estatus = 'RE')
			where b.corrtramite = @corrtramite
			--set rowcount 0
		end		
	end
    
    return @str
end



GO
/****** Object:  UserDefinedFunction [dbo].[descripcionOficina]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[descripcionOficina](	@oficina int, @origen varchar(10)) RETURNS varchar(50)
AS
BEGIN
	declare @descripcionAgencia varchar(30)
	if @origen = 'SIPSA'
	begin
		select @descripcionAgencia = ag.nombre_agencia from operacion..agencias ag 
		where ag.cod_agencia = @oficina
		and ag.cod_empresa= 1 
	end
	if @origen = 'PTC'
	begin
        select @descripcionAgencia = ca.descripcion from ptc..ca_oficina ca 
		where ca.codigo = @oficina
	end
	return @descripcionAgencia
END



GO
/****** Object:  UserDefinedFunction [dbo].[fnIndiceBigramas]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fnIndiceBigramas](@string1 varchar(250),@string2 
varchar(250))
returns real
as
BEGIN
declare @tabla1 table (id int, bigrama char(2), comparado bit) declare @tabla2 table (id int, bigrama char(2), comparado bit) declare @limite as integer declare @i as integer declare @j as integer declare @bigrama as char(2) declare @bigramasIguales as integer declare @bigramasPromedio as real declare @bigramas1 as integer declare @bigramas2 as integer

insert into @tabla2 select * from fnObtieneBigramas(@string2) insert into @tabla1 select * from fnObtieneBigramas(@string1) set @bigramasIguales = 0 select @bigramas1 = count(*) from @tabla1 select @bigramas2 = count(*) from @tabla2 set @bigramasPromedio = (@bigramas1 + @bigramas2)/2

set @i = 0
while @i<@bigramasPromedio
begin
  SET @j = -1
  select top 1 @j=t1.id
 from @tabla1 t1,@tabla2 t2  where
   t1.comparado=0
   and t1.bigrama=t2.bigrama
   and t2.id=@i
  if @j >= 0 update @tabla1 set comparado = 1 where id = @j
  set @i = @i + 1
end

select @bigramasIguales = COUNT(*) FROM @TABLA1 WHERE comparado = 1

return @bigramasIguales / @bigramasPromedio




END



GO
/****** Object:  UserDefinedFunction [dbo].[fnObtieneBigramas]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   function [dbo].[fnObtieneBigramas](@string varchar(250))
returns @tabla table (id int, bigram char(2), comparado bit)
as
BEGIN

 declare @i as int
 declare @j as int
 declare @bigrama as char(2)
 declare @limite as int

 set @string = ltrim(rtrim(@string))
 set @i = 1
 set @j = 1
 set @limite = len (@string)

 insert into @tabla values (0,substring(@string,1,1),0)
 while @i <= @limite
 begin
  set @bigrama = substring(@string,@i,2)
  insert into @tabla values (@j,@bigrama,0)
  set @i = @i+1
  set @j = @j+1
  while ascii(substring(@string,@i,1))=32 set @i = @i+1

 end

 return
END



GO
/****** Object:  UserDefinedFunction [dbo].[getIngresoNeto]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getIngresoNeto]
(
	 @i_corrcliente int
	,@i_ingresomensualotr money = null
	,@i_ingresomensualremesas money = null
	,@i_ingresoformulario money = null
	,@enHistorico char(1)
)
RETURNS money
AS
BEGIN
	declare @w_ingresoneto money
	select @w_ingresoneto = 0
	
	if @i_ingresomensualotr is not null 
		select @w_ingresoneto = @w_ingresoneto + @i_ingresomensualotr
	
	if @i_ingresomensualremesas is not null
		if @i_ingresomensualremesas < 4000
			select @w_ingresoneto = @w_ingresoneto + @i_ingresomensualremesas
		else
			select @w_ingresoneto = @w_ingresoneto + 4000

	if @enHistorico = 'N'	
		select @w_ingresoneto = @w_ingresoneto + sum(ingreso)
		from ocupacion
		where corrcliente = @i_corrcliente
	else	
		select @w_ingresoneto = @w_ingresoneto + sum(ingreso)
		from creditfactoryhis..ocupacion
		where corrcliente = @i_corrcliente
		

	if @i_ingresoformulario is not null 
		and @i_ingresoformulario < @w_ingresoneto
			select @w_ingresoneto = @i_ingresoformulario		

	return @w_ingresoneto
END



GO
/****** Object:  UserDefinedFunction [dbo].[ultimaEtapaAprobada]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ultimaEtapaAprobada] (@i_tramite int
, @i_estadoOperativo varchar(5)
, @enHistorico char(1)) RETURNS varchar(10)
AS
BEGIN
	declare @w_etapaaprobada varchar(10)
	select @w_etapaaprobada = ''
	if @i_estadoOperativo = 'AP'
	begin	
		if @enHistorico = 'N'
			select top 1 @w_etapaaprobada = etapa
			from tramiteflujo with(nolock) where corrtramite = @i_tramite
			and estatus = 'AP'
			order by orden desc
		else
			select top 1 @w_etapaaprobada = etapa
			from creditfactoryhis..tramiteflujo with(nolock) where corrtramite = @i_tramite
			and estatus = 'AP'
			order by orden desc			
	end
	return @w_etapaaprobada
END

GO
/****** Object:  Table [dbo].[AFParametros]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AFParametros](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[fechaIngreso] [datetime] NOT NULL,
	[fechaModificacion] [datetime] NULL,
	[Usuario] [varchar](30) NULL,
	[estado] [char](2) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[descripcion] [varchar](255) NULL,
	[categoria] [varchar](50) NULL,
 CONSTRAINT [PK_AFParametros] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AFParametrosValor]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AFParametrosValor](
	[corrParametro] [numeric](18, 0) NOT NULL,
	[valor] [varchar](500) NOT NULL,
	[fechaIngreso] [datetime] NOT NULL,
	[fechaModificacion] [datetime] NULL,
	[Usuario] [varchar](20) NULL,
	[estado] [char](2) NOT NULL,
	[rowVersion] [int] NULL,
	[motivo] [varchar](255) NULL,
 CONSTRAINT [PK_AFParametrosValor] PRIMARY KEY CLUSTERED 
(
	[corrParametro] ASC,
	[valor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ArchivoFormulario]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ArchivoFormulario](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[nombreArchivo] [varchar](255) NOT NULL,
	[texto] [text] NOT NULL,
	[horaInicio] [datetime] NOT NULL,
	[horaUltMod] [datetime] NULL,
	[usuario] [varchar](50) NOT NULL,
	[observacion] [varchar](100) NULL,
	[resultado] [varchar](15) NOT NULL,
	[numlineas] [int] NULL,
 CONSTRAINT [PK_ArchivoFormulario] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ArchivoFormularioDetalle]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ArchivoFormularioDetalle](
	[numLinea] [int] NOT NULL,
	[corrArchivo] [numeric](18, 0) NOT NULL,
	[linea] [varchar](255) NOT NULL,
	[corrTramite] [int] NULL,
	[resultado] [varchar](15) NOT NULL,
	[hora] [datetime] NOT NULL,
	[observacion] [varchar](100) NULL,
	[etapa] [varchar](10) NULL,
 CONSTRAINT [PK_ArchivoFormularioDetalle] PRIMARY KEY CLUSTERED 
(
	[numLinea] ASC,
	[corrArchivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[binesTC]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[binesTC](
	[bin] [varchar](6) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BitacoraCambiosCampo]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[BitacoraCambiosCampo](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campo] [varchar](50) NULL,
	[tipoValor] [varchar](20) NULL,
	[valorINuevo] [int] NULL,
	[valorIAnterior] [int] NULL,
	[valorLNuevo] [numeric](18, 0) NULL,
	[valorLAnterior] [numeric](18, 0) NULL,
	[valorMNuevo] [money] NULL,
	[valorMAnterior] [money] NULL,
	[valorANuevo] [varchar](1024) NULL,
	[valorAAnterior] [varchar](1024) NULL,
	[valorTNuevo] [text] NULL,
	[valorTAnterior] [text] NULL,
	[usuario] [varchar](20) NOT NULL,
	[corrEntidadCambio] [numeric](18, 0) NOT NULL,
	[valorCAnterior] [datetime] NULL,
	[valorCNuevo] [datetime] NULL,
 CONSTRAINT [PK_BitacoraCambiosCampo] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BitacoraCambiosEntidad]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[BitacoraCambiosEntidad](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[entidad] [varchar](50) NOT NULL,
	[etapa] [varchar](10) NULL,
	[fecha] [datetime] NOT NULL,
	[usuario] [varchar](50) NOT NULL,
	[rol] [int] NOT NULL,
	[secuencialGenerado] [numeric](18, 0) NULL,
 CONSTRAINT [PK_BitacoraCambiosEntidad] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BitacoraCuestionario]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BitacoraCuestionario](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[corrCuestionario] [numeric](18, 0) NOT NULL,
	[resultadoAprobacionTotal] [char](2) NOT NULL,
	[observacionResultadoAprobacionTotal] [varchar](255) NOT NULL,
	[formularioTO] [text] NULL,
	[fecha] [datetime] NOT NULL,
	[usuario] [varchar](50) NOT NULL,
 CONSTRAINT [PK_BitacoraCuestionario] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BitacoraEtapas]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[BitacoraEtapas](
	[corrTramite] [numeric](18, 0) NOT NULL,
	[estado] [char](2) NOT NULL,
	[etapa] [varchar](5) NOT NULL,
	[observaciones] [text] NULL,
	[fecha] [datetime] NULL,
	[secuencialGenerado] [numeric](18, 0) NOT NULL,
	[horaInicio] [datetime] NULL,
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[horaFinal] [datetime] NULL,
	[correlativoMensaje] [numeric](18, 0) NULL,
	[mensajeErrorSistema] [text] NULL,
	[tieneAdvertencias] [char](1) NULL,
	[notaCorta] [varchar](255) NULL,
	[usuario] [varchar](50) NULL,
 CONSTRAINT [PK_BitacoraEtapas_1] PRIMARY KEY CLUSTERED 
(
	[corrTramite] ASC,
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BitacoraMensajes]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[BitacoraMensajes](
	[secuencial] [numeric](18, 0) NOT NULL,
	[corrTramite] [numeric](18, 0) NULL,
	[etapa] [varchar](5) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[mensaje] [text] NULL,
	[operacion] [char](2) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[mensajeRespuesta] [text] NULL,
	[otrasReferencias1] [varchar](50) NULL,
	[otrasReferencias2] [varchar](50) NULL,
	[otrasReferencias3] [varchar](50) NULL,
	[otrasReferencias4] [varchar](50) NULL,
	[replyQueue] [varchar](100) NULL,
	[corrCliente] [numeric](18, 0) NULL,
	[vigente] [char](1) NULL,
	[signoInvertido] [char](1) NULL,
	[resultadoParseo] [char](2) NULL,
	[otrasReferencias5] [varchar](50) NULL,
	[otrasReferencias6] [varchar](50) NULL,
 CONSTRAINT [PK_BitacoraMensajes] PRIMARY KEY CLUSTERED 
(
	[secuencial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BitacoraTrasladoTramites]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BitacoraTrasladoTramites](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[corrTramite] [numeric](18, 0) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[operacion] [varchar](50) NOT NULL,
	[tiempoTranscurrido] [int] NULL,
	[registrosMigrados] [int] NULL,
 CONSTRAINT [PK_BitacoraTrasladoTramites] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Carga Lista Negra Noviembre]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Carga Lista Negra Noviembre](
	[No ] [varchar](50) NULL,
	[PRIMER NOMBRE] [varchar](50) NULL,
	[SEGUNDO NOMBRE] [varchar](50) NULL,
	[TERCER NOMBRE] [varchar](50) NULL,
	[PRIMER APELLIDO] [varchar](50) NULL,
	[SEGUNDO APELLIDO] [varchar](50) NULL,
	[TERCER APELLIDO] [varchar](50) NULL,
	[CEDULA  DPI] [varchar](50) NULL,
	[MOTIVO] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[origenIngresos] [int] NULL,
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[primerNombre] [varchar](100) NOT NULL,
	[primerApellido] [varchar](100) NOT NULL,
	[segundoNombre] [varchar](100) NULL,
	[segundoApellido] [varchar](100) NULL,
	[usuario] [varchar](50) NOT NULL,
	[fechaIngreso] [datetime] NOT NULL,
	[fechaModificacion] [datetime] NULL,
	[fechaNacimiento] [datetime] NULL,
	[fechaFallecimiento] [datetime] NULL,
	[estado] [char](2) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[apellidoCasada] [varchar](50) NULL,
	[paisOrigen] [varchar](20) NULL,
	[profesion] [varchar](32) NULL,
	[sexo] [varchar](20) NULL,
	[estadoCivil] [varchar](20) NULL,
	[numDependientes] [int] NULL,
	[NIT] [varchar](20) NULL,
	[MIS] [int] NULL,
	[carnetIGSS] [varchar](20) NULL,
	[puestoDesempeñado] [varchar](50) NULL,
	[ingresoMensualOtr] [money] NULL,
	[nIngresoMensualOtr] [int] NULL,
	[egresoMensual] [money] NULL,
	[nacionalidad] [varchar](50) NULL,
	[tieneNegocioPropio] [char](1) NULL,
	[poseeVehiculo] [char](1) NULL,
	[tercerNombre] [varchar](50) NULL,
	[ingresoMensualRemesas] [money] NULL,
	[tieneTramitesRechazados] [char](1) NULL,
	[ultimoTramiteRechazado] [int] NULL,
	[tipoDocId] [varchar](20) NULL,
	[numDocId] [varchar](50) NULL,
	[lugarDocId] [varchar](50) NULL,
	[ingresoFormulario] [money] NULL,
	[corrFormularioAsociado] [int] NULL,
	[esJubilado] [char](1) NULL,
	[clasificacion] [varchar](10) NULL,
	[cedulaOrden] [varchar](5) NULL,
	[cedulaRegistro] [varchar](15) NULL,
	[primerNombreStd] [varchar](50) NULL,
	[segundoNombreStd] [varchar](50) NULL,
	[primerApellidoStd] [varchar](50) NULL,
	[segundoApellidoStd] [varchar](50) NULL,
	[montoDeudaAcumulada] [money] NULL,
	[montoCuotaAcumulada] [money] NULL,
	[etapaFormularioAsociado] [varchar](10) NULL,
	[cui] [varchar](20) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClienteSolicitud]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClienteSolicitud](
	[corrSolicitud] [numeric](18, 0) NOT NULL,
	[corrCliente] [numeric](18, 0) NOT NULL,
	[rolEnSolicitud] [varchar](20) NOT NULL,
	[fecha] [datetime] NULL,
	[relaciontarjetahabiente] [varchar](50) NULL,
 CONSTRAINT [PK_ClienteSolicitud] PRIMARY KEY CLUSTERED 
(
	[corrSolicitud] ASC,
	[corrCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CondicionManual]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CondicionManual](
	[fecha] [datetime] NOT NULL,
	[usuario] [varchar](50) NOT NULL,
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[corrTramite] [numeric](18, 0) NOT NULL,
	[etapa] [varchar](5) NOT NULL,
	[mensajeSistema] [varchar](256) NULL,
 CONSTRAINT [PK_CondicionManual_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CondicionManualDetalle]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CondicionManualDetalle](
	[corrCondicion] [numeric](18, 0) NOT NULL,
	[nombreCampo] [varchar](30) NOT NULL,
	[valor] [varchar](2048) NULL,
	[tipo] [varchar](50) NULL,
	[tituloCampo] [varchar](50) NULL,
 CONSTRAINT [PK_CondicionManualDetalle] PRIMARY KEY CLUSTERED 
(
	[corrCondicion] ASC,
	[nombreCampo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ConfiguracionValidacionTO]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ConfiguracionValidacionTO](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[claseTO] [varchar](100) NOT NULL,
	[origen] [varchar](5) NOT NULL,
	[producto] [varchar](5) NOT NULL,
	[usuarioIngresa] [varchar](45) NULL,
	[fechaIngreso] [date] NULL,
	[usuarioModifica] [varchar](45) NULL,
	[fechaModifica] [date] NULL,
 CONSTRAINT [PK_ConfiguracionValidacionTO] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CreditosPersona]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CreditosPersona](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[corrPersona] [numeric](18, 0) NOT NULL,
	[nombreInstitucion] [varchar](30) NULL,
	[fechaIngreso] [datetime] NOT NULL,
	[fechaCancelacion] [datetime] NULL,
	[fechaInicio] [datetime] NULL,
	[estado] [varchar](10) NOT NULL,
	[saldo] [money] NULL,
	[cuota] [money] NULL,
	[etapa] [varchar](10) NULL,
	[secuencialGenerado] [numeric](18, 0) NULL,
	[fechaUltMod] [datetime] NULL,
	[tasaInteres] [money] NULL,
	[corrTramite] [numeric](18, 0) NULL,
	[rol] [varchar](20) NULL,
 CONSTRAINT [PK_CreditosPersona] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CuestionarioAsociado]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CuestionarioAsociado](
	[corrCuestionario] [numeric](18, 0) NOT NULL,
	[corrCuestionarioPersona] [numeric](18, 0) NOT NULL,
	[fecha] [datetime] NULL,
	[enHistorico] [varchar](1) NOT NULL,
 CONSTRAINT [PK_CuestionarioAsociado] PRIMARY KEY CLUSTERED 
(
	[corrCuestionario] ASC,
	[corrCuestionarioPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CuestionarioTramite]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CuestionarioTramite](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[corrTramite] [numeric](18, 0) NOT NULL,
	[etapa] [varchar](10) NOT NULL,
	[secuencialGenerado] [numeric](18, 0) NOT NULL,
	[fechaIngreso] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[resultadoAprobacionTotal] [char](2) NULL,
	[documentacionIncluida] [char](1) NOT NULL,
	[documentacionPorSolicitud] [char](1) NULL,
	[documentacionPorPersona] [char](1) NULL,
	[observacionResultadoAprobacionTotal] [varchar](255) NULL,
	[corrSolicitud] [int] NULL,
	[nota] [text] NULL,
	[url] [varchar](255) NULL,
	[personaAsignada] [varchar](50) NULL,
	[usuario] [varchar](50) NULL,
	[formularioInvalidado] [char](1) NULL,
 CONSTRAINT [PK_CuestionarioTramite_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CuestionarioTramitePersona]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CuestionarioTramitePersona](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[corrCliente] [numeric](18, 0) NOT NULL,
	[fechaIngreso] [datetime] NOT NULL,
	[fechaUltModificacion] [datetime] NULL,
	[motivoRechazo] [text] NULL,
	[corrPrincipal] [numeric](18, 0) NULL,
	[nota] [text] NULL,
	[rol] [varchar](50) NULL,
	[preguntaCorrrelacionada] [numeric](18, 0) NULL,
 CONSTRAINT [PK_CuestionarioTramite] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CuestionarioTramitePreguntas]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CuestionarioTramitePreguntas](
	[corrCuestionario] [numeric](18, 0) NOT NULL,
	[pregunta] [varchar](255) NOT NULL,
	[estado] [char](2) NOT NULL,
	[correlativo] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[respuestaAbierta] [varchar](255) NULL,
	[esPreguntaCerrada] [char](1) NULL,
	[esPreguntaAbierta] [char](1) NULL,
	[esObligatoria] [char](1) NULL,
	[tipoDatoPregunta] [varchar](20) NULL,
	[esExcluyente] [char](1) NULL,
	[esSubTitulo] [char](1) NULL,
	[esNota] [char](1) NULL,
	[campoBaseTO] [varchar](50) NULL,
 CONSTRAINT [PK_CuestionarioTramitePreguntas] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CuestionarioTramiteRespuestas]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CuestionarioTramiteRespuestas](
	[corrPregunta] [numeric](10, 0) NOT NULL,
	[respuestaCerrada] [varchar](255) NULL,
	[secuencial] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[seleccionada] [char](1) NULL,
 CONSTRAINT [PK_CuestionarioTramiteRespuestas] PRIMARY KEY CLUSTERED 
(
	[corrPregunta] ASC,
	[secuencial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DatosMutables]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DatosMutables](
	[corrTramite] [numeric](18, 0) NOT NULL,
	[nombreDato] [varchar](50) NOT NULL,
	[tipoValor] [char](1) NOT NULL,
	[valorI] [int] NULL,
	[valorM] [money] NULL,
	[secuencialGenerado] [numeric](18, 0) NOT NULL,
	[etapa] [varchar](50) NULL,
	[nota] [varchar](250) NULL,
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NULL,
	[valorIAnterior] [int] NULL,
	[valorMAnterior] [int] NULL,
 CONSTRAINT [PK_DatosMutables] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetalleTabla]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetalleTabla](
	[tabla] [numeric](18, 0) NOT NULL,
	[codigo] [varchar](10) NOT NULL,
	[descripcion] [varchar](64) NULL,
	[fecha] [datetime] NULL,
 CONSTRAINT [PK_DETALLETABLA] PRIMARY KEY CLUSTERED 
(
	[tabla] ASC,
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Direccion]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Direccion](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[municipio] [varchar](50) NULL,
	[pais] [varchar](50) NULL,
	[departamento] [varchar](50) NULL,
	[rowVersion] [int] NOT NULL,
	[calle] [varchar](50) NULL,
	[avenida] [varchar](50) NULL,
	[numeroCasa] [int] NULL,
	[colonia] [varchar](50) NULL,
	[sector] [varchar](50) NULL,
	[manzana] [varchar](50) NULL,
	[zona] [int] NULL,
	[ciudad] [varchar](50) NULL,
	[cuotaAlquiler] [money] NULL,
	[tipoVivienda] [varchar](20) NULL,
	[tiempoResidencia] [int] NULL,
	[fechaModificacion] [datetime] NULL,
	[fechaIngreso] [datetime] NULL,
	[fechaInicio] [datetime] NULL,
	[aldea] [varchar](50) NULL,
	[otroDato] [varchar](255) NULL,
 CONSTRAINT [PK_Direccion] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentosAdjuntos]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DocumentosAdjuntos](
	[corrSolicitud] [numeric](18, 0) NOT NULL,
	[tipoDoc] [varchar](10) NOT NULL,
	[descripcionDoc] [varchar](50) NULL,
	[imagen] [image] NOT NULL,
	[corrCliente] [int] NOT NULL,
	[observaciones] [text] NULL,
	[estado] [char](2) NOT NULL,
	[etapa] [varchar](5) NULL,
 CONSTRAINT [PK_DocumentosAdjuntos] PRIMARY KEY CLUSTERED 
(
	[corrSolicitud] ASC,
	[tipoDoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empresa](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[nombreComercial] [varchar](100) NOT NULL,
	[sectorEconomico] [varchar](50) NULL,
	[nombreRepresentanteLegal] [varchar](100) NULL,
	[fechaCreacion] [datetime] NOT NULL,
	[corrDireccion] [numeric](18, 0) NULL,
	[fechaCierre] [datetime] NULL,
	[razonSocial] [varchar](20) NULL,
	[descripcionNegocio] [varchar](255) NULL,
	[numPatente] [varchar](50) NULL,
	[NIT] [varchar](20) NULL,
	[fechaInicioOperaciones] [datetime] NULL,
	[actividadEconomica] [varchar](50) NULL,
 CONSTRAINT [PK_Empresa] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmpresaDireccion]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpresaDireccion](
	[corrEmpresa] [numeric](18, 0) NOT NULL,
	[corrDireccion] [nchar](10) NOT NULL,
 CONSTRAINT [PK_EmpresaDireccion] PRIMARY KEY CLUSTERED 
(
	[corrEmpresa] ASC,
	[corrDireccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmpresaSolicitud]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpresaSolicitud](
	[corrEmpresa] [numeric](18, 0) NOT NULL,
	[corrSolicitud] [numeric](18, 0) NOT NULL,
	[fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_EmpresaSolicitud] PRIMARY KEY CLUSTERED 
(
	[corrEmpresa] ASC,
	[corrSolicitud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmpresaTelefono]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpresaTelefono](
	[corrEmpresa] [numeric](18, 0) NOT NULL,
	[corrTelefono] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_EmpresaTelefono] PRIMARY KEY CLUSTERED 
(
	[corrEmpresa] ASC,
	[corrTelefono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[formulario]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[formulario](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](45) NOT NULL,
	[etapa] [varchar](5) NOT NULL,
	[fechaIngreso] [date] NOT NULL,
	[usuarioIngreso] [varchar](50) NOT NULL,
	[tipoProducto] [varchar](5) NULL,
	[origen] [varchar](5) NULL,
	[rolPersona] [varchar](20) NULL,
	[relacionLaboral] [varchar](30) NULL,
 CONSTRAINT [PK_formulario] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HILOSEQUENCES]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[HILOSEQUENCES](
	[SEQUENCENAME] [varchar](50) NOT NULL,
	[HIGHVALUES] [int] NOT NULL,
 CONSTRAINT [hilo_pk] PRIMARY KEY CLUSTERED 
(
	[SEQUENCENAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[JMS_MESSAGES]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[JMS_MESSAGES](
	[MESSAGEID] [int] NOT NULL,
	[DESTINATION] [varchar](150) NOT NULL,
	[TXID] [int] NULL,
	[TXOP] [char](1) NULL,
	[MESSAGEBLOB] [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[JMS_ROLES]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[JMS_ROLES](
	[ROLEID] [varchar](32) NOT NULL,
	[USERID] [varchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[USERID] ASC,
	[ROLEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[JMS_SUBSCRIPTIONS]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[JMS_SUBSCRIPTIONS](
	[CLIENTID] [varchar](128) NOT NULL,
	[SUBNAME] [varchar](128) NOT NULL,
	[TOPIC] [varchar](255) NOT NULL,
	[SELECTOR] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[CLIENTID] ASC,
	[SUBNAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[JMS_TRANSACTIONS]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JMS_TRANSACTIONS](
	[TXID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TXID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JMS_USERS]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[JMS_USERS](
	[USERID] [varchar](32) NOT NULL,
	[PASSWD] [varchar](32) NOT NULL,
	[CLIENTID] [varchar](128) NULL,
PRIMARY KEY CLUSTERED 
(
	[USERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ListaNegra]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ListaNegra](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[primerNombre] [varchar](50) NOT NULL,
	[primerApellido] [varchar](50) NOT NULL,
	[numeroId] [varchar](64) NOT NULL,
	[motivo] [varchar](255) NULL,
	[usuario] [varchar](20) NULL,
	[fechaIngreso] [datetime] NOT NULL,
	[fechaModificacion] [datetime] NULL,
	[estado] [char](2) NOT NULL,
	[segundoNombre] [varchar](50) NULL,
	[segundoApellido] [varchar](50) NULL,
	[tercerNombre] [varchar](50) NULL,
	[tercerApellido] [varchar](50) NULL,
	[tipoid] [int] NULL,
	[rowversion] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[logines]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[logines](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[login] [varchar](50) NOT NULL,
	[fechaIngreso] [datetime] NOT NULL,
	[estado] [char](2) NOT NULL,
	[fechaModificacion] [datetime] NULL,
 CONSTRAINT [PK_logines] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[loginRol]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loginRol](
	[corrLogin] [numeric](18, 0) NOT NULL,
	[corrRol] [numeric](18, 0) NOT NULL,
	[fecha] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LogReglas]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogReglas](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[corrTramite] [numeric](18, 0) NULL,
	[etapa] [char](5) NOT NULL,
	[estado] [char](2) NOT NULL,
	[fecha] [datetime] NULL,
	[secuencialGenerado] [numeric](18, 0) NULL,
	[nota] [varchar](255) NULL,
	[ruleTO] [text] NULL,
	[tieneAdvertencias] [char](1) NULL,
 CONSTRAINT [PK_LogReglas] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[logreglasaceptadas]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[logreglasaceptadas](
	[corrRegla] [numeric](18, 0) NOT NULL,
	[campo] [varchar](20) NULL,
	[valor] [varchar](64) NULL,
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[motivo] [varchar](255) NULL,
	[advertencia] [char](1) NULL,
	[procesoManual] [char](1) NULL,
 CONSTRAINT [PK_logreglasaceptadas] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LogReglasRechazos]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogReglasRechazos](
	[corrRegla] [numeric](18, 0) NOT NULL,
	[campo] [varchar](20) NULL,
	[condicion] [varchar](100) NULL,
	[motivo] [varchar](255) NOT NULL,
	[correlativo] [numeric](18, 0) IDENTITY(100,1) NOT NULL,
	[valor] [varchar](50) NULL,
	[categoria] [varchar](50) NULL,
 CONSTRAINT [PK_LogReglasRechazos] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MediosContacto]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MediosContacto](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[valor] [varchar](50) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[fechaIngreso] [datetime] NOT NULL,
	[fechaUltModif] [datetime] NULL,
	[tipoMedio] [varchar](20) NOT NULL,
 CONSTRAINT [PK_MediosContacto] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ocupacion]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ocupacion](
	[corrCliente] [numeric](18, 0) NOT NULL,
	[tipoRelacionLaboral] [varchar](20) NOT NULL,
	[ingreso] [money] NOT NULL,
	[fechaIngreso] [datetime] NOT NULL,
	[correoTrabajo] [varchar](50) NULL,
	[fechaInicioLabores] [datetime] NULL,
	[bonificacion] [money] NULL,
	[salarioBase] [money] NULL,
	[corrEmpresa] [numeric](18, 0) NULL,
	[actividadEconomica] [varchar](50) NULL,
	[sectorEconomico] [varchar](50) NULL,
	[fechaFinTrabajo] [datetime] NULL,
	[puestoDesempeniado] [varchar](100) NULL,
	[nombreJefeInmediato] [varchar](50) NULL,
	[cedulaJefeInmediato] [varchar](50) NULL,
	[fechaUltModif] [datetime] NULL,
	[esOcupacionPrincipal] [char](1) NULL,
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Ocupacion] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OFCEntes]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OFCEntes](
	[nombre] [varchar](255) NOT NULL,
	[apellido] [varchar](255) NOT NULL,
	[tipo] [char](2) NULL,
	[pais] [varchar](32) NULL,
	[direccion] [varchar](255) NULL,
	[ciudad] [varchar](32) NULL,
	[uid] [int] NOT NULL,
 CONSTRAINT [PK_OFCEntes] PRIMARY KEY CLUSTERED 
(
	[uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OFCEntesAlias]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OFCEntesAlias](
	[uid] [int] NOT NULL,
	[uidEnte] [int] NOT NULL,
	[categoria] [varchar](10) NOT NULL,
	[nombre] [varchar](255) NOT NULL,
 CONSTRAINT [PK_OFCEntesAlias] PRIMARY KEY CLUSTERED 
(
	[uid] ASC,
	[uidEnte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OtrasCuentas]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OtrasCuentas](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[corrSolicitud] [numeric](18, 0) NOT NULL,
	[empresaEmisora] [varchar](50) NOT NULL,
	[numeroTarjeta] [varchar](20) NOT NULL,
	[limiteAutorizado] [money] NOT NULL,
	[fechaVencimiento] [datetime] NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_OtrasTarjetas] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC,
	[corrSolicitud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonaDireccion]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PersonaDireccion](
	[corrDireccion] [numeric](18, 0) NOT NULL,
	[corrCliente] [numeric](18, 0) NOT NULL,
	[tipoRelacion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PersonaDireccion] PRIMARY KEY CLUSTERED 
(
	[corrDireccion] ASC,
	[corrCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonaTelefono]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonaTelefono](
	[corrCliente] [numeric](18, 0) NOT NULL,
	[corrTelefono] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_PersonaTelefono] PRIMARY KEY CLUSTERED 
(
	[corrCliente] ASC,
	[corrTelefono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[preguntas]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[preguntas](
	[correlativo] [int] NOT NULL,
	[idFormulario] [int] NOT NULL,
	[texto] [varchar](100) NOT NULL,
	[tipoDato] [varchar](10) NOT NULL,
	[cerrada] [char](1) NOT NULL,
	[esSubtitulo] [char](1) NOT NULL,
	[respuestaBinaria] [char](1) NOT NULL,
	[obligatoria] [char](1) NOT NULL,
	[campoBaseTO] [varchar](200) NULL,
 CONSTRAINT [PK_preguntas_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[respuesta]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[respuesta](
	[idPregunta] [int] NOT NULL,
	[texto] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[resultado_formulario]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[resultado_formulario](
	[idFormulario] [int] NOT NULL,
	[valor] [varchar](10) NOT NULL,
	[fechaIngreso] [date] NULL,
	[usuarioIngreso] [varchar](50) NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_resultado_formulario_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[resultado_formulario_detalle]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[resultado_formulario_detalle](
	[idResultado] [int] NOT NULL,
	[valor] [varchar](10) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_resultado_formulario_detalle] PRIMARY KEY CLUSTERED 
(
	[idResultado] ASC,
	[valor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[rol]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[rol](
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[descripcion] [varchar](255) NULL,
	[fechaCreacion] [datetime] NOT NULL,
	[estado] [char](2) NOT NULL,
	[fechaModificacion] [datetime] NULL,
 CONSTRAINT [PK_rol] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Servicio]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Servicio](
	[codigo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[identificador] [varchar](255) NOT NULL,
	[fechaIng] [datetime] NULL,
	[usuario] [varchar](50) NULL,
	[rowVersion] [int] NOT NULL,
	[fechaMod] [datetime] NULL,
 CONSTRAINT [PK_Servicio] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServicioParametros]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ServicioParametros](
	[codigoServicio] [numeric](18, 0) NOT NULL,
	[parametro] [varchar](50) NOT NULL,
	[valorStr] [varchar](255) NULL,
	[valorInt] [int] NULL,
	[fechaIng] [datetime] NULL,
	[fechaMod] [datetime] NULL,
	[rowVersion] [int] NULL,
 CONSTRAINT [PK_ServicioParametros] PRIMARY KEY CLUSTERED 
(
	[codigoServicio] ASC,
	[parametro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Solicitud]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Solicitud](
	[tipoSolicitud] [varchar](5) NULL,
	[codigoVendedor] [int] NULL,
	[correlativo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[fechaIngreso] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[oficina] [int] NULL,
	[rowVersion] [int] NULL,
	[tipoTarjeta] [varchar](10) NULL,
	[producto] [varchar](10) NULL,
	[empresaOrigen] [varchar](32) NULL,
	[campaña] [varchar](32) NULL,
	[promocion] [varchar](32) NULL,
	[emisionAsignada] [varchar](20) NULL,
	[corrDireccion] [numeric](18, 0) NULL,
	[corrClienteSolicitante] [numeric](18, 0) NULL,
	[corrClienteConyugue] [numeric](18, 0) NULL,
	[montoCredito] [money] NULL,
	[origen] [varchar](10) NULL,
	[plazoSolicitado] [int] NULL,
	[tieneCtaMonetaria] [char](1) NULL,
	[tieneCtaAhorro] [char](1) NULL,
	[cuotaPrestamo] [money] NULL,
	[microfinanzas] [char](1) NULL,
	[descripcionPrestamo] [varchar](50) NULL,
	[correoANotificar] [varchar](50) NULL,
	[correlativoExterno] [int] NULL,
	[ingresoMinimoGeneral] [money] NULL,
	[numCredito] [varchar](20) NULL,
	[periodicidadCuotas] [varchar](10) NULL,
	[fiadoresObligatorios] [char](1) NULL,
	[categoriaProducto] [varchar](10) NULL,
	[destinoProducto] [varchar](250) NULL,
	[afiliado] [varchar](50) NULL,
	[nombreOficina] [varchar](100) NULL,
	[tasa] [decimal](18, 0) NULL,
	[capturaCanal] [varchar](20) NULL,
	[reestructuracion] [char](1) NULL,
	[atributos] [numeric](18, 0) NULL,
	[descripcionVendedor] [varchar](100) NULL,
	[corrClienteExterno] [int] NULL,
 CONSTRAINT [PK_Solicitud] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tabla]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tabla](
	[codigo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](20) NULL,
	[descripcion] [varchar](64) NULL,
	[estado] [char](2) NULL,
	[fecha] [datetime] NULL,
 CONSTRAINT [PK_TABLA] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TemporalClientesFabrica]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TemporalClientesFabrica](
	[corrTramite] [numeric](18, 0) NOT NULL,
	[origenIngresos] [int] NULL,
	[correlativo] [numeric](18, 0) NOT NULL,
	[primerNombre] [varchar](100) NOT NULL,
	[primerApellido] [varchar](100) NOT NULL,
	[segundoNombre] [varchar](100) NULL,
	[segundoApellido] [varchar](100) NULL,
	[usuario] [varchar](50) NOT NULL,
	[fechaIngreso] [datetime] NOT NULL,
	[fechaModificacion] [datetime] NULL,
	[fechaNacimiento] [datetime] NULL,
	[fechaFallecimiento] [datetime] NULL,
	[estado] [char](2) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[apellidoCasada] [varchar](50) NULL,
	[paisOrigen] [varchar](20) NULL,
	[profesion] [varchar](32) NULL,
	[sexo] [varchar](20) NULL,
	[estadoCivil] [varchar](20) NULL,
	[numDependientes] [int] NULL,
	[NIT] [varchar](20) NULL,
	[MIS] [int] NULL,
	[carnetIGSS] [varchar](20) NULL,
	[puestoDesempeñado] [varchar](50) NULL,
	[ingresoMensualOtr] [money] NULL,
	[nIngresoMensualOtr] [int] NULL,
	[egresoMensual] [money] NULL,
	[nacionalidad] [varchar](50) NULL,
	[tieneNegocioPropio] [char](1) NULL,
	[poseeVehiculo] [char](1) NULL,
	[tercerNombre] [varchar](50) NULL,
	[ingresoMensualRemesas] [money] NULL,
	[tieneTramitesRechazados] [char](1) NULL,
	[ultimoTramiteRechazado] [int] NULL,
	[tipoDocId] [varchar](20) NULL,
	[numDocId] [varchar](50) NULL,
	[lugarDocId] [varchar](50) NULL,
	[ingresoFormulario] [money] NULL,
	[corrFormularioAsociado] [int] NULL,
	[esJubilado] [char](1) NULL,
	[clasificacion] [varchar](10) NULL,
	[cedulaOrden] [varchar](5) NULL,
	[cedulaRegistro] [varchar](15) NULL,
	[primerNombreStd] [varchar](50) NULL,
	[segundoNombreStd] [varchar](50) NULL,
	[primerApellidoStd] [varchar](50) NULL,
	[segundoApellidoStd] [varchar](50) NULL,
	[montoDeudaAcumulada] [money] NULL,
	[montoCuotaAcumulada] [money] NULL,
	[etapaFormularioAsociado] [varchar](10) NULL,
	[cui] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TOPath]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TOPath](
	[idTO] [int] NOT NULL,
	[path] [varchar](200) NOT NULL,
	[opcional] [char](1) NOT NULL,
	[titulo] [varchar](45) NULL,
 CONSTRAINT [PK_TOPath] PRIMARY KEY CLUSTERED 
(
	[idTO] ASC,
	[path] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TramiteDinamico]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TramiteDinamico](
	[corrSolicitud] [numeric](18, 0) NOT NULL,
	[corrTramite] [numeric](18, 0) NOT NULL,
	[fecha] [date] NOT NULL,
	[origen] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TramiteFlujo]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TramiteFlujo](
	[etapa] [varchar](5) NOT NULL,
	[corrTramite] [numeric](18, 0) NOT NULL,
	[fechaCreacion] [datetime] NOT NULL,
	[estatus] [char](2) NULL,
	[orden] [int] NOT NULL,
	[ingresomanual] [char](1) NULL,
	[tieneAdvertencias] [char](1) NULL,
	[ejecuciones] [int] NULL,
	[ejecucionParalelo] [char](1) NULL,
	[ultSecuencialGenerado] [int] NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[TramiteFlujo] ADD [aprobacionforzada] [char](1) NULL
ALTER TABLE [dbo].[TramiteFlujo] ADD [comportamiento] [int] NOT NULL
 CONSTRAINT [PK_SolicitudFlujo] PRIMARY KEY CLUSTERED 
(
	[etapa] ASC,
	[corrTramite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TramitePersonaIndividual]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TramitePersonaIndividual](
	[corrTramite] [numeric](18, 0) NOT NULL,
	[corrCliente] [numeric](18, 0) NOT NULL,
	[oficina] [int] NOT NULL,
	[secuencialBanru] [int] NULL,
	[idTramite] [int] NOT NULL,
	[montoSolicitado] [money] NULL,
	[plazoSolicitado] [int] NULL,
	[tipoCredito] [int] NULL,
	[ctaDepMonet] [char](2) NULL,
	[ctaAhorro] [char](2) NULL,
	[cuotaPrestamo] [money] NULL,
	[microFinanzas] [char](5) NULL,
	[mensajeTramite] [text] NULL,
	[rolEnSolicitud] [varchar](20) NULL,
	[corrSolicitud] [int] NULL,
	[tieneAdvertencias] [char](1) NULL,
 CONSTRAINT [PK_TramitePersonaIndividual] PRIMARY KEY CLUSTERED 
(
	[corrTramite] ASC,
	[corrCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TramiteProcesos]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TramiteProcesos](
	[corrTramite] [numeric](18, 0) IDENTITY(231000,1) NOT NULL,
	[fechaIngreso] [datetime] NOT NULL,
	[fechaUltModif] [datetime] NULL,
	[estadoOperativo] [char](2) NULL,
	[esTramitePersona] [char](1) NULL,
	[esTramiteSolicitud] [char](1) NULL,
	[rowVersion] [int] NOT NULL,
	[tieneAdvertencias] [char](1) NULL,
	[origen] [varchar](20) NULL,
	[codigoFlujo] [varchar](10) NULL,
	[producto] [varchar](10) NULL,
	[forzamientoHabilitado] [char](1) NULL,
	[estadoProceso] [char](2) NULL,
	[montoAcumulado] [money] NULL,
	[montoActual] [money] NULL,
	[cuotaAcumulada] [money] NULL,
	[cuotaActual] [money] NULL,
	[actualizarMonto] [char](1) NULL,
	[actualizarCuota] [char](1) NULL,
	[preautorizacion] [char](1) NULL,
	[corrPreautorizacion] [int] NULL,
	[corrLote] [int] NULL,
	[categoriaProducto] [varchar](50) NULL,
	[destinoProducto] [varchar](50) NULL,
	[codigoVendedor] [int] NULL,
	[tasaInteres] [decimal](18, 0) NULL,
	[plazo] [int] NULL,
	[plazoActual] [int] NULL,
	[corrTramiteAnterior] [numeric](18, 0) NULL,
	[agenciaDescripcion] [varchar](100) NULL,
	[emision] [varchar](20) NULL,
	[canalCaptura] [varchar](20) NULL,
	[oficina] [int] NULL,
	[oficinaDescripcion] [varchar](100) NULL,
	[usuario] [varchar](50) NULL,
	[descripcionEmision] [varchar](50) NULL,
	[descripcionProducto] [varchar](50) NULL,
	[nota] [varchar](255) NULL,
	[periodicidad] [varchar](20) NULL,
	[reestructuracion] [char](1) NULL,
	[aprobacionForzada] [char](1) NULL,
	[atributos] [numeric](18, 0) NULL,
	[campania] [varchar](20) NULL,
	[promocion] [varchar](10) NULL,
 CONSTRAINT [PK_TramiteProcesos] PRIMARY KEY CLUSTERED 
(
	[corrTramite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TramiteSolicitud]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TramiteSolicitud](
	[corrSolicitud] [numeric](18, 0) NOT NULL,
	[corrTramite] [numeric](18, 0) NOT NULL,
	[nota] [varchar](64) NULL,
	[oficina] [varchar](10) NULL,
	[usuario] [varchar](10) NULL,
	[rowVersion] [int] NULL,
	[fechaIngreso] [datetime] NULL,
	[preautorizado] [char](1) NULL,
 CONSTRAINT [PK_TramiteSolicitudFlujo] PRIMARY KEY CLUSTERED 
(
	[corrSolicitud] ASC,
	[corrTramite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tramiteTEMP]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tramiteTEMP](
	[corrtramite] [numeric](18, 0) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[vLogActividadVdocsSipsa]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vLogActividadVdocsSipsa](
	[Usuario] [varchar](50) NULL,
	[CorrTramite] [numeric](15, 5) NULL,
	[Agencia] [varchar](50) NULL,
	[Estado] [char](2) NULL,
	[FechaIni] [datetime] NULL,
	[HoraIni] [datetime] NULL,
	[FechaFinal] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vLogActividadInvtSipsaMensual]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vLogActividadInvtSipsaMensual]
AS
    (select 
        a.usuario Usuario, a.corrTramite CorrTramite, e.nombre_agencia Agencia, a.estado Estado, 
        a.horaInicio FechaIni, a.horaInicio HoraIni, a.horaFinal FechaFinal
     from 
        TramiteProcesos     b with (nolock) inner join 
        BitacoraEtapas      a with (nolock) on (a.corrTramite = b.corrTramite) left join 
        operacion..agencias e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
     where 
        a.etapa   = 'INVT'   and 
        b.origen  = 'SIPSA'  and 
        a.estado != 'SP'     and 
        --convert(varchar, a.horaFinal, 112) = convert(varchar, (getDate() - 1), 112) )
		year(a.horaFinal) = year(case when (day(getdate())=1) then (getdate()-5) else getdate() end ) and 
		month(a.horaFinal) = month(case when (day(getdate())=1) then (getdate()-5) else getdate() end )) 
		
    union
    (select 
        d.usuario Usuario, c.corrTramite CorrTramite, e.nombre_agencia Agencia, 'PC' Estado, 
        c.fechaIngreso FechaIni, c.fechaIngreso HoraIni, d.fecha FechaFinal
     from 
        TramiteProcesos      b with (nolock) inner join 
        CuestionarioTramite  c with (nolock) on (b.corrTramite = c.corrTramite) inner join 
        BitacoraCuestionario d with (nolock) on (c.correlativo = d.corrcuestionario) left join 
        operacion..agencias  e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
     where 
        b.origen = 'SIPSA' and         
		c.etapa  = 'INVT' and
        d.resultadoaprobaciontotal = 'PC' and 
        --convert(varchar, d.fecha, 112) = convert(varchar, (getDate() - 1), 112) ) 
		year(d.fecha) = year(case when (day(getdate())=1) then (getdate()-5) else getdate() end ) and 
		month(d.fecha) = month(case when (day(getdate())=1) then (getdate()-5) else getdate() end ))
    --order by Usuario, HoraFinal



GO
/****** Object:  View [dbo].[vLogActividadVdocsSipsa_Disabled]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vLogActividadVdocsSipsa_Disabled]
AS
    (select 
        a.usuario Usuario, a.corrTramite CorrTramite, e.nombre_agencia Agencia, a.estado Estado, 
        a.horaInicio FechaIni, a.horaInicio HoraIni, a.horaFinal FechaFinal
     from 
        TramiteProcesos     b with (nolock) inner join 
        BitacoraEtapas      a with (nolock) on (a.corrTramite = b.corrTramite) left join 
        operacion..agencias e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
     where 
        a.etapa   = 'VDOCS'   and 
        b.origen  = 'SIPSA'  and 
        a.estado != 'SP'     and 
       (convert(varchar, a.horaFinal, 112) = convert(varchar, (getDate()), 112) or
        convert(varchar, a.horaFinal, 112) = convert(varchar, (getDate() - 1), 112)) )
    union
    (select 
        d.usuario Usuario, c.corrTramite CorrTramite, e.nombre_agencia Agencia, 'PC' Estado, 
        c.fechaIngreso FechaIni, c.fechaIngreso HoraIni, d.fecha FechaFinal
     from 
        TramiteProcesos      b with (nolock) inner join 
        CuestionarioTramite  c with (nolock) on (b.corrTramite = c.corrTramite) inner join 
        BitacoraCuestionario d with (nolock) on (c.correlativo = d.corrcuestionario) left join 
        operacion..agencias  e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
     where 
        b.origen = 'SIPSA' and 
        c.etapa  = 'VDOCS' and 
        d.resultadoaprobaciontotal = 'PC' and 
       (convert(varchar, d.fecha, 112) = convert(varchar, (getDate()), 112) or 
        convert(varchar, d.fecha, 112) = convert(varchar, (getDate() - 1), 112)) ) 
    --order by Usuario, HoraFinal



GO
/****** Object:  View [dbo].[vLogActividadVdocsSipsaMensual]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vLogActividadVdocsSipsaMensual]
AS
    (select 
        a.usuario Usuario, a.corrTramite CorrTramite, e.nombre_agencia Agencia, a.estado Estado, 
        a.horaInicio FechaIni, a.horaInicio HoraIni, a.horaFinal FechaFinal
     from 
        TramiteProcesos     b with (nolock) inner join 
        BitacoraEtapas      a with (nolock) on (a.corrTramite = b.corrTramite) left join 
        operacion..agencias e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
     where 
        a.etapa   = 'VDOCS'   and 
        b.origen  = 'SIPSA'  and 
        a.estado != 'SP'     and 
        --convert(varchar, a.horaFinal, 112) = convert(varchar, (getDate() - 1), 112) )
		year(a.horaFinal) = year(case when (day(getdate())=1) then (getdate()-5) else getdate() end ) and 
		month(a.horaFinal) = month(case when (day(getdate())=1) then (getdate()-5) else getdate() end )) 
		
    union
    (select 
        d.usuario Usuario, c.corrTramite CorrTramite, e.nombre_agencia Agencia, 'PC' Estado, 
        c.fechaIngreso FechaIni, c.fechaIngreso HoraIni, d.fecha FechaFinal
     from 
        TramiteProcesos      b with (nolock) inner join 
        CuestionarioTramite  c with (nolock) on (b.corrTramite = c.corrTramite) inner join 
        BitacoraCuestionario d with (nolock) on (c.correlativo = d.corrcuestionario) left join 
        operacion..agencias  e with (nolock) on (e.cod_empresa = 1 and cod_agencia = b.oficina)
     where 
        b.origen = 'SIPSA' and         
		c.etapa  = 'VDOCS' and
        d.resultadoaprobaciontotal = 'PC' and 
        --convert(varchar, d.fecha, 112) = convert(varchar, (getDate() - 1), 112) ) 
		year(d.fecha) = year(case when (day(getdate())=1) then (getdate()-5) else getdate() end ) and 
		month(d.fecha) = month(case when (day(getdate())=1) then (getdate()-5) else getdate() end ))
    --order by Usuario, HoraFinal



GO
/****** Object:  View [dbo].[vLogFormulariosConsolidadoMensual]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vLogFormulariosConsolidadoMensual]
AS
	select
        sub.origen as ORIGEN, sub.usuario as USUARIO,
        sum(case when sub.etapa = 'AUTCR' then sub.total else 0 end) as AUTCR,
        sum(case when sub.etapa = 'BBR' then sub.total else 0 end) as BBR,
        sum(case when sub.etapa = 'BPTC' then sub.total else 0 end) as BPTC,
        sum(case when sub.etapa = 'BSP' then sub.total else 0 end) as BSP,
        sum(case when sub.etapa = 'CNFC' then sub.total else 0 end) as CNFC,
        sum(case when sub.etapa = 'CRD' then sub.total else 0 end) as CRD,
        sum(case when sub.etapa = 'CRG' then sub.total else 0 end) as CRG,
        sum(case when sub.etapa = 'FTCR' then sub.total else 0 end) as FTCR,
        sum(case when sub.etapa = 'INF' then sub.total else 0 end) as INF,
        sum(case when sub.etapa = 'INVC' then sub.total else 0 end) as INVC,
        sum(case when sub.etapa = 'INVT' then sub.total else 0 end) as INVT,
        sum(case when sub.etapa = 'RINV' then sub.total else 0 end) as RINV,
        sum(case when sub.etapa = 'TRN' then sub.total else 0 end) as TRN,
        sum(case when sub.etapa = 'VDOCS' then sub.total else 0 end) as VDOCS,
        sum(sub.total) as TOTAL--,
    from 
       (select 
           c.origen as origen, a.usuario as usuario, a.etapa as etapa, count(a.correlativo) as total    
        from 
            CuestionarioTramite a, TramiteProcesos c
        where 
            a.corrTramite = c.corrTramite and 
            convert(varchar, a.fechaUltModificacion, 112) >= convert(varchar,((Dateadd(Month,-1,getDate()) - day(Dateadd(Month,-1,getDate()) - 1)) + 25), 112) and
            convert(varchar, a.fechaUltModificacion, 112) <= convert(varchar,(getDate() - day(getDate() - 1) + 24), 112)
        group by 
            c.origen, a.usuario, a.etapa) as sub 
      group by 
        sub.origen, sub.usuario



GO
/****** Object:  View [dbo].[vLogFormulariosMensual]    Script Date: 21/05/2018 09:38:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vLogFormulariosMensual]
AS

	select 
        c.origen, a.usuario, a.etapa, count(a.correlativo) total
    from 
        CuestionarioTramite a with(nolock), TramiteProcesos c with(nolock)
    where 
        a.corrTramite = c.corrTramite and 
        convert(varchar, a.fechaUltModificacion, 112) >=  convert(varchar,((Dateadd(Month,-1,getDate()) - day(Dateadd(Month,-1,getDate()) - 1)) + 25), 112) and
        convert(varchar, a.fechaUltModificacion, 112) <= convert(varchar,(getDate() - day(getDate() - 1) + 24), 112)
      group by 
        c.origen, a.usuario, a.etapa



GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [JMS_MESSAGES_IDX]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE UNIQUE CLUSTERED INDEX [JMS_MESSAGES_IDX] ON [dbo].[JMS_MESSAGES]
(
	[MESSAGEID] ASC,
	[DESTINATION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [bitacoracuestionario_corrcuestionario_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [bitacoracuestionario_corrcuestionario_idx] ON [dbo].[BitacoraCuestionario]
(
	[corrCuestionario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [bitacoracuestionario_resultado_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [bitacoracuestionario_resultado_idx] ON [dbo].[BitacoraCuestionario]
(
	[resultadoAprobacionTotal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [Idx_BitacoraCuestionario_1]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [Idx_BitacoraCuestionario_1] ON [dbo].[BitacoraCuestionario]
(
	[fecha] ASC,
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [bitacoraetapas_etapa_estado_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [bitacoraetapas_etapa_estado_idx] ON [dbo].[BitacoraEtapas]
(
	[estado] ASC,
	[etapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [bitacoraetapas_rep_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [bitacoraetapas_rep_idx] ON [dbo].[BitacoraEtapas]
(
	[corrTramite] ASC,
	[usuario] ASC,
	[etapa] ASC,
	[horaFinal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [bitacoraetapas_secgen_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [bitacoraetapas_secgen_idx] ON [dbo].[BitacoraEtapas]
(
	[secuencialGenerado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [bitacora_mensajes_corrtramite_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [bitacora_mensajes_corrtramite_idx] ON [dbo].[BitacoraMensajes]
(
	[corrTramite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [bitacora_mensajes_fecha_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [bitacora_mensajes_fecha_idx] ON [dbo].[BitacoraMensajes]
(
	[fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Cliente_cedula_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [Cliente_cedula_idx] ON [dbo].[Cliente]
(
	[numDocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [cliente_nit_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cliente_nit_idx] ON [dbo].[Cliente]
(
	[NIT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Cliente_nombres_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [Cliente_nombres_idx] ON [dbo].[Cliente]
(
	[primerNombreStd] ASC,
	[segundoNombreStd] ASC,
	[primerApellidoStd] ASC,
	[segundoApellidoStd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [cliente_numDocId_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cliente_numDocId_idx] ON [dbo].[Cliente]
(
	[numDocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [cliente_primerApellidostd_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cliente_primerApellidostd_idx] ON [dbo].[Cliente]
(
	[primerApellidoStd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [cliente_primerNombreStd_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cliente_primerNombreStd_idx] ON [dbo].[Cliente]
(
	[primerNombreStd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [cliente_segundoApellidostd_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cliente_segundoApellidostd_idx] ON [dbo].[Cliente]
(
	[segundoApellidoStd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [cliente_segundoNombrestd_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cliente_segundoNombrestd_idx] ON [dbo].[Cliente]
(
	[segundoNombreStd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [cond_man_corrtramite_etapa_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cond_man_corrtramite_etapa_idx] ON [dbo].[CondicionManual]
(
	[corrTramite] ASC,
	[etapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [creditospersona_corrpersona_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [creditospersona_corrpersona_idx] ON [dbo].[CreditosPersona]
(
	[corrPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [cuestionariotramite_corrtramite_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cuestionariotramite_corrtramite_idx] ON [dbo].[CuestionarioTramite]
(
	[corrTramite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [cuestionariotramite_etapa_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cuestionariotramite_etapa_idx] ON [dbo].[CuestionarioTramite]
(
	[etapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [cuestionariotramitepersona_corrcliente_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cuestionariotramitepersona_corrcliente_idx] ON [dbo].[CuestionarioTramitePersona]
(
	[corrCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [cuestionariotramitepersona_corrprincipal_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cuestionariotramitepersona_corrprincipal_idx] ON [dbo].[CuestionarioTramitePersona]
(
	[corrPrincipal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [cuestionariotramitepreguntas_corrcuestionario_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cuestionariotramitepreguntas_corrcuestionario_idx] ON [dbo].[CuestionarioTramitePreguntas]
(
	[corrCuestionario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [cuestionariotramiterespuestas_corrpregunta_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [cuestionariotramiterespuestas_corrpregunta_idx] ON [dbo].[CuestionarioTramiteRespuestas]
(
	[corrPregunta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [datosmutables_corrtramite_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [datosmutables_corrtramite_idx] ON [dbo].[DatosMutables]
(
	[corrTramite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [empresa_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [empresa_idx] ON [dbo].[Empresa]
(
	[corrDireccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [JMS_MESSAGES_DESTINATION]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [JMS_MESSAGES_DESTINATION] ON [dbo].[JMS_MESSAGES]
(
	[DESTINATION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [JMS_MESSAGES_TXOP_TXID]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [JMS_MESSAGES_TXOP_TXID] ON [dbo].[JMS_MESSAGES]
(
	[TXOP] ASC,
	[TXID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [LogReglas_corrTramiteIDX]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [LogReglas_corrTramiteIDX] ON [dbo].[LogReglas]
(
	[corrTramite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [logreglas_idx2]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [logreglas_idx2] ON [dbo].[LogReglas]
(
	[corrTramite] ASC,
	[secuencialGenerado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [logreglasaceptadas_corrregla_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [logreglasaceptadas_corrregla_idx] ON [dbo].[logreglasaceptadas]
(
	[corrRegla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [logreglasrechazos_corrregla_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [logreglasrechazos_corrregla_idx] ON [dbo].[LogReglasRechazos]
(
	[corrRegla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [ocupacion_corrcliente_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [ocupacion_corrcliente_idx] ON [dbo].[Ocupacion]
(
	[corrCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [ocupacion_corrempresa_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [ocupacion_corrempresa_idx] ON [dbo].[Ocupacion]
(
	[corrEmpresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [OFCEntesIDX]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [OFCEntesIDX] ON [dbo].[OFCEntes]
(
	[nombre] ASC,
	[apellido] ASC,
	[tipo] ASC,
	[pais] ASC,
	[direccion] ASC,
	[ciudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [OFCEntesIDX2]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [OFCEntesIDX2] ON [dbo].[OFCEntes]
(
	[uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [OFCEntesAliasIDX]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [OFCEntesAliasIDX] ON [dbo].[OFCEntesAlias]
(
	[uid] ASC,
	[uidEnte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [solicitud_cliente_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [solicitud_cliente_idx] ON [dbo].[Solicitud]
(
	[corrClienteSolicitante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [solicitud_correxterno_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [solicitud_correxterno_idx] ON [dbo].[Solicitud]
(
	[correlativoExterno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [TramiteDinamico_01]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [TramiteDinamico_01] ON [dbo].[TramiteDinamico]
(
	[fecha] ASC,
	[corrTramite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [tf_estatus_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [tf_estatus_idx] ON [dbo].[TramiteFlujo]
(
	[estatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [tramite_flujo_corrtramite_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [tramite_flujo_corrtramite_idx] ON [dbo].[TramiteFlujo]
(
	[corrTramite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [tramiteflujo_estatus_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [tramiteflujo_estatus_idx] ON [dbo].[TramiteFlujo]
(
	[estatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [tramiteflujo_etapa_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [tramiteflujo_etapa_idx] ON [dbo].[TramiteFlujo]
(
	[etapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [tramiteflujo_ultsec_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [tramiteflujo_ultsec_idx] ON [dbo].[TramiteFlujo]
(
	[ultSecuencialGenerado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [idx_tpisol]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [idx_tpisol] ON [dbo].[TramitePersonaIndividual]
(
	[corrSolicitud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [tp_fechaingreso_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [tp_fechaingreso_idx] ON [dbo].[TramiteProcesos]
(
	[fechaIngreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [tramiteprocesos_estadoOperativo]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [tramiteprocesos_estadoOperativo] ON [dbo].[TramiteProcesos]
(
	[estadoOperativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [tramiteprocesos_fechaingreso]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [tramiteprocesos_fechaingreso] ON [dbo].[TramiteProcesos]
(
	[fechaIngreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [tramiteprocesos_origen_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [tramiteprocesos_origen_idx] ON [dbo].[TramiteProcesos]
(
	[origen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [tramiteprocesos_rep_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [tramiteprocesos_rep_idx] ON [dbo].[TramiteProcesos]
(
	[corrTramite] ASC,
	[origen] ASC,
	[estadoOperativo] ASC,
	[fechaUltModif] ASC,
	[usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [tramite_solicitud_corrsol]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [tramite_solicitud_corrsol] ON [dbo].[TramiteSolicitud]
(
	[corrSolicitud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Index [tramitesolicitud_corrtramite_idx]    Script Date: 21/05/2018 09:38:42 p.m. ******/
CREATE NONCLUSTERED INDEX [tramitesolicitud_corrtramite_idx] ON [dbo].[TramiteSolicitud]
(
	[corrTramite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BitacoraMensajes] ADD  CONSTRAINT [DF_BitacoraMensajes_vigente]  DEFAULT ('N') FOR [vigente]
GO
ALTER TABLE [dbo].[TramiteFlujo] ADD  CONSTRAINT [DF_TramiteFlujo_comportamiento]  DEFAULT ((2)) FOR [comportamiento]
GO
ALTER TABLE [dbo].[TramiteProcesos] ADD  CONSTRAINT [DF__TramitePr__promo__37B03374]  DEFAULT (NULL) FOR [promocion]
GO
ALTER TABLE [dbo].[AFParametrosValor]  WITH CHECK ADD  CONSTRAINT [FK_AFParametrosValor_AFParametros] FOREIGN KEY([corrParametro])
REFERENCES [dbo].[AFParametros] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AFParametrosValor] CHECK CONSTRAINT [FK_AFParametrosValor_AFParametros]
GO
ALTER TABLE [dbo].[ArchivoFormularioDetalle]  WITH CHECK ADD  CONSTRAINT [FK_ArchivoFormularioDetalle_ArchivoFormulario] FOREIGN KEY([corrArchivo])
REFERENCES [dbo].[ArchivoFormulario] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ArchivoFormularioDetalle] CHECK CONSTRAINT [FK_ArchivoFormularioDetalle_ArchivoFormulario]
GO
ALTER TABLE [dbo].[BitacoraCambiosCampo]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraCambiosCampo_BitacoraCambiosEntidad] FOREIGN KEY([corrEntidadCambio])
REFERENCES [dbo].[BitacoraCambiosEntidad] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BitacoraCambiosCampo] CHECK CONSTRAINT [FK_BitacoraCambiosCampo_BitacoraCambiosEntidad]
GO
ALTER TABLE [dbo].[BitacoraCuestionario]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraCuestionario_CuestionarioTramite] FOREIGN KEY([corrCuestionario])
REFERENCES [dbo].[CuestionarioTramite] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BitacoraCuestionario] CHECK CONSTRAINT [FK_BitacoraCuestionario_CuestionarioTramite]
GO
ALTER TABLE [dbo].[BitacoraEtapas]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraEtapas_TramiteProcesos] FOREIGN KEY([corrTramite])
REFERENCES [dbo].[TramiteProcesos] ([corrTramite])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BitacoraEtapas] CHECK CONSTRAINT [FK_BitacoraEtapas_TramiteProcesos]
GO
ALTER TABLE [dbo].[ClienteSolicitud]  WITH CHECK ADD  CONSTRAINT [FK_ClienteSolicitud_Cliente] FOREIGN KEY([corrCliente])
REFERENCES [dbo].[Cliente] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClienteSolicitud] CHECK CONSTRAINT [FK_ClienteSolicitud_Cliente]
GO
ALTER TABLE [dbo].[ClienteSolicitud]  WITH CHECK ADD  CONSTRAINT [FK_ClienteSolicitud_Solicitud] FOREIGN KEY([corrSolicitud])
REFERENCES [dbo].[Solicitud] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClienteSolicitud] CHECK CONSTRAINT [FK_ClienteSolicitud_Solicitud]
GO
ALTER TABLE [dbo].[CondicionManual]  WITH CHECK ADD  CONSTRAINT [FK_CondicionManual_TramiteFlujo] FOREIGN KEY([etapa], [corrTramite])
REFERENCES [dbo].[TramiteFlujo] ([etapa], [corrTramite])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CondicionManual] CHECK CONSTRAINT [FK_CondicionManual_TramiteFlujo]
GO
ALTER TABLE [dbo].[CondicionManualDetalle]  WITH CHECK ADD  CONSTRAINT [FK_CondicionManualDetalle_CondicionManual] FOREIGN KEY([corrCondicion])
REFERENCES [dbo].[CondicionManual] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CondicionManualDetalle] CHECK CONSTRAINT [FK_CondicionManualDetalle_CondicionManual]
GO
ALTER TABLE [dbo].[CreditosPersona]  WITH CHECK ADD  CONSTRAINT [FK_CreditosPersona_Cliente] FOREIGN KEY([corrPersona])
REFERENCES [dbo].[Cliente] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CreditosPersona] CHECK CONSTRAINT [FK_CreditosPersona_Cliente]
GO
ALTER TABLE [dbo].[CuestionarioAsociado]  WITH CHECK ADD  CONSTRAINT [FK_CuestionarioAsociado_CuestionarioTramitePersona] FOREIGN KEY([corrCuestionarioPersona])
REFERENCES [dbo].[CuestionarioTramitePersona] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CuestionarioAsociado] CHECK CONSTRAINT [FK_CuestionarioAsociado_CuestionarioTramitePersona]
GO
ALTER TABLE [dbo].[CuestionarioTramite]  WITH CHECK ADD  CONSTRAINT [FK_CuestionarioTramite_TramiteProcesos] FOREIGN KEY([corrTramite])
REFERENCES [dbo].[TramiteProcesos] ([corrTramite])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CuestionarioTramite] CHECK CONSTRAINT [FK_CuestionarioTramite_TramiteProcesos]
GO
ALTER TABLE [dbo].[CuestionarioTramitePersona]  WITH CHECK ADD  CONSTRAINT [FK_CuestionarioTramite_Cliente] FOREIGN KEY([corrCliente])
REFERENCES [dbo].[Cliente] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CuestionarioTramitePersona] CHECK CONSTRAINT [FK_CuestionarioTramite_Cliente]
GO
ALTER TABLE [dbo].[CuestionarioTramitePersona]  WITH CHECK ADD  CONSTRAINT [FK_CuestionarioTramitePersona_CuestionarioTramite] FOREIGN KEY([corrPrincipal])
REFERENCES [dbo].[CuestionarioTramite] ([correlativo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CuestionarioTramitePersona] CHECK CONSTRAINT [FK_CuestionarioTramitePersona_CuestionarioTramite]
GO
ALTER TABLE [dbo].[CuestionarioTramitePreguntas]  WITH CHECK ADD  CONSTRAINT [FK_CuestionarioTramitePreguntas_CuestionarioTramite] FOREIGN KEY([corrCuestionario])
REFERENCES [dbo].[CuestionarioTramitePersona] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CuestionarioTramitePreguntas] CHECK CONSTRAINT [FK_CuestionarioTramitePreguntas_CuestionarioTramite]
GO
ALTER TABLE [dbo].[CuestionarioTramiteRespuestas]  WITH CHECK ADD  CONSTRAINT [FK_CuestionarioTramiteRespuestas_CuestionarioTramitePreguntas] FOREIGN KEY([corrPregunta])
REFERENCES [dbo].[CuestionarioTramitePreguntas] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CuestionarioTramiteRespuestas] CHECK CONSTRAINT [FK_CuestionarioTramiteRespuestas_CuestionarioTramitePreguntas]
GO
ALTER TABLE [dbo].[DatosMutables]  WITH CHECK ADD  CONSTRAINT [FK_DatosMutables_TramiteProcesos] FOREIGN KEY([corrTramite])
REFERENCES [dbo].[TramiteProcesos] ([corrTramite])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DatosMutables] CHECK CONSTRAINT [FK_DatosMutables_TramiteProcesos]
GO
ALTER TABLE [dbo].[DetalleTabla]  WITH CHECK ADD  CONSTRAINT [FK_DETALLET_REFERENCE_TABLA] FOREIGN KEY([tabla])
REFERENCES [dbo].[Tabla] ([codigo])
GO
ALTER TABLE [dbo].[DetalleTabla] CHECK CONSTRAINT [FK_DETALLET_REFERENCE_TABLA]
GO
ALTER TABLE [dbo].[DocumentosAdjuntos]  WITH CHECK ADD  CONSTRAINT [FK_DocumentosAdjuntos_Solicitud] FOREIGN KEY([corrSolicitud])
REFERENCES [dbo].[Solicitud] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DocumentosAdjuntos] CHECK CONSTRAINT [FK_DocumentosAdjuntos_Solicitud]
GO
ALTER TABLE [dbo].[Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Empresa_Direccion] FOREIGN KEY([corrDireccion])
REFERENCES [dbo].[Direccion] ([correlativo])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Empresa] CHECK CONSTRAINT [FK_Empresa_Direccion]
GO
ALTER TABLE [dbo].[EmpresaSolicitud]  WITH CHECK ADD  CONSTRAINT [FK_EmpresaSolicitud_Empresa] FOREIGN KEY([corrEmpresa])
REFERENCES [dbo].[Empresa] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmpresaSolicitud] CHECK CONSTRAINT [FK_EmpresaSolicitud_Empresa]
GO
ALTER TABLE [dbo].[EmpresaSolicitud]  WITH CHECK ADD  CONSTRAINT [FK_EmpresaSolicitud_Solicitud] FOREIGN KEY([corrSolicitud])
REFERENCES [dbo].[Solicitud] ([correlativo])
GO
ALTER TABLE [dbo].[EmpresaSolicitud] CHECK CONSTRAINT [FK_EmpresaSolicitud_Solicitud]
GO
ALTER TABLE [dbo].[EmpresaTelefono]  WITH CHECK ADD  CONSTRAINT [FK_EmpresaTelefono_Empresa] FOREIGN KEY([corrEmpresa])
REFERENCES [dbo].[Empresa] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmpresaTelefono] CHECK CONSTRAINT [FK_EmpresaTelefono_Empresa]
GO
ALTER TABLE [dbo].[EmpresaTelefono]  WITH CHECK ADD  CONSTRAINT [FK_EmpresaTelefono_MediosContacto] FOREIGN KEY([corrTelefono])
REFERENCES [dbo].[MediosContacto] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmpresaTelefono] CHECK CONSTRAINT [FK_EmpresaTelefono_MediosContacto]
GO
ALTER TABLE [dbo].[loginRol]  WITH CHECK ADD  CONSTRAINT [FK_loginRol_logines] FOREIGN KEY([corrLogin])
REFERENCES [dbo].[logines] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[loginRol] CHECK CONSTRAINT [FK_loginRol_logines]
GO
ALTER TABLE [dbo].[loginRol]  WITH CHECK ADD  CONSTRAINT [FK_loginRol_rol] FOREIGN KEY([corrRol])
REFERENCES [dbo].[rol] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[loginRol] CHECK CONSTRAINT [FK_loginRol_rol]
GO
ALTER TABLE [dbo].[LogReglas]  WITH CHECK ADD  CONSTRAINT [FK_LogReglas_TramiteProcesos] FOREIGN KEY([corrTramite])
REFERENCES [dbo].[TramiteProcesos] ([corrTramite])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LogReglas] CHECK CONSTRAINT [FK_LogReglas_TramiteProcesos]
GO
ALTER TABLE [dbo].[logreglasaceptadas]  WITH CHECK ADD  CONSTRAINT [FK_logreglasaceptadas_LogReglas] FOREIGN KEY([corrRegla])
REFERENCES [dbo].[LogReglas] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[logreglasaceptadas] CHECK CONSTRAINT [FK_logreglasaceptadas_LogReglas]
GO
ALTER TABLE [dbo].[LogReglasRechazos]  WITH CHECK ADD  CONSTRAINT [FK_LogReglasRechazos_LogReglas] FOREIGN KEY([corrRegla])
REFERENCES [dbo].[LogReglas] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LogReglasRechazos] CHECK CONSTRAINT [FK_LogReglasRechazos_LogReglas]
GO
ALTER TABLE [dbo].[Ocupacion]  WITH CHECK ADD  CONSTRAINT [FK_Ocupacion_Cliente] FOREIGN KEY([corrCliente])
REFERENCES [dbo].[Cliente] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ocupacion] CHECK CONSTRAINT [FK_Ocupacion_Cliente]
GO
ALTER TABLE [dbo].[Ocupacion]  WITH CHECK ADD  CONSTRAINT [FK_Ocupacion_Empresa] FOREIGN KEY([corrEmpresa])
REFERENCES [dbo].[Empresa] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ocupacion] CHECK CONSTRAINT [FK_Ocupacion_Empresa]
GO
ALTER TABLE [dbo].[OFCEntesAlias]  WITH CHECK ADD  CONSTRAINT [FK_OFCEntesAlias_OFCEntes] FOREIGN KEY([uidEnte])
REFERENCES [dbo].[OFCEntes] ([uid])
GO
ALTER TABLE [dbo].[OFCEntesAlias] CHECK CONSTRAINT [FK_OFCEntesAlias_OFCEntes]
GO
ALTER TABLE [dbo].[OtrasCuentas]  WITH CHECK ADD  CONSTRAINT [FK_OtrasTarjetas_Solicitud] FOREIGN KEY([corrSolicitud])
REFERENCES [dbo].[Solicitud] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OtrasCuentas] CHECK CONSTRAINT [FK_OtrasTarjetas_Solicitud]
GO
ALTER TABLE [dbo].[PersonaDireccion]  WITH CHECK ADD  CONSTRAINT [FK_PersonaDireccion_Cliente] FOREIGN KEY([corrCliente])
REFERENCES [dbo].[Cliente] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonaDireccion] CHECK CONSTRAINT [FK_PersonaDireccion_Cliente]
GO
ALTER TABLE [dbo].[PersonaDireccion]  WITH CHECK ADD  CONSTRAINT [FK_PersonaDireccion_Direccion] FOREIGN KEY([corrDireccion])
REFERENCES [dbo].[Direccion] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonaDireccion] CHECK CONSTRAINT [FK_PersonaDireccion_Direccion]
GO
ALTER TABLE [dbo].[PersonaTelefono]  WITH CHECK ADD  CONSTRAINT [FK_PersonaTelefono_Cliente] FOREIGN KEY([corrCliente])
REFERENCES [dbo].[Cliente] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonaTelefono] CHECK CONSTRAINT [FK_PersonaTelefono_Cliente]
GO
ALTER TABLE [dbo].[PersonaTelefono]  WITH CHECK ADD  CONSTRAINT [FK_PersonaTelefono_MediosContacto] FOREIGN KEY([corrTelefono])
REFERENCES [dbo].[MediosContacto] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonaTelefono] CHECK CONSTRAINT [FK_PersonaTelefono_MediosContacto]
GO
ALTER TABLE [dbo].[preguntas]  WITH CHECK ADD  CONSTRAINT [FK_preguntas_formulario] FOREIGN KEY([idFormulario])
REFERENCES [dbo].[formulario] ([correlativo])
GO
ALTER TABLE [dbo].[preguntas] CHECK CONSTRAINT [FK_preguntas_formulario]
GO
ALTER TABLE [dbo].[respuesta]  WITH CHECK ADD  CONSTRAINT [FK_respuesta_preguntas] FOREIGN KEY([idPregunta])
REFERENCES [dbo].[preguntas] ([correlativo])
GO
ALTER TABLE [dbo].[respuesta] CHECK CONSTRAINT [FK_respuesta_preguntas]
GO
ALTER TABLE [dbo].[resultado_formulario]  WITH CHECK ADD  CONSTRAINT [FK_resultado_formulario_formulario] FOREIGN KEY([idFormulario])
REFERENCES [dbo].[formulario] ([correlativo])
GO
ALTER TABLE [dbo].[resultado_formulario] CHECK CONSTRAINT [FK_resultado_formulario_formulario]
GO
ALTER TABLE [dbo].[resultado_formulario_detalle]  WITH CHECK ADD  CONSTRAINT [FK_resultado_formulario_detalle_resultado_formulario] FOREIGN KEY([idResultado])
REFERENCES [dbo].[resultado_formulario] ([correlativo])
GO
ALTER TABLE [dbo].[resultado_formulario_detalle] CHECK CONSTRAINT [FK_resultado_formulario_detalle_resultado_formulario]
GO
ALTER TABLE [dbo].[ServicioParametros]  WITH CHECK ADD  CONSTRAINT [FK_ServicioParametros_Servicio] FOREIGN KEY([codigoServicio])
REFERENCES [dbo].[Servicio] ([codigo])
GO
ALTER TABLE [dbo].[ServicioParametros] CHECK CONSTRAINT [FK_ServicioParametros_Servicio]
GO
ALTER TABLE [dbo].[TOPath]  WITH CHECK ADD  CONSTRAINT [FK_TOPath_ConfiguracionValidacionTO] FOREIGN KEY([idTO])
REFERENCES [dbo].[ConfiguracionValidacionTO] ([correlativo])
GO
ALTER TABLE [dbo].[TOPath] CHECK CONSTRAINT [FK_TOPath_ConfiguracionValidacionTO]
GO
ALTER TABLE [dbo].[TramiteFlujo]  WITH CHECK ADD  CONSTRAINT [FK_TramiteFlujo_TramiteProcesos] FOREIGN KEY([corrTramite])
REFERENCES [dbo].[TramiteProcesos] ([corrTramite])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TramiteFlujo] CHECK CONSTRAINT [FK_TramiteFlujo_TramiteProcesos]
GO
ALTER TABLE [dbo].[TramitePersonaIndividual]  WITH CHECK ADD  CONSTRAINT [FK_TramitePersonaIndividual_Cliente] FOREIGN KEY([corrCliente])
REFERENCES [dbo].[Cliente] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TramitePersonaIndividual] CHECK CONSTRAINT [FK_TramitePersonaIndividual_Cliente]
GO
ALTER TABLE [dbo].[TramitePersonaIndividual]  WITH CHECK ADD  CONSTRAINT [FK_TramitePersonaIndividual_TramiteProcesos] FOREIGN KEY([corrTramite])
REFERENCES [dbo].[TramiteProcesos] ([corrTramite])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TramitePersonaIndividual] CHECK CONSTRAINT [FK_TramitePersonaIndividual_TramiteProcesos]
GO
ALTER TABLE [dbo].[TramiteSolicitud]  WITH CHECK ADD  CONSTRAINT [FK_TramiteSolicitudFlujo_Solicitud] FOREIGN KEY([corrSolicitud])
REFERENCES [dbo].[Solicitud] ([correlativo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TramiteSolicitud] CHECK CONSTRAINT [FK_TramiteSolicitudFlujo_Solicitud]
GO
ALTER TABLE [dbo].[TramiteSolicitud]  WITH CHECK ADD  CONSTRAINT [FK_TramiteSolicitudFlujo_TramiteProcesos] FOREIGN KEY([corrTramite])
REFERENCES [dbo].[TramiteProcesos] ([corrTramite])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TramiteSolicitud] CHECK CONSTRAINT [FK_TramiteSolicitudFlujo_TramiteProcesos]
GO
USE [master]
GO
ALTER DATABASE [creditfactory] SET  READ_WRITE 
GO
