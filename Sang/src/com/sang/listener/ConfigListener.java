package com.sang.listener;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Enumeration;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sang.common.CoreConstants;


public class ConfigListener implements ServletContextListener{
	private Logger logger = LoggerFactory.getLogger(ConfigListener.class);
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		logger.info("shut down ConfigListener . . .");
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		logger.info("start ConfigListener . . .");
		ServletContext context = event.getServletContext();
		//obtain the System properties and will push some into it
		Properties properties = System.getProperties();
		int configCount = 0;
		Enumeration<String> locations = context.getInitParameterNames();
		while(locations.hasMoreElements()){
			String location = locations.nextElement();
			if(location.startsWith(CoreConstants.configPrefix)){
				String configName = context.getInitParameter(location);
				String realPath = context.getRealPath(configName);
				try {
					logger.info("parsing config file ["+configName+"]");
					logger.info("reading config file ["+configName+"]");
					InputStream config = new FileInputStream(realPath);
					logger.info("success to read config file ["+configName+"]");
					properties.load(config);
					logger.info("success to load config file ["+configName+"]");
					configCount=configCount+1;
				} catch (FileNotFoundException e) {
					logger.info("fail to read config file ["+configName+"].File not found");
					logger.info("config file real path is ["+realPath+"]");
					//throw runtime exception to indicate lisenter fail to start
					throw new RuntimeException();
				} catch (IOException e) {
					logger.info("fail to load config file ["+configName+"] by properties");
					logger.info("config file real path is ["+realPath+"]");
					//throw runtime exception to indicate lisenter fail to start
					throw new RuntimeException();
				}
			}
		}
		logger.info("Success to start ConfigListener , configCount is "+ configCount);
	}

}
