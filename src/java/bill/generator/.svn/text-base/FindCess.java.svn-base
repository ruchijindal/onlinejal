package bill.generator;

import java.sql.ResultSet;
import java.util.Calendar;

public class FindCess {

    double csrate;
    String con_tp;
    float pipe_size;
    ResultSet rs;
    Calendar cessdt = Calendar.getInstance();

    public double getCess(Calendar bl_per_fr, String cons_no, String sec, String xmlpath) {
        ConsumerDetail cd = new ConsumerDetail();

        try {
            rs = cd.getConsumerDetails(cons_no, sec, xmlpath);
            while (rs.next()) {
                con_tp = rs.getString("con_tp");
                pipe_size = (float) rs.getFloat("pipe_size");

            }

            cessdt.set(106, 2, 31);
            if (bl_per_fr.after(cessdt)) {
                if (con_tp.equals("R") && pipe_size == 15) {
                    csrate = 1;
                } else if (con_tp.equals("R") && pipe_size == 20) {
                    csrate = 1.5;
                } else if ((con_tp.equals("I") || con_tp.equals("T") || con_tp.equals("C")) && pipe_size == 15) {
                    csrate = 6;
                } else if ((con_tp.equals("I") || con_tp.equals("T") || con_tp.equals("C")) && pipe_size == 20) {
                    csrate = 11;
                } else if ((con_tp.equals("I") || con_tp.equals("T") || con_tp.equals("C")) && pipe_size == 25) {
                    csrate = 16;
                } else if ((con_tp.equals("I") || con_tp.equals("T") || con_tp.equals("C")) && pipe_size == 40) {
                    csrate = 41;
                } else if ((con_tp.equals("I") || con_tp.equals("T") || con_tp.equals("C")) && pipe_size == 50) {
                    csrate = 63;
                } else if ((con_tp.equals("I") || con_tp.equals("T") || con_tp.equals("C")) && pipe_size == 65) {
                    csrate = 107;
                } else if ((con_tp.equals("I") || con_tp.equals("T") || con_tp.equals("C")) && pipe_size == 80) {
                    csrate = 161;
                } else if ((con_tp.equals("I") || con_tp.equals("T") || con_tp.equals("C")) && pipe_size == 100) {
                    csrate = 252;
                } else if ((con_tp.equals("I") || con_tp.equals("T") || con_tp.equals("C")) && pipe_size == 125) {
                    csrate = 392;
                } else {
                    csrate = 0;
                }

            }
        } catch (Exception ex) {
            System.out.println("Exception in Findcess" + ex);
        }
        return csrate;

    }
}
