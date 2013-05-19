/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bill.generator;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.smp.jal.ConvertToDate;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/*
 *
 * @author smp
 *
 *
 */
@WebServlet(name = "GeneratePdf", urlPatterns = {"/GeneratePdf"})
public class GeneratePdf extends HttpServlet {

    double rate;
    String billrepository_rate;
    int rates;
    String billrepository_rates;
    double cessamt;
    String cess_amount;
    double arrearamt;
    String arrear_amount;
    double interestamt;
    String interest_amount;
    double totalamt;
    String total_amount;
    int noOfconsumer;
    double finalAmount;
    String sector;
    Connection con;
    String sql;

    double roundTwoDecimals(double d) {
        DecimalFormat df = new DecimalFormat("#.##");
        return Double.valueOf(df.format(d));
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
       
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            HttpSession session = request.getSession();
            ConvertToDate ctd = new ConvertToDate();
            DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");
            String division = request.getParameter("div");
            System.out.println("div======>" + division);
            Rectangle pageSize = new Rectangle(648, 864);
            Document document = new Document(pageSize);
            BillDescription billDescription = new BillDescription();
            billDescription = (BillDescription) session.getAttribute("billDescription");


            baos = new ByteArrayOutputStream();
            PdfWriter docWriter = null;
            try {
                docWriter = PdfWriter.getInstance(document, baos);
            } catch (DocumentException ex) {
                Logger.getLogger(GeneratePdf.class.getName()).log(Level.SEVERE, null, ex);
            }

            document.open();
            noOfconsumer = 0;
            finalAmount = 0.0;

            char number = division.charAt((division.length() - 1));
            sector = "MASTER" + number;
            System.out.println("sector======>" + sector);
            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
            con = dataSource.getConnection();
            sql = "select * from " + sector + " where trim(cons_no)=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, request.getParameter("cons_no"));
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                 for (int i = 0; i < 3; i++) {
                System.out.println("inside if=====>");

                try {

                    float[] widths1 = {1.5f, 1.8f, 1f, 0.7f};
                    PdfPTable table = new PdfPTable(widths1);

                    table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
                    Paragraph p = new Paragraph();
                    p.add("   NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY                                                  "
                            + "                               OFFICE OF THE PROJECT ENGINEER (JAL-" + division + ") SECTOR-" + "5" + ",NOIDA                                     "
                            + "                             BILL CUM CHALLAN FOR DEPOSITING AMOUNT WATER CHARGES");
                    String str = " ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                    String[] conNO = {"1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th"};
                    String index = " ";
                    if (rs.getString("cons_no").length() == 9) {
                        index = rs.getString("cons_no").substring(8, 9);
                    }
                    //p.add("\n\n Bill Number - JAL" + division + "/" + id[i]);
//                    if(str.indexOf(index) >0)
//                        p.add("\n\n "+conNO[str.indexOf(index)]+" Connection Bill");
//                    p.add("\n\n Bill Number - JAL" + division + "/" + id[i]);
                    PdfPCell cell = new PdfPCell(p);

                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setColspan(4);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    cell.setBorder(Rectangle.BOTTOM);
                    cell.setPaddingBottom(30.0f);
                    table.addCell(cell);
                    table.addCell("Consumer Number");
                    System.out.println("conNO[str.indexOf(index)]==== " + conNO[str.indexOf(index)]);
                    if (!(conNO[str.indexOf(index)].equals("1st"))) {
                        table.addCell(rs.getString("cons_no") + "( " + conNO[str.indexOf(index)] + " Connection )");
                    } else {
                        table.addCell(rs.getString("cons_no"));
                    }
                    cell = new PdfPCell(new Paragraph("Due Date"));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    table.addCell(cell);
                    cell = new PdfPCell();
                    Phrase abc = new Phrase();
                    Chunk chunk = new Chunk(dateFormat.format(billDescription.getDueDate()));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    chunk.setUnderline(0.5f, -2f);
                    abc.add(chunk);
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setPhrase(abc);
                    table.addCell(cell);
                    if (rs.getString("trans_nm") == null) {
                        table.addCell("Consumer Name");
                        table.addCell(rs.getString("cons_nm1"));
                    } else {
                        table.addCell("Consumer Name");
                        table.addCell(rs.getString("trans_nm"));
                    }
                    cell = new PdfPCell(new Paragraph("Flat Type"));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(rs.getString("flat_type")));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    //cell.setHorizontalAligat com.smp.jal.GeneratePdf.processRequest(GeneratePdf.java:409)nment(Element.ALIGN_RIGHT);
                    table.addCell(cell);
                    table.addCell("Sector");
                    table.addCell(rs.getString("sector"));
                    cell = new PdfPCell(new Paragraph("Category"));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    table.addCell(cell);

                    if (rs.getString("cons_ctg").equals("R") || rs.getDate("comp_date") != null) {
                        cell = new PdfPCell(new Paragraph("Regular"));
                    } else {
                        cell = new PdfPCell(new Paragraph("Temporary"));
                    }
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);
                    table.addCell("Block Number");
                    table.addCell(rs.getString("blk_no"));
                    cell = new PdfPCell(new Paragraph("Bill Period From"));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(dateFormat.format(billDescription.getBillFrom())));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);
                    table.addCell("Flat Number");
                    table.addCell(rs.getString("flat_no"));
                    cell = new PdfPCell(new Paragraph("Bill Period To"));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(dateFormat.format(billDescription.getBillTo())));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Min Charge per Month (Rs.)"));
                    cell.setBorder(Rectangle.TOP);
                    cell.setPaddingTop(10.0f);
                    table.addCell(cell);
                    rate = billDescription.getRate();
                    DecimalFormat decimalFormate = new DecimalFormat("#0.00 ");
                    billrepository_rate = decimalFormate.format(rate);
                    cell = new PdfPCell(new Paragraph(billrepository_rate));
                    cell.setBorder(Rectangle.TOP);
                    cell.setPaddingTop(10.0f);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(""));
                    cell.setBorder(Rectangle.TOP);
                    cell.setPaddingTop(10.0f);
                    table.addCell(cell);
                    Calendar from = Calendar.getInstance();
                    from.setTime(billDescription.getBillFrom());
                    Calendar to = Calendar.getInstance();
                    to.setTime(billDescription.getBillTo());
                    rates = (int) (billDescription.getRate() * ((to.get(Calendar.YEAR) - from.get(Calendar.YEAR)) * 12 - (from.get(Calendar.MONTH) - to.get(Calendar.MONTH)) + 1));
                    decimalFormate = new DecimalFormat("#0.00 ");
                    billrepository_rates = decimalFormate.format(rates);
                   cell = new PdfPCell(new Paragraph(billrepository_rates));
                    // cell = new PdfPCell(new Paragraph(""));
                    cell.setBorder(Rectangle.TOP);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    cell.setPaddingTop(10.0f);
                    table.addCell(cell);
                    if (true) {
                        table.addCell("Rebate");
                        if (billDescription.getRebate() != 0) {
                            table.addCell((billDescription.getRebate() * 100) / rates + "%");
                        } else {
                            table.addCell("0%");
                        }
                        cell = new PdfPCell(new Paragraph("(-)"));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(decimalFormate.format(billDescription.getRebate())));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);
                    }
                    table.addCell("Cess Amount");
                    table.addCell("");
                    table.addCell("");
                    cessamt = billDescription.getCessAmount();
                    decimalFormate = new DecimalFormat("#0.00 ");
                    cess_amount = decimalFormate.format(cessamt);
                    cell = new PdfPCell(new Paragraph(cess_amount));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);
                    table.addCell("Arrear principal Amount Upto");
                    table.addCell(dateFormat.format(billDescription.getBillTo()));
                    table.addCell("");

                    //arrearamt = billrepository.getPrincipal().doubleValue() - billrepository.getRate().doubleValue() * 12;
                    arrearamt = billDescription.getPrincipal();
                    decimalFormate = new DecimalFormat("#0.00 ");
