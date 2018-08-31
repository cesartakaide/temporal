<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <script type="text/javascript" src="libraries/frameworks/jquery2.1/jquery.js"></script>  
  <script type="text/javascript" src="libraries/frameworks/bootstrap/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="libraries/frameworks/bootstrap/css/bootstrap.min.css">
  
  <script type="text/javascript" src="libraries/frameworks/datatables/datatables.min.js"></script>
  <link rel="stylesheet" href="libraries/frameworks/datatables/datatables.min.css">
  <link rel="stylesheet" href="libraries/frameworks/datatables/Select-1.1.2/css/select.dataTables.min.css">
  <link rel="stylesheet" href="libraries/frameworks/datatables/Select-1.1.2/css/select.bootstrap.min.css">
  
  <script type="text/javascript" src="libraries/frameworks/angular/angular.min.js"></script>
  <script type="text/javascript" src="libraries/frameworks/angular/angular-route.js"></script>
  <script type="text/javascript" src="libraries/frameworks/angular/angular-resource.js"></script>
  <!-- <script type="text/javascript" src="libraries/frameworks/angular/angular-ui-router.min.js"></script> -->   
  <script type="text/javascript" src="libraries/frameworks/angular/angular-ui-router.min.js"></script>
       
  <script type="text/javascript" src="libraries/frameworks/angular/grid/ui-grid.min.js"></script>
  <script type="text/javascript" src="libraries/frameworks/angular/grid/ui-grid.core.min.js"></script>
   <script type="text/javascript" src="libraries/frameworks/angular/grid/ui-grid.selection.min.js"></script>
    <script type="text/javascript" src="libraries/frameworks/angular/grid/ui-grid.cellnav.min.js"></script>
   
  <script type="text/javascript" src="libraries/frameworks/angular/ui-bootstrap-tpls-1.3.2.js"></script>  
       
  <script type="text/javascript" src="libraries/frameworks/angular/angular-datatables/angular-datatables.min.js"></script>
  <link rel="stylesheet" href="libraries/frameworks/angular/angular-datatables/css/angular-datatables.min.css">  
  <script type="text/javascript" src="libraries/frameworks/angular/angular-datatables/plugins/select/angular-datatables.select.min.js"></script>
  
  <script type="text/javascript" src="libraries/frameworks/bootstrap/fileInput/js/fileinput.min.js"></script>
  <link rel="stylesheet" href="libraries/frameworks/bootstrap/fileInput/css/fileinput.min.css">    
  
  <script type="text/javascript" src="libraries/frameworks/bootstrap/datepicker/js/bootstrap-datepicker.min.js"></script>
  <link rel="stylesheet" href="libraries/frameworks/bootstrap/datepicker/css/bootstrap-datepicker.min.css">    

<!-- UtilLibraries -->

<script type="text/javascript" src="libraries/utils/ScriptUtils.js"></script>
<script type="text/javascript" src="libraries/utils/ControllerUtils.js"></script>
<script type="text/javascript" src="libraries/utils/AppConfig.js"></script>


</head>
  <script type="text/javascript">
    angular.element(document.getElementsByTagName('head')).append(angular.element('<base href="' + window.location.pathname + '" />'));
  </script>  

<style>
    input {
        max-width: 100%;
    }
    select {
        max-width: 100%;
    }  
</style>

</head>

     
<body ng-app="MainWindow">
   <div class="container-fluid" ng-controller="MainController" ng-init="init()">
   <div class="row">
      <div class="col-xs-12">
      <nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">[SIN TITULO]</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"></a>
          </div>  
            <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
               <li class="active"><a href="/WEBSpringProject/main">Home</a></li>
               <li class="dropdown"><a href="#/nullState" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">ubc servicio<span class="caret"></span></a>
				  <ul class="dropdown-menu">
                     <li><a ng-href="#/ListUBCServicio_fromMenu/prueba">listado ubc servicio</a></li>                     
                  </ul>
               </li>
            </ul>                     
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>           
   </div>
   <div class="row">
  	  	<div class="col-xs-1">
  	  	  <!-- barra de botones. -->	  	    	  	  
  	  	  <div class="row" ng-repeat="boton in botones">
	         <a href="#" ng-if="boton.enabled">
	         <img ng-src="{{boton.iconSrc}}"
	            data-toggle="tooltip" data-placement="right" title="{{boton.info}}" 
	            ng-click="click(boton)" width="60px" height="60px">
	         </a>
          </div>
  	  	</div>
  	  	<div class="col-xs-11">		 
  	  	   <div class="row"> 	
			   <ol class="breadcrumb">  
			      <li class="breadcrumb-item"><a href="/WEBSpringProject/main">Home</a></li>      
	              <li class="breadcrumb-item" ng-repeat="linkItem in navigationHistory.itemList">	                 	                 
	                 <a ng-href="#/nullState" ng-click="linkItem.onClick()" >{{linkItem.getLinkAlias()}}</a>	                 	                 	                
	              </li>
	           </ol>
           </div>
           <div class="row">
              <div class="panel panel-default">
                <div ui-view="content" class="panel-body">		   		   
		   		</div>
		   		<div ui-view="footer" class="panel-footer">		   		   
		   		</div>		   		
	          </div>
	       </div>
        </div>
      </div>
   </div>
