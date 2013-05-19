
<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%@ page import ="com.fusioncharts.FusionChartsHelper"%>
<%@page  import="java.io.*,javax.xml.parsers.*,org.xml.sax.*,org.w3c.dom.NodeList;"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<% // We have imported the above file for using encodeDataURL method
%>
<%!    Connection connection;
    String dt1, dt2;
    String strDataURL;
    String tbl_name;
    int y1, y2;
    String c_id;
    String division, sec, year;
    float paidamount;
    String xmlfile;
    String update_dt;
    String userrole;
    int t;
%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head> <title>Noida Jal Board : Revenue Collection Details</title>
        <meta http-equiv="Content-Script-Type" content="text/javascript"></meta>
        <jsp:include page="../../../common/header.jsp"/>


        <meta http-equiv="content-type" content="text/html;charset=utf-8" />
        <meta http-equiv="content-type" content="text/javascript;charset=UTF-8" />
        <meta http-equiv="Content-Style-Type" content="text/css" />
        <script type="text/javascript" src="../../../../resources/jquery/simpla.jquery.configuration.js"></script>

        <script  type="text/javascript" src="../FusionCharts/FusionCharts.js" ></script>
        <script  type="text/javascript" src="../FusionCharts/FusionChartsExportComponent.js"></script>
        <style type="text/css">
            <!--
            body {
                font-family: Arial, Helvetica, sans-serif;
                font-size: 12px;
            }
            //-->
        </style>
        <script type="text/javascript">
          
            function startExport(){
                myExportComponent.BeginExport();
            }

        </script>

    </head>

    <%
                request.getSession(false);
                request.setAttribute("t", t);

                userrole = (String) session.getAttribute("userrole");
                String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");

    %>
    <body>
        <jsp:include page="../../../common/navigation.jsp"/>
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
                            <%
                                        try {
                                            String userrole = (String) session.getAttribute("userrole");

                                            if (userrole.equals("manager")) {
                            %>
                            <a href="../../../manager/mgr_dashboard.jsp" title="Manager">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Manager
                                        </span>
                                    </span>
                                </span>
                            </a>
                            <%       } else if (userrole.equals("admin")) {
                            %>
                            <a href="../../../admin/admin.jsp" title="Admin">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Admin
                                        </span>
                                    </span>
                                </span>
                            </a>
                            <%                }
                                        } catch (Exception ex) {
                                            System.out.println(ex);
                                        }
                            %>

                        </div> <!-- #breadcrums .active -->
                        <div class="active">
                            <a href="#" title="Graph">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Revenue Graph(JAL)
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

                    <div id="contentrail" class="full">


                        <div class="content">

                            <div class="insider">

                                <!--<div class="content-box-content">

					<<div class="tab-content default-tab" id="tab1">-->
                                <%
                                            try {
                                                InitialContext initialContext = new InitialContext();
                                                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                connection = dataSource.getConnection();
                                                // connection = (Connection) pageContext.getServletContext().getAttribute("con");


                                                String sql = "select xmlfile,to_char(update_dt,'dd-Mon-yyyy') from reports_tab where report_type='revenue_report' order by update_dt desc";
                                                PreparedStatement ps = connection.prepareStatement(sql);
                                                ResultSet rs = ps.executeQuery();
                                                if (rs.next()) {
                                                    xmlfile = rs.getString(1);
                                                    update_dt = rs.getString(2);

                                                }
                                            } catch (Exception ex) {
                                                System.out.println(ex);
                                            } finally {
                                                connection.close();
                                            }
                                            //System.out.println(xmlfile);
                                %>
                                <div id="table-blk" class="full">
                                    <h2>Revenue Collection Chart for JAL</h2>
                                    <div class="buttons">

                                        <button class="submit chart" type="button" title="Save Chart" value='Begin Chart Export' onclick="startExport();">
                                            <span class="leftcorners">
                                                <span class="rightcorners">
                                                    <span class="bg">
                                    			Export Chart
                                                    </span>
                                                </span>
                                            </span>
                                        </button>
                                    </div>
                                    <div id="chart" >
                                        <div id="fcexpDiv" ></div>
                                    </div>
                                    <h4>As on <%=update_dt%></h4>


                                    <%


                                                //Create an XML data document in a string variable
                                                String animateChart = null;
                                                animateChart = request.getParameter("animate");
                                                //Set default value of 1
                                                if (null == animateChart || animateChart.equals("")) {
                                                    animateChart = "1";
                                                }
                                                String strXML = "";

                                                DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
                                                DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
                                                org.w3c.dom.Document docxml = docBuilder.parse(new InputSource(new StringReader(xmlfile)));

                                                NodeList nl = docxml.getElementsByTagName("revenue_details");
                                                NodeList nl1 = nl.item(0).getChildNodes();
                                                strXML = "<?xml version='1.0' encoding='UTF-8' standalone='no'?><jal>";
                                                for (int j = 1; j < nl1.getLength(); j = j + 2) {
                                                    division = nl1.item(j).getNodeName().trim();
                                                    c_id = division.toUpperCase();

                                                    strXML += "<" + division.toUpperCase() + ">";
                                                    if (nl1.item(j).hasChildNodes()) {
                                                        NodeList nl2 = nl1.item(j).getChildNodes();
                                                        paidamount = 0;

                                                        for (int k = 1; k < nl2.item(1).getChildNodes().getLength(); k = k + 2) {
                                                            for (int i = 1; i < nl2.getLength(); i = i + 2) {
                                                                sec = nl2.item(i).getNodeName().trim();
                                                                sec = sec.substring(4).toUpperCase();
                                                                if (nl2.item(i).hasChildNodes()) {
                                                                    NodeList nl3 = nl2.item(i).getChildNodes();
                                                                    year = nl3.item(k).getNodeName().trim();

                                                                    year = year.substring(5);
                                                                    if (nl3.item(k).hasChildNodes()) {
                                                                        NodeList nl4 = nl3.item(k).getChildNodes();
                                                                        String f = nl4.item(5).getTextContent().trim();
                                                                        paidamount = paidamount + Float.parseFloat(f);
                                                                    }


                                                                }
                                                            }
                                                            paidamount = paidamount / 100000;
                                                            String s2 = paidamount + "";
                                                            strXML += "<year name='" + year + "' value='" + s2 + "'></year>";
                                                        }



                                                    }


                                                    strXML += "</" + division.toUpperCase() + ">";
                                                }
                                                strXML += "</jal>";
                                                //System.out.println(strXML);
                                                org.w3c.dom.Document docxml1 = docBuilder.parse(new InputSource(new StringReader(strXML)));
                                                NodeList jal = docxml1.getElementsByTagName("jal");
                                                NodeList jal1 = jal.item(0).getChildNodes();
                                                strXML = "<chart caption='Year Wise Revenue Collection Details of JAL'  xAxisName='Year' yAxisName='Paid Amount (in Lakhs)' bgcolor='#F0F0F0' showBorder='0' showFCMenuItem='0' formatNumberScale='2' numberSuffix='' Unitsanimation='" + animateChart + "' decimalPrecision='2' formatNumberScale='0'  rotatevalues='1' placevaluesinside='1' labelDisplay='Rotate' slantLabels='1' exportEnabled='1' exportAtClient='1' exportHandler='fcBatchExporter' bgcolor='FBFBFB' showToolTipShadow='1'  showAboutMenuItem='0'>";
                                                //System.out.println(jal1.item(1).getChildNodes().getLength());
                                                for (int i = 0; i < jal1.item(1).getChildNodes().getLength(); i = i + 1) {
                                                    paidamount = 0;
                                                    String y = "";
                                                    for (int j = 0; j < jal1.getLength(); j = j + 1) {
                                                        NodeList jalyear = jal1.item(j).getChildNodes();

                                                        Node year = jalyear.item(i);
                                                        Element element = (Element) year;
                                                        //System.out.println(element.getAttribute("value"));
                                                        y = element.getAttribute("name");
                                                        paidamount = paidamount + Float.parseFloat(element.getAttribute("value"));

                                                    }

                                                    strXML += "<set name='" + y + "' value='" + paidamount + "'/>";
                                                }
                                                strXML += "</chart>";

                                    %>
                                    <br class="clear"/>
                                    <jsp:include page="Includes/FusionChartsRenderer.jsp">
                                        <jsp:param name="chartSWF" value="../FusionCharts/Column3D.swf" />
                                        <jsp:param name="strURL" value="" />
                                        <jsp:param name="strXML" value="<%=strXML%>" />
                                        <jsp:param name="chartId" value="SectorWiseRevenueSum" />
                                        <jsp:param name="chartWidth" value="940" />
                                        <jsp:param name="chartHeight" value="430" />
                                        <jsp:param name="debugMode" value="false" />
                                        <jsp:param name="registerWithJS" value="true" />
                                    </jsp:include>
                                    <%

                                                strXML = "<chart caption='Yearly Revenue Collection Details of JAL with Division Wise breakups'showSum='1'   xAxisName='Year' yAxisName='Paid Amount (in Lakhs)' showBorder='0' bgcolor='#F0F0F0' formatNumberScale='2'  Unitsanimation='" + animateChart + "' decimalPrecision='0' formatNumberScale='0'  rotatevalues='0' placevaluesinside='1' labelDisplay='Rotate' slantLabels='1' exportEnabled='1' exportAtClient='1' exportHandler='fcBatchExporter'  bgcolor='FBFBFB' showToolTipShadow='1'  showAboutMenuItem='0'>";

                                                for (int j = 1; j < 2; j = j + 2) {
                                                    division = nl1.item(j).getNodeName().trim();
                                                    paidamount = 0;
                                                    if (nl1.item(j).hasChildNodes()) {
                                                        NodeList nl2 = nl1.item(j).getChildNodes();

                                                        for (int i = 1; i < 2; i = i + 2) {
                                                            sec = nl2.item(i).getNodeName().trim();
                                                            sec = sec.substring(4).toUpperCase();

                                                            if (nl2.item(i).hasChildNodes()) {
                                                                NodeList nl3 = nl2.item(i).getChildNodes();
                                                                strXML += "<categories> ";
                                                                for (int k = 1; k < nl3.getLength(); k = k + 2) {
                                                                    year = nl3.item(k).getNodeName().trim();

                                                                    year = year.substring(5);
                                                                    strXML += "<category label='" + year + "' />";

                                                                }
                                                                strXML += "</categories> ";
                                                            }
                                                        }
                                                    }


                                                }

                                                for (int j = 1; j < nl1.getLength(); j = j + 2) {
                                                    division = nl1.item(j).getNodeName().trim();
                                                    c_id = division.toUpperCase();
                                                    //strXML = "";
                                                    strXML += "<dataset seriesName='" + division.toUpperCase() + "' value='" + paidamount + "' showValues='0'>";
                                                    if (nl1.item(j).hasChildNodes()) {
                                                        NodeList nl2 = nl1.item(j).getChildNodes();

                                                        paidamount = 0;

                                                        for (int k = 1; k < nl2.item(1).getChildNodes().getLength(); k = k + 2) {
                                                            for (int i = 1; i < nl2.getLength(); i = i + 2) {
                                                                sec = nl2.item(i).getNodeName().trim();
                                                                sec = sec.substring(4).toUpperCase();
                                                                if (nl2.item(i).hasChildNodes()) {
                                                                    NodeList nl3 = nl2.item(i).getChildNodes();
                                                                    year = nl3.item(k).getNodeName().trim();

                                                                    year = year.substring(5);
                                                                    if (nl3.item(k).hasChildNodes()) {
                                                                        NodeList nl4 = nl3.item(k).getChildNodes();
                                                                        String f = nl4.item(5).getTextContent().trim();
                                                                        paidamount = paidamount + Float.parseFloat(f);
                                                                    }


                                                                }
                                                            }
                                                            paidamount = paidamount / 100000;
                                                            String s2 = paidamount + "";
                                                            strXML += "<set value='" + paidamount + "'  link = 'sectorchart.jsp?div=" + division + "' />";
                                                        }



                                                    }


                                                    strXML += "</dataset>";

                                                }
                                                strXML += "</chart>";
                                                //System.out.println(strXML);
                                                //Create the chart - Pie 3D Chart with data from strXML

                                                //Create the chart - Column 3D Chart with data from strXML variable using dataXML method
                                    %>
                                    <br class="clear"/>
                                    <jsp:include page="Includes/FusionChartsRenderer.jsp">
                                        <jsp:param name="chartSWF" value="../FusionCharts/StackedColumn3D.swf" />
                                        <jsp:param name="strURL" value="" />
                                        <jsp:param name="strXML" value="<%=strXML%>" />
                                        <jsp:param name="chartId" value="RevenueSum" />
                                        <jsp:param name="chartWidth" value="940" />
                                        <jsp:param name="chartHeight" value="430" />
                                        <jsp:param name="debugMode" value="false" />
                                        <jsp:param name="registerWithJS" value="true" />
                                    </jsp:include>

                                    <div style="text-align: center"> Please click to select the Division from above bar chart to view detailed data.</div>

                                    <script type="text/javascript">
                                        //Initialize Batch Exporter with DOM Id as fcBatchExporter
                                        var myExportComponent = new FusionChartsExportObject("fcBatchExporter", "../FusionCharts/FCExporter.swf");

                                        //Add the charts to queue. The charts are referred to by their DOM Id.
                                        myExportComponent.sourceCharts = ['SectorWiseRevenueSum','RevenueSum'];

                                        //------ Export Component Attributes ------//
                                        //Set the mode as full mode
                                        myExportComponent.componentAttributes.fullMode='1';
                                        //Set saving mode as both. This allows users to download individual charts/ as well as download all charts as a single file.
                                        myExportComponent.componentAttributes.saveMode='batch';

                                        //Default export format
                                        myExportComponent.componentAttributes.defaultExportFormat = 'pdf';
                                        //Do not show allowed export format drop-down
                                        myExportComponent.componentAttributes.showAllowedTypes = '1';

                                        //Default file name.
                                        myExportComponent.componentAttributes.defaultExportFileName = 'Revenue Chart';
                                        //Width and height
                                        myExportComponent.componentAttributes.width = '300';
                                        myExportComponent.componentAttributes.height = '60';
                                        //Title of button
                                        myExportComponent.componentAttributes.btnsavetitle = 'Save chart';
                                        myExportComponent.componentAttributes.btndisabledtitle = 'click on button';

                                        //Render the exporter SWF in our DIV fcexpDiv
                                        myExportComponent.Render("fcexpDiv");
                                    </script>

                                    <h3><a href="jal_year_chart.jsp">Please Click to View Year Wise Chart</a> </h3>

                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>

        </div>



        <!-- Footer Starts -->
        <jsp:include page="../../../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>
