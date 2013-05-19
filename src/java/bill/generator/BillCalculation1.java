/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package bill.generator;

import bill.utility.ConToSqldt;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.*;

/**
 *
 * @author smp
 */


public class BillCalculation1
 {
     
      Calendar bl_per_fr=new GregorianCalendar();
      Calendar bl_per_fr1=new GregorianCalendar();
      Calendar bl_per_to1=new GregorianCalendar();
      java.sql.Date sqlbl_per_fr;
      java.sql.Date sqlbl_per_to;
      Calendar bl_per_to=new GregorianCalendar();
      Calendar prepay_date=new GregorianCalendar();
      Calendar pay_date2=new GregorianCalendar();
      Calendar fbl_per_fr=new GregorianCalendar();
      Calendar fbl_per_to=new GregorianCalendar();

      Calendar cbl_per_fr=new GregorianCalendar();
      Calendar cbl_per_to=new GregorianCalendar();
      String flat_no;
      String blk_no;
      String sector;
      String cons_nm2;

      int bill_cycle=1;
       Calendar cal_date=new GregorianCalendar();


      int calmonth;

      ResultSet rs=null;
      java.sql.Date conn_dt;
      java.sql.Date nodue_dt;
      java.sql.Date cal_dt;
      double paid_amt;
      Calendar pay_date=Calendar.getInstance();
      double arrear=0;
      double rate;
      int yrdiff;               //Variable that wiil hold difference of years from first bill period to current bill period
      int i=1;                 // Counter variable

     Double bill_amt;
     int   ydiffbl_per_fr1;  //Temporary variable to hold value of year of first bill period
     int  ydiffbill_year;   //Temporary variable to hold value of year of last bill period
     int year;
     int yy;
     int mm;
     String con_tp;
     String cons_ctg;
     String flat_type;
     int pipe_size;
     float plot_size;
     int x;
     String sec;
    // Connection con;

     String sql;
     //PreparedStatement pst;
     PreparedStatement pst;
     String cons_nm1;
     String trf;
     String trans_nm;

     boolean flag3=false;

      //java.sql.Date sqlpay_date;

     Calendar dt=Calendar.getInstance();

      double paidcss;
      long diff;


        int yearDiff(Calendar dt1,Calendar dt2)
       {
           int month=0;
           Calendar dt3=Calendar.getInstance();
           Calendar dt4=Calendar.getInstance();

           dt3.set(dt1.get(Calendar.YEAR),dt1.get(Calendar.MONTH),dt1.get(Calendar.DATE));
           dt4.set(dt2.get(Calendar.YEAR),dt2.get(Calendar.MONTH),dt2.get(Calendar.DATE));
           diff=dt4.getTime().getTime()-dt3.getTime().getTime();
            if(diff<0)
            {
                diff=0;
            }

            if( dt3.get(Calendar.MONTH)==1&& dt4.get(Calendar.MONTH)==1)
                month=(int)(diff/(1000*60*60*24))/27;
            else
                month=(int)(diff/(1000*60*60*24))/29;
                //System.out.println("Difference between "+dt1+ "and "+dt2+"is "+ month);

        return month;
       }



       public ArrayList<ArrayList> insblPeriodCl(String cons_no,Calendar billdate,String sec,String xmlpath)
    {

      cons_nm1=null;
      cons_nm2=null;
      con_tp=null;
      cons_ctg=null;
      flat_type=null;
      flat_no=null;
      blk_no=null;
      sector=null;
      plot_size=0;
      pipe_size=0;
      cal_date=null;

      int k=0;
       rate=0;

       bill_amt=0.0;

            ArrayList<ArrayList> al = new <ArrayList>ArrayList();
            ArrayList alrow = new ArrayList();

            bill_cycle=1;
            ConsumerDetail cd=new ConsumerDetail();
            ChallanDetails chd=new ChallanDetails();
            FindBillCycle fbc=new FindBillCycle();
            FindCalDate fcd=new FindCalDate();
            FindRate fr=new FindRate();
            ConToSqldt sqldt=new ConToSqldt();



            //rs will hold consumer details
            rs=cd.getConsumerDetails(cons_no,sec,xmlpath);

            try
            {

                 //con=DBConnection1.dbConnection(xmlpath);

                 //con=DBConnection.dbConnection();

               if(rs.next())
               {
                   //Consumer details

                  cons_nm1=(String)rs.getString(1).trim();
                  con_tp=(String)rs.getString(2).trim();
                  cons_ctg=(String)rs.getString(3).trim();
                  flat_type=(String)rs.getString(4).trim();
                  pipe_size=(int)rs.getInt(5);
                  plot_size=(float)rs.getFloat(6);
                  conn_dt=rs.getDate(7);
                  nodue_dt=rs.getDate(8);
                  trf=(String)rs.getString(9);
                  trans_nm=(String)rs.getString(10);
                  sector=(String)rs.getString(11);
                  blk_no=(String)rs.getString(12);
                  flat_no=(String)rs.getString(13);
                  if(flat_no!=null)
                    flat_no=flat_no.replace(',', '&');
                  cal_dt=rs.getDate(14);
                    if(trf!=null)
                    {
                        trf.trim();
                        cons_nm1=trans_nm;
                    }

               }

                 //Function for calculation date
                  cal_date=fcd.getCalDate(conn_dt, nodue_dt,cal_dt,xmlpath);
                        //System.out.println("Consno is" +cons_no);
                        //System.out.println("Consnm is" +cons_nm1);

                  //converting calculation date from sql date to util date
                  int bl_per_fr1year=cal_date.get(Calendar.YEAR);
                  int bl_per_fr1month=cal_date.get(Calendar.MONTH);
                  int bl_per_fr1date=cal_date.get(Calendar.DATE);

                  // Initializing Calculation date
                   bl_per_fr1.set(bl_per_fr1year,bl_per_fr1month+1,1);

                  int bill_year=billdate.get(Calendar.YEAR);
                  int bill_month=billdate.get(Calendar.MONTH);
                  int bill_date=billdate.get(Calendar.DATE);

                  //Calculating yeardifference to find out number of bill periods
                  if((bl_per_fr1.get(Calendar.MONTH))<3 )
                        ydiffbl_per_fr1= bl_per_fr1year-1;
                  else
                        ydiffbl_per_fr1= bl_per_fr1year;

                 /*  if(bill_month>3 )
                      ydiffbill_year=bill_year+1;
                   else*/
                       ydiffbill_year=bill_year;

                    yrdiff= ydiffbill_year-ydiffbl_per_fr1;
                    //-------------------------------------------------------//


                    //System.out.println(yrdiff);

                            if(bl_per_fr1.get(Calendar.MONTH)>2)
                                year= bl_per_fr1.get(Calendar.YEAR)+1;
                            else
                                year=bl_per_fr1.get(Calendar.YEAR);

                          bl_per_to.set(year,2,31);



                    for(int j=0;j<=yrdiff&&bl_per_fr1.before(billdate);j++)
                    {

                     //Rate function from plots
                      if(flat_type.equals("PLOT"))
                         {
                           rate= fr.getRatePlot(con_tp,cons_ctg,flat_type,plot_size,pipe_size,bl_per_fr1);
                         }
                              //Rate function for flat
                      else
                         {
                           rate= fr.getRateFlat(con_tp,cons_ctg,flat_type,pipe_size,bl_per_fr1,sec);
                         }

                     //System.out.println("Rate is" +rate);

                              //Function for bill cycle
                                 dt.set(2002,2,31);
                              //if(bl_per_fr1.after(new java.util.Date(102,2,31)))
                               if(bl_per_fr1.after(dt))
                                 bill_cycle=fbc.getBillCycle(rate);

                              //System.out.println("billcycle is"+bill_cycle);
                                  bl_per_fr=bl_per_fr1;
                                if(bill_cycle==1)
                                {
                                     sqlbl_per_fr=sqldt.conToSql(bl_per_fr);
                                     sqlbl_per_to=sqldt.conToSql(bl_per_to);
                                      if(bl_per_fr.get(Calendar.MONTH)>=3)
                                     calmonth=bl_per_to.get(Calendar.MONTH)+12-bl_per_fr.get(Calendar.MONTH)+1;
                                      else
                                     calmonth=bl_per_to.get(Calendar.MONTH)-bl_per_fr.get(Calendar.MONTH)+1;

                                     bill_amt=calmonth*rate;

                                      if(bl_per_to.after(billdate))
                                      {
                                          //sqlbl_per_to=billdate;
                                          bl_per_to.setTimeInMillis(billdate.getTime().getTime());
                                          bill_amt=yearDiff(bl_per_fr,billdate)*rate;
                                      }

                             alrow.add(0,cons_no);
                             alrow.add(1, cons_nm1);
                             alrow.add(2, cons_nm2);
                             alrow.add(3, con_tp);
                             alrow.add(4, cons_ctg);
                             alrow.add(5, flat_type);
                             alrow.add(6, flat_no);
                             alrow.add(7, blk_no);
                             alrow.add(8, sector);
                             alrow.add(9, plot_size);
                             alrow.add(10, pipe_size);
                             //alrow.add(11, sqlbl_per_fr);
                             //alrow.add(12, sqlbl_per_to);
                             alrow.add(11, new GregorianCalendar(bl_per_fr.get(Calendar.YEAR),bl_per_fr.get(Calendar.MONTH),bl_per_fr.get(Calendar.DATE)));
                             alrow.add(12, new GregorianCalendar(bl_per_to.get(Calendar.YEAR),bl_per_to.get(Calendar.MONTH),bl_per_to.get(Calendar.DATE)));
                             alrow.add(13, bill_amt);
                             alrow.add(14, rate);
                             alrow.add(15, bill_cycle);
                                    /* sql="insert into caltbl_001(cons_no,cons_nm1,con_tp,cons_ctg,flat_type,plot_size,pipe_size,bl_per_fr,bl_per_to,bill_amt,rate,bilcycle) values(?,?,?,?,?,?,?,?,?,?,?,?)";
                                     pst=(OraclePreparedStatement)con.prepareStatement(sql);
                                     pst.setString(1, cons_no);
                                     pst.setString(2, cons_nm1);
                                     pst.setString(3, con_tp);
                                     pst.setString(4, cons_ctg);
                                     pst.setString(5,flat_type);
                                     pst.setDouble(6,plot_size);
                                     pst.setDouble(7,pipe_size);
                                     pst.setDate(8, sqlbl_per_fr);
                                     pst.setDate(9, sqlbl_per_to);
                                     pst.setDouble(10,bill_amt);
                                     pst.setDouble(11, rate);
                                     pst.setInt(12, bill_cycle);
                                     ((OraclePreparedStatement)pst).executeUpdate();
                                     pst.close();
                                     */
                               al.add(new ArrayList(alrow));
                               alrow.clear();
                                     //System.out.println(bl_per_fr);
                                     //System.out.println(bl_per_to);

                                }

                                else if(bill_cycle==2)
                                {
                                   sqlbl_per_fr=sqldt.conToSql(bl_per_fr);
                                  // bl_per_to1=sqldt.conToSql(bl_per_to);
                                   bl_per_to1.setTimeInMillis(bl_per_to.getTime().getTime());

                                   if((bl_per_fr.get(Calendar.MONTH))>=9&&(bl_per_fr.get(Calendar.MONTH))<=11)
                                    yy=bl_per_fr.get(Calendar.YEAR)+1;
                                   else
                                     yy=bl_per_fr.get(Calendar.YEAR);
                                   if(bl_per_fr.get(Calendar.MONTH)>=3&&bl_per_fr.get(Calendar.MONTH)<=8)
                                    mm=8;
                                   else if(bl_per_fr.get(Calendar.MONTH)>=9||bl_per_fr.get(Calendar.MONTH)<=2)
                                   {
                                       mm=2;
                                   }


                                   for(i=0;i<2&&(bl_per_fr.before(bl_per_to1))&&(bl_per_fr.before(billdate));i++)
                                   {
                                     /*if(mm==8)
                                      sqlbl_per_to=new GregorianCalendar(yy,mm, 30);
                                     else
                                      sqlbl_per_to=new GregorianCalendar(yy,mm, 31);*/
                                       if(mm==8)
                                      bl_per_to.set(yy,mm, 30);
                                     else
                                      bl_per_to.set(yy,mm, 31);


                                     if(bl_per_fr.get(Calendar.MONTH)>=9)
                                     calmonth=bl_per_to.get(Calendar.MONTH)+12-bl_per_fr.get(Calendar.MONTH)+1;
                                      else
                                     calmonth=bl_per_to.get(Calendar.MONTH)-bl_per_fr.get(Calendar.MONTH)+1;

                                     bill_amt=calmonth*rate;

                                      if(bl_per_to.after(billdate))
                                      {
                                          //sqlbl_per_to=billdate;
                                           bl_per_to.setTimeInMillis(billdate.getTime().getTime());
                                          bill_amt=yearDiff(bl_per_fr,billdate)*rate;
                                      }

                                      alrow.add(0,cons_no);
                                      alrow.add(1, cons_nm1);
                                      alrow.add(2, cons_nm2);
                                      alrow.add(3, con_tp);
                                      alrow.add(4, cons_ctg);
                                      alrow.add(5, flat_type);
                                      alrow.add(6, flat_no);
                                      alrow.add(7, blk_no);
                                      alrow.add(8, sector);
                                      alrow.add(9, plot_size);
                                      alrow.add(10, pipe_size);
                                      //alrow.add(11, sqlbl_per_fr);
                                      //alrow.add(12, sqlbl_per_to);
                                      alrow.add(11, new GregorianCalendar(bl_per_fr.get(Calendar.YEAR),bl_per_fr.get(Calendar.MONTH),bl_per_fr.get(Calendar.DATE)));
                                      alrow.add(12, new GregorianCalendar(bl_per_to.get(Calendar.YEAR),bl_per_to.get(Calendar.MONTH),bl_per_to.get(Calendar.DATE)));
                                      alrow.add(13, bill_amt);
                                      alrow.add(14, rate);
                                      alrow.add(15, bill_cycle);

                                   /*  sql="insert into caltbl_001(cons_no,cons_nm1,con_tp,cons_ctg,flat_type,plot_size,pipe_size,bl_per_fr,bl_per_to,bill_amt,rate,bilcycle) values(?,?,?,?,?,?,?,?,?,?,?,?)";
                                     pst=(OraclePreparedStatement)con.prepareStatement(sql);
                                     pst.setString(1, cons_no);
                                     pst.setString(2, cons_nm1);
                                     pst.setString(3, con_tp);
                                     pst.setString(4, cons_ctg);
                                     pst.setString(5,flat_type);
                                     pst.setDouble(6,plot_size);
                                     pst.setDouble(7,pipe_size);
                                     pst.setDate(8, sqlbl_per_fr);
                                     pst.setDate(9, sqlbl_per_to);
                                     pst.setDouble(10,bill_amt);
                                     pst.setDouble(11, rate);
                                     pst.setInt(12, bill_cycle);

                                    ((OraclePreparedStatement)pst).executeUpdate();
                                      pst.close();
                                       */

                                      al.add(new ArrayList(alrow));

                                      alrow.clear();
                                     //System.out.println(bl_per_fr);
                                     //System.out.println(bl_per_to);
                                     //sqlbl_per_fr=new GregorianCalendar(yy,mm+1,1);
                                     bl_per_fr.set(yy,mm+1,1);
                                     mm=mm+6;
                                   }

                                }else if(bill_cycle==4)
                                {
                                   sqlbl_per_fr=sqldt.conToSql(bl_per_fr);
                                  // bl_per_to1=sqldt.conToSql(bl_per_to);
                                   bl_per_to1.setTimeInMillis(bl_per_to.getTime().getTime());

                                    yy=bl_per_fr.get(Calendar.YEAR);
                                   if(bl_per_fr.get(Calendar.MONTH)>=3&&bl_per_fr.get(Calendar.MONTH)<=5)
                                    mm=5;
                                   else if(bl_per_fr.get(Calendar.MONTH)>=6&&bl_per_fr.get(Calendar.MONTH)<=8)
                                    mm=8;
                                   else if(bl_per_fr.get(Calendar.MONTH)>=9&&bl_per_fr.get(Calendar.MONTH)<=12)
                                    mm=11;
                                   else if(bl_per_fr.get(Calendar.MONTH)>=0&&bl_per_fr.get(Calendar.MONTH)<=2)
                                    {
                                    mm=2;
                                    }

                                     for(i=0;i<4&&(bl_per_fr.before(bl_per_to1))&&(bl_per_fr.before(billdate));i++)
                                   {
                                       /* if(mm==5||mm==8)
                                         sqlbl_per_to=new GregorianCalendar(yy,mm, 30);
                                        else
                                         sqlbl_per_to=new GregorianCalendar(yy,mm, 31);*/
                                         if(mm==5||mm==8)
                                         bl_per_to.set(yy,mm, 30);
                                        else
                                         bl_per_to.set(yy,mm, 31);

                                     calmonth=Math.abs(bl_per_to.get(Calendar.MONTH)-bl_per_fr.get(Calendar.MONTH)+1);
                                     bill_amt=calmonth*rate;

                                      if(bl_per_to.after(billdate))
                                      {
                                         // sqlbl_per_to=billdate;
                                          bl_per_to.setTimeInMillis(billdate.getTime().getTime());
                                          bill_amt=yearDiff(bl_per_fr,billdate)*rate;
                                      }

                             alrow.add(0,cons_no);
                             alrow.add(1, cons_nm1);
                             alrow.add(2, cons_nm2);
                             alrow.add(3, con_tp);
                             alrow.add(4, cons_ctg);
                             alrow.add(5, flat_type);
                             alrow.add(6, flat_no);
                             alrow.add(7, blk_no);
                             alrow.add(8, sector);
                             alrow.add(9, plot_size);
                             alrow.add(10, pipe_size);
                             //alrow.add(11, sqlbl_per_fr);
                             //alrow.add(12, sqlbl_per_to);
                             alrow.add(11, new GregorianCalendar(bl_per_fr.get(Calendar.YEAR),bl_per_fr.get(Calendar.MONTH),bl_per_fr.get(Calendar.DATE)));
                             alrow.add(12, new GregorianCalendar(bl_per_to.get(Calendar.YEAR),bl_per_to.get(Calendar.MONTH),bl_per_to.get(Calendar.DATE)));
                             alrow.add(13, bill_amt);
                             alrow.add(14, rate);
                             alrow.add(15, bill_cycle);
                                    /* sql="insert into caltbl_001(cons_no,cons_nm1,con_tp,cons_ctg,flat_type,plot_size,pipe_size,bl_per_fr,bl_per_to,bill_amt,rate,bilcycle) values(?,?,?,?,?,?,?,?,?,?,?,?)";
                                     pst=(OraclePreparedStatement)con.prepareStatement(sql);
                                     pst.setString(1, cons_no);
                                     pst.setString(2, cons_nm1);
                                     pst.setString(3, con_tp);
                                     pst.setString(4, cons_ctg);
                                     pst.setString(5,flat_type);
                                     pst.setDouble(6,plot_size);
                                     pst.setDouble(7,pipe_size);
                                     pst.setDate(8, sqlbl_per_fr);
                                     pst.setDate(9, sqlbl_per_to);
                                     pst.setDouble(10,bill_amt);
                                     pst.setDouble(11, rate);
                                     pst.setInt(12, bill_cycle);
                                    ((OraclePreparedStatement)pst).executeUpdate();
                                     pst.close();
                                      */
                              al.add(new ArrayList(alrow));

                              alrow.clear();
                                    //System.out.println(sqlbl_per_fr);
                                    //System.out.println(sqlbl_per_to);
                                     //sqlbl_per_fr=new GregorianCalendar(yy,mm+1,1);
                                    bl_per_fr.set(yy,mm+1,1);
                                     mm=mm+3;

                                   }

                                }else if(bill_cycle==12)
                                {

                                   sqlbl_per_fr=sqldt.conToSql(bl_per_fr);
                                   //bl_per_to1=sqldt.conToSql(bl_per_to);
                                    bl_per_to1.setTimeInMillis(bl_per_to.getTime().getTime());

                                    for(i=0;i<12&&(bl_per_fr.before(bl_per_to1))&&(bl_per_fr.before(billdate));i++)
                                   {
                                         yy=bl_per_fr.get(Calendar.YEAR);
                                         mm=bl_per_fr.get(Calendar.MONTH);
                                       /* if(mm==5||mm==8||mm==10||mm==3)
                                          sqlbl_per_to=new GregorianCalendar(yy,mm, 30);
                                        else if(mm==1)
                                          sqlbl_per_to=new GregorianCalendar(yy,mm, 28);
                                        else
                                          sqlbl_per_to=new GregorianCalendar(yy,mm,31);*/

                                         if(mm==5||mm==8||mm==10||mm==3)
                                          bl_per_to.set(yy,mm, 30);
                                        else if(mm==1)
                                          bl_per_to.set(yy,mm, 28);
                                        else
                                          bl_per_to.set(yy,mm,31);
                                     calmonth=Math.abs(bl_per_to.get(Calendar.MONTH)-bl_per_fr.get(Calendar.MONTH)+1);
                                     bill_amt=calmonth*rate;

                                      alrow.add(0,cons_no);
                                      alrow.add(1, cons_nm1);
                                      alrow.add(2, cons_nm2);
                                      alrow.add(3, con_tp);
                                      alrow.add(4, cons_ctg);
                                      alrow.add(5, flat_type);
                                      
                                      alrow.add(6, flat_no);
                                      alrow.add(7, blk_no);
                                      alrow.add(8, sector);
                                      alrow.add(9, plot_size);
                                      alrow.add(10, pipe_size);
                                      //alrow.add(11, sqlbl_per_fr);
                                      //alrow.add(12, sqlbl_per_to);
                                      alrow.add(11, new GregorianCalendar(bl_per_fr.get(Calendar.YEAR),bl_per_fr.get(Calendar.MONTH),bl_per_fr.get(Calendar.DATE)));
                                      alrow.add(12, new GregorianCalendar(bl_per_to.get(Calendar.YEAR),bl_per_to.get(Calendar.MONTH),bl_per_to.get(Calendar.DATE)));
                                      alrow.add(13, bill_amt);
                                      alrow.add(14, rate);
                                      alrow.add(15, bill_cycle);

                                    /* sql="insert into caltbl_001(cons_no,cons_nm1,con_tp,cons_ctg,flat_type,plot_size,pipe_size,bl_per_fr,bl_per_to,bill_amt,rate,bilcycle) values(?,?,?,?,?,?,?,?,?,?,?,?)";
                                      pst=(OraclePreparedStatement)con.prepareStatement(sql);
                                      pst.setString(1, cons_no);
                                      pst.setString(2, cons_nm1);
                                      pst.setString(3, con_tp);
                                      pst.setString(4, cons_ctg);
                                      pst.setString(5,flat_type);
                                      pst.setDouble(6,plot_size);
                                      pst.setDouble(7,pipe_size);
                                     pst.setDate(8, sqlbl_per_fr);
                                     pst.setDate(9, sqlbl_per_to);
                                     pst.setDouble(10,bill_amt);
                                     pst.setDouble(11, rate);
                                     pst.setInt(12, bill_cycle);
                                     ((OraclePreparedStatement)pst).executeUpdate();
                                      pst.close();
                                    */

                                      al.add(new ArrayList(alrow));

                                      alrow.clear();

                                      //System.out.println(bl_per_fr);
                                      //System.out.println(bl_per_to);
                                      //sqlbl_per_fr=new GregorianCalendar(yy,mm+1,1);
                                      bl_per_fr.set(yy,mm+1,1);
                                   }

                                }
                                  //year= sqlbl_per_to.get(Calendar.Year);
                                  year=bl_per_to.get(Calendar.YEAR);
                                  bl_per_fr1.set(year,3,1);
                                  bl_per_to.set(++year,2,31);

        }
            rs.close();

            //System.out.println("after insertion caltbl is------------------------------");
            /*for (int a = 0; a < al.size(); a++)
                     {

                         alrow= (ArrayList) al.get(a);
                         Iterator itr1 =alrow.iterator();
                           while(itr1.hasNext())
                          {

                          Object element=itr1.next();
                          System.out.print(element + " ");

                          }
                          System.out.println();
                     }*/


            }catch(Exception ex)
            {
                System.out.println("Exception in insbillperiod "+ex);
            }

            return al;
    }




       public ArrayList<ArrayList> updChlDetCl(String cons_no,Calendar billdate,String sec,String xmlpath)
                  {
                     cons_nm1=null;
                     cons_nm2=null;
                     con_tp=null;
                     cons_ctg=null;
                     flat_type=null;
                     flat_no=null;
                     blk_no=null;
                     sector=null;
                     plot_size=0;
                     pipe_size=0;


                     paid_amt=0.0;

                     rate=0;

                     bill_amt=0.0;
                     arrear=0.0;
                     paidcss=0;




                    ArrayList<ArrayList> al = new <ArrayList>ArrayList();
                    ArrayList alrow = new ArrayList();

                    al=insblPeriodCl(cons_no,billdate,sec,xmlpath);
                    ChallanDetails chd=new ChallanDetails();
                    ConToSqldt sqldt=new ConToSqldt();



                    try{
                          //con=DBConnection1.dbConnection(xmlpath);

                          rs=chd.getChallanDetails(cons_no,sec,xmlpath);
                           int a=0;
                          if(rs!=null)
                           {
                           while(rs.next())
                            {

                               cbl_per_fr.setTime(rs.getDate(1));
                               cbl_per_to.setTime(rs.getDate(2));
                               paid_amt=rs.getDouble(5);
                               java.sql.Date sqlpaydate=rs.getDate(6);
                               if(sqlpaydate!=null)
                               {
                                   pay_date=Calendar.getInstance();
                                   pay_date.setTime(sqlpaydate);
                                 }
                               else
                                pay_date=null;
                               paidcss=rs.getDouble(7);
                              //if(pay_date!=null)
                              //sqlpay_date=sqldt.conToSql(pay_date);
                              //sqlbl_per_fr=sqldt.conToSql(cbl_per_fr);
                              //sqlbl_per_to=sqldt.conToSql(cbl_per_to);

                               if(paidcss!=0)
                               paid_amt=paid_amt-paidcss;


                              if(pay_date!=null )
                               {
                                  if(pay_date.after(cbl_per_to))
                                   {

                                       for (; a < al.size(); a++)
                                        {
                                           alrow= (ArrayList) al.get(a);
                                           cons_no=(String)alrow.get(0);
                                           cons_nm1=(String)alrow.get(1);
                                           cons_nm2=(String)alrow.get(2);
                                           con_tp=(String)alrow.get(3);
                                           cons_ctg=(String)alrow.get(4);
                                           flat_type=(String)alrow.get(5);
                                           flat_no=(String)alrow.get(6);
                                           blk_no=(String)alrow.get(7);
                                           sector=(String)alrow.get(8);
                                           plot_size=Float.parseFloat(alrow.get(9).toString());
                                           pipe_size=Integer.parseInt(alrow.get(10).toString());
                                           //bl_per_fr=((Calendar)alrow.get(11));
                                           //bl_per_to=(Calendar)alrow.get(12);
                                           bl_per_fr.setTimeInMillis(((Calendar)alrow.get(11)).getTimeInMillis());
                                           bl_per_to.setTimeInMillis(((Calendar)alrow.get(12)).getTimeInMillis());
                                           bill_amt=Double.parseDouble(alrow.get(13).toString());
                                           rate=Double.parseDouble(alrow.get(14).toString());
                                           bill_cycle=Integer.parseInt(alrow.get(15).toString());

                                           if(bl_per_to.equals(cbl_per_to))
                                           {
                                                alrow.add(16,paid_amt);
                                                 alrow.add(17, new GregorianCalendar(pay_date.get(Calendar.YEAR),pay_date.get(Calendar.MONTH),pay_date.get(Calendar.DATE)));
                                                alrow.add(18,paidcss);
                                                a++;
                                               break;
                                            }
                                           else
                                            {
                                             alrow.add(16,0);
                                             alrow.add(17,null);
                                             alrow.add(18,0);
                                               if(!cbl_per_to.equals(bl_per_to))
                                                 continue;
                                              else
                                              {
                                                 a++;
                                              break;
                                              }
                                             }
                                           }


                                     /*sql="update caltbl_001 set paid_amt=?,pay_date=? where  to_char(bl_per_to,'yyyy-mm-dd')=to_char(?,'yyyy-mm-dd') and cons_no=?";
                                  pst=(OraclePreparedStatement)con.prepareStatement(sql);
                                  pst.setDouble(1, paid_amt);
                                  pst.setDate(2, sqlpay_date);
                                  pst.setDate(3, sqlbl_per_to);
                                  pst.setString(4,cons_no);*/
                                 }
                                 else if(pay_date.before(cbl_per_fr))
                                 {



                                       for (; a < al.size(); a++)
                                           {
                                          alrow= (ArrayList) al.get(a);
                                           cons_no=(String)alrow.get(0);
                                           cons_nm1=(String)alrow.get(1);
                                           cons_nm2=(String)alrow.get(2);
                                           con_tp=(String)alrow.get(3);
                                           cons_ctg=(String)alrow.get(4);
                                           flat_type=(String)alrow.get(5);
                                           flat_no=(String)alrow.get(6);
                                           blk_no=(String)alrow.get(7);
                                           sector=(String)alrow.get(8);
                                           plot_size=Float.parseFloat(alrow.get(9).toString());
                                           pipe_size=Integer.parseInt(alrow.get(10).toString());
                                           //bl_per_fr=(Calendar)alrow.get(11);
                                           //bl_per_to=(Calendar)alrow.get(12);
                                           bl_per_fr.setTimeInMillis(((Calendar)alrow.get(11)).getTimeInMillis());
                                           bl_per_to.setTimeInMillis(((Calendar)alrow.get(12)).getTimeInMillis());
                                           bill_amt=Double.parseDouble(alrow.get(13).toString());
                                           rate=Double.parseDouble(alrow.get(14).toString());
                                           bill_cycle=Integer.parseInt(alrow.get(15).toString());

                                           if(bl_per_fr.equals(cbl_per_fr))
                                           {


                                               alrow.add(16,paid_amt);
                                               alrow.add(17, new GregorianCalendar(pay_date.get(Calendar.YEAR),pay_date.get(Calendar.MONTH),pay_date.get(Calendar.DATE)));
                                               alrow.add(18,paidcss);
                                               a++;
                                               break;

                                           }
                                           else
                                            {
                                              alrow.add(16,0);
                                              alrow.add(17,null);
                                              alrow.add(18,0);
                                             if(!cbl_per_to.equals(bl_per_to))
                                             continue;
                                               else
                                               {
                                                   a++;
                                                    break;
                                               }

                                             }

                                       }

                                  /*sql="update caltbl_001 set paid_amt=?,pay_date=? where  to_char(bl_per_fr,'yyyy-mm-dd')=to_char(?,'yyyy-mm-dd') and cons_no=?";
                                  pst=(OraclePreparedStatement)con.prepareStatement(sql);
                                  pst.setDouble(1, paid_amt);
                                  pst.setDate(2, sqlpay_date);
                                  pst.setDate(3, sqlbl_per_fr);
                                  pst.setString(4,cons_no);*/
                                 }
                                 else
                                 {


                                       for (; a < al.size(); a++)
                                          {
                                          alrow= (ArrayList) al.get(a);
                                           cons_no=(String)alrow.get(0);
                                           cons_nm1=(String)alrow.get(1);
                                           cons_nm2=(String)alrow.get(2);
                                           con_tp=(String)alrow.get(3);
                                           cons_ctg=(String)alrow.get(4);
                                           flat_type=(String)alrow.get(5);
                                           flat_no=(String)alrow.get(6);
                                           blk_no=(String)alrow.get(7);
                                           sector=(String)alrow.get(8);
                                           plot_size=Float.parseFloat(alrow.get(9).toString());
                                           pipe_size=Integer.parseInt(alrow.get(10).toString());
                                           //bl_per_fr=(Calendar)alrow.get(11);
                                           //bl_per_to=(Calendar)alrow.get(12);
                                           bl_per_fr.setTimeInMillis(((Calendar)alrow.get(11)).getTimeInMillis());
                                           bl_per_to.setTimeInMillis(((Calendar)alrow.get(12)).getTimeInMillis());
                                           bill_amt=Double.parseDouble(alrow.get(13).toString());
                                           rate=Double.parseDouble(alrow.get(14).toString());
                                           bill_cycle=Integer.parseInt(alrow.get(15).toString());


                                           if((bl_per_fr.before(pay_date)||bl_per_fr.equals(pay_date))&&(bl_per_to.after(pay_date)||bl_per_to.equals(pay_date)))
                                           {


                                               alrow.add(16,paid_amt);
                                                alrow.add(17, new GregorianCalendar(pay_date.get(Calendar.YEAR),pay_date.get(Calendar.MONTH),pay_date.get(Calendar.DATE)));
                                               alrow.add(18,paidcss);
                                               a++;
                                               break;

                                           }
                                           else
                                            {
                                             alrow.add(16,0);
                                             alrow.add(17,null);
                                             alrow.add(18,0);
                                              if(!cbl_per_to.equals(bl_per_to))
                                             continue;
                                               else
                                               {
                                                   a++;
                                                    break;
                                               }
                                             }
                                       }

                                /*sql="update caltbl_001 set paid_amt=?,pay_date=? where to_char(bl_per_fr,'yyyy-mm-dd')<=to_char(?,'yyyy-mm-dd') and to_char(bl_per_to,'yyyy-mm-dd')>=to_char(?,'yyyy-mm-dd') and cons_no=?";
                                 pst=(OraclePreparedStatement)con.prepareStatement(sql);
                                 pst.setDouble(1, paid_amt);
                                 pst.setDate(2, sqlpay_date);
                              // pst.setDate(3, sqlbl_per_fr);
                                pst.setDate(3, sqlpay_date);
                                pst.setDate(4, sqlpay_date);
                                pst.setString(5,cons_no);*/
                                 }

                             }

                             else
                             {
                                if(paid_amt!=0)
                                 {

                                       for (; a < al.size(); a++)
                                         {
                                          alrow= (ArrayList) al.get(a);
                                           cons_no=(String)alrow.get(0);
                                           cons_nm1=(String)alrow.get(1);
                                           cons_nm2=(String)alrow.get(2);
                                           con_tp=(String)alrow.get(3);
                                           cons_ctg=(String)alrow.get(4);
                                           flat_type=(String)alrow.get(5);
                                           flat_no=(String)alrow.get(6);
                                           blk_no=(String)alrow.get(7);
                                           sector=(String)alrow.get(8);
                                           plot_size=Float.parseFloat(alrow.get(9).toString());
                                           pipe_size=Integer.parseInt(alrow.get(10).toString());
                                           //bl_per_fr=(Calendar)alrow.get(11);
                                           //bl_per_to=(Calendar)alrow.get(12);
                                           bl_per_fr.setTimeInMillis(((Calendar)alrow.get(11)).getTimeInMillis());
                                           bl_per_to.setTimeInMillis(((Calendar)alrow.get(12)).getTimeInMillis());
                                           bill_amt=Double.parseDouble(alrow.get(13).toString());
                                           rate=Double.parseDouble(alrow.get(14).toString());
                                           bill_cycle=Integer.parseInt(alrow.get(15).toString());

                                        if(bl_per_to.equals(cbl_per_to))
                                           {

                                               alrow.add(16,paid_amt);
                                                alrow.add(17, new GregorianCalendar(cbl_per_to.get(Calendar.YEAR),cbl_per_to.get(Calendar.MONTH),cbl_per_to.get(Calendar.DATE)));
                                               alrow.add(18,paidcss);
                                               a++;
                                               break;

                                           }
                                            else
                                            {
                                             alrow.add(16,0);
                                             alrow.add(17,null);
                                             alrow.add(18,0);
                                             if(!cbl_per_to.equals(bl_per_to))
                                             continue;
                                              else
                                               {
                                                   a++;
                                                    break;
                                               }
                                             }
                                          }
                               /* sql="update caltbl_001 set paid_amt=?,pay_date=? where bl_per_to=? and  cons_no=?";
                                pst=(OraclePreparedStatement)con.prepareStatement(sql);
                                pst.setDouble(1, paid_amt);
                                pst.setDate(2, sqlbl_per_to);
                                pst.setDate(3, sqlbl_per_to);
                                pst.setString(4,cons_no);
                                 */
                                 }
                                else
                                    {

                                     for (; a < al.size(); a++)
                                           {
                                          alrow= (ArrayList) al.get(a);
                                           cons_no=(String)alrow.get(0);
                                           cons_nm1=(String)alrow.get(1);
                                           cons_nm2=(String)alrow.get(2);
                                           con_tp=(String)alrow.get(3);
                                           cons_ctg=(String)alrow.get(4);
                                           flat_type=(String)alrow.get(5);
                                           flat_no=(String)alrow.get(6);
                                           blk_no=(String)alrow.get(7);
                                           sector=(String)alrow.get(8);
                                           plot_size=Float.parseFloat(alrow.get(9).toString());
                                           pipe_size=Integer.parseInt(alrow.get(10).toString());
                                           //bl_per_fr=(Calendar)alrow.get(11);
                                           //bl_per_to=(Calendar)alrow.get(12);
                                           bl_per_fr.setTimeInMillis(((Calendar)alrow.get(11)).getTimeInMillis());
                                           bl_per_to.setTimeInMillis(((Calendar)alrow.get(12)).getTimeInMillis());
                                           bill_amt=Double.parseDouble(alrow.get(13).toString());
                                           rate=Double.parseDouble(alrow.get(14).toString());
                                           bill_cycle=Integer.parseInt(alrow.get(15).toString());
                                           alrow.add(16,0);
                                           alrow.add(17,null);
                                           alrow.add(18,0);
                                            if(!cbl_per_to.equals(bl_per_to))
                                             continue;
                                             else
                                               {
                                                   a++;
                                                    break;
                                               }
                                             }
                                     }

                             }
                             //((OraclePreparedStatement)pst).executeUpdate();




                               //System.out.println("updated");
                       }
                                for (; a < al.size(); a++)
                                   {
                                           alrow= (ArrayList) al.get(a);
                                           cons_no=(String)alrow.get(0);
                                           cons_nm1=(String)alrow.get(1);
                                           cons_nm2=(String)alrow.get(2);
                                           con_tp=(String)alrow.get(3);
                                           cons_ctg=(String)alrow.get(4);
                                           flat_type=(String)alrow.get(5);
                                           flat_no=(String)alrow.get(6);
                                           blk_no=(String)alrow.get(7);
                                           sector=(String)alrow.get(8);
                                           plot_size=Float.parseFloat(alrow.get(9).toString());
                                           pipe_size=Integer.parseInt(alrow.get(10).toString());
                                           //bl_per_fr=(Calendar)alrow.get(11);
                                           //bl_per_to=(Calendar)alrow.get(12);
                                           bl_per_fr.setTimeInMillis(((Calendar)alrow.get(11)).getTimeInMillis());
                                           bl_per_to.setTimeInMillis(((Calendar)alrow.get(12)).getTimeInMillis());
                                           bill_amt=Double.parseDouble(alrow.get(13).toString());
                                           rate=Double.parseDouble(alrow.get(14).toString());
                                           bill_cycle=Integer.parseInt(alrow.get(15).toString());
                                           alrow.add(16,0);
                                           alrow.add(17,null);
                                           alrow.add(18,0);
                                   }

                            // pst.close();
                            //rs.close();
                        }
                          else
                          {
                                for (; a < al.size(); a++)
                                   {
                                           alrow= (ArrayList) al.get(a);
                                           cons_no=(String)alrow.get(0);
                                           cons_nm1=(String)alrow.get(1);
                                           cons_nm2=(String)alrow.get(2);
                                           con_tp=(String)alrow.get(3);
                                           cons_ctg=(String)alrow.get(4);
                                           flat_type=(String)alrow.get(5);
                                           flat_no=(String)alrow.get(6);
                                           blk_no=(String)alrow.get(7);
                                           sector=(String)alrow.get(8);
                                           plot_size=Float.parseFloat(alrow.get(9).toString());
                                           pipe_size=Integer.parseInt(alrow.get(10).toString());
                                           //bl_per_fr=(Calendar)alrow.get(11);
                                           //bl_per_to=(Calendar)alrow.get(12);
                                           bl_per_fr.setTimeInMillis(((Calendar)alrow.get(11)).getTimeInMillis());
                                           bl_per_to.setTimeInMillis(((Calendar)alrow.get(12)).getTimeInMillis());
                                           bill_amt=Double.parseDouble(alrow.get(13).toString());
                                           rate=Double.parseDouble(alrow.get(14).toString());
                                           bill_cycle=Integer.parseInt(alrow.get(15).toString());
                                           alrow.add(16,0);
                                           alrow.add(17,null);
                                           alrow.add(18,0);
                                   }

                          }

                   //System.out.println("after Updation caltbl is------------------------------");
                  /*for ( a = 0; a < al.size(); a++)
                     {

                         alrow= (ArrayList) al.get(a);
                         Iterator itr1 =alrow.iterator();
                           while(itr1.hasNext())
                          {

                          Object element=itr1.next();
                          System.out.print(element + " ");

                          }
                          System.out.println();
                     }*/



                      }catch(Exception ex)
                        {
                            System.out.println("Exception in update challan :"+ex);
                        }

                     return al;
               }




     public ArrayList<ArrayList> calbillCl(String cons_no,Calendar billdate,Calendar due_dt,String sec,String xmlpath)
     {

       cons_nm1=null;
       cons_nm2=null;
       con_tp=null;
       cons_ctg=null;
       flat_type=null;
       flat_no=null;
       blk_no=null;
       sector=null;
       plot_size=0;
       pipe_size=0;
       double surcharge=0;
       String err=null;
       double totpaidamount=0;
       double  principle=0;
       double csscredit=0;


       paid_amt=0.0;

       rate=0;
       double interest=0.0;
       double billamt=0.0;
       bill_amt=0.0;
       arrear=0.0;
       double rebate=0.0;
       double credit=0.0;
       int bilcycle=0;
       int intmonth=0;
       double bill_amt1=0;
       double arrear1=0.0;
       Calendar endbl_per_to=Calendar.getInstance();
       int flag=0;                     //// flag var  when  rebate has been given
       int bflag=0;
       
       double cssrate=0;
       double css=0;
       double totalcss=0;
       double precssarr=0;
       double cssarrear=0;
       double cssinterest=0;
       double currentamt=0;
       double totamt=0;
     

       double totinterest=0;

        ArrayList<ArrayList> al = new <ArrayList>ArrayList();
        ArrayList alrow = new ArrayList();
        double pramt=0;
        double pdamt=0;
        int flag4=0;
        prepay_date=null;


              try{
               /* String sql="select bl_per_fr,bl_per_to,paid_amt,pay_date,rate,bill_amt,bilcycle,credit from caltbl_001 where cons_no=? order by bl_per_fr";
                OraclePreparedStatement pst=(OraclePreparedStatement)con.prepareStatement(sql);
                pst.setString(1,cons_no);
                ResultSet rs= ((OraclePreparedStatement)pst).executeQuery();*/
                                     al=updChlDetCl(cons_no,billdate,sec,xmlpath);


                     if(due_dt!=null)                ///set due_date to last day of due_date month
                       {
                        int ddd=due_dt.get(Calendar.DATE);
                        int mmm=due_dt.get(Calendar.MONTH);
                        int yyy=due_dt.get(Calendar.YEAR);
                        //System.out.println("Days"+ddd+"Month"+mmm+"Year"+yyy);
                        if(mmm==1)
                            due_dt.set(yyy,mmm,28);
                        else if(mmm==0 || mmm==2 || mmm==4 || mmm==6 || mmm==7 || mmm==9 ||mmm==11)
                            due_dt.set(yyy,mmm,31);
                        else
                            due_dt.set(yyy,mmm,30);
                        }

                                       for (int a = 0; a < al.size(); a++)
                                      {
                                           alrow= (ArrayList) al.get(a);
                                           cons_no=(String)alrow.get(0);
                                           cons_nm1=(String)alrow.get(1);
                                           cons_nm2=(String)alrow.get(2);
                                           con_tp=(String)alrow.get(3);
                                           cons_ctg=(String)alrow.get(4);
                                           flat_type=(String)alrow.get(5);
                                           flat_no=(String)alrow.get(6);
                                           blk_no=(String)alrow.get(7);
                                           sector=(String)alrow.get(8);
                                           plot_size=Float.parseFloat(alrow.get(9).toString());
                                           pipe_size=Integer.parseInt(alrow.get(10).toString());
                                           //bl_per_fr=(Calendar)alrow.get(11);
                                           //bl_per_to=(Calendar)alrow.get(12);
                                           bl_per_fr.setTimeInMillis(((Calendar)alrow.get(11)).getTimeInMillis());
                                           bl_per_to.setTimeInMillis(((Calendar)alrow.get(12)).getTimeInMillis());
                                           bill_amt=Double.parseDouble(alrow.get(13).toString());
                                           rate=Double.parseDouble(alrow.get(14).toString());
                                           bilcycle=Integer.parseInt(alrow.get(15).toString());
                                           paid_amt=Double.parseDouble(alrow.get(16).toString());
                                           //pay_date=(Calendar)alrow.get(17);

                                          if(alrow.get(17)!=null)
                                           {
                                           pay_date=Calendar.getInstance();
                                           pay_date.setTimeInMillis(((Calendar)alrow.get(17)).getTimeInMillis());
                                            }
                                           else
                                           pay_date=null;
                                           paidcss=Double.parseDouble(alrow.get(18).toString());


                           //Find Cess

                                //dt.set(2006,2,31);
                         if(bl_per_fr.after(new GregorianCalendar(2006,2,31)))
                           {
                                 FindCess fc=new FindCess();
                                 //find cess rate
                                 cssrate= fc.getCess(bl_per_fr,cons_no,sec,xmlpath);

                                       //find cess for current bill period

                                        intmonth=yearDiff(bl_per_fr,bl_per_to);
                                         css=cssrate*intmonth;
                                        //System.out.println("difference between "+bl_per_fr+"and"+bl_per_to+"for cess"+intmonth);
                                        //System.out.println("cess rate"+cssrate +" and cess amount"+css);

                           }
                         else
                         {
                           cssrate=0.0;
                           css=0.0;
                          }

                       //css for current year
                                  totalcss=totalcss+css;


                                           if(bl_per_to.after(due_dt))
                                           {
                                               bl_per_to.set(due_dt.get(Calendar.YEAR), due_dt.get(Calendar.MONTH),due_dt.get(Calendar.DATE));
                                           }

                                        /*  while(rs.next())
                                               {
                                            bl_per_fr=rs.getDate(1);
                                            bl_per_to=rs.getDate(2);
                                            paid_amt=rs.getDouble(3);
                                            pay_date=rs.getDate(4);
                                            rate=rs.getDouble(5);
                                            bill_amt=rs.getDouble(6);
                                            bilcycle=rs.getInt(7);
                                            credit=rs.getDouble(8);
                                        */


                        if(flag==1)          //if rebate has been given
                        {
                          billamt=0.0;
                          if(bilcycle!=1)
                            bill_amt=0.0;
                        }

                         if(bflag==1)          //if rebate has been given
                        {
                          billamt=0.0;
                           if(bilcycle!=1)
                             bill_amt=0.0;
                        }


                        if(bl_per_to.get(Calendar.MONTH)==2&&bl_per_to.get(Calendar.DATE)==31)
                        {
                            flag=0;
                           // bflag=0;
                        }

                      if(pay_date!=null)                ///set pay_date to last day of pay_date month
                       {
                        int ddd=pay_date.get(Calendar.DATE);
                        int mmm=pay_date.get(Calendar.MONTH);
                        int yyy=pay_date.get(Calendar.YEAR);
                        //System.out.println("Days"+ddd+"Month"+mmm+"Year"+yyy);
                        if(mmm==1)
                            pay_date.set(yyy,mmm,28);
                        else if(mmm==0 || mmm==2 || mmm==4 || mmm==6 || mmm==7 || mmm==9 ||mmm==11)
                            pay_date.set(yyy,mmm,31);
                        else
                            pay_date.set(yyy,mmm,30);
                        }

                      //Find Rebate
                           //dt.set(2002,2,31);
                        if(bl_per_fr.after(new GregorianCalendar(2002,2,31))&&pay_date!=null)
                              {
                                 FindRebate rb=new FindRebate();
                                  if(bl_per_fr.get(Calendar.MONTH)>=3)
                                  {
                                     bill_amt1=rate*12;
                                     rebate= rb.getRebate(bl_per_fr,pay_date,bill_amt1,paid_amt,bilcycle);
                                  }
                              }
                         else
                           rebate=0.0;




                      ////----------For bl_per_fr before 1/4/2002----------------------------////

                        // dt.set(2002,3,1);
                        if( bl_per_fr.before(new GregorianCalendar(2002,3,1)))
                           {
                                if(pay_date==null)             //if pay_date is null
                                     {
                                           if(prepay_date!=null)
                                             {
                                                   intmonth=yearDiff(prepay_date,bl_per_to);
                                                   if(prepay_date.before(bl_per_to)||prepay_date.equals(bl_per_to))
                                                     prepay_date=null;
                                              }
                                            else
                                              {
                                                    intmonth=yearDiff(bl_per_fr,bl_per_to);
                                               }
                                             if(arrear>0)                         //calculate interest if arrear exists
                                              {
                                                 interest=(arrear*intmonth*15)/(100*12);
                                                 arrear=arrear+interest;

                                                  totinterest=totinterest+interest;
                                               }
                                            arrear=arrear+bill_amt;

                                      }
                                  else                    // if pay_date is not null
                                     {
                                      /////////////////////*******************///////////////////////
                                     if(pay_date.after(bl_per_to))
                                      {

                                         if(prepay_date!=null)
                                                {
                                                   intmonth=yearDiff(prepay_date,bl_per_to);
                                                   if(prepay_date.before(bl_per_to)||prepay_date.equals(bl_per_to))
                                                     prepay_date=null;
                                                 }
                                              else
                                                {
                                             intmonth=yearDiff(bl_per_fr,bl_per_to);
                                                }

                                             if(arrear>0)        // calculate interest on arrear
                                             {
                                              interest=(arrear*intmonth*15)/(100*12);
                                              arrear=arrear+interest;
                                              totinterest=totinterest+interest;
                                             }

                                              /////////////////////////////////////
                                              pramt= arrear +bill_amt-totinterest;
                                              pdamt=pramt-paid_amt;
                                              if(pdamt<0)
                                              totinterest=totinterest-Math.abs(pdamt);
                                               if(totinterest<0)
                                                 totinterest=0;
                                              //////////////////////////////////////
                                               arrear=arrear+bill_amt;
                                               intmonth=yearDiff(bl_per_to,pay_date);
                                             if(arrear>0)               //calculate interest if arrear >0 after payment
                                             {
                                               interest=(arrear*intmonth*15)/(100*12);
                                              arrear=arrear+interest;
                                              totinterest=totinterest+interest;

                                             }
                                             arrear=arrear-paid_amt;


                                     }
                                    else if(pay_date.before(bl_per_fr))
                                      {

                                         if(prepay_date!=null&& prepay_date.before(pay_date))
                                                {
                                                   intmonth=yearDiff(prepay_date,pay_date);
                                                   if(prepay_date.before(pay_date)||prepay_date.equals(pay_date))
                                                     prepay_date=null;
                                                 }
                                              else
                                                {
                                             intmonth=0;
                                                }
                                              if(arrear>0)        // calculate interest on arrear
                                               {
                                                interest=(arrear*intmonth*15)/(100*12);
                                                arrear=arrear+interest;
                                                totinterest=totinterest+interest;

                                               }

                                             /////////////////////////////////////
                                              pramt= arrear +bill_amt-totinterest;
                                              pdamt=pramt-paid_amt;
                                              if(pdamt<0)
                                              totinterest=totinterest-Math.abs(pdamt);
                                               if(totinterest<0)
                                              totinterest=0;
                                           //////////////////////////////////////
                                             arrear=arrear+bill_amt-paid_amt;

                                      }
                                    else
                                      {
                                         if(prepay_date!=null)
                                                {
                                                   intmonth=yearDiff(prepay_date,pay_date);
                                                   if(prepay_date.before(pay_date)||prepay_date.equals(pay_date))
                                                     prepay_date=null;
                                                 }
                                              else
                                                {
                                             intmonth=yearDiff(bl_per_fr,pay_date);
                                                }
                                              if(arrear>0)        // calculate interest on arrear
                                               {
                                                interest=(arrear*intmonth*15)/(100*12);
                                                arrear=arrear+interest;
                                                totinterest=totinterest+interest;

                                               }

                                              /////////////////////////////////////
                                               pramt= arrear +bill_amt-totinterest;
                                               pdamt=pramt-paid_amt;
                                               if(pdamt<0)
                                                totinterest=totinterest-Math.abs(pdamt);
                                               if(totinterest<0)
                                                totinterest=0;
                                              //////////////////////////////////////
                                              arrear=arrear+bill_amt-paid_amt;

                                               intmonth=yearDiff(pay_date,bl_per_to);
                                            if(arrear>0)               //calculate interest if arrear >0 after payment
                                             {
                                               interest=(arrear*intmonth*15)/(100*12);
                                              arrear=arrear+interest;
                                              totinterest=totinterest+interest;

                                             }
                                    }
                                  }
                             }



                     ////////-------------------------for bl_per_fr after 31/3/2002-----------------------------/////

                else if((bl_per_fr.after(new GregorianCalendar(2002,2,31))))
                  {

                      ////----------When Pay Date is null----------------////
                      if(pay_date==null)
                         {


                            if(arrear1>0)
                                  {
                                      if(prepay_date!=null)
                                       {
                                          intmonth=yearDiff(prepay_date,bl_per_to);
                                          if(prepay_date.before(bl_per_to)||prepay_date.equals(bl_per_to))
                                                     prepay_date=null;
                                       }
                                      else
                                       {
                                          intmonth=yearDiff(bl_per_fr,bl_per_to);
                                       }

                                         if((bl_per_fr.after(new GregorianCalendar(2002,2,31)))&&(bl_per_fr.before(new GregorianCalendar(2003,3,1))))
                                           interest=(arrear1*intmonth*24)/(100*12);
                                         else
                                           interest=(arrear1*intmonth*15)/(100*12);
                                           arrear=arrear+interest;
                                           totinterest=totinterest+interest;

                                 }


                           if(arrear<0)                 //if credit amount>0
                             {
                                     arrear=arrear+bill_amt;
                                     //arrear1=arrear;
                                

                                     if(arrear>0)      //if credit is less than current bill amt
                                     {
                                      flag4=1;
                                     }
                            }
                                 else
                                     arrear=arrear+bill_amt;

                                         if(billamt>0)
                                         {
                                              intmonth=yearDiff(bl_per_fr,bl_per_to);
                                           if((bl_per_fr.after(new GregorianCalendar(2002,2,31)))&&(bl_per_fr.before(new GregorianCalendar(2003,3,1))))
                                            interest=(billamt*intmonth*24)/(100*12);
                                           else
                                            interest=(billamt*intmonth*15)/(100*12);
                                           if(bilcycle==4||bilcycle==12)
                                            billamt=billamt+interest;
                                            arrear=arrear+interest;
                                            totinterest=totinterest+interest;
                                         }

                                        if(flag4==1)
                                        {
                                            bill_amt=bill_amt-credit;
                                        }

                                 }

                         ///////----------------------When pay date is not null---------------------------------//////
                             else
                             {

                               //-------------When pay date is after bl_per_to-----//
                                    if(pay_date.after(bl_per_to))
                                    {


                                        ///////////-------------when bill period is not last bill period---------------------///////////////////
                                        if((bl_per_to.get(Calendar.MONTH)!=2)&&(bl_per_to.get(Calendar.DATE)!=31))
                                        {
                                             if(arrear1>0)             // calculate interest if previous arrear exists
                                           {
                                             if(prepay_date!=null)
                                                {
                                                  /* Original code
                                                   intmonth=yearDiff(prepay_date,bl_per_to);
                                                   prepay_date=null;
                                                    */
                                                  //My change
                                                  intmonth=yearDiff(prepay_date,pay_date);
                                                  if(prepay_date.before(bl_per_to)||prepay_date.equals(bl_per_to))
                                                     prepay_date=null;
                                                 ////

                                                 }
                                              else
                                                {
                                                  intmonth=yearDiff(bl_per_fr,pay_date);
                                                }

                                             if((bl_per_fr.after(new GregorianCalendar(2002,2,31)))&&(bl_per_fr.before(new GregorianCalendar(2003,3,1))))
                                               interest=(arrear1*intmonth*24)/(100*12);
                                             else
                                               interest=(arrear1*intmonth*15)/(100*12);
                                               arrear=arrear+interest;
                                               totinterest=totinterest+interest;
                                           }


                                          if(billamt>0)          //calculate interest on previous unpaid billamt
                                           {

                                              intmonth=yearDiff(bl_per_fr,bl_per_to);

                                             if((bl_per_fr.after(new GregorianCalendar(2002,2,31)))&&(bl_per_fr.before(new GregorianCalendar(2003,3,1))))
                                              interest=(billamt*intmonth*24)/(100*12);
                                             else
                                              interest=(billamt*intmonth*15)/(100*12);

                                             if(bilcycle==4||bilcycle==12)
                                               billamt=billamt+interest;
                                              arrear=arrear+interest;
                                              totinterest=totinterest+interest;
                                            }

                                             billamt=billamt+bill_amt;
                                           if(billamt>0)          //calculate interest on previous unpaid billamt
                                           {
                                              bl_per_to1.set(bl_per_to.get(Calendar.YEAR),bl_per_to.get(Calendar.MONTH),bl_per_to.get(Calendar.DATE)+1);
                                              intmonth=yearDiff(bl_per_to1,pay_date);

                                             if((bl_per_fr.after(new GregorianCalendar(2002,2,31)))&&(bl_per_fr.before(new GregorianCalendar(2003,3,1))))
                                              interest=(billamt*intmonth*24)/(100*12);
                                             else
                                              interest=(billamt*intmonth*15)/(100*12);

                                              arrear=arrear+interest;
                                              totinterest=totinterest+interest;
                                            }


                                            if(bl_per_fr.get(Calendar.MONTH)>=0&&bl_per_fr.get(Calendar.MONTH)<=2)
                                              {
                                                  endbl_per_to.set(bl_per_fr.get(Calendar.YEAR),2,31);
                                              }
                                              else if(bl_per_fr.get(Calendar.MONTH)>=3&&bl_per_fr.get(Calendar.MONTH)<=11)
                                              {
                                                  endbl_per_to.set(bl_per_fr.get(Calendar.YEAR)+1,2,31);
                                              }

                                              if(bflag==1)
                                              {
                                                bill_amt=0.0;
                                              }
                                              else
                                              {
                                              intmonth=yearDiff(bl_per_fr,endbl_per_to);
                                              bill_amt=rate*intmonth;
                                              }
                                             // bill_amt=rate*12-bill_amt2;
                                                 arrear=arrear+bill_amt;
                                              bflag=1;

                                               /////////////////////////////////////
                                              pramt= arrear-totinterest;
                                              pdamt=pramt-paid_amt;
                                              if(pdamt<0)
                                              totinterest=totinterest-Math.abs(pdamt);
                                                if(totinterest<0)
                                              totinterest=0;
                                              //////////////////////////////////////

                                              arrear=arrear-paid_amt;
                                              if(arrear>0)
                                              arrear1=arrear;          //new arrear after payment
                                              else
                                              arrear1=0;
                                              totinterest=totinterest+interest;


                                        }
                           /////////////////////-------------------------//////////////////////////////
                                else
                                   {


                                         if(arrear1>0)             // calculate interest if previous arrear exists
                                           {
                                              if(prepay_date!=null)
                                                {
                                                   intmonth=yearDiff(prepay_date,bl_per_to);
                                                   if(prepay_date.before(bl_per_to)||prepay_date.equals(bl_per_to))
                                                     prepay_date=null;
                                                 }
                                              else
                                                {
                                                  intmonth=yearDiff(bl_per_fr,bl_per_to);
                                                }

                                             if((bl_per_fr.after(new GregorianCalendar(2002,2,31)))&&(bl_per_fr.before(new GregorianCalendar(2003,3,1))))
                                               interest=(arrear1*intmonth*24)/(100*12);
                                             else
                                               interest=(arrear1*intmonth*15)/(100*12);
                                               arrear=arrear+interest;
                                               totinterest=totinterest+interest;
                                           }
                                               arrear=arrear+bill_amt;

                                          if(billamt>0)          //calculate interest on previous unpaid billamt
                                           {

                                              intmonth=yearDiff(bl_per_fr,bl_per_to);

                                             if((bl_per_fr.after(new GregorianCalendar(2002,2,31)))&&(bl_per_fr.before(new GregorianCalendar(2003,3,1))))
                                              interest=(billamt*intmonth*24)/(100*12);
                                             else
                                              interest=(billamt*intmonth*15)/(100*12);

                                             if(bilcycle==4||bilcycle==12)
                                               billamt=billamt+interest;
                                              arrear=arrear+interest;
                                              totinterest=totinterest+interest;
                                            }

                                              if(arrear>0)
                                              arrear1=arrear;             //new arrear for next billperiod
                                              else
                                              arrear1=0;

                                             bl_per_to1.set(bl_per_to.get(Calendar.YEAR),3,1);   //calculate interest on new arrear
                                            intmonth=yearDiff(bl_per_to1,pay_date);

                                             if((bl_per_fr.after(new GregorianCalendar(2002,2,31)))&&(bl_per_fr.before(new GregorianCalendar(2003,3,1))))
                                               interest=(arrear1*intmonth*24)/(100*12);
                                             else
                                              interest=(arrear1*intmonth*15)/(100*12);

                                             /////////////////////////////////////
                                              totinterest=totinterest+interest;
                                              pramt= arrear-totinterest;
                                              pdamt=pramt-paid_amt;
                                              if(pdamt<0)
                                              totinterest=totinterest-Math.abs(pdamt);
                                                if(totinterest<0)
                                              totinterest=0;
                                              //////////////////////////////////////

                                              arrear=arrear+interest-paid_amt;
                                              if(arrear>0)
                                              arrear1=arrear;          //new arrear after payment
                                              else
                                              arrear1=0;
                                              //totinterest=totinterest+interest;
                                     }
                              }
                                       ////----------When pay date is earlier than bl_per_fr----------------////


                                      else if(pay_date.before(bl_per_fr))
                                    {

                                          if(rebate>0)          //if cons gets rebate
                                           {
                                              /////////////////////////////////////
                                              pramt= arrear+bill_amt-rebate-totinterest;
                                              pdamt=pramt-paid_amt;
                                               if(pdamt<0)
                                                totinterest=totinterest-Math.abs(pdamt);
                                               if(totinterest<0)
                                                totinterest=0;
                                              //////////////////////////////////////
                                                bill_amt=bill_amt*bilcycle;
                                              arrear=arrear+bill_amt-paid_amt-rebate;
                                              flag=1;
                                           }
                                           else
                                           {
                                              /////////////////////////////////////
                                              pramt= arrear+bill_amt-totinterest;
                                              pdamt=pramt-paid_amt;
                                              if(pdamt<0)
                                              totinterest=totinterest-Math.abs(pdamt);
                                              if(totinterest<0)
                                               totinterest=0;
                                              //////////////////////////////////////

                                                //-----flag1=1;
                                               if(bl_per_fr.get(Calendar.MONTH)>=0&&bl_per_fr.get(Calendar.MONTH)<=2)
                                              {
                                                  endbl_per_to.set(bl_per_fr.get(Calendar.YEAR),2,31);
                                              }
                                              else if(bl_per_fr.get(Calendar.MONTH)>=3&&bl_per_fr.get(Calendar.MONTH)<=11)
                                              {
                                                  endbl_per_to.set(bl_per_fr.get(Calendar.YEAR)+1,2,31);
                                              }

                                               if(bflag==1)
                                              {
                                                bill_amt=0.0;
                                              }
                                              else
                                              {
                                              intmonth=yearDiff(bl_per_fr,endbl_per_to);
                                              bill_amt=rate*intmonth;
                                              }
                                              
                                             // bill_amt=rate*12-bill_amt2;
                                              arrear=arrear+bill_amt-paid_amt;
                                               bflag=1;

                                            }
                                              if(arrear>0)
                                              arrear1=arrear;
                                              else
                                              arrear1=0;

                                             if(arrear1>0)                   //calculate interest if arrear exists after payment
                                            {
                                              intmonth=yearDiff(bl_per_fr,bl_per_to);
                                              if((bl_per_fr.after(new GregorianCalendar(2002,2,31)))&&(bl_per_fr.before(new GregorianCalendar(2003,3,1))))
                                               interest=(arrear1*intmonth*24)/(100*12);
                                              else
                                               interest=(arrear1*intmonth*15)/(100*12);
                                              arrear=arrear+interest;
                                              totinterest=totinterest+interest;
                                            }

                                      }

                      ////---------------When pay date lies between bl_per_fr and bl_per_to----------------////
                               else
                               {
                                     if((arrear1>0))          //calculate interest if previous arrear exists
                                      {
                                            if(prepay_date!=null)
                                             {
                                                 intmonth=yearDiff(prepay_date,pay_date);
                                                 if(prepay_date.before(pay_date)||prepay_date.equals(pay_date))
                                                     prepay_date=null;
                                             }
                                            else
                                             {
                                              //-- long diff=pay_date.getTime()-bl_per_fr1.getTime();
                                                intmonth=yearDiff(bl_per_fr,pay_date);
                                             }
                                           if((bl_per_fr.after(new GregorianCalendar(2002,2,31)))&&(bl_per_fr.before(new GregorianCalendar(2003,3,1))))
                                             interest=(arrear1*intmonth*24)/(100*12);
                                           else
                                             interest=(arrear1*intmonth*15)/(100*12);
                                            arrear=arrear+interest;
                                            totinterest=totinterest+interest;
                                       }


                                         if(billamt>0)            //calculate interest on previous unpaid billamt
                                         {
                                               intmonth=yearDiff(bl_per_fr,pay_date);
                                            if((bl_per_fr.after(new GregorianCalendar(2002,2,31)))&&(bl_per_fr.before(new GregorianCalendar(2003,3,1))))
                                              interest=(billamt*intmonth*24)/(100*12);
                                            else
                                              interest=(billamt*intmonth*15)/(100*12);
                                            if(bilcycle==4||bilcycle==12)
                                               billamt=billamt+interest;
                                             arrear=arrear+interest;
                                              totinterest=totinterest+interest;
                                          }

                                          if(rebate>0)            //if cons gets rebate
                                           {

                                              /////////////////////////////////////////
                                              pramt= arrear+bill_amt-rebate-totinterest;
                                              pdamt=pramt-paid_amt;
                                              if(pdamt<0)
                                              totinterest=totinterest-Math.abs(pdamt);
                                              if(totinterest<0)
                                              totinterest=0;
                                              //////////////////////////////////////
                                           //-- arrear=arrear+bill_amt1-paid_amt-rebate;
                                               bill_amt=bill_amt*bilcycle;
                                              arrear=arrear+bill_amt-paid_amt-rebate;
                                            flag=1;
                                           }
                                           else
                                           {
                                              /////////////////////////////////////
                                              pramt= arrear+bill_amt-totinterest;
                                              pdamt=pramt-paid_amt;
                                              if(pdamt<0)
                                              totinterest=totinterest-Math.abs(pdamt);
                                              if(totinterest<0)
                                              totinterest=0;
                                              //////////////////////////////////////

                                              //-----  arrear=arrear+bill_amt2-paid_amt;
                                             if(bl_per_fr.get(Calendar.MONTH)>=0&&bl_per_fr.get(Calendar.MONTH)<=2)
                                              {
                                                  endbl_per_to.set(bl_per_fr.get(Calendar.YEAR),2,31);
                                              }
                                            else if(bl_per_fr.get(Calendar.MONTH)>=3&&bl_per_fr.get(Calendar.MONTH)<=11)
                                              {
                                                  endbl_per_to.set(bl_per_fr.get(Calendar.YEAR)+1,2,31);
                                              }

                                               if(bflag==1)
                                              {
                                                bill_amt=0.0;
                                              }
                                              else
                                              {
                                              intmonth=yearDiff(bl_per_fr,endbl_per_to);
                                              bill_amt=rate*intmonth;
                                              }
                                               //bill_amt=rate*12-bill_amt2;
                                              arrear=arrear+bill_amt-paid_amt;
                                               bflag=1;
                                               //----- flag1=1;
                                           }
                                              if(arrear>0)
                                              arrear1=arrear;
                                              else
                                              arrear1=0;


                                         pay_date2.set(pay_date.get(Calendar.YEAR),pay_date.get(Calendar.MONTH)+1,1);

                                          if(arrear1>0&&bl_per_to.after(pay_date2))    //calculate interest on new arrear for remaining period after pay_date
                                          {

                                               intmonth=yearDiff(pay_date2,bl_per_to);
                                           if((bl_per_fr.after(new GregorianCalendar(2002,2,31)))&&(bl_per_fr.before(new GregorianCalendar(2003,3,1))))
                                            interest=(arrear1*intmonth*24)/(100*12);
                                           else
                                            interest=(arrear1*intmonth*15)/(100*12);
                                            arrear=arrear+interest;
                                            totinterest=totinterest+interest;
                                           }

                                 }
                                        totalcss=totalcss-paidcss;
                             }
                       }


                            if(arrear<=0)
                           {
                              totinterest=0;
                           }

                           if(arrear<0)
                             credit=Math.abs(arrear);
                           else
                              credit=0.0;

                      ////find cess arrear and interest


                       if((bl_per_fr.get(Calendar.MONTH)==3&&bl_per_fr.get(Calendar.DATE)==1))
                       {

                         if(precssarr>0)
                           {
                             cssinterest=precssarr*.24;
                            }
                           else
                            cssinterest=0;
                            cssarrear=totalcss+cssinterest;
                            totalcss=totalcss+cssinterest;
                       }
                       else
                          cssarrear=totalcss;

                          currentamt=bill_amt+css;
                          if(arrear>0)
                          {
                           totamt=arrear+cssarrear;
                           principle=arrear-totinterest;
                          }
                          else
                          {
                            totamt=cssarrear;
                            principle=0;
                          }

                         /* String sql1="update caltbl_001 set arrear=?,credit=?,rebate=?,cssrate=?,css=?,cssarrear=?,currentamt=?,totamt=?" +
                                  ",principle=?,interest=? where bl_per_fr=? and cons_no=?";
                          pst=(OraclePreparedStatement)con.prepareStatement(sql1);
                          if(arrear<0)
                          pst.setDouble(1,0.0);
                          else
                          pst.setDouble(1,arrear);
                          pst.setDouble(2,credit);
                          pst.setDouble(3,rebate);
                          pst.setDouble(4,cssrate);
                          pst.setDouble(5,css);
                          pst.setDouble(6,cssarrear);
                          pst.setDouble(7,currentamt);
                          pst.setDouble(8,totamt);
                          pst.setDouble(9,principle);
                          pst.setDouble(10,totinterest);
                          pst.setDate(11,bl_per_fr);
                          pst.setString(12,cons_no);
                          ((OraclePreparedStatement)pst).executeUpdate();
                          */

                              if(arrear<0)
                               alrow.add(19, 0);
                              else
                               alrow.add(19, arrear);
                               alrow.add(20, credit);
                               alrow.add(21, cal_date);
                               alrow.add(22, surcharge);
                               alrow.add(23, due_dt);
                               alrow.add(24, err);
                               alrow.add(25, css);
                               alrow.add(26, totamt);
                               alrow.add(27, totpaidamount);
                               alrow.add(28, principle);
                               alrow.add(29, currentamt);
                               alrow.add(30, rebate);
                               alrow.add(31, cssarrear);
                               alrow.add(32, csscredit);
                               alrow.add(33, cssrate);
                               alrow.add(34, totinterest);

                          //System.out.println("bill amount:"+bill_amt);
                          //System.out.println("Arrear:"+arrear);
                          //System.out.println("Cess Arrear:"+cssarrear);

                          if(bl_per_to.get(Calendar.MONTH)==2&&bl_per_to.get(Calendar.DATE)==31)
                            {
                              if(arrear>0)
                                arrear1=arrear;
                              else
                                arrear1=0;
                             precssarr=totalcss;
                             prepay_date=null;
                             //flagrebate=0;
                           }
                           if(pay_date!=null)
                            {
                              if(pay_date.after(bl_per_to))
                             {
                               prepay_date=Calendar.getInstance();
                               prepay_date.set(pay_date.get(Calendar.YEAR),pay_date.get(Calendar.MONTH)+1,1);
                             }
                            }

                          interest=0.0;
                          rebate=0.0;


                          if((!(bl_per_to.get(Calendar.MONTH)==2&&bl_per_to.get(Calendar.DATE)==31))&&arrear>0&&pay_date==null&&bilcycle==2)
                          {
                             billamt=bill_amt;
                             

                          }
                          else if((!(bl_per_to.get(Calendar.MONTH)==2&&bl_per_to.get(Calendar.DATE)==31))&&arrear>0&&pay_date==null&&(bilcycle==4||bilcycle==12))
                          {
                             billamt=billamt+bill_amt;
                            

                          }
                          else
                          {
                             billamt=0;
                             

                          }


                        if(bl_per_to.get(Calendar.MONTH)==2&&bl_per_to.get(Calendar.DATE)==31)
                        {
                            //flag=0;
                            bflag=0;
                        }
                      flag4=0;

                 }

                      //System.out.println("contents of al"+al);
                      //System.out.println("Size of al"+al.size());

                   /*for (int a = 0; a < al.size(); a++)
                     {

                         alrow= (ArrayList) al.get(a);
                         Iterator itr1 =alrow.iterator();
                           while(itr1.hasNext())
                          {

                          Object element=itr1.next();
                          System.out.print(element + " ");

                          }
                          System.out.println();
                     }*/

      }catch(Exception ex)
         {
             System.out.println(ex);
         }
         return al;

   }

}