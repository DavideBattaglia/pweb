<%@ page import="java.sql.*, java.sql.ResultSetMetaData" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    String Consent = null;
    javax.servlet.http.Cookie[] biscotti = request.getCookies();
    if (biscotti != null) {
        for (javax.servlet.http.Cookie cookie : biscotti) {
            if ("cookie_accepted".equals(cookie.getName())) {
                Consent = cookie.getValue();
                break;
            }
        }
    }


    String sid = session.getId();
    String dettaglioURL = "dettaglioEvento";

    if("false".equals(Consent)){
        dettaglioURL += ";jsessionid=" + sid;

    }

    try {
        String dettaglioencodedURL = URLEncoder.encode(dettaglioURL, "UTF-8");


    } catch (UnsupportedEncodingException e) {
        // Gestione dell'eccezione, se necessario
        e.printStackTrace();
    }
%>
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

<div class="container">
    <div class="container text-center">
        <h1>EVENTI SPORTIVI</h1>

        <% ResultSet resultSet = (ResultSet) request.getAttribute("resultSet"); %>


        <div class="row">
            <% while (resultSet.next()) { // Loop through each event result and limit to 3 %>
            <div class="col-md-4 card">
                <div class="card-img-top-container">
                    <img src="<%= (String) resultSet.getObject("Immagine") %>" width="100%" >
                </div>
                <div class="container">
                    <h4><b><%= resultSet.getObject("NomeEvento") %></b></h4>
                    <p><%= resultSet.getObject("DataOra")%></p>
                    <p><%= resultSet.getObject("Localita") %></p>
                    <form action="<%= dettaglioURL %>" method="post">
                        <input type="hidden" name="eventId" value="<%= resultSet.getObject("Id") %>" id="eventId">
                        <button type="submit" class="btn btn-secondary">Visualizza Evento</button>
                    </form>
                </div>
            </div>
            <% } %>

        </div>
    </div>
</div>

<%@include file = "footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // JavaScript to set eventId value dynamically (optional, can be removed)
    // function setEventId(eventId) {
    //     document.getElementById("eventId").value = eventId;
    // }
</script>
</body>
</html>
