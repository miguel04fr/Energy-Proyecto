<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- @ts-nocheck -->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Entrenadores</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .table-responsive {
                margin-top: 20px;
            }
            .status-active {
                color: #198754;
            }
            .status-inactive {
                color: #dc3545;
            }
            .action-buttons {
                white-space: nowrap;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp"/>
        <div class="container-fluid">
            <h2 class="text-center my-4">Gestión de Entrenadores</h2>
            
            <div class="row mb-3">
                <div class="col">
                    <a href="FrontController?cmd=admin" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Volver al Panel de Administración
                    </a>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>DNI</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Email</th>
                            <th>Teléfono</th>
                            <th>IBAN</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listaUsuarios}" var="usuario">
                            <tr>
                                <td>${usuario.id}</td>
                                <td>${usuario.dni}</td>
                                <td>${usuario.nombre}</td>
                                <td>${usuario.apellido}</td>
                                <td>${usuario.email}</td>
                                <td>${usuario.telefono}</td>
                                <td>${usuario.iban}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${usuario.activo}">
                                            <span class="status-active">
                                                <i class="fas fa-check-circle"></i> Activo
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-inactive">
                                                <i class="fas fa-times-circle"></i> Inactivo
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="action-buttons">
                                  
                                    
                                    <form action="Update" method="post">
                                        <input type="hidden" name="id" value="${usuario.id}">
                                    <button class="btn ${usuario.activo ? 'btn-warning' : 'btn-success'} btn-sm" 
                                            data-id="${usuario.id}"
                                            data-activo="${usuario.activo}"
                                            type="submit"
                                            name="cambiarEstadoUsuario" value="${usuario.activo ? 'false' : 'true'}">
                                        <i class="fas ${usuario.activo ? 'fa-user-slash' : 'fa-user-check'}"></i>
                                        ${usuario.activo ? 'Desactivar' : 'Activar'}
                                    </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Modal para editar entrenador -->
        <div class="modal fade" id="editarEntrenadorModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Editar Entrenador</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editarEntrenadorForm">
                            <input type="hidden" id="entrenadorId" name="id">
                            <div class="mb-3">
                                <label for="dni" class="form-label">DNI</label>
                                <input type="text" class="form-control" id="dni" name="dni" required>
                            </div>
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                            </div>
                            <div class="mb-3">
                                <label for="apellido" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="apellido" name="apellido" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="tel" class="form-control" id="telefono" name="telefono" required>
                            </div>
                            <div class="mb-3">
                                <label for="iban" class="form-label">IBAN</label>
                                <input type="text" class="form-control" id="iban" name="iban" required>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary" onclick="guardarCambios()">Guardar Cambios</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function editarEntrenador(id) {
                // Aquí deberías hacer una llamada AJAX para obtener los datos del entrenador
                // y luego mostrar el modal con los datos
                const modal = new bootstrap.Modal(document.getElementById('editarEntrenadorModal'));
                modal.show();
            }

            function guardarCambios() {
                // Aquí deberías hacer una llamada AJAX para guardar los cambios
                const formData = new FormData(document.getElementById('editarEntrenadorForm'));
                // Implementar la lógica de guardado
            }

            function eliminarEntrenador(id) {
                if (confirm('¿Estás seguro de que deseas eliminar este entrenador?')) {
                    // Aquí deberías hacer una llamada AJAX para eliminar el entrenador
                    window.location.href = 'FrontController?cmd=eliminarEntrenador&id=' + id;
                }
            }

            function cambiarEstado(button) {
                const id = button.dataset.id;
                const activo = button.dataset.activo === 'true';
                window.location.href = 'FrontController?cmd=cambiarEstadoEntrenador&id=' + id + '&activo=' + !activo;
            }
        </script>
    </body>
</html> 