<script type="text/javascript">
var myApp = angular.module('MainWindow',['ngRoute', 'ui.bootstrap','ui.grid', 'ui.router'
                                       , 'ui.grid.selection', 'datatables', 'datatables.select'
                                       , 'ngResource']);
</script>     

 
   
    


<script type="text/javascript">
//inicializacion de constantes.
var projectSiteData = {
   siteName           : 'WEBSpringProject'
   ,appBaseDir        :'/libraries/base'
	,appComponentsDir : '/libraries/components'
	,appUtilsDir      : '/libraries/utils'
	,appServicesDir   : '/libraries/services'
	,appRootDir       : '/app'
	,sourceDelivery   : 'sourceDelivery'
	,autorizationDisabled : true
}
myApp.constant('projectSite',projectSiteData);
myApp.controller('MainController', ['$transitions','$rootScope', '$scope', '$location', '$log', 'showMessage', '$state', 'NavigationHistoryService'
                         , function($transitions, $rootScope, $scope,  $location, $log, showMessage, $state, NavigationHistoryService) {   
    $scope.$location = $location;   
    
    $scope.initBreadCumbs = function(){
    	$scope.linkItems=[];     	
    };
   
    $scope.$on('MAIN-disableAll', function(event, arg){
    	var f = $scope.botones.length;
    	for (var i=0; i<f; i++){
    		if ($scope.botones[i].enabled){
    			$scope.botones[i].enabled = false;    			
    		}
    	}    	
    });
    
    $scope.$on('MAIN-enableButton', function(event, arg){
    	var buttonName = arg.name;
    	var f = $scope.botones.length;
    	for (var i=0; i<f; i++){
    		if ($scope.botones[i].name == buttonName){
    			$scope.botones[i].enabled = true;
    			return;
    		}
    	}
    	$log.info('BOTON (' + buttonName + ') NO ENCONTRADO');
    });
    
    $scope.click = function(botonPresionado){
    	$log.info('BOTON PRESIONADO:' + botonPresionado.name);
    	$scope.$emit('cmdButtonClick_' + botonPresionado.name, botonPresionado);
    };    
    
	/*$scope.$on('addLinkItem', function(event, arg){
		var itemName =arg.linkAlias;
		var url= arg.urlValue;
		var urlParams = arg.urlParams;
		var stateParams = arg.stateParams;
		
		//$scope.addItem(itemName, url, urlParams, stateParams);
		addItem($scope, itemName, url, urlParams, stateParams);
	});*/
	
	$scope.$on('resetNavigationBar', function(event, arg){
    	$scope.initBreadCumbs();
	});
    
		
	$scope.$on('MAIN-enableButton', function(event, arg){
		$scope.$broadcast('MENUBAR-enableButton', arg);
	});
	
	$scope.navigationHistory = {};
	NavigationHistoryService($scope.navigationHistory);
    
   
    $scope.init = function(){
   		$scope.initBreadCumbs();
   		$scope.botones  = [
        {
             name : 'Informacion'             	
    	  	,iconSrc : 'libraries/icons/info.png    	'    
    	   	,enabled : false
    	  }
  ,      {
             name : '"Pantalla de ayuda"'             	
    	  	,iconSrc : 'libraries/icons/help.png'    
    	   	,enabled : false
    	  }
  ,      {
             name : 'Actualizar'             	
    	  	,iconSrc : 'libraries/icons/update.png'    
    	   	,enabled : false
    	  }
  ,      {
             name : 'Upload'             	
    	  	,iconSrc : 'libraries/icons/upload.png         	'    
    	   	,enabled : false
    	  }
  ,      {
             name : 'Download'             	
    	  	,iconSrc : 'libraries/icons/download.png    	'    
    	   	,enabled : false
    	  }
  ,      {
             name : 'Detalle'             	
    	  	,iconSrc : 'libraries/icons/detail.png'    
    	   	,enabled : false
    	  }
  ,      {
             name : 'Eliminar'             	
    	  	,iconSrc : 'libraries/icons/minus.png'    
    	   	,enabled : false
    	  }
  ,      {
             name : 'Aceptar'             	
    	  	,iconSrc : 'libraries/icons/accept.png'    
    	   	,enabled : false
    	  }
  ,      {
             name : 'Agregar'             	
    	  	,iconSrc : 'libraries/icons/plus.png'    
    	   	,enabled : false
    	  }
       ];	
       
       $log.info('INICIALIZANDO BARRA DE BOTONES');    	    	

    	//habilitar comunicacion de los botones.
    	$scope.botones.forEach(function(boton){
    		$log.info('HACIENDO DEPLOY DEL BOTON:' + boton.name);
    		var name = boton.name;		
    		$scope.$on('cmdButtonClick_' + name, function(event, arg){
    			$log.info('RETRANSMITIENDO');
    			$scope.$broadcast('onClickEvent_' + name);
    		});	
    	});
    	
    	$state.go('DetailUBCServicioGridTest', {
            state : 'CN'    
            ,correlativo : 9
        })
    };       
    
    $scope.addItem = function (itemName, url, urlParams, stateParams){
    	//validar si el link seleccionado ya esta dentro del trace.
    	var pos=0;
    	var itemEncontrado=false;
    	var l =$scope.linkItems.length;
    	
    	for (var i=0;i<l;i++){
    		pos++;
    		var linkItem = $scope.linkItems[i];
    		if (linkItem.linkItemName == itemName){
    			itemEncontrado = true;
    			break;
    		}      		    		
    	}
    	
    	if (itemEncontrado){
    		$scope.linkItems = $scope.linkItems.slice(0, pos);
    		return;
    	}
    	
    	//obtener los valores de los parametros.
    	var paramsValue = [];
    	
    	urlParams.forEach(function (param){
    		var value = getPropertyPath(stateParams, param);
    		if (value == null){
    			value = '';
    		}
    		paramsValue.push(value);
    	});
    	
    	var fullUrl = url;
    	paramsValue.forEach(function(param){
    		fullUrl += '/' + param; 
    	});
    	
    	var linkItem = {
    		linkItemName : itemName
    		,url         : url
    		,params      : paramsValue
    		,fullUrl     : fullUrl     
    		,linkType    : stateParams.linkType
    	};
    	
    	$scope.linkItems.push(linkItem);
    }

    
    /*
    no trabaja con angularui router 1.0
    $rootScope.$on('$stateChangeSuccess', 
    		function(event, toState, toParams, fromState, fromParams){ 
    	$log.log('statechange success');
    });
    
    $rootScope.$on('$stateChangeError', 
    		function(event, toState, toParams, fromState, fromParams){ 
    	$log.log('statechange error');
    	showMessage('PANTALLA NO ENCONTRADA O NO ESTA AUTORIZADO');
    });   */
      
    $transitions.onStart({}, function(transition){
       $log.log('TRANSITION (start)'); 	   
 	   var destinyState = transition.params('to'); 
 	   var destinyParams = transition.$to();
 	   if (destinyState.urlValue == 'nullState'){
 		   transition.abort(); 		 
 	   }else{
 	 	   //procesar transicion.
 	 	   $scope.navigationHistory.addItem(destinyParams.name, destinyState);
 	   }    	    	   
    });   
 
    $transitions.onExit({}, function(transition){
 	   $log.log('TRANSITION (exit)');
    });   
    $transitions.onRetain({}, function(transition){
 	   $log.log('TRANSITION (retain)');
    });   
    $transitions.onEnter({}, function(transition){
 	   $log.log('TRANSITION (enter)');
    });   
    $transitions.onFinish({}, function(transition){
 	   $log.log('TRANSITION (finish)');
    });   
 
    $transitions.onError({}, function(transition){
 	   $log.log('TRANSITION (ERROR)');
 	   showMessage('PANTALLA NO ENCONTRADA O NO ESTA AUTORIZADO');
 	   return false;
    });   
    
}]);


