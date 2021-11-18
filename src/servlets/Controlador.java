package servlets;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;


@WebServlet(urlPatterns = {"/Controlador/aves"})
public class Controlador extends HttpServlet {
	private static final long serialVersionUID = 1L;       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		var url= request.getServletPath();
		ArrayList<String> aves= new ArrayList<String>();
	
		if(url.equalsIgnoreCase("/Controlador/aves")) {			
			
			try {
				aves= buscarNomesAves();
			} catch (ParserConfigurationException | SAXException | IOException e) {
				System.err.println(e);
			}
			
			request.setAttribute("aves", aves);
			
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}
		
	}
	
	private ArrayList<String> buscarNomesAves() throws ParserConfigurationException, SAXException, IOException {		
		
		File arquivo= new File("workspace/info-aves/WebContent/aves.xml");			
		
		DocumentBuilderFactory dbf= DocumentBuilderFactory.newInstance();
		DocumentBuilder db= dbf.newDocumentBuilder();
		Document documento= db.parse(arquivo);
		documento.getDocumentElement().normalize();
			
		ArrayList<String> nomesAves= new ArrayList<String>();
			
		NodeList listaNos= documento.getElementsByTagName("ave");
		for(int i=0; i<listaNos.getLength(); i++) {
			
			Node no= listaNos.item(i);							
			if(no.getNodeType() == Node.ELEMENT_NODE) {
				
				Element elemento= (Element) no;
				nomesAves.add(elemento.getAttribute("nome"));				
			}				
		}
		
		return nomesAves;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}
