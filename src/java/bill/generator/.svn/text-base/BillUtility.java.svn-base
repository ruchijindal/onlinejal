/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bill.generator;

import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author smp-06
 */
public class BillUtility {

    /****************************************************** for rebate calculation ***************************************************************/
    double rebate = 0.0;
    Calendar dt = Calendar.getInstance();
    Calendar dt1 = Calendar.getInstance();
    Calendar dt2 = Calendar.getInstance();
    Calendar dt3 = Calendar.getInstance();
    Calendar dt4 = Calendar.getInstance();

    public int yearDiff(Calendar dt1, Calendar dt2) {
        int month = 0;
        Calendar dt3 = Calendar.getInstance();
        Calendar dt4 = Calendar.getInstance();
        long diff = 0;
        dt3.set(dt1.get(Calendar.YEAR), dt1.get(Calendar.MONTH), dt1.get(Calendar.DATE));
        dt4.set(dt2.get(Calendar.YEAR), dt2.get(Calendar.MONTH) + 1, dt2.get(Calendar.DATE));
        diff = dt4.getTime().getTime() - dt3.getTime().getTime();
        if (diff < 0) {
            diff = 0;
        }

        if (dt3.get(Calendar.MONTH) == 1 && dt4.get(Calendar.MONTH) == 1) {
            month = (int) (diff / (1000 * 60 * 60 * 24)) / 28;
        } else {
            month = (int) (diff / (1000 * 60 * 60 * 24)) / 31;
        }
        //System.out.println("Difference between "+dt1+ "and "+dt2+"is "+ month);

        return month;
    }

    public double getRebate(Calendar billFrom, Date payDate1, double billAmount, double paidAmont, int bilcycle) {
        Calendar payDate = Calendar.getInstance();
        rebate = 0;
        if (payDate1 != null) {
            payDate.setTime(payDate1);
        } else {
            payDate.setTime(billFrom.getTime());
        }
        dt.set(billFrom.get(Calendar.YEAR), 5, 1);
        dt1.set(billFrom.get(Calendar.YEAR), 4, 31);
        dt2.set(billFrom.get(Calendar.YEAR), 9, 1);
        dt3.set(billFrom.get(Calendar.YEAR), 5, 1);
        dt4.set(billFrom.get(Calendar.YEAR), 4, 1);
        if (bilcycle == 1 || bilcycle == 2) {

            if (payDate.before(dt)) {
                rebate = billAmount * 10 / 100;
                if (paidAmont >= billAmount - rebate) {
                    return rebate;
                } else {
                    rebate = 0;
                }

            } else if ((payDate.after(dt1) && payDate.before(dt2))) {
                rebate = billAmount * 5 / 100;
                if (paidAmont >= billAmount - rebate) {
                    return rebate;
                } else {
                    rebate = 0;
                }
            } else {
                rebate = 0;
            }
        } else if (bilcycle == 4) {

            if ((payDate.before(dt3))) {
                rebate = billAmount * 10 / 100;


                if (paidAmont >= billAmount - rebate) {
                    return rebate;
                } else {
                    rebate = 0;
                }

            }

        } else if (bilcycle == 12) {
            if (payDate.before(dt4)) {
                rebate = billAmount * 10 / 100;

                if (paidAmont >= billAmount - rebate) {
                    return rebate;
                } else {
                    rebate = 0;
                }

            }
        }

        return rebate;
    }

    /***************************************** for cessrate calculation *********************************************/
    public double getCess(Calendar bl_per_fr, String connType, double pipeSize) {
        double csrate = 0.0;
        Calendar cessdt = Calendar.getInstance();
        cessdt.set(2006, 2, 31);
        if (bl_per_fr.after(cessdt) && connType != null) {
            if (connType.equals("R") && pipeSize == 15) {
                csrate = 1;
            } else if (connType.equals("R") && pipeSize == 20) {
                csrate = 1.5;
            } else if ((connType.equals("I") || connType.equals("T") || connType.equals("C")) && pipeSize == 15) {
                csrate = 6;
            } else if ((connType.equals("I") || connType.equals("T") || connType.equals("C")) && pipeSize == 20) {
                csrate = 11;
            } else if ((connType.equals("I") || connType.equals("T") || connType.equals("C")) && pipeSize == 25) {
                csrate = 16;
            } else if ((connType.equals("I") || connType.equals("T") || connType.equals("C")) && pipeSize == 40) {
                csrate = 41;
            } else if ((connType.equals("I") || connType.equals("T") || connType.equals("C")) && pipeSize == 50) {
                csrate = 63;
            } else if ((connType.equals("I") || connType.equals("T") || connType.equals("C")) && pipeSize == 65) {
                csrate = 107;
            } else if ((connType.equals("I") || connType.equals("T") || connType.equals("C")) && pipeSize == 80) {
                csrate = 161;
            } else if ((connType.equals("I") || connType.equals("T") || connType.equals("C")) && pipeSize == 100) {
                csrate = 252;
            } else if ((connType.equals("I") || connType.equals("T") || connType.equals("C")) && pipeSize == 125) {
                csrate = 392;
            } else {
                csrate = 0;
            }
        }
        return csrate;
    }

