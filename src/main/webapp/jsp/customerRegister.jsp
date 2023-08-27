<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="it.betacom.dao.CustomerDao" %>
<jsp:useBean id="c" class="it.betacom.bean.Customer"></jsp:useBean>
<jsp:setProperty property="*" name="c"/>

<%
boolean salvataggioEffettuato = false;
int i = CustomerDao.save(c);
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
            window.location.href = "http://localhost:8080/PetshopWeb/customerLogin.html";
        </script>
        <% 
    } else {
        %>
        <script>
            alert('Salvataggio fallito, verrai reindirizzato alla pagina di registrazione');
            window.location.href = "http://localhost:8080/PetshopWeb/customerRegister.html";
        </script>
        <%
    }
    %>
</body>
</html>