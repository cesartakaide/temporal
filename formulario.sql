

IF OBJECT_ID('dbo.sp_mantto_formulario') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_mantto_formulario
    IF OBJECT_ID('dbo.sp_mantto_formulario') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.sp_mantto_formulario >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.sp_mantto_formulario >>>'
END
go
create proc dbo.sp_mantto_formulario  
   @i_operacion char(1)    
	,@i_nombre varchar(50) = null
	,@i_descripcion varchar(45) = null
	,@i_etapa varchar(5) = null
	,@i_fechaIngreso date = null
	,@i_usuarioIngreso varchar(50)  = null
	,@i_tipoProducto varchar(5)  = null
	,@i_origen varchar(5)  = null
	,@i_rolPersona varchar(20)  = null
	,@i_relacionLaboral varchar(30) = null
 	,@o_correlativo int = null output
as 
--variables reservadas
      --CUERPO DE SP se generar por medio de un generador de codigo.  
	  --PENDIENTE.
end	


create proc sp_mantto_formulario_pregunta
   @i_operacion char(1)       	
	,@i_idFormulario int = null
	,@i_texto varchar(100)  = null
	,@i_tipoDato varchar(10) = null
	,@i_cerrada  char(1)  = null
	,@i_esSubtitulo char(1)  = null
	,@i_respuestaBinaria char(1)  = null
	,@i_obligatoria  char(1)  = null
	,@i_campoBaseTO varchar(200)  = null
	,@i_orden  int = null
    ,@o_correlativo int = null output
	
---CUERPO PENDIENTE	

create proc sp_mantto_formulario_pregunta_respuesta
    @i_operacion char(1)    
	,@i_idPregunta int = null
	,@i_texto varchar(50)  = null


create proc sp_mantto_resultado_formulario
 @i_idFormulario  int = null
 ,@i_valor  varchar(10) = null
 ,@i_fechaIngreso  date = null
 ,@i_usuarioIngreso  varchar(50) = null
 ,@o_correlativo  int  = null output
 
create proc sp_mantto_resultado_formulario_detalle 
 @i_idResultado int = null
 ,@i_valor varchar(10) = null
 ,@i_descripcion varchar(50)  = null
go

declare @w_correlativo int , @w_corrPregunta int
--proceso manual buro banrural 
exec sp_mantto_formulario  
   @i_operacion  = 'I'
 ,@i_nombre  = 'PROCESOMANUAL_BANRURAL'
 ,@i_descripcion ='PROCESO MANUAL'
 ,@i_etapa = 'BBR' 
 ,@i_tipoProducto   = 'PRE' 
  ,@o_correlativo int = @w_correlativo output
 
 --respuesta                  tipo dato   cerrada   abierta   subtitulo    obligatoria pregunta binaria (SI o NO)    campoBaseTO
 --ESTA AL DIA CON LOS PAGOS              true                             true        true                          estaAlDiaPagos
 exec sp_mantto_formulario_pregunta
    @i_operacion = 'I'
   ,@i_idFormulario  = @w_correlativo
   ,@i_texto   = 'ESTA AL DIA CON LOS PAGOS'
   ,@i_tipoDato  = 'V'
   ,@i_cerrada    = 'S'
   
   ,@i_respuestaBinaria  = 'S'
   ,@i_obligatoria   = 'S'
   ,@i_campoBaseTO  = 'estaAlDiaPagos'
    ,@o_correlativo  = @w_corrPregunta output

--respuesta                  tipo dato   cerrada   abierta   subtitulo    obligatoria   pregunta binaria (SI o NO)   campoBaseTO 
--MORAS 60 POR 12 MESES                  true                                           true                          moras60por12meses
 exec sp_mantto_formulario_pregunta
    @i_operacion = 'I'
   ,@i_idFormulario  = @w_correlativo
   ,@i_texto   = 'MORAS 60 POR 12 MESES'
   ,@i_tipoDato  = 'V'
   ,@i_cerrada    = 'S'   
   ,@i_respuestaBinaria  = 'S'   
   ,@i_campoBaseTO  = 'moras60por12meses'
    ,@o_correlativo  = @w_corrPregunta output