    /******************************************* for caldate calculation ***************************************************/
    public Calendar getCalDate(Date noDueDate, Date calDate) {
        Calendar nDate = Calendar.getInstance();
        Calendar cDate = Calendar.getInstance();

        if (noDueDate != null) {
            nDate.setTime(noDueDate);
            if (nDate.get(Calendar.DATE) >= 1) {
                nDate.set(nDate.get(Calendar.YEAR), nDate.get(Calendar.MONTH) + 1, 1);
                noDueDate = nDate.getTime();
            }
        }
        if (calDate != null) {
            cDate.setTime(calDate);
            if (cDate.get(Calendar.DATE) >= 1) {
                cDate.set(cDate.get(Calendar.YEAR), cDate.get(Calendar.MONTH) + 1, 1);
                calDate = cDate.getTime();
            }
        }
        Calendar cal_date = Calendar.getInstance();
        if (noDueDate == null && calDate != null) {
            cal_date.setTime(calDate);
        } else if (calDate == null && noDueDate != null) {
            cal_date.setTime(noDueDate);
        } else {
            if ((calDate != null && noDueDate != null) && calDate.after(noDueDate)) {
                cal_date.setTime(calDate);
            } else if ((calDate != null && noDueDate != null)) {
                cal_date.setTime(noDueDate);
            }
        }

        return cal_date;
    }
    /******************************************** for bill cycle *****************************************************************/
    int billCycle = 1;

    public int getBillCycle(double rate, Calendar dateFrom) {
        Calendar cycleDate = Calendar.getInstance();
        cycleDate.set(2002, 2, 31);
        double billAmount = rate * 12;
        if ((billAmount >= 0 && billAmount <= 1500) || dateFrom.before(cycleDate)) {
            billCycle = 1;
        } else if (billAmount >= 1501 && billAmount <= 4000) {
            billCycle = 2;
        } else if (billAmount >= 4001 && billAmount <= 12000) {
            billCycle = 4;
        } else if (billAmount >= 12001) {
            billCycle = 12;
        }
        return billCycle;

    }

    /********************************* For Bill Period ***************************************/
    public int getBillPeriod(int billCycle, Calendar date) {
        int billPeriod = 0;
        if (billCycle == 1) {
            billPeriod = 1;
        } else if (billCycle == 2) {
            if (date.get(Calendar.MONTH) >= 3 && date.get(Calendar.MONTH) < 9) {
                billPeriod = 1;
            } else {
                billPeriod = 2;
            }
        } else if (billCycle == 4) {

            if (date.get(Calendar.MONTH) >= 3 && date.get(Calendar.MONTH) < 6) {
                billPeriod = 1;
            } else if (date.get(Calendar.MONTH) >= 6 && date.get(Calendar.MONTH) < 9) {
                billPeriod = 2;
            } else if (date.get(Calendar.MONTH) >= 9 && date.get(Calendar.MONTH) < 12) {
                billPeriod = 3;
            } else {
                billPeriod = 4;
            }
        } else if (billCycle == 12) {
            if (date.get(Calendar.MONTH) >= 3 && date.get(Calendar.MONTH) < 4) {
                billPeriod = 1;
            } else if (date.get(Calendar.MONTH) >= 4 && date.get(Calendar.MONTH) < 5) {
                billPeriod = 2;
            } else if (date.get(Calendar.MONTH) >= 5 && date.get(Calendar.MONTH) < 6) {
                billPeriod = 3;
            } else if (date.get(Calendar.MONTH) >= 6 && date.get(Calendar.MONTH) < 7) {
                billPeriod = 4;
            } else if (date.get(Calendar.MONTH) >= 7 && date.get(Calendar.MONTH) < 8) {
                billPeriod = 5;
            } else if (date.get(Calendar.MONTH) >= 8 && date.get(Calendar.MONTH) < 9) {
                billPeriod = 6;
            } else if (date.get(Calendar.MONTH) >= 9 && date.get(Calendar.MONTH) < 10) {
                billPeriod = 7;
            } else if (date.get(Calendar.MONTH) >= 10 && date.get(Calendar.MONTH) < 11) {
                billPeriod = 8;
            } else if (date.get(Calendar.MONTH) >= 11 && date.get(Calendar.MONTH) < 12) {
                billPeriod = 9;
            } else if (date.get(Calendar.MONTH) >= 0 && date.get(Calendar.MONTH) < 1) {
                billPeriod = 10;
            } else if (date.get(Calendar.MONTH) >= 1 && date.get(Calendar.MONTH) < 2) {
                billPeriod = 11;
            } else {
                billPeriod = 12;
            }
        }
        return billPeriod;
    }

