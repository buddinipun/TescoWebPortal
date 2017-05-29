/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import javax.imageio.ImageIO;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;

import org.apache.tomcat.util.http.fileupload.FileItemStream;

/**
 *
 * @author Charitha
 */
public class FileUpload {

    public static boolean processFile(String path, FileItemStream item, String fileName) {
        try {
            File f = new File(path + File.separator + "artwork");

            File f2 = new File(path + File.separator + "artwork" + File.separator + fileName + ".png");

            if (!f.exists()) {
                f.mkdir();
            }

            if (f2.exists()) {
                f2.delete();
            }

            // File savedFile = new File(f.getAbsolutePath() + File.separator + item.getName());
            File savedFile = new File(f.getAbsolutePath() +".png");
            FileOutputStream fos = new FileOutputStream(savedFile);
            InputStream is = item.openStream();
            int x = 0;
            byte[] b = new byte[1024];
            while ((x = is.read(b)) != -1) {
                fos.write(b, 0, x);
            }
            fos.flush();
            fos.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();

        }
        return false;
    }

    public static boolean convertProcessFile(String src, String destination, String FileName) {

        try {

            //  String sourceDir = "D:/New/04-Request-Headers.pdf"; // Pdf files are read from this folder
            String sourceDir = src + FileName + ".pdf"; // Pdf files are read from this folder
            // String destinationDir = "D:/Img/Converted_PdfFiles_to_Image/"; // converted images from pdf document are saved here
            String destinationDir = destination; // converted images from pdf document are saved here

            // System.out.println("src" + src);
            // System.out.println("destination" + destination);
            // System.out.println("FileName" + FileName);

            File sourceFile = new File(sourceDir);

            File destinationFile = new File(destinationDir);
            if (!destinationFile.exists()) {
                destinationFile.mkdir();
                // System.out.println("Folder Created -> " + destinationFile.getAbsolutePath());
            }
            if (sourceFile.exists()) {
                // System.out.println("Images copied to Folder: " + destinationFile.getName());
                PDDocument document = PDDocument.load(sourceDir);
                List<PDPage> list = document.getDocumentCatalog().getAllPages();
                // System.out.println("Total files to be converted -> " + list.size());

                String fileName = sourceFile.getName().replace(".pdf", "");
                int pageNumber = 1;

                for (PDPage page : list) {
                    BufferedImage image = page.convertToImage();
                    File outputfile = new File(destinationDir + fileName + ".png");
                    // System.out.println("Image Created -> " + outputfile.getName());
                    ImageIO.write(image, "png", outputfile);
                    pageNumber++;
                }

                document.close();
                // System.out.println("Converted Images are saved at -> " + destinationFile.getAbsolutePath());
            } else {
                System.err.println(sourceFile.getName() + " File not exists");
            }

        } catch (IOException ie) {
            // System.out.println("Io exception in ");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
