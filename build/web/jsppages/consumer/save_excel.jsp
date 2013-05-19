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


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%@page language="java" import="com.itextpdf.text.*,com.itextpdf.text.pdf.*,java.sql.*,java.io.*;"%>

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
    String address;
    String plotSize;
    String pipeSize;
    String xmlpath;
    DocumentBuilderFactory dbf = null;
    DocumentBuilder db = null;
    org.w3c.dom.Document docxml = null;

%>

<%
            request.getSession(false);
            request.setAttribute("t", t);
            userrole = (String) session.getAttribute("userrole");

%>

<%

            try {
                cons_no = (String) session.getAttribute("userid");
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



                /* if (sec.equals("01") || sec.equals("02") || sec.equals("03") || sec.equals("04") || sec.equals("05") || sec.equals("06") || sec.equals("07") || sec.equals("08") || sec.equals("09") || sec.equals("10") || sec.equals("11") || sec.equals("11IND") || sec.equals("12")
                || sec.equals("14") || sec.equals("14A") || sec.equals("15") || sec.equals("15A") || sec.equals("16") || sec.equals("16A") || sec.equals("17") || sec.equals("18") || sec.equals("19") || sec.equals("22") || sec.equals("23") || sec.equals("24") || sec.equals("27") || sec.equals("55") || sec.equals("56") || sec.equals("57")
                || sec.equals("58") || sec.equals("59") || sec.equals("60") || sec.equals("62") || sec.equals("63") || sec.equals("64") || sec.equals("65") || sec.equals("105")) {
                division = "JAL1";
                } else if (sec.equals("20") || sec.equals("21") || sec.equals("21A") || sec.equals("25") || sec.equals("26") || sec.equals("28") || sec.equals("29") || sec.equals("30") || sec.equals("31") || sec.equals("33") || sec.equals("33A") || sec.equals("34") || sec.equals("35")
                || sec.equals("36") || sec.equals("37") || sec.equals("37ADD") || sec.equals("52") || sec.equals("53") || sec.equals("61") || sec.equals("71") || sec.equals("72")) {
                division = "JAL2";
                } else if (sec.equals("39") || sec.equals("40") || sec.equals("41") || sec.equals("42") || sec.equals("43") || sec.equals("44") || sec.equals("46") || sec.equals("47") || sec.equals("48") || sec.equals("49") || sec.equals("50") || sec.equals("51") || sec.equals("73") || sec.equals("80") || sec.equals("81") || sec.equals("82") || sec.equals("83") || sec.equals("84") || sec.equals("92") || sec.equals("93") || sec.equals("94") || sec.equals("95")) {
                division = "JAL3";
                }*/

                char number = division.charAt((division.length() - 1));

                sector = "MASTER" + number;
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                sql = "select cons_nm1,con_tp,cons_ctg,flat_type,flat_no,blk_no,plot_size,pipe_size,reg_no,to_char(conn_dt,'DD-MM-YYYY'),esti_no,esti_amt,secu,to_char(esti_dt,'DD-MM-YYYY'),esti1_amt,nodue_amt,to_char(nodue_dt,'DD-MM-YYYY'),trans_nm,trf,rowid from " + sector + " where trim(cons_no)=?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, cons_no.trim());
                ResultSet rs = pst.executeQuery();


                if (rs.next()) {
                    cons_nm1 = rs.getString(1);
                    con_tp = rs.getString(2);
                    if (con_tp.equalsIgnoreCase("R")) {
                        con_tp = "Residential";
                    } else if (con_tp.equalsIgnoreCase("T")) {
                        con_tp = "Industrial";
                    } else if (con_tp.equalsIgnoreCase("G")) {
                        con_tp = "Group Housing";
                    } else if (con_tp.equalsIgnoreCase("C")) {
                        con_tp = "Commercial";
                    } else if (con_tp.equalsIgnoreCase("S")) {
                        con_tp = "Staff";
                    } else if (con_tp.equalsIgnoreCase("I")) {
                        con_tp = "Industrial";
                    }
                    cons_ctg = rs.getString(3);
                    if (cons_ctg.equalsIgnoreCase("R")) {
                        cons_ctg = "Regular";
                    } else if (cons_ctg.equalsIgnoreCase("T")) {
                        cons_ctg = "Temporary";
                    }
                    flat_type = rs.getString(4);
                    flat_no = rs.getString(5);
                    blk_no = rs.getString(6);
                    if (blk_no == null) {
                        blk_no = "-";
                    }
                    plot_size = rs.getDouble(7);
                    if (String.valueOf(plot_size) != null) {
                        plotSize = String.valueOf(plot_size) + " Sq Feet";
                    }
                    pipe_size = rs.getInt(8);
                    if (String.valueOf(pipe_size) != null) {
                        pipeSize = String.valueOf(pipe_size) + " mm";
                    }

                    reg_no = rs.getString(9);
                    if (reg_no == null) {
                        reg_no = " ";
                    }
                    conn_dt = rs.getString(10);
                    if (conn_dt == null) {
                        conn_dt = " ";
                    }
                    esti_no = rs.getString(11);
                    if (esti_no == null) {
                        esti_no = " ";
                    }
                    esti_amt = rs.getDouble(12);
                    secu = rs.getDouble(13);
                    esti_dt = rs.getString(14);
                    if (esti_dt == null) {
                        esti_dt = " ";
                    }
                    esti1_amt = rs.getDouble(15);
                    nodue_amt = rs.getDouble(16);
                    nodue_dt = rs.getString(17);
                    if (nodue_dt == null) {
                        nodue_dt = "";
                    }
                    trans_nm = rs.getString(18);
                    if (trans_nm == null) {
                        trans_nm = "";
                    }

                    trf = rs.getString(19);
                    if (trf != null && (!(trf.trim()).equals("null"))) {
                        cons_nm1 = trans_nm;
                    }
                    if (trf == null) {
                        trf = "-";
                    }
                }

                address = sec + "/" + blk_no.trim() + "-" + flat_no.trim();

                char number1 = division.charAt((division.length() - 1));
                sector = "CHALLAN" + number1;

                sql = "select to_char(bl_per_fr,'DD-MM-YY'),to_char(bl_per_to,'DD-MM-YY'),to_char(due_dt,'DD-MM-YY'),bill_amt,surcharge,paid_amt,to_char(pay_date,'DD-MM-YY'),arrear,credit,recp_no,dis_cd,noc,secu,t_fee,bnk_cd,br_nm,rowid from " + sector + " where trim(cons_no)=? and bl_per_fr is not null order by bl_per_fr desc";
                pst = con.prepareStatement(sql);
                pst.setString(1, cons_no.trim());
                rs = pst.executeQuery();


                response.setHeader("Cache-Control", "Max-age=0");
                response.setHeader("Pragma", "public");
                response.setDateHeader("Expires", 0);
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("Content-Disposition", "attachment;filename=" + cons_no + ".xls");
%>
<table  width="100%">

    <tr><td colspan="8" rowspan="2" align="center"><font size="4">Consumer Details</font></td>

    </tr>
    <tr></tr>


    <tr>
        <td colspan="2" ><font size="3">Consumer No: </font></td><td colspan="2" align="left">&nbsp;<%=cons_no%></td>
        <td colspan="2" ><font size="3">Registration No: </font></td><td colspan="2" align="left"> &nbsp;<%=reg_no%></td>
    </tr>

    <tr>
        <td colspan="2" ><font size="3">Consumer Name: </font></td><td colspan="2" align="left"> &nbsp;<%=cons_nm1%></td>
        <td colspan="2"><font size="3">Connection Date: </font></td><td colspan="2" align="left"> &nbsp;<%=conn_dt%></td>
    </tr>

    <tr>
        <td colspan="2" ><font size="3">Address:  </font></td><td colspan="2" align="left">&nbsp;<%=address%></td>
        <td colspan="2"><font size="3">Estimation No: </font></td><td colspan="2" align="left"> &nbsp;<%=esti_no%></td>
    </tr>

    <tr>
        <td colspan="2"><font size="3">Connection Type: </font> </td><td colspan="2" align="left">&nbsp;<%=con_tp%></td>
        <td colspan="2"><font size="3">Estimation Amount: </font> </td><td colspan="2" align="left">&nbsp;<%=esti_amt%></td>
    </tr>

    <tr>
        <td colspan="2" ><font size="3">Connection Category: </font> </td><td colspan="2" align="left">&nbsp;<%=cons_ctg%></td>
        <td colspan="2"><font size="3">Security: </font></td><td colspan="2" align="left"> &nbsp;<%=secu%></td>
    </tr>

    <tr>
        <td colspan="2"><font size="3">Flat Type:  </font></td><td colspan="2" align="left">&nbsp;<%=flat_type%></td>
        <td colspan="2" ><font size="3">Estimation Date: </font></td><td colspan="2" align="left"> &nbsp;<%=esti_dt%></td>
    </tr>

    <tr>
        <td colspan="2"><font size="3">Plot Size:  </font></td><td colspan="2" align="left">&nbsp;<%=plotSize%></td>
        <td colspan="2" ><font size="3">No Due Amount: </font></td><td colspan="2" align="left"> &nbsp;<%=nodue_amt%></td>
    </tr>

    <tr>
        <td colspan="2" ><font size="3">Pipe Size: </font> </td><td colspan="2" align="left">&nbsp;<%=pipeSize%></td>
        <td colspan="2" ><font size="3">No Due Date: </font></td><td colspan="2" align="left"> &nbsp;<%=nodue_dt%></td>
    </tr>


</table>
<table   width="100%">
    <tr><td colspan="12" rowspan="2" align="center"><font size="4">Challan Details</font></td></tr>
    <tr></tr>

    <tr><th  colspan="2" align="center"><font size="2">Bill Period</font></th>
        <th  align="center"><font size="2">Due Date</font></th>
        <th  align="center"><font size="2">Bill Amt</font></th>
        <th  align="center"><font size="2">Surcharge</font></th>
        <th  align="center"><font size="2">Paid Amt</font></th>
        <th  align="center"><font size="2">Pay Date</font></th>
        <th  align="center"><font size="2">Receipt No</font></th>
        <th  align="center"><font size="2">Security</font></th>
        <th  align="center"><font size="2">Transfer Fees</font></th>
        <th  align="center"><font size="2">Bank Code</font></th>
        <th  align="center"><font size="2">Bank Name</font></th>
    </tr>
    <%
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
    %>

    <tr>
        <td align="center" ><%=bl_per_fr%></td>
        <td align="center" ><%=bl_per_to%></td>
        <td align="center" ><%=due_dt%></td>
        <td align="center" ><%=bill_amt%></td>
        <td align="center" ><%=surcharge%></td>
        <td align="center" ><%=paid_amt%></td>
        <td align="center" ><%=pay_date%></td>
        <td align="center" ><%=recp_no%></td>
        <td align="center" ><%=secu%></td>
        <td align="center" ><%=t_fee%></td>
        <td align="center" ><%=bnk_cd%></td>
        <td align="center" ><%=br_nm%></td>
    </tr>

    <%
                    }
    %>
</table>


<%


            } catch (Exception e) {
                System.err.println("Exception in dopost" + e);
            } finally {
                con.close();
            }
%>
