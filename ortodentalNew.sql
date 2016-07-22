USE [master]
GO
/****** Object:  Database [ERPDatabase]    Script Date: 21/07/2016 11:47:33 p.m. ******/
CREATE DATABASE [ERPDatabase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'new_ortodental', FILENAME = N'C:\Program Files\Microsoft SQL Server 2012\MSSQL11.SQLSERVER2012\MSSQL\DATA\new_ortodental.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'new_ortodental_log', FILENAME = N'C:\Program Files\Microsoft SQL Server 2012\MSSQL11.SQLSERVER2012\MSSQL\DATA\new_ortodental_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ERPDatabase] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ERPDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ERPDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ERPDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ERPDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ERPDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ERPDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [ERPDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ERPDatabase] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ERPDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ERPDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ERPDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ERPDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ERPDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ERPDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ERPDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ERPDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ERPDatabase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ERPDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ERPDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ERPDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ERPDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ERPDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ERPDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ERPDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ERPDatabase] SET RECOVERY FULL 
GO
ALTER DATABASE [ERPDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [ERPDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ERPDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ERPDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ERPDatabase] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ERPDatabase', N'ON'
GO
USE [ERPDatabase]
GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_Area]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_Area]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_tipoArea varchar(50) = null   
,  @i_descripcion varchar(250) = null   
,  @i_maquinamod varchar(50) = null   
,  @i_nombre varchar(50) = null   
,  @i_usuariomod varchar(50) = null   
,  @i_empresa int = null   
,  @i_maquinaing varchar(50) = null   
,  @i_usuarioing varchar(50) = null   
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
          from Area
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert Area off  --solo aplica si tiene identity


          insert into  Area (
              tipoArea
              ,descripcion
              ,maquinamod
              ,nombre
              ,empresa
              ,maquinaing
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_tipoArea
              ,@i_descripcion
              ,@i_maquinamod
              ,@i_nombre
              ,@i_empresa
              ,@i_maquinaing
              ,@i_usuarioing
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
      from Area
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update Area
         set
              tipoArea = isnull(@i_tipoArea, t.tipoArea)
              ,descripcion = isnull(@i_descripcion, t.descripcion)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,nombre = isnull(@i_nombre, t.nombre)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from Area t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from Area
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
         
         update Area                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_Evento]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_Evento]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_descripcion varchar(100) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_tipoEvento char(10) = null   
,  @i_categoria char(10) = null   
,  @i_estado int = null   
,  @i_empresa smallint = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from Evento
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert Evento off  --solo aplica si tiene identity


          insert into  Evento (
              descripcion
              ,maquinamod
              ,tipoEvento
              ,categoria
              ,estado
              ,empresa
              ,maquinaing
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_descripcion
              ,@i_maquinamod
              ,@i_tipoEvento
              ,@i_categoria
              ,@i_estado
              ,@i_empresa
              ,@i_maquinaing
              ,@i_usuarioing
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
      from Evento
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update Evento
         set
              descripcion = isnull(@i_descripcion, t.descripcion)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,tipoEvento = isnull(@i_tipoEvento, t.tipoEvento)
              ,categoria = isnull(@i_categoria, t.categoria)
              ,estado = isnull(@i_estado, t.estado)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from Evento t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from Evento
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
         
         update Evento                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_FacturaFormaPago]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_FacturaFormaPago]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_idDoc int = null   
,  @i_confirmaCierreCaja int = null   
,  @i_moneda char(10) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_idMovDocPromo int = null   
,  @i_unidades int = null   
,  @i_idAutorizacion int = null   
,  @i_efectivoVuelto money = null   
,  @i_cantidad money = null   
,  @i_efectivoRecibido money = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_idMarcaTarjeta char(10) = null   
,  @i_noDocumento varchar(50) = null   
,  @i_tasaCambio money = null   
,  @i_cantidadOriginal money = null   
,  @i_comentario nvarchar(400) = null   
,  @i_idCierreCaja int = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_idCheque int = null   
,  @i_empresa smallint = null   
,  @i_idSucursal int = null   
,  @i_idFormaPago char(10) = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from FacturaFormaPago
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert FacturaFormaPago off  --solo aplica si tiene identity


          insert into  FacturaFormaPago (
              idDoc
              ,confirmaCierreCaja
              ,moneda
              ,maquinamod
              ,idMovDocPromo
              ,unidades
              ,idAutorizacion
              ,efectivoVuelto
              ,cantidad
              ,efectivoRecibido
              ,maquinaing
              ,idMarcaTarjeta
              ,noDocumento
              ,tasaCambio
              ,cantidadOriginal
              ,comentario
              ,idCierreCaja
              ,idCheque
              ,empresa
              ,idSucursal
              ,idFormaPago
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_idDoc
              ,@i_confirmaCierreCaja
              ,@i_moneda
              ,@i_maquinamod
              ,@i_idMovDocPromo
              ,@i_unidades
              ,@i_idAutorizacion
              ,@i_efectivoVuelto
              ,@i_cantidad
              ,@i_efectivoRecibido
              ,@i_maquinaing
              ,@i_idMarcaTarjeta
              ,@i_noDocumento
              ,@i_tasaCambio
              ,@i_cantidadOriginal
              ,@i_comentario
              ,@i_idCierreCaja
              ,@i_idCheque
              ,@i_empresa
              ,@i_idSucursal
              ,@i_idFormaPago
              ,@i_usuarioing
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
      from FacturaFormaPago
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update FacturaFormaPago
         set
              idDoc = isnull(@i_idDoc, t.idDoc)
              ,confirmaCierreCaja = isnull(@i_confirmaCierreCaja, t.confirmaCierreCaja)
              ,moneda = isnull(@i_moneda, t.moneda)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,idMovDocPromo = isnull(@i_idMovDocPromo, t.idMovDocPromo)
              ,unidades = isnull(@i_unidades, t.unidades)
              ,idAutorizacion = isnull(@i_idAutorizacion, t.idAutorizacion)
              ,efectivoVuelto = isnull(@i_efectivoVuelto, t.efectivoVuelto)
              ,cantidad = isnull(@i_cantidad, t.cantidad)
              ,efectivoRecibido = isnull(@i_efectivoRecibido, t.efectivoRecibido)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,idMarcaTarjeta = isnull(@i_idMarcaTarjeta, t.idMarcaTarjeta)
              ,noDocumento = isnull(@i_noDocumento, t.noDocumento)
              ,tasaCambio = isnull(@i_tasaCambio, t.tasaCambio)
              ,cantidadOriginal = isnull(@i_cantidadOriginal, t.cantidadOriginal)
              ,comentario = isnull(@i_comentario, t.comentario)
              ,idCierreCaja = isnull(@i_idCierreCaja, t.idCierreCaja)
              ,idCheque = isnull(@i_idCheque, t.idCheque)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,idSucursal = isnull(@i_idSucursal, t.idSucursal)
              ,idFormaPago = isnull(@i_idFormaPago, t.idFormaPago)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from FacturaFormaPago t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from FacturaFormaPago
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
         
         update FacturaFormaPago                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_Imagen]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_Imagen]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_estImagen char(1) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_imagen text = null   
,  @i_empresa smallint = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_nombreImagen nvarchar(150) = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from Imagen
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert Imagen off  --solo aplica si tiene identity


          insert into  Imagen (
              estImagen
              ,maquinamod
              ,imagen
              ,empresa
              ,maquinaing
              ,nombreImagen
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_estImagen
              ,@i_maquinamod
              ,@i_imagen
              ,@i_empresa
              ,@i_maquinaing
              ,@i_nombreImagen
              ,@i_usuarioing
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
      from Imagen
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update Imagen
         set
              estImagen = isnull(@i_estImagen, t.estImagen)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,imagen = isnull(@i_imagen, t.imagen)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,nombreImagen = isnull(@i_nombreImagen, t.nombreImagen)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from Imagen t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from Imagen
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
         
         update Imagen                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_MedioContacto]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_MedioContacto]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_tipoContacto char(10) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_categoriaContacto char(10) = null   
,  @i_valor nvarchar(100) = null   
,  @i_empresa smallint = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_idPersona int = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from MedioContacto
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert MedioContacto off  --solo aplica si tiene identity


          insert into  MedioContacto (
              tipoContacto
              ,maquinamod
              ,categoriaContacto
              ,valor
              ,empresa
              ,maquinaing
              ,idPersona
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_tipoContacto
              ,@i_maquinamod
              ,@i_categoriaContacto
              ,@i_valor
              ,@i_empresa
              ,@i_maquinaing
              ,@i_idPersona
              ,@i_usuarioing
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
      from MedioContacto
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update MedioContacto
         set
              tipoContacto = isnull(@i_tipoContacto, t.tipoContacto)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,categoriaContacto = isnull(@i_categoriaContacto, t.categoriaContacto)
              ,valor = isnull(@i_valor, t.valor)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,idPersona = isnull(@i_idPersona, t.idPersona)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from MedioContacto t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from MedioContacto
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
         
         update MedioContacto                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_Movimiento]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_Movimiento]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_idDoc int = null   
,  @i_prodServ char(1) = null   
,  @i_tipoMovimiento char(10) = null   
,  @i_idOrdenProducto int = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_idOrdenCliente int = null   
,  @i_valorMov money = null   
,  @i_fechaMov datetime = null   
,  @i_idAutorizacion int = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_idOrdenServicio int = null   
,  @i_cantidad int = null   
,  @i_empresa smallint = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_idSucursal int = null   
,  @i_usuarioing nvarchar(100) = null   
,  @i_idProdServ int = null   
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
          from Movimiento
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert Movimiento off  --solo aplica si tiene identity


          insert into  Movimiento (
              idDoc
              ,prodServ
              ,tipoMovimiento
              ,idOrdenProducto
              ,maquinamod
              ,idOrdenCliente
              ,valorMov
              ,fechaMov
              ,idAutorizacion
              ,idOrdenServicio
              ,cantidad
              ,empresa
              ,maquinaing
              ,idSucursal
              ,idProdServ
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_idDoc
              ,@i_prodServ
              ,@i_tipoMovimiento
              ,@i_idOrdenProducto
              ,@i_maquinamod
              ,@i_idOrdenCliente
              ,@i_valorMov
              ,@i_fechaMov
              ,@i_idAutorizacion
              ,@i_idOrdenServicio
              ,@i_cantidad
              ,@i_empresa
              ,@i_maquinaing
              ,@i_idSucursal
              ,@i_idProdServ
              ,@i_usuarioing
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
      from Movimiento
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update Movimiento
         set
              idDoc = isnull(@i_idDoc, t.idDoc)
              ,prodServ = isnull(@i_prodServ, t.prodServ)
              ,tipoMovimiento = isnull(@i_tipoMovimiento, t.tipoMovimiento)
              ,idOrdenProducto = isnull(@i_idOrdenProducto, t.idOrdenProducto)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,idOrdenCliente = isnull(@i_idOrdenCliente, t.idOrdenCliente)
              ,valorMov = isnull(@i_valorMov, t.valorMov)
              ,fechaMov = isnull(@i_fechaMov, t.fechaMov)
              ,idAutorizacion = isnull(@i_idAutorizacion, t.idAutorizacion)
              ,idOrdenServicio = isnull(@i_idOrdenServicio, t.idOrdenServicio)
              ,cantidad = isnull(@i_cantidad, t.cantidad)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,idSucursal = isnull(@i_idSucursal, t.idSucursal)
              ,idProdServ = isnull(@i_idProdServ, t.idProdServ)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from Movimiento t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from Movimiento
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
         
         update Movimiento                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_MovimientoCuentaXCobrar]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_MovimientoCuentaXCobrar]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_idDoc int = null   
