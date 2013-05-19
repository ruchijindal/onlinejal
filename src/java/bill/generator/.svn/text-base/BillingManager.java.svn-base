/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bill.generator;

import com.smp.jal.ConvertToDate;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.*;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 *
 * @author smp-06
 */
//@Stateless
public class BillingManager implements Runnable {

    // @PersistenceContext(unitName = "NEWDMSPU")
    BillUtility billUtility = new BillUtility();
    ConvertToDate convertToDate = new ConvertToDate();
    String division;
    int status;
    boolean cancel;
    BillDescription billDescription;
    String consumerNo;
    Calendar dateTo;
    Calendar dueDate;
    Thread thread;
    Connection con;
    String sql;
    String table;
    PreparedStatement pst;
    ResultSet rs, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10;
    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");

    public BillingManager() {
    }

    public BillingManager(String division, String consumerNo, Calendar dateTo, Calendar dueDate) {

        this.division = division;
        this.consumerNo = consumerNo;

        this.dateTo = dateTo;
        this.dueDate = dueDate;
        this.status = 0;
        this.cancel = true;
    }

    @Override
    public void run() {
        this.billDescription = calculateBill(this.division, this.consumerNo, this.dateTo, this.dueDate);
    }

    public double getRateByConsumerNo(String cons_no, String division) {
        double rate = 0;
        table = "master" + division.charAt(division.length() - 1);
        sql = "select * from " + table.trim() + " where trim(cons_no)='" + cons_no + "'";
        try {
            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
            con = dataSource.getConnection();
            pst = con.prepareStatement(sql);
            Statement st = con.createStatement();
            rs8 = st.executeQuery(sql);

            if (rs8.next()) {
                if (rs8.getInt("pipe_size") == 15 && rs8.getString("flat_type").trim().equals("PLOT")) {
                    rate = getRate(rs8.getString("con_tp"), rs8.getString("cons_ctg"), rs8.getString("flat_type"), rs8.getBigDecimal("plot_size"), rs8.getBigDecimal("pipe_size"), new Date());
                } else if (!rs8.getString("flat_type").trim().equals("PLOT")) {
                    rate = getRateForFlat(rs8.getString("con_tp"), rs8.getString("cons_ctg"), rs8.getString("flat_type"), rs8.getBigDecimal("pipe_size").intValue(), rs5.getString("sector").trim(), new Date());
                } else {
                    rate = getRateForBulk(rs8.getString("con_tp"), rs8.getString("cons_ctg"), rs8.getString("flat_type"), rs8.getBigDecimal("pipe_size"), new Date());
                }
                //  rate= getRate(rs8.getString("con_tp"), rs8.getString("cons_ctg"), rs8.getString("flat_type"), rs8.getBigDecimal("plot_size"), rs8.getBigDecimal("pipe_size"),  );
            } else {
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();

        }

        return rate;
    }

    public double getRate(String connType, String connCategory, String flatType, BigDecimal plotSize, BigDecimal pipeSize, Date rateYear) {
        Calendar staffDate = Calendar.getInstance();
        staffDate.set(1999, 10, 30);
        Calendar rateYear1 = Calendar.getInstance();
        rateYear1.setTime(rateYear);
        double rate = 0.0;
        Rates rates = null;
        List<Rates> ratesList = new ArrayList<Rates>();


        // @NamedQuery(name = "Rates.findByCriteria", query = "SELECT r FROM Rates r WHERE (r.pipeSize = :pipeSize) and (r.connType = :connType) and (r.dateFrom < :dateFrom and r.dateTo > :dateTo) and (r.connCategory = :connCategory) and (r.minPlotSize < :minPlotSize and r.maxPlotSize > :maxPlotSize)"),
        try {
            sql = "select *  from Rates where (pipe_size =?) and (conn_type =?) and  (conn_category=?) and  (min_plot_size < ? and max_plot_size > ?)";
            pst = con.prepareStatement(sql);
            pst.setBigDecimal(1, pipeSize);
            pst.setString(2, connType);

            pst.setString(3, connCategory);
            pst.setBigDecimal(4, plotSize);
            pst.setBigDecimal(5, plotSize);

            rs = pst.executeQuery();

            //  List<Rates> RateList = em.createNamedQuery("Rates.findByCriteria").setParameter("pipeSize", pipeSize).setParameter("connType", connType).setParameter("minPlotSize", plotSize).setParameter("maxPlotSize", plotSize).setParameter("connCategory", connCategory).setParameter("dateFrom", rateYear).setParameter("dateTo", rateYear).getResultList();
            while (rs.next()) {
                rates = new Rates();
                rates.setConnCategory(rs.getString("conn_category"));
                rates.setConnType(rs.getString("conn_type"));
                rates.setDateFrom(rs.getDate("date_from"));
                rates.setDateTo(rs.getDate("date_to"));
                rates.setFlatType(rs.getString("flat_type"));
                if (rs.getBigDecimal("max_plot_size") != null) {
                    rates.setMaxPlotSize(rs.getBigDecimal("max_plot_size").toBigInteger());
                }
                if (rs.getBigDecimal("min_plot_size") != null) {
                    rates.setMinPlotSize(rs.getBigDecimal("min_plot_size").toBigInteger());
                }
                if (rs.getBigDecimal("pipe_size") != null) {
                    rates.setPipeSize(rs.getBigDecimal("pipe_size").toBigInteger());
                }
                rates.setRate(rs.getDouble("rate"));
                rates.setSector(rs.getString("sector"));
                ratesList.add(rates);
            }

            if (!ratesList.isEmpty() && !rateYear.before(ratesList.get(0).getDateFrom())) {
                for (int i = 0; i < ratesList.size(); i++) {

                    if (i < (ratesList.size() - 1) && (rateYear.compareTo(ratesList.get(i).getDateFrom()) >= 0 && rateYear.compareTo(ratesList.get(i + 1).getDateFrom()) < 0)) {
                        rate = ratesList.get(i).getRate();

                        break;
                    }
                    if (i == ratesList.size() - 1) {
                        rate = ratesList.get(i).getRate();
                    }

                }
            }


            if (connType.equals("S") && rateYear1.after(staffDate)) {
                rate = 0.0;
            }
        } catch (Exception e) {
            System.out.println("Exception in getRate " + e);

        }
        return rate;
    }

    public double getRateForBulk(String connType, String connCategory, String flatType, BigDecimal pipeSize, Date rateYear) {
        //@NamedQuery(name = "Rates.findByCriteriaForBulk", query = "SELECT r FROM Rates r WHERE (r.pipeSize = :pipeSize) and (r.connType = :connType) and (r.dateFrom < :dateFrom and r.dateTo > :dateTo) and (r.connCategory = :connCategory) "),
        double rate = 0.0;
        try {
            sql = "select *  from Rates where (pipe_size =?) and (conn_type =?) and (conn_category=?) order by date_from ";
            pst = con.prepareStatement(sql);
            pst.setBigDecimal(1, pipeSize);
            pst.setString(2, connType);

            pst.setString(3, connCategory);

            rs1 = pst.executeQuery();
            Rates rates = null;
            List<Rates> ratesList = new ArrayList<Rates>();
            //List<Rates> RateList = em.createNamedQuery("Rates.findByCriteriaForBulk").setParameter("pipeSize", pipeSize).setParameter("connType", connType).setParameter("connCategory", connCategory).setParameter("dateFrom", rateYear).setParameter("dateTo", rateYear).getResultList();

            while (rs.next()) {
                rates = new Rates();
                rates.setConnCategory(rs.getString("conn_category"));
                rates.setConnType(rs.getString("conn_type"));
                rates.setDateFrom(rs.getDate("date_from"));
                rates.setDateTo(rs.getDate("date_to"));
                rates.setFlatType(rs.getString("flat_type"));
                if (rs.getBigDecimal("max_plot_size") != null) {
                    rates.setMaxPlotSize(rs.getBigDecimal("max_plot_size").toBigInteger());
                }
                if (rs.getBigDecimal("min_plot_size") != null) {
                    rates.setMinPlotSize(rs.getBigDecimal("min_plot_size").toBigInteger());
                }
                if (rs.getBigDecimal("pipe_size") != null) {
                    rates.setPipeSize(rs.getBigDecimal("pipe_size").toBigInteger());
                }
                rates.setRate(rs.getDouble("rate"));
                rates.setSector(rs.getString("sector"));
                ratesList.add(rates);
            }

            if (!ratesList.isEmpty() && !rateYear.before(ratesList.get(0).getDateFrom())) {
                for (int i = 0; i < ratesList.size(); i++) {

                    if (i < (ratesList.size() - 1) && (rateYear.compareTo(ratesList.get(i).getDateFrom()) >= 0 && rateYear.compareTo(ratesList.get(i + 1).getDateFrom()) < 0)) {
                        rate = ratesList.get(i).getRate();

                        break;
                    }
                    if (i == ratesList.size() - 1) {
                        rate = ratesList.get(i).getRate();
                    }

                }
            }
        } catch (Exception e) {
            System.out.println("Exception in getRateForBulk " + e);

        }

        return rate;
    }

    public double getRateForFlat(String connType, String connCategory, String flatType, int pipeSize, String sector, Date rateYear) {

        // @NamedQuery(name = "Rates.findByCriteriaForFlat", query = "SELECT r FROM Rates r WHERE  (r.connType = :connType) and (r.dateFrom < :dateFrom and r.dateTo > :dateTo) and (r.connCategory = :connCategory) and (r.sector = :sector) and (r.flatType =  :flatType)"),

        // List<Rates> RateList = em.createNamedQuery("Rates.findByCriteriaForFlat").setParameter("connType", connType).setParameter("connCategory", connCategory).setParameter("dateFrom", rateYear).setParameter("dateTo", rateYear).setParameter("flatType", flatType).setParameter("sector", sector).getResultList();
        double rate = 0.0;
        try {
            sql = "select * from Rates where (conn_type =?) and  (conn_category=?) and (trim(sector) = ?) and (flat_type =  ?) order by date_from ";
            pst = con.prepareStatement(sql);

            pst.setString(1, connType);
            pst.setString(2, connCategory);
            pst.setString(3, sector.trim());
            pst.setString(4, flatType);

            rs2 = pst.executeQuery();

            Rates rates = null;
            List<Rates> ratesList = new ArrayList<Rates>();
            //List<Rates> RateList = em.createNamedQuery("Rates.findByCriteriaForBulk").setParameter("pipeSize", pipeSize).setParameter("connType", connType).setParameter("connCategory", connCategory).setParameter("dateFrom", rateYear).setParameter("dateTo", rateYear).getResultList();

            while (rs.next()) {
                rates = new Rates();
                rates.setConnCategory(rs.getString("conn_category"));
                rates.setConnType(rs.getString("conn_type"));
                rates.setDateFrom(rs.getDate("date_from"));
                rates.setDateTo(rs.getDate("date_to"));
                rates.setFlatType(rs.getString("flat_type"));
                if (rs.getBigDecimal("max_plot_size") != null) {
                    rates.setMaxPlotSize(rs.getBigDecimal("max_plot_size").toBigInteger());
                }
                if (rs.getBigDecimal("min_plot_size") != null) {
                    rates.setMinPlotSize(rs.getBigDecimal("min_plot_size").toBigInteger());
                }
                if (rs.getBigDecimal("pipe_size") != null) {
                    rates.setPipeSize(rs.getBigDecimal("pipe_size").toBigInteger());
                }
                rates.setRate(rs.getDouble("rate"));
                rates.setSector(rs.getString("sector"));
                ratesList.add(rates);
            }

            if (!ratesList.isEmpty() && !rateYear.before(ratesList.get(0).getDateFrom())) {
                for (int i = 0; i < ratesList.size(); i++) {

                    if (i < (ratesList.size() - 1) && (rateYear.compareTo(ratesList.get(i).getDateFrom()) >= 0 && rateYear.compareTo(ratesList.get(i + 1).getDateFrom()) < 0)) {
                        rate = ratesList.get(i).getRate();

                        break;
                    }
                    if (i == ratesList.size() - 1) {
                        rate = ratesList.get(i).getRate();
                    }

                }
            }
        } catch (Exception e) {
            System.out.println("Exception in getRateForFlat " + e);

        }
        return rate;
    }

    public double getInterestRate(Date rateDate) {

        //  @NamedQuery(name = "InterestRates.findByDateBetween", query = "SELECT i FROM InterestRates i WHERE i.dateFrom <= :dateFrom and i.dateTo >= :dateTo"),
        double rate = 0.0;
        try {
            sql = "select * from Interest_Rates order by date_from ";
            pst = con.prepareStatement(sql);
            rs3 = pst.executeQuery();
            InterestRates interestRates = null;
            List<InterestRates> interestRatesList = new ArrayList<InterestRates>();
            while (rs3.next()) {
                interestRates = new InterestRates();
                interestRates.setDateFrom(rs3.getDate("date_from"));
                interestRates.setDateTo(rs3.getDate("date_to"));
                interestRates.setRate(rs3.getDouble("rate"));
                interestRatesList.add(interestRates);
            }




            // List<InterestRates> interestRateList = em.createNamedQuery("InterestRates.findByDateBetween").setParameter("dateFrom", rateDate).setParameter("dateTo", rateDate).getResultList();
            // InterestRates interestRates = new InterestRates();

            if (!interestRatesList.isEmpty() && !rateDate.before(interestRatesList.get(0).getDateFrom())) {
                for (int i = 0; i < interestRatesList.size(); i++) {

                    if (i < (interestRatesList.size() - 1) && ((rateDate.compareTo(interestRatesList.get(i).getDateFrom())) >= 0 && rateDate.compareTo(interestRatesList.get(i + 1).getDateFrom()) < 0)) {
                        interestRates = interestRatesList.get(i);

                        rate = interestRates.getRate();
                        break;
                    }
                    if (i == interestRatesList.size() - 1) {
                        interestRates = interestRatesList.get(i);

                        rate = interestRates.getRate();
                    }
                }

            }
        } catch (Exception e) {
            System.out.println("Exception in getInterestRate " + e);

        }
        return rate;
    }

    public Double getCessRate(Date cessDate, double pipeSize, String conType) {
        double rate = 0.0;
        try {
            sql = "select * from Cess_Rate where  pipe_size = ? and con_type like ?";
            pst = con.prepareStatement(sql);

            pst.setDouble(1, pipeSize);
            pst.setString(2, "%" + conType + "%");
            rs4 = pst.executeQuery();
            CessRate cessRate=null;
            List<CessRate> cessRateList=new ArrayList<CessRate>();

            // List<CessRate> cessRateList = em.createNamedQuery("CessRate.findByDateBetween").setParameter("dateFrom", cessDate).setParameter("dateTo", cessDate).getResultList();
            // CessRate cessRate = new CessRate();
            while(rs.next())
            {
                cessRate=new CessRate();
                cessRate.setConType(rs.getString("con_type"));
                cessRate.setDateFrom(rs.getDate("date_from"));
                cessRate.setDateTo(rs.getDate("date_to"));
                if(rs.getBigDecimal("pipe_size") !=null)
                cessRate.setPipeSize(rs.getBigDecimal("pipe_size").toBigInteger());
                cessRate.setRate(rs.getDouble("rate"));
                cessRateList.add(cessRate);
            }
          if (!cessRateList.isEmpty() && !cessDate.before(cessRateList.get(0).getDateFrom())) {
            for (int i = 0; i < cessRateList.size(); i++) {
                if (i < (cessRateList.size() - 1) && (cessDate.compareTo(cessRateList.get(i).getDateFrom())>=0 && cessDate.compareTo(cessRateList.get(i + 1).getDateFrom())<0)) {
                    cessRate = cessRateList.get(i);
                    rate = cessRate.getRate();
                }
                if (i == cessRateList.size() - 1) {
                    cessRate = cessRateList.get(i);
                    rate = cessRate.getRate();
                }
            }
        }
        } catch (Exception e) {
            System.out.println("Exception in getCessRate " + e);

        }
        return rate;
    }

    public double getDiscount(Date discountDate) {

        double rate = 0.0;

        try {
            sql = "select * from Discount_Rate where date_from <=? and date_to >= ?";
            pst = con.prepareStatement(sql);


            pst.setDate(1, new java.sql.Date(discountDate.getTime()));
            pst.setDate(2, new java.sql.Date(discountDate.getTime()));

            rs10 = pst.executeQuery();
            // List<CessRate> cessRateList = em.createNamedQuery("CessRate.findByDateBetween").setParameter("dateFrom", cessDate).setParameter("dateTo", cessDate).getResultList();
            // CessRate cessRate = new CessRate();

            if (rs10.next()) {

                rate = rs10.getDouble("rate");
            }
        } catch (Exception e) {
            System.out.println("Exception in getCessRate " + e);

        }
        return rate;
    }

    public BillDescription calculateBill(String division, String consumerNo, Calendar billTo, Calendar dueDate) {

        BillDescription billDescription = new BillDescription();
        try {
            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
            con = dataSource.getConnection();

            double billRate = 0.0;
            double cessRate = 0.0;
            double rebate = 0.0;
            double interestRate = 0.0;
            double principal = 0.0;
            double arrear = 0.0;
            double credit = 0.0;
            double interest = 0.0;
            double billAmount = 0.0;
            double paidAmount = 0.0;
            double cessAmount = 0.0;
            int id = 0;
            Calendar paymentDate = Calendar.getInstance();
            int billCycle = 1;
            int cyclePeriod = 1;
            double billRate1 = 0.0;
            table = "MASTER" + division.charAt((division.length() - 1));
            sql = "select sector,cons_nm1,con_tp,cons_ctg,flat_type,flat_no,blk_no,plot_size,pipe_size,reg_no,to_char(conn_dt,'DD-MM-YYYY'),esti_no,esti_amt,secu,to_char(esti_dt,'DD-MM-YYYY'),esti1_amt,nodue_amt,nodue_dt,cal_date,trans_nm,trf,id,comp_date from " + table + " where trim(cons_no)=?";
            pst = con.prepareStatement(sql);
            pst.setString(1, consumerNo);
            rs5 = pst.executeQuery();
//            if (master.getConsCtg() == null || master.getConTp() == null || master.getFlatType() == null || (master.getFlatType() != null && (master.getFlatType().equals("PLOT") && master.getPlotSize() == null) || master.getPipeSize() == null || (master.getCalDate() == null && master.getNodueDt() == null))) {
            //              billDescription = null;
//            }

            if (rs5.next() == false || rs5.getString("cons_ctg") == null || rs5.getString("con_tp") == null || rs5.getString("flat_type") == null || (rs5.getString("flat_type") != null && rs5.getString("flat_type").equals("PLOT") && rs5.getInt("plot_size") == 0 || rs5.getInt("pipe_size") == 0 || (rs5.getDate("cal_date") == null && rs5.getDate("nodue_dt") == null))) {
                billDescription = null;
                System.out.println("billDescription is null.");
            } else {

                Calendar calculationDate = billUtility.getCalDate(rs5.getDate("nodue_dt"), rs5.getDate("cal_date"));
                int billPeriod = billTo.get(Calendar.YEAR) - calculationDate.get(Calendar.YEAR);
                if (calculationDate.get(Calendar.MONTH) < 3) {
                    billPeriod++;
                }
                Calendar dateFrom = Calendar.getInstance();
                dateFrom.setTime(calculationDate.getTime());
                Calendar dateTo = Calendar.getInstance();
                Calendar lastPaymentDate = Calendar.getInstance();
                Calendar yearEnd = Calendar.getInstance();
                for (int i = 0; i < billPeriod || dateFrom.before(billTo); i++) {

                    System.out.println("......................................................................................");
                    paidAmount = 0.0;
                    billAmount = 0.0;
                    double cessInterest = 2.0;
                    yearEnd = billUtility.getDateTo(1, dateFrom);
                    String connCateg = "";
                    if (rs5.getString("cons_ctg").equals("T") && rs5.getDate("comp_date") != null && rs5.getDate("comp_date").before(dateFrom.getTime())) {
                        connCateg = "R";
                    } else {
                        connCateg = rs5.getString("cons_ctg");
                    }
                    if (rs5.getInt("pipe_size") != 0) {
                        // cessRate = billUtility.getCess(dateFrom, rs5.getString("con_tp"), rs5.getInt("pipe_size"));
                        cessRate = getCessRate(dateFrom.getTime(), rs5.getDouble("pipe_size"), rs5.getString("con_tp"));
                        System.out.println("cess rate=" + cessRate + "duration=" + ((yearEnd.get(Calendar.YEAR) - dateFrom.get(Calendar.YEAR)) * 12 - (dateFrom.get(Calendar.MONTH) - yearEnd.get(Calendar.MONTH)) + 1));
                        cessInterest = cessAmount * ((yearEnd.get(Calendar.YEAR) - dateFrom.get(Calendar.YEAR)) * 12 - (dateFrom.get(Calendar.MONTH) - yearEnd.get(Calendar.MONTH)) + 1) * 2 / 100;
                        cessAmount = cessInterest + cessAmount + cessRate * ((yearEnd.get(Calendar.YEAR) - dateFrom.get(Calendar.YEAR)) * 12 - (dateFrom.get(Calendar.MONTH) - yearEnd.get(Calendar.MONTH)) + 1);
                        if (rs5.getInt("pipe_size") == 15 && rs5.getString("flat_type").trim().equals("PLOT")) {
                            billRate = getRate(rs5.getString("con_tp"), connCateg, rs5.getString("flat_type"), rs5.getBigDecimal("plot_size"), rs5.getBigDecimal("pipe_size"), dateFrom.getTime());
                        } else if (!rs5.getString("flat_type").trim().equals("PLOT")) {
                            billRate = getRateForFlat(rs5.getString("con_tp"), connCateg, rs5.getString("flat_type"), rs5.getBigDecimal("pipe_size").intValue(), rs5.getString("sector").trim(), dateFrom.getTime());
                        } else {
                            billRate = getRateForBulk(rs5.getString("con_tp"), connCateg, rs5.getString("flat_type"), rs5.getBigDecimal("pipe_size"), dateFrom.getTime());
                        }
                        billRate1 = billRate;
                    }
                    if (billRate1 == 0) {
                        break;
                    }
                    interestRate = getInterestRate(dateFrom.getTime());

                    billCycle = billUtility.getBillCycle(billRate, dateFrom);
                    cyclePeriod = billUtility.getBillPeriod(billCycle, dateFrom);

                    Calendar dateFromForCycle2 = Calendar.getInstance();
                    dateFromForCycle2.setTime(dateFrom.getTime());
                    dateTo = billUtility.getDateTo(billCycle, dateFromForCycle2);
                    if (i == 0) {
                        lastPaymentDate.setTime(dateTo.getTime());
                    }
                    double preArear = 0.0;
                    if (arrear > 0) {
                        preArear = arrear;
                    }
                    double localArrear = 0.0;
                    double localInterest = 0.0;
                    for (int j = 0; j < billCycle && dateFromForCycle2.before(billTo); j++) {
                        billAmount = 0.0;
                        paidAmount = 0.0;
                        rebate = 0.0;
                        table = "Challan" + division.charAt((division.length() - 1));
                        System.out.println("challan======>" + table);
                        // @NamedQuery(name = "Challan1.findByConsNo&BlPerFr&BlPerTo", query = "SELECT c FROM Challan1 c                                                               WHERE TRIM(FROM c.consNo) = :consNo and      c.payDate >= :blPerFr and c.payDate <= :blPerTo and c.payDate >= c.blPerFr and c.payDate <= c.blPerTo and c.blPerFr is not null and c.blPerTo is not null and c.payDate is not null ORDER BY c.blPerFr"),
                        System.out.println("date1=====>" + new java.sql.Date(dateFromForCycle2.getTimeInMillis()));
                        System.out.println("date2=====>" + new java.sql.Date(dateTo.getTimeInMillis()));
                        System.out.println("consno=====>" + consumerNo);


                        sql = "select bl_per_fr,bl_per_to,due_dt,bill_amt,surcharge,paid_amt,pay_date,arrear,credit,recp_no,dis_cd,css,noc,secu,t_fee,bnk_cd,br_nm,id,discount from " + table + " where trim(cons_no)=? and pay_date >= ? and pay_date<= ? and pay_date >=bl_per_fr and pay_date <= bl_per_to and bl_per_fr is not null and bl_per_to is not null and pay_date is not null and (status is null or status = 'A') order by bl_per_fr";
                        pst = con.prepareStatement(sql);
                        pst.setString(1, consumerNo);
                        pst.setDate(2, new java.sql.Date(dateFromForCycle2.getTimeInMillis()));
                        pst.setDate(3, new java.sql.Date(dateTo.getTimeInMillis()));
                        rs6 = pst.executeQuery();
                        //  List<Challan> challanList = em.createNamedQuery("Challan" + division + ".findByConsNo&BlPerFr&BlPerTo").setParameter("consNo", masterList.get(x).getConsNo()).setParameter("blPerFr", dateFromForCycle2.getTime()).setParameter("blPerTo", dateTo.getTime()).getResultList();
                        int dateDifference = 0;
                        boolean bool = false;
                        bool = rs6.next();
                        if (!bool) {
                            // @NamedQuery(name = "Challan1.findByConsNo&Financialyear", query = "SELECT c FROM Challan1 c WHERE                                                      TRIM(FROM c.consNo) = :consNo and ( (c.blPerFr = :blPerFr and c.payDate < c.blPerFr) or (c.blPerTo = :blPerTo and (c.payDate is null or c.payDate > :blPerTo ))) and c.blPerFr is not null and c.blPerTo is not null  ORDER BY c.blPerFr"),

                            // challanList = em.createNamedQuery("Challan" + division + ".findByConsNo&Financialyear").setParameter("consNo", masterList.get(x).getConsNo()).setParameter("blPerFr", dateFromForCycle2.getTime()).setParameter("blPerTo", dateTo.getTime()).getResultList();
                            sql = "select bl_per_fr,bl_per_to,due_dt,bill_amt,surcharge,paid_amt,pay_date,arrear,credit,recp_no,dis_cd,css,noc,secu,t_fee,bnk_cd,br_nm,id,discount from " + table + " where trim(cons_no)=? and ((bl_per_fr = ? and pay_date < bl_per_fr) or ( bl_per_to =? and( pay_date is null or pay_date > ?))) and bl_per_fr is not null and bl_per_to is not null and (status is null or status = 'A')  order by bl_per_fr";
                            pst = con.prepareStatement(sql);
                            pst.setString(1, consumerNo);
                            pst.setDate(2, new java.sql.Date(dateFromForCycle2.getTimeInMillis()));
                            pst.setDate(3, new java.sql.Date(dateTo.getTimeInMillis()));
                            pst.setDate(4, new java.sql.Date(dateTo.getTimeInMillis()));
                            rs6 = pst.executeQuery();
                        }
                        if (bool) {
                            System.out.println("true........................");

                            if (rs6.getDate("pay_date") == null) {
                                System.out.print("paid amt-------> " + rs6.getDouble("paid_amt"));
                                rebate = billUtility.getRebate(dateFrom, dateTo.getTime(), billRate * 12, rs6.getDouble("paid_amt"), billCycle);


                            } else {
                                rebate = billUtility.getRebate(dateFrom, rs6.getDate("pay_date"), billRate * 12, rs6.getDouble("bill_amt"), billCycle);
                            }
                            //System.out.println("date=" + dateFrom.getTime() + " paid date=" + rs6.getDate("pay_date") + " billamount=" + (billRate * 12) + " paidamount=" + rs.getDouble("paid_amt") + " billcycle=" + billCycle);
                            billAmount = billRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1);

                            //billRate = 0;
                            paidAmount = rs6.getDouble("paid_amt");
                            paymentDate.setTime(rs6.getDate("pay_date"));

                            if (rs6.getDouble("css") != 0) {
                                paidAmount = paidAmount - rs6.getDouble("css");
                                cessAmount = cessAmount - rs6.getDouble("css");
                            }
                            if (rs6.getDouble("discount") != 0) {
                                paidAmount = paidAmount - rs6.getDouble("discount");
                            }
                            if (rs6.getDouble("secu") != 0) {
                                paidAmount = paidAmount - rs6.getDouble("secu");
                            }

                            System.out.println("paymentdate=" + paymentDate.getTime());
                            System.out.println("last payment date=" + lastPaymentDate.getTime());
                            preArear = preArear + localInterest;
                            System.out.println("prearrea=" + preArear);
                            if (paymentDate.after(lastPaymentDate) && credit <= 0 && paymentDate.getTimeInMillis() <= dueDate.getTimeInMillis()) {
                                //interest = interest + arrear * interestRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1) / (100 * 12);
                                Calendar f = Calendar.getInstance();
                                Calendar d = Calendar.getInstance();
                                f.setTimeInMillis(lastPaymentDate.getTimeInMillis());
                                d.setTimeInMillis(paymentDate.getTimeInMillis());
                                interest = interest + preArear * interestRate * billUtility.yearDiff(f, d) / (100 * 12);
                            }

                            if (paymentDate.after(dateTo) && credit <= 0 && paymentDate.getTimeInMillis() <= dueDate.getTimeInMillis()) {
                                Calendar f = Calendar.getInstance();
                                Calendar d = Calendar.getInstance();
                                f.setTimeInMillis(dateTo.getTimeInMillis());
                                d.setTimeInMillis(paymentDate.getTimeInMillis());
                                interest = interest + billAmount * interestRate * billUtility.yearDiff(f, d) / (100 * 12);
                            }
                            principal = principal + billAmount - (paidAmount + rebate + credit);
                            System.out.println("principal between financial year..............=" + principal);
                            System.out.println("interest between financial year..............=" + interest);

                            if (principal < 0) {

                                principal = principal + interest;
                                interest = 0;



                                if (principal < 0) {
                                    credit = -principal;
                                    principal = 0;
                                } else {
                                    credit = 0;
                                }
                            } else {
                                credit = 0;
                            }

                            if (credit < 0) {
                                principal = -credit;
                                credit = 0;
                            }
//                                else {
//                                    principal = 0;
//                                }

                            lastPaymentDate.set(paymentDate.get(Calendar.YEAR), paymentDate.get(Calendar.MONTH), paymentDate.get(Calendar.DATE));
                            //paymentDate.setTime(dateTo.getTime());
                            paymentDate.set(dateTo.get(Calendar.YEAR), dateTo.get(Calendar.MONTH), dateTo.get(Calendar.DATE));
                            Calendar f = Calendar.getInstance();
                            Calendar d = Calendar.getInstance();
                            f.setTimeInMillis(lastPaymentDate.getTimeInMillis());
                            d.setTimeInMillis(paymentDate.getTimeInMillis());

                            // interest = interest + principal * interestRate * ((paymentDate.get(Calendar.YEAR) - lastPaymentDate.get(Calendar.YEAR)) * 12 - (lastPaymentDate.get(Calendar.MONTH) - paymentDate.get(Calendar.MONTH))) / 1200;
                            if (credit <= 0 && paymentDate.getTimeInMillis() <= dueDate.getTimeInMillis()) {
                                interest = interest + principal * interestRate * billUtility.yearDiff(f, d) / 1200;

                            }
                            arrear = principal + interest;
                            preArear = arrear;

                            lastPaymentDate.setTime(dateTo.getTime());

                        } //                        else if (!rs6.next() && billRate == 0) {
                        //                            paymentDate.setTime(dateTo.getTime());
                        //
                        //                            billAmount = billRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1);
                        //                            //  preArear = preArear + localInterest;
                        //                            //  BigDecimal bigPreArear = new BigDecimal(preArear);
                        //                            //  preArear = bigPreArear.setScale(2, RoundingMode.CEILING).doubleValue();
                        //                            if (paymentDate.after(lastPaymentDate)) {
                        //
                        //                                interest = interest + preArear * interestRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1) / 1200;
                        //                                BigDecimal bigInterest = new BigDecimal(interest);
                        //
                        //                            }
                        //
                        //                            principal = principal + billAmount - credit;
                        //                            BigDecimal bigPrincipal = new BigDecimal(principal);
                        //                            //principal = bigPrincipal.setScale(2, RoundingMode.CEILING).doubleValue();
                        //                            if (principal < 0) {
                        //                                credit = -principal;
                        //                                arrear = 0;
                        //                                principal = 0;
                        //                                interest = 0;
                        //                            } else {
                        //                                credit = 0;
                        //                            }
                        //                            arrear = principal + interest;
                        //                            BigDecimal bigArrear = new BigDecimal(arrear);
                        //                            //arrear = bigArrear.setScale(2, RoundingMode.CEILING).doubleValue();
                        //                            preArear = preArear + billAmount;
                        //                            lastPaymentDate.setTime(dateTo.getTime());
                        //
                        //                        }
                        else {
                            paymentDate.setTime(dateTo.getTime());

                            billAmount = billRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1);
                            preArear = preArear + localInterest;
                            BigDecimal bigPreArear = new BigDecimal(preArear);
                            // preArear = bigPreArear.setScale(2, RoundingMode.CEILING).doubleValue();
                            int dy = dateTo.get(Calendar.YEAR);
                            int dy1 = billTo.get(Calendar.YEAR);
                            int mo = dateTo.get(Calendar.MONTH);
                            int mo1 = billTo.get(Calendar.MONTH);
                            System.out.println("dy=" + dy + "dy1=" + dy1 + "mo=" + mo + "mo1=" + mo1);
                            if ((dy == dy1 && mo == mo1)) {
                                rebate = billUtility.getRebate(dateFrom, billTo.getTime(), billRate1 * 12, billRate1 * ((dateTo.get(Calendar.YEAR) - dateFrom.get(Calendar.YEAR)) * 12 - (dateFrom.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1), billCycle);
                            }
                            if (paymentDate.after(lastPaymentDate) && paymentDate.getTimeInMillis() <= dueDate.getTimeInMillis()) {
                                System.out.println("Prearrer=" + preArear);
                                interest = interest + preArear * interestRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1) / 1200;
                                BigDecimal bigInterest = new BigDecimal(interest);
                                //interest = bigInterest.setScale(2, RoundingMode.CEILING).doubleValue();
                                localInterest = (localArrear) * interestRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1) / 1200;
                            }
                            localArrear = localArrear + billAmount;
//                             
                            principal = principal + billAmount - credit;
                            preArear = preArear + billAmount - credit;
                            BigDecimal bigPrincipal = new BigDecimal(principal);
                            //principal = bigPrincipal.setScale(2, RoundingMode.CEILING).doubleValue();
                            if (principal < 0) {
                                credit = -principal;
                                arrear = 0;
                                principal = 0;
                                interest = 0;
                                preArear = 0;
                            } else {
                                credit = 0;
                            }
                            arrear = principal + interest;
                            BigDecimal bigArrear = new BigDecimal(arrear);
                            //arrear = bigArrear.setScale(2, RoundingMode.CEILING).doubleValue();
                            // preArear = preArear + billAmount;
                            lastPaymentDate.setTime(dateTo.getTime());
                        }

                        System.out.println("paid amount=" + paidAmount);
                        System.out.println("date form=" + dateFromForCycle2.getTime());
                        System.out.println("date to=" + dateTo.getTime());
                        System.out.println("interest rate=" + interestRate);
                        System.out.println("bill Rate=" + billRate);
                        System.out.println("cess Rate=" + cessRate);
                        System.out.println("rebate=" + rebate);
                        System.out.println("bill amount=" + billAmount);
                        System.out.println("credit=" + credit);
                        System.out.println("principal=" + principal);
                        System.out.println("interest=" + interest);
                        System.out.println("arrear=" + arrear);
                        System.out.println("cess amount=" + cessAmount);
                        dateFromForCycle2.set(dateTo.get(Calendar.YEAR), dateTo.get(Calendar.MONTH) + 1, 1);
                        System.out.println("dateform=" + dateFromForCycle2.getTime());
                        System.out.println("cycleperiod=" + cyclePeriod);
                        dateTo = billUtility.getDateTo(billCycle, dateFromForCycle2);
                        if (cyclePeriod == billCycle) {
                            break;
                        }
                        cyclePeriod = billUtility.getBillPeriod(billCycle, dateFromForCycle2);
                    }
                    System.out.println("bill cycle=" + billCycle);


                    dateFrom.setTime(dateFromForCycle2.getTime());
                }
                if (billRate1 != 0) {
                    Calendar from = Calendar.getInstance();
                    Calendar to = Calendar.getInstance();
                    if (from.get(Calendar.MONTH) < 3) {
                        from.set(from.get(Calendar.YEAR) - 1, 3, 1);
                        to.set(billTo.get(Calendar.YEAR), billTo.get(Calendar.MONTH), billTo.get(Calendar.DATE));
                    } else {
                        from.set(from.get(Calendar.YEAR), 3, 1);
                        to.set(billTo.get(Calendar.YEAR), billTo.get(Calendar.MONTH), billTo.get(Calendar.DATE));
                    }
                    //rebate = billUtility.getRebate(from, dueDate.getTime(), billRate1 * 12, billRate1 * ((to.get(Calendar.YEAR) - from.get(Calendar.YEAR)) * 12 - (from.get(Calendar.MONTH) - to.get(Calendar.MONTH)) + 1), billCycle);
                    double discount = getDiscount(dueDate.getTime());
                    billDescription.setBillFrom(from.getTime());
                    billDescription.setBillTo(to.getTime());
                    billDescription.setCessAmount(cessAmount);
                    billDescription.setConsNO(consumerNo);
                    billDescription.setCreatedBy("online");
                    billDescription.setDiscount(discount);
                    billDescription.setDueDate(dueDate.getTime());
                    billDescription.setInterest(interest);
                    billDescription.setPrincipal(principal);
                    billDescription.setRate(billRate1);
                    billDescription.setRebate(rebate);
                } else {
                    billDescription = null;
                }

//                billDescription.add(0, Round((interest + principal + cessAmount), 2));
//                billDescription.add(1, dateFormat.format(dueDate.getTime()));
//                billDescription.add(2, from.getTime());
//                billDescription.add(3, to.getTime());
//                billDescription.add(4, cessAmount);
//                billDescription.add(5, consumerNo);
//                billDescription.add(6, interest);
//                billDescription.add(7, principal);
//                billDescription.add(8, billRate1);
//                billDescription.add(9, rebate);
//                // return billDescription;
            }


            con.close();
        } catch (Exception ex) {
            System.out.println("Exception in calculateBill " + ex);
        }
        this.status++;
        return billDescription;
    }

    public static double Round(double Rval, int Rpl) {
        double p = (double) Math.pow(10, Rpl);
        Rval = Rval * p;
        double tmp = Math.round(Rval);
        return (double) tmp / p;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public boolean isCancel() {
        return cancel;
    }

    public void setCancel(boolean cancel) {
        this.cancel = cancel;
    }

    public BillDescription getBillDescription() {
        return billDescription;
    }

    public void setBillDescription(BillDescription billDescription) {
        this.billDescription = billDescription;
    }
}
