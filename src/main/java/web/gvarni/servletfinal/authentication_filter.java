package web.gvarni.servletfinal;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebFilter(filterName = "authentication_filter")
public class authentication_filter implements Filter {

    public void init(FilterConfig fconfig) throws ServletException {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException e) {
            throw new UnavailableException(
                    "authentication_filter..doFilter(  ) ClassNotFoundException: " +
                            e.getMessage());
        }
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {

        Connection conn = null;
        String URL = "jdbc:derby://localhost:1527/ProgWebDB";
        String DBuser = "App";
        String DBpwd = "pw";
        PreparedStatement ps = null;
        ResultSet results = null;
        String user = null;
        String pwd = null;

        HttpServletRequest hreq = (HttpServletRequest) request;

        String username = hreq.getParameter("username");
        String password = hreq.getParameter("password");

        HttpSession session = hreq.getSession(false);

        if (session != null && session.getAttribute("name") != null) {
            chain.doFilter(request, response);

        } else if (session == null) {
            try {
                conn = DriverManager.getConnection(URL, DBuser, DBpwd);
            } catch (SQLException e) {
                throw new UnavailableException("authentication_filter.doFilter(  ) SQLException: " + e.getMessage());
            }

            try {
                String sql = "SELECT PASSWORD FROM UTENTI WHERE USERNAME = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                results = ps.executeQuery();

                if (results.next()) {
                    String dbPassword = results.getString(1);
                    if (password.equals(dbPassword)) {

                        session = hreq.getSession();
                        session.setAttribute("name", username);
                        SessionConnection sessionConnection = new SessionConnection();
                        sessionConnection.setConnection(conn);
                        session.setAttribute("sessionconnection", sessionConnection);
                        chain.doFilter(request, response);

                    } else {
                        // Invalid password
                        try {
                            conn.close();
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
                        request.getRequestDispatcher("./failure.html").forward(request, response);
                    }
                } else {
                    // Username not found
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    request.getRequestDispatcher("./failure.html").forward(request, response);
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            } finally {
                if (results != null) {
                    try {
                        results.close();
                    } catch (SQLException e) {
                        // Handle exception
                    }
                }
                if (ps != null) {
                    try {
                        ps.close();
                    } catch (SQLException e) {
                        // Handle exception
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        // Handle exception
                    }
                }
            }
        } else {
            // No session, redirect to login page
            request.getRequestDispatcher("./login.html").forward(request, response);
        }
    }
}