--respuesta                  tipo dato   cerrada   abierta   subtitulo    obligatoria   pregunta binaria (SI o NO)   campoBaseTO 
--MORAS 90 POR 12 MESES                            true                                 true                         moras90por12meses
 exec sp_mantto_formulario_pregunta
    @i_operacion = 'I'
   ,@i_idFormulario  = @w_correlativo
   ,@i_texto   = 'MORAS 90 POR 12 MESES'
   ,@i_tipoDato  = 'V'
   ,@i_cerrada    = 'S'   
   ,@i_respuestaBinaria  = 'S'   
   ,@i_campoBaseTO  = 'moras90por12meses'
    ,@o_correlativo  = @w_corrPregunta output

--respuesta                  tipo dato   cerrada   abierta   subtitulo    obligatoria   pregunta binaria (SI o NO)   campoBaseTO 
--MORAS 120|                 |           |         true|     |            |             |true                        |moras120
 exec sp_mantto_formulario_pregunta
    @i_operacion = 'I'
   ,@i_idFormulario  = @w_correlativo
   ,@i_texto   = 'MORAS 120'
   ,@i_tipoDato  = 'V'
   ,@i_cerrada   = 'S'   
   ,@i_respuestaBinaria  = 'S'
   ,@i_obligatoria   = 'S'
   ,@i_campoBaseTO  = 'estaAlDiaPagos'
    ,@o_correlativo  = @w_corrPregunta output

--respuesta                  tipo dato   cerrada   abierta   subtitulo    obligatoria   pregunta binaria (SI o NO)    campoBaseTO 
--CUOTA DEUDA DIRECTA|       |           |         |true     |            |             |                            |cuotaDeudaDirecta
 exec sp_mantto_formulario_pregunta
    @i_operacion = 'I'
   ,@i_idFormulario  = @w_correlativo
   ,@i_texto   = 'CUOTA DEUDA DIRECTA'
   ,@i_tipoDato  = 'V'
   ,@i_abierta    = 'S'     
   ,@i_campoBaseTO  = 'cuotaDeudaDirecta'
    ,@o_correlativo  = @w_corrPregunta output

--respuesta                  tipo dato   cerrada   abierta   subtitulo    obligatoria   pregunta binaria (SI o NO)    campoBaseTO 
--CUOTA DEUDA INDIRECTA|     |           |         |true     |            |             |                             |cuotaDeudaIndirecta
exec sp_mantto_formulario_pregunta
    @i_operacion = 'I'
   ,@i_idFormulario  = @w_correlativo
   ,@i_texto   = 'CUOTA DEUDA INDIRECTA'
   ,@i_tipoDato  = 'V'
   ,@i_abierta    = 'S'     
   ,@i_campoBaseTO  = 'cuotaDeudaIndirecta'
    ,@o_correlativo  = @w_corrPregunta output

--respuesta                  tipo dato   cerrada   abierta   subtitulo    obligatoria   pregunta binaria (SI o NO)    campoBaseTO 
--MONTO DEUDA DIRECTA|       |           |         |true     |            |             |                             |montoDeudaDirecta
exec sp_mantto_formulario_pregunta
    @i_operacion = 'I'
   ,@i_idFormulario  = @w_correlativo
   ,@i_texto   = 'MONTO DEUDA DIRECTA'
   ,@i_tipoDato  = 'V'
   ,@i_abierta    = 'S'  
   ,@i_campoBaseTO  = 'montoDeudaDirecta'
    ,@o_correlativo  = @w_corrPregunta output
	
--respuesta                  tipo dato   cerrada   abierta   subtitulo    obligatoria   pregunta binaria (SI o NO)    campoBaseTO 
--MONTO DEUDA INDIRECTA|     |           |         |true     |            |             |                             |montoDeudaIndirecta
exec sp_mantto_formulario_pregunta
    @i_operacion = 'I'
   ,@i_idFormulario  = @w_correlativo
   ,@i_texto   = 'MONTO DEUDA INDIRECTA'
   ,@i_tipoDato  = 'V'
   ,@i_abierta    = 'S'  
   ,@i_campoBaseTO  = 'montoDeudaIndirecta'
    ,@o_correlativo  = @w_corrPregunta output
	
