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
    <head> <title>Noida Jal Board : Report</title></head>
    <jsp:include page="../common/header.jsp"/>

    <script  type="text/javascript" src="../../resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="../../resources/jquery/jquery.validate.js"></script>
    <script type="text/javascript" src="../../resources/jquery/jquery.maskedinput-1.2.2.js"></script>
    <script type='text/javascript' src='../../resources/jquery/jquery.simplemodal.js'></script>
    <script type='text/javascript' src='../../resources/jquery/basic.js'></script>

    <script  type="text/javascript">
        $(document).ready(function(){

            $("#billdate").mask("99/99/99");
            $("#reportform").validate();
            $("#form1").validate();
        });



        function callGetReport()
        {
            i=0;

            sec= document.getElementById("sec").value
            dt_mon= document.getElementById("dt_mon").value
            dt_yr= document.getElementById("dt_yr").value
            document.forms[1].sec.value=sec;
            document.forms[1].dt_mon.value=dt_mon;
            document.forms[1].dt_yr.value=dt_yr;
            xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }
            var url="/OnlineJal_Example/BillReport"
            url=url+"?&sec="+sec+"&dt_mon="+dt_mon+"&dt_yr="+dt_yr
            xmlHttp.open("GET",url,true)
            xmlHttp.send(null)

            xmlHttp.onreadystatechange=function()
            {
                sec=null;
                path=null;

                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {

                    var showdata = xmlHttp.responseText;
                    str=showdata.split(":");
                    sec=str[0];
                    path=str[1];
                                      

                    if(sec!=null&&path!=null)
                    {
                        document.getElementById("pdf").style.visibility="visible";
                        document.getElementById("processing").style.visibility="hidden";
                        i=1;
                    }
                    if(i!=1)
                        setTimeout("callGetReport()", 5000);
                }else
                {
                    document.getElementById("processing").style.visibility="visible";
                    document.getElementById("pdf").style.visibility="hidden";

                }

            }

        }


        function GetXmlHttpObject()
        {
            var xmlHttp=null;
            try
            {
                // Firefox, Opera 8.0+, Safari
                xmlHttp=new XMLHttpRequest();
            }
            catch (e)
            {
                //Internet Explorer
                try
                {
                    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e)
                {
                    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
            }
            return xmlHttp;
        }
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
                                            Bill Amount Report
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

                            <h2>Bill Amount Report</h2>

                            <div class="content">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <div class="insider">

                                                <form id="reportform" action="/OnlineJal_Example/BillReport" >
                                                    <fieldset>
                                                        <ul>
                                                            <li><table>

                                                                    <tr> <div class="inputbox">
                                                                            <td><label  for="sec">Sector<span class="required">*</span></label></td>
                                                                            <td>  <select name="sec" id="sec" class="required">
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




                                                                    <tr><td colspan="2"><p class="required">* Required Fields</p></td></tr>


                                                                    <tr><td> <div class="buttons">

                                                                                <button class="submit" type="submit" value="Submit">
                                                                                    <span class="leftcorners">
                                                                                        <span class="rightcorners">
                                                                                            <span class="bg">
                                    			Submit
                                                                                            </span>
                                                                                        </span>
                                                                                    </span>
                                                                                </button>

                                                                                <br class="clear" />
                                                                            </div>
                                                                        </td>
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

                                                                            </div>
                                                                        </td>
                                                                    </tr>

                                                                </table>
                                                            </li>
                                                        </ul>
                                                    </fieldset>
                                                </form>
                                                <br class="clear" />

                                            </div> <!-- #news .article -->
                                        </div>  <!-- #news .insider -->
                                    </div> <!-- #news .bg -->
                                </div> <!-- #news .rightcorners -->
                            </div> <!-- #news .leftcorners -->
                        </div> <!-- #news .content -->
                    </div> <!-- #news -->



                    <div id="right">
                        <div id="contentrail" class="half" >


                            <h2>Arrear Report</h2>

                            <div class="content">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <div class="insider">

                                                <div id="reportform">
                                                    <form id="form1" action="/OnlineJal_Example/ArrearReport">
                                                        <fieldset>
                                                            <ul>
                                                                <li><table>
                                                                        <tr>
                                                                            <div class="inputbox">
                                                                                <td><label  for="sec">Sector<span class="required">*</span></label></td>
                                                                                <td>  <select name="sec" id="sec" class="required">
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

                                                </div>

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

