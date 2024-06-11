<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.UnsupportedEncodingException" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <style>
        /* Personalizzazione dello stile del banner */
        .cookie-banner {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: cadetblue;
            padding: 10px 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }
    </style>
</head>
<body>
<header>
    <%@include file = "navbar.jsp" %>

</header>
<!--caroselllo-->
<%
    ResultSet resultSet = (ResultSet) request.getAttribute("resultSet");
    int itemCount = 0; // Counter to track carousel item index
%>
<div class="container text-center">
    <div id="carouselExample" class="carousel slide" data-bs-ride="carousel" data-bs-interval="15000">
        <div class="carousel-inner">
            <%while (resultSet.next()) { // Loop through each event result %>
            <div class="carousel-item <% if (itemCount == 0) { %>active<% } %> ">
                <%-- Set image source dynamically based on your data structure --%>
                    <div class="d-flex justify-content-center align-items-center">
                        <img src="<%= resultSet.getObject("Immagine") %>" width="120px" border-radius="5px">
                        <h2>  <%= resultSet.getObject("NomeEvento") %>  </h2>
                        <form action="dettaglioEvento" method="post">
                            <input type="hidden" name="eventId" value="<%= resultSet.getObject("Id") %>" id="eventId">
                            <button type="submit" class="btn"> <%= resultSet.getObject("Sconto") %> % </button>
                        </form>
                    </div>
            </div>
            <% itemCount++; %>
            <% } %>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>


<!--caroselllo-->


<div class="cookie-banner" id="cookie-banner">
    <div class="row">
        <div class="col-md-8">
            Questo sito utilizza i cookie per migliorare l'esperienza dell'utente.
            <!-- Puoi personalizzare questo testo a tuo piacimento -->
        </div>
        <div class="col-md-4 text-right">
            <button type="button" class="btn btn-primary btn-sm" id="accept-cookies">Accetta</button>
            <button type="button" class="btn btn-secondary btn-sm" id="reject-cookies">Rifiuta</button>
        </div>
    </div>
</div>
</div>

<!-- JavaScript per gestire l'evento dei bottoni -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Funzione per impostare un cookie
    function setCookie(name, value, days) {
        var expires = "";
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + (value || "") + expires + "; path=/";
    }

    // Funzione per ottenere il valore di un cookie
    function getCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
        }
        return null;
    }

    // Funzione per nascondere il banner dei cookie se l'utente ha già accettato o rifiutato
    function hideCookieBanner() {
        var cookieAccepted = getCookie('cookie_accepted');
        if (cookieAccepted === 'true') {
            document.getElementById('cookie-banner').style.display = 'none';
        }
    }

    // Mostra il banner dei cookie se non è già stato accettato o rifiutato
    window.onload = function() {
        hideCookieBanner();
    };

    // Azioni quando l'utente accetta i cookie
    document.getElementById('accept-cookies').addEventListener('click', function() {
        setCookie('cookie_accepted', 'true', 365); // Imposta il cookie per un anno
        document.getElementById('cookie-banner').style.display = 'none';
    });

    // Azioni quando l'utente rifiuta i cookie
    document.getElementById('reject-cookies').addEventListener('click', function() {
        setCookie('cookie_accepted', 'false', 365); // Imposta il cookie per un anno
        document.getElementById('cookie-banner').style.display = 'none';

    });

</script>


<main>
    <div class="container">
        <h1>Welcome to Zughri events</h1>
        <p>Benvenuti a Zugri Eventi, il tuo portale per vivere al massimo il tuo tempo libero a Trento e dintorni</p>

        <div class="buttons">
            <a href="<%= response.encodeURL("registra.jsp") %>"><button class="btn">Registra</button></a>
            <a href="<%= response.encodeURL("login.jsp") %>"><button class="btn">Login</button></a>
        </div>
    </div>

    <div class="container">
        <div class="container text-center">
            <h1>Top 3 eventi piu cliccati</h1>

            <% ResultSet resultSet2 = (ResultSet) request.getAttribute("resultSet2"); %>

            <%
                int counter = 0; // Counter to track the number of displayed events
            %>

            <div class="row">
                <% while (resultSet2.next() && counter < 3) { // Loop through each event result and limit to 3 %>
                <div class="col-md-4 card">
                    <div class="card-img-top-container">
                        <img src="<%= (String) resultSet2.getObject("Immagine") %>" width="100%" >
                    </div>
                    <div class="container">
                        <h4><b><%= resultSet2.getObject("NomeEvento") %></b></h4>
                        <p><%= resultSet2.getObject("DataOra")%></p>
                        <p><%= resultSet2.getObject("Localita") %></p>
                        <form action="dettaglioEvento" method="post">
                            <input type="hidden" name="eventId" value="<%= resultSet2.getObject("Id") %>" id="eventId">
                            <button type="submit" class="btn btn-secondary">Visualizza Evento</button>
                        </form>
                    </div>
                </div>

                <% counter++; %>
                <% } %>

            </div>  </div>
    </div>










</main>

<%@include file = "footer.html" %>


</body>
</html>