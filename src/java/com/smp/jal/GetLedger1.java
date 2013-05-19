/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.smp.jal;

import bill.generator.LedgerCalculation;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.FontSelector;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
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
public class GetLedger1 extends HttpServlet {



    double roundTwoDecimals(double d)
     {
        	DecimalFormat df = new DecimalFormat("#.##");
		return Double.valueOf(df.format(d));
      }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    String cons_no;
    String sec=null;
    String division;
    ArrayList <ArrayList> al;
    ArrayList <ArrayList> alsec;
    Calendar billdate=Calendar.getInstance();
    DocumentBuilderFactory dbf=null;
    DocumentBuilder db=null;
    org.w3c.dom.Document doc=null;
    NodeList nl=null;
    String xmlpath=null;
    ServletContext context=null;
    int x=0;
    Object o;
   // MyPdf pdf;



    ArrayList alrow;
    java.sql.Date dt;
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

  int rows;


   boolean flag4=false;

   Format formatter;

    String cons_nm1=null;

    String blk_no=null;
    String flat_no=null;


    String bl_per_fr=null;
    String bl_per_to=null;
    double rate=0 ,rate1=0;

    double arrear=0;
    double interest=0;


    String pay_date=null;
    double paid_amt=0;
    double credit=0;
    double principal=0;
    double cssarrear=0;
    double cssrate=0;


    ByteArrayOutputStream baos;
    String alist;
    ArrayList alr1=null;
    java.util.Date dt1;

    alr1=new ArrayList();

                    rows=al.size();
                    //Rectangle pageSize = new Rectangle(864, 1080);
 	            Document document1 = new Document(PageSize.A4);

                       baos = new ByteArrayOutputStream();
                       PdfWriter docWriter = null;
                       docWriter = PdfWriter.getInstance(document1, baos);

                       document1.open();
                       float[] widths1 = {1.4f,1f,1f,1f,1f,1f,1f,1.2f,1f};
PdfPTable table=new PdfPTable(widths1);

table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
    FontSelector fontselectorhd = new FontSelector();
    fontselectorhd.addFont(new Font(Font.TIMES_ROMAN,13));
    Phrase ph1=fontselectorhd.process("NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY");
    PdfPCell cell = new PdfPCell(new Paragraph(ph1));
    cell.setBorder(Rectangle.NO_BORDER);
    cell.setColspan (9);
    cell.setHorizontalAlignment (Element.ALIGN_CENTER);
    cell.setPaddingBottom(10.0f);
    table.addCell (cell);

  FontSelector fontselectorhd1 = new FontSelector();
  fontselectorhd1.addFont(new Font(Font.TIMES_ROMAN,11));
    Phrase ph2=fontselectorhd1.process("LEDGER FOR CONSUMER NUMBER - "+cons_no);
   // PdfPCell cell = new PdfPCell(new Paragraph(ph2));
    cell = new PdfPCell(new Paragraph(ph2));
    cell.setBorder(Rectangle.NO_BORDER);
    cell.setColspan (9);
    cell.setHorizontalAlignment (Element.ALIGN_CENTER);
    cell.setPaddingBottom(20.0f);
    table.addCell (cell);

                   flag4=true;


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
                  blk_no=(String)alrow.get(7);
                   if(blk_no==null||blk_no.trim().equals("null"))
                      blk_no=" ";
                   else
                       blk_no=blk_no.trim();
                  flat_no= (String)alrow.get(6);
                       if(flat_no==null||flat_no.trim().equals("null"))
                      flat_no=" ";
                       else
                          flat_no=flat_no.trim();