--respuesta                  tipo dato   cerrada   abierta   subtitulo    obligatoria   pregunta binaria (SI o NO)    campoBaseTO 
--ESTATUS|                               true      |         |            |true         |                             |status
exec sp_mantto_formulario_pregunta
    @i_operacion = 'I'
   ,@i_idFormulario  = @w_correlativo
   ,@i_texto   = 'ESTATUS'
   ,@i_tipoDato  = 'V'
   ,@i_cerrada    = 'S'  
   ,@i_respuestaBinaria  = 'S'   
   ,@i_obligatoria  = 'S'
   ,@i_campoBaseTO  = 'status'
    ,@o_correlativo  = @w_corrPregunta output
	
--respuestas
--00
--20
--21
exec  sp_mantto_formulario_pregunta_respuesta
    @i_operacion = 'I'
	,@i_idPregunta  = @w_corrPregunta
	,@i_texto   = '00'
exec sp_mantto_formulario_pregunta_respuesta
    @i_operacion = 'I'
	,@i_idPregunta  = @w_corrPregunta
	,@i_texto   = '20'
exec sp_mantto_formulario_pregunta_respuesta
    @i_operacion = 'I'
	,@i_idPregunta  = @w_corrPregunta
	,@i_texto   = '21'


	
	
---BURO PTC
exec sp_mantto_formulario  
   @i_operacion  = 'I'
 ,@i_nombre  = 'PROCESOMANUAL_PTC'
 ,@i_descripcion ='PROCESO MANUAL'
 ,@i_etapa = 'PTC' 
 ,@i_tipoProducto   = 'PRE' 
  ,@o_correlativo int = @w_correlativo output


---PROCESO MANUAL BURO PTC
--texto pregunta      respuesta            tipo dato         cerrada   abierta   pregunta binaria    obligatoria   campobaseTO
--ANTIGUEDAD          |                    |DECIMAL          |         |true     |                   |true         |antiguedad
--SALDO               |                    |DECIMAL          |         |true     |                   |true         |saldo
--ESTATUS             |CA                  |                 |true     |         |                   |             |estado
/*CA
|IN||||||
|AC||||||
|NE||||||
|NU||||||
|MO||||||
|CM||||||
|CJ||||||
|SR||||||
|CO||||||*/
--ESTA AL DIA CON PAGOS|                   |                 |true     |         |true               |true          |estaAlDiaEnPagos
--ES CLIENTE DE PTC    |                   |                 |true     |         |true               |true          |
--MORAS 30 HACE 1 MES  |                   |                 |         |true     |                   |              |moras30hace1mes
--MORAS 30 HACE 6 MESES|                   |                 |         |true     |                   |              |moras30hace6meses
--MORAS 30 HACE 12 MESES|                  |                 |         |true     |                   |              |moras30hace12meses
--MORAS 30 HISTORICAS  |                   |                 |         |true     |                   |              |moras30Historico
--MORAS 60 HACE 3 MESES|                   |                 |         |true     |                   |              |moras60hace3meses
--MORAS 60 HACE 6 MESES|                   |                 |         |true     |                   |              |moras60hace6meses
--MORAS 60 HACE 12 MESES|                  |                 |         |true     |                   |              |moras60hace12meses
--MORAS 60 HISTORICAS|                     |                 |         |true     |                   |              |moras60Historico
--MORAS 90 HACE 12 MESES|                  |                 |         |true     |                   |              |moras90hace12meses
--MORAS 90 HISTORICAS|                     |                 |         |true     |                   |              |moras90Historico
--MORAS 120 HISTORICAS|                    |                 |         |true     |                   |              |moras120
--TIENE COBRO JUDICIAL|                    |                 |true     |         |true               |true          |tieneCobroJudicial
--TIENE SALDO REESTRUCTURADO|              |                 |true     |         |true               |true          |tieneSaldoReestructurado
--TIENE CUENTAS SOBREGIRADAS|              |                 |true     |         |true               |true          |cuentaSobregirada
--EMISION              |                   |                 |         |true     |                   |              |emision




