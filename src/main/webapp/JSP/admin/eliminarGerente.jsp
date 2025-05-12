<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Gerente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp"/>
            <div class="container mt-4">
            <h2 class="mb-4">Eliminar Gerente</h2>
            
            <c:if test="${not empty mensaje}">
                <div class="alert alert-info">
                    ${mensaje}
                </div>
            </c:if>

            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Lista de Gerentes</h5>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Email</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="gerente" items="${listaGerentes}">
                                    <tr>
                                        <td>${gerente.id}</td>
                                        <td>${gerente.nombre}</td>
                                        <td>${gerente.email}</td>
                                        <td>
                                            <form action="Delete" method="POST" style="display: inline;">
                                                <input type="hidden" name="gerenteId" value="${gerente.id}">
                                                <button type="submit" name="eliminarGerente" class="btn btn-danger btn-sm" 
                                                    <i class="fas fa-trash"></i> Eliminar
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/JSP/admin/indexAdmin.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Volver al Panel de Administración
                </a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html> 