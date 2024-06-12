package com.example.progweb;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebFilter(filterName = "PrivateFilter")

public class PrivateFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String user = (String) req.getSession().getAttribute("user");

        if (user == null) {
            res.setContentType("text/html");
            PrintWriter out = res.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('È richiesto l\\'accesso');");
            ((PrintWriter) out).println("window.location.href = '" + req.getContextPath() + "/login.jsp';");
            out.println("</script>");
            out.close();
        } else {
            chain.doFilter(request, response);
        }
    }

    public void init(FilterConfig filterConfig) throws ServletException {
        // Inizializzazione del filtro, se necessario
    }

    public void destroy() {
        // Cleanup del filtro, se necessario
    }
}
