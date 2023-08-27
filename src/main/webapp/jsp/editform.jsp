<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="it.betacom.dao.ClienteDao, it.betacom.bean.*,java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Updating Cliente</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link rel="stylesheet" href="../css/editform.css">
</head>
<body>
	<%
	String username = request.getParameter("username");
	Cliente c = ClienteDao.getRecordByUsername(username);
	%>
	
	<div class="container">
    <form action="editcliente.jsp" method="post">
      <section class="ftco-section">
        <div class="card-form">      
              <div class="card">
                <div class="card-body">
                  <h5 class="card-title text-center">Modifica Utente</h5>
                  <div class="table-responsive">
                    <table class="table">
                      <tr>
                        <th>Nome</th>
                        <td><input type="text" name="nome" value="<%=c.getNome()%>" /></td>
                      </tr>
                      <tr>
                        <th>Cognome</th>
                        <td><input type="text" name="cognome" value="<%=c.getCognome()%>" /></td>
                      </tr>
                      <tr>
                        <th>Email</th>
                        <td><input type="text" name="email" value="<%=c.getEmail()%>" /></td>
                      </tr>
                      <tr>
                        <th>Cellulare</th>
                        <td><input type="text" name="cellulare" value="<%=c.getCellulare()%>" /></td>
                      </tr>
                      <tr>
                        <th>Data di nascita</th>
                        <td><input type="text" name="data_di_nascita" value="<%=c.getData_di_nascita()%>" /></td>
                      </tr>
                      <tr>
                        <th>Username</th>
                        <td><input type="text" name="username" value="<%=c.getUsername()%>" /></td>
                      </tr>
                      <tr>
                        <th>Password</th>
                        <td><input type="password" name="password" value="<%=c.getPassword()%>" /></td>
                      </tr>
                      <tr>
                        <th>Ruolo</th>
                        <td>
                          <% if (c.getRuolo().equals("G")) { %>
                          <a href="editruolo.jsp?username=<%=c.getUsername()%>" class="btn btn-primary">Rendi Manager</a>
                          <% } else if (c.getRuolo().equals("M")) { %>
                          <a href="editruolo.jsp?username=<%=c.getUsername()%>" class="btn btn-primary">Rendi Guest</a>
                          <% } %>
                        </td>
                      </tr>
                      <tr>
                        <th>Status</th>
                        <td>
                          <% if (c.getStatus().equals("A")) { %>
                          <a href="editstatus.jsp?username=<%=c.getUsername()%>" class="btn btn-primary">Disabilita</a>
                          <% } else if (c.getStatus().equals("D")) { %>
                          <a href="editstatus.jsp?username=<%=c.getUsername()%>" class="btn btn-primary">Abilita</a>
                          <% } %>
                        </td>
                      </tr>
                      <tr>
                        <td colspan="2">
                          <button type="submit" class="btn btn-primary">Conferma</button>
                        </td>
                      </tr>
                    </table>
                  </div>
                </div>
              </div>
        </div>
      </section>
    </form>
  </div>
</body>
</html>