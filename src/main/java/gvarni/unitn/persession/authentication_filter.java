package gvarni.unitn.persession;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebFilter(filterName = "authentication_filter")
public class authentication_filter implements Filter {

    public void init(FilterConfig fconfig) throws ServletException {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        }
        catch (ClassNotFoundException e) {
            throw new UnavailableException(
                    "authentication_filter..doFilter(  ) ClassNotFoundException: " +
                            e.getMessage(  ));
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
        Statement stmt = null;
        ResultSet results  = null;
        String user = null;
        String pwd = null;

        HttpServletRequest hreq = (HttpServletRequest) request;

        String username = hreq.getParameter("username");
        String password = hreq.getParameter("password");

        HttpSession session = hreq.getSession(false);

        if (session != null && session.getAttribute("name")!=null) {
            chain.doFilter(request, response);

        }else if (session == null) {
            try {
                conn = DriverManager.getConnection(URL,DBuser,DBpwd);
            }
            catch (SQLException e) {
                throw new UnavailableException("authentication_filter.doFilter(  ) SQLException: " + e.getMessage(  ));
            }

            try {
                stmt = conn.createStatement();
                String sql = "SELECT USERNAME, PASSWORD FROM UTENTI";
                results = stmt.executeQuery(sql);

                while (results.next()) { // per semplicità si supponga di avere un solo utente nella tbella del DB
                    user=results.getString(1);
                    pwd=results.getString(2);
                }
                results.close();
                stmt.close();
            }catch(SQLException e) {
                throw new UnavailableException("authentication_filter.doFilter(  ) SQLException: " + e.getMessage(  ));
            }

            if (username.equals(user) && password.equals(pwd)) {

                session = hreq.getSession();
                session.setAttribute("name", username);
                SessionConnection sessionConnection = new SessionConnection(  );
                sessionConnection.setConnection(conn);
                session.setAttribute("sessionconnection", sessionConnection);
                chain.doFilter(request, response);
            }
            else { //utente non autenticato
                try {
                    conn.close(); //  chiudo la connessione che avevo aperto per recuperare username e pwd
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                request.getRequestDispatcher("./failure.html").forward(request, response);}

                }
            }

        }