--PROCESO MANUAL SIPSA
--inTO.addPregunta("$param");|RESPUESTA;|tipo dato pregunta;| cerrada;|abierta;|subtitulo;|obligatoria;|binaria;|inTO.setCampoBaseTO("$param");
--ES CLIENTE DE SIPSA        |          |                   |true     |        |          |true        |true    |clienteSipsa
--ANTIGUEDAD CLIENTE         |          |DECIMAL            |         |true    |          |            |        |antiguedadCliente
--ESTA AL DIA CON LOS PAGOS  |          |                   |true     |        |          |true        |true    |pagosAlDia
--SALDO ACTUAL               |          |DECIMAL            |         |true    |          |            |        |saldoActual
--CUOTA ACTUAL               |          |DECIMAL            |         |true    |          |            |        |cuotaActual
--PERIODICIDAD               |          |DECIMAL            |         |true    |          |            |        |periodicidad
--CUOTAS ATRASADAS 6 MESES   |          |DECIMAL            |         |true    |          |            |        |cuotasAtrasadas6meses
--CUOTAS ATRASADAS 12 MESES  |          |DECIMAL            |         |true    |          |            |        |cuotasAtrasadas12meses
--CUOTAS ATRASADAS HISTORICAS|          |DECIMAL            |         |true    |          |            |        |cuotasAtrasadasHistoricas
--PLAZO                      |          |DECIMAL            |         |true    |          |            |        |plazo
--TIENE SALDO REESTRUCTURADO |          |                   |true     |        |          |true        |true    |tieneSaldoReestructurado
--CUOTAS PAGADAS             |          |                   |         |true    |          |            |        |cuotasPagadas


--PROCESO CREDIREF
--pregunta                   respuesta     tipo dato     cerrada       abierta      subtitulo     obligatoria     binaria   campo baseto
--ESTA AL DIA CON PAGOS      |             |             |true         |            |             |true           |true     |estaAlDiaPago
--MORAS 60 POR 3 MESES       |             |             |true         |            |             |               |true     |moras60por3meses
--MORAS 60 POR 12 MESES      |             |             |true         |            |             |               |true     |moras60por12meses
--MORAS 90 POR 12 MESES      |             |             |true         |            |             |               |true     |moras90por12meses
--MORAS 120                  |             |             |true         |            |             |               |true     |moras120
--CUENTAS CON COBRO JUDICIAL |             |             |true         |            |             |               |true     |cuentasCobroJudicial
--CUENTA INCOBRABLE          |             |             |true         |            |             |               |true     |cuentaIncobrable
--EN PROCESO DE PRORROGA     |             |             |true         |            |             |               |true     |enProcesoProrroga
--CANCELADO POR RENOVACION   |             |             |true         |            |             |               |true     |canceladoRenovacion
--CANCELADO POR INCOBRABLE   |             |             |true         |            |             |               |true     |canceladoPorIncobrable
--CANCELADO POR EJECUCION JUDICIAL|        |             |true         |            |             |               |true     |canceladoPorEjecucionJudicial
--SALDO REESTRUCTURADO       |             |             |true         |            |             |               |true     |saldoReestructurado
--SE ENCONTRARON REGISTROS   |             |             |true         |            |             |true           |true     |conInformacion
--TOTAL DEUDA                |             |DECIMAL      |             |true        |             |               |         |totalDeuda
--TOTAL CUOTA                |             |DECIMAL      |             |true        |             |               |         |totalCuota
--COMPARTE INFORMACION       |             |             |true         |            |             |true           |true     |comparteInformacion



