/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package billservlet;

import bill.generator.BillCalculation1;
//import bill.utility.DBConnection1;
import com.smp.jal.ConvertToDate;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import javax.naming.InitialContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
//import oracle.jdbc.OracleConnection;
//import oracle.jdbc.OraclePreparedStatement;
import org.w3c.dom.NodeList;

/**
 *
 * @author smp
 */
public class CalBill extends HttpServlet {

    DocumentBuilderFactory dbf;
    DocumentBuilder db;
        org.w3c.dom.Document doc=null;
    ServletContext context;
    String xmlpath;

    public class MyPdf implements Runnable{

     private boolean threadd=false;

     int p=0;
     int j=0;
     String tname;
     java.sql.Date dt;
     Thread t2;
     String cons_no="-1";
     ArrayList al;
     Calendar calbilldate;
     Calendar due_dt;
     String sec;
     int rows;
     ArrayList alrow;
     ArrayList<ArrayList> alsec;
     BillCalculation1 bc;
     String sector;
     java.sql.Date billdate;
  Connection con;
     String chl_tab;
     int totcons=-1;
     ResultSet rs,rs1;
   PreparedStatement ps;
     String sql;
     boolean flag=true;
     java.sql.Date billfr;


//int totcons=0;

    MyPdf()
    {}
   MyPdf(String threadname,java.sql.Date bill_fr,Calendar clbilldate,Calendar duedt,String sec1,int totalcons, Connection cn,ResultSet resultSet,String challan_tab)
   {
   tname=threadname;
   t2=new Thread(this,tname);
   calbilldate= clbilldate;
   due_dt=duedt;
   sec=sec1;
   totcons=totalcons;
   rs=resultSet;
   chl_tab=challan_tab;
   billfr=bill_fr;
   con=cn;
   bc=new BillCalculation1();
   alsec=new ArrayList<ArrayList>();
   t2.start();

   }

  /////////////////////////////////////////////////////

  public void done(boolean b)
  {
       threadd=b;
       p=totcons;

  }

    /////////////////////////////////////////////////////
            public void run()
                {
                  ///////////////
                  /*while (!threadDone)
                  {*/
                  /////////////////

                   try
                     {
                              while(rs.next()&& !threadd)
                                {

                                   p++;
                                  cons_no=rs.getString(1);
                                   sql="select DISTINCT bl_per_fr from "+chl_tab+" where cons_no='"+cons_no+"' and to_char(bl_per_fr,'YYYY-MM-DD')='"+billfr+"'";
                                ps=con.prepareStatement(sql);
                                rs1=ps.executeQuery();
                                if(!rs1.next())
                                {
                                  al=bc.calbillCl(cons_no,calbilldate,due_dt,sec,xmlpath);
                                  rows=al.size();
                                  alrow=(ArrayList)al.get(rows-1);
                                         if(al.size()!=0)
                                         {
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

                               alsec.add(new ArrayList(alrow));
                                  alrow.clear();
                                  al.clear();
                                 }
                             }
                                  //////////////////////////////////////////////////
                                  /*if(p==10)
                                  {
                                      done();
                                      return;
                                  }*/
                                  ///////////////////////////////////////////////////
                                  Thread.sleep(500);

                            }

                                rs.close();
                                con.commit();
                                con.close();
//                               if(!con.isClosed())
//                                {
//                                  con.close();
//                                }
                              }catch(Exception ex)
                                {
                                 System.out.println("Exception in main:"+ex);
                                }

                 ///////////
                    //}
                 //////////
                //  p=totcons;

     }

    public  ArrayList<ArrayList>  calAl()
    {

			return alsec;
		}


		public int getPercentage() {

                    return  p;
		}

}

    public class MyPdfCons implements Runnable{

     int p=0;
     int j=0;
     String tname;
     java.sql.Date  dt;
     Thread t1;
     String cons_no;
     ArrayList al;
     Calendar calbilldate;
     Calendar due_dt;
     String sec;
     int rows;
     ArrayList alrow;
     ArrayList<ArrayList> alsec=null;
     BillCalculation1 bc;

 MyPdfCons(String threadname,String cons,Calendar clbilldate,Calendar duedt,String sec1 )
 {
   tname=threadname;
   t1=new Thread(this,tname);
   cons_no=cons;
   calbilldate= clbilldate;
   due_dt=duedt;
   sec=sec1;
    alsec=new ArrayList<ArrayList>();
   t1.start();

 }

