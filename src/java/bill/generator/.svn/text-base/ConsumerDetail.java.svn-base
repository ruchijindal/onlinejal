package bill.generator;

import com.smp.jal.SelectSec_Div;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.NodeList;

public class ConsumerDetail {

    public ResultSet getConsumerDetails(String cons_no, String sec, String xmlpath) {
        System.out.println("inside consumerDetail.........."+cons_no);
         System.out.println("sec.........."+sec);
          System.out.println("xmlpath+++ "+xmlpath);

        ResultSet rs = null;
        int x;
        cons_no = cons_no.trim();

        String sector;
        String division = null;

        NodeList nl1 = null, nl2 = null;
        DocumentBuilderFactory dbf = null;
        DocumentBuilder db = null;
        org.w3c.dom.Document doc = null;
        org.w3c.dom.Document docxml = null;
        String div = null;

        try {

            if (cons_no != null && !cons_no.equals("")) {
                int l = (int) cons_no.charAt(7);
                if (l >= 65 && l <= 90) {
                    x = Integer.parseInt(cons_no.substring(0, 2));
                } else {
                    x = Integer.parseInt(cons_no.substring(0, 3));
                }
                sec = Integer.toString(x);
                if (x < 10) {
                    sec = Integer.toString(x);
                    sec = "0" + sec;
                }
            }

//           if(sec.equals("01")||sec.equals("02")||sec.equals("03")||sec.equals("04")||sec.equals("05")||sec.equals("06")||sec.equals("07")||sec.equals("08")||sec.equals("09")||sec.equals("10")||sec.equals("11")||sec.equals("11IND")||sec.equals("12")||
//                sec.equals("14")||sec.equals("14A")||sec.equals("15A")||sec.equals("15")||sec.equals("16")||sec.equals("16A")||sec.equals("17")||sec.equals("18")||sec.equals("19")||sec.equals("22")||sec.equals("23")|| sec.equals("24")||sec.equals("27")||sec.equals("55")||sec.equals("56")||sec.equals("57")||
//                sec.equals("58")||sec.equals("59")|| sec.equals("60")||sec.equals("62")||sec.equals("63")||sec.equals("64")||sec.equals("65")||sec.equals("105"))
//               {
//                   division="JAL1";
//                }
//              else if(sec.equals("20")||sec.equals("21")||sec.equals("21A")||sec.equals("25")||sec.equals("26")||sec.equals("28")||sec.equals("29")||sec.equals("30")||sec.equals("31")||sec.equals("33")||sec.equals("33A")||sec.equals("34")||sec.equals("35")||
//                sec.equals("36")||sec.equals("37")||sec.equals("37ADD")||sec.equals("52")||sec.equals("53")||sec.equals("61")||sec.equals("71")||sec.equals("72"))
//              {
//                division="JAL2";
//               }
//             else if(sec.equals("39")||sec.equals("40")||sec.equals("41")||sec.equals("43")||sec.equals("44")||sec.equals("46")||sec.equals("47") ||sec.equals("48")||sec.equals("49")||sec.equals("50")||sec.equals("51")||sec.equals("52")||sec.equals("73")||sec.equals("80")||sec.equals("81")||sec.equals("82")||sec.equals("83")||sec.equals("84")||sec.equals("92")||sec.equals("93")||sec.equals("94")||sec.equals("95"))
//               {
//                division="JAL3";
//               }
            dbf = DocumentBuilderFactory.newInstance();
            db = dbf.newDocumentBuilder();
            docxml = db.parse(xmlpath);
            SelectSec_Div sec_Div = new SelectSec_Div();
            division = sec_Div.getDevision(sec, docxml);
            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
            Connection con = dataSource.getConnection();
            //OracleConnection con=DBConnection1.dbConnection(xmlpath);

            char number = division.charAt((division.length() - 1));
            sector = "MASTER" + number;
            System.out.println("table==> "+sector);

            String sql = "select CONS_NM1,CON_TP,CONS_CTG,FLAT_TYPE,PIPE_SIZE,PLOT_SIZE,CONN_DT,NODUE_DT,TRF,TRANS_NM,SECTOR,BLK_NO,FLAT_NO,CAL_DATE from " + sector + " where trim(cons_no)=?";
            //System.out.println(sql);
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, cons_no.trim());
            rs = ps.executeQuery();
            
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception in consumerdetail :" + ex);
        }
        return rs;
    }
}
