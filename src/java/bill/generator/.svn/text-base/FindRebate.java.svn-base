/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bill.generator;

import java.util.Calendar;

/**
 *
 * @author smp
 */
public class FindRebate {

    double rebate = 0.0;
    Calendar dt = Calendar.getInstance();
    Calendar dt1 = Calendar.getInstance();
    Calendar dt2 = Calendar.getInstance();
    Calendar dt3 = Calendar.getInstance();
    Calendar dt4 = Calendar.getInstance();

    public double getRebate(Calendar bl_per_fr, Calendar pay_date, double bill_amt1, double paid_amt, int bilcycle) {
        dt.set(bl_per_fr.get(Calendar.YEAR), 5, 1);
        dt1.set(bl_per_fr.get(Calendar.YEAR), 4, 31);
        dt2.set(bl_per_fr.get(Calendar.YEAR), 9, 1);
        dt3.set(bl_per_fr.get(Calendar.YEAR), 5, 1);
        dt4.set(bl_per_fr.get(Calendar.YEAR), 4, 1);
        if (bilcycle == 1 || bilcycle == 2) {

            if (pay_date.before(dt)) {
                rebate = bill_amt1 * 10 / 100;
                if (paid_amt >= bill_amt1 - rebate) {
                    return rebate;
                } else {
                    rebate = 0;
                }

            } else if ((pay_date.after(dt1) && pay_date.before(dt2))) {
                rebate = bill_amt1 * 5 / 100;
                if (paid_amt >= bill_amt1 - rebate) {
                    return rebate;
                } else {
                    rebate = 0;
                }
            } else {
                rebate = 0;
            }
        } else if (bilcycle == 4) {

            if ((pay_date.before(dt3))) {
                rebate = bill_amt1 * 10 / 100;


                if (paid_amt >= bill_amt1 - rebate) {
                    return rebate;
                } else {
                    rebate = 0;
                }

            }

        } else if (bilcycle == 12) {
            if (pay_date.before(dt4)) {
                rebate = bill_amt1 * 10 / 100;

                if (paid_amt >= bill_amt1 - rebate) {
                    return rebate;
                } else {
                    rebate = 0;
                }

            }
        }

        return rebate;
    }
}
