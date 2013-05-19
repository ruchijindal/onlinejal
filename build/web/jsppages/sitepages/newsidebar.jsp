<%-- 
    Document   : newsidebar
    Created on : 24 Jun, 2010, 1:16:30 PM
    Author     : smp03
--%>

<%@page import="com.smp.jal.ConvertToDate"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        
        <script src="../../resources/js/jquery.js" type="text/javascript"></script>
        <script src="../../resources/js/jquery_003.js" type="text/javascript"></script>

        <script type="text/javascript" src="../../resources/js/demo.js"></script>


      

        <div id="main">
            <% InitialContext initialContext = new InitialContext();
                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                        Connection con = dataSource.getConnection();
                        PreparedStatement preparedStatement = con.prepareStatement("select * from jal_content where content_type='news' order by con_date");
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
                          
                            //System.out.println(dateField[0]);
                        }
                        ConvertToDate convertToDate=new ConvertToDate();
                        //convertToDate.checkNewsMonth("2011", "03");
            %>

            <ul id="red" class="treeview-red treeview">
                <% while (endYear >= startYear) {      
      if(convertToDate.checkYear(String.valueOf(endYear),"news")){
    %>
   
                <li class="expandable"><div class="hitarea expandable-hitarea"></div><span class=""><%=endYear%></span>
                    <ul style="display: none;">
                        <%if(convertToDate.checkNewsMonth(String.valueOf(endYear), "01","news")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthnews.jsp?month=01&amp;year=<%=endYear%>">January</a></span></li>
                        <%} if(convertToDate.checkNewsMonth(String.valueOf(endYear), "02","news")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthnews.jsp?month=02&amp;year=<%=endYear%>">February</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "03","news")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthnews.jsp?month=03&amp;year=<%=endYear%>">March</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "04","news")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthnews.jsp?month=04&amp;year=<%=endYear%>">April</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "05","news")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthnews.jsp?month=05&amp;year=<%=endYear%>">May</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "06","news")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthnews.jsp?month=06&amp;year=<%=endYear%>">June</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "07","news")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthnews.jsp?month=07&amp;year=<%=endYear%>">July</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "08","news")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthnews.jsp?month=08&amp;year=<%=endYear%>">August</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "09","news")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthnews.jsp?month=09&amp;year=<%=endYear%>">September</a></span></li>
                        <%} if(convertToDate.checkNewsMonth(String.valueOf(endYear), "10","news")){%>
                        <li><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthnews.jsp?month=10&amp;year=<%=endYear%>">October</a></span></li>
                        <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "11","news")){%>
                       <li ><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthnews.jsp?month=11&amp;year=<%=endYear%>">November</a></span></li>
                       <%}  if(convertToDate.checkNewsMonth(String.valueOf(endYear), "12","news")){%>
                        <li ><span><img src="../../resources/images/new_news/n.png" alt="" /><a href="monthnews.jsp?month=12&amp;year=<%=endYear%>">December</a></span></li>
                        <%}%>
                      
                    </ul>

                </li>

                <% }endYear--;
            }
                        con.close();
        %>

            </ul>


        </div>