,  @i_creditoDebito char(1) = null   
,  @i_idCliente int = null   
,  @i_montoMov money = null   
,  @i_descripcion nvarchar(400) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_idCuentaXCobrar int = null   
,  @i_fechaMov datetime = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_empresa smallint = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_idSucursal int = null   
,  @i_estMovCuentaXCobrar char(10) = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from MovimientoCuentaXCobrar
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert MovimientoCuentaXCobrar off  --solo aplica si tiene identity


          insert into  MovimientoCuentaXCobrar (
              idDoc
              ,creditoDebito
              ,idCliente
              ,montoMov
              ,descripcion
              ,maquinamod
              ,idCuentaXCobrar
              ,fechaMov
              ,empresa
              ,maquinaing
              ,idSucursal
              ,estMovCuentaXCobrar
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_idDoc
              ,@i_creditoDebito
              ,@i_idCliente
              ,@i_montoMov
              ,@i_descripcion
              ,@i_maquinamod
              ,@i_idCuentaXCobrar
              ,@i_fechaMov
              ,@i_empresa
              ,@i_maquinaing
              ,@i_idSucursal
              ,@i_estMovCuentaXCobrar
              ,@i_usuarioing
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
      from MovimientoCuentaXCobrar
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update MovimientoCuentaXCobrar
         set
              idDoc = isnull(@i_idDoc, t.idDoc)
              ,creditoDebito = isnull(@i_creditoDebito, t.creditoDebito)
              ,idCliente = isnull(@i_idCliente, t.idCliente)
              ,montoMov = isnull(@i_montoMov, t.montoMov)
              ,descripcion = isnull(@i_descripcion, t.descripcion)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,idCuentaXCobrar = isnull(@i_idCuentaXCobrar, t.idCuentaXCobrar)
              ,fechaMov = isnull(@i_fechaMov, t.fechaMov)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,idSucursal = isnull(@i_idSucursal, t.idSucursal)
              ,estMovCuentaXCobrar = isnull(@i_estMovCuentaXCobrar, t.estMovCuentaXCobrar)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from MovimientoCuentaXCobrar t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from MovimientoCuentaXCobrar
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
         
         update MovimientoCuentaXCobrar                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_ocupacion]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_ocupacion]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_idCliente int = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_categoria char(10) = null   
,  @i_estado int = null   
,  @i_idEmpresa int = null   
,  @i_puesto char(10) = null   
,  @i_empresa smallint = null   
,  @i_ingresoMensual money = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from ocupacion
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert ocupacion off  --solo aplica si tiene identity


          insert into  ocupacion (
              idCliente
              ,maquinamod
              ,categoria
              ,estado
              ,idEmpresa
              ,puesto
              ,empresa
              ,ingresoMensual
              ,maquinaing
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_idCliente
              ,@i_maquinamod
              ,@i_categoria
              ,@i_estado
              ,@i_idEmpresa
              ,@i_puesto
              ,@i_empresa
              ,@i_ingresoMensual
              ,@i_maquinaing
              ,@i_usuarioing
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
      from ocupacion
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update ocupacion
         set
              idCliente = isnull(@i_idCliente, t.idCliente)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,categoria = isnull(@i_categoria, t.categoria)
              ,estado = isnull(@i_estado, t.estado)
              ,idEmpresa = isnull(@i_idEmpresa, t.idEmpresa)
              ,puesto = isnull(@i_puesto, t.puesto)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,ingresoMensual = isnull(@i_ingresoMensual, t.ingresoMensual)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from ocupacion t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from ocupacion
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
         
         update ocupacion                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_OrdenCliente]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_OrdenCliente]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_idCitaActual int = null   
,  @i_estaAbierta char(1) = null   
,  @i_fecha datetime = null   
,  @i_comentarios text = null   
,  @i_fechaFin char(8) = null   
,  @i_maquinamod varchar(50) = null   
,  @i_dia int = null   
,  @i_estRegistro char(2) = null   
,  @i_usuariomod varchar(50) = null   
,  @i_cliente int = null   
,  @i_empresa int = null   
,  @i_maquinaing varchar(50) = null   
,  @i_idSucursal int = null   
,  @i_idPersonaPresupuesto int = null   
,  @i_usuarioing varchar(50) = null   
,  @i_fechaInicio char(8) = null   
,  @i_idCitaProxima int = null   
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
          from OrdenCliente
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert OrdenCliente off  --solo aplica si tiene identity


          insert into  OrdenCliente (
              idCitaActual
              ,estaAbierta
              ,fecha
              ,comentarios
              ,fechaFin
              ,maquinamod
              ,dia
              ,estRegistro
              ,cliente
              ,empresa
              ,maquinaing
              ,idSucursal
              ,idPersonaPresupuesto
              ,fechaInicio
              ,idCitaProxima
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_idCitaActual
              ,@i_estaAbierta
              ,@i_fecha
              ,@i_comentarios
              ,@i_fechaFin
              ,@i_maquinamod
              ,@i_dia
              ,@i_estRegistro
              ,@i_cliente
              ,@i_empresa
              ,@i_maquinaing
              ,@i_idSucursal
              ,@i_idPersonaPresupuesto
              ,@i_fechaInicio
              ,@i_idCitaProxima
              ,@i_usuarioing
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
      from OrdenCliente
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update OrdenCliente
         set
              idCitaActual = isnull(@i_idCitaActual, t.idCitaActual)
              ,estaAbierta = isnull(@i_estaAbierta, t.estaAbierta)
              ,fecha = isnull(@i_fecha, t.fecha)
              ,comentarios = isnull(@i_comentarios, t.comentarios)
              ,fechaFin = isnull(@i_fechaFin, t.fechaFin)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,dia = isnull(@i_dia, t.dia)
              ,estRegistro = isnull(@i_estRegistro, t.estRegistro)
              ,cliente = isnull(@i_cliente, t.cliente)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,idSucursal = isnull(@i_idSucursal, t.idSucursal)
              ,idPersonaPresupuesto = isnull(@i_idPersonaPresupuesto, t.idPersonaPresupuesto)
              ,fechaInicio = isnull(@i_fechaInicio, t.fechaInicio)
              ,idCitaProxima = isnull(@i_idCitaProxima, t.idCitaProxima)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from OrdenCliente t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from OrdenCliente
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
         
         update OrdenCliente                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_Paquete]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_Paquete]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_descripcion nvarchar(400) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_nombre nvarchar(200) = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_precio money = null   
,  @i_empresa smallint = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_estPaquete nchar(20) = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from Paquete
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert Paquete off  --solo aplica si tiene identity


          insert into  Paquete (
              descripcion
              ,maquinamod
              ,nombre
              ,precio
              ,empresa
              ,maquinaing
              ,estPaquete
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_descripcion
              ,@i_maquinamod
              ,@i_nombre
              ,@i_precio
              ,@i_empresa
              ,@i_maquinaing
              ,@i_estPaquete
              ,@i_usuarioing
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
      from Paquete
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update Paquete
         set
              descripcion = isnull(@i_descripcion, t.descripcion)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,nombre = isnull(@i_nombre, t.nombre)
              ,precio = isnull(@i_precio, t.precio)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,estPaquete = isnull(@i_estPaquete, t.estPaquete)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from Paquete t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from Paquete
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
         
         update Paquete                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_Persona]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_Persona]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_identifica nvarchar(100) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_nombre2 nvarchar(100) = null   
,  @i_nombre1 nvarchar(100) = null   
,  @i_nombrelargo nvarchar(500) = null   
,  @i_nombre3 nvarchar(100) = null   
,  @i_apecasada nvarchar(100) = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_recibePublicidad int = null   
,  @i_apellido2 nvarchar(100) = null   
,  @i_apellido1 nvarchar(100) = null   
,  @i_tipoident char(10) = null   
,  @i_fechanac datetime = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_genero char(1) = null   
,  @i_ocupacion char(10) = null   
,  @i_estadocivil char(10) = null   
,  @i_estado int = null   
,  @i_nit nvarchar(100) = null   
,  @i_empresa smallint = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from Persona
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert Persona off  --solo aplica si tiene identity


          insert into  Persona (
              identifica
              ,maquinamod
              ,nombre2
              ,nombre1
              ,nombrelargo
              ,nombre3
              ,apecasada
              ,maquinaing
              ,recibePublicidad
              ,apellido2
              ,apellido1
              ,tipoident
              ,fechanac
              ,genero
              ,ocupacion
              ,estadocivil
              ,estado
              ,nit
              ,empresa
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_identifica
              ,@i_maquinamod
              ,@i_nombre2
              ,@i_nombre1
              ,@i_nombrelargo
              ,@i_nombre3
              ,@i_apecasada
              ,@i_maquinaing
              ,@i_recibePublicidad
              ,@i_apellido2
              ,@i_apellido1
              ,@i_tipoident
              ,@i_fechanac
              ,@i_genero
              ,@i_ocupacion
              ,@i_estadocivil
              ,@i_estado
              ,@i_nit
              ,@i_empresa
              ,@i_usuarioing
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
      from Persona
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update Persona
         set
              identifica = isnull(@i_identifica, t.identifica)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,nombre2 = isnull(@i_nombre2, t.nombre2)
              ,nombre1 = isnull(@i_nombre1, t.nombre1)
              ,nombrelargo = isnull(@i_nombrelargo, t.nombrelargo)
              ,nombre3 = isnull(@i_nombre3, t.nombre3)
              ,apecasada = isnull(@i_apecasada, t.apecasada)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,recibePublicidad = isnull(@i_recibePublicidad, t.recibePublicidad)
              ,apellido2 = isnull(@i_apellido2, t.apellido2)
              ,apellido1 = isnull(@i_apellido1, t.apellido1)
              ,tipoident = isnull(@i_tipoident, t.tipoident)
              ,fechanac = isnull(@i_fechanac, t.fechanac)
              ,genero = isnull(@i_genero, t.genero)
              ,ocupacion = isnull(@i_ocupacion, t.ocupacion)
              ,estadocivil = isnull(@i_estadocivil, t.estadocivil)
              ,estado = isnull(@i_estado, t.estado)
              ,nit = isnull(@i_nit, t.nit)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from Persona t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from Persona
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
         
         update Persona                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_PrespuestoPersona]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_PrespuestoPersona]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_plazo varchar(10) = null   