myApp.config(['$stateProvider', '$urlRouterProvider'
    , function($stateProvider,   $urlRouterProvider) {     
     
     //carga de todos los links.
     //addRoute('/WEBSpringProject//libraries/base','DetalleUBCDestinoModal', 'app/screens/ubcTests/DetalleUBCDestinoModal.html', 'detalle ubcdestino'
      //  , [], $stateProvider, false);
     //addRoute('/WEBSpringProject//libraries/base','ListUBCServicio', 'app/screens/ubcTests/ListUBCServicio.html', 'listado servicio'
     //   , ['paramPrueba'], $stateProvider, false);
     //addRoute('/WEBSpringProject//libraries/base','DetalleUBCArchivo', 'app/screens/ubcTests/DetalleUBCArchivo.html', 'detalle ubcarchivo'
     //   , ['idArchivo','servicioInTO'], $stateProvider, false);
     //addRoute('/WEBSpringProject//libraries/base','DetalleUBCLote', 'app/screens/ubcTests/DetalleUBCLote.html', 'detalle ubclote'
     //   , ['id','secuencial'], $stateProvider, false);
     //addRoute('/WEBSpringProject//libraries/base','ListUBCArchivo', 'app/screens/ubcTests/ListUBCArchivo.html', 'listado UBCArchivo'
     //   , ['servicioInTO'], $stateProvider, false);
    // addRoute('/WEBSpringProject//libraries/base','DetailUBCServicio', 'app/screens/ubcTests/DetailUBCServicio.html', 'detalle servicio'
     //   , ['correlativo','servicioNombre'], $stateProvider, false);

     //cargar los los links a los que se hace referencia desde el menu.
     //addRoute('/WEBSpringProject//libraries/base', 'ListUBCServicio_fromMenu', 'app/screens/ubcTests/ListUBCServicio.html', 'listado servicio'
     //   ,['paramPrueba'] // estado valido es [] 
     //   , $stateProvider, true);

     //addRoute('/WEBSpringProject//libraries/base', 'OtherWisePage', 'libraries/base/OtherWisePage.html', 'OtherWisePage'
     //   , []  , $stateProvider, false);
     
     //addRoute('/WEBSpringProject//libraries/base', 'HomePage', 'libraries/base/HomePage.html', 'HomePage'
     //    , [] , $stateProvider, false);
     
     //addRoute('/WEBSpringProject//libraries/base', 'nullState', 'libraries/base/HomePage.html', 'HomePage'
     //        , [] , $stateProvider, false);          
     
     /*addRoute('/WEBSpringProject//libraries/base', 'ListUBCServicio_fromMenu', 'sourceDelivery?objectName=ListUBCServicio&objectType=SCREEN_PAGE', 'listado servicio'    		 
        , []    
        , $stateProvider, true);*/

     addRoute('/WEBSpringProject//libraries/base','DetailUBCServicioGridTest', 'app/views/ubcTests/DetailUBCServicioGridTest.html', 'detalle servicio'
          , ['correlativo'], $stateProvider, false);
     
     /*$state.go('DetailUBCServicioGridTest', {
         state : 'CN'    
         ,correlativo : 9
     });  */
     
     $urlRouterProvider.when('/', '/HomePage');     
     $urlRouterProvider.when('', '/HomePage');
     //$urlRouterProvider.when('', 'home');
     
     $urlRouterProvider.otherwise('/OtherWisePage');
     /*$urlRouterProvider.otherwise('OtherWisePage'   ,{    	
    	 url    : '/OtherWisePage'
    	 ,cache :  false
    	 ,views: {
    	    'header': {
    	         templateUrl: '/WEBSpringProject/libraries/base/header.html'
    	     },   	 
    	    'content' :{
    	         templateUrl: 'libraries/base/OtherWisePage.html'         
    	     },
    	     'footer': {
    	         templateUrl: '/WEBSpringProject/libraries/base/footer.html'
    	     }
    	  }       
     });*/
     
     /*$urlRouterProvider.otherwise(function(){
        //showMessage('PANTALLA NO EXISTENTE');
     });*/
     
     /*$transitions.onStart({}, function(transition){
     	$log.log('TRANSITION (START)');
     });
     
     $transitions.onBefore({}, function(transition){
     	$log.log('TRANSITION (BEFORE)');
     });
    
     $transitions.onSuccess({}, function(transition){
     	$log.log('TRANSITION (SUCCESS)');
     });
     
     $transitions.onError({}, function(transition){
     	$log.log('TRANSITION (ERROR)');
     });   */   
     
     /*$state.go('DetailUBCServicioRowspan', {
         state : 'CN'    
         ,correlativo : 9
     });*/
}]);