                public void run()
                 {

                   try
                     {
                       dbf = DocumentBuilderFactory.newInstance();
                       db = dbf.newDocumentBuilder();

                       context = getServletContext();
                       xmlpath=context.getRealPath("")+"/resources/jalutilXML/"+"jal.xml";  // get path on the server

                       if(p<1)
                       {
                         bc=new BillCalculation1();
                         al=bc.calbillCl(cons_no,calbilldate,due_dt,sec,xmlpath);
                         rows=al.size();
                         alrow=(ArrayList)al.get(rows-1);

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
                                    if(al.size()!=0)
                         alsec.add(new ArrayList(alrow));
                         alrow.clear();
                              al.clear();
                         //Thread.sleep(100);
                         p++;

                       }

                      }catch(Exception ex)
                            {
                             System.out.println("Exception in calbill:"+ex);
                            }
                  p=1;

                  }

   public  ArrayList<ArrayList>  calAl() {

			return alsec;
		}


		public int getPercentage() {
                    return  p;
		}

}



    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
    String userid;
    String cons_no=null;
    String sec=null;
    Calendar due_dt=Calendar.getInstance();
    String discount=null;
    BillCalculation1 bc;

    String f1=null;
    String f2=null;
    Connection con;
    String sector;
    String chl_tab;
    String form=null;

    Calendar calbilldate=Calendar.getInstance();
    Calendar calbillfr=Calendar.getInstance();
    java.sql.Date billfr=null;

    java.sql.Date billdate;
    String bdate=null;
    ConvertToDate ctd;

    ArrayList<ArrayList> alsec;
    ResultSet rs,rs1;
    RequestDispatcher rd;
    PreparedStatement ps,ps1;
    ArrayList al=null;
    int totcons=0;

    Object o;
    String division;

    int x;
    String blk;
    String con_tp;
    String cons_no_fr;
    String cons_no_to;
    String sql1=null;
    String sql=null;
    String page=null;


    String div=null;
    String strdue_dt=null;
    String strbill_date=null;
    String strbill_fr=null;

    int i=0;

                HttpSession session = request.getSession(true);

                System.out.print("Inside doPost()");
                //System.out.println("Consumer number:"+cons_no);
                MyPdf pdf;
                MyPdfCons pdfcons;
                ctd=new ConvertToDate();