,  @i_maquinamod varchar(50) = null   
,  @i_idServicioPlan int = null   
,  @i_usuariomod varchar(50) = null   
,  @i_cuotas int = null   
,  @i_empresa int = null   
,  @i_maquinaing varchar(50) = null   
,  @i_valorTotal money = null   
,  @i_idPersona int = null   
,  @i_periodo varchar(10) = null   
,  @i_descuentoTotal money = null   
,  @i_usuarioing varchar(50) = null   
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
          from PrespuestoPersona
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert PrespuestoPersona off  --solo aplica si tiene identity


          insert into  PrespuestoPersona (
              plazo
              ,maquinamod
              ,idServicioPlan
              ,cuotas
              ,empresa
              ,maquinaing
              ,valorTotal
              ,idPersona
              ,periodo
              ,descuentoTotal
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_plazo
              ,@i_maquinamod
              ,@i_idServicioPlan
              ,@i_cuotas
              ,@i_empresa
              ,@i_maquinaing
              ,@i_valorTotal
              ,@i_idPersona
              ,@i_periodo
              ,@i_descuentoTotal
              ,@i_usuarioing
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
      from PrespuestoPersona
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update PrespuestoPersona
         set
              plazo = isnull(@i_plazo, t.plazo)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,idServicioPlan = isnull(@i_idServicioPlan, t.idServicioPlan)
              ,cuotas = isnull(@i_cuotas, t.cuotas)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,valorTotal = isnull(@i_valorTotal, t.valorTotal)
              ,idPersona = isnull(@i_idPersona, t.idPersona)
              ,periodo = isnull(@i_periodo, t.periodo)
              ,descuentoTotal = isnull(@i_descuentoTotal, t.descuentoTotal)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from PrespuestoPersona t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from PrespuestoPersona
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
         
         update PrespuestoPersona                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_ProductoExistencia]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_ProductoExistencia]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_maquinamod nvarchar(100) = null   
,  @i_idProd int = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_precioUnitario money = null   
,  @i_cantidad int = null   
,  @i_empresa smallint = null   
,  @i_idSucursal int = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_fechaCaducidad datetime = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from ProductoExistencia
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert ProductoExistencia off  --solo aplica si tiene identity


          insert into  ProductoExistencia (
              maquinamod
              ,idProd
              ,precioUnitario
              ,cantidad
              ,empresa
              ,idSucursal
              ,maquinaing
              ,fechaCaducidad
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_maquinamod
              ,@i_idProd
              ,@i_precioUnitario
              ,@i_cantidad
              ,@i_empresa
              ,@i_idSucursal
              ,@i_maquinaing
              ,@i_fechaCaducidad
              ,@i_usuarioing
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
      from ProductoExistencia
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update ProductoExistencia
         set
              maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,idProd = isnull(@i_idProd, t.idProd)
              ,precioUnitario = isnull(@i_precioUnitario, t.precioUnitario)
              ,cantidad = isnull(@i_cantidad, t.cantidad)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,idSucursal = isnull(@i_idSucursal, t.idSucursal)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,fechaCaducidad = isnull(@i_fechaCaducidad, t.fechaCaducidad)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from ProductoExistencia t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from ProductoExistencia
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
         
         update ProductoExistencia                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_Proveedor]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_Proveedor]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_tipoProveedor char(10) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_nombre2 nvarchar(200) = null   
,  @i_nombre1 nvarchar(200) = null   
,  @i_nit nvarchar(100) = null   
,  @i_empresa smallint = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from Proveedor
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert Proveedor off  --solo aplica si tiene identity


          insert into  Proveedor (
              tipoProveedor
              ,maquinamod
              ,nombre2
              ,nombre1
              ,nit
              ,empresa
              ,maquinaing
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_tipoProveedor
              ,@i_maquinamod
              ,@i_nombre2
              ,@i_nombre1
              ,@i_nit
              ,@i_empresa
              ,@i_maquinaing
              ,@i_usuarioing
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
      from Proveedor
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update Proveedor
         set
              tipoProveedor = isnull(@i_tipoProveedor, t.tipoProveedor)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,nombre2 = isnull(@i_nombre2, t.nombre2)
              ,nombre1 = isnull(@i_nombre1, t.nombre1)
              ,nit = isnull(@i_nit, t.nit)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from Proveedor t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from Proveedor
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
         
         update Proveedor                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_SalidaEfectivoCaja]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_SalidaEfectivoCaja]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_idDoc int = null   
,  @i_confirmaCierreCaja int = null   
,  @i_motivoSalidaEfectivo char(10) = null   
,  @i_moneda char(10) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_idAutorizacion int = null   
,  @i_idCierreCaja int = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_idFacturaFormaPago int = null   
,  @i_empresa smallint = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_idSucursal int = null   
,  @i_fechaHoraSEC datetime = null   
,  @i_usuarioing nvarchar(100) = null   
,  @i_monto money = null   
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
          from SalidaEfectivoCaja
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert SalidaEfectivoCaja off  --solo aplica si tiene identity


          insert into  SalidaEfectivoCaja (
              idDoc
              ,confirmaCierreCaja
              ,motivoSalidaEfectivo
              ,moneda
              ,maquinamod
              ,idAutorizacion
              ,idCierreCaja
              ,idFacturaFormaPago
              ,empresa
              ,maquinaing
              ,idSucursal
              ,fechaHoraSEC
              ,monto
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_idDoc
              ,@i_confirmaCierreCaja
              ,@i_motivoSalidaEfectivo
              ,@i_moneda
              ,@i_maquinamod
              ,@i_idAutorizacion
              ,@i_idCierreCaja
              ,@i_idFacturaFormaPago
              ,@i_empresa
              ,@i_maquinaing
              ,@i_idSucursal
              ,@i_fechaHoraSEC
              ,@i_monto
              ,@i_usuarioing
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
      from SalidaEfectivoCaja
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update SalidaEfectivoCaja
         set
              idDoc = isnull(@i_idDoc, t.idDoc)
              ,confirmaCierreCaja = isnull(@i_confirmaCierreCaja, t.confirmaCierreCaja)
              ,motivoSalidaEfectivo = isnull(@i_motivoSalidaEfectivo, t.motivoSalidaEfectivo)
              ,moneda = isnull(@i_moneda, t.moneda)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,idAutorizacion = isnull(@i_idAutorizacion, t.idAutorizacion)
              ,idCierreCaja = isnull(@i_idCierreCaja, t.idCierreCaja)
              ,idFacturaFormaPago = isnull(@i_idFacturaFormaPago, t.idFacturaFormaPago)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,idSucursal = isnull(@i_idSucursal, t.idSucursal)
              ,fechaHoraSEC = isnull(@i_fechaHoraSEC, t.fechaHoraSEC)
              ,monto = isnull(@i_monto, t.monto)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from SalidaEfectivoCaja t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from SalidaEfectivoCaja
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
         
         update SalidaEfectivoCaja                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_SerieFactura]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_SerieFactura]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_fechaVigencia datetime = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_noFactura int = null   
,  @i_estRegistro char(10) = null   
,  @i_tipoCorrelativo char(10) = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_serie varchar(50) = null   
,  @i_rangoFinal int = null   
,  @i_terminal varchar(50) = null   
,  @i_rangoInicio int = null   
,  @i_empresa smallint = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_idSucursal int = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from SerieFactura
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert SerieFactura off  --solo aplica si tiene identity


          insert into  SerieFactura (
              fechaVigencia
              ,maquinamod
              ,noFactura
              ,estRegistro
              ,tipoCorrelativo
              ,serie
              ,rangoFinal
              ,terminal
              ,rangoInicio
              ,empresa
              ,maquinaing
              ,idSucursal
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_fechaVigencia
              ,@i_maquinamod
              ,@i_noFactura
              ,@i_estRegistro
              ,@i_tipoCorrelativo
              ,@i_serie
              ,@i_rangoFinal
              ,@i_terminal
              ,@i_rangoInicio
              ,@i_empresa
              ,@i_maquinaing
              ,@i_idSucursal
              ,@i_usuarioing
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
      from SerieFactura
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update SerieFactura
         set
              fechaVigencia = isnull(@i_fechaVigencia, t.fechaVigencia)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,noFactura = isnull(@i_noFactura, t.noFactura)
              ,estRegistro = isnull(@i_estRegistro, t.estRegistro)
              ,tipoCorrelativo = isnull(@i_tipoCorrelativo, t.tipoCorrelativo)
              ,serie = isnull(@i_serie, t.serie)
              ,rangoFinal = isnull(@i_rangoFinal, t.rangoFinal)
              ,terminal = isnull(@i_terminal, t.terminal)
              ,rangoInicio = isnull(@i_rangoInicio, t.rangoInicio)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,idSucursal = isnull(@i_idSucursal, t.idSucursal)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from SerieFactura t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from SerieFactura
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
         
         update SerieFactura                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_Servicio]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_Servicio]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_duracionServicio int = null   
,  @i_descripcion nvarchar(300) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_idEmpresaArea int = null   
,  @i_nombre nvarchar(100) = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_tipoServicio int = null   
,  @i_empresa smallint = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from Servicio
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert Servicio off  --solo aplica si tiene identity


          insert into  Servicio (
              duracionServicio
              ,descripcion
              ,maquinamod
              ,idEmpresaArea
              ,nombre
              ,tipoServicio
              ,empresa
              ,maquinaing
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_duracionServicio
              ,@i_descripcion
              ,@i_maquinamod
              ,@i_idEmpresaArea
              ,@i_nombre
              ,@i_tipoServicio
              ,@i_empresa
              ,@i_maquinaing
              ,@i_usuarioing
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
      from Servicio
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update Servicio
         set
              duracionServicio = isnull(@i_duracionServicio, t.duracionServicio)
              ,descripcion = isnull(@i_descripcion, t.descripcion)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,idEmpresaArea = isnull(@i_idEmpresaArea, t.idEmpresaArea)
              ,nombre = isnull(@i_nombre, t.nombre)
              ,tipoServicio = isnull(@i_tipoServicio, t.tipoServicio)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from Servicio t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from Servicio
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
         
         update Servicio                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_ServicioPlan]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_ServicioPlan]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_plazo char(10) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_descuento money = null   
