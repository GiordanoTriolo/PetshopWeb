<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="it.betacom.dao.AnimaleDao"%>
<%@ page import="it.betacom.bean.Animale"%>
<jsp:useBean id="a" class="it.betacom.bean.Animale"></jsp:useBean>

<jsp:setProperty property="*" name="a" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deleting User</title>
</head>
<body>
	<%
	String matricola = request.getParameter("matricola");

	a = AnimaleDao.getRecordByMatricola(Integer.parseInt(matricola));

	if (a != null) {
		int result = AnimaleDao.delete(a);
		if(result > 0){
			response.sendRedirect("tableanimali.jsp");
		} else
			out.print("errore result");
		
	} else {
		out.print(matricola);
		out.print("errore");
	}
	%>
</body>
</html>