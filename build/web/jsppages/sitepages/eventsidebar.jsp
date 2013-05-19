<%--
    Document   : newsidebar
    Created on : 24 Jun, 2010, 1:16:30 PM
    Author     : smp03
--%>

<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="com.smp.jal.ConvertToDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>




        <script src="../../resources/js/jquery.js" type="text/javascript"></script>
        <script src="../../resources/js/jquery_003.js" type="text/javascript"></script>

        <script type="text/javascript" src="../../resources/js/demo.js"></script>


        


        <div id="main">
              <% InitialContext initialContext = new InitialContext();
                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                        Connection con = dataSource.getConnection();
                        PreparedStatement preparedStatement = con.prepareStatement("select * from jal_content where content_type='notice' order by con_date");
                        ResultSet resultSet = preparedStatement.executeQuery();
                        int year = 0;
                        int startYear = 0;
                        int endYear = 0;
                        Date contentDate = new Date();
                        String dateField[] = new String[3];
                        while (resultSet.next()) {
                            contentDate = resultSet.getDate("con_date");
                            dateField = contentDate.toString().split("[-]");
                            if (year == 0) {
                                startYear = Integer.parseInt(dateField[0]);
                                year++;
                            }
                            endYear = Integer.parseInt(dateField[0]);
                            //System.out.println("Date is" +contentDate);
                        }
                        ConvertToDate convertToDate=new ConvertToDate();
                        
            %>

            <ul id="red" class="treeview-red treeview">
                <% while (endYear >= startYear) {

     if(convertToDate.checkYear(String.valueOf(endYear),"notice")){
    %>

                <li class="expandable"><div class="hitarea expandable-hitarea"></div><span class=""><%=endYear%></span>
                    <ul style="display: none;">
                        <%if(convertToDate.checkNewsMonth(String.valueOf(endYear), "01","notice")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=01&amp;year=<%=endYear%>">January</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "02","notice")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=02&amp;year=<%=endYear%>">February</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "03","notice")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=03&amp;year=<%=endYear%>">March</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "04","notice")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=04&amp;year=<%=endYear%>">April</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "05","notice")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=05&amp;year=<%=endYear%>">May</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "06","notice")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=06&amp;year=<%=endYear%>">June</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "07","notice")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=07&amp;year=<%=endYear%>">July</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "08","notice")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=08&amp;year=<%=endYear%>">August</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "09","notice")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=09&amp;year=<%=endYear%>">September</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "10","notice")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=10&amp;year=<%=endYear%>">October</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "11","notice")){%>
                       <li ><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=11&amp;year=<%=endYear%>">November</a></span></li>
                       <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "12","notice")){%>
                        <li ><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=12&amp;year=<%=endYear%>">December</a></span></li>
                        <%}%>

                    </ul>

                </li>

                <% }endYear--;
            }
                        con.close();
            %>

            </ul>

<!--            <ul id="red" class="treeview-red treeview">


                <li class="expandable"><div class="hitarea expandable-hitarea"></div><span class="">2010</span>
                    <ul style="display: none;">
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=01&year=2010">January</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=02&year=2010">February</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=03&year=2010">March</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=04&year=2010">April</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=05&year=2010">May</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=06&year=2010">June</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=07&year=2010">July</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=08&year=2010">August</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=09&year=2010">September</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=10&year=2010">October</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=11&year=2010">November</a></span></li>
                        <li class="last"><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthevents.jsp?month=12&year=2010">December</a></span></li>
                    </ul>

                </li>
                <li class="expandable lastExpandable"><div class="hitarea expandable-hitarea lastExpandable-hitarea "></div><span class="">2011</span>
                    <ul style="display: none;">
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="#jan">January</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="#feb">February</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="#mar">March</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="#apr">April</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="#may">May</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="#june">June</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="#july">July</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="#aug">August</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="#sep">September</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="#oct">October</a></span></li>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="#nov">November</a></span></li>
                        <li class="last"><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="#dec">December</a></span></li>
                    </ul>
                </li>


            </ul>-->


        </div>

    