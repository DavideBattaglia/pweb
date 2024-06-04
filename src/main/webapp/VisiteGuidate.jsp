<%@ page import="java.sql.*, java.sql.ResultSetMetaData" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Eventi Sportivi</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>

<header>
  <%@include file = "navbar.jsp" %>
</header>

<div class="container text-center">
  <h1>Eventi Sportivi Disponibili</h1>

  <% ResultSet resultSet = (ResultSet) request.getAttribute("resultSet"); %>

  <% while (resultSet.next()) { %>
  <div class="card mb-3">
    <div class="card-img-top-container">
      <img class="card-img-top" src="<%= resultSet.getObject("Immagine") %>" alt="Immagine Evento">
    </div>
    <div class="card-body">
      <h5 class="card-title"><%= resultSet.getObject("NomeEvento") %></h5>
      <p class="card-text">
        Data e Ora: <%= resultSet.getObject("DataOra") %> <br>
      </p>

      <form action="carrello" method="post">
        <input type="hidden" name="eventId" value="<%= resultSet.getObject("Id") %>" id="eventId">  <div class="form-group d-flex justify-content-end" aria-labelledby="ticketTypeLabel">
        <label id="ticketTypeLabel">Tipologia Biglietto:</label>
        <div class="d-flex">
          <button type="submit" class="btn btn-primary me-2" name="ticketType" value="STANDING">In Piedi (€<%= resultSet.getObject("PrezzoInPiedi") %>)</button>
          <button type="submit" class="btn btn-primary" name="ticketType" value="SEATED">Seduto (€<%= resultSet.getObject("PrezzoASedere") %>)</button>
        </div>
      </div>
      </form>
    </div>
  </div>
  <% } %>
</div>

<%@include file = "footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // JavaScript to set eventId value dynamically
  function setEventId(eventId) {
    document.getElementById("eventId").value = eventId;
  }
</script>
</body>
</html>
