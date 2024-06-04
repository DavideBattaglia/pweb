<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <a class="navbar-brand" href="index.jsp">
            <img src="img/zughri.png" alt="Logo" width="150" class="d-inline-block align-text-top">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="<%= response.encodeURL("index.jsp") %>">Home</a>
                </li>
                <li class="nav-item dropdown"> <a class="nav-link dropdown-toggle" href="#" id="eventiDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    Eventi
                </a>
                    <ul class="dropdown-menu" aria-labelledby="eventiDropdown"> <li><a class="dropdown-item" href="<%= response.encodeURL("DisplayConcerti") %>">Concerti</a></li>
                        <li><a class="dropdown-item" href="<%= response.encodeURL("DisplaySpettacoliTeatrali") %>">Spettacoli teatrali</a></li>
                        <li><a class="dropdown-item" href="<%= response.encodeURL("DisplayEventiSportivi") %>">Eventi Sportivi</a></li>
                        <li><a class="dropdown-item" href="<%= response.encodeURL("DisplayVisiteGuidate") %>">Visite guidate</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= response.encodeURL("") %>">Contatti</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= response.encodeURL("DisplayCarrelloServlet") %>">Carrello</a>
                </li>
                <li class="nav-item">
                    <%
                        String username = (String) session.getAttribute("user");
                        if (username != null && !username.isEmpty()) {
                    %>
                    <a class="nav-link" href="#"><%= username %></a>
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
