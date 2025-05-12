<%-- 
    Document   : crearInscripcion
    Created on : 4 abr 2025, 9:21:51
    Author     : zapat
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="contexto" value="${pageContext.request.contextPath}" scope="application"/>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Formulario de Reserva</title>
        <script src="${contexto}/JS/crearInscripcion.js" defer=""></script>
        <link rel="stylesheet" href="${contexto}/CSS/crearEntrenador.css"/>

    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>Formulario de dar de alta Entrenador</h1>
                <button id="toggleMode" class="toggle-btn">Modo Oscuro</button>
            </div>
            <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

            <form action="Create" method="post">
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" value="Juan" >
                </div>

                <div class="form-group">
                    <label for="apellido">Apellido:</label>
                    <input type="text" id="apellido" name="apellido" value="Pérez" >
                </div>

                <div class="form-group">
                    <label for="telefono">Teléfono:</label>
                    <input type="tel" id="telefono" name="telefono" value="612345678" >
                </div>
                <div class="form-group">
                    <label for="telefono">Dni: </label>
                    <input type="tel" id="dni" name="dni" value="A1234567V" >
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="juan.perez@gmail.com" >
                </div>
                <div class="form-group">
                    <label for="fechaNacimiento">Fecha de Nacimiento:</label>
                    <input type="date" id="fechaNacimiento" name="fechaNacimiento" value="1990-01-01" >
                </div>
                <div class="form-group">
                    <label for="iban">Iban:</label>
                    <input type="tel" id="iban" name="iban" value="ES12345678901234567890" >
                </div>
                <div class="form-group">
                    <label for="clave"><i class="fas fa-lock"></i> Contraseña</label>
                    <div class="password-input">
                        <input type="password" id="clave" name="clave" required >
                               
                        <button type="button" class="toggle-password">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                <div class="form-group">
                    <input type="submit" value="Enviar" class="submit-btn" name="crearEntrenador">
                </div>
              
            </form>
        </div>
    </body>
</html>


