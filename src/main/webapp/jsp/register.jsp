<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="it.betacom.dao.ClienteDao" %>
<jsp:useBean id="c" class="it.betacom.bean.Cliente"></jsp:useBean>
<jsp:setProperty property="*" name="c"/>

<%
boolean salvataggioEffettuato = false;
int i = ClienteDao.save(c);
if (i > 0) {
    salvataggioEffettuato = true;
} else {
    salvataggioEffettuato = false;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Risultato Salvataggio</title>
    <style>
        .success {
            background-color: #28a745;
        }

        .error {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
    <%
    if (salvataggioEffettuato) {
        %>
        <script>
            alert('Salvataggio effettuato');
            document.body.classList.add('success');
            window.location.href = "http://localhost:8080/PetshopWeb/login.html";
        </script>
        <% 
    } else {
        %>
        <script>
            alert('Salvataggio fallito, verrai reindirizzato alla pagina di registrazione');
            window.location.href = "http://localhost:8080/PetshopWeb/index.html";
        </script>
        <%
    }
    %>
</body>
</html>