      try {
           InitialContext initialContext = new InitialContext();
                           DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                        con= dataSource.getConnection();
           userid=(String)session.getAttribute("userid");

              alsec=new <ArrayList>ArrayList();
              bc=new BillCalculation1();


              f1=request.getParameter("f1");
              f2=request.getParameter("f2");
              if(f1==null)
                  form=f2;
              else
                  form=f1;

              System.out.println("form-------------------------------"+form);

              if(form.equals("f1"))
              {
                   page=request.getParameter("page");
                   cons_no=request.getParameter("cons_no");
                  bdate=request.getParameter("bill_fr");
                   strbill_fr=bdate;
                   if(bdate.equals(""))
                   {
                     calbillfr=null;
                     billfr=null;
                   }
                   else
                   {
                     calbillfr.setTimeInMillis(ctd.convertStringToCLDate(bdate).getTimeInMillis());
                     billfr=new java.sql.Date(calbillfr.getTimeInMillis());
                   }
                   //sec=request.getParameter("sec");
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
                   bdate=request.getParameter("due_dt");
                   strdue_dt=bdate;
                    if(!bdate.equals(""))
                     due_dt.setTimeInMillis(ctd.convertStringToCLDate(bdate).getTimeInMillis());
                    else
                     due_dt=null;

                   bdate=request.getParameter("billdate");
                   strbill_date=bdate;
                   if(bdate.equals(""))
                   {
                     calbilldate=null;
                     billdate=null;
                   }
                   else
                   {
                     calbilldate.setTimeInMillis(ctd.convertStringToCLDate(bdate).getTimeInMillis());
                     billdate=new java.sql.Date(calbilldate.getTimeInMillis());
                   }

                   discount=request.getParameter("discount");
                     i++;


                     dbf = DocumentBuilderFactory.newInstance();
                       db = dbf.newDocumentBuilder();

                       context = getServletContext();
                       xmlpath=context.getRealPath("")+"/resources/jalutilXML/"+"jal.xml";  // get path on the server

                   //con=DBConnection1.dbConnection(xmlpath);


                   doc = db.parse(xmlpath);

                   NodeList nl1= doc.getElementsByTagName("division");

                   div=nl1.item(0).getFirstChild().getNodeValue().trim();
                   division="JAL"+div;

                   NodeList nl2= doc.getElementsByTagName("master_tab");
                   NodeList nl3= doc.getElementsByTagName("challan_tab");
                          //sector="MASTER_"+division;
                   sector=nl2.item(0).getFirstChild().getNodeValue().trim();
                   chl_tab=nl3.item(0).getFirstChild().getNodeValue().trim();

                          //sector="MASTER_"+division;

         sql="select cons_no from "+sector+" where trim(cons_no)='"+cons_no.trim()+"' and trim(sector)='"+sec+"' and CONS_NO is not null and (CONS_NM1 is  null or CON_TP is  null or CONS_CTG is  null or FLAT_TYPE is  null or (FLAT_TYPE='PLOT'and PLOT_SIZE is null) or PIPE_SIZE is  null  or CONN_DT is  null "+
               "or (CAL_DATE IS NULL and NODUE_DT IS NULL) or (( CAL_DATE IS NOT NULL and to_char(CAL_DATE,'YYYY-MM-DD')>='"+billdate+"') or (NODUE_DT IS NOT NULL  and to_char(NODUE_DT,'YYYY-MM-DD')>='"+billdate+"')))";

                    ps=con.prepareStatement(sql);
                   rs=ps.executeQuery();

                    sql="select DISTINCT bl_per_fr from "+chl_tab+" where trim(cons_no)='"+cons_no.trim()+"' and to_char(bl_per_fr,'YYYY-MM-DD')='"+billfr+"'";
                             ps1=con.prepareStatement(sql);
                             rs1=ps1.executeQuery();

                        if(rs.next()||rs1.next())
                        {
                           i=0;
                           response.sendRedirect("jsppages/billing/errorgen.jsp?cons_no="+cons_no);
                            return;

                        }

                 o = session.getAttribute("myPdfcons");

                // pdfcons= new MyPdfCons(userid,cons_no,calbilldate,due_dt,sec);
                //session.setAttribute("myPdfcons", pdfcons);
	        if (o == null)
                 {
		      pdfcons= new MyPdfCons(userid,cons_no,calbilldate,due_dt,sec);
                      session.setAttribute("myPdfcons", pdfcons);

		 }
                else
                 {
			pdfcons = (MyPdfCons) o;
		 }
            	response.setContentType("text/html");
		switch (pdfcons.getPercentage())
                {
		 case -1:
			isError(response.getOutputStream());
			return;
		 case 1:

                                 // t.destroy();
                          al=pdfcons.calAl();
                           String s=al.toString();
                           session.removeAttribute("myPdfcons");
                         isFinished(response.getOutputStream(),page,form,cons_no,discount,strbill_fr,strbill_date,strdue_dt,sec, al);

                  System.out.println("bill calculated-----------------------------");
                        	return;
                    default:
                         isBusy(pdfcons, response.getOutputStream());
                   	return;

		}

              }
              else if(form.equals("f2"))
              {
                  page=request.getParameter("page");
                  sec=request.getParameter("sec");


                   bdate=request.getParameter("bill_fr");
                   strbill_fr=bdate;
                   if(bdate.equals(""))
                   {
                     calbillfr=null;
                     billfr=null;
                   }
                   else
                   {
                     calbillfr.setTimeInMillis(ctd.convertStringToCLDate(bdate).getTimeInMillis());
                     billfr=new java.sql.Date(calbillfr.getTimeInMillis());
                   }


                  bdate=request.getParameter("due_dt");
                    strdue_dt=bdate;
                   if(!bdate.equals(""))
                      due_dt.setTimeInMillis(ctd.convertStringToCLDate(bdate).getTimeInMillis());
                   else
                    due_dt=null;
                   bdate=request.getParameter("billdate");
                     if(bdate.equals(""))
                   {
                     calbilldate=null;
                     billdate=null;
                   }
                   else
                   {
                     calbilldate.setTimeInMillis(ctd.convertStringToCLDate(bdate).getTimeInMillis());
                     billdate=new java.sql.Date(calbilldate.getTimeInMillis());
                   }
                   blk=request.getParameter("block");
                   if(!blk.equals(""))
                       blk=blk.trim().toUpperCase();
                   con_tp=request.getParameter("con_tp");
                   if(!con_tp.equals(""))
                       con_tp=con_tp.trim();
                   cons_no_fr=request.getParameter("cons_no_fr");
                   if(!cons_no_fr.equals(""))
                       cons_no_fr=cons_no_fr.trim();
                   cons_no_to=request.getParameter("cons_no_to");
                   if(cons_no_to.equals(""))
                       cons_no_to=cons_no_to.trim();
                 // discount=request.getParameter("discount");
                   ///////////////////////////////////////////
                   /////////////////////////////////////////////////
                    dbf = DocumentBuilderFactory.newInstance();
                       db = dbf.newDocumentBuilder();

                       context = getServletContext();
                       xmlpath=context.getRealPath("")+"/resources/jalutilXML/"+"jal.xml";  // get path on the server
                       doc = db.parse(xmlpath);

                       //con=DBConnection1.dbConnection(xmlpath);


                        NodeList nl1= doc.getElementsByTagName("division");

                        div=nl1.item(0).getFirstChild().getNodeValue().trim();
                        division="JAL"+div;

                        NodeList nl2= doc.getElementsByTagName("master_tab");

                        NodeList nl3=doc.getElementsByTagName("challan_tab");


                              //sector="MASTER_"+division;
                        sector=nl2.item(0).getFirstChild().getNodeValue().trim();

                        chl_tab=nl3.item(0).getFirstChild().getNodeValue().trim();

                        if(!cons_no_fr.equals("")&&!cons_no_to.equals(""))
                        {
                            sql1="select COUNT(DISTINCT CONS_NO) from "+sector+" where trim(sector)='"+sec+"' and (cons_no>='"+cons_no_fr+"' and cons_no<='"+cons_no_to+"') and CONS_NO is not null and CONS_NM1 is not null and CON_TP is not null and CONS_CTG is not null and FLAT_TYPE is not null and (FLAT_TYPE!='PLOT' or (FLAT_TYPE='PLOT'and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null" +
                                     " and (CAL_DATE IS NOT NULL or NODUE_DT IS NOT NULL) and ((CAL_DATE IS NULL or to_char(CAL_DATE,'YYYY-MM-DD')<'"+billdate+"') and (NODUE_DT IS NULL  or to_char(NODUE_DT,'YYYY-MM-DD')<'"+billdate+"')) order by cons_no";
                        }
                        else
                        {
                            if(blk.equals("")&& con_tp.equals(""))
                            {
                                sql1="select COUNT(DISTINCT CONS_NO) from "+sector+" where trim(sector)='"+sec+"' and CONS_NO is not null and CONS_NM1 is not null and CON_TP is not null and CONS_CTG is not null and FLAT_TYPE is not null and (FLAT_TYPE!='PLOT' or (FLAT_TYPE='PLOT'and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null" +
                                     " and (CAL_DATE IS NOT NULL or NODUE_DT IS NOT NULL) and ((CAL_DATE IS NULL or to_char(CAL_DATE,'YYYY-MM-DD')<'"+billdate+"') and (NODUE_DT IS NULL  or to_char(NODUE_DT,'YYYY-MM-DD')<'"+billdate+"')) order by cons_no";
                            }
                            else if(!blk.equals("") && con_tp.equals(""))
                            {
                                sql1="select COUNT(DISTINCT CONS_NO) from "+sector+" where trim(sector)='"+sec+"' and blk_no='"+blk+"' and CONS_NO is not null and CONS_NM1 is not null and CON_TP is not null and CONS_CTG is not null and FLAT_TYPE is not null and (FLAT_TYPE!='PLOT' or (FLAT_TYPE='PLOT'and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null" +
                                     " and (CAL_DATE IS NOT NULL or NODUE_DT IS NOT NULL) and ((CAL_DATE IS NULL or to_char(CAL_DATE,'YYYY-MM-DD')<'"+billdate+"') and (NODUE_DT IS NULL  or to_char(NODUE_DT,'YYYY-MM-DD')<'"+billdate+"')) order by cons_no";
                            }
                            else if(blk.equals("") && !con_tp.equals(""))
                            {
                                sql1="select COUNT(DISTINCT CONS_NO) from "+sector+" where trim(sector)='"+sec+"' and con_tp='"+con_tp+"'  and CONS_NO is not null and CONS_NM1 is not null and CON_TP is not null and CONS_CTG is not null and FLAT_TYPE is not null and (FLAT_TYPE!='PLOT' or (FLAT_TYPE='PLOT'and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null" +
                                     " and (CAL_DATE IS NOT NULL or NODUE_DT IS NOT NULL) and ((CAL_DATE IS NULL or to_char(CAL_DATE,'YYYY-MM-DD')<'"+billdate+"') and (NODUE_DT IS NULL  or to_char(NODUE_DT,'YYYY-MM-DD')<'"+billdate+"')) order by cons_no";
                            }
                            else if(!blk.equals("") && !con_tp.equals(""))
                            {
                                sql1="select COUNT(DISTINCT CONS_NO) from "+sector+" where trim(sector)='"+sec+"' and blk_no='"+blk+"' and con_tp='"+con_tp+"' and CONS_NO is not null and CONS_NM1 is not null and CON_TP is not null and CONS_CTG is not null and FLAT_TYPE is not null and (FLAT_TYPE!='PLOT' or (FLAT_TYPE='PLOT'and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null" +
                                     " and (CAL_DATE IS NOT NULL or NODUE_DT IS NOT NULL) and ((CAL_DATE IS NULL or to_char(CAL_DATE,'YYYY-MM-DD')<'"+billdate+"') and (NODUE_DT IS NULL  or to_char(NODUE_DT,'YYYY-MM-DD')<'"+billdate+"')) order by cons_no";
                            }
                        }

                              System.out.println("sql----------------"+sql1);

                             ps=con.prepareStatement(sql1);

                             rs=ps.executeQuery();

                             if(rs.next())
                             totcons=rs.getInt(1);
                        if(!cons_no_fr.equals("")&&!cons_no_to.equals(""))
                        {
                               sql="select DISTINCT CONS_NO from "+sector+" where trim(sector)='"+sec+"' and (cons_no>='"+cons_no_fr+"' and cons_no<='"+cons_no_to+"') and CONS_NO is not null and CONS_NM1 is not null and CON_TP is not null and CONS_CTG is not null and FLAT_TYPE is not null and (FLAT_TYPE!='PLOT' or (FLAT_TYPE='PLOT'and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null" +
                               " and (CAL_DATE IS NOT NULL or NODUE_DT IS NOT NULL) and ((CAL_DATE IS NULL or to_char(CAL_DATE,'YYYY-MM-DD')<'"+billdate+"') and (NODUE_DT IS NULL  or to_char(NODUE_DT,'YYYY-MM-DD')<'"+billdate+"')) order by cons_no";
                        }
                        else
                        {
                            if(blk.equals("")&&con_tp.equals(""))
                            {
                                sql="select DISTINCT CONS_NO from "+sector+" where trim(sector)='"+sec+"' and CONS_NO is not null and CONS_NM1 is not null and CON_TP is not null and CONS_CTG is not null and FLAT_TYPE is not null and (FLAT_TYPE!='PLOT' or (FLAT_TYPE='PLOT'and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null" +
                                     " and (CAL_DATE IS NOT NULL or NODUE_DT IS NOT NULL) and ((CAL_DATE IS NULL or to_char(CAL_DATE,'YYYY-MM-DD')<'"+billdate+"') and (NODUE_DT IS NULL  or to_char(NODUE_DT,'YYYY-MM-DD')<'"+billdate+"')) order by cons_no";
                            }
                           else if(!blk.equals("") && con_tp.equals(""))
                           {
                                sql="select DISTINCT CONS_NO from "+sector+" where trim(sector)='"+sec+"' and blk_no='"+blk+"' and CONS_NO is not null and CONS_NM1 is not null and CON_TP is not null and CONS_CTG is not null and FLAT_TYPE is not null and (FLAT_TYPE!='PLOT' or (FLAT_TYPE='PLOT'and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null" +
                                     " and (CAL_DATE IS NOT NULL or NODUE_DT IS NOT NULL) and ((CAL_DATE IS NULL or to_char(CAL_DATE,'YYYY-MM-DD')<'"+billdate+"') and (NODUE_DT IS NULL  or to_char(NODUE_DT,'YYYY-MM-DD')<'"+billdate+"')) order by cons_no";
                           }
                           else if(blk.equals("") && !con_tp.equals(""))
                           {
                                sql="select DISTINCT CONS_NO from "+sector+" where trim(sector)='"+sec+"' and con_tp='"+con_tp+"'  and  CONS_NO is not null and CONS_NM1 is not null and CON_TP is not null and CONS_CTG is not null and FLAT_TYPE is not null and (FLAT_TYPE!='PLOT' or (FLAT_TYPE='PLOT'and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null" +
                                     " and (CAL_DATE IS NOT NULL or NODUE_DT IS NOT NULL) and ((CAL_DATE IS NULL or to_char(CAL_DATE,'YYYY-MM-DD')<'"+billdate+"') and (NODUE_DT IS NULL  or to_char(NODUE_DT,'YYYY-MM-DD')<'"+billdate+"')) order by cons_no";
                           }
                           else if(!blk.equals("") && !con_tp.equals(""))
                           {
                                sql="select DISTINCT CONS_NO from "+sector+" where trim(sector)='"+sec+"' and blk_no='"+blk+"' and con_tp='"+con_tp+"' and CONS_NO is not null and CONS_NM1 is not null and CON_TP is not null and CONS_CTG is not null and FLAT_TYPE is not null and (FLAT_TYPE!='PLOT' or (FLAT_TYPE='PLOT'and PLOT_SIZE is not null)) and PIPE_SIZE is not null  and CONN_DT is not null" +
                                     " and (CAL_DATE IS NOT NULL or NODUE_DT IS NOT NULL) and ((CAL_DATE IS NULL or to_char(CAL_DATE,'YYYY-MM-DD')<'"+billdate+"') and (NODUE_DT IS NULL  or to_char(NODUE_DT,'YYYY-MM-DD')<'"+billdate+"')) order by cons_no";
                           }
                       }

                             System.out.println("sql----------------"+sql);
                             ps=con.prepareStatement(sql);

                             rs=ps.executeQuery();
                   //////////////////////////////////////////////
                   //////////////////////////////////////////////
                  i++;
                 o = session.getAttribute("myPdf");

		if (o == null) {
			pdf = new MyPdf(userid,billfr,calbilldate,due_dt,sec,totcons,con,rs,chl_tab);
                        /*Thread t = new Thread(pdf);
                        t.start();*/
			session.setAttribute("myPdf", pdf);
			// t = new Thread(pdf);
			//t.start();
		}
                else {
			pdf = (MyPdf) o;
		}
            	response.setContentType("text/html");

		switch (pdf.getPercentage()) {
		case -1:
			isError(response.getOutputStream());
			return;
		/*case 100:
 			 isFinished(response.getOutputStream());

                            System.out.println("bill calculated-----------------------------");
                        	return;*/

               default:
                    totcons=pdf.totcons;
                     if(pdf.getPercentage()==totcons)
                     {
                      //t.destroy();
                     al=pdf.calAl();
                     session.removeAttribute("myPdf");
                     isFinished(response.getOutputStream(),page,form,strbill_fr,strbill_date,strdue_dt,sec, al);
                           System.out.println("bill calculated-----------------------------");
                          return;
                     }

                    isBusy(pdf, response.getOutputStream(),totcons,page,form,strbill_fr,strbill_date,strdue_dt,sec, al);
                   	return;

		}

              }


              con.close();

        }
       catch(Exception ex)
        {
          System.out.println(ex);
        }
    }




    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        /*String stopth=request.getParameter("stopth");
        MyPdf mypdf=new MyPdf();
        mypdf.flag=false;*/


        processRequest(request, response);
    }


