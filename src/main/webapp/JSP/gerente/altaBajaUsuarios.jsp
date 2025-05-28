<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!-- @ts-nocheck -->
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Gestión de Usuarios</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <style>
                .table-responsive {
                    margin-top: 20px;
                    overflow-x: auto;
                }

                .card-container {
                    display: none;
                }

                .usuario-card {
                    margin-bottom: 15px;
                    border: 1px solid #ddd;
                    border-radius: 8px;
                    padding: 15px;
                    background-color: #fff;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                }

                .usuario-card .card-header {
                    background-color: #f8f9fa;
                    padding: 10px;
                    border-bottom: 1px solid #ddd;
                    border-radius: 8px 8px 0 0;
                }

                .usuario-card .card-body {
                    padding: 15px;
                }

                .usuario-info {
                    margin-bottom: 10px;
                }

                .usuario-info strong {
                    display: inline-block;
                    width: 120px;
                    color: #666;
                }

                .btn-container {
                    margin-top: 10px;
                    display: flex;
                    gap: 5px;
                    flex-wrap: wrap;
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

                @media (max-width: 768px) {
                    .table-container {
                        display: none;
                    }

                    .card-container {
                        display: block;
                    }

                    .container-fluid {
                        padding: 10px;
                        margin-top: 114px;
                    }

                    h2 {
                        font-size: 1.5rem;
                    }

                    .usuario-card {
                        margin: 10px 0;
                    }

                    .usuario-info strong {
                        width: 100px;
                        font-size: 0.9rem;
                    }

                    .btn {
                        padding: 0.25rem 0.5rem;
                        font-size: 0.75rem;
                        width: 100%;
                        margin: 5px 0;
                    }

                    .admin-actions {
                        margin: 10px 0;
                    }

                    .btn-admin {
                        width: 100%;
                        margin: 5px 0;
                    }
                }

                .btn-volver {
                    margin: 15px 0;
                }
            </style>
        </head>

        <body>
            <jsp:include page="/INC/cabecera.jsp" />
            <div class="container-fluid">
                <h2 class="text-center my-4">Gestión de Usuarios</h2>

                <div class="row mb-3">
                    <div class="col">
                        <form action="FrontController" method="post">
                            <button type="submit" name="inicio" value="inicio" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Volver al Panel de Administración
                            </button>
                        </form>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col">
                        <form action="FrontController" method="post">
                            <button type="submit" name="crearCliente" value="crearCliente" class="btn btn-primary">
                                <i class="fas fa-user-plus"></i> Crear Cliente
                            </button>
                        </form>
                    </div>
                </div>
                

                <!-- Vista de tabla para pantallas grandes -->
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
                                                data-id="${usuario.id}" data-activo="${usuario.activo}" type="submit"
                                                name="cambiarEstadoUsuario"
                                                value="${usuario.activo ? 'false' : 'true'}">
                                                <i class="fas ${usuario.activo ? 'fa-user-slash' : 'fa-user-check'}"></i>
                                                ${usuario.activo ? 'Desactivar' : 'Activar'}
                                            </button>
                                        </form>
                                    </td>
                                    <td>
                                     

                                    
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Vista de tarjetas para móviles -->
                <div class="card-container">
                    <c:forEach items="${listaUsuarios}" var="usuario">
                        <div class="usuario-card">
                            <div class="card-header">
                                <h5 class="mb-0">${usuario.nombre} ${usuario.apellido}</h5>
                            </div>
                            <div class="card-body">
                                <div class="usuario-info">
                                    <strong>ID:</strong> ${usuario.id}
                                </div>
                                <div class="usuario-info">
                                    <strong>DNI:</strong> ${usuario.dni}
                                </div>
                                <div class="usuario-info">
                                    <strong>Email:</strong> ${usuario.email}
                                </div>
                                <div class="usuario-info">
                                    <strong>Teléfono:</strong> ${usuario.telefono}
                                </div>
                                <div class="usuario-info">
                                    <strong>IBAN:</strong> ${usuario.iban}
                                </div>
                                <div class="usuario-info">
                                    <strong>Estado:</strong>
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
                                </div>
                                <div class="btn-container">
                                    <form action="Update" method="post" class="w-100">
                                        <input type="hidden" name="id" value="${usuario.id}">
                                        <button class="btn ${usuario.activo ? 'btn-warning' : 'btn-success'}"
                                            data-id="${usuario.id}" data-activo="${usuario.activo}" type="submit"
                                            name="cambiarEstadoUsuario"
                                            value="${usuario.activo ? 'false' : 'true'}">
                                            <i class="fas ${usuario.activo ? 'fa-user-slash' : 'fa-user-check'}"></i>
                                            ${usuario.activo ? 'Desactivar' : 'Activar'}
                                        </button>
                                    </form>
                                    <form action="Delete" method="post" class="w-100">
                                        <input type="hidden" name="id" value="${usuario.id}">
                                        <button class="btn btn-danger" type="submit" name="eliminarUsuario" value="eliminarUsuario">
                                            <i class="fas fa-trash-alt"></i> Eliminar
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>