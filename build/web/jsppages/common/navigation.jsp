<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.*"%>

<%!    int indexflag;
    int t = 0;
    int rateflag;
    int schemeflag;
    int formflag;
    int contactflag;
    int siteflag;
    int userflag;
    int adminflag;
    int serviceflag;
    int dbflag;
    int usflag;
    int contentflag;
    int infoflag;
    int pageflag;
    int consumerflag;
    int homeflag;
    String content_type;
    String con_title;
    String display;
    String priority;
    String content;
    String sql;
    PreparedStatement pst;
    ResultSet rs;
    Connection connection;
    String con_id;
    int crmflag;
    String class1 = "active";
    String class2 = "";
%>

<div id="canvas">
    <div id="header">
        <div class="inside">
            <div class="container">



                <div id="logo"><a href="<%=request.getContextPath()%>/index.jsp" title="noida_logo"><img src="<%=request.getContextPath()%>/resources/images/logo.png" alt="noida_logo"/></a> </div> <!-- #header #logo -->

                <div id="toolbar">

                    <%
                             
                                String userrole = (String) session.getAttribute("userrole");

                                if (userrole == null) {

                    %>
                    <div class="login">


                        <%
                                                            if (request.getAttribute("t1") != null) {

                                                                t = (Integer) request.getAttribute("t1");

                                                                if (t == 1) {
                        %>
                        <p class="errorcolor" style="margin-left:7px;"><label>Invalid Username or Password </label></p>
                        <%
                                                                                            t = (Integer) 0;

                                                                                        }
                                                                                    } else {
                        %>


                        <p style="margin-left:7px;"><label >Member Login</label></p>
                        <%                   }
                        %>

                        <form action="<%=request.getContextPath()%>/login.jsp" method="post"  >
                            <fieldset>

                                <input class="user" value="User Name" name="userid" id="userid" onclick="this.value=''" />

                                <input class="small" value="Password" name="password" id="password" title="Please fill Your password !" onfocus="this.type='password',this.value=''"  onclick="this.value=''" />
                                <button type="submit">Login</button>

                            </fieldset>
                        </form>
                    </div>

                    <%
                                }
                    %>



                    <%
                                if (userrole != null) {



                    %>
                    <div class="logout">
                        <%if (!userrole.equals("consumer")) {%>

                        <a href="<%=request.getContextPath()%>/jsppages/common/ch_pwd.jsp">Change Password</a>&nbsp;|&nbsp;
                        <%}%>
                        <a href="<%=request.getContextPath()%>/jsppages/common/logout.jsp">Logout</a> </div>
                    <br/>
                    <div class="wel">
                        <%
                                                            if (userrole.equalsIgnoreCase("consumer")) {
                        %>
                        Welcome <%=session.getAttribute("cons_nm")%>!
                        <%
                                                                                    } else {
                        %>
                        Welcome <%=session.getAttribute("username")%>!
                        <%
                                                            }
                        %> </div>
                        <%
                                    }
                        %>

                    <br class="clear" />
                </div>

            </div>
        </div> <!-- #header .container -->
    </div> <!-- #header .inside -->
</div> <!-- #header -->



