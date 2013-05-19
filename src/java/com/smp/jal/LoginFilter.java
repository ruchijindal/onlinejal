package com.smp.jal;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginFilter implements Filter {

    private FilterConfig config = null;
    FilterChain chain;

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse res = (HttpServletResponse) response;
        HttpServletRequest req = (HttpServletRequest) request;
       // System.out.println("inside do filter method ------------");
        HttpSession session = req.getSession(false);

        if (session != null) {
            String userid = (String) session.getAttribute("userid");
            if (userid == null) {
               // System.out.println("currentUser null");
                res.sendRedirect(req.getContextPath());
            } else {
                String userrole = (String) session.getAttribute("userrole");
                String url = new String(req.getRequestURL());
                String page = url.substring(url.lastIndexOf("/") + 1);

                url = url.substring(0, url.lastIndexOf("/"));

                String searchstr = url.substring(url.lastIndexOf("/") + 1);


               // System.out.println(searchstr);
                if (userrole.equals("admin")) {
                    chain.doFilter(request, response);
                }else if(userrole.equals("crm"))
                {
                     //System.out.println("I am inCRMMMMMMMMMMMMMMMMMMMM");
                    chain.doFilter(request, response);
                }
                else if (userrole.equals("general")) {
                    if (searchstr.equals("admin") || searchstr.equals("manager") || searchstr.equals("consumer") || searchstr.equals("reports") || searchstr.equals("charts") || page.equals("rate.jsp")) {
                        res.sendRedirect(req.getContextPath() + "/404.jsp");
                    } else {
                        chain.doFilter(request, response);
                    }
                } else if (userrole.equals("consumer")) {
                    if (searchstr.equals("admin") || searchstr.equals("manager") || searchstr.equals("reports") || searchstr.equals("charts")) {
                        res.sendRedirect(req.getContextPath() + "/404.jsp");
                    } else {
                        chain.doFilter(request, response);
                    }

                } else if (userrole.equals("manager")) {

                    if (searchstr.equals("admin") ||searchstr.equals("reports")) {
                        res.sendRedirect(req.getContextPath() + "/404.jsp");
                    } else {
                        chain.doFilter(request, response);
                    }
                }
                // chain.doFilter(request, response);
            }

        } else {
            res.sendRedirect(req.getContextPath());
        }


    }

    public void destroy() {
        this.config = null;


    }

    public void init(FilterConfig config) {
        this.config = config;
    }
}