--PROCESO MANUAL INFORNET
--pregunta                    respuesta     tipo dato    cerrada       abierta      subtitulo     obligatoria     binaria    baseTO          
--TIENE CREDITOS CON ESTATUS MALO|          |            |true         |            |             |true           |true      |tieneCreditosEdoMalo
--TIENE CREDITOS CON CLASIFICACION MALA|    |            |true         |            |             |true           |true      |tieneCreditosClasifMala
--TIENE MALAS REFERENCIAS DE PRENSA|        |            |true         |||true|true|tieneMalasReferenciasPrensa
--JUICIOS 2                   |             |            |             |true        |             |               |          |njuicios2
--JUICIOS 0 A 2 AÑOS          |             |            |             |true        |             |               |          |njuicios0a2
--JUICIOS 1 A 2 AÑOS          |             |            |             |true        |             |               |          |njuicios1a2
--TIENE REGISTROS EN INFORNET |             |            |true         |            |             |true           |true      |tieneRegistros
--COMPARTE INFORMACION        |             |            |true         |            |             |true           |true      |comparteInformacion
--CUOTA                       |             |DECIMAL     |             |true        |             |               |          |cuota
--DEUDA                       |             |DECIMAL     |             |true        |             |               |          |deuda
--TEXTO PRENSA                |             |            |             |true        |             |               |          |


--proceso MANUAL TRANSUNION
--pregunta                             respuesta      tipo dato    cerrada       abierta      subtitulo      binaria     obligatoria     baseto
--TIENE REFERENCIAS COMERCIALES MALAS  |              |            |true         |            |              |true       |true           |tieneRefComercialesMalas
--TIENE REFERENCIAS CREDITICIAS MALAS  |              |            |true         |            |              |true       |true           |tieneRefCrediticiasMalas
--NUMERO DE JUICIOS 2                  |              |DECIMAL     |             |true        |              |           |               |nJuicios2
--NUMERO DE JUICIOS 0 A 2 AÑOS         |              |DECIMAL     |             |true        |              |           |               |nJuicios0a2
--NUMERO DE JUICIOS 1 A 2 AÑOS         |              |DECIMAL     |             |true        |              |           |               |nJuicios1a2
--MORAS 60 POR 3 MESES                 |              |            |true         |            |              |true       |               |moras60por3meses
--MORAS 60 POR 12 MESES                |              |DECIMAL     |             |true        |              |           |               |moras60por12meses
--MORAS 90 POR 12 MESES                |              |            |true         |            |              |true       |               |moras90por12meses
--MORAS 120                            |              |            |true         |            |              |true       |               |moras120
--TIENE CUENTAS COBRO JUDICIAL         |              |            |true         |            |              |true       |true           |cuentasCobroJudicial
--TIENE CUENTAS SALDO REESTRUCTURADO   |              |            |true         |            |              |true       |true           |cuentasSaldoReestructurado
--TIENE REGISTROS EN TRANSUNION        |              |            |true         |            |              |true       |true           |tieneRegistros
--DEUDA REGISTRADA                     |              |DECIMAL     |             |true        |              |           |               |deuda
--CUOTA REGISTRADA                     |              |DECIMAL     |             |true        |              |           |               |cuota
--COMPARTE INFORMACION                 |              |            |true         |            |              |true       |true           |comparteInformacion



--INVESTIGACIONES
--FORMULARIO CONFIRMACION DE CREDITO
 exec sp_mantto_formulario  
   @i_operacion  = 'I'
  ,@i_nombre  = 'FORMULARIO_CONFIRMACION_CREDITO'
  ,@i_descripcion ='PROCESO MANUAL'
  ,@i_etapa = 'CNFC' 
  ,@i_tipoProducto   = 'PRE' 
  ,@i_rolPersona = 'SOLICITANTE'
  ,@i_origen = 'SIPSA'
  ,@o_correlativo int = @w_correlativo output
 
--pregunta                                respuesta                       cerrada    tipo dato     abierta                             obligatoria
--Esta de acuerdo con el monto sugerido del credito:                      |true      |             |true                               |
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Esta de acuerdo con el monto sugerido del credito:'
	,@i_tipoDato  = 'V'
	,@i_cerrada    = 'S'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 			
    ,@o_correlativo = @w_corrPregunta output
	
--                                        |SI
--                                        |NO                             |          |             |                                   |

--pregunta                                respuesta                       cerrada    tipo dato     abierta                             obligatoria
--Si no esta de acuerdo, ingresar el monto acordado:|                     |          |             |true                               |
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Si no esta de acuerdo, ingresar el monto acordado'
	,@i_tipoDato  = 'DECIMAL'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	,@i_respuestaBinaria   = 'N'	
	
