
package com.smp.jal;
import bill.generator.LedgerCalculation;
import java.io.PrintWriter;

import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.NodeList;



/**
 *
 * @author smp
 */
public class ExcelGen1 extends HttpServlet {


double roundTwoDecimals(double d)
     {
        	DecimalFormat df = new DecimalFormat("#.##");
		return Double.valueOf(df.format(d));
      }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
     String cons_no=null;
     String sec=null;
     String division;
     String form;

     int k=0;
     int rows;
     String alist;
     ArrayList alr1;
     ArrayList alrow;
     ArrayList<ArrayList> al;
     String ledger;
      String cons_nm1=null;
    sec=null;
    String blk_no=null;
    String flat_no=null;


    String bl_per_fr=null;
    String bl_per_to=null;
    double rate=0;

    double arrear=0;
    double interest=0;
     Format formatter;
    String address;
    String pay_date=null;
    double paid_amt=0;
    double credit=0;
    double principal=0;
    double cssarrear=0;
    double cssrate=0;
    java.util.Date dt1;
    java.sql.Date dt;
    boolean flag=true;



    DocumentBuilderFactory dbf=null;
    DocumentBuilder db=null;
    org.w3c.dom.Document doc=null;
    NodeList nl=null;
    String xmlpath=null;
    ServletContext context=null;
    ArrayList <ArrayList> alsec;
    Calendar billdate=Calendar.getInstance();



    int x=0;
    Object o;
   // MyPdf pdf;




    String strbilldate;

    int  yy ;
    int mm;
   int  dd;

