package com.impression.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

public class Log4jUtil {
//    private static org.apache.log4j.Logg  er log = Logger.getLogger("errors.log");

    private static Logger log = Logger.getLogger("errors.log");

    public Log4jUtil() {

    }

    public static void logErrorMessage(Object message) throws IOException {
        Properties props = new Properties();
//        props.load(new FileInputStream("C:\\Users\\Intern_pc\\Documents\\vccran\\IEPTescoNew\\TescoIEP\\src\\java\\com\\impression\\log4j\\logErrorMessage.properties"));
        props.load(new FileInputStream("D:/IEPTesco/IEPTescoNew/src/java/com/impression/log4j/logErrorMessage.properties"));
        PropertyConfigurator.configure(props);
        log.error(message);
    }

    public static void logInfoMessage(Object message) throws IOException {
        Properties props = new Properties();
//        props.load(new FileInputStream("C:\\Users\\Intern_pc\\Documents\\vccran\\IEPTescoNew\\TescoIEP\\src\\java\\com\\impression\\log4j\\logInfoMessage.properties"));
        props.load(new FileInputStream("D:/IEPTesco/IEPTescoNew/src/java/com/impression/log4j/logInfoMessage.properties"));
        PropertyConfigurator.configure(props);
        log.info(message);
    }

    public static void logFatalMessage(Object message) throws IOException {
        Properties props = new Properties();
//        props.load(new FileInputStream("C:\\Users\\Intern_pc\\Documents\\vccran\\IEPTescoNew\\TescoIEP\\src\\java\\com\\impression\\log4j\\logFatalMessage.properties"));
        props.load(new FileInputStream("D:/IEPTesco/IEPTescoNew/src/java/com/impression/log4j/logFatalMessage.properties"));
        PropertyConfigurator.configure(props);
        log.fatal(message);
    }

    public static void logDebugMessage(Object message) throws IOException {
        Properties props = new Properties();
//        props.load(new FileInputStream("C:\\Users\\Intern_pc\\Documents\\vccran\\IEPTescoNew\\TescoIEP\\src\\java\\com\\impression\\log4j\\logDebugMessage.properties"));
        props.load(new FileInputStream("D:/IEPTesco/IEPTescoNew/src/java/com/impression/log4j/logDebugMessage.properties"));
        PropertyConfigurator.configure(props);
        log.debug(message);
    }

}
