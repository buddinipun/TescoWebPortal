<%-- 
    Document   : footer
    Created on : Jul 5, 2015, 7:10:28 AM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="footer_div" >
    <div class=" navbar navbar-blend navbar-fixed-bottom">
        <div class="container-fluid" style="padding-top: 20px; color: #c0c0c0; font-size: 12px;">
            <div class="col-lg-3 pull-left">
                <script type="text/javascript">
                    function googleTranslateElementInit() {
                        new google.translate.TranslateElement({pageLanguage: 'en', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
                    }
                </script>
                <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

                <p class="">Terms &  Conditions</p>
            </div>
            <div class="col-lg-6 hidden-sm hidden-xs">
                <marquee scrolldelay="1" scrollamount="2">Sri Lanka &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; India &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; United Kingdom &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; China &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Bangladesh &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Cambodia &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Pakistan &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Turkey &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Vietnam &nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp; Hong Kong   </marquee>
            </div>
            <div class="col-lg-3 pull-right">
                <p class="pull-right">Impressions Labels &copy; <span id="year"><em></em></span></p>
            </div>
        </div>
    </div>
</div>
</div>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js"></script>

<script src="/IEPTescoNew/js/jquery.js"></script>

<script src="/IEPTescoNew/js/jquery-ui.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/IEPTescoNew/js/bootstrap.js"></script>

<!-- Nice Scrolling -->
<script src="/IEPTescoNew/js/jquery.nicescroll.js"></script>

<!-- Ajax Object -->
<script src="/IEPTescoNew/js/imp.js"></script>

<!-- Bootstrap Dialog Object -->
<script src="/IEPTescoNew/js/bootstrap-dialog.js"></script>

<script type="text/javascript">
                                            function loading() {
                                                BootstrapDialog.show({
                                                    title: 'Say-hello dialog',
                                                    message: 'Hi Apple!'
                                                });
                                            }
</script>

<script>
    $(document).ready(function () {
        function setHeight() {
            var windowHeight = $(window).innerHeight() - 70;
            $('#page-wrapper').css('min-height', windowHeight);
        }
        ;
        setHeight();

        $(window).resize(function () {
            setHeight();
        });
    });
</script>

<script>
    window.onload = function () {
        var d = new Date();
        var n = d.getFullYear();
        var dat = document.getElementById("year");
        dat.innerHTML = n;

        var nice = $('html').niceScroll({cursorborder: "", cursorcolor: "#A2A2A2", cursorwidth: "10px", boxzoom: true, autohidemode: false});
    }
</script>

</body>

</html>
