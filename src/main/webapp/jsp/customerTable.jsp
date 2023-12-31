<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="it.betacom.dao.ClienteDao, it.betacom.bean.*,java.util.*"%>
	<%@page
	import="it.betacom.dao.CustomerDao, it.betacom.bean.*,java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Clienti JSP</title>
<link rel="stylesheet" href="../css/table.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>

	<%
	List<Customer> list = CustomerDao.getAllRecords();
	request.setAttribute("list", list);
	Cliente user = (Cliente) session.getAttribute("loggedUser");
	if (user != null) {
		System.out.println("Nome utente loggato: " + user.getNome());
		System.out.println("Ruolo utente loggato: " + user.getRuolo());
	}

	boolean isManager = false;
	if (user != null && "M".equals(user.getRuolo())) {
		isManager = true;
	}
	%>
	
<body style="background-color: orange;">
<div class = "container" id = "generalContainer">
        <div class="row justify-content-start"> <!-- Utilizzo di justify-content-start -->
            <div class="col">
                <h1 class="display-4" style="color:black;">Customers List</h1>
            </div>
            <div class="col-auto">
                <a href="homepage.jsp" class="btn btn-primary" style="color: white;">Home</a>
            </div>
        </div>

	<div class="container">
		<table>
			<thead>
				<tr>
					<th>Nome</th>
					<th>Cognome</th>
					<th>Username</th>
					<th>Cellulare</th>
					<th>Data di nascita</th>
					<th>Citt�</th>
					<th>Indirizzo</th>
					
					<%
					if (isManager) {
					%>
					<th>Visualizza acquisti</th>
					<%
					}
					%>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="c">
					<tr>
						<td>${c.getNome()}</td>
						<td>${c.getCognome()}</td>
						<td>${c.getUsername()}</td>
						<td>${c.getCellulare()}</td>
						<td>${c.getData_di_nascita()}</td>
						<td>${c.getCitta()}</td>
						<td>${c.getIndirizzo()}</td>
						
						<%
						if (isManager) {
						%>
                        <td><a href="acquistiView.jsp?id=${CustomerDao.getIdByUsername(c.getUsername())}"
                                class="btn btn-info">Visualizza Acquisti</a></td>
						<%
						}
						%>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	</div>
</body>

</html>