    /********************************** For Bill per To ***********************************************/
    public Calendar getDateTo(int billCycle, Calendar date) {
        Calendar dateTo = Calendar.getInstance();
        if (billCycle == 1) {
            if (date.get(Calendar.MONTH) < 3) {
                dateTo.set(date.get(Calendar.YEAR), 2, 31);
            } else {
                dateTo.set(date.get(Calendar.YEAR) + 1, 2, 31);
            }
        } else if (billCycle == 2) {
            if (date.get(Calendar.MONTH) >= 3 && date.get(Calendar.MONTH) < 9) {
                dateTo.set(date.get(Calendar.YEAR), 8, 30);
            } else {
                if (date.get(Calendar.MONTH) < 3) {
                    dateTo.set(date.get(Calendar.YEAR), 2, 31);
                } else {
                    dateTo.set(date.get(Calendar.YEAR) + 1, 2, 31);
                }
            }
        } else if (billCycle == 4) {

            if (date.get(Calendar.MONTH) >= 3 && date.get(Calendar.MONTH) < 6) {
                dateTo.set(date.get(Calendar.YEAR), 5, 30);
            } else if (date.get(Calendar.MONTH) >= 6 && date.get(Calendar.MONTH) < 9) {
                dateTo.set(date.get(Calendar.YEAR), 8, 30);
            } else if (date.get(Calendar.MONTH) >= 9 && date.get(Calendar.MONTH) < 12) {
                dateTo.set(date.get(Calendar.YEAR), 11, 31);
            } else {
                if (date.get(Calendar.MONTH) < 3) {
                    dateTo.set(date.get(Calendar.YEAR), 2, 31);
                } else {
                    dateTo.set(date.get(Calendar.YEAR) + 1, 2, 31);
                }
            }
        } else if (billCycle == 12) {
            if (date.get(Calendar.MONTH) >= 3 && date.get(Calendar.MONTH) < 4) {
                dateTo.set(date.get(Calendar.YEAR), 3, 30);
            } else if (date.get(Calendar.MONTH) >= 4 && date.get(Calendar.MONTH) < 5) {
                dateTo.set(date.get(Calendar.YEAR), 4, 31);
            } else if (date.get(Calendar.MONTH) >= 5 && date.get(Calendar.MONTH) < 6) {
                dateTo.set(date.get(Calendar.YEAR), 5, 30);
            } else if (date.get(Calendar.MONTH) >= 6 && date.get(Calendar.MONTH) < 7) {
                dateTo.set(date.get(Calendar.YEAR), 6, 31);
            } else if (date.get(Calendar.MONTH) >= 7 && date.get(Calendar.MONTH) < 8) {
                dateTo.set(date.get(Calendar.YEAR), 7, 31);
            } else if (date.get(Calendar.MONTH) >= 8 && date.get(Calendar.MONTH) < 9) {
                dateTo.set(date.get(Calendar.YEAR), 8, 30);
            } else if (date.get(Calendar.MONTH) >= 9 && date.get(Calendar.MONTH) < 10) {
                dateTo.set(date.get(Calendar.YEAR), 9, 31);
            } else if (date.get(Calendar.MONTH) >= 10 && date.get(Calendar.MONTH) < 11) {
                dateTo.set(date.get(Calendar.YEAR), 10, 30);
            } else if (date.get(Calendar.MONTH) >= 11 && date.get(Calendar.MONTH) < 12) {
                dateTo.set(date.get(Calendar.YEAR), 11, 31);
            } else if (date.get(Calendar.MONTH) >= 0 && date.get(Calendar.MONTH) < 1) {
                dateTo.set(date.get(Calendar.YEAR), 0, 31);
            } else if (date.get(Calendar.MONTH) >= 1 && date.get(Calendar.MONTH) < 2) {
                dateTo.set(date.get(Calendar.YEAR), 1, 28);
            } else {
                dateTo.set(date.get(Calendar.YEAR), 2, 31);
            }
        }
        return dateTo;
    }
}
