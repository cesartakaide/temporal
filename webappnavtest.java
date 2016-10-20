package com.test.app;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.appgen.web.configurator.DaoTOTree;
import com.appgen.web.screen.enums.ScreenType;
import com.test.dao.DetailParameterDao;
import com.test.dao.ListDaoTest;
import com.test.dao.ManttoParameterTest;

public class WebNavAppTest {
	public static final void main(String[] d){
		try{			
			ApplicationContext  ctx = new ClassPathXmlApplicationContext(				
				     "classpath:/META-INF/core-config.xml"
					,"classpath:/META-INF/BeanCommand-config.xml"
					,"classpath:/META-INF/datasource-direct-config.xml"					
					,"classpath:/META-INF/catalog-config.xml"
					,"classpath:/META-INF/converter-config.xml"
					,"classpath:/applicationContext-local.xml"
					,"applicationContext-local.xml"
					,"classpath:/META-INF/applicationAppGen-local.xml"
					,"properties-config-webappgen.xml");
			
			String parametro = "parameter";
			String packageStr = "com.test.appgen.action";
			DaoTOTree tree= ctx.getBean("DaoTOTree",DaoTOTree.class);
			
			tree.initTree(ListDaoTest.class, ScreenType.LIST, parametro, packageStr)			
				.addBranch("detalle", DetailParameterDao.class
					, ScreenType.DETAIL, parametro, packageStr
					//, new String[] {"criterio/cliente/unicoOTRO","parametro/unicoOTRO"});
					, new String[] {"[listado]/unicoOTRO","criterio/cliente/unicoOTRO"})
				.addBranch("edicion",ManttoParameterTest.class, ScreenType.OPERATION, "manttoParameter", packageStr
					, new String[] {"[listado]/unicoOTRO","parametro/cliente/unicoOTRO"}
				    , new String[] {"[*CONST]operacion","E"}
					, new String[] {"[*CONST]inputMode","true"})
				.addBranch("eliminacion",ManttoParameterTest.class, ScreenType.OPERATION, "manttoParameter", packageStr
						, new String[] {"[listado]/unicoOTRO","parametro/cliente/unicoOTRO"}
					    , new String[] {"[*CONST]operacion","D"}
						, new String[] {"[*CONST]inputMode","true"})
				.addBranch("nuevo", ManttoParameterTest.class, ScreenType.OPERATION, "manttoParameter", packageStr
						, new String[] {"[*CONST]operacion","I"}
						, new String[] {"[*CONST]inputMode","true"});
			
			tree.renderAll();
			System.out.println("FIN GENERACION CODIGO");
		}catch(Exception ex){
			System.out.println("ERROR:" + ex.getMessage());
			ex.printStackTrace();
		}
	}
}
