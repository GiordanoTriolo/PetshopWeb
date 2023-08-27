<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="it.betacom.dao.ClienteDao"%>
<%@ page import="it.betacom.bean.Cliente"%>
<jsp:useBean id="c" class="it.betacom.bean.Cliente"></jsp:useBean>

<jsp:setProperty property="*" name="c" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deleting User</title>
</head>
<body>
	<%
	String username = request.getParameter("username");

	c = ClienteDao.getRecordByUsername(username);

	if (c != null) {
		int result = ClienteDao.delete(c);
		if(result > 0){
			response.sendRedirect("table.jsp");
		} else
			out.print("errore result");
		
	} else {
		out.print(username);
		out.print("errore");
	}
	%>
</body>
</html>