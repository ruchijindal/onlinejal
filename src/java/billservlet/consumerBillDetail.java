/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package billservlet;

import bill.generator.BillDescription;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 *
 * @author smp
 */
@WebServlet(name="consumerBillDetail", urlPatterns={"/consumerBillDetail"})
public class consumerBillDetail extends HttpServlet {
   
     
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
             /*TODO output your page here*/
            
            
            HttpSession session=request.getSession();
            BillDescription billDescription=(BillDescription) session.getAttribute("billDescription");
       
            InitialContext context=new InitialContext();
            DataSource datasource=(DataSource) context.lookup("OnlineJal");
            Connection con=datasource.getConnection();
//            String sql="insert into getvalue(column1,column2,column3,column4) values('"+list.get(0)+"','"+list.get(1)+"','"+list.get(5)+"','"+list.get(6)+"')";
//            PreparedStatement statement=con.prepareStatement(sql);
//                int rs=statement.executeUpdate();
                out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet consumerBillDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet consumerBillDetail at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
            response.sendRedirect("../../OnlineJal/jsppages/consumer/cons_details.jsp");
            con.close();
        }catch(Exception e)
        {
            e.printStackTrace();
        }

        finally {

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
