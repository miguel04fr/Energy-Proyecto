<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Editar Entrenador</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <style>
                .form-container {
                    max-width: 800px;
                    margin: 0 auto;
                    padding: 20px;
                    background-color: #f8f9fa;
                    border-radius: 10px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                }

                .required-field::after {
                    content: "*";
                    color: red;
                    margin-left: 4px;
                }
            </style>
        </head>

        <body>
            <jsp:include page="/INC/cabecera.jsp" />
            <div class="container py-4">
                <div class="form-container">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="mb-0">Editar Entrenador</h2>
                        <form action="FrontController" method="POST" class="d-inline">
                            <button type="submit" name="modificarEntrenadores" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left"></i> Volver
                            </button>
                        </form>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <form action="Update" method="POST" class="needs-validation" novalidate>
                        <input type="hidden" name="id" value="${entrenador.id}">

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="dni" class="form-label required-field">DNI</label>
                                <input type="text" class="form-control" id="dni" name="dni" value="${entrenador.dni}"
                                    required pattern="[0-9]{8}[A-Za-z]">
                                <div class="invalid-feedback">
                                    Por favor, introduce un DNI válido (8 números y una letra)
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="iban" class="form-label required-field">IBAN</label>
                                <input type="text" class="form-control" id="iban" name="iban" value="${entrenador.iban}"
                                    required pattern="[A-Z]{2}[0-9]{22}">
                                <div class="invalid-feedback">
                                    Por favor, introduce un IBAN válido
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="nombre" class="form-label required-field">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre"
                                    value="${entrenador.nombre}" required>
                                <div class="invalid-feedback">
                                    Por favor, introduce el nombre
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="apellido" class="form-label required-field">Apellido</label>
                                <input type="text" class="form-control" id="apellido" name="apellido"
                                    value="${entrenador.apellido}" required>
                                <div class="invalid-feedback">
                                    Por favor, introduce el apellido
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="email" class="form-label required-field">Email</label>
                                <input type="email" class="form-control" id="email" name="email"
                                    value="${entrenador.email}" required>
                                <div class="invalid-feedback">
                                    Por favor, introduce un email válido
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="telefono" class="form-label required-field">Teléfono</label>
                                <input type="tel" class="form-control" id="telefono" name="telefono"
                                    value="${entrenador.telefono}" required pattern="[0-9]{9}">
                                <div class="invalid-feedback">
                                    Por favor, introduce un teléfono válido (9 dígitos)
                                </div>
                            </div>
                        </div>
                        <div>
                            <label for="fechaNacimiento" class="form-label required-field">Fecha de Nacimiento</label>
                            <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento"
                                value="${entrenador.fechaNacimiento}" required>
                        </div>





                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <button type="submit" name="guardarEntrenador" class="btn btn-primary">
                                <i class="fas fa-save"></i> Guardar Cambios
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
        </body>

        </html>