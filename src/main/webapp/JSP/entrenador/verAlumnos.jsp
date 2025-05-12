<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mis Alumnos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .table-container {
                margin: 20px;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .table thead th {
                background-color: #f8f9fa;
                border-bottom: 2px solid #dee2e6;
            }
            .table-hover tbody tr:hover {
                background-color: #f5f5f5;
            }
            .header-section {
                background-color: #f8f9fa;
                padding: 20px;
                margin-bottom: 20px;
                border-radius: 8px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp"/>

        <div class="container">
            <div class="header-section">
                <h2 class="text-center mb-4">Mis Alumnos</h2>
                <p class="text-center text-muted">Lista de alumnos inscritos en tus clases</p>
            </div>

            <div class="table-container">
                <c:if test="${empty listaUsuarios}">
                    <div class="alert alert-info text-center">
                        No tienes alumnos inscritos en tus clases actualmente.
                    </div>
                </c:if>

                <c:if test="${not empty listaUsuarios}">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Email</th>
                                <th>Teléfono</th>
                                <th>DNI</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="usuario" items="${listaUsuarios}">
                                <tr>
                                    <td>${usuario.id}</td>
                                    <td>${usuario.nombre}</td>
                                    <td>${usuario.apellido}</td>
                                    <td>${usuario.email}</td>
                                    <td>${usuario.telefono}</td>
                                    <td>${usuario.dni}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>

            <div class="text-center mt-4">
                <a href="FrontController" class="btn btn-primary">Volver al Inicio</a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html> 