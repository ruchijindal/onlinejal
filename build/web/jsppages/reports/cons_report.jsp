<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
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
    String errormsg = "";
    int t;
    ArrayList<String> sectorList = new ArrayList<String>();
    ArrayList<Integer> sectorListnum = new ArrayList<Integer>();
    ArrayList<String> sectorListChar=new ArrayList<String>();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head> <title>Noida Jal Board : Consumer Report</title></head>
    <jsp:include page="../common/header.jsp"/>

    <script  type="text/javascript">
        $(document).ready(function(){

                
            $("#reportform").validate();
        });

        function validate()
        {

            var dd = document.getElementById("sec").selectedIndex;

            if(dd==0)
            {
                errormsg="*Select Sector";
                document.getElementById("err").innerHTML=  errormsg;

                return false;
            }


            else
            {
                errormsg="";
                document.getElementById("err").innerHTML=  errormsg;
                return true;

            }
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
                                            Connection Report
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



                        <h2>Consumer Connection Report</h2>



                        <form id="reportform" action="<%= request.getContextPath()%>/ConsumerDet" >
                            <fieldset>
                                <ul>
                                    <li><table><tbody>
                                                <!--tr>
                                                    <div class="inputbox">
                                             <td><label  for="password">Sector</label></td>
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
                                                </select></td>
                                                                     </div></tr>

                                                                      <tr><td colspan="2"><p class="required">* Required Fields</p></td></tr-->
                                                <tr><td>
                                                        <h4>Click Here to Generate Consumer Connection Report of all divisions.</h4></td></tr>
                                                <tr>
                                                    <td><div class="buttons">

                                                            <button class="submit a" type="submit" value="Submit">
                                                                <span class="leftcorners">
                                                                    <span class="rightcorners">
                                                                        <span class="bg">
                                    			Generate Report
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </button>
                                                            <br class="clear" />
                                                        </div></td>
                                                </tr></tbody>
                                        </table>
                                        <br class="clear" />

                                    </li>
                                </ul>
                            </fieldset>


                        </form>



                    </div> <!-- #news -->




                    <div id="report">
                        <div id="contentrail" class="half" >


                            <h2>View Consumer Connection Report</h2>



                            <form id="reportform" action="<%= request.getContextPath()%>/ViewConsumerDetReport" method="post" onSubmit="return validate()">
                                <fieldset>
                                    <ul>
                                        <li><table><tbody>


                                                    <tr>

                                                        <td><label  for="sec">Sector<span class="required">*</span></label></td>
                                                        <td>  <select name="sec" id="sec" class="required"   >
                                                                <option value="" selected>select</option>
                                                                <%
                                                                            try {

                                                                                                                    DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
                                                                                                                    DocumentBuilder db = dbf.newDocumentBuilder();

                                                                                                                    xmlpath = this.getServletContext().getRealPath("") + "/resources/jalutilXML/" + "jal.xml";  // get path on the server
                                                                                                                    Document doc = db.parse(xmlpath);

                                                                                                                    NodeList nl1 = doc.getElementsByTagName("sector");
                                                                                                                    len = nl1.getLength();
                                                                                                                    sectorList.clear();
                                                                                                                    sectorListnum.clear();
                                                                                                                    sectorListChar.clear();
                                                                                                                    String sectorNO;
                                                                                                                    for (int i = 0; i < len; i++) {
                                                                                                                        sectorNO = nl1.item(i).getFirstChild().getNodeValue();
                                                                                                                      if ((sectorNO.charAt(0) >= 'A' && sectorNO.charAt(0) <= 'Z') || (sectorNO.charAt(0) >= 'a' && sectorNO.charAt(0) <= 'z')) {
                                                                                                                          sectorListChar.add(sectorNO);
                                                                                                                      }
                                                                                                                        else{

                                                                                                                        if (sectorNO.length() > 2) {
                                                                                                                            char[] chrArray = sectorNO.toCharArray();
                                                                                                                            boolean flag = false;

                                                                                                                            for (int j = 0; j < chrArray.length; j++) {
                                                                                                                                if ((chrArray[j] >= 'A' && chrArray[j] <= 'Z') || (chrArray[j] >= 'a' && chrArray[j] <= 'z')) {
                                                                                                                                    flag = true;
                                                                                                                                    break;
                                                                                                                                }
                                                                                                                            }
                                                                                                                            if (flag == true) {
                                                                                                                                sectorList.add(sectorNO);

                                                                                                                            } else {
                                                                                                                                sectorListnum.add(Integer.parseInt(sectorNO));

                                                                                                                            }
                                                                                                                        } else {
                                                                                                                            sectorList.add(sectorNO);
                                                                                                                        }
                                                                                                                        }

                                                                                                                    }
                                                                                                                    Collections.sort(sectorList);
                                                                                                                    Collections.sort(sectorListnum);
                                                                                                                    Collections.sort(sectorListChar);

                                                                                                                    for (int i = 0; i < sectorList.size(); i++) {

                                                                    %>
                                                                    <option value="<%= sectorList.get(i)%>"><%= sectorList.get(i)%></option>
                                                                    <%
                                                                                                                                                                                        }
                                                                                                                                                                                        for (int i = 0; i < sectorListnum.size(); i++) {

                                                                    %>
                                                                    <option value="<%= sectorListnum.get(i)%>"><%= sectorListnum.get(i)%></option>
                                                                    <%
                                                                                                                    }
                                                                                                                     for (int i = 0; i < sectorListChar.size(); i++) {

                                                                    %>
                                                                    <option value="<%= sectorListChar.get(i)%>"><%= sectorListChar.get(i)%></option>
                                                                    <%
                                                                                                                    }
                                                                                                                } catch (Exception ex) {
                                                                                                                    System.out.println(ex);
                                                                                                                }
                                                                %>
                                                            </select>

                                                        </td>
                                                        <td class="errorcolor" id="error1"><label id="err"  ><%=errormsg%></label></td>
                                                    </tr>


                                                    <tr><td colspan="2"><p class="required">* Required Fields</p></td></tr>
                                                    <tr>
                                                        <td></td><td><div class="buttons">

                                                                <button class="submit " type="submit" value="Submit">
                                                                    <span class="leftcorners">
                                                                        <span class="rightcorners">
                                                                            <span class="bg">
                                    			Submit
                                                                            </span>
                                                                        </span>
                                                                    </span>
                                                                </button>

                                                             

                                                                <button class="submit" type="reset" value="Reset">
                                                                    <span class="leftcorners">
                                                                        <span class="rightcorners">
                                                                            <span class="bg">
                                    		Reset
                                                                            </span>
                                                                        </span>
                                                                    </span>
                                                                </button>

                                                            </div></td></tr></tbody>
                                            </table>


                                        </li>
                                    </ul>
                                </fieldset>


                            </form>



                        </div> <!-- #rightrail -->
                    </div> <!-- #centerrail -->

                </div>
            </div>
        </div>


        <jsp:include page="../common/footer.jsp"/>

    </body>
</html>

