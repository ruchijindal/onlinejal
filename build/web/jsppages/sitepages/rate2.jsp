<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.*" %>

<%!    int t = 0;
    String sql;
    String content;
    String content_type;
    String con_id;
    String con_date;
    String con_title;
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    String content1;
    String sql1;
    String content2;
%>

<%
            try {
                t = ((Integer) request.getAttribute("t")).intValue();
            } catch (Exception ex) {
                System.out.println("Exception:" + ex);
            }
            String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
            String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../common/header.jsp"/>

    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid-->
    <link rel="stylesheet" href="../../resources/css/invalid.css" type="text/css" media="screen" />

    <!-- jQuery -->
    <script type="text/javascript" src="../../resources/jquery/jquery-1.3.2.min.js"></script>

    <!-- jQuery Configuration -->
    <script type="text/javascript" src="../../resources/jquery/simpla.jquery.configuration.js"></script>


    <body>


        <!-- Menu Starts -->
        <jsp:include page="../common/navigation.jsp"/>
        <!-- Menu Ends -->

        <%

                    try {
                        InitialContext initialContext = new InitialContext();
                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                        con = dataSource.getConnection();
                        //con=(Connection)pageContext.getServletContext().getAttribute("con");
                        con_id = request.getParameter("con_id");
                        con_title = request.getParameter("con_title");
                        content = request.getParameter("content");
                        content_type = request.getParameter("content_type");
                        con_date = request.getParameter("con_date");
                        sql = "select con_id,con_title,content,content_type,con_date from jal_content where con_id=1 and content_type='maincontent'";
                        pst = con.prepareStatement(sql);
                        rs = pst.executeQuery();
                        if (rs.next()) {
                            con_id = rs.getString(1);
                            con_title = rs.getString(2);
                            content = rs.getString(3);
                            content_type = rs.getString(4);
                            con_date = rs.getString(5);
                        }

                        pst.close();
                        rs.close();
                    } catch (Exception ex) {
                        System.out.println(ex);
                    } finally {
                        con.close();
                    }
        %>

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
       	<a href="#" title="Rates">
         <span class="leftcorners">
          <span class="rightarrow">
           <span class="bg">
            Rates
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
                    <div id="centerrail">

                        <div id="news" class="box box620 w">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <h3>Rates</h3>
                                            <ul class="content-box-tabs">
                                                <li><a href="#tab1" class="default-tab">Residential</a></li> <!-- href must be unique and match the id of target div -->
                                                <li><a href="#tab2">Industrial</a></li>
                                                <li><a href="#tab3">Institutional</a></li>
                                                <li><a href="#tab4">Commercial</a></li>
                                                <li><a href="#tab5">Flats</a></li>
                                            </ul>
                                        </div> <!-- #news .bg -->
                                    </div> <!-- #news .rightcorners -->
                                </div> <!-- #news .leftcorners -->
                            </div> <!-- #news .heading -->
                            <div class="content">
                                <div class="leftcorners1">
                                    <div class="rightcorners1">
                                        <div class="bg1">
                                            <div class="insider">
                                                <div class="article">
                                                    <div class="content-box-content">

                                                        <div class="tab-content default-tab" id="tab1"> <!-- This is the target div. id must match the href of this div's tab -->
                                                            <!--h3>Rates For Residential</h3-->
                                                            <div id="table-blk" >

                                                                <table id="box-table">
                                                                    <colgroup>
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                    </colgroup>

                                                                    <thead>
                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="6">  RESIDENTIAL </th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="2"rowspan="2">Time Period</th>
                                                                            <th scope="col" id="vzebra-adventure"rowspan="2" >Pipe Size <br/>(in mm)</th>
                                                                            <th scope="col" id="vzebra-comedy"rowspan="2">Connection Type</th>
                                                                            <th scope="col" id="vzebra-adventure"colspan="2">Plot Size (per sq. meter)</th>
                                                                        </tr>
                                                                        <tr>
                                                                            <th scope="col" id="vzebra-adventure">01-250</th>
                                                                            <th scope="col" id="vzebra-comedy" >ABOVE 250</th>
                                                                        </tr>

                                                                    </thead>

                                                                    <tbody>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" colspan="2" rowspan="2">1990-1995</td>
                                                                            <td scope="col" id="vzebra-action" rowspan="6">15 </td>
                                                                            <td>Regular</td>
                                                                            <td>30</td>
                                                                            <td>30</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>150</td>
                                                                            <td>150</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" colspan="2" rowspan="2">1995-1999</td>
                                                                            <td>Regular</td>
                                                                            <td>60</td>
                                                                            <td>100</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>200</td>
                                                                            <td>200</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" colspan="2" rowspan="2">1999-2002</td>
                                                                            <td>Regular</td>
                                                                            <td>90</td>
                                                                            <td>150</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>300</td>
                                                                            <td>300</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                                <br/>
                                                                <br/>


                                                                <table id="box-table">
                                                                    <colgroup>
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                    </colgroup>
                                                                    <thead>
                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="12">  RESIDENTIAL </th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" rowspan="2">Time Period</th>
                                                                            <th scope="col" id="vzebra-adventure"rowspan="2" >Pipe Size<br/> (in mm)</th>
                                                                            <th scope="col" id="vzebra-comedy"rowspan="2">Con Type</th>
                                                                            <th scope="col" id="vzebra-adventure"colspan="9">Plot Size (per sq. meter)</th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" >01-30</th>
                                                                            <th scope="col" id="vzebra-adventure" >31-50</th>
                                                                            <th scope="col" id="vzebra-comedy">51-100</th>
                                                                            <th scope="col" id="vzebra-adventure">101-200</th>
                                                                            <th scope="col" id="vzebra-comedy" >201-300</th>
                                                                            <th scope="col" id="vzebra-adventure" >301-400</th>
                                                                            <th scope="col" id="vzebra-comedy">401-500</th>
                                                                            <th scope="col" id="vzebra-adventure">501-1000</th>
                                                                            <th scope="col" id="vzebra-comedy" >ABOVE 1000</th>
                                                                        </tr>

                                                                    </thead>



                                                                    <tbody>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">2002-2003</td>
                                                                            <td scope="col" id="vzebra-action" rowspan="4">15 </td>
                                                                            <td>Regular</td>
                                                                            <td>40</td>
                                                                            <td>50</td>
                                                                            <td>120</td>
                                                                            <td>150</td>
                                                                            <td>200</td>
                                                                            <td>230</td>
                                                                            <td>270</td>
                                                                            <td>300</td>
                                                                            <td>NA</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>80</td>
                                                                            <td>100</td>
                                                                            <td>240</td>
                                                                            <td>300</td>
                                                                            <td>400</td>
                                                                            <td>460</td>
                                                                            <td>540</td>
                                                                            <td>600</td>
                                                                            <td>NA</td>
                                                                        </tr>


                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">2003-2004</td>
                                                                            <td>Regular</td>
                                                                            <td>40</td>
                                                                            <td>50</td>
                                                                            <td>120</td>
                                                                            <td>150</td>
                                                                            <td>200</td>
                                                                            <td>230</td>
                                                                            <td>270</td>
                                                                            <td>300</td>
                                                                            <td>NA</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>50</td>
                                                                            <td>65</td>
                                                                            <td>150</td>
                                                                            <td>190</td>
                                                                            <td>250</td>
                                                                            <td>290</td>
                                                                            <td>340</td>
                                                                            <td>375</td>
                                                                            <td>NA</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                                <br/>
                                                                <br/>
                                                                <br/>
                                                            </div>
                                                        </div>

                                                        <div class="tab-content" id="tab2">
                                                            <!--h2>Rates For Industrial</h2-->
                                                            <div id="table-blk">

                                                                <table id="box-table">
                                                                    <colgroup>
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                    </colgroup>
                                                                    <thead>
                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="7">  INDUSTRIAL </th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="2" rowspan="2">Time Period</th>
                                                                            <th scope="col" id="vzebra-adventure"rowspan="2" >Pipe Size<br/> (in mm)</th>
                                                                            <th scope="col" id="vzebra-comedy"rowspan="2">Con Type</th>
                                                                            <th scope="col" id="vzebra-adventure"colspan="3">Plot Size (per sq. meter)</th>
                                                                        </tr>
                                                                        <tr>
                                                                            <th scope="col" id="vzebra-adventure">01 to 250</th>
                                                                            <th scope="col" id="vzebra-comedy" >251 to 500</th>
                                                                            <th scope="col" id="vzebra-adventure">501 to ABOVE</th>

                                                                        </tr>

                                                                    </thead>

                                                                    <tbody>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" colspan="2" rowspan="4">1990-1995</td>
                                                                            <td  scope="col" id="vzebra-action" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td> 60</td>
                                                                            <td> 60</td>
                                                                            <td> 60</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 150</td>
                                                                            <td> 150</td>
                                                                            <td> 150</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td> 120</td>
                                                                            <td> 120</td>
                                                                            <td> 120</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 300</td>
                                                                            <td> 300</td>
                                                                            <td> 300</td>
                                                                        </tr>


                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" colspan="2" rowspan="4">1995-1999</td>
                                                                            <td  scope="col" id="vzebra-action" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td> 60</td>
                                                                            <td> 90</td>
                                                                            <td> 120</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 300</td>
                                                                            <td> 300</td>
                                                                            <td> 300</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td> 240</td>
                                                                            <td> 240</td>
                                                                            <td> 240</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 600</td>
                                                                            <td> 600</td>
                                                                            <td> 600</td>
                                                                        </tr>


                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" colspan="2" rowspan="18">1999-2002</td>
                                                                            <td  scope="col" id="vzebra-action" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td> 90</td>
                                                                            <td> 135</td>
                                                                            <td> 180</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 450</td>
                                                                            <td> 450</td>
                                                                            <td> 450</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td> 360</td>
                                                                            <td> 360</td>
                                                                            <td> 360</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 900</td>
                                                                            <td> 900</td>
                                                                            <td> 900</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">25 </td>
                                                                            <td>Regular</td>
                                                                            <td> 1643</td>
                                                                            <td> 1643</td>
                                                                            <td> 1643</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 2054</td>
                                                                            <td> 2054</td>
                                                                            <td> 2054</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">32 </td>
                                                                            <td>Regular</td>
                                                                            <td> 2464</td>
                                                                            <td> 2464</td>
                                                                            <td> 2464</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 3080</td>
                                                                            <td> 3080</td>
                                                                            <td> 3080</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">40 </td>
                                                                            <td>Regular</td>
                                                                            <td> 3833</td>
                                                                            <td> 3833</td>
                                                                            <td> 3833</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 4791</td>
                                                                            <td> 4791</td>
                                                                            <td> 4791</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">50 </td>
                                                                            <td>Regular</td>
                                                                            <td> 6023</td>
                                                                            <td> 6023</td>
                                                                            <td> 6023</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 7529</td>
                                                                            <td> 7529</td>
                                                                            <td> 7529</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">65 </td>
                                                                            <td>Regular</td>
                                                                            <td> 8395</td>
                                                                            <td> 8395</td>
                                                                            <td> 8395</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 10494</td>
                                                                            <td> 10494</td>
                                                                            <td> 10494</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">80 </td>
                                                                            <td>Regular</td>
                                                                            <td> 11969</td>
                                                                            <td> 11969</td>
                                                                            <td> 11969</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 14962</td>
                                                                            <td> 14962</td>
                                                                            <td> 14962</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">100 </td>
                                                                            <td>Regular</td>
                                                                            <td> 21292</td>
                                                                            <td> 21292</td>
                                                                            <td> 21292</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 26615</td>
                                                                            <td> 26615</td>
                                                                            <td> 26615</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                                <br/>
                                                                <br/>


                                                                <table id="box-table">
                                                                    <colgroup>
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                    </colgroup>
                                                                    <thead>
                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="12">  INDUSTRIAL </th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy"  rowspan="2">Time Period</th>
                                                                            <th scope="col" id="vzebra-adventure"rowspan="2" >Pipe Size<br/> (in mm)</th>
                                                                            <th scope="col" id="vzebra-comedy"rowspan="2">Con Type</th>
                                                                            <th scope="col" id="vzebra-adventure"colspan="9">Plot Size (per sq. meter)</th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" >01-30</th>
                                                                            <th scope="col" id="vzebra-adventure" >31-50</th>
                                                                            <th scope="col" id="vzebra-comedy">51-100</th>
                                                                            <th scope="col" id="vzebra-adventure">101-200</th>
                                                                            <th scope="col" id="vzebra-comedy" >201-300</th>
                                                                            <th scope="col" id="vzebra-adventure" >301-400</th>
                                                                            <th scope="col" id="vzebra-comedy">401-500</th>
                                                                            <th scope="col" id="vzebra-adventure">501-1000</th>
                                                                            <th scope="col" id="vzebra-comedy" >ABOVE 1000</th>
                                                                        </tr>

                                                                    </thead>

                                                                    <tbody>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="18">2002-2003</td>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td>125</td>
                                                                            <td>125</td>
                                                                            <td>180</td>
                                                                            <td>225</td>
                                                                            <td>300</td>
                                                                            <td>345</td>
                                                                            <td>405</td>
                                                                            <td>450</td>
                                                                            <td>500</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>250</td>
                                                                            <td>250</td>
                                                                            <td>360</td>
                                                                            <td>450</td>
                                                                            <td>600</td>
                                                                            <td>690</td>
                                                                            <td>810</td>
                                                                            <td>900</td>
                                                                            <td>1000</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">25 </td>
                                                                            <td>Regular</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">32 </td>
                                                                            <td>Regular</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">40 </td>
                                                                            <td>Regular</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">50 </td>
                                                                            <td>Regular</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">65 </td>
                                                                            <td>Regular</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">80 </td>
                                                                            <td>Regular</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">100 </td>
                                                                            <td>Regular</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                        </tr>




                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="18">2003-2004</td>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td>100</td>
                                                                            <td>100</td>
                                                                            <td>150</td>
                                                                            <td>190</td>
                                                                            <td>250</td>
                                                                            <td>290</td>
                                                                            <td>340</td>
                                                                            <td>375</td>
                                                                            <td>500</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>125</td>
                                                                            <td>125</td>
                                                                            <td>190</td>
                                                                            <td>240</td>
                                                                            <td>315</td>
                                                                            <td>365</td>
                                                                            <td>425</td>
                                                                            <td>470</td>
                                                                            <td>625</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">25 </td>
                                                                            <td>Regular</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">32 </td>
                                                                            <td>Regular</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">40 </td>
                                                                            <td>Regular</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">50 </td>
                                                                            <td>Regular</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">65 </td>
                                                                            <td>Regular</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">80 </td>
                                                                            <td>Regular</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">100 </td>
                                                                            <td>Regular</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                        </tr>
                                                                    </tbody>

                                                                </table>
                                                                <br/>
                                                                <br/>
                                                                <br/>
                                                            </div>
                                                        </div>

                                                        <div class="tab-content" id="tab3">

                                                            <!--h2>Rates For Institutional</h2-->
                                                            <div id="table-blk">


                                                                <table id="box-table">
                                                                    <colgroup>
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                    </colgroup>
                                                                    <thead>
                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="7">  INSTITUTIONAL </th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="2" rowspan="2">Time Period</th>
                                                                            <th scope="col" id="vzebra-adventure"rowspan="2" >Pipe Size <br/>(in mm)</th>
                                                                            <th scope="col" id="vzebra-comedy"rowspan="2">Con Type</th>
                                                                            <th scope="col" id="vzebra-adventure"colspan="3">Plot Size (per sq. meter)</th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-adventure">01 to 250</th>
                                                                            <th scope="col" id="vzebra-comedy" >251 to 500</th>
                                                                            <th scope="col" id="vzebra-adventure">501 to ABOVE</th>

                                                                        </tr>

                                                                    </thead>

                                                                    <tbody>


                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" colspan="2" rowspan="4">1990-1995</td>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td> 60</td>
                                                                            <td> 60</td>
                                                                            <td> 60</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 150</td>
                                                                            <td> 150</td>
                                                                            <td> 150</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td> 120</td>
                                                                            <td> 120</td>
                                                                            <td> 120</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 300</td>
                                                                            <td> 300</td>
                                                                            <td> 300</td>
                                                                        </tr>


                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" colspan="2" rowspan="4">1995-1999</td>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td> 60</td>
                                                                            <td> 90</td>
                                                                            <td> 120</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 300</td>
                                                                            <td> 300</td>
                                                                            <td> 300</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td> 240</td>
                                                                            <td> 240</td>
                                                                            <td> 240</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 600</td>
                                                                            <td> 600</td>
                                                                            <td> 600</td>
                                                                        </tr>


                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" colspan="2" rowspan="18">1999-2002</td>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td> 90</td>
                                                                            <td> 135</td>
                                                                            <td> 180</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 450</td>
                                                                            <td> 450</td>
                                                                            <td> 450</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td> 360</td>
                                                                            <td> 360</td>
                                                                            <td> 360</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 900</td>
                                                                            <td> 900</td>
                                                                            <td> 900</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">25 </td>
                                                                            <td>Regular</td>
                                                                            <td> 1643</td>
                                                                            <td> 1643</td>
                                                                            <td> 1643</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 5042</td>
                                                                            <td> 5042</td>
                                                                            <td> 5042</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">32 </td>
                                                                            <td>Regular</td>
                                                                            <td> 2464</td>
                                                                            <td> 2464</td>
                                                                            <td> 2464</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 3080</td>
                                                                            <td> 3080</td>
                                                                            <td> 3080</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">40 </td>
                                                                            <td>Regular</td>
                                                                            <td> 3833</td>
                                                                            <td> 3833</td>
                                                                            <td> 3833</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 4791</td>
                                                                            <td> 4791</td>
                                                                            <td> 4791</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">50 </td>
                                                                            <td>Regular</td>
                                                                            <td> 6023</td>
                                                                            <td> 6023</td>
                                                                            <td> 6023</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 7529</td>
                                                                            <td> 7529</td>
                                                                            <td> 7529</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">65 </td>
                                                                            <td>Regular</td>
                                                                            <td> 8395</td>
                                                                            <td> 8395</td>
                                                                            <td> 8395</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 10494</td>
                                                                            <td> 10494</td>
                                                                            <td> 10494</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">80 </td>
                                                                            <td>Regular</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 14962</td>
                                                                            <td> 14962</td>
                                                                            <td> 14962</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">100 </td>
                                                                            <td>Regular</td>
                                                                            <td> 21292</td>
                                                                            <td> 21292</td>
                                                                            <td> 21292</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 26615</td>
                                                                            <td> 26615</td>
                                                                            <td> 26615</td>
                                                                        </tr>
                                                                    </tbody>

                                                                </table>
                                                                <br/>
                                                                <br/>

                                                                <table id="box-table">
                                                                    <colgroup>
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                    </colgroup>
                                                                    <thead>
                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="12">  INSTITUTIONAL </th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy"  rowspan="2">Time Period</th>
                                                                            <th scope="col" id="vzebra-adventure"rowspan="2" >Pipe Size <br/> (in mm)</th>
                                                                            <th scope="col" id="vzebra-comedy"rowspan="2">Con Type</th>
                                                                            <th scope="col" id="vzebra-adventure"colspan="9">Plot Size (per sq. meter)</th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" >01-30</th>
                                                                            <th scope="col" id="vzebra-adventure" >31-50</th>
                                                                            <th scope="col" id="vzebra-comedy">51-100</th>
                                                                            <th scope="col" id="vzebra-adventure">101-200</th>
                                                                            <th scope="col" id="vzebra-comedy" >201-300</th>
                                                                            <th scope="col" id="vzebra-adventure" >301-400</th>
                                                                            <th scope="col" id="vzebra-comedy">401-500</th>
                                                                            <th scope="col" id="vzebra-adventure">501-1000</th>
                                                                            <th scope="col" id="vzebra-comedy" >ABOVE 1000</th>
                                                                        </tr>

                                                                    </thead>

                                                                    <tbody>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="18">2002-2003</td>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td>125</td>
                                                                            <td>125</td>
                                                                            <td>180</td>
                                                                            <td>225</td>
                                                                            <td>300</td>
                                                                            <td>345</td>
                                                                            <td>405</td>
                                                                            <td>450</td>
                                                                            <td>500</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>250</td>
                                                                            <td>250</td>
                                                                            <td>360</td>
                                                                            <td>450</td>
                                                                            <td>600</td>
                                                                            <td>690</td>
                                                                            <td>810</td>
                                                                            <td>900</td>
                                                                            <td>1000</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                            <td>1314</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                        </tr>


                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">25 </td>
                                                                            <td>Regular</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                            <td>1971</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">32 </td>
                                                                            <td>Regular</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                            <td>2957</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                            <td>5913</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">40 </td>
                                                                            <td>Regular</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                            <td>4599</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                            <td>9198</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">50 </td>
                                                                            <td>Regular</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                            <td>7227</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                            <td>14454</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">65 </td>
                                                                            <td>Regular</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                            <td>10074</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                            <td>20148</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">80 </td>
                                                                            <td>Regular</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                            <td>14363</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                            <td>28726</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">100 </td>
                                                                            <td>Regular</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                            <td>25550</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                            <td>51100</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="18">2003-2004</td>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td>100</td>
                                                                            <td>100</td>
                                                                            <td>150</td>
                                                                            <td>190</td>
                                                                            <td>250</td>
                                                                            <td>290</td>
                                                                            <td>340</td>
                                                                            <td>375</td>
                                                                            <td>500</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>125</td>
                                                                            <td>125</td>
                                                                            <td>190</td>
                                                                            <td>240</td>
                                                                            <td>315</td>
                                                                            <td>365</td>
                                                                            <td>425</td>
                                                                            <td>470</td>
                                                                            <td>625</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                            <td>1095</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                            <td>1369</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">25 </td>
                                                                            <td>Regular</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                            <td>1643</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                            <td>2054</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">32 </td>
                                                                            <td>Regular</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                            <td>2464</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                            <td>3080</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">40 </td>
                                                                            <td>Regular</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                            <td>3833</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                            <td>4791</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">50 </td>
                                                                            <td>Regular</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                            <td>6023</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                            <td>7529</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">65 </td>
                                                                            <td>Regular</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                            <td>8395</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                            <td>10494</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">80 </td>
                                                                            <td>Regular</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                            <td>14962</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">100 </td>
                                                                            <td>Regular</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                            <td>21292</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                            <td>26615</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                                <br/>
                                                                <br/>
                                                                <br/>

                                                            </div>
                                                        </div>

                                                        <div class="tab-content" id="tab4">
                                                            <!--h2>Rates For Commercial</h2-->
                                                            <div id="table-blk">

                                                                <table id="box-table">
                                                                    <colgroup>
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                    </colgroup>
                                                                    <thead>
                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="7">  COMMERCIAL </th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="2" rowspan="2">Time Period</th>
                                                                            <th scope="col" id="vzebra-adventure"rowspan="2" >Pipe Size<br/> (in mm)</th>
                                                                            <th scope="col" id="vzebra-comedy"rowspan="2">Con Type</th>
                                                                            <th scope="col" id="vzebra-adventure"colspan="3">Plot Size (per sq. meter)</th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-adventure">01 to 250</th>
                                                                            <th scope="col" id="vzebra-comedy" >251 to 500</th>
                                                                            <th scope="col" id="vzebra-adventure">501 to ABOVE</th>

                                                                        </tr>

                                                                    </thead>
                                                                    <tbody>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" colspan="2" rowspan="4">1990-1995</td>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td> 60</td>
                                                                            <td> 60</td>
                                                                            <td> 60</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 150</td>
                                                                            <td> 150</td>
                                                                            <td> 150</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td> 120</td>
                                                                            <td> 120</td>
                                                                            <td> 120</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 300</td>
                                                                            <td> 300</td>
                                                                            <td> 300</td>
                                                                        </tr>


                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" colspan="2" rowspan="4">1995-1999</td>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td> 60</td>
                                                                            <td> 90</td>
                                                                            <td> 120</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 300</td>
                                                                            <td> 300</td>
                                                                            <td> 300</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td> 240</td>
                                                                            <td> 240</td>
                                                                            <td> 240</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 600</td>
                                                                            <td> 600</td>
                                                                            <td> 600</td>
                                                                        </tr>


                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" colspan="2" rowspan="18">1999-2002</td>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td> 90</td>
                                                                            <td> 135</td>
                                                                            <td> 180</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 450</td>
                                                                            <td> 450</td>
                                                                            <td> 450</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td> 360</td>
                                                                            <td> 360</td>
                                                                            <td> 360</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 900</td>
                                                                            <td> 900</td>
                                                                            <td> 900</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">25 </td>
                                                                            <td>Regular</td>
                                                                            <td> 1643</td>
                                                                            <td> 1643</td>
                                                                            <td> 1643</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 2054</td>
                                                                            <td> 2054</td>
                                                                            <td> 2054</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">32 </td>
                                                                            <td>Regular</td>
                                                                            <td> 2464</td>
                                                                            <td> 2464</td>
                                                                            <td> 2464</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 3080</td>
                                                                            <td> 3080</td>
                                                                            <td> 3080</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">40 </td>
                                                                            <td>Regular</td>
                                                                            <td> 3833</td>
                                                                            <td> 3833</td>
                                                                            <td> 3833</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 4791</td>
                                                                            <td> 4791</td>
                                                                            <td> 4791</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">50 </td>
                                                                            <td>Regular</td>
                                                                            <td> 6023</td>
                                                                            <td> 6023</td>
                                                                            <td> 6023</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 7529</td>
                                                                            <td> 7529</td>
                                                                            <td> 7529</td>
                                                                        </tr>


                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">65 </td>
                                                                            <td>Regular</td>
                                                                            <td> 8395</td>
                                                                            <td> 8395</td>
                                                                            <td> 8395</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 10494</td>
                                                                            <td> 10494</td>
                                                                            <td> 10494</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">80 </td>
                                                                            <td>Regular</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                            <td>11969</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 14962</td>
                                                                            <td> 14962</td>
                                                                            <td> 14962</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">100 </td>
                                                                            <td>Regular</td>
                                                                            <td> 21292</td>
                                                                            <td> 21292</td>
                                                                            <td> 21292</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td> 26615</td>
                                                                            <td> 26615</td>
                                                                            <td> 26615</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                                <br/>
                                                                <br/>


                                                                <table id="box-table">
                                                                    <colgroup>
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                    </colgroup>
                                                                    <thead>
                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="12">  COMMERCIAL </th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy"  rowspan="2">Time Period</th>
                                                                            <th scope="col" id="vzebra-adventure"rowspan="2" >Pipe Size<br/> (in mm)</th>
                                                                            <th scope="col" id="vzebra-comedy"rowspan="2">Con Type</th>
                                                                            <th scope="col" id="vzebra-adventure"colspan="9">Plot Size (per sq. meter)</th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" >01-30</th>
                                                                            <th scope="col" id="vzebra-adventure" >31-50</th>
                                                                            <th scope="col" id="vzebra-comedy">51-100</th>
                                                                            <th scope="col" id="vzebra-adventure">101-200</th>
                                                                            <th scope="col" id="vzebra-comedy" >201-300</th>
                                                                            <th scope="col" id="vzebra-adventure" >301-400</th>
                                                                            <th scope="col" id="vzebra-comedy">401-500</th>
                                                                            <th scope="col" id="vzebra-adventure">501-1000</th>
                                                                            <th scope="col" id="vzebra-comedy" >ABOVE 1000</th>
                                                                        </tr>

                                                                    </thead>

                                                                    <tbody>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="18">2002-2003</td>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td>150</td>
                                                                            <td>150</td>
                                                                            <td>240</td>
                                                                            <td>300</td>
                                                                            <td>400</td>
                                                                            <td>460</td>
                                                                            <td>540</td>
                                                                            <td>600</td>
                                                                            <td>600</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>300</td>
                                                                            <td>300</td>
                                                                            <td>480</td>
                                                                            <td>600</td>
                                                                            <td>800</td>
                                                                            <td>920</td>
                                                                            <td>1080</td>
                                                                            <td>1200</td>
                                                                            <td>1200</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>3504</td>
                                                                            <td>3504</td>
                                                                            <td>3504</td>
                                                                            <td>3504</td>
                                                                            <td>3504</td>
                                                                            <td>3504</td>
                                                                            <td>3504</td>
                                                                            <td>3504</td>
                                                                            <td>3504</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">25 </td>
                                                                            <td>Regular</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>5256</td>
                                                                            <td>5256</td>
                                                                            <td>5256</td>
                                                                            <td>5256</td>
                                                                            <td>5256</td>
                                                                            <td>5256</td>
                                                                            <td>5256</td>
                                                                            <td>5256</td>
                                                                            <td>5256</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">32 </td>
                                                                            <td>Regular</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>7884</td>
                                                                            <td>7884</td>
                                                                            <td>7884</td>
                                                                            <td>7884</td>
                                                                            <td>7884</td>
                                                                            <td>7884</td>
                                                                            <td>7884</td>
                                                                            <td>7884</td>
                                                                            <td>7884</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">40 </td>
                                                                            <td>Regular</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>12264</td>
                                                                            <td>12264</td>
                                                                            <td>12264</td>
                                                                            <td>12264</td>
                                                                            <td>12264</td>
                                                                            <td>12264</td>
                                                                            <td>12264</td>
                                                                            <td>12264</td>
                                                                            <td>12264</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">50 </td>
                                                                            <td>Regular</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>19272</td>
                                                                            <td>19272</td>
                                                                            <td>19272</td>
                                                                            <td>19272</td>
                                                                            <td>19272</td>
                                                                            <td>19272</td>
                                                                            <td>19272</td>
                                                                            <td>19272</td>
                                                                            <td>19272</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">65 </td>
                                                                            <td>Regular</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>26864</td>
                                                                            <td>26864</td>
                                                                            <td>26864</td>
                                                                            <td>26864</td>
                                                                            <td>26864</td>
                                                                            <td>26864</td>
                                                                            <td>26864</td>
                                                                            <td>26864</td>
                                                                            <td>26864</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">80 </td>
                                                                            <td>Regular</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>38301</td>
                                                                            <td>38301</td>
                                                                            <td>38301</td>
                                                                            <td>38301</td>
                                                                            <td>38301</td>
                                                                            <td>38301</td>
                                                                            <td>38301</td>
                                                                            <td>38301</td>
                                                                            <td>38301</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">100 </td>
                                                                            <td>Regular</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>68134</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="18">2003-2004</td>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">15 </td>
                                                                            <td>Regular</td>
                                                                            <td>150</td>
                                                                            <td>150</td>
                                                                            <td>240</td>
                                                                            <td>300</td>
                                                                            <td>400</td>
                                                                            <td>460</td>
                                                                            <td>540</td>
                                                                            <td>600</td>
                                                                            <td>NA</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>190</td>
                                                                            <td>190</td>
                                                                            <td>300</td>
                                                                            <td>375</td>
                                                                            <td>500</td>
                                                                            <td>575</td>
                                                                            <td>675</td>
                                                                            <td>750</td>
                                                                            <td>NA</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">20 </td>
                                                                            <td>Regular</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                            <td>1752</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>2190</td>
                                                                            <td>2190</td>
                                                                            <td>2190</td>
                                                                            <td>2190</td>
                                                                            <td>2190</td>
                                                                            <td>2190</td>
                                                                            <td>2190</td>
                                                                            <td>2190</td>
                                                                            <td>2190</td>
                                                                        </tr>


                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">25 </td>
                                                                            <td>Regular</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                            <td>2628</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>3285</td>
                                                                            <td>3285</td>
                                                                            <td>3285</td>
                                                                            <td>3285</td>
                                                                            <td>3285</td>
                                                                            <td>3285</td>
                                                                            <td>3285</td>
                                                                            <td>3285</td>
                                                                            <td>3285</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">32 </td>
                                                                            <td>Regular</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                            <td>3942</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>4928</td>
                                                                            <td>4928</td>
                                                                            <td>4928</td>
                                                                            <td>4928</td>
                                                                            <td>4928</td>
                                                                            <td>4928</td>
                                                                            <td>4928</td>
                                                                            <td>4928</td>
                                                                            <td>4928</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">40 </td>
                                                                            <td>Regular</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                            <td>6132</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>7665</td>
                                                                            <td>7665</td>
                                                                            <td>7665</td>
                                                                            <td>7665</td>
                                                                            <td>7665</td>
                                                                            <td>7665</td>
                                                                            <td>7665</td>
                                                                            <td>7665</td>
                                                                            <td>7665</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">50 </td>
                                                                            <td>Regular</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                            <td>9636</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>10245</td>
                                                                            <td>10245</td>
                                                                            <td>10245</td>
                                                                            <td>10245</td>
                                                                            <td>10245</td>
                                                                            <td>10245</td>
                                                                            <td>10245</td>
                                                                            <td>10245</td>
                                                                            <td>10245</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">65 </td>
                                                                            <td>Regular</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                            <td>13432</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>16790</td>
                                                                            <td>16790</td>
                                                                            <td>16790</td>
                                                                            <td>16790</td>
                                                                            <td>16790</td>
                                                                            <td>16790</td>
                                                                            <td>16790</td>
                                                                            <td>16790</td>
                                                                            <td>16790</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" rowspan="2">80 </td>
                                                                            <td>Regular</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                            <td>19151</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                            <td>23938</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" rowspan="2">100 </td>
                                                                            <td>Regular</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                            <td>34067</td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>Temporary</td>
                                                                            <td>42584</td>
                                                                            <td>42584</td>
                                                                            <td>42584</td>
                                                                            <td>42584</td>
                                                                            <td>42584</td>
                                                                            <td>42584</td>
                                                                            <td>42584</td>
                                                                            <td>42584</td>
                                                                            <td>42584</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                                <br/>
                                                                <br/>
                                                                <br/>

                                                            </div>
                                                        </div>

                                                        <div class="tab-content" id="tab5">
                                                            <!--h2>Rates For Flats</h2-->
                                                            <div id="table-blk">
                                                                <table id="box-table">
                                                                    <colgroup>
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                        <col class="vzebra-odd" />
                                                                        <col class="vzebra-even" />
                                                                    </colgroup>
                                                                    <thead>
                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="13"> FLATS</th>
                                                                        </tr>

                                                                        <tr>
                                                                            <th scope="col" id="vzebra-comedy" colspan="2">Time Period</th>
                                                                            <th scope="col" id="vzebra-adventure">EWS</th>
                                                                            <th scope="col" id="vzebra-comedy">EWS1</th>
                                                                            <th scope="col" id="vzebra-adventure">LIG</th>
                                                                            <th scope="col" id="vzebra-comedy">LIG1</th>
                                                                            <th scope="col" id="vzebra-adventure">MIG</th>
                                                                            <th scope="col" id="vzebra-comedy">MIG1</th>
                                                                            <th scope="col" id="vzebra-adventure">MIG2</th>
                                                                            <th scope="col" id="vzebra-comedy">HIG</th>
                                                                            <th scope="col" id="vzebra-adventure">HIG1</th>
                                                                            <th scope="col" id="vzebra-comedy">DUPLEX</th>
                                                                            <th scope="col" id="vzebra-adventure">VILLA</th>
                                                                        </tr>
                                                                    </thead>

                                                                    <tbody>
                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" colspan="2">1990-1995</td>
                                                                            <td> 5</td>
                                                                            <td> 5</td>
                                                                            <td> 8</td>
                                                                            <td> 8</td>
                                                                            <td> 30</td>
                                                                            <td> 30</td>
                                                                            <td> 30</td>
                                                                            <td> 45</td>
                                                                            <td> 45</td>
                                                                            <td> NA</td>
                                                                            <td> 8</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" colspan="2">1995-1999</td>
                                                                            <td> 7</td>
                                                                            <td> 7</td>
                                                                            <td> 11</td>
                                                                            <td> 11</td>
                                                                            <td> 45</td>
                                                                            <td> 45</td>
                                                                            <td> 45</td>
                                                                            <td> 60</td>
                                                                            <td> 60</td>
                                                                            <td> NA</td>
                                                                            <td> 11</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td scope="col" id="vzebra-action" colspan="2">1999-2002</td>
                                                                            <td> 10</td>
                                                                            <td> 10</td>
                                                                            <td> 15</td>
                                                                            <td> 15</td>
                                                                            <td> 70</td>
                                                                            <td> 70</td>
                                                                            <td> 70</td>
                                                                            <td> 75</td>
                                                                            <td> 75</td>
                                                                            <td> NA</td>
                                                                            <td> 15</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td scope="col" id="vzebra-children" colspan="2">AFTER-2002</td>
                                                                            <td> 25</td>
                                                                            <td> 40</td>
                                                                            <td> 30</td>
                                                                            <td> 50</td>
                                                                            <td> 100</td>
                                                                            <td> 120</td>
                                                                            <td> NA</td>
                                                                            <td> 120</td>
                                                                            <td> 150</td>
                                                                            <td> 150</td>
                                                                            <td> 40</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                                <br/>
                                                                <br/>


                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Container Ends -->
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>