</script>



<!-- ServiceLibraries -->

<script type="text/javascript" src="libraries/services/CatalogRestService.js"></script>
<script type="text/javascript" src="libraries/services/fileUploadService.js"></script>
<script type="text/javascript" src="libraries/services/EnumRestService.js"></script>
<script type="text/javascript" src="libraries/services/enumDataService.js"></script>
<script type="text/javascript" src="libraries/services/catalogServices.js"></script>
<script type="text/javascript" src="libraries/services/dialogs/showErrorService.js"></script>
<script type="text/javascript" src="libraries/services/dialogs/ShowMessage.js"></script>
<script type="text/javascript" src="libraries/services/dialogs/confirmDialogService.js"></script>
<script type="text/javascript" src="libraries/services/dialogs/ErrorHandler.js"></script>
<script type="text/javascript" src="libraries/services/systemMessage.js"></script>
<script type="text/javascript" src="libraries/services/AJAXServices.js"></script>
<script type="text/javascript" src="libraries/services/SecurityService.js"></script>
<script type="text/javascript" src="libraries/services/NavigationHistoryService.js"></script>
<script type="text/javascript" src="libraries/services/ViewContextInitializer.js"></script>
<script type="text/javascript" src="libraries/services/ReportService.js"></script>

<!-- ComponentLibraries -->