--nuevo plazo                             |                               |          |DECIMAL      |true                               |true
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'nuevo plazo'
	,@i_tipoDato  = 'DECIMAL'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	,@i_respuestaBinaria   = 'V'

--Notas del sistema                       |                               |          |             |true                               |
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 

	

--INVESTIGACION DE CAMPO
--VERIFICACION DEL DOMICILIO						true	
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'VERIFICACION DEL DOMICILIO'
	,@i_esSubtitulo   = 'S' 
	
--Refrigeradora (Cantidad)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 

--Refrigeradora (Forma de propiedad)	Propio	true					
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
--	De familia						


--Refrigeradora (Fecha adquisicion)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Refrigeradora (plazo de pago)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Refrigeradora (cuota pago)			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Refrigeradora (saldo actual)			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Estufa (Cantidad)			true		
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Estufa (Forma de propiedad)	Propio	true	
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 				
--	De familia				

		
--Estufa (Fecha adquisicion)			true
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Estufa (plazo de pago)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Estufa (cuota pago)			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Estufa (saldo actual)			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--TV (Cantidad)			true		
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--TV (Forma de propiedad)	Propio	true					
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
--	De familia				

		
--TV (Fecha adquisicion)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--TV (plazo de pago)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--TV (saldo actual)			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--TV (cuota pago)			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Equipo Sonido (Cantidad)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Equipo Sonido (Forma de propiedad)	Propio	true					
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
--	De familia				

		
--Equipo Sonido (Fecha adquisicion)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Equipo Sonido (plazo de pago)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Equipo Sonido (saldo actual)			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Equipo Sonido (cuota pago)			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Microondas (Cantidad)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Microondas (Forma de propiedad)	Propio	true					
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
--	De familia				

		
--Microondas (Fecha adquisicion)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Microondas (plazo de pago)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Microondas (cuota pago)			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Microondas (saldo actual)			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Otro electrodomestico			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Otro (Cantidad)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Otro (Forma de propiedad)	Propio	true					
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
--	De familia				

		
--Otro (Fecha adquisicion)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Otro (plazo de pago)			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Otro (cuota pago)			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Otro (saldo actual)			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Uso exclusivo del verificador						true	
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Hace cuanto lo conoce?			true				
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--Verificacion de caracter del cliente	Cumple con sus compromisos	true	true		false		
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
--	Es violento						
--	Es alcoholico						
--	dos o más años de residir en el domicilio/Laborar en la empresa						
--	Posee arraigo en el lugar de trabajo						
--	Localizable en trabajo y casa						

--Cualidades que resaltan del cliente	trabajador	true	true		false		
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
--	Cumple con sus compromisos						
--	buen vecino						
--	Otro	

					
--Le debe a alguna persona o a algun banco?	SI	true					
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
--	NO						
--Banco 1			true				
--cuenta 1			true				
--saldo 1			true	DECIMAL			
--cuota 1			true	DECIMAL			
--Banco 2			true				
--cuenta 2			true				
--saldo 2			true	DECIMAL			
--cuota 2			true	DECIMAL			
--Banco 3			true				
--cuenta 3			true				
--saldo 3			true	DECIMAL			
--cuota 3			true	DECIMAL			
--especifique			true		

		
--Recibe remesas del extranjero?	SI	true					
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
--	NO						

--mes1			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--mes2			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--mes3			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--mes4			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
--total			true	DECIMAL			
exec sp_mantto_formulario_pregunta
   @i_operacion = 'I'
	,@i_idFormulario =  @w_correlativo
	,@i_texto   = 'Notas del sistema'
	,@i_tipoDato  = 'VARCHAR'
	,@i_cerrada    = 'N'
	,@i_abierta    = 'S'
	,@i_esSubtitulo   = 'N' 
	
	
PARA LAS SIGUIENTES RELACIONES LABORALES, SE DEBE CREAR UN REGISTRO DE FORMULARIO Y REPETIR TODAS LAS PREGUNTAS DEFINIDAS ANTERIORMENTE
POR CADA FORMULARIO.

