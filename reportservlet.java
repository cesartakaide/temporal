package com.test.servlets;

import java.awt.print.PrinterJob;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PipedInputStream;
import java.io.PipedOutputStream;
import java.util.HashMap;

import javax.print.PrintService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.dme.catalog.to.CatalogDetailTO;
import com.dme.java.command.DaoTOCommandExecService;
import com.test.dao.ParametroTO;
import com.test.dao.SPTestDaoTO;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

/**
 * Servlet implementation class ReportServlet
 */
public class ReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Logger log = Logger.getLogger(ReportServlet.class);
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			JasperReport jasperReport = null;
			
			WebApplicationContext ctx =	WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());

			SPTestDaoTO daoTO = new SPTestDaoTO();
			daoTO.setOperacion("M");
			ParametroTO input = new ParametroTO();		
			input.setCatalogo1(new CatalogDetailTO("1000", "OTROS VALORES"));
			input.setValorLogico(true);

			daoTO.setParametro(input);
			daoTO.setMappingAlias("INVOCATION1");
			DaoTOCommandExecService cmdServer= ctx.getBean("DaoTOCommandExecServiceBean", DaoTOCommandExecService.class);
			cmdServer.executeCommand(daoTO);	
			InputStream is= getClass().getClassLoader().getResourceAsStream("com/test/reports/TestReport.jrxml");			
			jasperReport = JasperCompileManager.compileReport(is);
			JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(daoTO.getListado()); 
			byte[] byteStream = JasperRunManager.runReportToPdf(jasperReport, new HashMap<String, Object>(), ds);                            
			OutputStream outStream = response.getOutputStream();
			//response.setHeader("Content-Disposition","inline, filename=myReport.pdf");
			response.setContentType("application/pdf");
			response.setContentLength(byteStream.length);
			outStream.write(byteStream,0,byteStream.length);    
			
			Object paramToPrint= request.getParameter("toPrint");
			if (paramToPrint != null && paramToPrint.equals("S")){
				PrintService[] printers= PrinterJob.lookupPrintServices();
				PrintService prService = null;
				for (PrintService printService : printers) {
					log.info("IMPRESORAS:" + printService.getName());
					if (printService.getName().equals("Programcion y tec")){
						prService = printService;
					}
				}
				
				ByteArrayInputStream bis = new ByteArrayInputStream(byteStream);								
				log.info("IMPRIMIENDO");
				PrinterJob jobPrn = PrinterJob.getPrinterJob(); 
				jobPrn.setPrintService(prService);
				PDDocument doc= PDDocument.load(bis);
				doc.silentPrint(jobPrn);
				bis.close();				
			}
		}catch(Throwable ex){
			log.error("ERROR", ex);
			throw new ServletException("ERROR AL RENDERIZAR REPORTE");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
