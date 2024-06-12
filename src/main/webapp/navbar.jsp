<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.UnsupportedEncodingException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String cookieConsent = null;
    javax.servlet.http.Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (javax.servlet.http.Cookie cookie : cookies) {
            if ("cookie_accepted".equals(cookie.getName())) {
                cookieConsent = cookie.getValue();
                break;
            }
        }
    }


    String sessionId = session.getId();
    String homeURL = "DisplayDiscountServlet";
    String concertiURL = "DisplayConcerti";
    String spettacoliURL = "DisplaySpettacoliTeatrali";
    String eventiSportiviURL = "DisplayEventiSportivi";
    String visiteURL = "DisplayVisiteGuidate";
    String loginURL = "login.jsp";
    String registraURL = "registra.jsp";
    String contattiURL = "contatti.jsp";

    if("false".equals(cookieConsent)){
        homeURL += ";jsessionid=" + sessionId;
        concertiURL += ";jsessionid=" + sessionId;
        spettacoliURL += ";jsessionid=" + sessionId;
        eventiSportiviURL += ";jsessionid=" + sessionId;
        visiteURL += ";jsessionid=" + sessionId;
        loginURL += ";jsessionid=" + sessionId;
        registraURL += ";jsessionid=" + sessionId;
        contattiURL += ";jsessionid=" + sessionId;
    }

    try {
        String homeencodedURL = URLEncoder.encode(homeURL, "UTF-8");
        String concertiencodedURL = URLEncoder.encode(concertiURL, "UTF-8");
        String spettacoliencodedURL = URLEncoder.encode(spettacoliURL, "UTF-8");
        String eventiSportiviencodedURL = URLEncoder.encode(eventiSportiviURL, "UTF-8");
        String visiteencodedURL = URLEncoder.encode(visiteURL, "UTF-8");
        String loginencodedURL = URLEncoder.encode(loginURL, "UTF-8");
        String registraencodedURL = URLEncoder.encode(registraURL, "UTF-8");
        String contattiencodedURL = URLEncoder.encode(contattiURL, "UTF-8");

    } catch (UnsupportedEncodingException e) {
        // Gestione dell'eccezione, se necessario
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Navbar Bootstrap 5.3.0 Alpha1</title>
    <!-- Bootstrap CSS
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    -->
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="/ProgWeb_war_exploded">
            <img src="img/zughri.png" alt="Logo" width="150" class="d-inline-block align-text-top">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="<%= response.encodeURL(homeURL) %>">Home</a>

                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="<%= response.encodeURL(contattiURL) %>">Contatti</a>
                </li>
                <%Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
                if (isAdmin != null) {
                    if(isAdmin){%>
                        <li class="divider"></li>
                        <li><a class="nav-link active" aria-current="page" href="<%= response.encodeURL("DisplayEventiServlet") %>">Visualizza Eventi</a></li>
                        <li><a class="nav-link active" aria-current="page" href="<%= response.encodeURL("DisplayUtentiServlet") %>">Visualizza Utenti</a></li>
                <%
                    } else {
                %>
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="<%= response.encodeURL("DisplayCarrelloServlet") %>">Carrello</a>
                        </li>
                <%
                    }
                }
                %>
                <li class="nav-item dropdown"> <a class="nav-link dropdown-toggle" href="#" id="eventiDropdown" data-bs-toggle="dropdown" aria-expanded="false">Eventi</a>
                    <ul class="dropdown-menu" aria-current="page" aria-labelledby="eventiDropdown">
                        <li><a class="dropdown-item" href="<%= response.encodeURL(concertiURL) %>">Concerti</a></li>
                        <li><a class="dropdown-item" href="<%= response.encodeURL(spettacoliURL) %>">Spettacoli teatrali</a></li>
                        <li><a class="dropdown-item" href="<%= response.encodeURL(eventiSportiviURL) %>">Eventi Sportivi</a></li>
                        <li><a class="dropdown-item" href="<%= response.encodeURL(visiteURL) %>">Visite Guidate</a></li>
                        <li class="divider"></li>
                    </ul>
                </li>

                <li class="nav-item">
                    <%
                        String username = (String) session.getAttribute("user");
                        if (username != null && !username.isEmpty()) {
                    %>
                    <a class="nav-link" aria-current="page" href="<%= response.encodeURL("ProfiloServlet") %>"><%= username %></a>
                    <a class="nav-link active" aria-current="page" href="<%= response.encodeURL("logout") %>">Logout</a>
                    <%
                    } else {

                    %>
                    <a class="nav-link active" aria-current="page" href="<%= response.encodeURL(loginURL) %>">Login</a>
                    <a class="nav-link active" aria-current="page" href="<%= response.encodeURL(registraURL) %>">Registrati</a>
                    <%
                        }
                    %>
                </li>
            </ul>
        </div>
    </div>
</nav>


<!-- Bootstrap Bundle with Popper
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>-->
</body>
</html>
