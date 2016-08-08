package com.dme.java.util;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Collection;
import java.util.Stack;

import com.dme.core.to.BaseCommandTO;

public class TOBrowser {
	private Stack<String> currentPath=null;
	private StringBuffer paths = null;
	private String pathSeparator="/";
	
	public TOBrowser(String pathSeparator){
		currentPath = new Stack<String>();
		paths = new StringBuffer();
		this.pathSeparator = pathSeparator;
	}
	
	public void createPaths(Class<? extends BaseCommandTO> clsCmd) throws Exception{
		boolean iscollection=false;
		Field[] fields= clsCmd.getDeclaredFields();
		for (Field field : fields) {
			iscollection=false;
			Class fieldType= (Class) field.getType();
			if (fieldType.isArray()){
				continue;
			}
			if (Collection.class.isAssignableFrom(fieldType)){
				Type genericFieldType = field.getGenericType();
				ParameterizedType aType = (ParameterizedType) genericFieldType;
			    Type[] fieldArgTypes = aType.getActualTypeArguments();
				//tomar el generic type.
				//seteando datos del mapeo a nivel de campo.
		    	fieldType = (Class) fieldArgTypes[0];
		    	iscollection = true;
			}			
			if (fieldType.isPrimitive() || JavaBasicTypes.isBasicType(fieldType)){
				String s = currentPathToString() + pathSeparator + field.getName();
				addToPath(s);
			}else{
				if (Serializable.class.isAssignableFrom(fieldType)){
					if (iscollection){
						currentPath.push("[" + field.getName() + "]");
					}else{
						currentPath.push(field.getName());
					}
					createPaths(fieldType);
					currentPath.pop();					
				}
			}
		}
	}
	
	public String currentPathToString(){
		StringBuffer sb = new StringBuffer();		
		for (String segment : currentPath) {
			sb.append(pathSeparator);
			sb.append(segment);
		}
		return sb.toString();
	}
	
	public void addToPath(String path){
		paths.append("\n");
		paths.append(path);
	}

	public StringBuffer getPaths() {
		return paths;
	}



	public String getPathSeparator() {
		return pathSeparator;
	}
	
	
	
}
