/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bill.generator;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author smp
 */
@WebServlet(name = "GenerateBill", urlPatterns = {"/GenerateBill"})
public class GenerateBill extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        try {
            // TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GenerateBill</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GenerateBill at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            // */
            int error = 0;
            String division = request.getParameter("div");
            String cons_no = request.getParameter("cons_no");
            String billcycle = request.getParameter("billcycle");
            System.out.println("bill Cycle is iiiiiiii  " + billcycle);
            Calendar calendar = Calendar.getInstance();
            Calendar dueDate = Calendar.getInstance();
            if (dueDate.get(Calendar.MONTH) == 0 || dueDate.get(Calendar.MONTH) == 2 || dueDate.get(Calendar.MONTH) == 4 || dueDate.get(Calendar.MONTH) == 6 || dueDate.get(Calendar.MONTH) == 7 || dueDate.get(Calendar.MONTH) == 9 || dueDate.get(Calendar.MONTH) == 11) {
                dueDate.set(dueDate.get(Calendar.YEAR), dueDate.get(Calendar.MONTH), 31);
            } else if (dueDate.get(Calendar.MONTH) == 3 || dueDate.get(Calendar.MONTH) == 5 || dueDate.get(Calendar.MONTH) == 8 || dueDate.get(Calendar.MONTH) == 10) {
                dueDate.set(dueDate.get(Calendar.YEAR), dueDate.get(Calendar.MONTH), 30);
            } else {
                dueDate.set(dueDate.get(Calendar.YEAR), dueDate.get(Calendar.MONTH), 28);
            }
            DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
            calendar.setTime(df.parse(billcycle));
// System.out.println(df.parse(billcycle.toString())+"calender date is "+calendar.get(calendar.YEAR)+"/"+calendar.get(calendar.MONTH)+"/ "+calendar.get(calendar.DATE));



            BillingManager billingManager = new BillingManager(division, cons_no, calendar, dueDate);

            Thread billThread = new Thread(billingManager);
            billThread.start();
            while (billThread.isAlive()) {
            }
            BillDescription billDescription = new BillDescription();
            billDescription = billingManager.getBillDescription();
            if (!(billDescription == null)) {
                session.setAttribute("billDescription", billDescription);
                session.setAttribute("div", division);
                session.setAttribute("to_date11", billcycle);
                response.sendRedirect("../../OnlineJal/jsppages/consumer/cons_bill.jsp?consno=" + cons_no);

            } else {
                error = 1;
                request.setAttribute("error", error);
                request.getServletContext().getRequestDispatcher("/jsppages/consumer/cons_details.jsp").forward(request, response);

            }
        } catch (Exception e) {
            // System.out.println("Exception in parsing string "+e);
            response.sendRedirect("../../OnlineJal/jsppages/consumer/cons_details.jsp?e=ex");
        } finally {
            out.close();
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
