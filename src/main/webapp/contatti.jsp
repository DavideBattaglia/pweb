<%--
  Created by IntelliJ IDEA.
  User: doghr
  Date: 11/06/2024
  Time: 23:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Contattaci!</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<header>
    <%@include file = "navbar.jsp" %>
</header>


<div class="container">
    <h3 class="text-center">Contattaci!</h3>
    <p class="text-center"><em>Chiedici quello che vuoi</em></p>
    <div class="row test">
        <div class="col-md-4">
            <p>Vuoi postare un evento? Chiedilo a noi e lo faremo per te!</p>
            <p><span class="glyphicon glyphicon-map-marker"></span>Italia, IT</p>
            <p><span class="glyphicon glyphicon-phone"></span>Telefono: +00 1515151515</p>
            <p><span class="glyphicon glyphicon-envelope"></span>Email: mail@mail.com</p>
        </div>
        <div class="col-md-8">
            <div class="row">
                <div class="col-sm-6 form-group">
                    <input class="form-control" id="name" name="name" placeholder="Name" type="text" required>
                </div>
                <div class="col-sm-6 form-group">
                    <input class="form-control" id="email" name="email" placeholder="Email" type="email" required>
                </div>
            </div>
            <textarea class="form-control" id="comments" name="comments" placeholder="Comment" rows="5"></textarea>
            <div class="row">
                <div class="col-md-12 form-group">
                    <button class="btn pull-right" type="submit">Invia</button>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file = "footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