--ASALARIADO_FORMAL	Nombre de la empresa			true					9922	
--ASALARIADO_FORMAL	fecha de ingreso			true					9921
--ASALARIADO_FORMAL	puesto en la empresa			true					9920
--ASALARIADO_FORMAL	Salario			true	DECIMAL			true	9919
--ASALARIADO_FORMAL	Base			true	DECIMAL				9918
--ASALARIADO_FORMAL	Bonificacion			true	DECIMAL				9917
--ASALARIADO_FORMAL	comisiones (promedio)			true	DECIMAL				9916
--ASALARIADO_FORMAL	forma de pago			true					9915
--ASALARIADO_FORMAL	actividad de la empresa			true					9914
--ASALARIADO_FORMAL	fecha de constitucion			true					9913
--ASALARIADO_FORMAL	numero de empleados			true	DECIMAL				9912
--ASALARIADO_FORMAL	nombre del gerente general			true					9911
--ASALARIADO_FORMAL	nombre de GTE RRHH o contador general			true					9910
--PROPIETARIO_FORMAL	Ingresos mensuales			true	DECIMAL			true	9909
--PROPIETARIO_FORMAL	Inventario de mercaderia			true					9908
--PROPIETARIO_FORMAL	Gastos fijos para funcionamiento del negocio						true		9907
--PROPIETARIO_FORMAL	Mercaderia en consignacion			true	DECIMAL				9906
--PROPIETARIO_FORMAL	Gastos electricidad			true	DECIMAL				9905
--PROPIETARIO_FORMAL	Gastos agua			true	DECIMAL				9904
--PROPIETARIO_FORMAL	Gastos seguridad			true	DECIMAL				9903
--PROPIETARIO_FORMAL	Gastos combustible			true	DECIMAL				9902
--PROPIETARIO_FORMAL	Alquiler del local			true	DECIMAL				9901
--PROPIETARIO_FORMAL	Gastos por salarios			true	DECIMAL				9900
--PROPIETARIO_FORMAL	Compra de mercaderia mensual			true	DECIMAL				9899
--PROPIETARIO_FORMAL	otros (ej, cuotas de compras de electrodomesticos o prestamos, etc)			true	DECIMAL				9898
--PROPIETARIO_INFORMAL	Ingresos mensuales			true	DECIMAL			true	9897
--PROPIETARIO_INFORMAL	Gastos fijos para funcionamiento del negocio						true		9896
--PROPIETARIO_INFORMAL	Gastos electricidad			true	DECIMAL				9895
--PROPIETARIO_INFORMAL	Gastos agua			true	DECIMAL				9894
--PROPIETARIO_INFORMAL	Gastos seguridad			true	DECIMAL				9893
--PROPIETARIO_INFORMAL	Gastos combustible			true	DECIMAL				9892
--PROPIETARIO_INFORMAL	Alquiler del local			true	DECIMAL				9891
--PROPIETARIO_INFORMAL	Gastos por salarios			true	DECIMAL				9890
--PROPIETARIO_INFORMAL	Compra de mercaderia mensual			true	DECIMAL				9889
--PROPIETARIO_INFORMAL	Otros (ej cuotas de compras de electrodomesticos o prestamos)			true	DECIMAL				9888
--ASALARIADO_INFORMAL	Nombre de la empresa			true					9887
--ASALARIADO_INFORMAL	Actividad de la empresa			true					9886
--ASALARIADO_INFORMAL	Tel de la empresa			true					9885
--ASALARIADO_INFORMAL	No de empleados			true					9884
--ASALARIADO_INFORMAL	Antiguedad de la empresa			true					9883
--ASALARIADO_INFORMAL	Tamaño de la empresa			true					9882
--ASALARIADO_INFORMAL	Observaciones			true					9881
--ASALARIADO_INFORMAL	Datos laborales del solicitante						true		9880
--ASALARIADO_INFORMAL	Salario mensual			true	DECIMAL			true	9879
--ASALARIADO_INFORMAL	fecha de ingreso			true					9878
--ASALARIADO_INFORMAL	puesto que desempeña			true					9877
--ASALARIADO_INFORMAL	forma de pago			true					9876
--	Observaciones finales			true					9875



	
