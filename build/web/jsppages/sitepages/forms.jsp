<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>


<%!    int cp = 0;
    String userrole;
    int t;
%>
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <head> <title>Noida Jal Board : Forms</title></head>
    <jsp:include page="../common/header.jsp"/>
    <body>
        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");
                    String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                    String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");


        %>
        <!-- Menu Starts -->
        <jsp:include page="../common/navigation.jsp"/>
        <!-- Menu Ends -->
        <div id="helper">
            <div class="inside">
                <div class="container">
                    <div class="bgr">
                    </div> <!-- #helper .leftcorners -->
                </div> <!-- #helper .container -->
            </div> <!-- #helper .inside -->
        </div> <!-- #helper -->



        <div id="breadcrumbs">
            <div class="inside">
                <div class="container">
                    <div id="breadcrumb">

                        <div class="youarehere">
                            <div class="leftcorners">
                                <div class="rightarrow">
                                    <div class="bg">
                                        You are here:
                                    </div> <!-- #breadcrums .bg -->
                                </div> <!-- #breadcrums .rightarrow -->
                            </div> <!-- #breadcrums .leftcorners -->
                        </div> <!-- #breadcrums .youarehere -->

                        <div class="inactive">
                            <a href="../../index.jsp" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Home
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                        <div class="active">
                            <a href="#" title="Forms">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Forms
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                    </div> <!-- #breadcrums .breadcrumb -->
                </div> <!-- #breadcrums .container -->
            </div> <!-- #breadcrums .inside -->
        </div> <!-- #breadcrums -->


        <div id="content">
            <div class="inside">
                <div class="container">
                    <div id="contentrail" class="full">

                        <div id="news">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <h2>Connection Forms</h2>
                                        </div> <!-- #news .bg -->
                                    </div> <!-- #news .rightcorners -->
                                </div> <!-- #news .leftcorners -->
                            </div> <!-- #news .heading -->
                            <div class="content">
                                <div class="insider">

                                    <div class="article">
                                        <h3>Application Form For Water Connection</h3>
                                        <p class="full">Click on download button to download Applicatin Form for Water Connection.</p>
                                        <img src="../../resources/images/forms_1.png" alt="Form" class="center"/>

                                        <!--                                        <div class="infobar dot">
                                                                                   <a href="../../resources/uploadimg/download.pdf">Download Link</a>
                                                                                </div>-->
                                        <div class="infobar dot">
                                            <div class="button form">
                                                <a href="../../resources/forms/form.doc"  title="Click to Download"  >
                                                    <span class="btleftcorners1">
                                                        <span class="btrightcorners1">
                                                            <span class="btbg1">
                                                                Download

                                                            </span>
                                                        </span>
                                                    </span>
                                                </a>
                                            </div>
                                        </div>
                                        <br class="clear" />
                                        <br class="clear" />
                                    </div>

                                    <div class="article">
                                        <h3>Application Form For Sewer Connection</h3>
                                        <p class="full">Click on download button to download Applicatin Form for Sewer Connection.</p>
                                        <img src="../../resources/images/forms_1.png" alt="Form" class="center"/>


                                        <div class="infobar dot">
                                            <div class="button form">
                                                <a href="../../resources/forms/form.doc "  title="Click to Download">
                                                    <span class="btleftcorners1">
                                                        <span class="btrightcorners1">
                                                            <span class="btbg1">
                                                                Download
                                                            </span>
                                                        </span>
                                                    </span>
                                                </a>
                                            </div> <!-- #news .button -->
                                        </div>
                                        <br class="clear" />
                                    </div> <!-- #news .article -->
                                    <div class="article">
                                        <h3>Application Form For Transfer of Connection</h3>
                                        <p class="full">Click on download button to download Applicatin Form for Transfer of Connection.</p>
                                        <img src="../../resources/images/forms_1.png" alt="Form" class="center"  />


                                        <div class="infobar dot">
                                            <div class="button form">
                                                <a href="../../resources/forms/form.doc"  title="Click to Download">
                                                    <span class="btleftcorners1">
                                                        <span class="btrightcorners1">
                                                            <span class="btbg1">
                                                                Download
                                                            </span>
                                                        </span>
                                                    </span>
                                                </a>
                                            </div> <!-- #news .button -->
                                        </div>
                                    </div> <!-- #news .article -->

                                </div>  <!-- #news .insider -->
                            </div> <!-- #news .content -->
                        </div>


                    </div> <!-- #centerrail -->


                </div> <!-- #content .inside .container -->
            </div> <!-- #content .inside -->
            <br class="clear" />
        </div> <!-- #content -->

        <jsp:include page="../common/footer.jsp"/>

    </body>
</html>