//                    if (arrearamt > 0) {
                    arrear_amount = decimalFormate.format(arrearamt);
//                    } else {
//                        arrear_amount = decimalFormate.format(0);
//                    }
                    cell = new PdfPCell(new Paragraph(arrear_amount));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);
                    table.addCell("Interest Amount Upto");
                    table.addCell(dateFormat.format(billDescription.getDueDate()));
                    table.addCell("");
                    interestamt = billDescription.getInterest();
                    decimalFormate = new DecimalFormat("#0.00 ");
                    interest_amount = decimalFormate.format(interestamt);
                    cell = new PdfPCell(new Paragraph(interest_amount));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);
                    if (billDescription.getDiscount() > 0) {
                        table.addCell("Discount On Interest");
                        table.addCell(billDescription.getDiscount() + "%");
                        cell = new PdfPCell(new Paragraph("(-)"));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);
                        String discount = decimalFormate.format((billDescription.getDiscount() * billDescription.getInterest()) / 100);
                        cell = new PdfPCell(new Paragraph(decimalFormate.format(discount)));
                        cell.setBorder(Rectangle.NO_BORDER);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);
                    }
                    int transferAmount = 0;
                    int nocAmount = 0;
                    int regularAmount = 0;




                    cell = new PdfPCell(new Paragraph("Total Amount to be paid"));
                    cell.setBorder(Rectangle.ALIGN_JUSTIFIED);
                    cell.setColspan(2);
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setPaddingTop(1.0f);
                    cell.setPaddingBottom(5.0f);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Rs."));
                    cell.setBorder(Rectangle.ALIGN_JUSTIFIED);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    cell.setPaddingTop(1.0f);
                    cell.setPaddingBottom(5.0f);
                    table.addCell(cell);

                    totalamt = billDescription.getInterest() + billDescription.getPrincipal() + billDescription.getCessAmount() + transferAmount + nocAmount + regularAmount + billDescription.getSecurity() - billDescription.getDiscount();
                    totalamt=Math.rint(totalamt);
                    decimalFormate = new DecimalFormat("#0.00 ");
                    total_amount = decimalFormate.format(totalamt);
                    finalAmount = finalAmount + totalamt;
                    cell = new PdfPCell(new Paragraph("" + (total_amount)));
                    cell.setBorder(Rectangle.ALIGN_JUSTIFIED);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    cell.setPaddingTop(1.0f);
                    cell.setPaddingBottom(5.0f);
                    table.addCell(cell);
                    table.addCell("\n\nCash/Draft No\n\n");
                    table.addCell("");
                    table.addCell("\n\nName & Signature of Allotee :\n\n");
                    table.addCell("");
                    table.addCell("Draft Issue date :\n\n");
                    table.addCell("");
                    table.addCell("");
                    table.addCell("");
                    table.addCell("Date of Deposit :\n\n");
                    table.addCell("");
                    table.addCell("Address :\n\n");
                    table.addCell("");
                    table.addCell("Name of Bank :\n\n");
                    table.addCell("");
                    table.addCell("Phone No :\n\n");
                    table.addCell("");

                    cell = new PdfPCell(new Paragraph("Please Read the Instructions Given Below –"));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setColspan(4);
                    cell.setPaddingTop(20.0f);
                    cell.setPaddingBottom(15.0f);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("1. Payment shall be made by Cash or Bank Draft in favour of 'NOIDA' directly to the bank."));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setColspan(4);
                    cell.setPaddingBottom(15.0f);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("2. If amount has already been deposited then this demand treated as withdrawn and submit the photocopy "
                            + "of the deposited challan to the office."));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setColspan(4);
                    cell.setPaddingBottom(15.0f);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("3. The water connection shall be disconnected if payment is not made upto due date without any further notice."));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setColspan(4);
                    cell.setPaddingBottom(15.0f);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("4. If any errors/clarification please contact to the office of the Project Engineer (JAL-1) water "
                            + "work's compound sector – Office  Noida between 10:30 a.m. to 1:00 p.m."));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setColspan(4);
                    cell.setPaddingBottom(15.0f);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("5. This is a computer generated demand which requires no signature."));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setColspan(4);
                    cell.setPaddingBottom(15.0f);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("6. E & O E."));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setColspan(4);
                    cell.setPaddingBottom(15.0f);
                    table.addCell(cell);



                    cell = new PdfPCell(new Paragraph("SAVE WATER FOR NATION"));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setColspan(2);
                    cell.setPaddingTop(30.0f);
                    cell.setPaddingBottom(10.0f);
                    cell.setPaddingLeft(20.0f);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("CLEAN NOIDA GREEN NOIDA"));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setColspan(2);
                    cell.setPaddingTop(30.0f);
                    cell.setPaddingBottom(10.0f);
                    cell.setPaddingLeft(20.0f);
                    table.addCell(cell);

                    table.setWidthPercentage(100);
                    table.setHorizontalAlignment(Element.ALIGN_CENTER);

                    document.add(table);

                    document.newPage();
                    con.close();

                } catch (Exception e) {
                    System.err.println("Exception in dopost" + e);

                }
                }
            }



            document.addAuthor("NOIDA JAL");

            document.addTitle("Bill-" + request.getParameter("cons_no"));
            response.setHeader("Content-Disposition", " filename=Bill-" + request.getParameter("cons_no"));

            document.close();
            docWriter.close();

            response.setHeader("Expires", "0");
            response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
            response.setHeader("Pragma", "public");
            response.setContentType("application/pdf");
            response.setContentLength(baos.size());
            ServletOutputStream out = response.getOutputStream();
            baos.writeTo(out);
            out.flush();
        
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
        try {
            processRequest(request, response);
        } catch (NamingException ex) {
            Logger.getLogger(GeneratePdf.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(GeneratePdf.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (NamingException ex) {
            Logger.getLogger(GeneratePdf.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(GeneratePdf.class.getName()).log(Level.SEVERE, null, ex);
        }
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
