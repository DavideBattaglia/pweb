package web.gvarni.servletfinal;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import com.google.gson.Gson;

@WebServlet(name = "GetEventData", value = "/GetEventData")
public class GetEventData extends HttpServlet {
    String dbURL = "jdbc:derby://localhost:1527/ProgWebDB";
    String user = "App";
    String password = "pw";
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve all event data
        List<Event> events = getAllEvents();

        // Convert event list to JSON
        Gson gson = new Gson();
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < events.size(); i++) {
            Event event = events.get(i);
            json.append(gson.toJson(event));
            if (i < events.size() - 1) {
                json.append(",");  // Add comma for each object except the last
            }
        }
        json.append("]");

        // Prepare JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        try (PrintWriter out = response.getWriter()) {
            out.println(json);
        }
    }

    private List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();

        try (Statement stmt = connection.createStatement();
             ResultSet results = stmt.executeQuery("SELECT * FROM EVENT")) {
            while (results.next()) {
                Event event = new Event();
                event.setEventId(results.getInt("EVENT_ID"));
                event.setEventCategory(results.getString("EVENT_CATEGORY"));
                event.setEventName(results.getString("EVENT_NAME"));
                event.setEventDate(results.getDate("EVENT_DATE"));
                event.setEventTime(results.getTime("EVENT_TIME"));
                event.setEventLocation(results.getString("EVENT_LOCATION"));
                event.setImgUrl(results.getString("IMG_URL"));
                event.setSeatTicketPrice(results.getBigDecimal("SEAT_TICKET_PRICE"));
                event.setStandingTicketPrice(results.getBigDecimal("STANDING_TICKET_PRICE"));
                System.out.println(event);
                events.add(event);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }

        return events;
    }

    @Override
    public void destroy() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }
}
