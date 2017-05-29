<%-- 
    Document   : forbidden_page
    Created on : May 19, 2015, 11:17:30 PM
    Author     : User
--%>

<%@include file="include/header.jsp"%>

<script type="text/javascript">
    document.title = "Forbidden | E-Platform"
</script>

<div id="content"> 
    <br/>
    <br/>
    <br/>

    <div class="col-lg-4 col-lg-offset-4 col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 col-xs-8 col-xs-offset-2" style="overflow-y: auto; ">
        <span>
            <img class="img-responsive" src="img/image10.png" alt="Page not Found." />
        </span>
        <div style="width:100%; margin-top: 50px;">
            <form name="backtoadmin" action="index.jsp">
                <input class="btn btn-lg btn-info" type="submit" value="Back to Home" style="width: 100%;"/>
            </form>
        </div>
    </div>
</div>

<%@include file="include/footer.jsp"%>