,  @i_cuotas money = null   
,  @i_empresa smallint = null   
,  @i_idSucursal int = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_periodo char(10) = null   
,  @i_usuarioing nvarchar(100) = null   
,  @i_montoTotal money = null   
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
          from ServicioPlan
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert ServicioPlan off  --solo aplica si tiene identity


          insert into  ServicioPlan (
              plazo
              ,maquinamod
              ,descuento
              ,cuotas
              ,empresa
              ,idSucursal
              ,maquinaing
              ,periodo
              ,montoTotal
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_plazo
              ,@i_maquinamod
              ,@i_descuento
              ,@i_cuotas
              ,@i_empresa
              ,@i_idSucursal
              ,@i_maquinaing
              ,@i_periodo
              ,@i_montoTotal
              ,@i_usuarioing
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
      from ServicioPlan
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update ServicioPlan
         set
              plazo = isnull(@i_plazo, t.plazo)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,descuento = isnull(@i_descuento, t.descuento)
              ,cuotas = isnull(@i_cuotas, t.cuotas)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,idSucursal = isnull(@i_idSucursal, t.idSucursal)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,periodo = isnull(@i_periodo, t.periodo)
              ,montoTotal = isnull(@i_montoTotal, t.montoTotal)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from ServicioPlan t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from ServicioPlan
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
         
         update ServicioPlan                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_Sucursal]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_Sucursal]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_direccion nvarchar(400) = null   
,  @i_telefono nvarchar(100) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_nombre nvarchar(200) = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_empresa smallint = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_encargado int = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from Sucursal
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert Sucursal off  --solo aplica si tiene identity


          insert into  Sucursal (
              direccion
              ,telefono
              ,maquinamod
              ,nombre
              ,empresa
              ,maquinaing
              ,encargado
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_direccion
              ,@i_telefono
              ,@i_maquinamod
              ,@i_nombre
              ,@i_empresa
              ,@i_maquinaing
              ,@i_encargado
              ,@i_usuarioing
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
      from Sucursal
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update Sucursal
         set
              direccion = isnull(@i_direccion, t.direccion)
              ,telefono = isnull(@i_telefono, t.telefono)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,nombre = isnull(@i_nombre, t.nombre)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,encargado = isnull(@i_encargado, t.encargado)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from Sucursal t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from Sucursal
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
         
         update Sucursal                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_Terminal]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_Terminal]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_terminalIP varchar(20) = null   
,  @i_direccionFija char(1) = null   
,  @i_maquinamod varchar(50) = null   
,  @i_usuariomod varchar(50) = null   
,  @i_empresa int = null   
,  @i_maquinaing varchar(50) = null   
,  @i_terminalNombre varchar(50) = null   
,  @i_usuarioing varchar(50) = null   
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
          from Terminal
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert Terminal off  --solo aplica si tiene identity


          insert into  Terminal (
              terminalIP
              ,direccionFija
              ,maquinamod
              ,empresa
              ,maquinaing
              ,terminalNombre
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_terminalIP
              ,@i_direccionFija
              ,@i_maquinamod
              ,@i_empresa
              ,@i_maquinaing
              ,@i_terminalNombre
              ,@i_usuarioing
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
      from Terminal
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update Terminal
         set
              terminalIP = isnull(@i_terminalIP, t.terminalIP)
              ,direccionFija = isnull(@i_direccionFija, t.direccionFija)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,terminalNombre = isnull(@i_terminalNombre, t.terminalNombre)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from Terminal t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from Terminal
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
         
         update Terminal                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_TipoServicio]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_TipoServicio]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_descripcion nvarchar(300) = null   
,  @i_padre int = null   
,  @i_cuentaSAP nvarchar(100) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_nombre nvarchar(100) = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_coordinacion char(10) = null   
,  @i_empresa smallint = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from TipoServicio
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert TipoServicio off  --solo aplica si tiene identity


          insert into  TipoServicio (
              descripcion
              ,padre
              ,cuentaSAP
              ,maquinamod
              ,nombre
              ,coordinacion
              ,empresa
              ,maquinaing
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_descripcion
              ,@i_padre
              ,@i_cuentaSAP
              ,@i_maquinamod
              ,@i_nombre
              ,@i_coordinacion
              ,@i_empresa
              ,@i_maquinaing
              ,@i_usuarioing
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
      from TipoServicio
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update TipoServicio
         set
              descripcion = isnull(@i_descripcion, t.descripcion)
              ,padre = isnull(@i_padre, t.padre)
              ,cuentaSAP = isnull(@i_cuentaSAP, t.cuentaSAP)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,nombre = isnull(@i_nombre, t.nombre)
              ,coordinacion = isnull(@i_coordinacion, t.coordinacion)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from TipoServicio t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from TipoServicio
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
         
         update TipoServicio                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_Ubicacion]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_Ubicacion]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_idDireccion int = null   
,  @i_descripcion varchar(250) = null   
,  @i_maquinamod nvarchar(100) = null   
,  @i_usuariomod nvarchar(100) = null   
,  @i_empresa smallint = null   
,  @i_idSucursal int = null   
,  @i_maquinaing nvarchar(100) = null   
,  @i_idEncargado int = null   
,  @i_usuarioing nvarchar(100) = null   
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
          from Ubicacion
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert Ubicacion off  --solo aplica si tiene identity


          insert into  Ubicacion (
              idDireccion
              ,descripcion
              ,maquinamod
              ,empresa
              ,idSucursal
              ,maquinaing
              ,idEncargado
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_idDireccion
              ,@i_descripcion
              ,@i_maquinamod
              ,@i_empresa
              ,@i_idSucursal
              ,@i_maquinaing
              ,@i_idEncargado
              ,@i_usuarioing
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
      from Ubicacion
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update Ubicacion
         set
              idDireccion = isnull(@i_idDireccion, t.idDireccion)
              ,descripcion = isnull(@i_descripcion, t.descripcion)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,idSucursal = isnull(@i_idSucursal, t.idSucursal)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,idEncargado = isnull(@i_idEncargado, t.idEncargado)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from Ubicacion t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from Ubicacion
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
         
         update Ubicacion                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  StoredProcedure [dbo].[sp_mantto_Usuario]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_mantto_Usuario]
