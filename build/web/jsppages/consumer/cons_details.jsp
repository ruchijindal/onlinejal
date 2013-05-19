<%@page import="java.text.NumberFormat"%>
<%@page import="bill.generator.BillUtility"%>
<%@page import="bill.generator.BillingManager"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="bill.generator.LedgerCalculation"%>
<%@page import="com.smp.jal.SelectSec_Div"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);

%>

<%@ page language="java" import="java.util.*,java.io.*,java.sql.*,java.net.URLEncoder,javax.servlet.*" pageEncoding="ISO-8859-1"%>
<%!    String sql;
    Connection con;
    String cons_no;
    String row_id;
    String sector;
    String cons_nm1;
    String con_tp;
    String cons_ctg;
    String flat_type;
    String flat_no;
    String blk_no;
    double plot_size;
    int pipe_size;
    String reg_no;
    String conn_dt;
    String esti_no;
    double esti_amt;
    double secu;
    String esti_dt;
    double esti1_amt;
    double nodue_amt;
    String nodue_dt;
    String trans_nm;
    String trf;
    String bl_per_fr;
    String bl_per_to;
    String due_dt;
    double bill_amt;
    double surcharge;
    double paid_amt;
    String pay_date;
    double arrear;
    double credit;
    String recp_no;
    String dis_cd;
    double noc;
    double t_fee;
    String bnk_cd;
    String br_nm;
    String userrole;
    String sess;
    String sec;
    int i;
    int t;
    int x;
    int empty;
    Integer t8;
    String division;
    String path;
    File delfile;
    String xmlpath;
    DocumentBuilderFactory dbf = null;
    DocumentBuilder db = null;
    org.w3c.dom.Document docxml = null;
    boolean genbill = false;
     DecimalFormat def = new DecimalFormat("0.00");
      Locale India=new Locale("en","IN");
