<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="/includes/header.jsp" %>

 
	<h1 id="top">Tabla</h1>
	
	
	<a href="/seguridad/productos?accion=formulario">Nuevo Producto</a>
	
	
	
	<ol>
		<c:forEach items="${productos}" var="p">
			<li>
				${p} <br>
				<a href="/seguridad/productos?accion=formulario&id=${p.id}">Editar</a>
			</li>
		</c:forEach>
	</ol>
	
	${productos}
	
	<!-- ------------------------------------------- -->
	

	
	<style>

		 .foto-perfil-producto {
		 	width: 3.5em;
		 }
	 
	</style>
	
	<%
	ArrayList<Producto> productos = (ArrayList<Producto>)request.getAttribute("productos");
	%>
	
	<!-- DATATABLES -->
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.dataTables.min.css"/>
        
	<!-- JAVASCRIPT -->
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	
	<script type="text/javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js"></script>
	    
	<script>
       	//nuestro script para seleccionar la tabla y ejecutar plugin
       	//con este script conseguimos que la tabla se adapte a las distintas posiciones del dispositivo y sea visible siempre (https://datatables.net/reference/option/responsive - https://datatables.net/extensions/responsive/examples/styling/compact) 
        $(document).ready(function() { //espera que esté todo el DOM (Document Object Mode, toda la págia web) cargado y listo. Podría cascar si cuando empieza a ejecutar, todavía no ha cargado la tabla
        	$('.tabla').DataTable( { 
        	 	responsive: true, 
        	 	language: 
        	 		{
		    			"sProcessing":     "Procesando...",
		                "sLengthMenu":     "Mostrar _MENU_ registros",
		                "sZeroRecords":    "No se encontraron resultados",
		                "sEmptyTable":     "Ningún dato disponible en esta tabla =(",
		                "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
		                "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
		                "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
		                "sInfoPostFix":    "",
		                "sSearch":         "Buscar:",
		                "sUrl":            "",
		                "sInfoThousands":  ",",
		                "sLoadingRecords": "Cargando...",
		                "oPaginate": {
		                    "sFirst":    "Primero",
		                    "sLast":     "Último",
		                    "sNext":     "Siguiente",
		                    "sPrevious": "Anterior"
		                },
		                "oAria": {
		                    "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
		                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
		                },
		                "buttons": {
		                    "copy": "Copiar",
		                    "colvis": "Visibilidad"
		                }	
	         	 	} //cerramos language
				} );
	         } );
         </script>
         
         
         <!-- TABLA -->
         <table class="tabla reponsive display">
	        <thead>
	            <tr>
	                <th>ID</th>
	                <th>Nombre</th>
	                <th>Precio</th>
	                <th>Imagen</th>
	                <th>Descripción</th>
	                <th>Descuento</th>
	                <th>Acción</th>
	            </tr>
	        </thead>
	        
	        <tbody>
		        				
				<%
					for ( Producto p :  productos ){
						int id = (int)p.getId();
				%>
				<tr>
					<td><%=p.getId()%></td>
					<td><%=p.getNombre()%></td>
					<td><%=p.getPrecio()%></td>
					<td><img src="<%=p.getImagen()%>"></td>
					<td><%=p.getDescripcion()%></td>
					<td><%=p.getDescuento()%></td>
					<td><a href="/seguridad/productos?accion=formulario&id=${p.id}">Editar</td>
				</tr>
				<%
					}
				%>		
									
	        </tbody>
	            
			<tfoot>
	            <tr>
	                <th>ID</th>
	                <th>Nombre</th>
	                <th>Precio</th>
	                <th>Imagen</th>
	                <th>Descripción</th>
	                <th>Descuento</th>
	                <th>Acción</th>
	            </tr>
	        </tfoot>
    	</table>
	

	
	
	<!-- ------------------------------------------- -->            
	
	

	<a id="btn-top" href="#top" class="btn btn-primary">top</a>

<%@include file="/includes/footer.jsp" %>    