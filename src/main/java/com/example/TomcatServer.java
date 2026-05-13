package com.example;

import java.io.File;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.catalina.Context;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;

public class TomcatServer {
    private static final Logger LOGGER = Logger.getLogger(TomcatServer.class.getName());

    public static void main(String[] args) {
        Tomcat tomcat = null;
        try {
            // Ensure directories exist
            new File("target/tomcat/webapps").mkdirs();
            
            tomcat = new Tomcat();
            tomcat.setPort(8082);
            tomcat.setBaseDir(new File("target/tomcat").getAbsolutePath());
            // Ensure embedded Tomcat can see JSP/Jasper classes from the Maven exec classpath.
            tomcat.getEngine().setParentClassLoader(Thread.currentThread().getContextClassLoader());
            // Force connector creation so Tomcat binds the port
            tomcat.getConnector();

            String webappDir = new File("src/main/webapp").getAbsolutePath();
            Context context = tomcat.addWebapp("", webappDir);

            // Map compiled classes into WEB-INF/classes for annotation scanning.
            File classesDir = new File("target/classes");
            if (classesDir.exists()) {
                WebResourceRoot resources = new StandardRoot(context);
                resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes",
                        classesDir.getAbsolutePath(), "/"));
                context.setResources(resources);
            } else {
                LOGGER.warning("target/classes not found. Run 'mvn compile' before starting.");
            }

            System.out.println("Starting Tomcat on port 8082...");
            System.out.println("Application URL: http://localhost:8082/");
            System.out.flush();
            
            tomcat.start();
            System.out.println("Tomcat started successfully!");
            System.out.println("Press Ctrl+C to stop server");
            System.out.flush();
            
            // Keep server running indefinitely
            Thread.currentThread().join();
        } catch (org.apache.catalina.LifecycleException e) {
            LOGGER.log(Level.SEVERE, "LifecycleException starting Tomcat", e);
            if (tomcat != null) {
                try {
                    tomcat.stop();
                } catch (Exception ex) {
                    LOGGER.log(Level.SEVERE, "Error stopping Tomcat", ex);
                }
            }
            System.exit(1);
        } catch (InterruptedException e) {
            LOGGER.log(Level.INFO, "Server interrupted");
            if (tomcat != null) {
                try {
                    tomcat.stop();
                } catch (Exception ex) {
                    LOGGER.log(Level.SEVERE, "Error stopping Tomcat", ex);
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, String.format("Unexpected error: %s", e.getMessage()), e);
            if (tomcat != null) {
                try {
                    tomcat.stop();
                } catch (Exception ex) {
                    LOGGER.log(Level.SEVERE, "Error stopping Tomcat", ex);
                }
            }
            System.exit(1);
        }
    }
}
