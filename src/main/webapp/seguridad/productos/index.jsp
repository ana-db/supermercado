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
	
	<!-- ${productos} -->
	
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
        
	<!-- JAVASCRIPT los incluimos en el pie-->
	
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
					<!-- <td><a href="/seguridad/productos?accion=formulario&id=${p.id}">Editar</a></td> -->
					<td><a href="/seguridad/productos?accion=formulario&id=<%=p.getId()%>">Editar</a></td> 
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