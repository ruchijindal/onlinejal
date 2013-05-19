package bill.generator;

import java.sql.Date;
import java.util.Calendar;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.NodeList;

public class FindCalDate {

    Calendar cal_date = Calendar.getInstance();
    DocumentBuilderFactory dbf = null;
    DocumentBuilder db = null;
    org.w3c.dom.Document doc = null;
    NodeList nl = null;
    String div = null;
    String division;

    public Calendar getCalDate(Date conn_dt, Date nodue_dt, Date cal_dt, String xmlpath) {
        try {

            if (nodue_dt == null) {
                cal_date.setTime(cal_dt);
            } else if (cal_dt == null) {
                cal_date.setTime(nodue_dt);
            } else {
                if (cal_dt.after(nodue_dt)) {
                    cal_date.setTime(cal_dt);
                } else {
                    cal_date.setTime(nodue_dt);
                }
            }
            //}
        } catch (Exception pce) {
            System.err.println("Exception in FindCalDate:" + pce);
        }

        return cal_date;
    }
}