<div id="menu">
    <div class="inside">
        <div class="container">
            <div class="leftcorners">
                <div class="rightcorners">
                    <div class="bg">
                        <ul>

                            <%
                                        try {
                                            InitialContext initialContext = new InitialContext();
                                            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                            connection = dataSource.getConnection();
                                            sql = "select con_id,con_title,position from jal_content where content_type='page'and (display='default' or display='home') order by priority";
                                            // con = (Connection) pageContext.getServletContext().getAttribute("con");
                                            pst = connection.prepareStatement(sql);
                                            rs = pst.executeQuery();
                                            List<String> totalList = new ArrayList<String>();

                                            String position;
                                            indexflag = 0;
                                            rateflag = 0;
                                            schemeflag = 0;
                                            contactflag = 0;
                                            formflag = 0;
                                            userflag = 0;
                                            adminflag = 0;
                                            serviceflag = 0;
                                            infoflag = 0;
                                            pageflag = 0;
                                            consumerflag = 0;
                                            homeflag = 0;
                                            crmflag = 0;
                                            String s = new String(request.getRequestURL());
                                            String s1 = s.substring(s.lastIndexOf("/") + 1);
                                            s = s.substring(0, s.lastIndexOf("/"));
                                            String searchstr = s.substring(s.lastIndexOf("/") + 1);



                                            if (searchstr.equals("common")) {
                                                if (s1.equals("home.jsp"));
                                                userflag = 1;
                                            } else if (searchstr.equals("sitepages")) {
                                                siteflag = 1;
                                            } else if (searchstr.equals("admin")) {
                                                userflag = 1;

                                            } else if (searchstr.equals("consumer")) {
                                                if (s1.equals("cons_details.jsp")) {
                                                    consumerflag = 1;
                                                }
                                            } else if (s1.equals("cons_detailslogin.jsp")) {
                                                consumerflag = 1;
                                            } else if (s1.equals("index.jsp") || s1.equals("")) {
                                                homeflag = 1;
                                            }




                                            if (siteflag == 1) {
                                                if (s1.equals("rate.jsp")) {
                                                    rateflag = 1;
                                                } else if (s1.equals("scheme.jsp")) {
                                                    infoflag = 1;
                                                } else if (s1.equals("services.jsp")) {
                                                    infoflag = 1;
                                                } else if (s1.equals("contact.jsp")) {
                                                    contactflag = 1;
                                                } else if (s1.equals("complaintForm.jsp")) {
                                                    contactflag = 1;
                                                } else if (s1.equals("downloads.jsp")) {
                                                    formflag = 1;
                                                } else if (s1.equals("news_list.jsp")) {
                                                    infoflag = 1;
                                                } else if (s1.equals("notices.jsp")) {
                                                    infoflag = 1;
                                                } else if (s1.equals("page.jsp")) {
                                                    pageflag = 1;
                                                }


                                            }


                                            if (userflag == 1) {
                                                if (s1.equals("admin.jsp")) {
                                                    adminflag = 1;
                                                } else if (s1.equals("viewcontent.jsp")) {
                                                    adminflag = 1;
                                                } else if (s1.equals("viewuploadfile.jsp")) {
                                                    adminflag = 1;
                                                } else if (s1.equals("view_complains.jsp")) {
                                                    adminflag = 1;
                                                    crmflag = 1;
                                                } else if (s1.equals("create_user.jsp")) {
                                                    adminflag = 1;
                                                } else if (s1.equals("view_user.jsp")) {
                                                    adminflag = 1;
                                                }
                                            }



                                            if (homeflag == 1) {

                            %>

                            <li class="active"><a href="<%=request.getContextPath()%>/index.jsp"  class="current">Home</a></li>
                            <%                            } else {
                            %>
                            <li ><a href="<%=request.getContextPath()%>/index.jsp"  class="current">Home</a></li>

                            <%}

                                                                        if (infoflag == 1) {
                            %>
                            <li class="boractive">   <a href="#" >News &amp; Events</a>
                                <%                              } else {
                                %>
                            <li class="bor">    <a href="#" >News &amp; Events</a>
                                <%          }

                                %>

                                <ul>
                                    <li class="first"><a href="<%=request.getContextPath()%>/jsppages/sitepages/news_list.jsp">News</a></li>
                                    <li><a href="<%=request.getContextPath()%>/jsppages/sitepages/events.jsp">Events</a></li>
                                    <li><a href="<%=request.getContextPath()%>/jsppages/sitepages/services.jsp">Services</a></li>
                                    <li><a href="<%=request.getContextPath()%>/jsppages/sitepages/scheme.jsp">Schemes</a></li>

                                    <%

                                                                                while (rs.next()) {
                                                                                    //System.out.println("yes get ............ content ..............");
                                                                                    con_id = rs.getString(1);
                                                                                    con_title = rs.getString(2);
                                                                                    position = rs.getString(3);
                                                                                    if (position != null && position.trim().equals("news")) {

                                                                                        if (pageflag == 1) {
                                    %>
                                    <li class="active" ><a href="<%=request.getContextPath()%>/jsppages/sitepages/page.jsp?con_id=<%=con_id%>"><%=con_title%></a></li>

                                    <%
                                                                                                                            } else {
                                    %>
                                    <li><a href="<%=request.getContextPath()%>/jsppages/sitepages/page.jsp?con_id=<%=con_id%>"><%=con_title%></a></li>
                                    <%
                                                                                        }
                                                                                    } else {
                                                                                    }
                                                                                }
                                    %>
                                </ul>
                            </li>

                            <%
                                                                        if (userrole == null || userrole.equals("admin") || userrole.equals("manager") || userrole.equals("crm")) {
                                                                            if (consumerflag == 1) {%>
                            <li class="boractive"><a href="#">Consumer</a>


                                <%                            } else {
                                %>

                            <li class="bor"><a href="<%=request.getContextPath()%>/cons_detailslogin.jsp">Consumer</a>

                                <%}

                                %>
                                <ul>

                                    <li class="first"> <a href="<%=request.getContextPath()%>/cons_detailslogin.jsp">Consumer Details</a></li>



                                    <%
                                                                    rs = pst.executeQuery();
                                                                    while (rs.next()) {
                                                                        con_id = rs.getString(1);
                                                                        con_title = rs.getString(2);
                                                                        position = rs.getString(3);
                                                                        if (position != null && position.trim().equalsIgnoreCase("consumer")) {
                                                                            // System.out.println("yes get one root content ..............");
                                                                            if (pageflag == 1) {
                                    %>
                                    <li class="active" ><a href="<%=request.getContextPath()%>/jsppages/sitepages/page.jsp?con_id=<%=con_id%>"><%=con_title%></a></li>

                                    <%
                                                                                      } else {
                                    %>
                                    <li><a href="<%=request.getContextPath()%>/jsppages/sitepages/page.jsp?con_id=<%=con_id%>"><%=con_title%></a></li>
                                    <%
                                                                            }
                                                                        }
                                                                    }

                                    %>

                                </ul>
                            </li>


                            <%   }
                                                                        if (userrole != null) {
                                                                            if (userrole.equals("crm")) {

                                                                                if (crmflag == 1) {
                            %>
                            <li class="active"><a href="<%=request.getContextPath()%>/jsppages/admin/view_complains.jsp?b=inbox">CRM</a>

                                <%
                                                                                                                } else {
                                %>
                            <li ><a href="<%=request.getContextPath()%>/jsppages/admin/view_complains.jsp?b=inbox">CRM</a>
                                <%
                                                                                                                }
                                %>

                            </li>

                            <%} else if (userrole.equals("admin")) {

                                                                                                            if (adminflag == 1) {
                            %>

                            <li class="boractive"><a href="#">Admin</a>
                                <%                                               } else {

                                %>
                            <li class="bor"><a href="#">Admin</a>
                                <%               }
                                %>
                                <ul>

                                    <li class="first"> <a href="<%=request.getContextPath()%>/jsppages/admin/admin.jsp">DashBoard</a></li>


                                    <li class="bo left1"><a href="#">Contents</a>
                                        <ul>
                                            <li class="first"><a href="<%=request.getContextPath()%>/jsppages/admin/viewcontent.jsp">Manage Contents</a></li>
                                            <li><a href="<%=request.getContextPath()%>/jsppages/admin/viewuploadfile.jsp">UploadedFiles</a></li>
                                            <li class="last"><a href="<%=request.getContextPath()%>/jsppages/admin/view_complains.jsp?b=inbox">Suggestions/Complaints</a></li>
                                        </ul>
                                    </li>
                                    <li class="bo left1 last"><a href="#">UserSettings</a>
                                        <ul>
                                            <li class="first"><a href="<%=request.getContextPath()%>/jsppages/admin/create_user.jsp">Create User</a></li>
                                            <li class="last"><a href="<%=request.getContextPath()%>/jsppages/admin/view_user.jsp">View User</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>


                            <%           } else if (userrole.equals("manager")) {
                            %>
                            <li class="bor"><a href="#">Manager</a>
                                <ul>
                                    <li class="first"> <a href="<%=request.getContextPath()%>/jsppages/manager/mgr_dashboard.jsp">DashBoard</a></li>
                                    <li class="bo left1"><a href="#">Reports</a>
                                        <ul>
                                            <li class="first"><a href="<%=request.getContextPath()%>/jsppages/manager/revenue_report.jsp">Revenue Report</a></li>
                                            <li class="last"><a href="<%=request.getContextPath()%>/jsppages/manager/cons_report.jsp">Consumer Report</a></li>
                                        </ul>
                                    </li>
                                    <li class="bo left1 last"><a href="#">Graphs</a>
                                        <ul>
                                            <li class="first"><a href="<%=request.getContextPath()%>/jsppages/charts/Code/JSP/jal_chart.jsp">Revenue Graph</a></li>
                                            <li class="last"><a href="<%=request.getContextPath()%>/jsppages/charts/Code/JSP/ConsumerChart.jsp">Consumer Graph</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <%
                                                                                                        } else if (userrole.equals("consumer")) {
                                                                                                            if (consumerflag == 1) {
                            %>

                            <li class="boractive"><a href="#">Consumer</a>


                                <%                            } else {
                                %>

                            <li class="bor"><a href="#">Consumer</a>
                                <%              }
                                %>
                                <ul>

                                    <li class="first"> <a href="<%=request.getContextPath()%>/jsppages/consumer/cons_details.jsp">Consumer Details</a></li>



                                </ul>
                            </li>

                            <%        }
                                                                        }



                                                                        rs = pst.executeQuery();
                                                                        List<String> plist = new ArrayList<String>();
                                                                        ResultSet rs2;
                                                                        rs = pst.executeQuery();
                                                                        while (rs.next()) {

                                                                            con_id = rs.getString(1);
                                                                            con_title = rs.getString(2);
                                                                            position = rs.getString(3);
                                                                            // System.out.println("yes get ............ content .............."+con_title);
                                                                            if (position.equalsIgnoreCase("root")) {
                                                                                plist.add(con_title);
                                                                                rs2 = connection.createStatement().executeQuery("select * from jal_content where position='" + con_title + "' and content_type='page'and (display='default' or display='home')");
                                                                                if (rs2.next()) {
                                                                                    //   System.out.println("class has been  changed for "+con_title);
                                                                                    class1 = "boractive";
                                                                                    class2 = "bor";
                                                                                } else {
                                                                                    // System.out.println("class has not been  changed for "+con_title);
                                                                                    class1 = "active";
                                                                                    class2 = "";
                                                                                }
                                                                                //  System.out.println("yes get one root content .............." + plist.size());
                                                                                if (pageflag == 1) {

                            %>
                            <li class="<%=class1%>" ><a href="<%=request.getContextPath()%>/jsppages/sitepages/page.jsp?con_id=<%=con_id%>"><%=con_title%></a>
                                <%
                                                                                                                } else {

                                %>
                            <li class="<%=class2%>" ><a href="<%=request.getContextPath()%>/jsppages/sitepages/page.jsp?con_id=<%=con_id%>"><%=con_title%></a>
                                <%
                                                                                                                        }%>
                                <ul><%
                                                                                                                for (int i = 0; i < plist.size(); i++) {
                                                                                                                    //System.out.println(" a  " + plist.get(i));
                                                                                                                    Statement statement = connection.createStatement();
                                                                                                                    ResultSet rs1 = statement.executeQuery(sql);
                                                                                                                    while (rs1.next()) {
                                                                                                                        if (plist.get(i).equals(rs1.getString("position"))) {
                                                                                                                            class1 = "boractive";
                                                                                                                            class2 = "bor";



                                    %>


                                    <li class="active" ><a href="<%=request.getContextPath()%>/jsppages/sitepages/page.jsp?con_id=<%=rs1.getString(1)%>"><%=rs1.getString(2)%></a></li>


                                    <%} else {
                                                                                                                                            class1 = "active";
                                                                                                                                            class2 = "";

                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                    plist.remove(i);
                                                                                                                                }%>
                                </ul>    </li><%     }
                                                                            }
                                %>

                            <%         Statement st = connection.createStatement();
                                                                        rs = st.executeQuery("select con_id,con_title,position from jal_content where position='download' and content_type='page'and (display='default' or display='home') order by priority");
                                                                        String cl1;
                                                                        String cl2;
                                                                        if (rs.next()) {
                                                                            cl1 = "boractive";
                                                                            cl2 = "bor";
                                                                        } else {
                                                                            cl1 = "active";
                                                                            cl2 = "";
                                                                        }
                                                                        if (formflag == 1) {


                            %>
                            <li id="downif"  class="<%=cl1%>"><a href="<%=request.getContextPath()%>/jsppages/sitepages/downloads.jsp">Downloads</a>
                                <%                            } else {
                                %>
                            <li id="downelse" class="<%= cl2%>"  ><a href="<%=request.getContextPath()%>/jsppages/sitepages/downloads.jsp">Downloads</a>
                                <%          }
                                %>
                                <ul>
                                    <%
                                                                                rs = pst.executeQuery();
                                                                                boolean test = false;
                                                                                while (rs.next()) {
                                                                                    //System.out.println("yes get ............ content ..............");
                                                                                    con_id = rs.getString(1);
                                                                                    con_title = rs.getString(2);
                                                                                    position = rs.getString(3);
                                                                                    if (position != null && position.trim().equals("download")) {
                                                                                        test = true;
                                                                                        // System.out.println("yes get one root content ..............");
                                                                                        if (pageflag == 1) {
                                    %>
                                    <li class="active" ><a href="<%=request.getContextPath()%>/jsppages/sitepages/page.jsp?con_id=<%=con_id%>"><%=con_title%></a></li>

                                    <%
                                                                                                                                                                                                            } else {
                                    %>
                                    <li ><a  href="<%=request.getContextPath()%>/jsppages/sitepages/page.jsp?con_id=<%=con_id%>"><%=con_title%></a></li>
                                    <%
                                                                                        }
                                                                                    } else {
                                                                                    }
                                                                                }
                                    %>

                                </ul>
                            </li>
                            <%

                                                                        if (contactflag == 1) {
                            %>
                            <li class="boractive">   <a href="#" >Contact Us </a>
                                <%                              } else {
                                %>
                            <li class="bor">    <a href="#" >Contact Us</a>
                                <%          }

                                %>

                                <ul>
                                    <li class="first"><a href="<%=request.getContextPath()%>/jsppages/sitepages/contact.jsp">Contact Details</a></li>
                                    <li><a href="<%=request.getContextPath()%>/jsppages/sitepages/complaintForm.jsp">Complaint Form</a></li>

                                    <%                              if (test == true) {
                                                                                }
                                                                                rs = pst.executeQuery();
                                                                                while (rs.next()) {
                                                                                    //System.out.println("yes get ............ content ..............");
                                                                                    con_id = rs.getString(1);
                                                                                    con_title = rs.getString(2);
                                                                                    position = rs.getString(3);
                                                                                    if (position != null && position.trim().equals("contact")) {
                                                                                        // System.out.println("yes get one root content ..............");
                                                                                        if (pageflag == 1) {
                                    %>
                                    <li class="active" ><a href="<%=request.getContextPath()%>/jsppages/sitepages/page.jsp?con_id=<%=con_id%>"><%=con_title%></a></li>

                                    <%
                                                                                                                                                                                                            } else {
                                    %>
                                    <li><a href="<%=request.getContextPath()%>/jsppages/sitepages/page.jsp?con_id=<%=con_id%>"><%=con_title%></a></li>
                                    <%
                                                                                        }
                                                                                    } else {
                                                                                    }
                                                                                }
                                    %>
                                </ul>
                            </li>
                            <%


                                        } catch (Exception ex) {
                                            ex.printStackTrace();
                                            System.out.println("Exception in navigation" + ex);
                                        } finally {
                                            connection.close();
                                        }
                            %>



                        </ul>
                    </div  > <!-- #menu .bg -->
                </div> <!-- #menu. rightcorners -->
            </div> <!-- #menu .leftcorners -->
        </div> <!-- #menu .container -->
    </div> <!-- #menu .inside -->
</div> <!-- #menu -->

