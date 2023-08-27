<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="it.betacom.dao.AnimaleDao, it.betacom.bean.Animale" %>
<%@ page import="java.util.*" %>

<%
    String matricola = request.getParameter("matricola");
    String nomeAnimale = request.getParameter("nomeAnimale");
    String tipoAnimale = request.getParameter("tipoAnimale");
    double prezzo = Double.parseDouble(request.getParameter("prezzo"));

    Animale a = new Animale();
    a.setMatricola(Integer.parseInt(matricola));
    a.setNomeAnimale(nomeAnimale);
    a.setTipoAnimale(tipoAnimale);
    a.setPrezzo(prezzo);

    int result = AnimaleDao.update(a);

    if (result > 0) {
        // Aggiornamento riuscito, puoi fare un reindirizzamento o mostrare un messaggio di successo
        response.sendRedirect("tableanimali.jsp");
    } else {
        // Aggiornamento fallito, puoi fare un reindirizzamento o mostrare un messaggio di errore
        response.sendRedirect("error.jsp");
    }
%>