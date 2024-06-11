<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Lista Eventi</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
  <script src="https://code.highcharts.com/highcharts.js"></script>
</head>
<body>
<header>
  <%@include file = "navbar.jsp" %>
</header>
<% String message = (String) request.getAttribute("message"); %>
<% if (message != null) { %>
<script type="text/javascript">
  alert("<%= message %>");
  window.location.href = "VisualizzaEventi.jsp"; // Reload the page
</script>
<% } %>

<h1>Lista Eventi</h1>
<form method="get" action="DisplayEventiServlet">
  <label>
    <input type="checkbox" id="order" name="order" value="desc"
      <%= request.getParameter("order") != null && request.getParameter("order").equals("desc") ? "checked" : "" %>>
    Ordina per numero di click (decrescente)
  </label>
  <input type="submit" value="Aggiorna">
</form>
<table border="1">
  <tr>
    <th>ID</th>
    <th>Tipo Evento</th>
    <th>Nome Evento</th>
    <th>Data/Ora</th>
    <th>Località</th>
    <th>Posti a Sedere</th>
    <th>Posti in Piedi</th>
    <th>Prezzo a Sedere</th>
    <th>Prezzo in Piedi</th>
    <th>Immagine</th>
    <th>Numero di Click</th>
    <th>Elimina</th>
  </tr>
  <%
    ResultSet rs = (ResultSet) request.getAttribute("resultSet");
    if (rs != null) {
      try {
        while (rs.next()) {
          out.println("<tr>");
          out.println("<td>" + rs.getInt("Id") + "</td>");
          out.println("<td>" + rs.getString("TipoEvento") + "</td>");
          out.println("<td>" + rs.getString("NomeEvento") + "</td>");
          out.println("<td>" + rs.getTimestamp("DataOra") + "</td>");
          out.println("<td>" + rs.getString("Localita") + "</td>");
          out.println("<td>" + rs.getInt("PostiASedere") + "</td>");
          out.println("<td>" + rs.getInt("PostiInPiedi") + "</td>");
          out.println("<td>" + rs.getFloat("PrezzoASedere") + "</td>");
          out.println("<td>" + rs.getFloat("PrezzoInPiedi") + "</td>");
          out.println("<td><img src='" + rs.getString("Immagine") + "' alt='Immagine'></td>");
          out.println("<td>"+ rs.getInt("Click") + "</td>");
          out.println("<td>");
          out.println("<form method='post' action='DisplayEventiServlet'>");
          out.println("<input type='hidden' name='Id' value='" + rs.getInt("Id") + "'>");
          out.println("<button type='submit'>Elimina</button>");
          out.println("</form>");
          out.println("</td>");
          out.println("</tr>");
        }
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
  %>
</table>
<form method="get" action="CreaEvento.jsp">
  <button type="submit">Crea nuovo evento</button>
</form>
<%
  Map<String, Integer> clickData = (Map<String, Integer>) request.getAttribute("clickData");
  if (clickData != null && !clickData.isEmpty()) {
%>
<div id="pieChart" style="width:100%; height:400px;"></div>
<script type="text/javascript">
  document.addEventListener('DOMContentLoaded', function () {
    Highcharts.chart('pieChart', {
      chart: {
        type: 'pie'
      },
      title: {
        text: 'Click per Tipo di Evento'
      },
      series: [{
        name: 'Click',
        data: [
          <%
              for (Map.Entry<String, Integer> entry : clickData.entrySet()) {
                  out.print("{ name: '" + entry.getKey() + "', y: " + entry.getValue() + " },");
              }
          %>
        ]
      }]
    });
  });
</script>
<% } %>

<%@include file = "footer.html" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
