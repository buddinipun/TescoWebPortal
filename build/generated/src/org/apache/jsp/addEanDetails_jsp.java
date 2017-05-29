package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.List;
import com.impression.extractpdf.CommonData;
import com.impression.hibe.model.SysUser;
import com.impression.hibe.model.SysUser;

public final class addEanDetails_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(3);
    _jspx_dependants.add("/./include/header.jsp");
    _jspx_dependants.add("/./include/sideMenu.jsp");
    _jspx_dependants.add("/include/footer.jsp");
  }

  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_forEach_var_items;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_choose;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_sql_query_var_dataSource;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_when_test;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _jspx_tagPool_c_forEach_var_items = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_c_choose = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_sql_query_var_dataSource = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_c_when_test = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _jspx_tagPool_c_forEach_var_items.release();
    _jspx_tagPool_c_choose.release();
    _jspx_tagPool_sql_query_var_dataSource.release();
    _jspx_tagPool_c_when_test.release();
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("\n");
      out.write("    <head>\n");
      out.write("\n");
      out.write("        <meta charset=\"utf-8\">\n");
      out.write("        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("        <meta name=\"description\" content=\"\">\n");
      out.write("        <meta name=\"author\" content=\"\">\n");
      out.write("        <link rel=\"shortcut icon\" href=\"/IEPTescoNew/img/title_logo.png\" type=\"image/png\">\n");
      out.write("        <link rel=\"shortcut icon\" type=\"image/png\" href=\"/IEPTescoNew/img/title_logo.png\" />\n");
      out.write("\n");
      out.write("        <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js\"></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("        <title>E-Platform | Impressions</title>\n");
      out.write("\n");
      out.write("        <!-- Bootstrap Core CSS -->\n");
      out.write("        <link href=\"/IEPTescoNew/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <!-- Custom CSS -->\n");
      out.write("        <link href=\"/IEPTescoNew/css/sb-admin.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <!-- Morris Charts CSS -->\n");
      out.write("        <link href=\"/IEPTescoNew/css/plugins/morris.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <!-- IMP CSS-->\n");
      out.write("        <link href=\"/IEPTescoNew/css/imp_style.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <!-- Bootstrap Dialog CSS-->\n");
      out.write("        <link href=\"/IEPTescoNew/css/bootstrap-dialog.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <!-- Custom Fonts -->\n");
      out.write("        <link href=\"/IEPTescoNew/font-awesome/css/font-awesome.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("\n");
      out.write("        <link href=\"/IEPTescoNew/css/jquery-ui.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("\n");
      out.write("        <style type=\"text/css\">\n");
      out.write("            .no-js #loader { display: none;  }\n");
      out.write("            .js #loader { display: block; position: absolute; left: 100px; top: 0; }\n");
      out.write("            .se-pre-con {\n");
      out.write("                position: fixed;\n");
      out.write("                left: 0px;\n");
      out.write("                top: 0px;\n");
      out.write("                width: 100%;\n");
      out.write("                height: 100%;\n");
      out.write("                z-index: 9999;\n");
      out.write("                background: url(/IEPTescoNew/img/Preloader_2.gif) center no-repeat #fff;\n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("        <script src=\"http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js\"></script>\n");
      out.write("        <script>\n");
      out.write("            $(window).load(function () {\n");
      out.write("                $(\".se-pre-con\").fadeOut(\"slow\");\n");
      out.write("            });\n");
      out.write("        </script>\n");
      out.write("    </head>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("        <div class=\"se-pre-con\"></div>\n");
      out.write("        <div id=\"wrapper\" style=\"padding-bottom: 40px;\">\n");
      out.write('\n');
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

    SysUser user5 = (SysUser) session.getAttribute("user");
    // System.out.println(user5.getUsername());

      out.write('\n');
      out.write('\n');
      //  sql:query
      org.apache.taglibs.standard.tag.rt.sql.QueryTag _jspx_th_sql_query_0 = (org.apache.taglibs.standard.tag.rt.sql.QueryTag) _jspx_tagPool_sql_query_var_dataSource.get(org.apache.taglibs.standard.tag.rt.sql.QueryTag.class);
      _jspx_th_sql_query_0.setPageContext(_jspx_page_context);
      _jspx_th_sql_query_0.setParent(null);
      _jspx_th_sql_query_0.setVar("idQ2");
      _jspx_th_sql_query_0.setDataSource(new String("jdbc/sdb"));
      int[] _jspx_push_body_count_sql_query_0 = new int[] { 0 };
      try {
        int _jspx_eval_sql_query_0 = _jspx_th_sql_query_0.doStartTag();
        if (_jspx_eval_sql_query_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          if (_jspx_eval_sql_query_0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
            out = _jspx_page_context.pushBody();
            _jspx_push_body_count_sql_query_0[0]++;
            _jspx_th_sql_query_0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
            _jspx_th_sql_query_0.doInitBody();
          }
          do {
            out.write("\n");
            out.write("    SELECT * FROM sys_user_menu_item sm INNER JOIN sys_user s ON sm.`username`=s.`username` WHERE sm.username='");
            out.print(user5.getUsername());
            out.write("'; \n");
            int evalDoAfterBody = _jspx_th_sql_query_0.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
          if (_jspx_eval_sql_query_0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE)
            out = _jspx_page_context.popBody();
            _jspx_push_body_count_sql_query_0[0]--;
        }
        if (_jspx_th_sql_query_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_sql_query_0[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_sql_query_0.doCatch(_jspx_exception);
      } finally {
        _jspx_th_sql_query_0.doFinally();
        _jspx_tagPool_sql_query_var_dataSource.reuse(_jspx_th_sql_query_0);
      }
      out.write(" \n");
      out.write("\n");
      //  sql:query
      org.apache.taglibs.standard.tag.rt.sql.QueryTag _jspx_th_sql_query_1 = (org.apache.taglibs.standard.tag.rt.sql.QueryTag) _jspx_tagPool_sql_query_var_dataSource.get(org.apache.taglibs.standard.tag.rt.sql.QueryTag.class);
      _jspx_th_sql_query_1.setPageContext(_jspx_page_context);
      _jspx_th_sql_query_1.setParent(null);
      _jspx_th_sql_query_1.setVar("idQ5");
      _jspx_th_sql_query_1.setDataSource(new String("jdbc/sdb"));
      int[] _jspx_push_body_count_sql_query_1 = new int[] { 0 };
      try {
        int _jspx_eval_sql_query_1 = _jspx_th_sql_query_1.doStartTag();
        if (_jspx_eval_sql_query_1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          if (_jspx_eval_sql_query_1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
            out = _jspx_page_context.pushBody();
            _jspx_push_body_count_sql_query_1[0]++;
            _jspx_th_sql_query_1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
            _jspx_th_sql_query_1.doInitBody();
          }
          do {
            out.write("\n");
            out.write("    SELECT COUNT(username) as cnt FROM sys_user where company_id='");
            out.print( user5.getCompanyId().getCompanyId());
            out.write("' AND is_active=false;         \n");
            int evalDoAfterBody = _jspx_th_sql_query_1.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
          if (_jspx_eval_sql_query_1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE)
            out = _jspx_page_context.popBody();
            _jspx_push_body_count_sql_query_1[0]--;
        }
        if (_jspx_th_sql_query_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_sql_query_1[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_sql_query_1.doCatch(_jspx_exception);
      } finally {
        _jspx_th_sql_query_1.doFinally();
        _jspx_tagPool_sql_query_var_dataSource.reuse(_jspx_th_sql_query_1);
      }
      out.write('\n');
      out.write('\n');
      //  sql:query
      org.apache.taglibs.standard.tag.rt.sql.QueryTag _jspx_th_sql_query_2 = (org.apache.taglibs.standard.tag.rt.sql.QueryTag) _jspx_tagPool_sql_query_var_dataSource.get(org.apache.taglibs.standard.tag.rt.sql.QueryTag.class);
      _jspx_th_sql_query_2.setPageContext(_jspx_page_context);
      _jspx_th_sql_query_2.setParent(null);
      _jspx_th_sql_query_2.setVar("idQ6");
      _jspx_th_sql_query_2.setDataSource(new String("jdbc/sdb"));
      int[] _jspx_push_body_count_sql_query_2 = new int[] { 0 };
      try {
        int _jspx_eval_sql_query_2 = _jspx_th_sql_query_2.doStartTag();
        if (_jspx_eval_sql_query_2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          if (_jspx_eval_sql_query_2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
            out = _jspx_page_context.pushBody();
            _jspx_push_body_count_sql_query_2[0]++;
            _jspx_th_sql_query_2.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
            _jspx_th_sql_query_2.doInitBody();
          }
          do {
            out.write("\n");
            out.write("    SELECT COUNT(username) as cnt FROM sys_user where company_id='");
            out.print( user5.getCompanyId().getCompanyId());
            out.write("' AND is_active=false;         \n");
            int evalDoAfterBody = _jspx_th_sql_query_2.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
          if (_jspx_eval_sql_query_2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE)
            out = _jspx_page_context.popBody();
            _jspx_push_body_count_sql_query_2[0]--;
        }
        if (_jspx_th_sql_query_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_sql_query_2[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_sql_query_2.doCatch(_jspx_exception);
      } finally {
        _jspx_th_sql_query_2.doFinally();
        _jspx_tagPool_sql_query_var_dataSource.reuse(_jspx_th_sql_query_2);
      }
      out.write("\n");
      out.write("\n");
      out.write("<nav class=\"navbar navbar-inverse navbar-fixed-top\" role=\"navigation\">\n");
      out.write("    <!-- Brand and toggle get grouped for better mobile display -->\n");
      out.write("    <div class=\"navbar-header\">\n");
      out.write("        <button type=\"button\" class=\"navbar-toggle\" data-toggle=\"collapse\" data-target=\".navbar-ex1-collapse\">\n");
      out.write("            <span class=\"sr-only\">Toggle navigation</span>\n");
      out.write("            <span class=\"icon-bar\"></span>\n");
      out.write("            <span class=\"icon-bar\"></span>\n");
      out.write("            <span class=\"icon-bar\"></span>\n");
      out.write("        </button>\n");
      out.write("        <a class=\"navbar-brand\" href=\"#\"  style=\"padding: 10px 10px 10px 20px;\">\n");
      out.write("            <img alt=\"Brand\" src=\"/IEPTescoNew/img/logo_head.png\" class=\"img-responsive\">\n");
      out.write("        </a>\n");
      out.write("        <a class=\"navbar-brand\" href=\"/IEPTescoNew/admin.jsp\">Impressions Labels E-Platform</a>\n");
      out.write("    </div>\n");
      out.write("    <!-- Top Menu Items -->\n");
      out.write("    <ul class=\"nav navbar-right top-nav\">\n");
      out.write("        <li class=\"dropdown\">\n");
      out.write("            <a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" style=\"text-transform: capitalize;\" ><i class=\"fa fa-user\"></i> ");
      out.print(user5.getUsername());
      out.write(" <b class=\"caret\"></b></a>\n");
      out.write("            <ul class=\"dropdown-menu\">\n");
      out.write("                <li>\n");
      out.write("                    <a href=\"/IEPTescoNew/userDetails.jsp\"><i class=\"fa fa-fw fa-user\"></i> Profile</a>\n");
      out.write("                </li>\n");
      out.write("                <li class=\"divider\"></li>\n");
      out.write("                <li>\n");
      out.write("                    <a href=\"/IEPTescoNew/LogoutController\"><i class=\"fa fa-fw fa-power-off\"></i> Log Out</a>\n");
      out.write("                </li>\n");
      out.write("            </ul>\n");
      out.write("        </li>\n");
      out.write("    </ul>\n");
      out.write("    <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->\n");
      out.write("    <div class=\"collapse navbar-collapse navbar-ex1-collapse\">\n");
      out.write("        <ul class=\"nav navbar-nav side-nav\">\n");
      out.write("            <li id=\"menuItem1\" class=\"active\">\n");
      out.write("                <a href=\"/IEPTescoNew/admin.jsp\"><i class=\"fa fa-fw fa-dashboard\"></i> Dashboard</a>\n");
      out.write("            </li>\n");
      out.write("            ");
      if (_jspx_meth_c_forEach_0(_jspx_page_context))
        return;
      out.write("\n");
      out.write("        </ul>\n");
      out.write("    </div>\n");
      out.write("    <!-- /.navbar-collapse -->\n");
      out.write("</nav>\n");
      out.write('\n');
      out.write('\n');
    List<String> eanSendArray = (List<String>) request.getAttribute("newList");


      out.write('\n');
      out.write('\n');
    SysUser user6 = (SysUser) session.getAttribute("user");
    if (user6 != null) {


      out.write("\n");
      out.write("\n");
      out.write("<div id=\"page-wrapper\">\n");
      out.write("    <div class=\"container-fluid\">\n");
      out.write("        <!-- Page Heading -->\n");
      out.write("        <div class=\"row\">\n");
      out.write("            <div class=\"col-lg-8 col-md-8 col-lg-offset-2 col-md-offset-2\">\n");
      out.write("                <div class=\"panel panel-default\">\n");
      out.write("                    <!-- Default panel contents -->\n");
      out.write("                    <div class=\"panel-heading\"><strong>EAN Details</strong></div>\n");
      out.write("                    <div class=\"panel-body\">\n");
      out.write("                        <form method=\"POST\" class=\"form-horizontal\">\n");
      out.write("                            <div class=\"col-lg-8 col-lg-offset-2\">\n");
      out.write("                                <div class=\"form-group\">\n");
      out.write("                                    <label class=\"control-label col-sm-4\" for=\"style_type\">Style Type:</label>\n");
      out.write("                                    <div class=\"col-sm-8\">\n");
      out.write("                                        <select id=\"style_type\" onchange=\"getPrimarySize();\" class=\"form-control\">\n");
      out.write("                                            <option disabled selected> - Select Type - </option>\n");
      out.write("                                            <option value=\"uk\">UK</option>\n");
      out.write("                                            <option value=\"ce\">CE</option>\n");
      out.write("                                        </select>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                        </form>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <!-- Table -->\n");
      out.write("                    <table border=\"0\" class=\"table table-responsive table-striped\" id=\"eanTable\">\n");
      out.write("                        <thead>\n");
      out.write("                            <tr>\n");
      out.write("                                <th width=\"40%\" style=\"text-align: center\" >EAN Number</th>\n");
      out.write("                                <th width=\"30%\" style=\"text-align: center\" >UK Primary Size</th>\n");
      out.write("                                <th style=\"text-align: center\" >CE Primary Size</th>\n");
      out.write("                            </tr>\n");
      out.write("                        </thead>\n");
      out.write("                        <tbody>\n");
      out.write("                            ");
for (int i = 0; i < eanSendArray.size(); i++) {
                            
      out.write("\n");
      out.write("\n");
      out.write("                            <tr>\n");
      out.write("                                <td style=\"text-align: center\" >");
      out.print(eanSendArray.get(i));
      out.write("</td>\n");
      out.write("                                <td>\n");
      out.write("                                    <input id=\"uk_siz");
      out.print(i);
      out.write("\" name=\"uk_siz");
      out.print(i);
      out.write("\" list=\"uk_prim_size\"  value=\"\"  class=\"form-control\" />\n");
      out.write("                                    <datalist id=\"uk_prim_size\"> \n");
      out.write("                                    </datalist>\n");
      out.write("                                </td>\n");
      out.write("                                <td>\n");
      out.write("                                    <input id=\"ce_siz");
      out.print(i);
      out.write("\"  name=\"ce_siz");
      out.print(i);
      out.write("\" list=\"ce_prim_size\"  value=\"\"  class=\"form-control\"/>\n");
      out.write("                                    <datalist id=\"ce_prim_size\" > \n");
      out.write("                                    </datalist>\n");
      out.write("                                </td>\n");
      out.write("                            </tr>\n");
      out.write("                            ");
 if (i == eanSendArray.size() - 1) {

                            
      out.write("\n");
      out.write("                        <script>\n");
      out.write("                            var val_update = [];\n");
      out.write("                            val_update.length = ");
      out.print(i);
      out.write(";\n");
      out.write("                        </script>\n");
      out.write("                        ");
}
                        
      out.write("\n");
      out.write("\n");
      out.write("                        ");

                            }
                        
      out.write("\n");
      out.write("                        </tbody>\n");
      out.write("                    </table>\n");
      out.write("                    <div class=\"panel-footer\">\n");
      out.write("                        <div class=\"row\">\n");
      out.write("                            <div class=\"col-lg-12 col-md-12\">\n");
      out.write("                                <center>\n");
      out.write("                                    <form id=\"next\" action=\"Extract/viewORMS.jsp\" method=\"post\">\n");
      out.write("                                        <input type=\"button\" id=\"btn_update_ean\" name=\"btn_update_ean\" value=\"Update & Next\" class=\"btn btn-default\" style=\"width: 100%;\"/>\n");
      out.write("                                    </form>\n");
      out.write("                                </center>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>        \n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <script type=\"text/javascript\">\n");
      out.write("\n");
      out.write("        function getPrimarySize() {\n");
      out.write("            var style_type = document.getElementById(\"style_type\").value;\n");
      out.write("            document.getElementById(\"uk_prim_size\").options.length = 1;\n");
      out.write("            document.getElementById(\"ce_prim_size\").options.length = 1;\n");
      out.write("            if (style_type === \"uk\") {\n");
      out.write("                $('input[name^=uk_siz]').attr(\"readOnly\", false);\n");
      out.write("                $('input[name^=ce_siz]').attr(\"readOnly\", true);\n");
      out.write("            }\n");
      out.write("            if (style_type === \"ce\") {\n");
      out.write("                $('input[name^=uk_siz]').attr(\"readOnly\", true);\n");
      out.write("                $('input[name^=ce_siz]').attr(\"readOnly\", false);\n");
      out.write("            }\n");
      out.write("            var xmlHttp1 = getAjaxObject();\n");
      out.write("\n");
      out.write("            xmlHttp1.onreadystatechange = function ()\n");
      out.write("            {\n");
      out.write("                if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)\n");
      out.write("                {\n");
      out.write("                    var data = eval('(' + xmlHttp1.responseText + ')');\n");
      out.write("\n");
      out.write("                    var datalistUK = document.getElementById(\"uk_prim_size\");\n");
      out.write("                    var datalistCE = document.getElementById(\"ce_prim_size\");\n");
      out.write("\n");
      out.write("                    var option3 = document.createElement(\"option\");\n");
      out.write("                    option3.innerHTML = \"Free Type --- Free Type\";\n");
      out.write("                    option3.value = \"Free Type --- Free Type\";\n");
      out.write("                    option3.id = \"Free Type --- Free Type\";\n");
      out.write("\n");
      out.write("                    var option4 = document.createElement(\"option\");\n");
      out.write("                    option4.innerHTML = \"Free Type --- Free Type\";\n");
      out.write("                    option4.value = \"Free Type --- Free Type\";\n");
      out.write("                    option4.id = \"Free Type --- Free Type\";\n");
      out.write("\n");
      out.write("                    datalistCE.appendChild(option4);\n");
      out.write("                    datalistUK.appendChild(option3);\n");
      out.write("\n");
      out.write("                    for (var i = 0; i < data.length; i++) {\n");
      out.write("\n");
      out.write("                        var allSize = data[i].split(\"#$#\");\n");
      out.write("\n");
      out.write("                        var option1 = document.createElement(\"option\");\n");
      out.write("                        option1.innerHTML = allSize[0] + \" --- \" + allSize[1];\n");
      out.write("                        option1.value = allSize[0] + \" --- \" + allSize[1];\n");
      out.write("                        option1.id = allSize[0] + \" --- \" + allSize[1];\n");
      out.write("\n");
      out.write("                        var option2 = document.createElement(\"option\");\n");
      out.write("                        option2.innerHTML = allSize[1] + \" --- \" + allSize[0];\n");
      out.write("                        option2.value = allSize[1] + \" --- \" + allSize[0];\n");
      out.write("                        option2.id = allSize[1] + \" --- \" + allSize[0];\n");
      out.write("\n");
      out.write("                        datalistCE.appendChild(option2);\n");
      out.write("                        datalistUK.appendChild(option1);\n");
      out.write("                    }\n");
      out.write("\n");
      out.write("                }\n");
      out.write("            };\n");
      out.write("            xmlHttp1.open(\"POST\", \"Controller?method=getAllPrimarySize\", true);\n");
      out.write("            xmlHttp1.send();\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        function readEanTable() {\n");
      out.write("\n");
      out.write("            var table = document.getElementById('eanTable').getElementsByTagName('tbody')[0];\n");
      out.write("\n");
      out.write("            var eanDetails = [];\n");
      out.write("\n");
      out.write("            for (var x = 0; x < table.rows.length; x++) {\n");
      out.write("\n");
      out.write("                var eanDetail = {};\n");
      out.write("                var rw = table.rows[x];\n");
      out.write("                var eanDetailNo = rw.cells[0].innerHTML;\n");
      out.write("                var uk_primary_size = rw.cells[1].children[0].value;\n");
      out.write("                var ce_primary_size = rw.cells[2].children[0].value;\n");
      out.write("\n");
      out.write("                eanDetail[\"eanDetailNo\"] = eanDetailNo;\n");
      out.write("                eanDetail[\"uk_primary_size\"] = uk_primary_size;\n");
      out.write("                eanDetail[\"ce_primary_size\"] = ce_primary_size;\n");
      out.write("                eanDetails.push(eanDetail);\n");
      out.write("            }\n");
      out.write("            console.log(eanDetails);\n");
      out.write("            console.log(eanDetails.length);\n");
      out.write("            var data = JSON.stringify(eanDetails);\n");
      out.write("            console.log(data);\n");
      out.write("\n");
      out.write("            var xmlHttp1 = getAjaxObject();\n");
      out.write("\n");
      out.write("            xmlHttp1.onreadystatechange = function ()\n");
      out.write("            {\n");
      out.write("                if (xmlHttp1.readyState === 4 && xmlHttp1.status === 200)\n");
      out.write("                {\n");
      out.write("                    var data1 = eval('(' + xmlHttp1.responseText + ')');\n");
      out.write("                    if (data1 == 1) {\n");
      out.write("                        BootstrapDialog.show({\n");
      out.write("                            title: 'Notification',\n");
      out.write("                            message: 'Success',\n");
      out.write("                            size: BootstrapDialog.SIZE_SMALL,\n");
      out.write("                            closable: true,\n");
      out.write("                            closeByBackdrop: false,\n");
      out.write("                            closeByKeyboard: false,\n");
      out.write("                            buttons: [{\n");
      out.write("                                    label: 'Next',\n");
      out.write("                                    action: function (dialogRef) {\n");
      out.write("                                        dialogRef.close();\n");
      out.write("                                        $(\"#next\").submit();\n");
      out.write("                                    }\n");
      out.write("                                }]\n");
      out.write("                        });\n");
      out.write("\n");
      out.write("                    } else {\n");
      out.write("                        BootstrapDialog.show({\n");
      out.write("                            title: 'Notification',\n");
      out.write("                            message: 'Fail',\n");
      out.write("                            size: BootstrapDialog.SIZE_SMALL,\n");
      out.write("                            title:BootstrapDialog.TYPE_WARNING\n");
      out.write("                        });\n");
      out.write("                    }\n");
      out.write("                }\n");
      out.write("            };\n");
      out.write("            xmlHttp1.open(\"POST\", \"Controller?method=addEanDetails&dataList=\" + data, true);\n");
      out.write("            xmlHttp1.send();\n");
      out.write("        }\n");
      out.write("\n");
      out.write("    </script>\n");
      out.write("\n");
      out.write("    <script type=\"text/javascript\">\n");
      out.write("        $(document).ready(function () {\n");
      out.write("            $('#btn_update_ean').click(function (e) {\n");
      out.write("                var isValid = true;\n");
      out.write("                $('input[name^=uk_siz]').each(function () {\n");
      out.write("                    if ($.trim($(this).val()) == '') {\n");
      out.write("                        isValid = false;\n");
      out.write("                        $(this).css({\n");
      out.write("                            \"border\": \"1px solid red\"\n");
      out.write("//                        \"background\": \"#FFCECE\"\n");
      out.write("                        });\n");
      out.write("                    }\n");
      out.write("                    else {\n");
      out.write("                        $(this).css({\n");
      out.write("                            \"border\": \"\"\n");
      out.write("//                        \"background\": \"\"\n");
      out.write("                        });\n");
      out.write("                    }\n");
      out.write("                });\n");
      out.write("                if (isValid == false) {\n");
      out.write("                    e.preventDefault();\n");
      out.write("                }\n");
      out.write("                else {\n");
      out.write("                    readEanTable();\n");
      out.write("                }\n");
      out.write("            });\n");
      out.write("        });\n");
      out.write("        var tmp = {};\n");
      out.write("        var tmpce = {};\n");
      out.write("        var tmp2 = {};\n");
      out.write("        var tmp2uk = {};\n");
      out.write("\n");
      out.write("        $(document).ready(function () {\n");
      out.write("            $(\"input[name^=uk_siz]\").bind('input', function () {\n");
      out.write("\n");
      out.write("                var uk_id = this.id;\n");
      out.write("                var ce_id = \"ce_siz\" + uk_id.substr(6);\n");
      out.write("                var count = uk_id.substr(6);\n");
      out.write("                var temp = document.getElementById(uk_id).value;\n");
      out.write("                if (temp.length > 0) {\n");
      out.write("                    var sizes = temp.split(\"---\");\n");
      out.write("                    if (typeof (sizes[1]) !== 'undefined') {\n");
      out.write("                        document.getElementById(uk_id).value = sizes[0];\n");
      out.write("                        document.getElementById(ce_id).value = sizes[1];\n");
      out.write("                        tmpce[this.id] = sizes[0];\n");
      out.write("//                        $('html').keyup(function(e){if(e.keyCode == 8)document.getElementById(ce_id).value = \"\"});\n");
      out.write("                        tmp[this.id] = temp;\n");
      out.write("                    }\n");
      out.write("                    $(\"#uk_prim_size option[value='\" + temp + \"']\").attr('disabled', 'disabled');\n");
      out.write("\n");
      out.write("                } else {\n");
      out.write("                    document.getElementById(ce_id).value = \"\";\n");
      out.write("                    $(\"#uk_prim_size option[id='\" + tmp[this.id] + \"']\").removeAttr('disabled');\n");
      out.write("                }\n");
      out.write("                \n");
      out.write("                if (document.getElementById(uk_id).value != tmpce[this.id]) {\n");
      out.write("                    val_update[count] = 0;\n");
      out.write("                    $(\"#btn_update_ean\").attr('disabled', 'disabled');\n");
      out.write("                } else {\n");
      out.write("                    val_update[count] = 1;\n");
      out.write("                    $(\"#btn_update_ean\").removeAttr('disabled');\n");
      out.write("                }\n");
      out.write("\n");
      out.write("                for (i = 0; i < val_update.length; i++) {\n");
      out.write("                    if(val_update[i] < 1){\n");
      out.write("                        $(\"#btn_update_ean\").attr('disabled', 'disabled');\n");
      out.write("                        return;\n");
      out.write("                    }else{\n");
      out.write("                        $(\"#btn_update_ean\").removeAttr('disabled');\n");
      out.write("                    }\n");
      out.write("                }\n");
      out.write("\n");
      out.write("\n");
      out.write("            });\n");
      out.write("\n");
      out.write("            $(\"input[name^=ce_siz]\").bind('input', function () {\n");
      out.write("                var ce_id = this.id;\n");
      out.write("                var uk_id = \"uk_siz\" + ce_id.substr(6);\n");
      out.write("                var count = uk_id.substr(6);\n");
      out.write("                var temp = document.getElementById(ce_id).value;\n");
      out.write("                if (temp.length > 0) {\n");
      out.write("                    var sizes = temp.split(\"---\");\n");
      out.write("                    if (typeof (sizes[1]) !== 'undefined') {\n");
      out.write("                        document.getElementById(uk_id).value = sizes[1];\n");
      out.write("                        document.getElementById(ce_id).value = sizes[0];\n");
      out.write("                        tmp2uk[this.id] = sizes[0];\n");
      out.write("                        tmp2[this.id] = temp;\n");
      out.write("                    }\n");
      out.write("                    $(\"#ce_prim_size option[value='\" + temp + \"']\").attr('disabled', 'disabled');\n");
      out.write("                } else {\n");
      out.write("                    document.getElementById(uk_id).value = \"\";\n");
      out.write("                    $(\"#ce_prim_size option[id='\" + tmp2[this.id] + \"']\").removeAttr('disabled');\n");
      out.write("                }\n");
      out.write("\n");
      out.write("                if (document.getElementById(ce_id).value != tmp2uk[this.id]) {\n");
      out.write("                    val_update[count] = 0;\n");
      out.write("                    $(\"#btn_update_ean\").attr('disabled', 'disabled');\n");
      out.write("                } else {\n");
      out.write("                    val_update[count] = 1;\n");
      out.write("                    $(\"#btn_update_ean\").removeAttr('disabled');\n");
      out.write("                }\n");
      out.write("                for (i = 0; i < val_update.length; i++) {\n");
      out.write("                    if(val_update[i] < 1){\n");
      out.write("                        $(\"#btn_update_ean\").attr('disabled', 'disabled');\n");
      out.write("                        return;\n");
      out.write("                    }else{\n");
      out.write("                        $(\"#btn_update_ean\").removeAttr('disabled');\n");
      out.write("                    }\n");
      out.write("                }\n");
      out.write("                \n");
      out.write("            });\n");
      out.write("        });\n");
      out.write("\n");
      out.write("\n");
      out.write("        $(document).ready(function () {\n");
      out.write("            $('input[name^=uk_siz]').attr(\"readOnly\", true);\n");
      out.write("            $('input[name^=ce_siz]').attr(\"readOnly\", true);\n");
      out.write("            $(\"#menuItem1\").removeClass(\"active\");\n");
      out.write("            $(\"#menuItem2\").removeClass(\"active\");\n");
      out.write("            $(\"#menuItem3\").removeClass(\"active\");\n");
      out.write("            $(\"#menuItem4\").removeClass(\"active\");\n");
      out.write("            $(\"#menuItem5\").removeClass(\"active\");\n");
      out.write("            $(\"#menuItem6\").removeClass(\"active\");\n");
      out.write("            $(\"#menuItem7\").removeClass(\"active\");\n");
      out.write("            $(\"#menuItem3\").addClass(\"active\");\n");
      out.write("        });\n");
      out.write("    </script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<div id=\"footer_div\" >\n");
      out.write("    <div class=\" navbar navbar-blend navbar-fixed-bottom\">\n");
      out.write("        <div class=\"container-fluid\" style=\"padding-top: 20px; color: #c0c0c0; font-size: 12px;\">\n");
      out.write("            <div class=\"col-lg-3 pull-left\">\n");
      out.write("                <script type=\"text/javascript\">\n");
      out.write("                    function googleTranslateElementInit() {\n");
      out.write("                        new google.translate.TranslateElement({pageLanguage: 'en', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');\n");
      out.write("                    }\n");
      out.write("                </script>\n");
      out.write("                <script type=\"text/javascript\" src=\"//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit\"></script>\n");
      out.write("\n");
      out.write("                <p class=\"\">Terms &  Conditions</p>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"col-lg-6 hidden-sm hidden-xs\">\n");
      out.write("                <marquee scrolldelay=\"1\" scrollamount=\"2\">Sri Lanka &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; India &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; United Kingdom &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; China &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Bangladesh &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Cambodia &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Pakistan &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Turkey &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Vietnam &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Hong Kong   </marquee>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"col-lg-3 pull-right\">\n");
      out.write("                <p class=\"pull-right\">Impressions Labels &copy; <span id=\"year\"><em></em></span></p>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("</div>\n");
      out.write("</div>\n");
      out.write("<!-- /#wrapper -->\n");
      out.write("\n");
      out.write("<!-- jQuery -->\n");
      out.write("<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js\"></script>\n");
      out.write("\n");
      out.write("<script src=\"/IEPTescoNew/js/jquery.js\"></script>\n");
      out.write("\n");
      out.write("<script src=\"/IEPTescoNew/js/jquery-ui.js\"></script>\n");
      out.write("\n");
      out.write("<!-- Bootstrap Core JavaScript -->\n");
      out.write("<script src=\"/IEPTescoNew/js/bootstrap.js\"></script>\n");
      out.write("\n");
      out.write("<!-- Nice Scrolling -->\n");
      out.write("<script src=\"/IEPTescoNew/js/jquery.nicescroll.js\"></script>\n");
      out.write("\n");
      out.write("<!-- Ajax Object -->\n");
      out.write("<script src=\"/IEPTescoNew/js/imp.js\"></script>\n");
      out.write("\n");
      out.write("<!-- Bootstrap Dialog Object -->\n");
      out.write("<script src=\"/IEPTescoNew/js/bootstrap-dialog.js\"></script>\n");
      out.write("\n");
      out.write("<script type=\"text/javascript\">\n");
      out.write("                                            function loading() {\n");
      out.write("                                                BootstrapDialog.show({\n");
      out.write("                                                    title: 'Say-hello dialog',\n");
      out.write("                                                    message: 'Hi Apple!'\n");
      out.write("                                                });\n");
      out.write("                                            }\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("    $(document).ready(function () {\n");
      out.write("        function setHeight() {\n");
      out.write("            var windowHeight = $(window).innerHeight() - 70;\n");
      out.write("            $('#page-wrapper').css('min-height', windowHeight);\n");
      out.write("        }\n");
      out.write("        ;\n");
      out.write("        setHeight();\n");
      out.write("\n");
      out.write("        $(window).resize(function () {\n");
      out.write("            setHeight();\n");
      out.write("        });\n");
      out.write("    });\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("    window.onload = function () {\n");
      out.write("        var d = new Date();\n");
      out.write("        var n = d.getFullYear();\n");
      out.write("        var dat = document.getElementById(\"year\");\n");
      out.write("        dat.innerHTML = n;\n");
      out.write("\n");
      out.write("        var nice = $('html').niceScroll({cursorborder: \"\", cursorcolor: \"#A2A2A2\", cursorwidth: \"10px\", boxzoom: true, autohidemode: false});\n");
      out.write("    }\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("\n");
      out.write("</html>\n");
      out.write('\n');
      out.write('\n');
 } else {
        response.sendRedirect("LogoutController");
    }
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_c_forEach_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_forEach_0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _jspx_tagPool_c_forEach_var_items.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_forEach_0.setPageContext(_jspx_page_context);
    _jspx_th_c_forEach_0.setParent(null);
    _jspx_th_c_forEach_0.setItems((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${idQ2.rows}", java.lang.Object.class, (PageContext)_jspx_page_context, null));
    _jspx_th_c_forEach_0.setVar("row2");
    int[] _jspx_push_body_count_c_forEach_0 = new int[] { 0 };
    try {
      int _jspx_eval_c_forEach_0 = _jspx_th_c_forEach_0.doStartTag();
      if (_jspx_eval_c_forEach_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("                ");
          if (_jspx_meth_c_choose_0((javax.servlet.jsp.tagext.JspTag) _jspx_th_c_forEach_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
            return true;
          out.write("\n");
          out.write("            ");
          int evalDoAfterBody = _jspx_th_c_forEach_0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_forEach_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_forEach_0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_forEach_0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_forEach_0.doFinally();
      _jspx_tagPool_c_forEach_var_items.reuse(_jspx_th_c_forEach_0);
    }
    return false;
  }

  private boolean _jspx_meth_c_choose_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:choose
    org.apache.taglibs.standard.tag.common.core.ChooseTag _jspx_th_c_choose_0 = (org.apache.taglibs.standard.tag.common.core.ChooseTag) _jspx_tagPool_c_choose.get(org.apache.taglibs.standard.tag.common.core.ChooseTag.class);
    _jspx_th_c_choose_0.setPageContext(_jspx_page_context);
    _jspx_th_c_choose_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_0);
    int _jspx_eval_c_choose_0 = _jspx_th_c_choose_0.doStartTag();
    if (_jspx_eval_c_choose_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                    ");
        if (_jspx_meth_c_when_0((javax.servlet.jsp.tagext.JspTag) _jspx_th_c_choose_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
          return true;
        out.write("\n");
        out.write("                    ");
        if (_jspx_meth_c_when_1((javax.servlet.jsp.tagext.JspTag) _jspx_th_c_choose_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
          return true;
        out.write("\n");
        out.write("                    ");
        if (_jspx_meth_c_when_2((javax.servlet.jsp.tagext.JspTag) _jspx_th_c_choose_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
          return true;
        out.write("\n");
        out.write("                    ");
        if (_jspx_meth_c_when_3((javax.servlet.jsp.tagext.JspTag) _jspx_th_c_choose_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
          return true;
        out.write("\n");
        out.write("                    ");
        if (_jspx_meth_c_when_4((javax.servlet.jsp.tagext.JspTag) _jspx_th_c_choose_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
          return true;
        out.write("\n");
        out.write("                    ");
        if (_jspx_meth_c_when_5((javax.servlet.jsp.tagext.JspTag) _jspx_th_c_choose_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
          return true;
        out.write("\n");
        out.write("\n");
        out.write("                    ");
        if (_jspx_meth_c_when_6((javax.servlet.jsp.tagext.JspTag) _jspx_th_c_choose_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
          return true;
        out.write("\n");
        out.write("                    ");
        if (_jspx_meth_c_when_7((javax.servlet.jsp.tagext.JspTag) _jspx_th_c_choose_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
          return true;
        out.write("\n");
        out.write("\n");
        out.write("                    ");
        if (_jspx_meth_c_when_8((javax.servlet.jsp.tagext.JspTag) _jspx_th_c_choose_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
          return true;
        out.write("\n");
        out.write("\n");
        out.write("\n");
        out.write("                    ");
        if (_jspx_meth_c_when_9((javax.servlet.jsp.tagext.JspTag) _jspx_th_c_choose_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
          return true;
        out.write("\n");
        out.write("                ");
        int evalDoAfterBody = _jspx_th_c_choose_0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_choose_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_choose.reuse(_jspx_th_c_choose_0);
      return true;
    }
    _jspx_tagPool_c_choose.reuse(_jspx_th_c_choose_0);
    return false;
  }

  private boolean _jspx_meth_c_when_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_choose_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:when
    org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_when_0 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _jspx_tagPool_c_when_test.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
    _jspx_th_c_when_0.setPageContext(_jspx_page_context);
    _jspx_th_c_when_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_choose_0);
    _jspx_th_c_when_0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${row2.menu_item==1 && row2.user_type==3}", java.lang.Boolean.class, (PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_when_0 = _jspx_th_c_when_0.doStartTag();
    if (_jspx_eval_c_when_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                        <li id=\"menuItem2\" class=\"\">\n");
        out.write("                            <a href=\"/IEPTescoNew/addSuperUser.jsp\"><i class=\"fa fa-fw fa-user\"></i> Add User</a>\n");
        out.write("                        </li>\n");
        out.write("                    ");
        int evalDoAfterBody = _jspx_th_c_when_0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_when_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_0);
      return true;
    }
    _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_0);
    return false;
  }

  private boolean _jspx_meth_c_when_1(javax.servlet.jsp.tagext.JspTag _jspx_th_c_choose_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:when
    org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_when_1 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _jspx_tagPool_c_when_test.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
    _jspx_th_c_when_1.setPageContext(_jspx_page_context);
    _jspx_th_c_when_1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_choose_0);
    _jspx_th_c_when_1.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${row2.menu_item==2 && row2.user_type<=3}", java.lang.Boolean.class, (PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_when_1 = _jspx_th_c_when_1.doStartTag();
    if (_jspx_eval_c_when_1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                        <li id=\"menuItem3\" class=\"\">\n");
        out.write("                            <a href=\"/IEPTescoNew/Extract/pdfExtracter.jsp\"><i class=\"fa fa-fw fa-hand-o-right\"></i> Place The Order</a>\n");
        out.write("                        </li>                        \n");
        out.write("                        <li id=\"menuItem3\" class=\"\">\n");
        out.write("                            <a href=\"/IEPTescoNew/techTeam.jsp\"><i class=\"fa fa-fw fa-hand-o-right\"></i> Tech Team</a>\n");
        out.write("                        </li>                        \n");
        out.write("                    ");
        int evalDoAfterBody = _jspx_th_c_when_1.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_when_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_1);
      return true;
    }
    _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_1);
    return false;
  }

  private boolean _jspx_meth_c_when_2(javax.servlet.jsp.tagext.JspTag _jspx_th_c_choose_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:when
    org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_when_2 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _jspx_tagPool_c_when_test.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
    _jspx_th_c_when_2.setPageContext(_jspx_page_context);
    _jspx_th_c_when_2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_choose_0);
    _jspx_th_c_when_2.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${row2.menu_item==3 && row2.user_type<=3}", java.lang.Boolean.class, (PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_when_2 = _jspx_th_c_when_2.doStartTag();
    if (_jspx_eval_c_when_2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                        <li id=\"menuItem5\" class=\"\">\n");
        out.write("                            <a href=\"/IEPTescoNew/requestArtwork.jsp\"><i class=\"fa fa-fw fa-gavel\"></i>Request Artwork</a>\n");
        out.write("                        </li>\n");
        out.write("                    ");
        int evalDoAfterBody = _jspx_th_c_when_2.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_when_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_2);
      return true;
    }
    _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_2);
    return false;
  }

  private boolean _jspx_meth_c_when_3(javax.servlet.jsp.tagext.JspTag _jspx_th_c_choose_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:when
    org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_when_3 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _jspx_tagPool_c_when_test.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
    _jspx_th_c_when_3.setPageContext(_jspx_page_context);
    _jspx_th_c_when_3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_choose_0);
    _jspx_th_c_when_3.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${row2.menu_item==4 && row2.user_type<=3}", java.lang.Boolean.class, (PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_when_3 = _jspx_th_c_when_3.doStartTag();
    if (_jspx_eval_c_when_3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                        <li id=\"menuItem12\" class=\"\">\n");
        out.write("                            <a href=\"/IEPTescoNew/copy_forgot.jsp\"><i class=\"fa fa-fw fa-gavel\"></i> Confirm Order</a>\n");
        out.write("                        </li>\n");
        out.write("                    ");
        int evalDoAfterBody = _jspx_th_c_when_3.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_when_3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_3);
      return true;
    }
    _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_3);
    return false;
  }

  private boolean _jspx_meth_c_when_4(javax.servlet.jsp.tagext.JspTag _jspx_th_c_choose_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:when
    org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_when_4 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _jspx_tagPool_c_when_test.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
    _jspx_th_c_when_4.setPageContext(_jspx_page_context);
    _jspx_th_c_when_4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_choose_0);
    _jspx_th_c_when_4.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${row2.menu_item==5 && (row2.user_type<=3)}", java.lang.Boolean.class, (PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_when_4 = _jspx_th_c_when_4.doStartTag();
    if (_jspx_eval_c_when_4 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                        <li id=\"menuItem4\" class=\"\">\n");
        out.write("                            <a href=\"/IEPTescoNew/orderTracking.jsp\"><i class=\"fa fa-fw fa-map-marker\"></i> Order Tracking</a>\n");
        out.write("                        </li>\n");
        out.write("                    ");
        int evalDoAfterBody = _jspx_th_c_when_4.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_when_4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_4);
      return true;
    }
    _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_4);
    return false;
  }

  private boolean _jspx_meth_c_when_5(javax.servlet.jsp.tagext.JspTag _jspx_th_c_choose_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:when
    org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_when_5 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _jspx_tagPool_c_when_test.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
    _jspx_th_c_when_5.setPageContext(_jspx_page_context);
    _jspx_th_c_when_5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_choose_0);
    _jspx_th_c_when_5.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${row2.menu_item==12 && row2.user_type == 5}", java.lang.Boolean.class, (PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_when_5 = _jspx_th_c_when_5.doStartTag();
    if (_jspx_eval_c_when_5 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                        <li id=\"menuItem12\" class=\"\">\n");
        out.write("                            <a href=\"/IEPTescoNew/cs_orderTracking.jsp\"><i class=\"fa fa-fw fa-map-marker\"></i> Order Tracking</a>\n");
        out.write("                        </li>\n");
        out.write("\n");
        out.write("                        <li id=\"menuItem13\" class=\"\">\n");
        out.write("                            <a href=\"/IEPTescoNew/orderstatuschange.jsp\"><i class=\"fa fa-fw fa-map-marker\"></i>Order Canceling</a>\n");
        out.write("                        </li>\n");
        out.write("                    ");
        int evalDoAfterBody = _jspx_th_c_when_5.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_when_5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_5);
      return true;
    }
    _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_5);
    return false;
  }

  private boolean _jspx_meth_c_when_6(javax.servlet.jsp.tagext.JspTag _jspx_th_c_choose_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:when
    org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_when_6 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _jspx_tagPool_c_when_test.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
    _jspx_th_c_when_6.setPageContext(_jspx_page_context);
    _jspx_th_c_when_6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_choose_0);
    _jspx_th_c_when_6.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${row2.menu_item==9 && row2.user_type>=3 && row2.user_type<6}", java.lang.Boolean.class, (PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_when_6 = _jspx_th_c_when_6.doStartTag();
    if (_jspx_eval_c_when_6 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                        <li id=\"menuItem10\" class=\"\">\n");
        out.write("                            <a href=\"/IEPTescoNew/artWorkUpload.jsp\"><i class=\"fa fa-fw fa-group\"></i> Upload Artwork</a>\n");
        out.write("                        </li>\n");
        out.write("                    ");
        int evalDoAfterBody = _jspx_th_c_when_6.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_when_6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_6);
      return true;
    }
    _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_6);
    return false;
  }

  private boolean _jspx_meth_c_when_7(javax.servlet.jsp.tagext.JspTag _jspx_th_c_choose_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:when
    org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_when_7 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _jspx_tagPool_c_when_test.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
    _jspx_th_c_when_7.setPageContext(_jspx_page_context);
    _jspx_th_c_when_7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_choose_0);
    _jspx_th_c_when_7.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${row2.menu_item==8 && row2.user_type==3}", java.lang.Boolean.class, (PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_when_7 = _jspx_th_c_when_7.doStartTag();
    if (_jspx_eval_c_when_7 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                        <li id=\"menuItem6\" class=\"\">\n");
        out.write("                            <a href=\"/IEPTescoNew/registerGarment.jsp\"><i class=\"fa fa-fw fa-group\"></i> Register Garment \n");
        out.write("\n");
        out.write("                            </a>\n");
        out.write("                        </li>\n");
        out.write("                    ");
        int evalDoAfterBody = _jspx_th_c_when_7.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_when_7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_7);
      return true;
    }
    _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_7);
    return false;
  }

  private boolean _jspx_meth_c_when_8(javax.servlet.jsp.tagext.JspTag _jspx_th_c_choose_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:when
    org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_when_8 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _jspx_tagPool_c_when_test.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
    _jspx_th_c_when_8.setPageContext(_jspx_page_context);
    _jspx_th_c_when_8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_choose_0);
    _jspx_th_c_when_8.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${row2.menu_item==7 && row2.user_type>=3}", java.lang.Boolean.class, (PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_when_8 = _jspx_th_c_when_8.doStartTag();
    if (_jspx_eval_c_when_8 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                        <li id=\"menuItem8\" class=\"\">\n");
        out.write("                            <a href=\"/IEPTescoNew/contentUp.jsp\"><i class=\"fa fa-fw fa-group\"></i> Content Updating</a>\n");
        out.write("                        </li>\n");
        out.write("                    ");
        int evalDoAfterBody = _jspx_th_c_when_8.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_when_8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_8);
      return true;
    }
    _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_8);
    return false;
  }

  private boolean _jspx_meth_c_when_9(javax.servlet.jsp.tagext.JspTag _jspx_th_c_choose_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:when
    org.apache.taglibs.standard.tag.rt.core.WhenTag _jspx_th_c_when_9 = (org.apache.taglibs.standard.tag.rt.core.WhenTag) _jspx_tagPool_c_when_test.get(org.apache.taglibs.standard.tag.rt.core.WhenTag.class);
    _jspx_th_c_when_9.setPageContext(_jspx_page_context);
    _jspx_th_c_when_9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_choose_0);
    _jspx_th_c_when_9.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${row2.menu_item==6}", java.lang.Boolean.class, (PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_when_9 = _jspx_th_c_when_9.doStartTag();
    if (_jspx_eval_c_when_9 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                        <li id=\"menuItem7\" class=\"\">\n");
        out.write("                            <a href=\"/IEPTescoNew/Users/givePermission.jsp\"><i class=\"fa fa-fw fa-group\"></i> User Permission Control</a>\n");
        out.write("                        </li>\n");
        out.write("                    ");
        int evalDoAfterBody = _jspx_th_c_when_9.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_when_9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_9);
      return true;
    }
    _jspx_tagPool_c_when_test.reuse(_jspx_th_c_when_9);
    return false;
  }
}
