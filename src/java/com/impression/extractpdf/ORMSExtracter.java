package com.impression.extractpdf;

import com.impression.dao.Check_lof;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.impression.dao.UserDAO;
import com.impression.hibe.model.Customer;

import com.impression.hibe.model.LofGeneraldata;
import com.impression.hibe.model.SysUser;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.parser.PdfTextExtractor;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class PDFExtracter
 */
public class ORMSExtracter extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private boolean isMultipart;
    private String filePath;
    private final int maxFileSize = 1000 * 1024;
    private final int maxMemSize = 1000 * 1024;
    private File file;
    // public static final String PREFACE =
    // "C:\\Users\\User\\workspace\\Impression\\4.pdf";
    static String[] arr = null;

    @Override
    public void init() {
        // Get the file location where it would be stored.
        filePath = getServletContext().getInitParameter("file-upload");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        HttpSession httpSession = request.getSession();
        SysUser user = (SysUser) httpSession.getAttribute("user");
        RequestDispatcher requestDispatcher;
        // Check that we have a file upload request
        isMultipart = ServletFileUpload.isMultipartContent(request);
        response.setContentType("text/html");
        java.io.PrintWriter out = response.getWriter();

        if (!isMultipart) {
            return;
        }
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // maximum size that will be stored in memory
        factory.setSizeThreshold(maxMemSize);
		// Location to save data that is larger than maxMemSize.
        // factory.setRepository(new File(" C:/Users/puneet verma/Downloads/"));

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
        // maximum file size to be uploaded.
        upload.setSizeMax(maxFileSize);

        try {
            // Parse the request to get file items.
            List fileItems = upload.parseRequest(request);

            // Process the uploaded file items
            Iterator k = fileItems.iterator();

            while (k.hasNext()) {
                FileItem fi = (FileItem) k.next();
                if (!fi.isFormField()) {

                    // Get the uploaded file parameters
                    String fieldName = fi.getFieldName();
                    String fileName = fi.getName();
                    String contentType = fi.getContentType();
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();

                    File uploadFile = new File(fileName);
                    uploadFile.deleteOnExit();
                    fi.write(uploadFile);

                    PdfReader reader = new PdfReader(uploadFile.getAbsolutePath());

                    List<Page> lstPage = new ArrayList<>();

                    int pageCount = reader.getNumberOfPages();

                    for (int i = 1; i <= pageCount; i++) {
                        try {
                            String str = PdfTextExtractor.getTextFromPage(reader, i);
                            Page page = new Page();
                            page.setContent(str);
                            page.setPageNo(i);

                            lstPage.add(page);

                        } catch (Exception e) {
                            i = 2;
                            String str = PdfTextExtractor.getTextFromPage(reader, i);
                            Page page = new Page();
                            page.setContent(str);
                            page.setPageNo(i);

                            lstPage.add(page);

                        }
                    }

                    Customer c = new UserDAO().getUserdetailsss(user.getUsername());
                    LofGeneraldata generaldata = new Check_lof().getOrderNumberPDF(c.getCustomerId());
                    String lofID = "";
                    if (generaldata != null) {
                        String tempOrderId = generaldata.getId();
                        String[] tempArray = tempOrderId.split("_");
                        int orderId = Integer.parseInt(tempArray[1]) + 1;
                        if (orderId < 10) {
                            lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + "0000" + orderId + "_1";
                        } else if (orderId < 100) {
                            lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + "000" + orderId + "_1";
                        } else if (orderId < 1000) {
                            lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + "00" + orderId + "_1";
                        } else if (orderId < 10000) {
                            lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + "0" + orderId + "_1";
                        } else {
                            lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + orderId + "_1";
                        }
                    } else {
                        lofID = "LOF_" + user.getCompanyId().getCompanyCode() + "_" + c.getCustomerId() + "00001_1";
                    }

                    CommonData commonData = ExtractORMS.getORMSData(lstPage);

                    CommonData common = ExtractORMS.getORMSData(lstPage);

                    List<String> newList = ExtractORMS.checkForExistEAN(commonData.getEanArr());
                    // System.out.println("newList :" + newList.size());

                    if (newList.size() > 0) {
                        request.getSession().setAttribute("commonData", common);
                        request.getSession().setAttribute("lofID", lofID);
                        request.setAttribute("newList", newList);
                        requestDispatcher = request.getRequestDispatcher("addEanDetails.jsp");

                    } else {

                        request.getSession().setAttribute("commonData", common);
                        request.getSession().setAttribute("lofID", lofID);
                        requestDispatcher = request.getRequestDispatcher("Extract/viewORMS.jsp");
                    }
                    requestDispatcher.forward(request, response);
                }
            }

        }catch(NullPointerException nu){
            request.setAttribute("error_null", "Invalid PDF Format");
            requestDispatcher = request.getRequestDispatcher("Extract/pdfExtracter.jsp");
            requestDispatcher.forward(request, response);
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
