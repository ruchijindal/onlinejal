<%@page import="reportservlet.ConsumerDet"%>
<%@page import="reportservlet.RevenueReport"%>
<%@page import="java.sql.*;"%>

<%
            try {
              //  System.out.println("yahooooooooooooooooooooooooooooooooooooo");
                //request.getRequestDispatcher("CancelRevenueReport").forward(request, response);
                RevenueReport.MyPdf pdf;
                ConsumerDet.MyPdf pdf1;
                Object o;
                int del = 0;
                if (session.getAttribute("del") != null) {
                    del = (Integer) session.getAttribute("del");
                } else {
                    del = 0;
                }
                if (del == 0) {
                    o = session.getAttribute("myPdf");
                    if (o != null) {
                        pdf = (RevenueReport.MyPdf) o;
                        pdf.done(true);
                        //t.destroy();
                        session.removeAttribute("myPdf");

                    }
                } else {

                    o = session.getAttribute("myPdf");
                    if (o != null) {
                        pdf1 = (ConsumerDet.MyPdf) o;
                        pdf1.done(true);
                        //t.destroy();
                        session.removeAttribute("myPdf");
                    }
                }
                session.removeAttribute("del");
                session.removeAttribute("userid");
                session.removeAttribute("userrole");
                request.getSession().invalidate();
                 System.out.println(request.getContextPath());
                response.sendRedirect(request.getContextPath());

            } catch (Exception ex) {
                session.removeAttribute("userid");
                session.removeAttribute("userrole");
                request.getSession().invalidate();
                response.sendRedirect("index.jsp");
            }
%>