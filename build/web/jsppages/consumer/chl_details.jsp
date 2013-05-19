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
    String division;
    String path;
    File delfile;
    String xmlpath;
    DocumentBuilderFactory dbf = null;
    DocumentBuilder db = null;
    org.w3c.dom.Document docxml = null;
%>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../common/header.jsp"/>

    <script type='text/javascript' src='../../resources/jquery/jquery.simplemodal.js'></script>
    <script type='text/javascript' src='../../resources/jquery/basic.js'></script>

    <script type="text/javascript">
    
    
        function delLedger()
        {
            document.location.href="delLedger.jsp";
        }


        function callGetLedger()
        {
            i=0;
            cons_no= document.getElementById("cons_no").value
            sec= document.getElementById("sec").value
            division= document.getElementById("division").value
 	
            xmlHttp=GetXmlHttpObject()
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }
            var url="/OnlineJal/GetLedger"
            url=url+"?&cons_no="+cons_no+"&sec="+sec+"&division="+division
            xmlHttp.open("GET",url,true)
            xmlHttp.send(null)
        
            xmlHttp.onreadystatechange=function()
            {
                cons_no=null;
                path=null;
               
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {

                    var showdata = xmlHttp.responseText;
                    str=showdata.split(":");
                    cons_no=str[0];
                    path=str[1];
                                            
                    if(cons_no!=null&&path!=null)
                    {
                        document.getElementById("pdf").style.visibility="visible";
                        document.getElementById("processing").style.visibility="hidden";
                        i=1;
                    }
                    if(i!=1)
                        setTimeout("callGetLedger()", 5000);
                }else
                {
                    document.getElementById("processing").style.visibility="visible";
                    document.getElementById("pdf").style.visibility="hidden";
                       
                }
               
            }
            
        }


        function GetXmlHttpObject()
        {
            var xmlHttp=null;
            try
            {
                // Firefox, Opera 8.0+, Safari
                xmlHttp=new XMLHttpRequest();
            }
            catch (e)
            {
                //Internet Explorer
                try
                {
                    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e)
                {
                    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
            }
            return xmlHttp;
        }
    </script>


    <body >
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

                        <div class="active">
                            <a href="#" title="consumerdetails">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Payment Details
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

                        <%

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

                                     /*   if (sec.equals("01") || sec.equals("02") || sec.equals("03") || sec.equals("04") || sec.equals("05") || sec.equals("06") || sec.equals("07") || sec.equals("08") || sec.equals("09") || sec.equals("10") || sec.equals("11") || sec.equals("11IND") || sec.equals("12")
                                                || sec.equals("14") || sec.equals("14A") || sec.equals("15A") || sec.equals("16A") || sec.equals("15") || sec.equals("16") || sec.equals("17") || sec.equals("18") || sec.equals("19") || sec.equals("22") || sec.equals("23") || sec.equals("24") || sec.equals("27") || sec.equals("55") || sec.equals("56") || sec.equals("57")
                                                || sec.equals("58") || sec.equals("59") || sec.equals("60") || sec.equals("62") || sec.equals("63") || sec.equals("64") || sec.equals("65") || sec.equals("105")) {
                                            division = "JAL1";
                                        } else if (sec.equals("20") || sec.equals("21") || sec.equals("21A") || sec.equals("25") || sec.equals("26") || sec.equals("28") || sec.equals("29") || sec.equals("30") || sec.equals("31") || sec.equals("33") || sec.equals("33A") || sec.equals("34") || sec.equals("35")
                                                || sec.equals("36") || sec.equals("37") || sec.equals("37ADD") || sec.equals("52") || sec.equals("53") || sec.equals("61") || sec.equals("71") || sec.equals("72")) {
                                            division = "JAL2";
                                        } else if (sec.equals("39") || sec.equals("40") || sec.equals("41") || sec.equals("43") || sec.equals("44") || sec.equals("46") || sec.equals("47") || sec.equals("48") || sec.equals("49") || sec.equals("50") || sec.equals("51") || sec.equals("73") || sec.equals("80") || sec.equals("81") || sec.equals("82") || sec.equals("83") || sec.equals("92") || sec.equals("94") || sec.equals("95") || sec.equals("93")) {
                                            division = "JAL3";
                                        }*/

                                        sector = "MASTER_" + division.toUpperCase().trim();                                        
                                        InitialContext initialContext = new InitialContext();
                                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                        con = dataSource.getConnection();
                                        sql = "select cons_nm1,con_tp,cons_ctg,flat_type,flat_no,blk_no,plot_size,pipe_size,reg_no,to_char(conn_dt,'DD-MM-YYYY'),esti_no,esti_amt,secu,to_char(esti_dt,'DD-MM-YYYY'),esti1_amt,nodue_amt,to_char(nodue_dt,'DD-MM-YYYY'),trans_nm,trf,rowid from " + sector + " where cons_no=?";
                                        PreparedStatement pst = con.prepareStatement(sql);
                                        pst.setString(1, cons_no);
                                        ResultSet rs = pst.executeQuery();

                        %>



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

                        %>



                        <%

                                        }

                                    } catch (Exception ex) {
                                        System.out.println("Exception:" + ex);
                                    }%>

                        <h2> Payment Details</h2>
                        <div class="buttons">
                            <form action="viewpdf.jsp?cons_no=<%=cons_no%>&sec=<%=sec%>&division=<%=division%>" id="contactusform" method="post">
                                <button class="submit up" type="submit" value="Submit" title="View scanned images of challans.">
                                    <span class="leftcorners">
                                        <span class="rightcorners">
                                            <span class="bg">
                                    			VIEW PDF
                                            </span>
                                        </span>
                                    </span>
                                </button>
                            </form>
                        </div>
                        <br class="clear"/>
                        <div id="table-blk" class="full" >

                            <table  id="box-table">
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
                                        <th scope="col" id="vzebra-comedy" colspan="2">Bill Period</th>

                                        <th scope="col" id="vzebra-comedy">Due Date</th>
                                        <th scope="col" id="vzebra-comedy">Bill Amt</th>
                                        <th scope="col" id="vzebra-comedy">Surcharge</th>
                                        <th scope="col" id="vzebra-comedy" >Paid Amt</th>
                                        <th scope="col" id="vzebra-comedy">Pay Date</th>
                                        <th scope="col" id="vzebra-comedy">Arrear</th>
                                        <th scope="col" id="vzebra-comedy" >Credit</th>
                                        <th scope="col" id="vzebra-comedy">Receipt No</th>
                                        <th scope="col" id="vzebra-comedy" >Security</th>
                                        <th scope="col" id="vzebra-comedy">Transfer Fees</th>
                                        <th scope="col" id="vzebra-comedy">Bank Code</th>
                                        <th scope="col" id="vzebra-comedy">Branch Name</th>
                                    </tr>
                                </thead>
                                <%

                                            cons_no = (String) session.getAttribute("userid");
                                            x = Integer.parseInt(cons_no.substring(0, 3));
                                            sec = Integer.toString(x);
                                            if (x < 10) {
                                                sec = Integer.toString(x);
                                                sec = "0" + sec;
                                            } else {
                                                sec = Integer.toString(x);
                                            }

                                            sector = "CHALLAN_" + division;
                                            try {
                                                sql = "select to_char(bl_per_fr,'DD-MM-YY'),to_char(bl_per_to,'DD-MM-YY'),to_char(due_dt,'DD-MM-YY'),bill_amt,surcharge,paid_amt,to_char(pay_date,'DD-MM-YY'),arrear,credit,recp_no,dis_cd,noc,secu,t_fee,bnk_cd,br_nm,rowid from " + sector + " where cons_no=? and bl_per_fr is not null order by bl_per_fr desc";
                                                PreparedStatement pst = con.prepareStatement(sql);
                                                pst.setString(1, cons_no);
                                                ResultSet rs = pst.executeQuery();
                                                while (rs.next()) {
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
                                                    bill_amt = rs.getDouble(4);
                                                    surcharge = rs.getDouble(5);
                                                    paid_amt = rs.getDouble(6);
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
                                                    secu = rs.getDouble(13);
                                                    t_fee = rs.getDouble(14);
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
                                <tbody>
                                    <tr>
                                        <td><%=bl_per_fr%></td>
                                        <td><%=bl_per_to%></td>
                                        <td><%=due_dt%></td>
                                        <td><%=bill_amt%></td>
                                        <td><%=surcharge%></td>
                                        <td><%=paid_amt%></td>
                                        <td><%=pay_date%></td>
                                        <td><%=arrear%></td>
                                        <td><%=credit%></td>
                                        <td><%=recp_no%></td>
                                        <td><%=secu%></td>
                                        <td><%=t_fee%></td>
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
                                        <td><%=bill_amt%></td>
                                        <td><%=surcharge%></td>
                                        <td><%=paid_amt%></td>
                                        <td><%=pay_date%></td>
                                        <td><%=arrear%></td>
                                        <td><%=credit%></td>
                                        <td><%=recp_no%></td>
                                        <td><%=secu%></td>
                                        <td><%=t_fee%></td>
                                        <td><%=bnk_cd%></td>
                                        <td><%=br_nm%></td>
                                    </tr>

                                    <%

                                                        }
                                                        i++;
                                                    }
                                                } catch (Exception ex) {
                                                    System.out.println("Exception:" + ex);
                                                } finally {
                                                    con.close();
                                                }
                                    %>

                                </tbody>
                            </table>

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


