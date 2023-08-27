<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="c" class="it.betacom.bean.Cliente"></jsp:useBean>
<%@page import="it.betacom.dao.*" %>
<%@page import="it.betacom.bean.*" %>
<jsp:setProperty property="*" name="c"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Status JSP</title>
</head>
<body>
	<%
	Cliente cliente = ClienteDao.getRecordByUsername(request.getParameter("username"));
	%>
	
	
    <%-- Rimuovi il codice di aggiornamento e il redirect --%>
    <% if (cliente.getStatus().equals("A")) { %>
        <%-- Aggiungi il codice per rendere il cliente Manager --%>
        <% ClienteDao.updateStatusDisabled(cliente); %>
        <%-- Mostra il messaggio di conferma usando JavaScript --%>
        <script>
            alert("Status aggiornato a disabilitato con successo!");
            window.location.href = "table.jsp";
        </script>
    <% } else if (cliente.getStatus().equals("D")) { %>
         <%-- Aggiungi il codice per rendere il cliente Manager --%>
        <% ClienteDao.updateStatusEnabled(cliente); %>
        <%-- Mostra il messaggio di conferma usando JavaScript --%>
        <script>
            alert("Status aggiornato ad abilitato con successo!");
            window.location.href = "table.jsp";
        </script>
    <% } %>
</body>
</html>