                  if(flag4==true)
                  {
                       FontSelector fontselector1 = new FontSelector();
  fontselector1.addFont(new Font(Font.TIMES_ROMAN,12));
    Phrase ph3=fontselector1.process("Consumer No:");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                   table.addCell (cell);
ph3=fontselector1.process(cons_no);
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                   table.addCell (cell);
ph3=fontselector1.process("Consumer Name:");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                   cell.setColspan(2);
                   table.addCell (cell);
                 
                    FontSelector fontselector13 = new FontSelector();
                    fontselector13.addFont(new Font(Font.TIMES_ROMAN,11));
    Phrase ph4=fontselector13.process(cons_nm1);
                   cell = new PdfPCell(new Paragraph(ph4));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setColspan (3);
                   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                   table.addCell (cell);
ph3=fontselector1.process("Address:");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                   table.addCell (cell);
  ph4=fontselector1.process(blk_no+"-"+flat_no+"/"+sec);
                   cell = new PdfPCell(new Paragraph(ph4));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                   table.addCell (cell);

                   fontselector1.addFont(new Font(Font.TIMES_ROMAN,8));
     ph3=fontselector1.process("Bill Period");

                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setColspan(2);
                   cell.setHorizontalAlignment (Element.ALIGN_CENTER);
                   table.addCell (cell);
  ph3=fontselector1.process("Rate");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
ph3=fontselector1.process("Paid Amount");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
ph3=fontselector1.process("Pay Date");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
ph3=fontselector1.process("Credit");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
ph3=fontselector1.process("Principal Amount");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
ph3=fontselector1.process("Remaining Interest");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
ph3=fontselector1.process("Arrear");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);


                  }


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
                    NumberFormat formatterno = new DecimalFormat("#0.00");
                  formatterno.format(rate);
                  paid_amt=roundTwoDecimals(paid_amt);
                  credit=roundTwoDecimals(credit);
                  principal=roundTwoDecimals(principal);
                  interest=roundTwoDecimals(interest);
                  arrear=roundTwoDecimals(arrear);
                  cssarrear=roundTwoDecimals(cssarrear);
                  cssrate=roundTwoDecimals(cssrate);

     FontSelector fontselector1 = new FontSelector();
     fontselector1.addFont(new Font(Font.BOLD,10));
      Phrase ph3=fontselector1.process(bl_per_fr);
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                 table.addCell (cell);

                   ph3=fontselector1.process(bl_per_to);
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                   table.addCell (cell);

                // table.addCell (bl_per_to);
  ph3=fontselector1.process(formatterno.format(rate));
                 cell = new PdfPCell(new Paragraph(ph3));
                 cell.setBorder(Rectangle.NO_BORDER);
                 cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                 table.addCell (cell);
//start from  here
                   ph3=fontselector1.process(formatterno.format(paid_amt));
                 cell = new PdfPCell(new Paragraph(ph3));
                 cell.setBorder(Rectangle.NO_BORDER);
                 cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                 table.addCell (cell);
                 //table.addCell (Double.toString(paid_amt));
                   ph3=fontselector1.process(pay_date);
                 cell = new PdfPCell(new Paragraph(ph3));
                 cell.setBorder(Rectangle.NO_BORDER);
                 cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                 table.addCell (cell);
  ph3=fontselector1.process(formatterno.format(credit));
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                table.addCell (cell);
 ph3=fontselector1.process(formatterno.format(principal));
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                table.addCell (cell);
                 ph3=fontselector1.process(formatterno.format(interest));
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                table.addCell (cell);
                    ph3=fontselector1.process(formatterno.format(arrear));
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                table.addCell (cell);

                flag4=false;
                   }

                   cell = new PdfPCell(new Paragraph(""));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setColspan (12);
                   cell.setPaddingBottom(20.0f);
                   table.addCell (cell);


table.setWidthPercentage(100);
table.setHorizontalAlignment(Element.ALIGN_CENTER);


document1.add(table);

                        document1.add(new Paragraph("  "));
                        document1.close();
                        docWriter.close();

                        response.setHeader("Expires", "0");
			response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
			response.setHeader("Pragma", "public");
                        response.setContentType("application/pdf");
                        response.setHeader("Content-Disposition","attachment;filename="+cons_no+".pdf" );

                        response.setContentLength(baos.size());

                        ServletOutputStream out = response.getOutputStream();
		        baos.writeTo(out);
                        out.flush();






        }
        catch(Exception ex)
        {
           System.out.println(ex);
        }
    }


 private void isError(ServletOutputStream stream) throws IOException
  {
		stream.print("<html>\n\t<head>\n\t\t<title>Error</title>\n\t</head>\n\t<body>");
		stream.print("An error occured.\n\t</body>\n</html>");
  }






    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