    int p=0;
        try
        {
            HttpSession session=request.getSession();
          cons_no=request.getParameter("cons_no");
          if(cons_no!=null&& !cons_no.equals(""))
                  {
                     int l= (int)cons_no.charAt(7);
                     if(l>=65&&l<=90 )
                       x=Integer.parseInt(cons_no.substring(0,2));
                      else
                        x=Integer.parseInt(cons_no.substring(0,3));
                      sec=Integer.toString(x);
                     if(x<10)
                       {
                        sec=Integer.toString(x);
                        sec="0"+sec;
                        }
                  }

//           if(sec.equals("01")||sec.equals("02")||sec.equals("03")||sec.equals("04")||sec.equals("05")||sec.equals("06")||sec.equals("07")||sec.equals("08")||sec.equals("09")||sec.equals("10")||sec.equals("11")||sec.equals("11IND")||sec.equals("12")||
//                sec.equals("14")||sec.equals("14A")||sec.equals("15A")||sec.equals("16A")||sec.equals("15")||sec.equals("16")||sec.equals("17")||sec.equals("18")||sec.equals("19")||sec.equals("22")||sec.equals("23")|| sec.equals("24")||sec.equals("27")||sec.equals("55")||sec.equals("56")||sec.equals("57")||
//                sec.equals("58")||sec.equals("59")|| sec.equals("60")||sec.equals("62")||sec.equals("63")||sec.equals("64")||sec.equals("65")||sec.equals("105"))
//               {
//                   division="JAL1";
//                }
//              else if(sec.equals("20")||sec.equals("21")||sec.equals("21A")||sec.equals("25")||sec.equals("26")||sec.equals("28")||sec.equals("29")||sec.equals("30")||sec.equals("31")||sec.equals("33")||sec.equals("33A")||sec.equals("34")||sec.equals("35")||
//                sec.equals("36")||sec.equals("37")||sec.equals("37ADD")||sec.equals("52")||sec.equals("53")||sec.equals("61")||sec.equals("71")||sec.equals("72"))
//              {
//                division="JAL2";
//               }
//             else if(sec.equals("39")||sec.equals("40")||sec.equals("41")||sec.equals("43")||sec.equals("44")||sec.equals("46")||sec.equals("47") ||sec.equals("48")||sec.equals("49")||sec.equals("50")||sec.equals("51")||sec.equals("52")||sec.equals("73")||sec.equals("80")||sec.equals("81")||sec.equals("82")||sec.equals("83")||sec.equals("84")||sec.equals("94")||sec.equals("95")||sec.equals("92")||sec.equals("93"))
//               {
//                division="JAL3";
//               }
        dbf = DocumentBuilderFactory.newInstance();
            db = dbf.newDocumentBuilder();
            doc = db.parse(xmlpath);
            SelectSec_Div sec_Div = new SelectSec_Div();
            division = sec_Div.getDevision(sec, doc);
          mm=billdate.get(Calendar.MONTH);
          yy=billdate.get(Calendar.YEAR);
          dd=billdate.get(Calendar.DATE);

          if(mm>=3 && mm<=11)
              yy++;



           billdate.set(yy,2,31);
           dt=new java.sql.Date(billdate.getTimeInMillis());
           strbilldate=dt.toString();

           dbf = DocumentBuilderFactory.newInstance();
           db = dbf.newDocumentBuilder();

           context = getServletContext();
           xmlpath=context.getRealPath("")+"/resources/jalutilXML/"+"jal.xml";
         
            LedgerCalculation lc=new LedgerCalculation();
              al=lc.calbillCl(cons_no,billdate,sec,xmlpath);
                        for(int m=0;m<al.size();m++)
                               {
                                   alrow=al.get(m);

                                      if(alrow.get(11)!=null)
                                       {
                                        dt=new java.sql.Date(((Calendar)alrow.get(11)).getTimeInMillis());
                                       // alrow.set(11, dt);

                                         alrow.add(11, dt);
                                         alrow.remove(12);
                                       }
                                      if(alrow.get(12)!=null)
                                       {
                                         dt= new java.sql.Date(((Calendar)alrow.get(12)).getTimeInMillis());
                                         //alrow.set(12, dt);

                                         alrow.add(12, dt);
                                         alrow.remove(13);
                                        }
                                      if(alrow.get(17)!=null)
                                       {
                                         dt= new java.sql.Date(((Calendar)alrow.get(17)).getTimeInMillis());
                                        // alrow.set(17, dt);

                                         alrow.add(17, dt);
                                         alrow.remove(18);
                                        }
                                      if(alrow.get(21)!=null)
                                        {
                                         dt=new java.sql.Date(((Calendar)alrow.get(21)).getTimeInMillis());
                                         //alrow.set(21, dt);

                                          alrow.add(21, dt);
                                          alrow.remove(22);
                                         }

                                      if(alrow.get(23)!=null)
                                        {
                                         dt= new java.sql.Date(((Calendar)alrow.get(23)).getTimeInMillis());
                                         //alrow.set(21, dt);

                                          alrow.add(23, dt);
                                          alrow.remove(24);
                                         }
                          }







     cons_no=request.getParameter("cons_no");
     response.setHeader("Cache-Control","Max-age=0");
     response.setHeader("Pragma","public");
     response.setDateHeader ("Expires", 0);
     response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-Disposition","attachment;filename="+cons_no+".xls" );

        ledger="LEDGER FOR CONSUMER NUMBER-"+cons_no;
    
    
          
          
            PrintWriter out=response.getWriter();
            out.println("<table border=\"0\" width=\"100%\">");
            out.println("<tr></tr>");
            out.println("<tr><th rowspan=2 colspan=18><font size=\"3\" weight=\"normal\">NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY</font></th></tr>");
            out.println("<tr></tr>");
            out.println("<tr><th rowspan=2 colspan=18><font size=\"3\" weight=\"normal\">"+ledger+"</font></th></tr>");
            out.println("<tr></tr>");

                 rows=al.size();
                     flag=true;
                    int r=al.size();
                   for(int j=0;j<r;j++ )
                   {
                      alrow=(ArrayList)al.get(j);
                   cons_no= (String)alrow.get(0);
                    if(cons_no==null||cons_no.trim().equals("null"))
                      cons_no=" ";
                   cons_nm1= (String)alrow.get(1);
                   if(cons_nm1==null||cons_nm1.trim().equals("null"))
                      cons_nm1=" ";
                   sec= (String)alrow.get(8);
                   if(sec==null||sec.trim().equals("null"))
                      sec=" ";
                   else
                       sec=sec.trim();
                   blk_no=(String)alrow.get(7);
                   if(blk_no==null||blk_no.trim().equals("null"))
                      blk_no=" ";
                   else
                       blk_no=blk_no.trim();
                   flat_no= (String)alrow.get(6);
                   if(flat_no==null||flat_no.equals("null"))
                      flat_no=" ";
                   else
                      flat_no=flat_no.trim();

                   address=sec.trim()+"/"+blk_no.trim()+"-"+flat_no.trim();
                   if(flag==true)
                   {
                   out.println("<tr><th rowspan=2 colspan=18><font size=\"3\">&nbsp;&nbsp;Consumer No.:&nbsp;&nbsp;"+cons_no.trim()+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Consumer Name:&nbsp;&nbsp;"+cons_nm1.trim()+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Address:&nbsp;&nbsp;"+address+"</font></th></tr>");
                   out.println("<tr></tr>");


                   out.println("<tr><th rowspan=2 colspan=2><font size=\"3\">Bill From</font></th><th rowspan=2 colspan=2><font size=\"3\">Bill Upto</font></th><th rowspan=2 colspan=2><font size=\"3\">Rate</font></th><th rowspan=2 colspan=2><font size=\"3\">Paid Amt</font></th><th rowspan=2  colspan=2><font size=\"3\">Pay Date</font></th><th rowspan=2 colspan=2><font size=\"3\">Credit</font></th><th rowspan=2 colspan=2><font size=\"3\">Principal</font></th><th rowspan=2 colspan=2><font size=\"3\">Interest</font></th><th rowspan=2 colspan=2><font size=\"3\">Arrear</font></th></tr>");
                   out.println("<tr></tr>");
                   }
                   flag=false;
                   DateFormat formatter1=new SimpleDateFormat("yyyy-MM-dd");

                   if((java.sql.Date)alrow.get(11)==null)
                      bl_per_fr=" ";
                   else
                     {

                       formatter = new SimpleDateFormat("dd-MMM-yy");
                        bl_per_fr= formatter.format((java.sql.Date)alrow.get(11));
                       }


                   if((java.sql.Date)alrow.get(12)==null)
                      bl_per_to=" ";
                   else
                     {
                        formatter = new SimpleDateFormat("dd-MMM-yy");
                        bl_per_to= formatter.format((java.sql.Date)alrow.get(12));

                      }



                  if((java.sql.Date)alrow.get(17)==null)
                      pay_date=" ";
                   else
                     {

                       formatter = new SimpleDateFormat("dd-MMM-yy");
                        pay_date= formatter.format((java.sql.Date)alrow.get(17));

                      }

                  rate=Double.parseDouble(alrow.get(14).toString().trim());
                  paid_amt=Double.parseDouble(alrow.get(16).toString().trim());
                  credit=Double.parseDouble(alrow.get(20).toString().trim());
                  principal=Double.parseDouble(alrow.get(28).toString().trim());
                  arrear=Double.parseDouble(alrow.get(19).toString().trim());
                  cssarrear=Double.parseDouble(alrow.get(31).toString().trim());
                  cssrate=Double.parseDouble(alrow.get(33).toString().trim());
                  interest=Double.parseDouble(alrow.get(34).toString().trim());

                  rate=roundTwoDecimals(rate);
                  paid_amt=roundTwoDecimals(paid_amt);
                  credit=roundTwoDecimals(credit);
                  principal=roundTwoDecimals(principal);
                  interest=roundTwoDecimals(interest);
                  arrear=roundTwoDecimals(arrear);
                  cssarrear=roundTwoDecimals(cssarrear);
                  cssrate=roundTwoDecimals(cssrate);

                            out.println("<tr><th colspan=2><font size=\"3\">"+bl_per_fr+"</font></th><th colspan=2><font size=\"3\">"+bl_per_to+"</font></th><th colspan=2><font size=\"3\">"+rate+"</font></th><th colspan=2><font size=\"3\">"+paid_amt+"</font></th><th colspan=2><font size=\"3\">"+pay_date+"</font></th><th colspan=2><font size=\"3\">"+credit+"</font></th><th colspan=2><font size=\"3\">"+principal+"</font></th><th colspan=2><font size=\"3\">"+interest+"</font></th><th colspan=2><font size=\"3\">"+arrear+"</font></th></tr>");
                            //out.println("<tr></tr>");


                    }//end of inner if clause

           



        out.println("</table>");

        }catch (Exception et)
        {
            et.printStackTrace ();
        }


    }
}

