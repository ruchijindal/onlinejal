<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%@page  language="java" import="javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" %>
<%!    int len;
    String xmlpath;
    String userrole;
    int t;

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head> <title>Noida Jal Board :Creditor</title></head>
    <jsp:include page="../common/header.jsp"/>
    <script type="text/javascript" src="../../resources/jquery/jquery.maskedinput-1.2.2.js"></script>
    <script  type="text/javascript">
        $(document).ready(function(){

            $("#billdate").mask("99/99/99");
            $("#billdate1").mask("99/99/99");
            $("#form3").validate();
        });
    </script>

    <body>
        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");

        %>
        <jsp:include page="../common/navigation.jsp"/>

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
                            <a href="../admin/admin.jsp" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Admin
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                        <div class="active">
                            <a href="#" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Defaulters/Creditors Report
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->



                    </div> <!-- #breadcrums .breadcrumb -->
                </div> <!-- #breadcrums .container -->
            </div> <!-- #breadcrums .inside -->
        </div> <!-- #breadcrums -->



        <!-- Container Starts -->
        <div id="content">
            <div class="inside">
                <div class="container">
                    <div id="contentrail" class="half">

                        <div id="news" >

                            <h2>Defaulters Report</h2>

                            <div class="content">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <div class="insider">

                                                <form id="reportform" action="/OnlineJal_Example/DefaulterGen" >
                                                    <fieldset>
                                                        <ul>
                                                            <li><table>
                                                                    <tr>
                                                                        <div class="inputbox">
                                                                            <td><label  for="sec">Sector</label></td>
                                                                            <td> <select name="sec" id="sec" class="required">
                                                                                    <option value="" selected>select</option>
                                                                                    <%
                                                                                                try {

                                                                                                    DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
                                                                                                    DocumentBuilder db = dbf.newDocumentBuilder();

                                                                                                    xmlpath = this.getServletContext().getRealPath("") + "/resources/jalutilXML/" + "jal.xml";  // get path on the server
                                                                                                    Document doc = db.parse(xmlpath);

                                                                                                    NodeList nl1 = doc.getElementsByTagName("sector");
                                                                                                    len = nl1.getLength();


                                                                                                    for (int i = 0; i < len; i++) {

                                                                                                        NodeList n1 = doc.getElementsByTagName("sector");
                                                                                    %>
                                                                                    <option value="<%= n1.item(i).getFirstChild().getNodeValue()%>"><%= n1.item(i).getFirstChild().getNodeValue()%></option>
                                                                                    <%
                                                                                                    }
                                                                                                } catch (Exception ex) {
                                                                                                    System.out.println(ex);
                                                                                                }
                                                                                    %>
                                                                                </select>
                                                                            </td>
                                                                        </div></tr>
                                                                    <tr>
                                                                        <div class="inputbox">
                                                                            <td><label  for="billdate">Date <span class="required">*</span></label></td>
                                                                            <td><input name="billdate" id="billdate" type="text" /></td>
                                                                        </div></tr>
                                                                    <tr><td colspan="2"><p class="required">* Required Fields</p></td></tr>
                                                                    <tr>
                                                                        <td><div class="buttons">

                                                                                <button class="submit " type="submit" value="Submit">
                                                                                    <span class="leftcorners">
                                                                                        <span class="rightcorners">
                                                                                            <span class="bg">
                                    			Submit
                                                                                            </span>
                                                                                        </span>
                                                                                    </span>
                                                                                </button>
                                                                                <br class="clear" />
                                                                            </div></td>

                                                                        <td><div class="buttons">

                                                                                <button class="submit" type="reset" value="Reset">
                                                                                    <span class="leftcorners">
                                                                                        <span class="rightcorners">
                                                                                            <span class="bg">
                                    		Reset
                                                                                            </span>
                                                                                        </span>
                                                                                    </span>
                                                                                </button>

                                                                            </div></td></tr>
                                                                </table>
                                                                <br class="clear" />

                                                            </li>
                                                        </ul>
                                                    </fieldset>


                                                </form>

                                            </div> <!-- #news .article -->
                                        </div>  <!-- #news .insider -->
                                    </div> <!-- #news .bg -->
                                </div> <!-- #news .rightcorners -->
                            </div> <!-- #news .leftcorners -->
                        </div> <!-- #news .content -->
                    </div> <!-- #news -->



                    <div id="right">
                        <div id="contentrail" class="half" >


                            <h2>Creditors Report</h2>

                            <div class="content">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <div class="insider">

                                                <form id="reportform" action="/OnlineJal_Example/CreditorGen" >
                                                    <fieldset>
                                                        <ul>
                                                            <li><table>
                                                                    <tr>
                                                                        <div class="inputbox">
                                                                            <td><label  for="sec">Sector</label></td>
                                                                            <td> <select name="sec" id="sec" class="required">
                                                                                    <option value="" selected>select</option>
                                                                                    <%
                                                                                                try {

                                                                                                    DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
                                                                                                    DocumentBuilder db = dbf.newDocumentBuilder();

                                                                                                    xmlpath = this.getServletContext().getRealPath("") + "/resources/jalutilXML/" + "jal.xml";  // get path on the server
                                                                                                    Document doc = db.parse(xmlpath);

                                                                                                    NodeList nl1 = doc.getElementsByTagName("sector");
                                                                                                    len = nl1.getLength();


                                                                                                    for (int i = 0; i < len; i++) {

                                                                                                        NodeList n1 = doc.getElementsByTagName("sector");
                                                                                    %>
                                                                                    <option value="<%= n1.item(i).getFirstChild().getNodeValue()%>"><%= n1.item(i).getFirstChild().getNodeValue()%></option>
                                                                                    <%
                                                                                                    }
                                                                                                } catch (Exception ex) {
                                                                                                    System.out.println(ex);
                                                                                                }
                                                                                    %>
                                                                                </select>
                                                                            </td>
                                                                        </div></tr>
                                                                    <tr>
                                                                        <div class="inputbox">
                                                                            <td><label  for="billdate">Date <span class="required">*</span></label></td>
                                                                            <td><input name="billdate" id="billdate1" type="text" /></td>
                                                                        </div></tr>
                                                                    <tr><td colspan="2"><p class="required">* Required Fields</p></td></tr>
                                                                    <tr>
                                                                        <td><div class="buttons">

                                                                                <button class="submit " type="submit" value="Submit">
                                                                                    <span class="leftcorners">
                                                                                        <span class="rightcorners">
                                                                                            <span class="bg">
                                    			Submit
                                                                                            </span>
                                                                                        </span>
                                                                                    </span>
                                                                                </button>
                                                                                <br class="clear" />
                                                                            </div></td>

                                                                        <td><div class="buttons">

                                                                                <button class="submit" type="reset" value="Reset">
                                                                                    <span class="leftcorners">
                                                                                        <span class="rightcorners">
                                                                                            <span class="bg">
                                    		Reset
                                                                                            </span>
                                                                                        </span>
                                                                                    </span>
                                                                                </button>

                                                                            </div></td></tr>
                                                                </table>
                                                                <br class="clear" />

                                                            </li>
                                                        </ul>
                                                    </fieldset>


                                                </form>

                                            </div> <!-- #news .article -->
                                        </div>  <!-- #news .insider -->
                                    </div> <!-- #news .bg -->
                                </div> <!-- #news .rightcorners -->
                            </div> <!-- #news .leftcorners -->

                        </div> <!-- #rightrail -->
                    </div> <!-- #centerrail -->
                </div>
            </div>
        </div>


        <jsp:include page="../common/footer.jsp"/>

    </body>
</html>

