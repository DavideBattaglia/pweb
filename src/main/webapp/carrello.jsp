<%@ page import="java.sql.*, java.sql.ResultSetMetaData" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Carrello</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>

<header>
  <%@include file = "navbar.jsp" %>
</header>

<div class="container">
  <h1>Carrello</h1>
  <p>Ogni 5 biglietti uno te lo regaliamo noi</p>

  <%
    // Retrieve events from the request attribute
    ResultSet resultSet = (ResultSet) request.getAttribute("resultSet");
    int totalPrice = 0; // Initialize total price
    int freeTicketCount = 0; // Track free tickets

    // Check if the resultSet is not null
    if (resultSet != null) {
  %>
  <table class="table table-striped">
    <thead>
    <tr>
      <th>Evento</th>
      <th>Data e Ora</th>
      <th>Luogo</th>
      <th>Tipologia Biglietto</th>
      <th>Prezzo</th>
    </tr>
    </thead>
    <tbody>
    <%
      int counter = 1; // Counter for tracking ticket position
      // Iterate through the resultSet (no need to call next() before the loop)
      int price = 0;
      while (resultSet.next()) {
        price = resultSet.getInt("Prezzo");

        // Apply discount logic (assuming promotion applies to all events)
        if (counter % 5 == 0) {
          freeTicketCount++;
          price = 0; // Set price to 0 for free ticket
        }

        totalPrice += price; // Add to total price (after discount logic)

        String priceClass = price == 0 ? "text-success bg-light" : ""; // Set class for free ticket

    %>
    <tr>
      <td><%=resultSet.getObject(1)%></td>
      <td><%=resultSet.getObject(2)%></td>
      <td><%=resultSet.getObject(3)%></td>
      <td><%=resultSet.getObject(4)%></td>
      <td class="<%=priceClass%>"><%=price%> €</td>
    </tr>
    <%
        counter++;
      }
    %>
    </tbody>
  </table>

  <%-- Display total price --%>
  <div class="row mt-3">
    <div class="col-6"></div>
    <div class="col-6 text-end">
      <p class="h5">
        Totale: <span class="fw-bold">€<%=totalPrice%></span> (scontati <span class="text-success">€
        <%=freeTicketCount * price%></span>)
      </p>
    </div>
  </div>

  <%-- Acquista button --%>
  <form action="clearCartServlet" method="post">
    <button type="submit" class="btn btn-primary mt-3">Acquista</button>
  </form>

  <%
  } else {
  %>
  <p>Il tuo carrello è vuoto.</p>
  <%
    }
  %>
</div>

<%@include file = "footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
