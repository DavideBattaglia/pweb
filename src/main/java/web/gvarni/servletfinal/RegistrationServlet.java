package web.gvarni.servletfinal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {

    private static final String dbURL = "jdbc:derby://localhost:1527/ProgWebDB"; // Replace with your Derby database connection URL
    private static final String DBuser = "App"; // Replace with your Derby database username
    private static final String DBpwd = "pw"; // Replace with your Derby database password
    Connection conn = null;

 /*   // Replace with your actual connection details
    String URL = "jdbc:derby://localhost:1527/ProgWebDB";
    String DBuser = "App";
    String DBpwd = "pw";
    Connection conn = null;*/

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
        String confirmPassword = request.getParameter("conferma_password"); // Get confirm password
/*
        if (!password.equals(confirmPassword)) {
            out.println("<p>Errore: Password e conferma password non corrispondono.</p>");
            return; // Stop further processing if passwords don't match
        }
*/
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
        Connection conn = null;
        PreparedStatement statement = null;
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(dbURL, DBuser, DBpwd);

            // Prepare SQL statement to insert new user data
            String sql = "INSERT INTO UTENTI (NOME, COGNOME, DATA_NASCITA, EMAIL, TELEFONO_CELLULARE, USERNAME, PASSWORD) VALUES (?, ?, ?, ?, ?, ?, ?)";
            statement = conn.prepareStatement(sql);
            statement.setString(1, nome);
            statement.setString(2, cognome);
            statement.setString(3, dataNascita);
            statement.setString(4, email);
            statement.setString(5, telefonoCellulare);
            statement.setString(6, username);
            statement.setString(7, password);

            // Execute the insert statement
            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                out.println("<p>Registrazione effettuata con successo!</p>");
            } else {
                out.println("<p>Errore durante la registrazione. Riprovare.</p>");
            }

        } catch (SQLException e) {
            out.println("<p>Errore durante la connessione al database: " + e.getMessage() + "</p>");
        } catch (ClassNotFoundException e) {
            out.println("<p>Errore durante il caricamento del driver JDBC: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (statement != null) {
                    statement.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                out.println("<p>Errore durante la chiusura della connessione al database: " + e.getMessage() + "</p>");
            }
        }
    }
}