private void isBusy(MyPdf pdf, ServletOutputStream stream,int totcons,String page,String form,String bill_fr,String bill_date,String due_dt,String sec,ArrayList<ArrayList> al)
			throws IOException {
		stream.print("<html><head><title>Please wait...</title><meta http-equiv=\"Refresh\" content=\"5\">" +
                        "<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" />" +
                        "<div id=\"login\"><div id=\"login-wrapper\" class=\"png_bg\"><div id=\"login-top\">" +
                        "<img  alt=\"DMS-JAL\"  src=\"resources/images/logo.png\"/><div id=\"profile-links\">"+
                        " <a href=\"jsppages/common/logout.jsp\"  title=\"Sign Out\">Sign Out</a>&nbsp;|&nbsp;" +
                        "<a href=\"jsppages/common/ch_pass.jsp\"  title=\"Sign Out\"> Change Password</a> </div> </div></div></div></head>" +
                        "<body> <div id=\"body-wrapper\"> ");
                stream.print(" <div id=\"main-content\">  <div class=\"content-box\"><div class=\"content-box-header\"></div><div class=\"content-box-content \">");

		stream.print("Bill for "+pdf.cons_no+" is being calculated."+String.valueOf(totcons-pdf.getPercentage()));
		stream.print("&nbsp;consumers are left.<br>\nPlease Wait while this page refreshes automatically (every 5 seconds)</div><form action=\"/DMS/CancelBill\">"+
                             "<input type=\"hidden\" name=\"page\" value=\""+page+"\">"+
                            "<input type=\"hidden\" name=\"bill_fr\" value=\""+bill_fr+"\"><input type=\"hidden\" name=\"page\" value=\""+page+"\">"+
                             "<input type=\"hidden\" name=\"due_dt\" value=\""+due_dt+"\">"+"<input type=\"hidden\" name=\"al\" value=\""+al+"\">"+
                             "<input type=\"hidden\" name=\"sec\" value=\""+sec+"\"><input type=\"hidden\" name=\"billdate\" value=\""+bill_date+"\">"+
                             "<input type=\"hidden\" name=\"form\" value=\""+form+"\">"+
                             "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type=\"Submit\"  class=\"button\" value=\"Cancel\"></form></div></div>");


              stream.print( "<div id=\"footer\">"+
          "<p>&copy; 2009 <a href=\"http//www.smptechnologies.org\">SMP Technologies Pvt. Ltd.</a></p></div></div></body>\n</html>");

	}


