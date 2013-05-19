/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package reportservlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author smp
 */
public class RedirectToCP extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Object o;
        HttpSession session = request.getSession();
        String page;
        page = request.getParameter("page");
        //System.out.println(page);
        try {
            if (page.equals("ArrearReport")) {
                ArrearReport.MyPdf pdf;
                o = session.getAttribute("myPdf");
                if (o != null) {
                    pdf = (ArrearReport.MyPdf) o;
                    pdf.done(true);
                    session.removeAttribute("myPdf");
                    System.out.println("Stoped");
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                } else {
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                }
            } else if (page.equals("BillReport")) {
                BillReport.MyPdf pdf;
                o = session.getAttribute("myPdf");
                if (o != null) {
                    pdf = (BillReport.MyPdf) o;
                    pdf.done(true);
                    session.removeAttribute("myPdf");
                    System.out.println("Stoped");
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                } else {
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                }
            } else if (page.equals("ConsumerDet")) {
                ConsumerDet.MyPdf pdf;
                o = session.getAttribute("myPdf");
                if (o != null) {
                    pdf = (ConsumerDet.MyPdf) o;
                    pdf.done(true);
                    session.removeAttribute("myPdf");
                    System.out.println("Stoped");
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                } else {
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                }
            } else if (page.equals("RevenueReport")) {
                RevenueReport.MyPdf pdf;
                o = session.getAttribute("myPdf");
                if (o != null) {
                    pdf = (RevenueReport.MyPdf) o;
                    pdf.done(true);
                    session.removeAttribute("myPdf");
                    System.out.println("Stoped");
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                } else {
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                }
            } else if (page.equals("CreditorGen")) {
                billservlet.CreditorGen.MyPdf pdf;
                o = session.getAttribute("myPdf");
                if (o != null) {
                    pdf = (billservlet.CreditorGen.MyPdf) o;
                    pdf.done(true);
                    session.removeAttribute("myPdf");
                    System.out.println("Stoped");
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                } else {
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                }
            } else if (page.equals("DefaulterGen")) {
                billservlet.DefaulterGen.MyPdf pdf;
                o = session.getAttribute("myPdf");
                if (o != null) {
                    pdf = (billservlet.DefaulterGen.MyPdf) o;
                    pdf.done(true);
                    session.removeAttribute("myPdf");
                    System.out.println("Stoped");
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                } else {
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                }
            } else if (page.equals("Err")) {
                billservlet.Err.MyPdf pdf;
                o = session.getAttribute("myPdf");
                if (o != null) {
                    pdf = (billservlet.Err.MyPdf) o;
                    pdf.t.stop();
                    session.removeAttribute("myPdf");
                    System.out.println("Stoped");
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                } else {
                    response.sendRedirect("jsppages/common/ch_pass.jsp");
                    return;
                }
            }

        } catch (Exception ex) {
            System.out.println("error in dopost" + ex);
            response.sendRedirect("jsppages/common/ch_pass.jsp");
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
