<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:useBean id="c" class="it.betacom.bean.Cliente"></jsp:useBean>
<%@page import="it.betacom.dao.*" %>
<jsp:setProperty property="*" name="c"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit User JSP</title>
</head>
<body>
<%
int i=ClienteDao.update(c);
response.sendRedirect("table.jsp");
%>
</body>
</html>