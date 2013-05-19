/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package reportservlet;

import reportservlet.ArrearReport.MyPdf;
import com.smp.jal.ConvertToDate;
import java.io.IOException;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author smp
 */
public class CancelArrearReport extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object o;
        HttpSession session = request.getSession();
        String sec;
        String path;
        String bdate;
        String strbill_date;


        Calendar calbilldate = Calendar.getInstance();
        java.sql.Date billdate;

        ConvertToDate ctd;



        try {
            //ArrearReport outer=new ArrearReport();

            ArrearReport.MyPdf pdf;

            o = session.getAttribute("myPdf");
            if (o != null) {
                pdf = (MyPdf) o;
                pdf.done(true);


                //t.destroy();
                session.removeAttribute("myPdf");
                ctd = new ConvertToDate();

                sec = request.getParameter("sec");
                path = request.getParameter("path");

                System.out.println("Stoped");
                response.sendRedirect("jsppages/reports/billamtreport.jsp");

            } else {
                response.sendRedirect("jsppages/reports/billamtreport.jsp");
            }

        } catch (Exception ex) {
            System.out.println("error in dopost" + ex);
        }
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
        processRequest(request, response);
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
