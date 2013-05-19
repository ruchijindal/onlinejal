<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<!-- Footer Starts -->
<div id="footer">
    <div class="inside">
        <div class="container">
            <div class="left">
                <ul>
                    <li class="first">Copyright &copy; 2011 Developed for NOIDAJAL by &nbsp;<a href="http://smptechnologies.org/">SMP Technologies Pvt Ltd</a></li>
                </ul>
            </div> <!-- #footer .left -->
            <div class="right">
                    <% InitialContext initialContext = new InitialContext();
                            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                            Connection conn = dataSource.getConnection();
                            Statement stmt = conn.createStatement();
                            ResultSet resultSet = stmt.executeQuery("select * from hit_counter");
                            int count = 0;
                            while (resultSet.next()) {
                                count = resultSet.getInt("count");
                            }
                               conn.close(); %>
                <ul>
                    <li>Visitors - <label><%=count%></label>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/jsppages/sitepages/disclaimer.jsp">Disclaimer</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/jsppages/sitepages/sitemap.jsp">Sitemap</a>
                       

                    </li>
                    <li class="last"><a href="#canvas" class="scroll" title="Top">Top</a> &uArr;</li>
                </ul>
            </div> <!-- #footer .right -->
        </div> <!-- #footer .container -->
    </div> <!-- #footer .inside -->
    <script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-5155848-3']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
</div> <!-- #footer -->



