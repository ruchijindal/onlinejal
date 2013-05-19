<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%@page  import="java.io.*,javax.xml.parsers.*,org.xml.sax.*,org.w3c.dom.NodeList;"%>
<%@ page import ="com.fusioncharts.FusionChartsHelper"%>
<% // We have imported the above file for using encodeDataURL method
%>


<%!    Connection connection;
    String dt1, dt2;
    String division, year2, sec, year;
    String[] s;
    String strDataURL;
    String strXML, xmlfile;
    int consumer;
    String userrole;
    int t;
%>

<%
            request.getSession(false);
            request.setAttribute("t", t);

            userrole = (String) session.getAttribute("userrole");

%>

<%
            division = request.getParameter("div");

            //Database Objects - Initialization
            //strXML will be used to store the entire XML document generated
            String strXML = "";

            //Generate the chart element
            strXML = "<chart caption='Consumer Details for " + division.toUpperCase() + "'  pieSliceDepth='10' showBorder='' formatNumberScale='2' decimalPrecision='3' bgcolor='#F0F0F0' exportEnabled='1' exportAtClient='1' exportHandler='fcBatchExporter' showFCMenuItem='0' showToolTipShadow='1'>";

            //year2 = request.getParameter("year2");
            //year1="1990";
            //year2="2010";
             InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                connection = dataSource.getConnection();

            //connection = (Connection) pageContext.getServletContext().getAttribute("con");


            String sql = "select xmlfile from reports_tab where report_type='totcons_report' order by update_dt desc";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                xmlfile = rs.getString(1);
            }
           
            DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
            org.w3c.dom.Document docxml = docBuilder.parse(new InputSource(new StringReader(xmlfile)));
            NodeList nl1 = docxml.getElementsByTagName(division);
            NodeList nl2 = nl1.item(0).getChildNodes();
            for (int i = 1; i < nl2.getLength(); i = i + 2) {
                consumer = 0;
                sec = nl2.item(i).getNodeName().trim();
                sec = sec.substring(4).toUpperCase();
               
                if (nl2.item(i).hasChildNodes()) {
                    NodeList nl3 = nl2.item(i).getChildNodes();
                    String f = nl3.item(1).getTextContent().trim();
                    consumer = consumer + Integer.parseInt(f);
                }
                String s2 = consumer + "";
                strXML += "<set label='Sector" + sec + "' value='" + s2 + "'/>";
            }

            connection.close();
            strXML += "</chart>";
            response.setContentType("text/xml");

%>
<%=strXML%>
