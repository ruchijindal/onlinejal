package com.smp.jal;

import java.io.PrintWriter;

import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.w3c.dom.Node;

/**
 *
 * @author smp
 */
public class ExcelGen extends HttpServlet {

    double roundTwoDecimals(double d) {
        DecimalFormat df = new DecimalFormat("#.##");
        return Double.valueOf(df.format(d));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cons_no = null;
        String sec = null;
        String form;

        int k = 0;
        int rows;
        String alist;
        ArrayList alr1;
        ArrayList alrow;
        ArrayList<ArrayList> al;
        String ledger;
        String cons_nm1 = null;
        sec = null;
        String blk_no = null;
        String flat_no = null;


        String bl_per_fr = null;
        String bl_per_to = null;
        double rate = 0;

        double arrear = 0;
        double interest = 0;
        Format formatter;
        String address;
        String pay_date = null;
        double paid_amt = 0;
        double credit = 0;
        double principal = 0;
        double cssarrear = 0;
        double cssrate = 0;
        java.util.Date dt1;
        Calendar dt;
        boolean flag = true;
        cons_no = request.getParameter("cons_no");
        response.setHeader("Cache-Control", "Max-age=0");
        response.setHeader("Pragma", "public");
        response.setDateHeader("Expires", 0);
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + cons_no + ".xls");


        alr1 = new ArrayList();
        al = new ArrayList<ArrayList>();
        alrow = new ArrayList();
        cons_no = request.getParameter("cons_no");
        ledger = "LEDGER FOR CONSUMER NUMBER-" + cons_no;



