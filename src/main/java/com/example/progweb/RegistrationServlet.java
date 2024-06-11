package com.example.progweb;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {

    private static final String dbURL = "jdbc:derby://localhost:1527/ProgWebDB";
    private static final String DBuser = "App";
    private static final String DBpwd = "pw";

    public void init() throws ServletException {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("Failed to load JDBC driver.", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String dataNascita = request.getParameter("data_nascita");
        String email = request.getParameter("email");
        String telefonoCellulare = request.getParameter("telefono_cellulare");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check if username already exists in the database
        try (Connection conn = DriverManager.getConnection(dbURL, DBuser, DBpwd);
             PreparedStatement usernameCheckStmt = conn.prepareStatement("SELECT COUNT(*) FROM UTENTI WHERE USERNAME = ?")) {
            usernameCheckStmt.setString(1, username);
            ResultSet rs = usernameCheckStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                out.println("<p>Errore: Username già esistente. Scegli un username diverso.</p>");
                return;
            }
        } catch (SQLException e) {
            out.println("<p>Errore durante la verifica del nome utente: " + e.getMessage() + "</p>");
            return;
        }

        // Connect to Derby database
        try (Connection conn = DriverManager.getConnection(dbURL, DBuser, DBpwd)) {
            String sql = "INSERT INTO UTENTI (NOME, COGNOME, DATA_NASCITA, EMAIL, TELEFONO_CELLULARE, USERNAME, PASSWORD, ISADMIN, ACQUISTI) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, nome);
                statement.setString(2, cognome);
                statement.setString(3, dataNascita);
                statement.setString(4, email);
                statement.setString(5, telefonoCellulare);
                statement.setString(6, username);
                statement.setString(7, password);
                statement.setBoolean(8, false);
                statement.setInt(9, 0);
                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", username);

                    String s = response.encodeRedirectURL("login.jsp");
                    response.sendRedirect(s);
                    //response.sendRedirect("welcome.jsp");
                } else {
                    out.println("<p>Errore durante la registrazione. Riprovare.</p>");
                }
            }
        } catch (SQLException e) {
            out.println("<p>Errore durante la connessione al database: " + e.getMessage() + "</p>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
