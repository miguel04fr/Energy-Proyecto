<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Salas - Energy</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp"/>
        
        <div class="container mt-5 pt-5">
            <div class="row">
                <div class="col-12">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white">
                            <h3 class="mb-0"><i class="fas fa-door-open"></i> Gestión de Salas</h3>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty requestScope.error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-circle"></i> ${requestScope.error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty requestScope.success}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle"></i> ${requestScope.success}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>

                            <!-- Formulario para añadir nueva sala -->
                            <form action="Create" method="POST" class="mb-4">   
                                <c:if test="${not empty requestScope.mensajeErrorId}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <i class="fas fa-exclamation-circle"></i> ${requestScope.mensajeErrorId}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                    </c:if>
                                <div class="row g-3 align-items-center">
                                    <div class="col-auto">
                                        <input type="number" class="form-control" name="idSala" placeholder="ID Sala" required>
                                        <input type="text" class="form-control" name="descripcion" placeholder="Nueva sala" required>
                                    </div>
                                    <div class="col-auto">
                                        <button type="submit" class="btn btn-success" name="crearSala">
                                            <i class="fas fa-plus"></i> Añadir Sala
                                        </button>
                                    </div>
                                </div>
                            </form>

                            <!-- Tabla de salas -->
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Descripción</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="sala" items="${requestScope.listaSalas}">
                                            <tr>
                                                <td>${sala.idSala}</td>
                                                <td>
                                                    <form action="Update" method="POST" class="d-flex">
                                                        <input type="hidden" name="idSala" value="${sala.idSala}">
                                                        <input type="text" class="form-control me-2" name="descripcion" value="${sala.descripcion}" required>
                                                        <button type="submit" class="btn btn-primary btn-sm" name="actualizarSala">
                                                            <i class="fas fa-save"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                                <td>
                                                    <form action="Delete" method="POST" style="display: inline;">
                                                        <input type="hidden" name="idSala" value="${sala.idSala}">
                                                        <button type="submit" class="btn btn-danger btn-sm" name="eliminarSala" onclick="return confirm('¿Estás seguro de que deseas eliminar esta sala?')">
                                                            <i class="fas fa-trash"></i>
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
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html> 