/************************************************/
/*   nombre programa :                                             */
/*   sp prueba de mantto                                           */
/*   autor:                                                        */
/*   xxxxxx                                                        */
/*   fecha:                                                         */
/*   29/02/2016                                                       */
/************************************************/
@i_operacion      char(1)   --tipo de operacion
,  @i_terminalUltimoAcceso varchar(50) = null   
,  @i_maquinamod varchar(50) = null   
,  @i_fechaUltimoAcceso datetime = null   
,  @i_password varchar(500) = null   
,  @i_usuariomod varchar(50) = null   
,  @i_estado varchar(10) = null   
,  @i_empresa int = null   
,  @i_maquinaing varchar(50) = null   
,  @i_login varchar(50) = null   
,  @i_ultimoPassword varchar(500) = null   
,  @i_usuarioing varchar(50) = null   
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
          from Usuario
         where correlativo = @o_correlativo
          
          if @w_eliminado = 'S'
          begin
               select @i_operacion = 'U'
                      , @o_restaurado = 'S'
               goto actualizacion
          end 
         
         --validar datos minimos         
          set identity_insert Usuario off  --solo aplica si tiene identity


          insert into  Usuario (
              terminalUltimoAcceso
              ,maquinamod
              ,fechaUltimoAcceso
              ,password
              ,estado
              ,empresa
              ,maquinaing
              ,login
              ,ultimoPassword
              ,usuarioing
              ,fechaing
              ,usuariomod
              ,fechamod
              ,rowVersion
              ,eliminado
          
          ) values (
              @i_terminalUltimoAcceso
              ,@i_maquinamod
              ,@i_fechaUltimoAcceso
              ,@i_password
              ,@i_estado
              ,@i_empresa
              ,@i_maquinaing
              ,@i_login
              ,@i_ultimoPassword
              ,@i_usuarioing
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
      from Usuario
         where correlativo = @o_correlativo
         
         if @w_rowVersion is null
         begin
            select @w_error_msg = 'REGISTRO NO EXISTE'
            goto error
         end
         else
         begin
            if @w_rowVersion <> @o_correlativo
            begin
                select @w_error_msg = 'VERSIONES DE FILAS NO COINCIDEN (' + convert(varchar, @w_rowVersion) + ' <> ' + convert(varchar, @o_correlativo) + ')'
                goto error
            end
         end
         
         if @w_eliminado = 'S'
         begin
              select @w_error_msg = 'REGISTRO YA FUE ELIMINADO'
              goto error
         end
         
         
         select @w_rowVersion = @w_rowVersion + 1
         
         update Usuario
         set
              terminalUltimoAcceso = isnull(@i_terminalUltimoAcceso, t.terminalUltimoAcceso)
              ,maquinamod = isnull(@i_maquinamod, t.maquinamod)
              ,fechaUltimoAcceso = isnull(@i_fechaUltimoAcceso, t.fechaUltimoAcceso)
              ,password = isnull(@i_password, t.password)
              ,estado = isnull(@i_estado, t.estado)
              ,empresa = isnull(@i_empresa, t.empresa)
              ,maquinaing = isnull(@i_maquinaing, t.maquinaing)
              ,login = isnull(@i_login, t.login)
              ,ultimoPassword = isnull(@i_ultimoPassword, t.ultimoPassword)
              ,usuariomod = @i_usuariomod 
              ,fechamod = getdate()
              ,rowVersion = @w_rowVersion
          from Usuario t
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
                select @w_error_msg = 'SE MODIFICARON (' + convert(varchar, @w_rowcount) + ') REGISTROS'
               goto error
          end
          
          select @o_rowVersion = @w_rowVersion          
          
     end



     if @i_operacion = 'D' --eliminacion
     begin
         select @w_rowVersion = rowVersion
               , @w_eliminado = eliminado   --solo eliminacion logica
         from Usuario
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
         
         update Usuario                            --solo eliminacion logica
         set rowVersion = @w_rowVersion
             ,eliminado = 'S'
            , fechamod = getdate()
            , usuariomod = @i_usuariomod
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
    
raiserror (@w_error_msg, 15, 1)
return -1
        
end




GO
/****** Object:  Table [dbo].[Area]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Area](
	[empresa] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[tipoArea] [varchar](50) NOT NULL,
	[descripcion] [varchar](250) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[rowVersion] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AreaImpresora]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AreaImpresora](
	[empresa] [int] NULL,
	[idArea] [int] NOT NULL,
	[idImpresora] [int] NOT NULL,
 CONSTRAINT [PK_AreaImpresora] PRIMARY KEY CLUSTERED 
(
	[idArea] ASC,
	[idImpresora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ArqueoCaja]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
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
/****** Object:  Table [dbo].[AtributoDetalleCatalogo]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AtributoDetalleCatalogo](
	[empresa] [int] NOT NULL,
	[idCatalogo] [int] NOT NULL,
	[codigo] [char](10) NOT NULL,
	[atributo] [varchar](30) NOT NULL,
	[valor] [varchar](10) NOT NULL,
	[estado] [nchar](10) NOT NULL,
	[usuarioing] [nchar](10) NOT NULL,
	[usuariomod] [nchar](10) NULL,
	[fechaing] [nchar](10) NOT NULL,
	[fechamod] [nchar](10) NULL,
	[maquinaing] [nchar](10) NOT NULL,
	[maquinamod] [nchar](10) NULL,
	[rowVersion] [nchar](10) NOT NULL,
	[eliminado] [nchar](10) NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_AtributoDetalleCatalogo] PRIMARY KEY CLUSTERED 
(
	[idCatalogo] ASC,
	[codigo] ASC,
	[atributo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CabCatalogo]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CabCatalogo](
	[empresa] [smallint] NOT NULL,
	[idCatalogo] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[nomVal1] [nvarchar](50) NULL,
	[nomVal2] [nvarchar](50) NULL,
	[nomVal3] [nvarchar](50) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_CabCatalogo_1] PRIMARY KEY CLUSTERED 
(
	[idCatalogo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Chat]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChatCommon]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChatCommon](
	[ChatCommon] [int] NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Activo] [smallint] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cheque]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cheque](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[noCheque] [int] NOT NULL,
	[codigoBanco] [varchar](10) NOT NULL,
	[idCliente] [int] NOT NULL,
	[rechazado] [char](1) NOT NULL,
	[cobrado] [char](1) NOT NULL,
	[fechaCobro] [datetime] NOT NULL,
	[secuencialBanco] [varchar](50) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usauriomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_Cheque] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChequeEnviado]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChequeEnviado](
	[idCheque] [int] NOT NULL,
	[idLote] [int] NOT NULL,
	[empresa] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_ChequeEnviado] PRIMARY KEY CLUSTERED 
(
	[idCheque] ASC,
	[idLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CierreCaja]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_CierreCaja] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idCierreCaja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CierreDiario]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
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
/****** Object:  Table [dbo].[CierreMensualDocumentoPromo]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[rowVersion] [timestamp] NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[CierreMensualDocumentoPromo] ADD [restaurado] [char](1) NOT NULL
 CONSTRAINT [PK_CierreMensualTarjeta_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[anio] ASC,
	[mes] ASC,
	[cliente] ASC,
	[idDocumentoPromo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cita]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cita](
	[empresa] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[idOrdenCliente] [int] NULL,
	[idPersona] [int] NULL,
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
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
	[idServicio] [int] NULL,
	[idEmpleado] [int] NULL,
	[restaurado] [char](1) NULL,
 CONSTRAINT [PK_Cita] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CitaDetalle]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CitaDetalle](
	[empresa] [nchar](10) NULL,
	[correlativo] [nchar](10) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[idPersona] [int] NULL,
	[tipoCliente] [char](10) NULL,
	[clasificacionCliente] [char](10) NULL,
	[ultimoServicio] [datetime] NULL,
	[estaEmbarazada] [char](1) NULL,
	[aplicaFactura] [char](1) NULL,
	[avisoPorInasistencia] [char](1) NULL,
	[ultimaInasistencia] [datetime] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClienteFamiliar]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClienteFamiliar](
	[empresa] [smallint] NOT NULL,
	[idFamiliarPersona] [int] NOT NULL,
	[idCliente] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[usuarioing] [nvarchar](1) NOT NULL,
	[maquinaing] [nvarchar](1) NOT NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_ClienteFamiliar] PRIMARY KEY CLUSTERED 
(
	[idFamiliarPersona] ASC,
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClienteMedioContacto]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ClienteMedioContacto](
	[empresa] [smallint] NULL,
	[idContacto] [int] NULL,
	[idCliente] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[eliminado] [char](1) NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[ClienteMedioContacto] ADD [restaurado] [char](1) NOT NULL

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClienteSesion]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClienteSesion](
	[empresa] [smallint] NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NULL,
	[idServicio] [int] NULL,
	[etapa] [varchar](35) NULL,
	[idOrdenCliente] [int] NULL,
	[idCita] [int] NULL,
	[idEmpleado] [int] NOT NULL,
	[horaInicio] [datetime] NULL,
	[horaFin] [datetime] NULL,
	[evaluacionCliente] [char](10) NULL,
	[notas] [text] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_ClienteSesion] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClienteSesionArchivos]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClienteSesionArchivos](
	[empresa] [smallint] NULL,
	[idSesion] [int] NOT NULL,
	[idImagen] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_ClienteSesionArchivos] PRIMARY KEY CLUSTERED 
(
	[idSesion] ASC,
	[idImagen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CuentaBancaria]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CuentaBancaria](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[noCuenta] [varchar](30) NOT NULL,
	[codigoBanco] [varchar](10) NOT NULL,
	[tipoCuenta] [varchar](10) NOT NULL,
	[estadoCuenta] [varchar](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[rowVersion] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_CuentaBancaria] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CuentaBancariaPersona]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CuentaBancariaPersona](
	[corrPersona] [int] NOT NULL,
	[corrCuenta] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[cuentaUso] [varchar](10) NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_CuentaBancariaPersona] PRIMARY KEY CLUSTERED 
(
	[corrPersona] ASC,
	[corrCuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CuentaContable]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_CuentaContable] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[noCuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CuentaXCobrar]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CuentaXCobrar](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[saldo] [money] NOT NULL,
	[idServicio] [nchar](10) NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_CuentaXCobrar] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Descuento]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Descuento](
	[empresa] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[valor] [money] NOT NULL,
	[aplicaPorcentaje] [char](1) NOT NULL,
	[aplicaValor] [char](1) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[idServicio] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Descuento] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DescuentoMovimiento]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DescuentoMovimiento](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Descuento_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DescuentoServicio]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DescuentoServicio](
	[correlativo] [int] NOT NULL,
	[idServicio] [int] NOT NULL,
	[tipoDescuento] [varchar](50) NOT NULL,
	[descripcion] [varchar](200) NOT NULL,
	[valor] [money] NOT NULL,
	[porValor] [char](1) NOT NULL,
	[porPorcentaje] [char](1) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[empresa] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_DescuentoServicio] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetalleCierreCaja]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
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
/****** Object:  Table [dbo].[DetalleCita]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[empleado] [int] NOT NULL,
	[idServicio] [int] NOT NULL,
	[horaInicio] [char](8) NULL,
	[horaFin] [char](8) NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_DetalleCita] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetalleOrdenProducto]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_DetalleOrdenProducto_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetalleOrdenServicio]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[empleado] [int] NOT NULL,
	[idServicio] [int] NOT NULL,
	[precio] [money] NOT NULL,
	[estRegistro] [char](2) NOT NULL,
	[calificacion] [char](10) NULL,
	[clasificacion] [char](10) NULL,
	[clasificacionCita] [char](10) NULL,
	[comentarios] [varchar](300) NULL,
	[comentariosCo] [varchar](300) NULL,
	[descuentoAplicado] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [timestamp] NOT NULL,
	[idEmpleado] [int] NULL,
	[numeroSesiones] [int] NULL,
	[sesionesRealizadas] [int] NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_DetalleOrdenServicio_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetCatalogo]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetCatalogo](
	[empresa] [smallint] NOT NULL,
	[idCatalogo] [int] NOT NULL,
	[codigo] [char](10) NOT NULL,
	[valor] [nvarchar](100) NOT NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[fechaing] [datetime] NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[rowVersion] [int] NOT NULL,
	[fechamod] [datetime] NULL,
	[eliminado] [char](1) NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_DetCatalogo] PRIMARY KEY CLUSTERED 
(
	[idCatalogo] ASC,
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetCatalogoAtributo]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetCatalogoAtributo](
	[idCatalogo] [int] NOT NULL,
	[codigo] [int] NOT NULL,
	[nombre] [int] NOT NULL,
	[valor] [varchar](50) NOT NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NOT NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[estado] [varchar](50) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[empresa] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_DetCatalogoAtributo] PRIMARY KEY CLUSTERED 
(
	[idCatalogo] ASC,
	[codigo] ASC,
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Direccion]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Direccion](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Direccion] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Documento]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Documento](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Documento_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentoPromo]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DocumentoPromo](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[correlativo] [int] NOT NULL,
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
	[rowVersion] [int] NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[DocumentoPromo] ADD [restaurado] [char](1) NOT NULL
 CONSTRAINT [PK_Tarjeta_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentoPromoPaquete]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[rowVersion] [int] NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[DocumentoPromoPaquete] ADD [restaurado] [char](1) NOT NULL
 CONSTRAINT [PK_TarjetaPaquete_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idDocumentoPromo] ASC,
	[idPaquete] ASC,
	[idDetallePaquete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentoPromoProducto]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[rowVersion] [int] NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[DocumentoPromoProducto] ADD [restaurado] [char](1) NOT NULL
 CONSTRAINT [PK_DocumentoPromoProducto] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idDocumentoPromo] ASC,
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleado](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[idPersona] [int] NOT NULL,
	[tipoEmpleado] [varchar](10) NULL,
	[inicioLabores] [datetime] NOT NULL,
	[sueldoBase] [money] NOT NULL,
	[bonificacion] [money] NULL,
	[tipoPlanilla] [varchar](50) NOT NULL,
	[tieneIGSS] [char](1) NULL,
	[horaExtra] [money] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[empresa] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empresa](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[rubroServicio] [char](10) NOT NULL,
	[categoria] [char](10) NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
	[nit] [varchar](20) NOT NULL,
	[fechaFundacion] [datetime] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Empresa] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmpresaArea]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmpresaArea](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
	[categoriaArea] [varchar](10) NOT NULL,
	[nit] [nchar](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nchar](50) NOT NULL,
	[usuariomod] [nchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_EmpresaArea] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmpresaDireccion]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmpresaDireccion](
	[empresa] [smallint] NULL,
	[idEmpresa] [int] NOT NULL,
	[idDireccion] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_EmpresaDireccion] PRIMARY KEY CLUSTERED 
(
	[idEmpresa] ASC,
	[idDireccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Estudios]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estudios](
	[empresa] [smallint] NOT NULL,
	[idPersona] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[categoria] [char](10) NOT NULL,
	[fechaInicio] [datetime] NOT NULL,
	[fechaFinal] [datetime] NOT NULL,
	[terminado] [char](1) NOT NULL,
	[institucion] [varchar](100) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Estudios] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Evento]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Evento](
	[empresa] [smallint] NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[tipoEvento] [char](10) NULL,
	[categoria] [char](10) NULL,
	[descripcion] [varchar](100) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Evento] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacturaActualCaja]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[rowVersion] [int] NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[FacturaActualCaja] ADD [restaurado] [char](1) NOT NULL
 CONSTRAINT [PK_FacturaActualCaja_1] PRIMARY KEY CLUSTERED 
(
	[terminal] ASC,
	[idDoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacturaFormaPago]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacturaFormaPago](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idCheque] [int] NULL,
	[idDoc] [int] NOT NULL,
	[idMovDocPromo] [int] NULL,
	[idFormaPago] [char](10) NOT NULL,
	[idAutorizacion] [int] NULL,
	[cantidad] [money] NULL,
	[unidades] [int] NULL,
	[noDocumento] [varchar](50) NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_FacturaFormaPago_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Huella]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Huella](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HuellaCliente]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HuellaCliente](
	[empresa] [smallint] NOT NULL,
	[idHuella] [int] NOT NULL,
	[idCliente] [int] NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[estado] [int] NOT NULL,
	[rowVersion] [int] NOT NULL,
 CONSTRAINT [PK_HuellaCliente] PRIMARY KEY CLUSTERED 
(
	[idHuella] ASC,
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Imagen]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Imagen](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[nombreImagen] [nvarchar](75) NOT NULL,
	[imagen] [text] NOT NULL,
	[estImagen] [char](1) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Imagen] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ImagenAtributo]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ImagenAtributo](
	[empresa] [smallint] NOT NULL,
	[idImagen] [int] NOT NULL,
	[codigoAtributo] [char](10) NOT NULL,
	[valor] [varchar](100) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_ImagenAtributo] PRIMARY KEY CLUSTERED 
(
	[idImagen] ASC,
	[codigoAtributo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ImagenCliente]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ImagenCliente](
	[empresa] [smallint] NOT NULL,
	[idImagen] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[tipoImagen] [char](10) NULL,
	[fechaing] [datetime] NOT NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_ImagenCliente] PRIMARY KEY CLUSTERED 
(
	[idImagen] ASC,
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Impresora]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Impresora](
	[empresa] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[impresoraAlias] [varchar](50) NOT NULL,
	[usuarioUltimpresion] [varchar](30) NULL,
	[maquinaUltimpresion] [varchar](30) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[rowVersion] [int] NOT NULL,
	[eliminada] [char](1) NOT NULL,
 CONSTRAINT [PK_Impresora] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoteChequesEnviados]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoteChequesEnviados](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[idPlanillaAsociada] [int] NULL,
	[motivoLote] [varchar](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[usuarioing] [varchar](10) NOT NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[empresa] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_LoteChequesEnviados] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoteDocumentoPromo]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoteDocumentoPromo](
	[empresa] [smallint] NOT NULL,
	[idSucrusal] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_LoteDocumentoPromo] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MedioContacto]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MedioContacto](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[tipoContacto] [char](10) NOT NULL,
	[categoriaContacto] [char](10) NOT NULL,
	[valor] [nvarchar](50) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[idPersona] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_MedioContacto] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Movimiento]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movimiento](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Movimiento_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovimientoCuentaXCobrar]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MovimientoCuentaXCobrar](
	[empresa] [smallint] NOT NULL,
	[idCuentaXCobrar] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[idSucursal] [int] NOT NULL,
	[idDoc] [int] NOT NULL,
	[idCliente] [int] NOT NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_MovimientoCuentaXCobrar_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovimientoDocumentoPromo]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
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
/****** Object:  Table [dbo].[NitFactura]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_NitFactura] PRIMARY KEY CLUSTERED 
(
	[nit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ocupacion]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ocupacion](
	[empresa] [smallint] NULL,
	[idCliente] [int] NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[categoria] [char](10) NULL,
	[puesto] [char](10) NULL,
	[ingresoMensual] [money] NULL,
	[idEmpresa] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK__ocupacio__BE5FA2042B05B79A] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrdenCliente]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrdenCliente](
	[empresa] [int] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[cliente] [int] NOT NULL,
	[fecha] [date] NULL,
	[dia] [int] NULL,
	[fechaInicio] [char](8) NULL,
	[fechaFin] [char](8) NULL,
	[estRegistro] [char](2) NOT NULL,
	[idCitaActual] [int] NULL,
	[idCitaProxima] [int] NULL,
	[estaAbierta] [char](1) NOT NULL,
	[comentarios] [text] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[idPersonaPresupuesto] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_OrdenCliente] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Paquete]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Paquete](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Paquete] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Persona]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Persona](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Persona_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonaDireccion]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PersonaDireccion](
	[empresa] [smallint] NOT NULL,
	[idDireccion] [int] NOT NULL,
	[idPersona] [int] NOT NULL,
	[tipoDireccion] [char](10) NULL,
	[fechaing] [datetime] NOT NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_ClienteDireccion] PRIMARY KEY CLUSTERED 
(
	[idDireccion] ASC,
	[idPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonaEvento]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PersonaEvento](
	[empresa] [smallint] NULL,
	[idEvento] [int] NOT NULL,
	[idPersona] [int] NOT NULL,
	[fechaInicio] [datetime] NULL,
	[fechaFinal] [datetime] NULL,
	[finalizado] [char](1) NULL,
	[nota] [text] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[estado] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_PersonaEvento] PRIMARY KEY CLUSTERED 
(
	[idEvento] ASC,
	[idPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[planilla_empleado]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[empresa] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_planilla_empleado] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[planilla_empleado_rubro]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[empresa] [int] NOT NULL,
 CONSTRAINT [PK_planilla_empleado_rubro] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[planilla_rubro_descripcion]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[empresa] [int] NOT NULL,
 CONSTRAINT [PK_planilla_rubro_descripcion] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[planilla_total]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[empresa] [smallint] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_planillaTotal] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrecioProducto]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_PrecioProducto] PRIMARY KEY CLUSTERED 
(
	[idPrecProdServ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrecioServicio]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrecioServicio](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[tipoPrecio] [char](10) NOT NULL,
	[idServicio] [int] NOT NULL,
	[precio] [money] NOT NULL,
	[precioMaximo] [money] NOT NULL,
	[fechaVigencia] [datetime] NOT NULL,
 CONSTRAINT [PK_PrecioServicio] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrespuestoPersona]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrespuestoPersona](
	[empresa] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[idPersona] [int] NOT NULL,
	[idServicioPlan] [int] NULL,
	[valorTotal] [money] NOT NULL,
	[descuentoTotal] [money] NULL,
	[cuotas] [int] NOT NULL,
	[plazo] [varchar](10) NOT NULL,
	[periodo] [varchar](10) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_PrespuestoPersona] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PresupuestoPersonaDetalle]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PresupuestoPersonaDetalle](
	[empresa] [int] NOT NULL,
	[idPersonaPresupuesto] [int] NOT NULL,
	[idServicio] [int] NOT NULL,
	[idEmpleadoAsignado] [int] NOT NULL,
	[idDescuentoAplicado] [int] NULL,
	[autorizacionDescuento] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_PresupuestoPersonaDetalle] PRIMARY KEY CLUSTERED 
(
	[idPersonaPresupuesto] ASC,
	[idServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[idProd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductoExistencia]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductoExistencia](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[idProd] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precioUnitario] [money] NOT NULL,
	[fechaCaducidad] [datetime] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_ProductoExistencia] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductoProveedor]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_ProductoProveedor] PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC,
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Propina]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Propina] PRIMARY KEY CLUSTERED 
(
	[idPropina] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proveedor]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proveedor](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Proveedor_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SalidaEfectivoCaja]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SalidaEfectivoCaja](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_SalidaEfectivoCaja_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SerieFactura]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SerieFactura](
	[empresa] [smallint] NOT NULL,
	[idSucursal] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_SerieFactura_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Servicio]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Servicio](
	[empresa] [smallint] NOT NULL,
	[tipoServicio] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[restaurado] [char](1) NOT NULL,
	[idEmpresaArea] [int] NOT NULL,
 CONSTRAINT [PK_Servicio_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServicioEmpleado]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_ServicioEmpleado_1] PRIMARY KEY CLUSTERED 
(
	[idServicio] ASC,
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServicioEtapa]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ServicioEtapa](
	[empresa] [smallint] NULL,
	[idServicio] [int] NOT NULL,
	[etapa] [varchar](35) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[duracion] [int] NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[idServicioPlan] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_ServicioEtapa] PRIMARY KEY CLUSTERED 
(
	[idServicio] ASC,
	[etapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServicioPlan]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ServicioPlan](
	[empresa] [smallint] NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[idSucursal] [int] NULL,
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
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_ServicioPlan] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sucursal]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sucursal](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Sucursal_1] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SucursalServicio]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_SucursalServicio_1] PRIMARY KEY CLUSTERED 
(
	[idSucursal] ASC,
	[idServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Terminal]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Terminal](
	[empresa] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[terminalNombre] [varchar](50) NOT NULL,
	[terminalIP] [varchar](20) NOT NULL,
	[direccionFija] [char](1) NOT NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[rowVersion] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Terminal] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TerminalArea]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TerminalArea](
	[empresa] [int] NULL,
	[idTerminal] [int] NOT NULL,
	[idArea] [int] NOT NULL,
 CONSTRAINT [PK_TerminalArea] PRIMARY KEY CLUSTERED 
(
	[idTerminal] ASC,
	[idArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoProducto]    Script Date: 21/07/2016 11:47:33 p.m. ******/
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_TipoProducto] PRIMARY KEY CLUSTERED 
(
	[idTipoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoServicio]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoServicio](
	[empresa] [smallint] NOT NULL,
	[correlativo] [int] NOT NULL,
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
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_TipoServicio] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ubicacion]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ubicacion](
	[empresa] [smallint] NULL,
	[idSucursal] [int] NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
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
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Ubicacion] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UbicacionAtributo]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UbicacionAtributo](
	[empresa] [smallint] NOT NULL,
	[idUbicacion] [int] NOT NULL,
	[nombre] [varchar](30) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[valor] [varchar](20) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [nvarchar](50) NOT NULL,
	[usuariomod] [nvarchar](50) NULL,
	[maquinaing] [nvarchar](50) NOT NULL,
	[maquinamod] [nvarchar](50) NULL,
	[eliminado] [char](1) NOT NULL,
	[rowVersion] [int] NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_UbicacionAtributo] PRIMARY KEY CLUSTERED 
