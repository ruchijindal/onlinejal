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
<%!    String strXML;
    Connection connection;
    String division, sector, year, sec;
    float paidamount;
    String xmlfile;
    String userrole;
    int t;

%>

<%
            request.getSession(false);
            request.setAttribute("t", t);

            userrole = (String) session.getAttribute("userrole");

%>

<%
            strXML = "";
            sector = request.getParameter("sec");
            division = (String) session.getAttribute("division");
            strXML += "<graph caption='Revenue Collection Details (Sector " + sector + ")' xAxisName='Year' yAxisName='Paid Amount (in Lakhs)' formatNumberScale='2' decimalPrecision='3' numberSuffix='Lakhs' bgcolor='#F0F0F0' rotatevalues='1' placevaluesinside='1' labelDisplay='Rotate' slantLabels='1' exportEnabled='1' exportAtClient='1' exportHandler='fcBatchExporter' showFCMenuItem='0' showToolTipShadow='1'>";
            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
            connection = dataSource.getConnection();
            //connection = (Connection) pageContext.getServletContext().getAttribute("con");


            String sql = "select xmlfile from reports_tab where report_type='revenue_report' order by update_dt desc";
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
                paidamount = 0;
                sec = nl2.item(i).getNodeName().trim();
                sec = sec.substring(4).toUpperCase();
                if (sec.equals(sector)) {
                  
                    if (nl2.item(i).hasChildNodes()) {
                        NodeList nl3 = nl2.item(i).getChildNodes();
                       
                        for (int k = 1; k < nl3.getLength(); k = k + 2) {
                            year = nl3.item(k).getNodeName().trim();
                            
                            year = year.substring(5);
                            if (nl3.item(k).hasChildNodes()) {
                                NodeList nl4 = nl3.item(k).getChildNodes();
                                String f = nl4.item(5).getTextContent().trim();
                                paidamount = Float.parseFloat(f) / 100000;
                                String s2 = paidamount + "";
                                strXML += "<set name='" + year + "' value='" + s2 + "'/>";
                            }
                        }
                    }
                }
            }
            connection.close();
            strXML += "</graph>";

            //Create the chart - Column 3D Chart with data from strXML variable using dataXML method

            //Just write out the XML data
            //NOTE THAT THIS PAGE DOESN'T CONTAIN ANY HTML TAG, WHATSOEVER
            response.setContentType("text/xml");
%>
<%=strXML%>