private void isBusy(MyPdfCons pdfcons, ServletOutputStream stream )
			throws IOException {
	stream.print("<html><head><title>Please wait...</title><meta http-equiv=\"Refresh\" content=\"5\">" +
                        "<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" />" +
                        "<div id=\"login\"><div id=\"login-wrapper\" class=\"png_bg\"><div id=\"login-top\">" +
                        "<img  alt=\"DMS-JAL\"  src=\"resources/images/logo.png\"/><div id=\"profile-links\">"+
                        " <a href=\"jsppages/common/logout.jsp\"  title=\"Sign Out\">Sign Out</a>&nbsp;|&nbsp;" +
                        "<a href=\"jsppages/common/ch_pass.jsp\"  title=\"Sign Out\"> Change Password</a> </div> </div></div></div></head>" +
                        "<body> <div id=\"body-wrapper\"> ");
        stream.print(" <div id=\"main-content\">  <div class=\"content-box\"><div class=\"content-box-header\"></div><div class=\"content-box-content \">");


	stream.print("Please Wait while this page refreshes automatically (every 5 seconds)</div></div></div><div id=\"footer\">"+
          "<p>&copy; 2009 <a href=\"http//www.smptechnologies.org\">SMP Technologies Pvt. Ltd.</a></p></div></div></body>\n</html>");
	}


 private void isFinished(ServletOutputStream stream,String page,String form,String cons_no,String disc,String bill_fr,String bill_date,String due_dt,String sec,ArrayList<ArrayList> al ) throws IOException {

     if(page.equals("billgen"))
     {
	  stream.print("<html><head><link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" />" +
                        "<div id=\"login\"><div id=\"login-wrapper\" class=\"png_bg\"><div id=\"login-top\">" +
                        "<img  alt=\"DMS-JAL\"  src=\"resources/images/logo.png\"/><div id=\"profile-links\">"+
                        " <a href=\"jsppages/common/logout.jsp\"  title=\"Sign Out\">Sign Out</a>&nbsp;|&nbsp;" +
                        "<a href=\"jsppages/common/ch_pass.jsp\"  title=\"Sign Out\"> Change Password</a> </div> </div></div></div></head>" +
                        "<body> <div id=\"body-wrapper\">");

          stream.print(" <div id=\"main-content\">  <div class=\"content-box\"><div class=\"content-box-header\"></div><div class=\"content-box-content \">"+
	                     " <div class=\"notification information png_bg\"><a href=\"#\" class=\"close\">" +
                             "<img src=\"resources/images/icons/cross_grey_small.png\" title=\"Close this notification\" alt=\"close\" /></a><div>"+
		             "The document is finished:&nbsp;&nbsp;&nbsp;&nbsp;</div></div><form method=\"POST\" action=\"/DMS/GeneratePdf \">" +
                             "<input type=\"hidden\" name=\"cons_no\" value=\""+cons_no+"\"><input type=\"hidden\" name=\"discount\" value=\""+disc+"\">"+
                             "<input type=\"hidden\" name=\"bill_fr\" value=\""+bill_fr+"\"><input type=\"hidden\" name=\"page\" value=\""+page+"\">"+
                             "<input type=\"hidden\" name=\"due_dt\" value=\""+due_dt+"\">"+"<input type=\"hidden\" name=\"al\" value=\""+al+"\">"+
                             "<input type=\"hidden\" name=\"sec\" value=\""+sec+"\"><input type=\"hidden\" name=\"billdate\" value=\""+bill_date+"\">"+
                             "<input type=\"hidden\" name=\"form\" value=\""+form+"\">"+
          "<input type=\"Submit\"  class=\"button\" value=\"Get PDF\"> <a href=\"jsppages/billing/billgen.jsp\"><input type=\"button\"  class=\"button\" value=\"Back\"></a></form></div></div></div><div id=\"footer\"><small>"+
	  "<p >Copyright &copy; 2009 Developed for JAL by <a href=\"http://smptechnologies.org/\">SMP Technologies Pvt Ltd</a></p></small></div></div></body>\n</html>");
     }
    else if(page.equals("cons_details"))
    {
         stream.print("<html><head><link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" />" +
                        "<div id=\"login\"><div id=\"login-wrapper\" class=\"png_bg\"><div id=\"login-top\">" +
                        "<img  alt=\"DMS-JAL\"  src=\"resources/images/logo.png\"/><div id=\"profile-links\">"+
                        " <a href=\"jsppages/common/logout.jsp\"  title=\"Sign Out\">Sign Out</a>&nbsp;|&nbsp;" +
                        "<a href=\"jsppages/common/ch_pass.jsp\"  title=\"Sign Out\"> Change Password</a> </div> </div></div></div></head>" +
                        "<body> <div id=\"body-wrapper\">");

         stream.print(" <div id=\"main-content\">  <div class=\"content-box\"><div class=\"content-box-header\"></div><div class=\"content-box-content \">"+
	                     " <div class=\"notification information png_bg\"><a href=\"#\" class=\"close\">" +
                             "<img src=\"resources/images/icons/cross_grey_small.png\" title=\"Close this notification\" alt=\"close\" /></a><div>"+
		             "The document is finished:&nbsp;&nbsp;&nbsp;&nbsp;</div></div><form method=\"POST\" action=\"/DMS/GeneratePdf \">" +
                             "<input type=\"hidden\" name=\"cons_no\" value=\""+cons_no+"\"><input type=\"hidden\" name=\"discount\" value=\""+disc+"\">"+
                             "<input type=\"hidden\" name=\"bill_fr\" value=\""+bill_fr+"\"><input type=\"hidden\" name=\"page\" value=\""+page+"\">"+
                             "<input type=\"hidden\" name=\"due_dt\" value=\""+due_dt+"\">"+"<input type=\"hidden\" name=\"al\" value=\""+al+"\">"+
                             "<input type=\"hidden\" name=\"sec\" value=\""+sec+"\"><input type=\"hidden\" name=\"billdate\" value=\""+bill_date+"\">"+
                              "<input type=\"hidden\" name=\"form\" value=\""+form+"\">"+
          "<input type=\"Submit\"  class=\"button\" value=\"Get PDF\"> <a href=\"jsppages/Search/cons_details.jsp?cons_no="+cons_no+"\"><input type=\"button\"  class=\"button\" value=\"Back\"></a></form></div></div></div><div id=\"footer\"><small>"+
	  "<p >Copyright &copy; 2009 Developed for JAL by <a href=\"http://smptechnologies.org/\">SMP Technologies Pvt Ltd</a></p></small></div></div></body>\n</html>");
     }
	}


  public void isFinished(ServletOutputStream stream,String page,String form,String bill_fr,String bill_date,String due_dt,String sec,ArrayList<ArrayList> al ) throws IOException {

     if(page.equals("billgen"))
     {
	  stream.print("<html><head><link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/style.css\" />" +
                        "<div id=\"login\"><div id=\"login-wrapper\" class=\"png_bg\"><div id=\"login-top\">" +
                        "<img  alt=\"DMS-JAL\"  src=\"resources/images/logo.png\"/><div id=\"profile-links\">"+
                        " <a href=\"jsppages/common/logout.jsp\"  title=\"Sign Out\">Sign Out</a>&nbsp;|&nbsp;" +
                        "<a href=\"jsppages/common/ch_pass.jsp\"  title=\"Sign Out\"> Change Password</a> </div> </div></div></div></head>" +
                        "<body> <div id=\"body-wrapper\">");

          stream.print(" <div id=\"main-content\">  <div class=\"content-box\"><div class=\"content-box-header\"></div><div class=\"content-box-content \">"+
	                     " <div class=\"notification information png_bg\"><a href=\"#\" class=\"close\">" +
                             "<img src=\"resources/images/icons/cross_grey_small.png\" title=\"Close this notification\" alt=\"close\" /></a><div>"+
		             "The document is finished:&nbsp;&nbsp;&nbsp;&nbsp;</div></div><form method=\"POST\" action=\"/DMS/GeneratePdf \">" +
                             "<input type=\"hidden\" name=\"form\" value=\""+form+"\">"+
                             "<input type=\"hidden\" name=\"bill_fr\" value=\""+bill_fr+"\"><input type=\"hidden\" name=\"page\" value=\""+page+"\">"+
                             "<input type=\"hidden\" name=\"due_dt\" value=\""+due_dt+"\">"+"<input type=\"hidden\" name=\"al\" value=\""+al+"\">"+
                             "<input type=\"hidden\" name=\"sec\" value=\""+sec+"\"><input type=\"hidden\" name=\"billdate\" value=\""+bill_date+"\">"+
          "<input type=\"Submit\"  class=\"button\" value=\"Get PDF\"> <a href=\"jsppages/billing/billgen.jsp\"><input type=\"button\"  class=\"button\" value=\"Back\"></a></form></div></div></div><div id=\"footer\"><small>"+
	  "<p >Copyright &copy; 2009 Developed for JAL by <a href=\"http://smptechnologies.org/\">SMP Technologies Pvt Ltd</a></p></small></div></div></body>\n</html>");
     }

	}

  private void isError(ServletOutputStream stream) throws IOException
  {
		stream.print("<html>\n\t<head>\n\t\t<title>Error</title>\n\t</head>\n\t<body>");
		stream.print("An error occured.\n\t</body>\n</html>");
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