(
	[idUbicacion] ASC,
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 21/07/2016 11:47:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[empresa] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[login] [varchar](50) NOT NULL,
	[password] [varchar](500) NOT NULL,
	[estado] [varchar](10) NOT NULL,
	[ultimoPassword] [varchar](500) NOT NULL,
	[fechaUltimoAcceso] [datetime] NULL,
	[terminalUltimoAcceso] [varchar](50) NULL,
	[fechaing] [datetime] NOT NULL,
	[fechamod] [datetime] NULL,
	[usuarioing] [varchar](50) NOT NULL,
	[usuariomod] [varchar](50) NULL,
	[maquinaing] [varchar](50) NOT NULL,
	[maquinamod] [varchar](50) NULL,
	[rowVersion] [int] NOT NULL,
	[eliminado] [char](1) NOT NULL,
	[restaurado] [char](1) NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[AreaImpresora]  WITH CHECK ADD  CONSTRAINT [FK_AreaImpresora_Area] FOREIGN KEY([idArea])
REFERENCES [dbo].[Area] ([correlativo])
GO
ALTER TABLE [dbo].[AreaImpresora] CHECK CONSTRAINT [FK_AreaImpresora_Area]
GO
ALTER TABLE [dbo].[AreaImpresora]  WITH CHECK ADD  CONSTRAINT [FK_AreaImpresora_Impresora] FOREIGN KEY([idImpresora])
REFERENCES [dbo].[Impresora] ([correlativo])
GO
ALTER TABLE [dbo].[AreaImpresora] CHECK CONSTRAINT [FK_AreaImpresora_Impresora]
GO
ALTER TABLE [dbo].[AtributoDetalleCatalogo]  WITH CHECK ADD  CONSTRAINT [FK_AtributoDetalleCatalogo_DetCatalogo] FOREIGN KEY([idCatalogo], [codigo])
REFERENCES [dbo].[DetCatalogo] ([idCatalogo], [codigo])
GO
ALTER TABLE [dbo].[AtributoDetalleCatalogo] CHECK CONSTRAINT [FK_AtributoDetalleCatalogo_DetCatalogo]
GO
ALTER TABLE [dbo].[ChequeEnviado]  WITH CHECK ADD  CONSTRAINT [FK_ChequeEnviado_Cheque] FOREIGN KEY([idCheque])
REFERENCES [dbo].[Cheque] ([correlativo])
GO
ALTER TABLE [dbo].[ChequeEnviado] CHECK CONSTRAINT [FK_ChequeEnviado_Cheque]
GO
ALTER TABLE [dbo].[ChequeEnviado]  WITH CHECK ADD  CONSTRAINT [FK_ChequeEnviado_LoteChequesEnviados] FOREIGN KEY([idLote])
REFERENCES [dbo].[LoteChequesEnviados] ([correlativo])
GO
ALTER TABLE [dbo].[ChequeEnviado] CHECK CONSTRAINT [FK_ChequeEnviado_LoteChequesEnviados]
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Persona] FOREIGN KEY([idPersona])
REFERENCES [dbo].[Persona] ([correlativo])
GO
ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [FK_Cliente_Persona]
GO
ALTER TABLE [dbo].[ClienteFamiliar]  WITH CHECK ADD  CONSTRAINT [FK_ClienteFamiliar_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([correlativo])
GO
ALTER TABLE [dbo].[ClienteFamiliar] CHECK CONSTRAINT [FK_ClienteFamiliar_Cliente]
GO
ALTER TABLE [dbo].[ClienteFamiliar]  WITH CHECK ADD  CONSTRAINT [FK_ClienteFamiliar_Persona] FOREIGN KEY([idFamiliarPersona])
REFERENCES [dbo].[Persona] ([correlativo])
GO
ALTER TABLE [dbo].[ClienteFamiliar] CHECK CONSTRAINT [FK_ClienteFamiliar_Persona]
GO
ALTER TABLE [dbo].[ClienteSesion]  WITH CHECK ADD  CONSTRAINT [FK_ClienteSesion_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([correlativo])
GO
ALTER TABLE [dbo].[ClienteSesion] CHECK CONSTRAINT [FK_ClienteSesion_Cliente]
GO
ALTER TABLE [dbo].[ClienteSesionArchivos]  WITH CHECK ADD  CONSTRAINT [FK_ClienteSesionArchivos_ClienteSesion] FOREIGN KEY([idSesion])
REFERENCES [dbo].[ClienteSesion] ([correlativo])
GO
ALTER TABLE [dbo].[ClienteSesionArchivos] CHECK CONSTRAINT [FK_ClienteSesionArchivos_ClienteSesion]
GO
ALTER TABLE [dbo].[CuentaBancariaPersona]  WITH CHECK ADD  CONSTRAINT [FK_CuentaBancariaPersona_CuentaBancaria] FOREIGN KEY([corrCuenta])
REFERENCES [dbo].[CuentaBancaria] ([correlativo])
GO
ALTER TABLE [dbo].[CuentaBancariaPersona] CHECK CONSTRAINT [FK_CuentaBancariaPersona_CuentaBancaria]
GO
ALTER TABLE [dbo].[CuentaBancariaPersona]  WITH CHECK ADD  CONSTRAINT [FK_CuentaBancariaPersona_Persona] FOREIGN KEY([corrCuenta])
REFERENCES [dbo].[Persona] ([correlativo])
GO
ALTER TABLE [dbo].[CuentaBancariaPersona] CHECK CONSTRAINT [FK_CuentaBancariaPersona_Persona]
GO
ALTER TABLE [dbo].[CuentaXCobrar]  WITH CHECK ADD  CONSTRAINT [FK_CuentaXCobrar_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([correlativo])
GO
ALTER TABLE [dbo].[CuentaXCobrar] CHECK CONSTRAINT [FK_CuentaXCobrar_Cliente]
GO
ALTER TABLE [dbo].[DescuentoMovimiento]  WITH CHECK ADD  CONSTRAINT [FK_Descuento_Documento] FOREIGN KEY([idDoc])
REFERENCES [dbo].[Documento] ([correlativo])
GO
ALTER TABLE [dbo].[DescuentoMovimiento] CHECK CONSTRAINT [FK_Descuento_Documento]
GO
ALTER TABLE [dbo].[DescuentoMovimiento]  WITH CHECK ADD  CONSTRAINT [FK_Descuento_Movimiento] FOREIGN KEY([idMov])
REFERENCES [dbo].[Movimiento] ([correlativo])
GO
ALTER TABLE [dbo].[DescuentoMovimiento] CHECK CONSTRAINT [FK_Descuento_Movimiento]
GO
ALTER TABLE [dbo].[DescuentoServicio]  WITH CHECK ADD  CONSTRAINT [FK_DescuentoServicio_Servicio] FOREIGN KEY([idServicio])
REFERENCES [dbo].[Servicio] ([correlativo])
GO
ALTER TABLE [dbo].[DescuentoServicio] CHECK CONSTRAINT [FK_DescuentoServicio_Servicio]
GO
ALTER TABLE [dbo].[DetalleCita]  WITH CHECK ADD  CONSTRAINT [FK_DetalleCita_Cita] FOREIGN KEY([idCita])
REFERENCES [dbo].[Cita] ([correlativo])
GO
ALTER TABLE [dbo].[DetalleCita] CHECK CONSTRAINT [FK_DetalleCita_Cita]
GO
ALTER TABLE [dbo].[DetalleOrdenProducto]  WITH CHECK ADD  CONSTRAINT [FK_DetalleOrdenProducto_OrdenCliente] FOREIGN KEY([idOrdenCliente])
REFERENCES [dbo].[OrdenCliente] ([correlativo])
GO
ALTER TABLE [dbo].[DetalleOrdenProducto] CHECK CONSTRAINT [FK_DetalleOrdenProducto_OrdenCliente]
GO
ALTER TABLE [dbo].[DetalleOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_DetalleOrdenServicio_OrdenCliente] FOREIGN KEY([idOrdenCliente])
REFERENCES [dbo].[OrdenCliente] ([correlativo])
GO
ALTER TABLE [dbo].[DetalleOrdenServicio] CHECK CONSTRAINT [FK_DetalleOrdenServicio_OrdenCliente]
GO
ALTER TABLE [dbo].[DetCatalogo]  WITH CHECK ADD  CONSTRAINT [FK_DetCatalogo_CabCatalogo] FOREIGN KEY([idCatalogo])
REFERENCES [dbo].[CabCatalogo] ([idCatalogo])
GO
ALTER TABLE [dbo].[DetCatalogo] CHECK CONSTRAINT [FK_DetCatalogo_CabCatalogo]
GO
ALTER TABLE [dbo].[Documento]  WITH CHECK ADD  CONSTRAINT [FK_Documento_SerieFactura] FOREIGN KEY([idSerieFactura])
REFERENCES [dbo].[SerieFactura] ([correlativo])
GO
ALTER TABLE [dbo].[Documento] CHECK CONSTRAINT [FK_Documento_SerieFactura]
GO
ALTER TABLE [dbo].[EmpresaArea]  WITH CHECK ADD  CONSTRAINT [FK_EmpresaArea_Empresa] FOREIGN KEY([empresa])
REFERENCES [dbo].[Empresa] ([correlativo])
GO
ALTER TABLE [dbo].[EmpresaArea] CHECK CONSTRAINT [FK_EmpresaArea_Empresa]
GO
ALTER TABLE [dbo].[EmpresaDireccion]  WITH CHECK ADD  CONSTRAINT [FK_EmpresaDireccion_Direccion] FOREIGN KEY([idDireccion])
REFERENCES [dbo].[Direccion] ([correlativo])
GO
ALTER TABLE [dbo].[EmpresaDireccion] CHECK CONSTRAINT [FK_EmpresaDireccion_Direccion]
GO
ALTER TABLE [dbo].[EmpresaDireccion]  WITH CHECK ADD  CONSTRAINT [FK_EmpresaDireccion_Empresa] FOREIGN KEY([idEmpresa])
REFERENCES [dbo].[Empresa] ([correlativo])
GO
ALTER TABLE [dbo].[EmpresaDireccion] CHECK CONSTRAINT [FK_EmpresaDireccion_Empresa]
GO
ALTER TABLE [dbo].[FacturaActualCaja]  WITH CHECK ADD  CONSTRAINT [FK_FacturaActualCaja_Documento] FOREIGN KEY([idDoc])
REFERENCES [dbo].[Documento] ([correlativo])
GO
ALTER TABLE [dbo].[FacturaActualCaja] CHECK CONSTRAINT [FK_FacturaActualCaja_Documento]
GO
ALTER TABLE [dbo].[FacturaFormaPago]  WITH CHECK ADD  CONSTRAINT [FK_FacturaFormaPago_Cheque] FOREIGN KEY([idCheque])
REFERENCES [dbo].[Cheque] ([correlativo])
GO
ALTER TABLE [dbo].[FacturaFormaPago] CHECK CONSTRAINT [FK_FacturaFormaPago_Cheque]
GO
ALTER TABLE [dbo].[FacturaFormaPago]  WITH CHECK ADD  CONSTRAINT [FK_FacturaFormaPago_Documento] FOREIGN KEY([idDoc])
REFERENCES [dbo].[Documento] ([correlativo])
GO
ALTER TABLE [dbo].[FacturaFormaPago] CHECK CONSTRAINT [FK_FacturaFormaPago_Documento]
GO
ALTER TABLE [dbo].[HuellaCliente]  WITH CHECK ADD  CONSTRAINT [FK_HuellaCliente_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([correlativo])
GO
ALTER TABLE [dbo].[HuellaCliente] CHECK CONSTRAINT [FK_HuellaCliente_Cliente]
GO
ALTER TABLE [dbo].[HuellaCliente]  WITH CHECK ADD  CONSTRAINT [FK_HuellaCliente_Huella] FOREIGN KEY([idHuella])
REFERENCES [dbo].[Huella] ([correlativo])
GO
ALTER TABLE [dbo].[HuellaCliente] CHECK CONSTRAINT [FK_HuellaCliente_Huella]
GO
ALTER TABLE [dbo].[ImagenAtributo]  WITH CHECK ADD  CONSTRAINT [FK_ImagenAtributo_Imagen] FOREIGN KEY([idImagen])
REFERENCES [dbo].[Imagen] ([correlativo])
GO
ALTER TABLE [dbo].[ImagenAtributo] CHECK CONSTRAINT [FK_ImagenAtributo_Imagen]
GO
ALTER TABLE [dbo].[ImagenCliente]  WITH CHECK ADD  CONSTRAINT [FK_ImagenCliente_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([correlativo])
GO
ALTER TABLE [dbo].[ImagenCliente] CHECK CONSTRAINT [FK_ImagenCliente_Cliente]
GO
ALTER TABLE [dbo].[ImagenCliente]  WITH CHECK ADD  CONSTRAINT [FK_ImagenCliente_Imagen] FOREIGN KEY([idImagen])
REFERENCES [dbo].[Imagen] ([correlativo])
GO
ALTER TABLE [dbo].[ImagenCliente] CHECK CONSTRAINT [FK_ImagenCliente_Imagen]
GO
ALTER TABLE [dbo].[MedioContacto]  WITH CHECK ADD  CONSTRAINT [FK_MedioContacto_Persona] FOREIGN KEY([idPersona])
REFERENCES [dbo].[Persona] ([correlativo])
GO
ALTER TABLE [dbo].[MedioContacto] CHECK CONSTRAINT [FK_MedioContacto_Persona]
GO
ALTER TABLE [dbo].[Movimiento]  WITH CHECK ADD  CONSTRAINT [FK_Movimiento_Documento] FOREIGN KEY([idDoc])
REFERENCES [dbo].[Documento] ([correlativo])
GO
ALTER TABLE [dbo].[Movimiento] CHECK CONSTRAINT [FK_Movimiento_Documento]
GO
ALTER TABLE [dbo].[Movimiento]  WITH CHECK ADD  CONSTRAINT [FK_Movimiento_OrdenCliente] FOREIGN KEY([idOrdenCliente])
REFERENCES [dbo].[OrdenCliente] ([correlativo])
GO
ALTER TABLE [dbo].[Movimiento] CHECK CONSTRAINT [FK_Movimiento_OrdenCliente]
GO
ALTER TABLE [dbo].[MovimientoCuentaXCobrar]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoCuentaXCobrar_CuentaXCobrar] FOREIGN KEY([idCuentaXCobrar])
REFERENCES [dbo].[CuentaXCobrar] ([correlativo])
GO
ALTER TABLE [dbo].[MovimientoCuentaXCobrar] CHECK CONSTRAINT [FK_MovimientoCuentaXCobrar_CuentaXCobrar]
GO
ALTER TABLE [dbo].[ocupacion]  WITH CHECK ADD  CONSTRAINT [FK_ocupacion_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([correlativo])
GO
ALTER TABLE [dbo].[ocupacion] CHECK CONSTRAINT [FK_ocupacion_Cliente]
GO
ALTER TABLE [dbo].[PersonaDireccion]  WITH CHECK ADD  CONSTRAINT [FK_ClienteDireccion_Direccion] FOREIGN KEY([idDireccion])
REFERENCES [dbo].[Direccion] ([correlativo])
GO
ALTER TABLE [dbo].[PersonaDireccion] CHECK CONSTRAINT [FK_ClienteDireccion_Direccion]
GO
ALTER TABLE [dbo].[PersonaDireccion]  WITH CHECK ADD  CONSTRAINT [FK_PersonaDireccion_Persona] FOREIGN KEY([idPersona])
REFERENCES [dbo].[Persona] ([correlativo])
GO
ALTER TABLE [dbo].[PersonaDireccion] CHECK CONSTRAINT [FK_PersonaDireccion_Persona]
GO
ALTER TABLE [dbo].[PersonaEvento]  WITH CHECK ADD  CONSTRAINT [FK_PersonaEvento_Evento] FOREIGN KEY([idEvento])
REFERENCES [dbo].[Evento] ([correlativo])
GO
ALTER TABLE [dbo].[PersonaEvento] CHECK CONSTRAINT [FK_PersonaEvento_Evento]
GO
ALTER TABLE [dbo].[PersonaEvento]  WITH CHECK ADD  CONSTRAINT [FK_PersonaEvento_Persona] FOREIGN KEY([idPersona])
REFERENCES [dbo].[Persona] ([correlativo])
GO
ALTER TABLE [dbo].[PersonaEvento] CHECK CONSTRAINT [FK_PersonaEvento_Persona]
GO
ALTER TABLE [dbo].[planilla_empleado]  WITH CHECK ADD  CONSTRAINT [FK_planilla_empleado_Empleado] FOREIGN KEY([corrEmpleado])
REFERENCES [dbo].[Empleado] ([correlativo])
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
ALTER TABLE [dbo].[PrecioProducto]  WITH CHECK ADD  CONSTRAINT [FK_PrecioProducto_Producto] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Producto] ([idProd])
GO
ALTER TABLE [dbo].[PrecioProducto] CHECK CONSTRAINT [FK_PrecioProducto_Producto]
GO
ALTER TABLE [dbo].[PrecioServicio]  WITH CHECK ADD  CONSTRAINT [FK_PrecioServicio_Servicio] FOREIGN KEY([idServicio])
REFERENCES [dbo].[Servicio] ([correlativo])
GO
ALTER TABLE [dbo].[PrecioServicio] CHECK CONSTRAINT [FK_PrecioServicio_Servicio]
GO
ALTER TABLE [dbo].[PrespuestoPersona]  WITH CHECK ADD  CONSTRAINT [FK_PrespuestoPersona_Persona] FOREIGN KEY([idPersona])
REFERENCES [dbo].[Persona] ([correlativo])
GO
ALTER TABLE [dbo].[PrespuestoPersona] CHECK CONSTRAINT [FK_PrespuestoPersona_Persona]
GO
ALTER TABLE [dbo].[PresupuestoPersonaDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PresupuestoPersonaDetalle_PrespuestoPersona] FOREIGN KEY([idPersonaPresupuesto])
REFERENCES [dbo].[PrespuestoPersona] ([correlativo])
GO
ALTER TABLE [dbo].[PresupuestoPersonaDetalle] CHECK CONSTRAINT [FK_PresupuestoPersonaDetalle_PrespuestoPersona]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [FK_Producto_TipoProducto] FOREIGN KEY([tipoProducto])
REFERENCES [dbo].[TipoProducto] ([idTipoProducto])
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [FK_Producto_TipoProducto]
GO
ALTER TABLE [dbo].[ProductoExistencia]  WITH CHECK ADD  CONSTRAINT [FK_ProductoExistencia_Producto] FOREIGN KEY([idProd])
REFERENCES [dbo].[Producto] ([idProd])
GO
ALTER TABLE [dbo].[ProductoExistencia] CHECK CONSTRAINT [FK_ProductoExistencia_Producto]
GO
ALTER TABLE [dbo].[ProductoProveedor]  WITH CHECK ADD  CONSTRAINT [FK_ProductoProveedor_Producto] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Producto] ([idProd])
GO
ALTER TABLE [dbo].[ProductoProveedor] CHECK CONSTRAINT [FK_ProductoProveedor_Producto]
GO
ALTER TABLE [dbo].[Propina]  WITH CHECK ADD  CONSTRAINT [FK_Propina_DetalleOrdenServicio] FOREIGN KEY([idDetalleOrdenServicio])
REFERENCES [dbo].[DetalleOrdenServicio] ([correlativo])
GO
ALTER TABLE [dbo].[Propina] CHECK CONSTRAINT [FK_Propina_DetalleOrdenServicio]
GO
ALTER TABLE [dbo].[ServicioEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_ServicioEmpleado_Servicio] FOREIGN KEY([idServicio])
REFERENCES [dbo].[Servicio] ([correlativo])
GO
ALTER TABLE [dbo].[ServicioEmpleado] CHECK CONSTRAINT [FK_ServicioEmpleado_Servicio]
GO
ALTER TABLE [dbo].[ServicioEtapa]  WITH CHECK ADD  CONSTRAINT [FK_ServicioEtapa_Servicio] FOREIGN KEY([idServicio])
REFERENCES [dbo].[Servicio] ([correlativo])
GO
ALTER TABLE [dbo].[ServicioEtapa] CHECK CONSTRAINT [FK_ServicioEtapa_Servicio]
GO
ALTER TABLE [dbo].[ServicioEtapa]  WITH CHECK ADD  CONSTRAINT [FK_ServicioEtapa_ServicioPlan] FOREIGN KEY([idServicioPlan])
REFERENCES [dbo].[ServicioPlan] ([correlativo])
GO
ALTER TABLE [dbo].[ServicioEtapa] CHECK CONSTRAINT [FK_ServicioEtapa_ServicioPlan]
GO
ALTER TABLE [dbo].[SucursalServicio]  WITH CHECK ADD  CONSTRAINT [FK_SucursalServicio_Sucursal] FOREIGN KEY([idSucursal])
REFERENCES [dbo].[Sucursal] ([correlativo])
GO
ALTER TABLE [dbo].[SucursalServicio] CHECK CONSTRAINT [FK_SucursalServicio_Sucursal]
GO
ALTER TABLE [dbo].[SucursalServicio]  WITH CHECK ADD  CONSTRAINT [FK_SucursalServicio_TipoServicio] FOREIGN KEY([idServicio])
REFERENCES [dbo].[TipoServicio] ([correlativo])
GO
ALTER TABLE [dbo].[SucursalServicio] CHECK CONSTRAINT [FK_SucursalServicio_TipoServicio]
GO
ALTER TABLE [dbo].[TerminalArea]  WITH CHECK ADD  CONSTRAINT [FK_TerminalArea_Area] FOREIGN KEY([idArea])
REFERENCES [dbo].[Area] ([correlativo])
GO
ALTER TABLE [dbo].[TerminalArea] CHECK CONSTRAINT [FK_TerminalArea_Area]
GO
ALTER TABLE [dbo].[TerminalArea]  WITH CHECK ADD  CONSTRAINT [FK_TerminalArea_Terminal] FOREIGN KEY([idTerminal])
REFERENCES [dbo].[Terminal] ([correlativo])
GO
ALTER TABLE [dbo].[TerminalArea] CHECK CONSTRAINT [FK_TerminalArea_Terminal]
GO
ALTER TABLE [dbo].[UbicacionAtributo]  WITH CHECK ADD  CONSTRAINT [FK_UbicacionAtributo_Ubicacion] FOREIGN KEY([idUbicacion])
REFERENCES [dbo].[Ubicacion] ([correlativo])
GO
ALTER TABLE [dbo].[UbicacionAtributo] CHECK CONSTRAINT [FK_UbicacionAtributo_Ubicacion]
GO
USE [master]
GO
ALTER DATABASE [ERPDatabase] SET  READ_WRITE 
GO