        try {
            PrintWriter out = response.getWriter();
            out.println("<table border=\"0\" width=\"100%\">");
            out.println("<tr></tr>");
            out.println("<tr><th rowspan=2 colspan=18><font size=\"3\" weight=\"normal\">NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY</font></th></tr>");
            out.println("<tr></tr>");
            out.println("<tr><th rowspan=2 colspan=18><font size=\"3\" weight=\"normal\">" + ledger + "</font></th></tr>");
            out.println("<tr></tr>");




            cons_no = request.getParameter("cons_no");


            alist = request.getParameter("al");

            alist = alist.substring(alist.indexOf("[") + 1, alist.lastIndexOf("]"));

            String[] aliststr = alist.split("]");

            for (int l = 0; l < aliststr.length; l++) {
                String[] alstr = aliststr[l].split(",");
                for (int m = 0; m < alstr.length; m++) {
                    if (m == 0 && l == 0) {
                        alr1.add(alstr[m].substring(1));
                    } else if (m == 1 && l != 0) {
                        alr1.add(alstr[m].substring(2));
                    } else if (m != 0) {
                        alr1.add(alstr[m]);
                    }
                }
                al.add(new ArrayList(alr1));
                alr1.clear();
            }


            sec = request.getParameter("sec");

            rows = al.size();
            flag = true;
            int r = al.size();
            for (int j = 0; j < r; j++) {
                alrow = (ArrayList) al.get(j);
                cons_no = (String) alrow.get(0);
                if (cons_no == null || cons_no.trim().equals("null")) {
                    cons_no = " ";
                }
                cons_nm1 = (String) alrow.get(1);
                if (cons_nm1 == null || cons_nm1.trim().equals("null")) {
                    cons_nm1 = " ";
                }
                sec = (String) alrow.get(8);
                if (sec == null || sec.trim().equals("null")) {
                    sec = " ";
                } else {
                    sec = sec.trim();
                }
                blk_no = (String) alrow.get(7);
                if (blk_no == null || blk_no.trim().equals("null")) {
                    blk_no = " ";
                } else {
                    blk_no = blk_no.trim();
                }
                flat_no = (String) alrow.get(6);
                if (flat_no == null || flat_no.equals("null")) {
                    flat_no = " ";
                } else {
                    flat_no = flat_no.trim();
                }

                address = sec.trim() + "/" + blk_no.trim() + "-" + flat_no.trim();
                if (flag == true) {
                    out.println("<tr><th rowspan=2 colspan=18><font size=\"3\">&nbsp;&nbsp;Consumer No.:&nbsp;&nbsp;" + cons_no.trim() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Consumer Name:&nbsp;&nbsp;" + cons_nm1.trim() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Address:&nbsp;&nbsp;" + address + "</font></th></tr>");
                    out.println("<tr></tr>");


                    out.println("<tr><th rowspan=2 colspan=2><font size=\"3\">Bill From</font></th><th rowspan=2 colspan=2><font size=\"3\">Bill Upto</font></th><th rowspan=2 colspan=2><font size=\"3\">Rate</font></th><th rowspan=2 colspan=2><font size=\"3\">Paid Amt</font></th><th rowspan=2  colspan=2><font size=\"3\">Pay Date</font></th><th rowspan=2 colspan=2><font size=\"3\">Credit</font></th><th rowspan=2 colspan=2><font size=\"3\">Principal</font></th><th rowspan=2 colspan=2><font size=\"3\">Interest</font></th><th rowspan=2 colspan=2><font size=\"3\">Arrear</font></th></tr>");
                    out.println("<tr></tr>");
                }
                flag = false;
                DateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd");
                String s = (String) alrow.get(11);
                if (s != null) {
                    dt1 = formatter1.parse(s);
                } else {
                    dt1 = null;
                }

                //dt=(Calendar)alrow.get(11);
                if (dt1 == null) {
                    bl_per_fr = " ";
                } else {
                    formatter = new SimpleDateFormat("dd-MMM-yy");
                    bl_per_fr = formatter.format(new java.sql.Date(dt1.getTime()));
                }

                s = (String) alrow.get(12);
                if (s != null) {
                    dt1 = formatter1.parse(s);
                } else {
                    dt1 = null;
                }
                // dt=(Calendar)alrow.get(12);
                if (dt1 == null) {
                    bl_per_to = " ";
                } else {
                    formatter = new SimpleDateFormat("dd-MMM-yy");
                    bl_per_to = formatter.format(new java.sql.Date(dt1.getTime()));

                }

                s = (String) alrow.get(17);

                if (s != null && !(s.trim().equals("null"))) {
                    dt1 = formatter1.parse(s);
                } else {
                    dt1 = null;
                }
                //dt=(Calendar)alrow.get(17);
                if (dt1 == null) {
                    pay_date = " ";
                } else {
                    formatter = new SimpleDateFormat("dd-MMM-yy");
                    pay_date = formatter.format(new java.sql.Date(dt1.getTime()));
                }

                rate = Double.parseDouble(alrow.get(14).toString().trim());
                paid_amt = Double.parseDouble(alrow.get(16).toString().trim());
                credit = Double.parseDouble(alrow.get(20).toString().trim());
                principal = Double.parseDouble(alrow.get(28).toString().trim());
                arrear = Double.parseDouble(alrow.get(19).toString().trim());
                cssarrear = Double.parseDouble(alrow.get(31).toString().trim());
                cssrate = Double.parseDouble(alrow.get(33).toString().trim());
                interest = Double.parseDouble(alrow.get(34).toString().trim());

                rate = roundTwoDecimals(rate);
                paid_amt = roundTwoDecimals(paid_amt);
                credit = roundTwoDecimals(credit);
                principal = roundTwoDecimals(principal);
                interest = roundTwoDecimals(interest);
                arrear = roundTwoDecimals(arrear);
                cssarrear = roundTwoDecimals(cssarrear);
                cssrate = roundTwoDecimals(cssrate);

                out.println("<tr><th colspan=2><font size=\"3\">" + bl_per_fr + "</font></th><th colspan=2><font size=\"3\">" + bl_per_to + "</font></th><th colspan=2><font size=\"3\">" + rate + "</font></th><th colspan=2><font size=\"3\">" + paid_amt + "</font></th><th colspan=2><font size=\"3\">" + pay_date + "</font></th><th colspan=2><font size=\"3\">" + credit + "</font></th><th colspan=2><font size=\"3\">" + principal + "</font></th><th colspan=2><font size=\"3\">" + interest + "</font></th><th colspan=2><font size=\"3\">" + arrear + "</font></th></tr>");
                //out.println("<tr></tr>");


            }//end of inner if clause





            out.println("</table>");

        } catch (Exception et) {
            et.printStackTrace();
        }


    }
}
