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
    int consumer;
    String xmlfile;
    String update_dt;
    String userrole;
    int t;
%>
<html>
    

        <head> <title>Noida Jal Board : Sector Wise Chart</title>
            <jsp:include page="../../../common/header.jsp"/>
        <meta http-equiv="content-type" content="text/html;charset=utf-8" />
        <meta http-equiv="Content-Style-Type" content="text/css" />

        <link rel="stylesheet" type="text/css" href="../../../../resources/css/style1.css" />

        <script  type="text/javascript" src="../FusionCharts/FusionCharts.js"></script>

        <script  type="text/javascript" src="../FusionCharts/FusionChartsExportComponent.js"></script>

        <script type="text/javascript">


            function updateChart(factoryIndex){
                //DataURL for the chart
                var strURL = "cons_sector.jsp?div="+factoryIndex;

                //URLEncode it - NECESSARY.
                strURL = escape(strURL);

                //Get reference to chart object using Dom ID "ConsumerDetailed"
                var chartObj = getChartFromId("ConsumerDetailed");
                //Send request for XML
                chartObj.setDataURL(strURL);
            }

            function getTimeForURL(){
                var dt = new Date();
                var strOutput = "";
                strOutput = dt.getHours() + "_" + dt.getMinutes() + "_" + dt.getSeconds() + "_" + dt.getMilliseconds();
                return strOutput;
            }

            function startExport(){
                myExportComponent.BeginExport();
            }
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
                                            Consumer Graph
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
                                <div id="table-blk" class="full">
                                    <%
                                                try {
                                                    InitialContext initialContext = new InitialContext();
                                                    DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                    connection = dataSource.getConnection();
                                                    // connection = (Connection) pageContext.getServletContext().getAttribute("con");


                                                    String sql = "select xmlfile,to_char(update_dt,'dd-Mon-yyyy') from reports_tab where report_type='totcons_report' order by update_dt desc";
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
                                    %>

                                    <h2>Consumer Chart for JAL</h2>
                                    <div class="buttons">

                                        <button class="submit chart" type="button" value="Submit" title="Save Chart"   onclick="javascript:startExport();">
                                            <span class="leftcorners">
                                                <span class="rightcorners">
                                                    <span class="bg">
                                    			Export Chart
                                                    </span>
                                                </span>
                                            </span>
                                        </button>
                                    </div>
                                    <div id="chart">
                                        <div id="fcexpDiv" ></div>
                                    </div>

                                    <h4>As on <%=update_dt%></h4>
                                    
                                        <%
                                                    String animateChart = null;
                                                    animateChart = request.getParameter("animate");
                                                    //Set default value of 1
                                                    if (null == animateChart || animateChart.equals("")) {
                                                        animateChart = "1";
                                                    }
                                                    String strXML = "";
                                                    strXML = "<chart caption='Consumer Details for JAL '  pieSliceDepth='10' showBorder='0' formatNumberScale='0' Unitsanimation='" + animateChart + "' decimalPrecision='3' formatNumberScale='2' bgcolor='#F0F0F0' exportEnabled='1' exportAtClient='1' exportHandler='fcBatchExporter' showFCMenuItem='0' showToolTipShadow='1' showAboutMenuItem='0'>";




                                                    DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
                                                    DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
                                                    org.w3c.dom.Document docxml = docBuilder.parse(new InputSource(new StringReader(xmlfile)));
                                                    NodeList nl = docxml.getElementsByTagName("cons_details");
                                                    NodeList nl1 = nl.item(0).getChildNodes();
                                                    for (int j = 1; j < nl1.getLength(); j = j + 2) {
                                                        division = nl1.item(j).getNodeName().trim();
                                                        consumer = 0;
                                                        if (nl1.item(j).hasChildNodes()) {
                                                            NodeList nl2 = nl1.item(j).getChildNodes();

                                                            for (int i = 1; i < nl2.getLength(); i = i + 2) {
                                                                sec = nl2.item(i).getNodeName().trim();
                                                                sec = sec.substring(4).toUpperCase();

                                                                if (nl2.item(i).hasChildNodes()) {
                                                                    NodeList nl3 = nl2.item(i).getChildNodes();
                                                                    String f = nl3.item(1).getTextContent().trim();
                                                                    consumer = consumer + Integer.parseInt(f);
                                                                }
                                                            }
                                                        }
                                                        String s2 = consumer + "";
                                                        strXML += "<set label='" + division.toUpperCase() + "' value='" + s2 + "' link='javaScript:updateChart(&quot;" + division + "&quot;)'/>";

                                                    }




                                                    strXML += "</chart>";
                                                    //Create the chart - Pie 3D Chart with data from strXML
%>
<br class="clear"/>  <jsp:include page="Includes/FusionChartsRenderer.jsp" flush="true">
                                            <jsp:param name="chartSWF" value="../FusionCharts/Pie3D.swf" />
                                            <jsp:param name="strURL" value="" />
                                            <jsp:param name="strXML" value="<%=strXML%>" />
                                            <jsp:param name="chartId" value="ConsumerSum" />
                                            <jsp:param name="chartWidth" value="940" />
                                            <jsp:param name="chartHeight" value="500" />
                                            <jsp:param name="debugMode" value="false" />
                                            <jsp:param name="registerWithJS" value="true" />
                                        </jsp:include>


                                        <script type="text/javascript">
                                            //Initialize Batch Exporter with DOM Id as fcBatchExporter
                                            var myExportComponent = new FusionChartsExportObject("fcBatchExporter", "../FusionCharts/FCExporter.swf");

                                            //Add the charts to queue. The charts are referred to by their DOM Id.
                                            myExportComponent.sourceCharts = ['ConsumerSum','ConsumerDetailed'];

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
                                            myExportComponent.componentAttributes.defaultExportFileName = 'Consumer Chart';
                                            //Width and height
                                            myExportComponent.componentAttributes.width = '300';
                                            myExportComponent.componentAttributes.height = '60';
                                            //Title of button
                                            myExportComponent.componentAttributes.btnsavetitle = 'Save chart';
                                            myExportComponent.componentAttributes.btndisabledtitle = 'click on button';

                                            //Render the exporter SWF in our DIV fcexpDiv
                                            myExportComponent.Render("fcexpDiv");
                                        </script>


                                        <%
                                                    //Column 2D Chart with changed "No data to display" message
                                                    //We initialize the chart with <chart></chart>
%>
            <br class="clear"/>                            <jsp:include page="Includes/FusionChartsRenderer.jsp" flush="true">
                                            <jsp:param name="chartSWF" value="../FusionCharts/Pie3D.swf?ChartNoDataText=Please select a Division from pie chart above to view detailed data." />
                                            <jsp:param name="strURL" value="" />
                                            <jsp:param name="strXML" value="<chart></chart>" />
                                            <jsp:param name="chartId" value="ConsumerDetailed" />
                                            <jsp:param name="chartWidth" value="940" />
                                            <jsp:param name="chartHeight" value="430" />
                                            <jsp:param name="debugMode" value="false" />
                                            <jsp:param name="registerWithJS" value="true" />
                                        </jsp:include>

                                        <br></br>
                                        <br></br>
                                   
                                </div></div></div></div></div></div></div>               <jsp:include page="../../../common/footer.jsp"/>
    </body>
</html>
