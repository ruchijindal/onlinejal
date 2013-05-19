
<%@page import="java.util.ArrayList"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%!    int msg = 0;
    String userrole;
    int t;
    String con_id;
    String sql;
    String id;
    String content;
    String content_type;
    String con_title;
    String con_date;
    String userid;
    String description;
    String heading;
    String path;
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    String xmlpath;
    DocumentBuilderFactory dbf = null;
    DocumentBuilder db = null;
    org.w3c.dom.Document docxml = null;
    NodeList nl = null;
    NodeList nl1 = null;
    boolean threaddone = false;
    String division;
    String sec;
    ArrayList arr;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head><title>Noida Jal Board : Contact Us</title>
    <jsp:include page="../common/header.jsp"/>


    <script type="text/javascript" src="../../resources/jquery/jquery.validate.js"></script>

    <script  type="text/javascript">
        $(document).ready(function()
        {
            $("#contactusform").validate();
        });
    </script>
</head>
    <body>
        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");
                    String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                    String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");


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
                            <a href="#" title="contact us">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Contact us
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
                    <div id="contentrail">
                        <div class="news">






                            <%
                             InitialContext initialContext = new InitialContext();
                                            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                            con = dataSource.getConnection();
                                        try {


                                            con_id = request.getParameter("con_id");
                                           
                                            // con = (Connection) pageContext.getServletContext().getAttribute("con");
                                            sql = "select con_id,con_title,content,content_type,con_date from jal_content where content_type='contact' and con_title='Contact Details'";
                                            pst = con.prepareStatement(sql);
                                            rs = pst.executeQuery();

                                            if (rs.next()) {
                                                con_id = rs.getString(1);
                                                con_title = rs.getString(2);
                                                content = rs.getString(3);
                                                content_type = rs.getString(4);
                                                con_date = rs.getString(5);

                            %>
                            <h2><%=con_title%></h2>

                            <%=content%>
                            <br/>
                            <%
                                            }


                                        } catch (Exception ex) {
                                            System.out.println(ex);
                                        }
                            %>




                        </div>
                    </div>
   <%
                    try {
                        userid = (String) session.getAttribute("userid");
                        dbf = DocumentBuilderFactory.newInstance();
                        db = dbf.newDocumentBuilder();
                        xmlpath = pageContext.getServletContext().getRealPath("") + "/resources/jalutilXML/" + "jal.xml";
                        docxml = db.parse(xmlpath);
                        
                        %>

                    <div id="rightrail">
                        <div  class="box box300 twitter">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <h3>JAL-1</h3>
                                        </div> <!-- #twitter .bg -->
                                    </div> <!-- #twitter .rightcorners -->
                                </div> <!-- #twitter .leftcorners -->
                            </div> <!-- #twitter .heading -->
                            <div class="content">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <div class="insider">

                                                <div class="tweet1">
                                                     <br class="clear"/>
                                                    <p>Address- Sector-5, NOIDA-201301</p>
                                                    <p><a href="http://maps.google.co.uk/maps?f=q&amp;source=embed&amp;hl=en&amp;q=Sector+5,+New+Delhi,+Delhi,+India&amp;sll=53.800651,-4.064941&amp;sspn=15.372765,53.569336&amp;ie=UTF8&amp;cd=1&amp;geocode=FWU-tAEdZdubBA&amp;split=0&amp;hq=&amp;hnear=Sector+5,+Pushp+Vihar,+New+Delhi,+Delhi,+India&amp;ll=28.52436,77.224016&amp;spn=0.011312,0.019655&amp;z=14&amp;iwloc=A"><img src="../../resources/images/sec5.png" alt="form" title="click here to view full map" class="left5" /></a></p>
                                             <p> Sector List-

                        <%

                         SelectSec_Div sec_Div = new SelectSec_Div();
                    arr=new  ArrayList();
                           arr = sec_Div.getSectorList("jal1", docxml);
                           for(int i=0;i<arr.size();i++)
         {
        %>

        <%=arr.get(i).toString() %>,

        <%
}
                        %>
                       
        </p>
                                                  
                                                </div> <!-- #tweet / div for tweets -->
                                            </div> <!-- #twitter .insider -->
                                        </div> <!-- #twitter .bg -->
                                    </div> <!-- #twitter .rightcorners -->
                                </div> <!-- #twitter .leftcorners -->
                            </div> <!-- #twitter .content -->
                        </div> <!-- #twitter -->
                        <br class="clear" />
                   
                        <div  class="box box300">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <h3>JAL-2</h3>
                                        </div> <!-- #twitter .bg -->
                                    </div> <!-- #twitter .rightcorners -->
                                </div> <!-- #twitter .leftcorners -->
                            </div> <!-- #twitter .heading -->
                            <div class="content">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <div class="insider">

                                                <div class="tweet1">
                                                     <br class="clear"/>
                                                    <p>Address- Sector-37, NOIDA-201301</p>
                                                    <p><a href="http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=noida+sector+37,39&amp;sll=28.565376,77.339373&amp;sspn=0.042139,0.104628&amp;ie=UTF8&amp;hq=&amp;hnear=Sector+37,+Delhi,+India&amp;ll=28.567035,77.348213&amp;spn=0.011307,0.021372&amp;z=14&amp;iwloc=A"><img src="../../resources/images/sec37.png" alt="form" title="click here to view full map" class="left5" /></a></p>
                                                     <p> Sector List-

                        <%

                    arr=new  ArrayList();
                           arr = sec_Div.getSectorList("jal2", docxml);
                           for(int i=0;i<arr.size();i++)
         {
       %>

        <%= arr.get(i).toString()%>,

        <%

                            
                        }
                        %>
                       
        </p>
                                                  
                                                  
                                                </div> <!-- #tweet / div for tweets -->

                                            </div> <!-- #twitter .insider -->
                                        </div> <!-- #twitter .bg -->
                                    </div> <!-- #twitter .rightcorners -->
                                </div> <!-- #twitter .leftcorners -->
                            </div> <!-- #twitter .content -->
                        </div> <!-- #twitter -->
                        <br class="clear" />
                  
                        <div class="box box300">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <h3>JAL-3</h3>
                                        </div> <!-- #twitter .bg -->
                                    </div> <!-- #twitter .rightcorners -->
                                </div> <!-- #twitter .leftcorners -->
                            </div> <!-- #twitter .heading -->
                            <div class="content">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <div class="insider">
                                                <div class="tweet1">
                                                    <br class="clear"/>
                                                    <p>Address- Sector-39, NOIDA-201301</p>
                                                    <p><a href="http://maps.google.co.uk/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=Sector+39,+New+Delhi,+Delhi,+India&amp;sll=28.524021,77.227407&amp;sspn=0.022284,0.052314&amp;ie=UTF8&amp;hq=&amp;hnear=Sector+39,+Delhi,+India&amp;ll=28.568015,77.351818&amp;spn=0.011307,0.019655&amp;z=14&amp;iwloc=A"><img src="../../resources/images/sec39.png" alt="form" title="click here to view full map" class="left5" /></a></p>
                                                   <p> Sector List-

                        <%
                          arr=new  ArrayList();
                           arr = sec_Div.getSectorList("jal3", docxml);
                           for(int i=0;i<arr.size();i++)
         {
        %>

        <%=  arr.get(i).toString()%>,

        <%

                            
                        }
                        %>
                       
        </p>
                                                  
                                                </div> <!-- #tweet / div for tweets -->

                                            </div> <!-- #twitter .insider -->
                                        </div> <!-- #twitter .bg -->
                                    </div> <!-- #twitter .rightcorners -->
                                </div> <!-- #twitter .leftcorners -->
                            </div> <!-- #twitter .content -->
                        </div> <!-- #twitter -->
                        <br class="clear" />
                    </div> <!-- #rightrail -->
 <%
                    } catch (Exception ex) {
                        System.out.println(ex);
                    }
                                            con.close();

        %>
                </div>
            </div>
        </div>

        <!-- Container Ends -->
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>

