/*
   String cons_no=null;
   String sec;

  int rows;
   ArrayList <ArrayList> al=null;
   ArrayList  alrow;

   boolean flag4=false;

   Format formatter;

    String cons_nm1=null;
    sec=null;
    String blk_no=null;
    String flat_no=null;


    String bl_per_fr=null;
    String bl_per_to=null;
    double rate=0 ,rate1=0;

    double arrear=0;
    double interest=0;


    String pay_date=null;
    double paid_amt=0;
    double credit=0;
    double principal=0;
    double cssarrear=0;
    double cssrate=0;

    Calendar dt;
    ByteArrayOutputStream baos;
    String alist;
    ArrayList alr1=null;
    java.util.Date dt1;

    alr1=new ArrayList();
    al=new ArrayList<ArrayList>();



          cons_no=request.getParameter("cons_no");


          alist=request.getParameter("al");

          //alist=alist.substring(alist.indexOf("[")+1,alist.lastIndexOf("]"));

          alist=alist.substring(alist.indexOf("[")+1,alist.lastIndexOf("]"));

          String[] aliststr=alist.split("]");

          for(int l=0;l<aliststr.length;l++)
            {
              String[] alstr=aliststr[l].split(",");
              for(int m=0;m<alstr.length;m++)
               {
                 if(m==0&&l==0)
                    alr1.add(alstr[m].substring(1));
                 else if(m==1&&l!=0)
                     alr1.add(alstr[m].substring(2));
                 else if(m!=0)
                     alr1.add(alstr[m]);
                }
                al.add(new ArrayList(alr1));
                alr1.clear();
            }


                    sec=request.getParameter("sec");

                    rows=al.size();
                    //Rectangle pageSize = new Rectangle(864, 1080);
 	            Document document1 = new Document(PageSize.A4);
		try
                {


                       baos = new ByteArrayOutputStream();
                       PdfWriter docWriter = null;
                       docWriter = PdfWriter.getInstance(document1, baos);


                      //pageSize.BackgroundColor = new Color(0xFF, 0xFF, 0xDE);
                      //Document document = new Document(pageSize);

                      //document1.setPageSize(PageSize.ARCH_B);
                       document1.open();
                       float[] widths1 = {1.4f,1f,1f,1f,1f,1f,1f,1.2f,1f};
PdfPTable table=new PdfPTable(widths1);

table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
    FontSelector fontselectorhd = new FontSelector();
    fontselectorhd.addFont(new Font(Font.TIMES_ROMAN,13));
    Phrase ph1=fontselectorhd.process("NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY");
    PdfPCell cell = new PdfPCell(new Paragraph(ph1));
    cell.setBorder(Rectangle.NO_BORDER);
    cell.setColspan (9);
    cell.setHorizontalAlignment (Element.ALIGN_CENTER);
    cell.setPaddingBottom(10.0f);
    table.addCell (cell);

  FontSelector fontselectorhd1 = new FontSelector();
  fontselectorhd1.addFont(new Font(Font.TIMES_ROMAN,11));
    Phrase ph2=fontselectorhd1.process("LEDGER FOR CONSUMER NUMBER - "+cons_no);
   // PdfPCell cell = new PdfPCell(new Paragraph(ph2));
    cell = new PdfPCell(new Paragraph(ph2));
    cell.setBorder(Rectangle.NO_BORDER);
    cell.setColspan (9);
    cell.setHorizontalAlignment (Element.ALIGN_CENTER);
    cell.setPaddingBottom(20.0f);
    table.addCell (cell);

                   flag4=true;


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
                  blk_no=(String)alrow.get(7);
                   if(blk_no==null||blk_no.trim().equals("null"))
                      blk_no=" ";
                   else
                       blk_no=blk_no.trim();
                  flat_no= (String)alrow.get(6);
                       if(flat_no==null||flat_no.trim().equals("null"))
                      flat_no=" ";
                       else
                          flat_no=flat_no.trim();



                  if(flag4==true)
                  {
                       FontSelector fontselector1 = new FontSelector();
  fontselector1.addFont(new Font(Font.TIMES_ROMAN,12));
    Phrase ph3=fontselector1.process("Consumer No:");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                   table.addCell (cell);
ph3=fontselector1.process(cons_no);
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                   table.addCell (cell);
ph3=fontselector1.process("Consumer Name:");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                   cell.setColspan(2);
                   table.addCell (cell);
                  // FontSelector fontselector12 = new FontSelector();
 /// fontselector1.addFont(new Font(Font.TIMES_ROMAN,9));
                    FontSelector fontselector13 = new FontSelector();
                    fontselector13.addFont(new Font(Font.TIMES_ROMAN,11));
    Phrase ph4=fontselector13.process(cons_nm1);
                   cell = new PdfPCell(new Paragraph(ph4));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setColspan (3);
                   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                   table.addCell (cell);
ph3=fontselector1.process("Address:");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                   table.addCell (cell);
  ph4=fontselector1.process(blk_no+"-"+flat_no+"/"+sec);
                   cell = new PdfPCell(new Paragraph(ph4));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                   table.addCell (cell);

                   fontselector1.addFont(new Font(Font.TIMES_ROMAN,8));
     ph3=fontselector1.process("Bill Period");

                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setColspan(2);
                   cell.setHorizontalAlignment (Element.ALIGN_CENTER);
                   table.addCell (cell);
  ph3=fontselector1.process("Rate");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
ph3=fontselector1.process("Paid Amount");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
ph3=fontselector1.process("Pay Date");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
ph3=fontselector1.process("Credit");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
ph3=fontselector1.process("Principal Amount");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
ph3=fontselector1.process("Remaining Interest");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
ph3=fontselector1.process("Arrear");
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.BOTTOM);
                   cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                   table.addCell (cell);
                  }


               DateFormat formatter1=new SimpleDateFormat("yyyy-MM-dd");
                String s=(String)alrow.get(11);
                  if(s!=null)
                  dt1=formatter1.parse(s);
                  else
                  dt1=null;

                   //dt=(Calendar)alrow.get(11);
                   if(dt1==null)
                      bl_per_fr=" ";
                   else
                     {

                       formatter = new SimpleDateFormat("dd-MMM-yy");
                        bl_per_fr= formatter.format(new java.sql.Date(dt1.getTime()));

                      }

                    s=(String)alrow.get(12);
                   if(s!=null)
                  dt1=formatter1.parse(s);
                  else
                  dt1=null;
                  // dt=(Calendar)alrow.get(12);
                   if(dt1==null)
                      bl_per_to=" ";
                   else
                     {
                        formatter = new SimpleDateFormat("dd-MMM-yy");
                        bl_per_to= formatter.format(new java.sql.Date(dt1.getTime()));

                      }

                    s=(String)alrow.get(17);

                    if(s!=null && !(s.trim().equals("null")))
                  dt1=formatter1.parse(s);
                  else
                  dt1=null;
                    //dt=(Calendar)alrow.get(17);
                  if(dt1==null)
                      pay_date=" ";
                   else
                     {

                       formatter = new SimpleDateFormat("dd-MMM-yy");
                        pay_date= formatter.format(new java.sql.Date(dt1.getTime()));

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
                    NumberFormat formatterno = new DecimalFormat("#0.00");
                  formatterno.format(rate);
                  paid_amt=roundTwoDecimals(paid_amt);
                  credit=roundTwoDecimals(credit);
                  principal=roundTwoDecimals(principal);
                  interest=roundTwoDecimals(interest);
                  arrear=roundTwoDecimals(arrear);
                  cssarrear=roundTwoDecimals(cssarrear);
                  cssrate=roundTwoDecimals(cssrate);

     FontSelector fontselector1 = new FontSelector();
     fontselector1.addFont(new Font(Font.BOLD,10));
      Phrase ph3=fontselector1.process(bl_per_fr);
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                 table.addCell (cell);

                 // FontSelector fontselector1 = new FontSelector();
  //fontselector1.addFont(new Font(Font.TIMES_ROMAN,8));
                   ph3=fontselector1.process(bl_per_to);
                   cell = new PdfPCell(new Paragraph(ph3));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setPaddingBottom(10.0f);
                   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                   table.addCell (cell);

                // table.addCell (bl_per_to);
  ph3=fontselector1.process(formatterno.format(rate));
                 cell = new PdfPCell(new Paragraph(ph3));
                 cell.setBorder(Rectangle.NO_BORDER);
                 cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                 table.addCell (cell);
//start from  here
                   ph3=fontselector1.process(formatterno.format(paid_amt));
                 cell = new PdfPCell(new Paragraph(ph3));
                 cell.setBorder(Rectangle.NO_BORDER);
                 cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                 table.addCell (cell);
                 //table.addCell (Double.toString(paid_amt));
                   ph3=fontselector1.process(pay_date);
                 cell = new PdfPCell(new Paragraph(ph3));
                 cell.setBorder(Rectangle.NO_BORDER);
                 cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                 table.addCell (cell);
  ph3=fontselector1.process(formatterno.format(credit));
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                table.addCell (cell);
 ph3=fontselector1.process(formatterno.format(principal));
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                table.addCell (cell);
                 ph3=fontselector1.process(formatterno.format(interest));
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                table.addCell (cell);
                    ph3=fontselector1.process(formatterno.format(arrear));
                cell = new PdfPCell(new Paragraph(ph3));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
                table.addCell (cell);

               /* table.addCell (Double.toString(cssrate));
                //table.addCell (Double.toString(cssarrear));/
                flag4=false;
                   }

                   cell = new PdfPCell(new Paragraph(""));
                   cell.setBorder(Rectangle.NO_BORDER);
                   cell.setColspan (12);
                   cell.setPaddingBottom(20.0f);
                   table.addCell (cell);


table.setWidthPercentage(100);
table.setHorizontalAlignment(Element.ALIGN_CENTER);


document1.add(table);

//document1.newPage();

                        document1.add(new Paragraph("  "));
                        document1.close();
                        docWriter.close();

                        response.setHeader("Expires", "0");
			response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
			response.setHeader("Pragma", "public");
                        response.setContentType("application/pdf");
                        response.setHeader("Content-Disposition","attachment;filename="+cons_no+".pdf" );

                        response.setContentLength(baos.size());

                        ServletOutputStream out = response.getOutputStream();
		        baos.writeTo(out);
                        out.flush();


		}
              catch(Exception e)
                {
			e.printStackTrace();

                            response.sendRedirect("jsppages/billing/ledgergen.jsp");
                            return;
                 }

                 /*finally
                 {
                      path=request.getParameter("path");
                          File f=new File(path);
                          if(f.exists())
                              f.delete();
                 }*/
        //processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}