<script type="text/javascript" src="libraries/components/rest/comboCatalog.js"></script>
<script type="text/javascript" src="libraries/components/rest/checkListCatalogCombo.js"></script>
<script type="text/javascript" src="libraries/components/rest/checkListEnumCombo.js"></script>
<script type="text/javascript" src="libraries/components/rest/enumCombo.js"></script>
<script type="text/javascript" src="libraries/components/checkField.js"></script>
<script type="text/javascript" src="libraries/components/textfield.js"></script>
<script type="text/javascript" src="libraries/components/checkListCatalogCombo.js"></script>
<script type="text/javascript" src="libraries/components/enumCombo.js"></script>
<script type="text/javascript" src="libraries/components/checkListEnumCombo.js"></script>
<script type="text/javascript" src="libraries/components/comboCatalog.js"></script>
<script type="text/javascript" src="libraries/components/uploadfile.js"></script>
<script type="text/javascript" src="libraries/components/datepicker.js"></script>
<script type="text/javascript" src="libraries/components/timepicker.js"></script>
<script type="text/javascript" src="libraries/components/listCombo.js"></script>
<script type="text/javascript" src="libraries/components/labelField.js"></script>
<script type="text/javascript" src="libraries/components/linkField.js"></script>
<script type="text/javascript" src="libraries/components/buttonField.js"></script>
<script type="text/javascript" src="libraries/components/gridField.js"></script>
<script type="text/javascript" src="libraries/components/typeAhead.js"></script>

<!-- AppLibrary -->


<script type="text/javascript" src="app/views/ubcTests/DetailUBCServicioRowspan.js"></script>
<script type="text/javascript" src="app/views/ubcTests/DetailUBCServicioGridTest.js"></script>
<script type="text/javascript" src="app/userMethods/UBCDestinoPre.js"></script>
<script type="text/javascript" src="app/controllers/ubcTests/UBCLoteController.js"></script>   
<script type="text/javascript" src="app/controllers/ubcTests/TestParamController.js"></script>
<script type="text/javascript" src="app/userMethods/UserMethodAbort.js"></script>
<script type="text/javascript" src="app/controllers/ubcTests/UBCArchivoController.js"></script>
<script type="text/javascript" src="app/controllers/ubcTests/ListParamController.js"></script>
<script type="text/javascript" src="app/controllers/ubcTests/UBCDestinoController.js"></script>   
<script type="text/javascript" src="app/userMethods/UBCServiceTest.js"></script>   
<script type="text/javascript" src="app/controllers/ubcTests/UBCServicioController.js"></script>   
<script type="text/javascript" src="app/userMethods/UserMethod3.js"></script>
<script type="text/javascript" src="app/userMethods/UBCActualizaDestinoPost.js"></script>
<script type="text/javascript" src="app/userMethods/UserMethod2.js"></script>
<script type="text/javascript" src="app/userMethods/UserMethod1.js"></script>
<script type="text/javascript" src="app/userMethods/UBCPostMethod.js"></script>
<script type="text/javascript" src="app/userMethods/UBCDestinoPost.js"></script>

<!-- 
<script type="text/javascript" src="sourceDelivery?objectName=ListUBCServicio&objectType=SCREEN_CONTROLLER"></script>
<script type="text/javascript" src="sourceDelivery?objectName=UBCServicioController&objectType=CONTROLLER"></script>
 -->
<!-- AppBaseLibrary -->

<script type="text/javascript" src="libraries/base/header.js"></script>
<script type="text/javascript" src="libraries/base/footer.js"></script>
<script type="text/javascript" src="libraries/base/home.js"></script>
<script type="text/javascript" src="libraries/base/OtherWisePage.js"></script>
<script type="text/javascript" src="libraries/base/HomePage.js"></script>


</body>
</html>
    
