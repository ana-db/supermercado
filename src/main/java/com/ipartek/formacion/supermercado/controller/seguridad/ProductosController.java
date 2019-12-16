package com.ipartek.formacion.supermercado.controller.seguridad;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.ipartek.formacion.supermercado.controller.Alerta;
import com.ipartek.formacion.supermercado.modelo.dao.ProductoDAO;
import com.ipartek.formacion.supermercado.modelo.pojo.Producto;


/**
 * Servlet implementation class ProductosController
 */
@WebServlet("/seguridad/productos")
public class ProductosController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final Logger LOG = Logger.getLogger(ProductosController.class);
	
	private static final String VIEW_TABLA = "productos/index.jsp";
	private static final String VIEW_FORM = "productos/formulario.jsp";
	private static String vistaSeleccionda = VIEW_TABLA;
	private static ProductoDAO dao;
	
	//acciones
	public static final String ACCION_LISTAR = "listar";
	public static final String ACCION_IR_FORMULARIO = "formulario";
	public static final String ACCION_GUARDAR = "guardar";   // crear y modificar
	public static final String ACCION_ELIMINAR = "eliminar";
       
	//variables:
	String pAccion;
	String pId;
	String pNombre;
	String pPrecio;
	String pImagen;
	String pDescripcion;
	String pDescuento;
	
	
	@Override
	public void init(ServletConfig config) throws ServletException {		
		super.init(config);
		dao = ProductoDAO.getInstance();
	}
      
	@Override
	public void destroy() {	
		super.destroy();
		dao = null;
	}
	
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. recogemos parámetros: 
		pAccion = request.getParameter("accion");
		
		pId = request.getParameter("id");
		pNombre = request.getParameter("nombre");
		pPrecio = request.getParameter("precio");
		pImagen = request.getParameter("imagen");
		pDescripcion = request.getParameter("descripcion");
		pDescuento = request.getParameter("descuento");
		
		
		try {
			//lógica de negocio
			
			switch (pAccion)
			{
				case ACCION_LISTAR:
					listar(request, response);
					break;
					
				case ACCION_ELIMINAR:
					eliminar(request, response);
					break;	
				
				case ACCION_GUARDAR:
					guardar(request, response);
					break;	
					
				case ACCION_IR_FORMULARIO:	
					irFormulario(request, response);
					
				default:
					listar(request, response);
					break;
			}
			
			request.setAttribute("productos", dao.getAll());
			
		}
		catch (Exception e)
		{
			//TODO log
			LOG.warn("Ha habido algún problema");
			e.printStackTrace();
		}
		finally{
			//ir a JSP:
			request.getRequestDispatcher(vistaSeleccionda).forward(request, response);
		}
	}
	
	
	
	//métodos: 
	
	private void irFormulario(HttpServletRequest request, HttpServletResponse response) {
		
		//TODO pregutar por pID > 0 recuperar del DAO
		// si no New Producto()
		
		//  	dao.getById(id) => implementar
		
		//////////////////////////////////////////
		
		//recibimos parámetros:
		int pId = ( request.getParameter("pId") == null ) ? 0 : Integer.parseInt(request.getParameter("pId")); 
		
		if (pId > 0) {
			
			Producto producto = dao.getById(pId); //getById() en IDAO
		
		}
		else {
			Producto producto = new Producto();
			request.setAttribute("pId", producto.getId() );
			request.setAttribute("pNombre", producto.getNombre() );
			LOG.trace("Sólo se listan los productos");
		}
		
		/////////////////////////////////////////
		
		request.setAttribute("producto", new Producto() );
		vistaSeleccionda = VIEW_FORM;
		
	}

	private void guardar(HttpServletRequest request, HttpServletResponse response) {
		//recibir datos del formulario
		int pId = Integer.parseInt( request.getParameter("id") );		
		
		//en función del id del producto:
		//1. se modificará si el id > 0, significa que el producto está en la lista
		//2. se creará un registro nuevo en caso contrario, puesto que si id = 0, significa que el producto todavía no está en la lista
		if (pId > 0) {
			LOG.trace("Modificar datos del producto");
			
			Producto producto = new Producto();			
			
			//modificamos los datos:
			producto.setId(pId); 
			producto.setNombre(pNombre);
			producto.setImagen(pImagen);
			
			try {
				dao.update(producto, pId);
				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Los datos del producto se han modificado correctamente") ); 
			} catch (Exception e) {
				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "Los datos del producto no se han podido modificar") );
			}						
		}
		else {
			LOG.trace("Crear un registro un producto nuevo");
			
			//crear registro para un producto nuevo
			Producto p = new Producto();
			p.setNombre(pNombre);
			p.setImagen(pImagen);
			
			//p.setId(indice);
			//indice++; //incrementamos para el siguiente
			
			
			
			//lo guardamos en la lista
			//perros.add(p);
			try {
				dao.create(p);
				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Prodcuto nuevo añadido") );
				
			} catch (Exception e) {
				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "No se puede añadir") );
			}	
		}
		
	}

	private void eliminar(HttpServletRequest request, HttpServletResponse response) {
		//recibimos parámetros:
		int pId = ( request.getParameter("pId") == null ) ? 0 : Integer.parseInt(request.getParameter("pId")); 
				
		Producto producto = dao.getById(pId);
		
		if (pId > 0) {
			
			try {
				dao.delete(pId);
				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Ya has comprado " + producto.getNombre() + " Gracias") ); 
				LOG.info(producto.getNombre() + " ha sido comprado");
			} catch (Exception e) {
				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "No se puede comprar este producto") ); 
			}
		}
		
	}

	private void listar(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("productos", dao.getAll() );
		vistaSeleccionda = VIEW_TABLA;
		
	}
	

}
