<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Entrenadores</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .card {
                transition: transform 0.3s;
                margin-bottom: 20px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .card:hover {
                transform: translateY(-5px);
            }
            .card-header {
                background-color: #007bff;
                color: white;
                font-weight: bold;
            }
            .icon-container {
                font-size: 2rem;
                margin-bottom: 10px;
                color: #007bff;
            }
            .admin-buttons {
                margin-top: 20px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp"/>

        <div class="container mt-5">
            <h1 class="text-center mb-4">Nuestros Entrenadores</h1>
            
            <c:if test="${sessionScope.usuarioLogueado.rol == 'GERENTE'}">
                <div class="admin-buttons">
                    <form action="FrontController" method="post">
                        <button type="submit" name="crearEntrenador" class="btn btn-success">
                            <i class="fas fa-plus"></i> Crear Nuevo Entrenador
                        </button>
                        
                    </form>
                </div>
            </c:if>

            <div class="row mt-4">
                <c:forEach var="entrenador" items="${listaEntrenadores}">
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header text-center">
                                <div class="icon-container">
                                    <i class="fas fa-user-tie"></i>
                                </div>
                                <h4>${entrenador.nombre} ${entrenador.apellido}</h4>
                            </div>
                            <div class="card-body">
                                <p class="card-text">
                                    <strong><i class="fas fa-phone"></i> Teléfono:</strong> ${entrenador.telefono}<br>
                                    <strong><i class="fas fa-user"></i> Nombre:</strong> ${entrenador.nombre} ${entrenador.apellido}<br>
                                    <strong><i class="fas fa-envelope"></i> Email:</strong> ${entrenador.email}<br>
                                    <strong><i class="fas fa-calendar-alt"></i> Fecha de Nacimiento:</strong> ${entrenador.fechaNacimiento}<br>

                                </p>
                            </div>
                            <div class="card-footer text-center">
                              <form action="FrontController" method="post">
                                <input type="hidden" name="verHorariosEntrenador" value="${entrenador.id}">
                                <button type="submit" name="verHorariosEntrenador" class="btn btn-outline-primary">
                                    <i class="fas fa-calendar-alt"></i> Ver Horarios
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