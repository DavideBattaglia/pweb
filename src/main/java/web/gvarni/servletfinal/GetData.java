package web.gvarni.servletfinal;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.Locale;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import com.google.gson.Gson;
import com.google.gson.JsonArray;

@WebServlet(name = "GetData", value = "/GetData")
public class GetData extends HttpServlet {
    String dbURL = "jdbc:derby://localhost:1527/ProgWebDB";
    String user = "APP";
    String password = "admin";
    Connection connection = null;

    @Override
    public void init(ServletConfig config) throws ServletException {
        try {
            super.init(config);
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection = DriverManager.getConnection(dbURL, user, password);
        } catch (ClassNotFoundException | NullPointerException | SQLException ex) {
            System.out.println(ex);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {

        ArrayList<City> output = new ArrayList<City>(); //ArrayList is a resizable array

        try {
            // Making the query
            String city = request.getParameter("city");
            String query = "SELECT NAME_REGION, SQRM, NUM_PEOPLE FROM CITIES WHERE NAME_CITY = '" + city.toUpperCase(Locale.ROOT) + "'";
            Statement stmt = connection.createStatement();
            ResultSet results = stmt.executeQuery(query);

            // Getting results and saving it in an array of beans
            while (results.next()) {
                City retrieved_city = new City();
                retrieved_city.setName(city);
                retrieved_city.setRegion(results.getString(1));
                retrieved_city.setArea(results.getFloat(2));
                retrieved_city.setPopulation(results.getInt(3));
                output.add(retrieved_city);
            }
        } catch (SQLException | NullPointerException ex) {
            System.out.println(ex);
            response.sendRedirect("error.html");
        }

        // Preparing and sending json response
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        try (PrintWriter out = response.getWriter()) {
            JsonArray array = new JsonArray();
            for(City c : output) {  //foreach
                Gson gson = new Gson();
                array.add(gson.toJson(c));
            }
            out.println(array);
            //out.flush();
        }
        catch (IOException ex) {
            System.out.println(ex);
            response.sendRedirect("error.html");
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }

    @Override
    public void destroy() {
        try {
            connection.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }
}