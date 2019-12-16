<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="/includes/header.jsp" %>

 
	<h1>Formulario</h1>
	
	usar este atributo para rellenar los values del formulario
	
	${producto}
	
	<!-- ------------------------------------------------------------------------------- -->
	
	<form action="/seguridad/productos" method="post">
	
		<div class="form-group">
	        <label for="id">ID</label>
	        <input type="number" 
	               class="form-control" 
	               name="id" id="id" 
	               required
	               placeholder="Identificador del producto"
	               pattern="[0-9]"
	               min="0" max="100"
	               aria-describedby="idHelp">
	        <small id="idHelp" class="form-text text-muted">Identificador del producto</small>
		</div>

	    <div class="form-group">
	        <label for="nombre">Producto</label>
	        <input type="text" 
	               class="form-control" 
	               name="nombre" id="nombre" 
	               required
	               placeholder="Mínimo 2 Máximo 150"
	               pattern=".{2,150}"
	               aria-describedby="nombreHelp">
	        <small id="nombreHelp" class="form-text text-muted">Nombre del producto</small>
	    </div>

	    <button type="submit" class="btn btn-block btn-outline-primary">Crear</button>
	</form>
	



<%@include file="/includes/footer.jsp" %>    