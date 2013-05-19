<%-- 
    Document   : cons_bill
    Created on : Aug 16, 2011, 5:04:31 PM
    Author     : smp
--%>




<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="bill.generator.BillDescription"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!    int t;
    String division;
    String sector;
    String sql;
    Connection con;
    String cons_no;
    String cons_nm1;
    String blk_no;
    String flat_type;
    String flat_no;
    String cons_ctg;
    int x;
    String sec;
    String conCategory;
    Locale India=new Locale("en","IN");
NumberFormat inFormat =NumberFormat.getCurrencyInstance(India);

DecimalFormat def = new DecimalFormat("0.00");
public String showAmmount(Double ammount)
        {
String s;
s=inFormat.format(ammount);
s=s.substring(3);
    return s; 
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>Noida Jal Board : Consumer Details</title>
        <jsp:include page="../common/header.jsp"/>

        <script type='text/javascript' src='../../resources/jquery/jquery.simplemodal.js'></script>
        <script type='text/javascript' src='../../resources/jquery/basic.js'></script>


    </head>

    <%

                request.getSession(false);
                request.setAttribute("t", t);
                String userrole = (String) session.getAttribute("userrole");
inFormat.setMaximumFractionDigits(2);

    %>
    <body>
        <!-- Menu Starts -->
        <jsp:include page="../common/navigation.jsp"/>


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
                        </div>
                        <div class="inactive">
                            <a href="../consumer/cons_details.jsp" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Consumer
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                        <div class="inactive">
                            <a href="cons_details.jsp" title="consumerdetails">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Consumer Details
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->
                        <div class="active">
                            <a href="#" title="consumerdetails">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Bill Details
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
                        <h2>Bill Detail   </h2>                      

                        <%
                                    BillDescription billDescription = new BillDescription();
                                    try {
                                        billDescription = (BillDescription) session.getAttribute("billDescription");
                                        Calendar from = Calendar.getInstance();
                                        from.setTime(billDescription.getBillFrom());

                                        Calendar to = Calendar.getInstance();
                                        to.setTime(billDescription.getBillTo());
                                        double billAmount = ((to.get(Calendar.YEAR) - from.get(Calendar.YEAR)) * 12 - (from.get(Calendar.MONTH) - to.get(Calendar.MONTH)) + 1) * billDescription.getRate();
                                        division = (String) session.getAttribute("div");
                                        cons_no = request.getParameter("consno");
                                        //
                                        DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
                                        String date_to = (String) session.getAttribute("to_date11");
                                        Calendar calendar = Calendar.getInstance();
                                        calendar.set(calendar.get(calendar.YEAR), calendar.APRIL, 1);
                                        String date_from = df.format(calendar.getTime());
                                        //    System.out.println("date from is "+date_from);
                                        if (cons_no != null && !cons_no.equals("")) {
                                            int l = (int) cons_no.charAt(7);
                                            if (l >= 65 && l <= 90) {
                                                x = Integer.parseInt(cons_no.substring(0, 2));
                                            } else {
                                                x = Integer.parseInt(cons_no.substring(0, 3));
                                            }
                                            sec = Integer.toString(x);
                                            if (x < 10) {
                                                sec = Integer.toString(x);
                                                sec = "0" + sec;
                                            }
                                        }

                                        SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");

                                        char number = division.charAt((division.length() - 1));
                                        sector = "MASTER" + number;
                                        InitialContext initialContext = new InitialContext();
                                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                        con = dataSource.getConnection();
                                        sql = "select cons_nm1,con_tp,cons_ctg,flat_type,flat_no,blk_no from " + sector + " where trim(cons_no)=?";
                                        PreparedStatement pst = con.prepareStatement(sql);
                                        pst.setString(1, cons_no);
                                        ResultSet rs = pst.executeQuery();

                        %>
                        <div id="table-blk" class="full" >
                            <table>
                                <%

                                                                        if (rs.next()) {
                                                                            cons_nm1 = rs.getString(1);
                                                                            //   con_tp = rs.getString(2);
                                                                            cons_ctg = rs.getString(3);
                                                                            flat_type = rs.getString(4);
                                                                            flat_no = rs.getString(5);
                                                                            blk_no = rs.getString(6);
                                                                            if (blk_no == null) {
                                                                                blk_no = "-";
                                                                            }
                                                                        }

                                %>

                                <tr>
                                    <th class="bold ">Consumer No.</th>
                                    <th class="n"><%=cons_no%> </th>
                                    <th class="bold1">Due Date</th>
                                    <th class="nm"><%=formatter.format(billDescription.getDueDate())%></th>

                                </tr>
                                <tr>
                                    <th class="bold">Consumer Name</th>
                                    <th class="n"><%=cons_nm1%> </th>
                                    <th class="bold1">Flat Type</th>
                                    <th class="nm"> <%=flat_type%></th>
                                </tr>
                                <tr>
                                    <th class="bold">Sector</th>
                                    <th class="n"><%=sec%></th>
                                    <th class="bold1">Category</th>
                                    <th class="nm"> <%if (cons_ctg.equalsIgnoreCase("R")) {
                                                                                conCategory = "Regular";
                                                                            } else if (cons_ctg.equalsIgnoreCase("T")) {
                                                                                conCategory = "Temporary";
                                                                            }

                                        %><%=conCategory%></th>
                                </tr>
                                <tr>
                                    <th class="bold">Block</th>
                                    <th class="n"><%=blk_no%> </th>
                                    <th class="bold1" >Bill Period From</th>
                                    <th class="nm"><%=formatter.format(billDescription.getBillFrom())%> </th>
                                </tr>
                                <tr>
                                    <th class="bold">Flat Number</th>
                                    <th class="n"><%=flat_no%> </th>
                                    <th class="bold1">Bill Period To</th>
                                    <th class="nm"><%=formatter.format(billDescription.getBillTo())%> </th>

                                </tr>


                            </table>


                            <h2></h2>


                            <table>





                                <tr>
                                    <th class="bold ">Min Charges Per Month(Rs.)</th>
                                    <th class="n"> <%=def.format(billDescription.getRate())%></th>
                                    <th class="bold"></th>
                                    <th class="nm"><%=showAmmount(billAmount)%></th>
<!--                                    <th class="nm"></th>-->

                                </tr>
                                <tr>
                                    <th class="bold">Rebate</th>
                                    <th class="n"><%= def.format((billDescription.getRebate() * ((to.get(Calendar.YEAR) - from.get(Calendar.YEAR)) * 12 - (from.get(Calendar.MONTH) - to.get(Calendar.MONTH)) + 1)) / billAmount)%>%</th>
                                    <th class="bold"> </th>
                                    <th class="nm"><%=showAmmount(billDescription.getRebate())%> </th>
                                </tr>
                                <tr>
                                    <th class="bold">Discount</th>
                                    <th class="n"><%= def.format(billDescription.getDiscount())%>%</th>
                                    <th class="bold"> </th>
                                    <th class="nm"><%=showAmmount((billDescription.getDiscount() * billDescription.getInterest()) / 100)%> </th>
                                </tr>
                                <tr>
                                    <th class="bold">Cess Amount</th>
                                    <th class="n"></th>
                                    <th class="bold"> </th>
                                    <th class="nm"> <%=showAmmount(billDescription.getCessAmount())%></th>
                                </tr>
                                <tr>
                                    <th class="bold">Arrear Principle Amount Upto</th>
                                    <th class="n"><%=formatter.format(billDescription.getBillTo())%></th>
                                    <th class="bold" > </th>
                                    <th class="nm"> <%= showAmmount((billDescription.getPrincipal()))%></th>
                                </tr>
                                <tr>
                                    <th class="bold">Interest Amount upto</th>
                                    <th class="n"><%=formatter.format(billDescription.getDueDate())%></th>
                                    <th class="bold"> </th>
                                    <th class="nm"><%=def.format(billDescription.getInterest())%> </th>

                                </tr>


                            </table>
                            <br/>

                            <h2></h2>
                            <%
Double Bill1 = billDescription.getPrincipal() + billDescription.getInterest() + billDescription.getCessAmount() - billDescription.getRebate() - billDescription.getDiscount();
long  Bill=Math.round(Bill1);
NumberFormat iFormat =NumberFormat.getCurrencyInstance(India);

//DecimalFormat def = new DecimalFormat("0.00");
String s=iFormat.format(Bill);
int i=s.indexOf(".");
 System.out.println("mohit formate-->"+ s);
s=s.substring(i+1);
    System.out.println("mohit formate-->"+ s+i);


                            %>
                            <table>
                                  
                                <tr>
                                    <th class="bold">Amount to be Paid</th>
                                    <th style="padding-left: 700px; text-align: right"   class="n"><img style=" margin-top: 3px; margin-left: 30px"   src="<%=request.getContextPath()%>/resources/images/Rupee1.png" alt="Rs."/><b><%= s %></b></th>
                                </tr>
                            </table>
                            <h2></h2>

                        </div>
                        <%} catch (Exception e) {
                                        e.printStackTrace();
                                    }%>
                        <br class="clear"/>
                        <br class="clear"/>
                        <div class="buttons">

                            <a href="<%= request.getContextPath()%>/GeneratePdf?div=<%=division%>&amp;cons_no=<%=cons_no%>" class="basic">
                                <button class="submit  bill1" type="button" value="Submit"   title="Pay Bill">
                                    <span class="leftcorners">
                                        <span class="rightcorners">
                                            <span class="bg">
                                    			Get Challan
                                            </span>
                                        </span>
                                    </span>
                                </button>
                            </a>
                        </div>

                        <div class="buttons">

                            <a href="../../consumerBillDetail" class="basic">
                                <button class="submit  bill" type="button" value="Submit"   title="Pay Bill">
                                    <span class="leftcorners">
                                        <span class="rightcorners">
                                            <span class="bg">
                                    			Pay Bill
                                            </span>
                                        </span>
                                    </span>
                                </button>
                            </a>
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
