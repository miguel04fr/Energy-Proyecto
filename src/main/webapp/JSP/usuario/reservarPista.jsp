<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Reservar pista</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/INC/estilos.css" />
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        </head>
        <body>
        <div class="inscripciones-container">
            <h1>Reservar pista</h1>
            <form action="${pageContext.request.contextPath}/Create" method="post">
                <label for="pista">Pista:</label>   
                <select id="pista" name="pista">    

                </select>

                <label for="fecha">Fecha:</label>    
                <input type="date" id="fecha" name="fecha" >
                
               <input type="submit" value="Reservar" name="reservarPista">
            
            </form>