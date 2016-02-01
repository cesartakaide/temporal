<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sj" uri="/jquery2-tags" %>
	<s:set var="modoConfirmacion">${modoConfirmacion}</s:set>

<form class="form-horizontal" role="form">
<s:form action="listComandoTest.action" namespace="/" id="ListComando" method="post" theme="simple">
    <div class="form-group">
        <div class="col-sm-1"></div>
    	<div class="col-sm-2">
    		<label>input decimal</label>  		
			<s:textfield  label="DECIMAL" name="input.decimal"/>
		</div> 
		<div class="col-sm-2">
    		<label>input texto</label>  
			<s:textfield  label="TEXTO" name="input.varchar"/>
		</div>	
		<div class="col-sm-2">
    		<label>fecha</label>  
			<sj:datepicker  label="FECHA" name="input.datetime"/>
		</div>	
	</div>	
	<div class="form-group"> 
		<div class="col-sm-1"></div>
    	<div class="col-sm-2">
			<label>ACEPTAR</label>
			<s:submit label="ACEPTAR"> </s:submit>
		</div>		
	</div>
</s:form>
</form>

<div class="form-group">
  <div class="col-sm-1"></div>
  <div class="col-sm-10">  
  
<table id="tbl_tabla" class="display compact" cellspacing="0" width="80%">
<thead>
<tr> 
   <th>NOMBRE</th>
   <th>TIPO ENTE</th>
   <th>LOGIN</th>
   <th>CATALOG</th>
   <th>ENUMERADO</th>
   <th>boton</th>
</tr>
</thead>
<tfoot>
<tr> 
   <th>NOMBRE</th>
   <th>TIPO ENTE</th>
   <th>LOGIN</th>
   <th>CATALOG</th>
   <th>ENUMERADO</th>
   <th>boton</th>
</tr>
</tfoot>
<tbody>	
	<c:forEach var="fila" items="${listado}">
		<tr>
			<td>${fila.nombre}</td>
			<td>${fila.tipoEnte}</td>
			<td>${fila.login.login}</td>
			<td>${fila.catalog2.shortCode}</td>
			<td>${fila.enumerado}</td>
			<td>
				<a href="<s:url action="struts/showComandoTest.action">
					<s:param name="input.varchar">${fila.nombre}</s:param>
					<s:param name="input.cliente.unico">${fila.unico}</s:param>                                       
                </s:url>"><span class='glyphicon glyphicon-star' aria-hidden='true'></span></a>
			</td>
		</tr>
	</c:forEach> 
</tbody>
</table>


<script type="text/javascript">				    
    var tbl_tabla = null;
    var ttools_tabla = null;
    $(function() {
		tbl_tabla = $('#tbl_tabla').DataTable(
            {"language": {
	            "lengthMenu": "Mostrar _MENU_ registros por pagina.",
	         	"zeroRecords": "No se encontraron registros.",
	            "info": "Mostrando pagina _PAGE_ de _PAGES_",
	            "infoEmpty": "No se encontraron registros",
	            "infoFiltered": "(filtered from _MAX_ total records)",
	            "search"      : "Filtro",
	                "oPaginate": {
        			     "sFirst":    "Primero",
        			     "sLast":     "Último",
                         "sNext":     "Siguiente",
                         "sPrevious": "Anterior"
                     }
              }
            ,columnDefs: [
               { width: '10%', targets: 0 }
             ]
           });	
	    
	     ttools_tabla = new $.fn.dataTable.TableTools( 
	          tbl_tabla
			  , {	
			   	"sRowSelect": "single"												        
		      }
		 );        
    });	
</script>    

   </div>
</div>