NumberFormat inFormat =NumberFormat.getCurrencyInstance(India);
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

        <script type="text/javascript">


            function delLedger()
            {
                document.location.href="delLedger.jsp";
            }


            //        function callGetLedger()
            //        {
            //            i=0;
            //            alert("hiiii");
            //            alert("hiiii");
            //            cons_no= document.getElementById("cons_no").value
            //
            //            sec= document.getElementById("sec").value;
            //            division= document.getElementById("division").value;
            //
            //            xmlHttp=GetXmlHttpObject();
            //
            //            if (xmlHttp==null)
            //            {
            //                alert ("Browser does not support HTTP Request")
            //                return
            //            }
            //            var url="/OnlineJal/GetLedger";
            //
            //            url=url+"?cons_no="+cons_no+"&amp;sec="+sec+"&amp;division="+division;
            //
            //            xmlHttp.open("GET",url,true);
            //            xmlHttp.send(null);
            //             alert( arrear);
            //            xmlHttp.onreadystatechange=function()
            //            {
            //                cons_no=null;
            //                path=null;
            //
            //                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
            //                {
            //
            //                    var showdata = xmlHttp.responseText;
            //                    str=showdata.split(":");
            //                    bl_pr_to=str[0];
            //                    principal=str[1];
            //                    interest=str[2];
            //                    arrear=str[3];
            //                    alert("arrear"+arrear);
            //                    document.getElementById('arear').value=arrear;
            ////                    if(cons_no!=null && path!=null)
            ////                    {
            ////                        document.getElementById("pdf").style.visibility="visible";
            ////                        document.getElementById("processing").style.visibility="hidden";
            ////                        i=1;
            ////                    }
            ////                    if(i!=1)
            ////                        setTimeout("callGetLedger()", 5000);
            //                }else
            //                {
            //                    document.getElementById("processing").style.visibility="visible";
            //                    document.getElementById("pdf").style.visibility="hidden";
            //                     alert("arrear"+arrear);
            //                }
            //
            //            }
            //
            //        }
            //
            //
            //        function GetXmlHttpObject()
            //        {
            //            var xmlHttp=null;
            //            try
            //            {
            //                // Firefox, Opera 8.0+, Safari
            //                xmlHttp=new XMLHttpRequest();
            //            }
            //            catch (e)
            //            {
            //                //Internet Explorer
            //                try
            //                {
            //                    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
            //                }
            //                catch (e)
            //                {
            //                    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
            //                }
            //            }
            //            return xmlHttp;
            //        }
            function wait()
            {
                var dd = document.getElementById("billcycle").selectedIndex; 
               
                if(dd!=0)
                {
                    document.getElementById("lab1").style.display="none"
                    document.getElementById("button11").style.display="none";
                    document.getElementById("mailwait").style.display="inline";
                }
               
               
            }
             
        </script>
    </head>
    <%
                request.getSession(false);
                request.setAttribute("t", t);
                userrole = (String) session.getAttribute("userrole");
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

                        <div class="active">
                            <a href="#" title="consumerdetails">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Consumer Details
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
                    <div id="contentrail" class="full"   >

                        <%
                        System.out.println("mohit is comming");
                        String gen = request.getParameter("gen");
                                    int ii;
                                    if (gen == null) {
                                        //  System.out.println("gen is not nulllllllllllllll");
                                        genbill = false;
                                    } else {
                                        //  System.out.println("gen issssssssss  nulllllllllllllll");
                                        if (gen.equals("1")) {
                                            genbill = true;
                                        } else {
                                            genbill = false;
                                        }
                                    }

                                    try {
                                        String userid = (String) session.getAttribute("userid");
                                        cons_no = (String) session.getAttribute("userid");
                                        session.setAttribute("cons_no", cons_no);
                                        path = this.getServletContext().getRealPath("") + "/resources/ledger/" + cons_no + ".xml";  // get path on the server
                                        delfile = new File(path);
                                        if (delfile.exists()) {
                                            delfile.delete();
                                            response.sendRedirect("cons_details.jsp?cons_no=" + cons_no);
                                        }



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

                                        dbf = DocumentBuilderFactory.newInstance();
                                        db = dbf.newDocumentBuilder();
                                        xmlpath = getServletContext().getRealPath("") + "/resources/jalutilXML/" + "jal.xml";
                                        docxml = db.parse(xmlpath);
                                        SelectSec_Div sec_Div = new SelectSec_Div();
                                        division = sec_Div.getDevision(sec, docxml);
                                        Calendar billdate = Calendar.getInstance();
                                        System.out.print("division1======> " + division + cons_no + billdate);
                                        BillingManager billingManager = new BillingManager(division, cons_no, billdate, billdate);

                                        Thread billThread = new Thread(billingManager);
                                        //  System.out.println("value of gen bin isssssssssss " + genbill);
                                        double rate = billingManager.getRateByConsumerNo(cons_no, division);
                                        java.util.Calendar calendar = Calendar.getInstance();
                                        calendar.setTime(new java.util.Date());
                                        int billcycle = new BillUtility().getBillCycle(rate, calendar);
                                           System.out.println("Bill cycle "+billcycle);
                                        int bmonth = (12 / billcycle) + 3;
                                        System.out.println("bmonth "+bmonth);
                                        while (bmonth > 12) {
                                            bmonth = bmonth - 12;
                                        }
                                        int days = 0;
                                        List<java.util.Date> billcycleList = new ArrayList<java.util.Date>();
                                        int temp = billcycle;

                                        while (temp != 0) {
                                            System.out.println("rate is       " + rate + " bill cycle " + billcycle + "month are " + bmonth + " year is " + calendar.get(calendar.YEAR));
                                            if ((bmonth == 1) || (bmonth == 3) || (bmonth == 5) || (bmonth == 7) || (bmonth == 8) || (bmonth == 10) || (bmonth == 12)) {
                                                days = 31;
                                            } else if (bmonth == 2) {
                                                if (calendar.get(calendar.YEAR) / 4 == 0) {
                                                    days = 29;
                                                } else {
                                                    days = 28;
                                                }
                                            } else {
                                                days = 30;
                                            }
                                            calendar.set(calendar.get(calendar.YEAR), bmonth - 1, days);
                                            java.util.Date d = new java.util.Date(calendar.getTimeInMillis());

                                            // System.out.println("year " + d.toString());
                                            billcycleList.add(d);
                                            bmonth = bmonth + (12 / billcycle);
                                            int currentyear = calendar.get(calendar.YEAR);
                                            if (bmonth > 12) {
                                                bmonth = bmonth - 12;
                                                if(bmonth<=3)
                                                    {
                                                    
                                                    }
                                                else{
                                                calendar.set(calendar.YEAR, calendar.get(calendar.YEAR) + 1);
                                                }
                                            }
                                            if (bmonth > 3 && calendar.get(calendar.YEAR) > currentyear) {
                                                break;
                                            }
                                            temp--;
                                        }


                                        List arrayList = null;
                                        if (genbill == true) {
                                            ii = 2;


                                            genbill = false;
                                        } else {
                                        }


                                        //billdate.set(billdate.get(Calendar.YEAR), 03, 01);
                                        System.out.println("sec----------> " + sec);
                                        // ArrayList arrayList = ledgerCalculation.calbillCl(cons_no.trim(), billdate, sec, xmlpath);
                                        //  System.out.println("size of arraylist======>" + arrayList.size());
                                        //  System.out.println("arraylist 0======>" + arrayList.get(0));
                                        // System.out.println("arraylist 1======>" + arrayList.get(1));


                                        //DecimalFormat def = new DecimalFormat("0.00");
                                        SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
                                        // String date="";
                                        //String amt="";
                                        // date= formatter.format(arrayList.get(23));
                                        //amt=  df.format(Double.parseDouble(arrayList.get(19).toString())+Double.parseDouble(arrayList.get(31).toString()));
                                        //System.out.println(arrayList.get(19)+"dd"+arrayList.get(31));

                                        /* if (sec.equals("01") || sec.equals("02") || sec.equals("03") || sec.equals("04") || sec.equals("05") || sec.equals("06") || sec.equals("07") || sec.equals("08") || sec.equals("09") || sec.equals("10") || sec.equals("11") || sec.equals("11IND") || sec.equals("12")
                                        || sec.equals("14") || sec.equals("14A") || sec.equals("15A") || sec.equals("16A") || sec.equals("15") || sec.equals("16") || sec.equals("17") || sec.equals("18") || sec.equals("19") || sec.equals("22") || sec.equals("23") || sec.equals("24") || sec.equals("27") || sec.equals("55") || sec.equals("56") || sec.equals("57")
                                        || sec.equals("58") || sec.equals("59") || sec.equals("60") || sec.equals("62") || sec.equals("63") || sec.equals("64") || sec.equals("65") || sec.equals("105")) {
                                        division = "JAL1";
                                        } else if (sec.equals("20") || sec.equals("21") || sec.equals("21A") || sec.equals("25") || sec.equals("26") || sec.equals("28") || sec.equals("29") || sec.equals("30") || sec.equals("31") || sec.equals("33") || sec.equals("33A") || sec.equals("34") || sec.equals("35")
                                        || sec.equals("36") || sec.equals("37") || sec.equals("37ADD") || sec.equals("52") || sec.equals("53") || sec.equals("61") || sec.equals("71") || sec.equals("72")) {
                                        division = "JAL2";
                                        } else if (sec.equals("39") || sec.equals("40") || sec.equals("41") || sec.equals("43") || sec.equals("44") || sec.equals("46") || sec.equals("47") || sec.equals("48") || sec.equals("49") || sec.equals("50") || sec.equals("51") || sec.equals("73") || sec.equals("80") || sec.equals("81") || sec.equals("82") || sec.equals("83") || sec.equals("84") || sec.equals("94") || sec.equals("95") || sec.equals("92") || sec.equals("93")) {
                                        division = "JAL3";
                                        }*/
                                        char number = division.charAt((division.length() - 1));
                                        sector = "MASTER" + number;
                                        InitialContext initialContext = new InitialContext();
                                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                        con = dataSource.getConnection();
                                        sql = "select cons_nm1,con_tp,cons_ctg,flat_type,flat_no,blk_no,plot_size,pipe_size,reg_no,to_char(conn_dt,'DD-Mon-YYYY'),esti_no,esti_amt,secu,to_char(esti_dt,'DD-MM-YYYY'),esti1_amt,nodue_amt,to_char(nodue_dt,'DD-MM-YYYY'),trans_nm,trf,id from " + sector + " where trim(cons_no)=?  and (status= 'A' or status is null)";
                                        PreparedStatement pst = con.prepareStatement(sql);
                                        pst.setString(1, cons_no);
                                        ResultSet rs = pst.executeQuery();
                        %>

                        <% if (request.getParameter("t8") != null) {
                                                                    t8 = Integer.parseInt(request.getParameter("t8"));
                                                                    if (t8 == 1) {
                        %>
                        <p class="errorcolor"><label style="float: right; margin-top: -15px;">Record not found</label></p>
                        <%
                                                                        t8 = (Integer) 0;
                                                                    }
                                                                }
                        %>
                        <h2> Consumer Details</h2>

                        <div id="containerm">
                            <div id="contentm">


                                <!--                                <div id="basic-modal-content">
                                                                    <div  id="pdf" style="visibility: hidden">
                                                                        <table>
                                                                            <tr>
                                                                                <td class="f"><a href="/OnlineJal/LedgerPdf?cons_no=<%=cons_no%>"><img src="../../resources/images/icons/Pdf2.png" alt="pdf" title="Get PDF"></img> </a><br/>
                                                                                </td>
                                                                                <td class="f"><a href="/OnlineJal/LedgerExcel?cons_no=<%=cons_no%>"><img src="../../resources/images/icons/Excel1.png" alt="Excel" title="Get Excel"></img> </a><br/>
                                                                                </td>

                                                                            </tr>
                                                                            <tr><td class="g"><a href="/OnlineJal/LedgerPdf?cons_no=<%=cons_no%>">Get PDF </a></td><td class="g"><a href="/OnlineJal/LedgerExcel?cons_no=<%=cons_no%>">Get XLS</a></td> </tr>


                                                                        </table>


                                                                    </div>
                                                                    <div id="processing" class="msg">
                                                                        Please wait while page is being refreshed.
                                                                    </div>
                                                                </div>-->
                                <div style='display:none'>
                                    <img src='../../resources/images/icons/Close-32.png' alt='' />
                                </div>
                            </div>
                        </div>

                        <% //System.out.println("the value of ii isssssssssss " + genbill);%>







                        <div class="buttons">
                            <form action="/OnlineJal/SavePdf" method="post">
                                <input type="hidden" name="cons_no" value="<%=cons_no%>"/>
                                <input type="hidden" name="sec" value="<%=sec%>"/>
                                <input type="hidden" name="division" value="<%=division%>"/>
                                <button class="submit upr" type="submit" value="Submit" title="Get Records as PDF file.">
                                    <span class="leftcorners">
                                        <span class="rightcorners">
                                            <span class="bg">
                                    			Get Pdf
                                            </span>
                                        </span>
                                    </span>
                                </button>
                            </form>
                        </div>

                        <div class="buttons">
                            <form action="save_excel.jsp" method="post">
                                <input type="hidden" name="cons_no" value="<%=cons_no%>"/>
                                <input type="hidden" name="sec" value="<%=sec%>"/>
                                <input type="hidden" name="division" value="<%=division%>"/>
                                <button class="submit ups" type="submit" value="Submit" title="Get Records as Excel Sheet.">
                                    <span class="leftcorners">
                                        <span class="rightcorners">
                                            <span class="bg">
                                    			Get Excel
                                            </span>
                                        </span>
                                    </span>
                                </button>
                            </form>
                        </div>

                        <div class="buttons">
                            <form action="viewpdf.jsp"  method="post">
                                <input type="hidden" name="cons_no" value="<%=cons_no%>"/>
                                <input type="hidden" name="sec" value="<%=sec%>"/>
                                <input type="hidden" name="division" value="<%=division%>"/>
                                <button class="submit up" type="submit" value="Submit" title="View scanned images of challans.">
                                    <span class="leftcorners">
                                        <span class="rightcorners">
                                            <span class="bg">
                                    			View Records
                                            </span>
                                        </span>
                                    </span>
                                </button>
                            </form>
                        </div>
                        <!--                        <div id="mailwait" style="visibility: hidden"  >
                                                    <img src="<%=request.getContextPath()%>/resources/images/ajax-loader.gif" alt="wait"/><p style="font-weight: bold;"> Calculating Bill</p>
                                                </div>-->
                        <form action="<%= request.getContextPath()%>/GenerateBill?div=<%=division%>&amp;cons_no=<%=cons_no%>" method="post" >

                            <table id="table-blk" class="full" >








                                <%
                                                                        if (rs.next()) {
                                                                            cons_nm1 = rs.getString(1);
                                                                            con_tp = rs.getString(2);
                                                                            cons_ctg = rs.getString(3);
                                                                            flat_type = rs.getString(4);
                                                                            flat_no = rs.getString(5);
                                                                            blk_no = rs.getString(6);
                                                                            if (blk_no == null) {
                                                                                blk_no = "-";
                                                                            }
                                                                            plot_size = rs.getDouble(7);
                                                                            pipe_size = rs.getInt(8);

                                                                            reg_no = rs.getString(9);
                                                                            if (reg_no == null) {
                                                                                reg_no = "-";
                                                                            }
                                                                            conn_dt = rs.getString(10);
                                                                            if (conn_dt == null) {
                                                                                conn_dt = "-";
                                                                            }
                                                                            esti_no = rs.getString(11);
                                                                            if (esti_no == null) {
                                                                                esti_no = "-";
                                                                            }
                                                                            esti_amt = rs.getDouble(12);
                                                                            secu = rs.getDouble(13);
                                                                            esti_dt = rs.getString(14);
                                                                            if (esti_dt == null) {
                                                                                esti_dt = "-";
                                                                            }
                                                                            esti1_amt = rs.getDouble(15);
                                                                            nodue_amt = rs.getDouble(16);
                                                                            nodue_dt = rs.getString(17);
                                                                            if (nodue_dt == null) {
                                                                                nodue_dt = "-";
                                                                            }
                                                                            trans_nm = rs.getString(18);
                                                                            if (trans_nm == null) {
                                                                                trans_nm = "-";
                                                                            }


                                                                            trf = rs.getString(19);
                                                                            if (trf != null && (!(trf.trim()).equals("null"))) {
                                                                                cons_nm1 = trans_nm;
                                                                            }
                                                                            if (trf == null) {
                                                                                trf = "-";
                                                                            }
                                                                            String conType = "";
                                                                            String conCategory = "";

                                %>



                                    <tr>
                                        <th class="bold ">Consumer No.</th>
                                        <th class="n"><%=cons_no%></th>
                                        <th class="bold1">Registration No.</th>
                                        <th class="nm"><%=reg_no%></th>

                                    </tr>
                                    <tr>
                                        <th class="bold">Consumer Name</th>
                                        <th class="n"><%=cons_nm1%></th>
                                        <th class="bold1">Connection Date</th>
                                        <th class="nm"><%=conn_dt%></th>
                                    </tr>
                                    <tr>
                                        <th class="bold">Address</th>
                                        <th class="n"><%=sec%>/<%=blk_no%>-<%=flat_no%></th>
                                        <th class="bold1">Estimation No.</th>
                                        <th class="nm"><%=esti_no%></th>
                                    </tr>
                                    <tr>
                                        <th class="bold">Connection Type</th>
                                        <th class="n"><%if (con_tp.equalsIgnoreCase("R")) {
                                                                                                                        conType = "Residential";
                                                                                                                    } else if (con_tp.equalsIgnoreCase("T")) {
                                                                                                                        conType = "Industrial";
                                                                                                                    } else if (con_tp.equalsIgnoreCase("G")) {
                                                                                                                        conType = "Group Housing";
                                                                                                                    } else if (con_tp.equalsIgnoreCase("C")) {
                                                                                                                        conType = "Commercial";
                                                                                                                    } else if (con_tp.equalsIgnoreCase("S")) {
                                                                                                                        conType = "Staff";
                                                                                                                    } else if (con_tp.equalsIgnoreCase("I")) {
                                                                                                                        conType = "Industrial";
                                                                                                                    }

                                            %>
                                            <%=conType%></th>
                                        <th class="bold1" >Estimation Amount</th>
                                        <th class="nm"><img class="m" style="text-align: right; margin-bottom: 0px; float:none;" src="<%=request.getContextPath()%>/resources/images/Rupee1.png" alt="Rs."/> <%= showAmmount(esti_amt)%> </th>
                                    </tr>
                                    <tr>
                                        <th class="bold">Connection Category</th>
                                        <th class="n"> <%if (cons_ctg.equalsIgnoreCase("R")) {
                                                                                                                        conCategory = "Regular";
                                                                                                                    } else if (cons_ctg.equalsIgnoreCase("T")) {
                                                                                                                        conCategory = "Temporary";
                                                                                                                    }

                                            %>
                                            <%=conCategory%></th>
                                        <th class="bold1">Estimation Date</th>
                                        <th class="nm"><%=esti_dt%></th>

                                    </tr>
                                    <tr>
                                        <th class="bold">Flat Type</th>
                                        <th class="n"><%=flat_type%></th>
                                        <th class="bold1">No-Due Amount</th>
                                        <th class="nm" ><img style="margin-right: 0px;margin-bottom: 0px; float: none;" src="<%=request.getContextPath()%>/resources/images/Rupee1.png" alt="Rs."/> <%=showAmmount(nodue_amt)%> </th>

                                    </tr>
                                    <tr>
                                        <th class="bold">Plot Size</th>
                                        <th class="n"><%=plot_size%> Sq Meter</th>
                                        <th class="bold1">No-Due Issued Upto</th>
                                        <th class="nm"><%=nodue_dt%></th>

                                    </tr>
                                    <tr>
                                        <th class="bold">Pipe Size</th>
                                        <th class="n"><%=pipe_size%> mm</th>

                                        <th class="bold1">Select Bill Cycle</th>
                                        <th class="nm" ><select name="billcycle" id="billcycle" class="required"    >
                                                <option value="Select">Select Bill Cycle</option>
                                                <%       for (int k = 0; k < billcycleList.size(); k++) {%>
                                                <option value="<%=formatter.format(billcycleList.get(k))%>">Upto <%=formatter.format(billcycleList.get(k))%></option>
                                                <% // System.out.println("yyyy" + billcycleList.get(k).toString());
                                                                                                                        }%>
                                        </select></th>

                                </tr>

                                    <tr>
                                        <th>
                                        </th>
                                        <th>
                                        </th>
                                        <th>
                                        </th>
                                        <th   style="text-align: right">

                                        Bill Cycle is<% if (billcycle == 12) {%> Monthly
                                        <%} else if (billcycle == 4) {%> Quarterly
                                        <%} else if (billcycle == 2) {%>
                                        Half Yearly
                                        <%} else {%>
                                        Monthly
                                        <%}
                                        %>
                                    </th>
                                </tr>
                                <tr>
                                    <th>
                                    </th>
                                    <th>
                                    </th>
                                    <th>
                                    </th>
                                    <th>
                                        <%
                                                                                                                    String check = request.getParameter("e");
                                                                                                                    if (check != null && check.equals("ex")) {%>
                                        <p class="errorcolor"><label id="lab1" style="float: right; margin-left: -100px;">Please Select Bill Cycle.</label></p>

                                        <% }
                                                                                                                    check = null;
                                        %>
                                        <br/>
                                        <div id="mailwait" style=" display:none;"   >
                                            <img src="<%=request.getContextPath()%>/resources/images/ajax-loader.gif" alt="wait"   /><p style="font-weight: bold;" > Calculating Bill</p>
                                        </div>
                                    </th>
                                </tr>



                                <%

                                                }

                                            } catch (Exception ex) {
                                                System.out.println("Exception:" + ex);
                                            }%>



                            </table>
                            <br/>
                           
                                <% if (request.getAttribute("error") != null) {
                                                request.setAttribute("error", 0);
                                %>
                                <p class="errorcolor"><label style="float: right; margin-bottom: -30px; margin-right:  220px;">Insufficient Details</label></p>
                                <% }%>

                                <div class="buttons" style="margin-left:80px;">

                                <button id="button11" class="submit bill1" type="submit" value="Submit"  onclick="wait()"  title="Select Bill Cycle Before Generate Bill.">
                                    <span class="leftcorners">
                                        <span class="rightcorners">
                                            <span class="bg">
                                                Generate Bill
                                            </span>
                                        </span>
                                    </span>
                                </button>


                            </div>


                        </form>
                        <br class="clear"/>





                        <h2> Challan Details</h2>

                        <br class="clear"/>

                        <div id="table-blk" class="full">

                            <table  class="box-table">
                                <colgroup>
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                </colgroup>

                                <thead>
                                    <tr>
                                        <th scope="col"   colspan="2">Bill Period</th>

                                        <th scope="col" >Due Date</th>
                                        <th scope="col" >Bill Amt</th>
                                        <th scope="col" >Surcharge</th>
                                        <th scope="col" >Paid Amt</th>
                                        <th scope="col" >Pay Date</th>
                                        <th scope="col" >Receipt No</th>

                                        <th scope="col" >Transfer Fees</th>
                                        <th scope="col" >Bank Code</th>
                                        <th scope="col" >Branch Name</th>
                                    </tr>
                                </thead>
                                <%                                    cons_no = (String) session.getAttribute("userid");
                                            x = Integer.parseInt(cons_no.substring(0, 3));
                                            sec = Integer.toString(x);
                                            if (x
                                                    < 10) {
                                                sec = Integer.toString(x);
                                                sec = "0" + sec;
                                            } else {
                                                sec = Integer.toString(x);
                                            }
                                            char number = division.charAt((division.length() - 1));
                                            sector = "CHALLAN" + number;
                                            try {
                                                sql = "select to_char(bl_per_fr,'DD-MM-YY'),to_char(bl_per_to,'DD-MM-YY'),to_char(due_dt,'DD-MM-YY'),bill_amt,surcharge,paid_amt,to_char(pay_date,'DD-MM-YY'),arrear,credit,recp_no,dis_cd,noc,secu,t_fee,bnk_cd,br_nm,id from " + sector + " where trim(cons_no)=? and (status= 'A' or status is null) and bl_per_fr is not null order by bl_per_fr desc";
                                                PreparedStatement pst = con.prepareStatement(sql);
                                                pst.setString(1, cons_no);
                                                ResultSet rs = pst.executeQuery();
                                                empty=0;
                                                while (rs.next()) {
                                                    empty=1;
                                                    bl_per_fr = rs.getString(1);
                                                    if (bl_per_fr == null) {
                                                        bl_per_fr = "-";
                                                    }
                                                    bl_per_to = rs.getString(2);
                                                    if (bl_per_to == null) {
                                                        bl_per_to = "-";
                                                    }
                                                    due_dt = rs.getString(3);
                                                    if (due_dt == null) {
                                                        due_dt = "-";
                                                    }
                                                    bill_amt = Math.round(rs.getDouble(4));
                                                    surcharge = Math.round(rs.getDouble(5));
                                                    paid_amt = Math.round(rs.getDouble(6));
                                                    pay_date = rs.getString(7);
                                                    if (pay_date == null) {
                                                        pay_date = "-";
                                                    }
                                                    arrear = rs.getDouble(8);
                                                    credit = rs.getDouble(9);
                                                    recp_no = rs.getString(10);
                                                    if (recp_no == null) {
                                                        recp_no = "-";
                                                    }
                                                    dis_cd = rs.getString(11);
                                                    if (dis_cd == null) {
                                                        dis_cd = "-";
                                                    }
                                                    noc = rs.getDouble(12);
                                                    t_fee = Math.round(rs.getDouble(14));
                                                    bnk_cd = rs.getString(15);
                                                    if (bnk_cd == null) {
                                                        bnk_cd = "-";
                                                    }
                                                    br_nm = rs.getString(16);
                                                    if (br_nm == null) {
                                                        br_nm = "-";
                                                    }


                                                    if (i % 2 == 0) {

                                %>

                                <tr>
                                    <td><%=bl_per_fr%></td>
                                    <td><%=bl_per_to%></td>
                                    <td><%=due_dt%></td>
                                    <td style="text-align: right"><%=showAmmount(bill_amt)%></td>
                                    <td style="text-align: right"><%=showAmmount(surcharge)%></td>
                                    <td style="text-align: right"><%=showAmmount(paid_amt)%></td>
                                    <td><%=pay_date%></td>
                                    <td><%=recp_no%></td>                                   
                                    <td style="text-align: right"><%=showAmmount(t_fee)%></td>
                                    <td><%=bnk_cd%></td>
                                    <td><%=br_nm%></td>
                                </tr>


                                <%
                                                                             } else {
                                %>

                                <tr>
                                    <td><%=bl_per_fr%></td>
                                    <td><%=bl_per_to%></td>
                                    <td><%=due_dt%></td>
                                    <td style="text-align: right"><%=showAmmount(bill_amt)%></td>
                                    <td style="text-align: right"><%=showAmmount(surcharge)%></td>
                                    <td style="text-align: right"><%=showAmmount(paid_amt)%></td>
                                    <td><%=pay_date%></td>
                                    <td><%=recp_no%></td>                                   
                                    <td style="text-align: right"><%=showAmmount(t_fee)%></td>
                                    <td><%=bnk_cd%></td>
                                    <td><%=br_nm%></td>
                                </tr>

                                <%

                                                    }
                                                    i++;
                                                }

                                                 if (empty != 1) {
                                %>
                                <tr><td colspan="11">
                                        Records are not available for this Consumer.</td>

                                </tr>
                                <% }
                                            } catch (Exception ex) {
                                                //  System.out.println("Exception:" + ex);
                                                ex.printStackTrace();
                                            } finally {
                                                con.close();
                                            }
                                %>


                            </table></div><br/>
                        <p><b><span>*
                                    This amount is calculated on the records available in our database. The actual amount may be differ.
                                    If already paid please ignore.(E. & O.E)
                                </span></b></p>
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
