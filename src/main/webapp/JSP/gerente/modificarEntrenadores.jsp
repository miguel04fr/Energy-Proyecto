<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
            <jsp:include page="/INC/cabecera.jsp" />
            <div class="container-fluid">
                <h2 class="text-center my-4">Gestión de Entrenadores</h2>

                <div class="row mb-3">
                    <div class="col">
                        <form action="FrontController" method="post">
                            <button type="submit" name="inicio" value="inicio">
                                <i class="fas fa-arrow-left"></i> Volver al Panel de Administración
                            </button>
                        </form>
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
                                <th>Eliminar</th>
                                <th>Editar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listaEntrenadores}" var="usuario">
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
                                                data-id="${usuario.id}" data-activo="${usuario.activo}" type="submit"
                                                name="cambiarEstadoEntrenador"
                                                value="${usuario.activo ? 'false' : 'true'}">
                                                <i
                                                    class="fas ${usuario.activo ? 'fa-user-slash' : 'fa-user-check'}"></i>
                                                ${usuario.activo ? 'Desactivar' : 'Activar'}
                                            </button>
                                        </form>
                                    </td>
                                    <td>
                                        <form action="Delete" method="post">
                                            <input type="hidden" name="id" value="${usuario.id}">
                                            <button class="btn btn-danger btn-sm" type="submit" name="eliminarEntrenador" value="eliminarEntrenador">
                                                <i class="fas fa-trash-alt"></i> Eliminar
                                            </button>
                                        </form>
                                    </td>
                                    <td>
                                        <form action="Update" method="post">
                                            <input type="hidden" name="id" value="${usuario.id}">
                                            <button class="btn btn-primary btn-sm" type="submit" name="editarEntrenador" value="editarEntrenador">
                                                <i class="fas fa-edit"></i> Editar
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
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