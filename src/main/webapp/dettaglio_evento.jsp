<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Dettaglio Evento</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>

<header>
  <%@include file = "navbar.jsp" %>
</header>

<div class="container text-center">
  <h1>Dettaglio Evento</h1>

  <%
    String Id = (String) request.getAttribute("Id");
    String nomeEvento = (String) request.getAttribute("nomeEvento");
    String dataOra = (String) request.getAttribute("dataOra");
    String localita = (String) request.getAttribute("localita");
    String immagine = (String) request.getAttribute("immagine");
    String descrizione = (String) request.getAttribute("descrizione");
    double prezzoInPiedi = (Double) request.getAttribute("prezzoInPiedi");
    double prezzoASedere = (Double) request.getAttribute("prezzoASedere");

    if (nomeEvento != null) {
  %>

  <div class="row justify-content-center">
    <div class="col-md-6">
      <h5 class="card-title"><%= nomeEvento %></h5>
      <p class="card-text">
        Data e Ora: <%= dataOra %> <br>
        Luogo: <%= localita %> <br>
        Descrizione: <%= descrizione %> <br>
        Prezzo Biglietto In Piedi: €<%= prezzoInPiedi %> <br>
        Prezzo Biglietto Seduto: €<%= prezzoASedere %> <br>
      </p>

      <form action="carrello" method="post">
        <input type="hidden" name="eventId" value="<%= Id %>" id="eventId">
        <div class="form-group d-flex justify-content-end" aria-labelledby="ticketTypeLabel">
          <label id="ticketTypeLabel">Tipologia Biglietto:</label>
          <div class="d-flex">
            <button type="submit" class="btn btn-primary me-2" name="ticketType" value="STANDING">In Piedi (€<%= prezzoInPiedi %>)</button>
            <button type="submit" class="btn btn-primary" name="ticketType" value="SEATED">Seduto (€<%= prezzoASedere %>)</button>
          </div>
        </div>
      </form>








    </div>
    <div class="col-md-6">
      <img src="<%= immagine %>" alt="Immagine Evento" class="img-fluid">
    </div>
  </div>

  <% } else { %>
  <p class="alert alert-danger">Evento non trovato.</p>
  <% } %>
</div>

<%@include file = "footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
