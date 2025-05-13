<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ver Horarios</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/INC/estilos.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .table-container {
                overflow-x: auto;
                margin: 20px 0;
            }

            .card-container {
                display: none;
            }

            .horario-card {
                margin-bottom: 15px;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 15px;
                background-color: #fff;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .horario-card .card-header {
                background-color: #f8f9fa;
                padding: 10px;
                border-bottom: 1px solid #ddd;
                border-radius: 8px 8px 0 0;
            }

            .horario-card .card-body {
                padding: 15px;
            }

            .horario-info {
                margin-bottom: 10px;
            }

            .horario-info strong {
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

            .btn {
                margin: 2px;
                white-space: nowrap;
            }

            .error-message {
                color: #dc3545;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #dc3545;
                border-radius: 4px;
                background-color: #f8d7da;
            }

            .info-message {
                color: #0c5460;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #bee5eb;
                border-radius: 4px;
                background-color: #d1ecf1;
            }

            @media (max-width: 768px) {
                .table-container {
                    display: none;
                }

                .card-container {
                    display: block;
                }

                .container {
                    padding: 10px;
                }
                @media screen and (max-width: 480px) {
    .container {
        margin-top: 114px !important;
    }
}

                h1 {
                    font-size: 1.5rem;
                }

                .horario-card {
                    margin: 10px 0;
                }

                .horario-info strong {
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
        </style>
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp" />
        
        <div class="container">
            <h1 class="text-center my-4">Lista de Horarios</h1>
            
            <c:if test="${sessionScope.usuarioLogueado.rol == 'GERENTE'}">
                <div class="admin-actions">
                    <form action="FrontController" method="post">
                        <button type="submit" name="crearInscripcion" class="btn btn-primary btn-admin">
                            <i class="fas fa-plus"></i> Crear Nueva Inscripción
                        </button>
                    </form>
                </div>
            </c:if>
            
            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>
            
            <c:if test="${empty listaHorarios}">
                <p class="info-message">No hay horarios disponibles</p>
            </c:if>

            <!-- Vista de tabla para pantallas grandes -->
            <c:if test="${not empty listaHorarios}">
                <div class="table-container">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Deporte</th>
                                <th>Entrenador</th>
                                <th>Día</th>
                                <th>Hora</th>
                                <th>Plazas Ofertadas</th>
                                <th>Plazas Ocupadas</th>
                                <c:if test="${sessionScope.usuarioLogueado.rol == 'USUARIO'}">
                                    <th>Inscribirse</th>
                                </c:if>
                                <c:if test="${sessionScope.usuarioLogueado.rol == 'GERENTE'}">
                                    <th>Eliminar Clase</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="horario" items="${requestScope.listaHorarios}">
                                <tr>
                                    <td>${horario.id}</td>
                                    <td>${horario.deporte.nombreDeporte}</td>
                                    <td>${horario.usuario.nombre} ${horario.usuario.apellido}</td>
                                    <td>${horario.diaSemana}</td>
                                    <td>${horario.hora}</td>
                                    <td>${horario.plazasOfertadas}</td>
                                    <td>${horario.plazasOcupadas}</td>
                                    <c:if test="${sessionScope.usuarioLogueado.rol == 'USUARIO'}">
                                        <td>
                                            <form action="${pageContext.request.contextPath}/Create" method="post">
                                                <input type="hidden" name="horarioId" value="${horario.id}">
                                                <input type="hidden" name="inscripcionId" value="${horario.inscripcion.id}">
                                                <c:if test="${horario.plazasOcupadas < horario.plazasOfertadas}">
                                                    <c:choose>
                                                        <c:when test="${empty horario.inscripcion}">
                                                            <button type="submit" name="confirmarInscripcion" class="btn btn-success btn-sm">
                                                                <i class="fas fa-user-plus"></i> Inscribirse
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-secondary btn-sm" disabled>
                                                                <i class="fas fa-check"></i> Ya está inscrito
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                                <c:if test="${horario.plazasOcupadas >= horario.plazasOfertadas}">
                                                    <button type="button" class="btn btn-danger btn-sm" disabled>
                                                        <i class="fas fa-times"></i> Todas las plazas ocupadas
                                                    </button>
                                                </c:if>
                                            </form>
                                        </td>
                                    </c:if>
                                    <c:if test="${sessionScope.usuarioLogueado.rol == 'GERENTE'}">
                                        <td>
                                            <form action="${pageContext.request.contextPath}/Delete" method="post">
                                                <input type="hidden" name="horarioId" value="${horario.id}">
                                                <button type="submit" name="eliminarHorario" class="btn btn-danger btn-sm">
                                                    <i class="fas fa-trash-alt"></i> Eliminar Clase
                                                </button>
                                            </form>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Vista de tarjetas para móviles -->
                <div class="card-container">
                    <c:forEach var="horario" items="${requestScope.listaHorarios}">
                        <div class="horario-card">
                            <div class="card-header">
                                <h5 class="mb-0">${horario.deporte.nombreDeporte}</h5>
                            </div>
                            <div class="card-body">
                                <div class="horario-info">
                                    <strong>ID:</strong> ${horario.id}
                                </div>
                                <div class="horario-info">
                                    <strong>Entrenador:</strong> ${horario.usuario.nombre} ${horario.usuario.apellido}
                                </div>
                                <div class="horario-info">
                                    <strong>Día:</strong> ${horario.diaSemana}
                                </div>
                                <div class="horario-info">
                                    <strong>Hora:</strong> ${horario.hora}
                                </div>
                                <div class="horario-info">
                                    <strong>Plazas:</strong> ${horario.plazasOcupadas}/${horario.plazasOfertadas}
                                </div>
                                <div class="btn-container">
                                    <c:if test="${sessionScope.usuarioLogueado.rol == 'USUARIO'}">
                                        <form action="${pageContext.request.contextPath}/Create" method="post" class="w-100">
                                            <input type="hidden" name="horarioId" value="${horario.id}">
                                            <input type="hidden" name="inscripcionId" value="${horario.inscripcion.id}">
                                            <c:if test="${horario.plazasOcupadas < horario.plazasOfertadas}">
                                                <c:choose>
                                                    <c:when test="${empty horario.inscripcion}">
                                                        <button type="submit" name="confirmarInscripcion" class="btn btn-success">
                                                            <i class="fas fa-user-plus"></i> Inscribirse
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="btn btn-secondary" disabled>
                                                            <i class="fas fa-check"></i> Ya está inscrito
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                            <c:if test="${horario.plazasOcupadas >= horario.plazasOfertadas}">
                                                <button type="button" class="btn btn-danger" disabled>
                                                    <i class="fas fa-times"></i> Todas las plazas ocupadas
                                                </button>
                                            </c:if>
                                        </form>
                                    </c:if>
                                    <c:if test="${sessionScope.usuarioLogueado.rol == 'GERENTE'}">
                                        <form action="${pageContext.request.contextPath}/Delete" method="post" class="w-100">
                                            <input type="hidden" name="horarioId" value="${horario.id}">
                                            <button type="submit" name="eliminarHorario" class="btn btn-danger">
                                                <i class="fas fa-trash-alt"></i> Eliminar Clase
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            
            <form action="FrontController" method="post">
                <button type="submit" name="inicio" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Volver
                </button>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
