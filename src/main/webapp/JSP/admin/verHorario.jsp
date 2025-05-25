<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Configurar las cookies de seguridad
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            cookie.setSecure(true);
            cookie.setHttpOnly(true);
            cookie.setPath("/");
            response.addCookie(cookie);
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://cdnjs.cloudflare.com; style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://cdnjs.cloudflare.com;">
        <title>Ver Horarios</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/INC/estilos.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .accordion-button:not(.collapsed) {
                background-color: #e7f1ff;
                color: #0c63e4;
            }

            .accordion-button:focus {
                box-shadow: none;
                border-color: rgba(0,0,0,.125);
            }

            .horario-item {
                border-left: 4px solid #0d6efd;
                margin-bottom: 10px;
                padding: 10px;
                background-color: #f8f9fa;
                border-radius: 4px;
            }

            .horario-item:hover {
                background-color: #e9ecef;
            }

            .horario-info {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                margin-bottom: 10px;
            }

            .horario-info span {
                display: inline-block;
                min-width: 150px;
            }

            .horario-info strong {
                color: #495057;
            }

            .btn-container {
                display: flex;
                gap: 5px;
                flex-wrap: wrap;
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

            @media screen and (max-width: 480px) {
                .container {
                    margin-top: 114px !important;
                }
            }

            .loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(255, 255, 255, 0.8);
                display: none;
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            .loading-spinner {
                width: 50px;
                height: 50px;
                border: 5px solid #f3f3f3;
                border-top: 5px solid #3498db;
                border-radius: 50%;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }

            .btn:disabled {
                cursor: not-allowed;
                opacity: 0.7;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp" />

        <div class="container">
            <h1 class="text-center my-4">Lista de Horarios</h1>

            <c:if test="${sessionScope.usuarioLogueado.rol == 'GERENTE'}">
                <div class="admin-actions mb-4">
                    <form action="FrontController" method="post">
                        <input type="hidden" name="crearInscripcion" value="true">
                        <button type="submit" name="crearInscripcion" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Crear Nueva Clase
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

            <c:if test="${not empty listaHorarios}">
                <div class="accordion" id="horariosAccordion">
                    <c:set var="diasSemana" value="Lunes,Martes,Miércoles,Jueves,Viernes,Sábado,Domingo" />
                    <c:forTokens items="${diasSemana}" delims="," var="dia">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                        data-bs-target="#collapse${dia}" aria-expanded="false" aria-controls="collapse${dia}">
                                    ${dia}
                                </button>
                            </h2>
                            <div id="collapse${dia}" class="accordion-collapse collapse" data-bs-parent="#horariosAccordion">
                                <div class="accordion-body">
                                    <c:forEach var="horario" items="${requestScope.listaHorarios}">
                                        <c:if test="${horario.diaSemana == dia}">
                                            <div class="horario-item">
                                                <div class="horario-info">
                                                    <span><strong>Deporte:</strong> ${horario.deporte.nombreDeporte}</span>
                                                    <span><strong>Entrenador:</strong> ${horario.usuario.nombre} ${horario.usuario.apellido}</span>
                                                    <span><strong>Dia:</strong> ${horario.diaSemana}</span>
                                                    <span><strong>Hora:</strong> ${horario.hora}</span>
                                                    <span><strong>Plazas:</strong> ${horario.plazasOcupadas}/${horario.plazasOfertadas}</span>
                                                    <span><strong>Sala:</strong> ${horario.salaId}</span>
                                                </div>
                                                <div class="btn-container">
                                                    <c:if test="${sessionScope.usuarioLogueado.rol == 'USUARIO'}">
                                                    <c:if test="${sessionScope.usuarioLogueado.activo == true}">
                                                    <c:if test="${sessionScope.usuarioLogueado.numeroInscripcion <= 15}">
                                                    
                                                    <c:if test="${horario.tieneClaseEnMismoHorario}">
                                                        <form action="${pageContext.request.contextPath}/FrontController" method="post">
                                                            <button type="submit" class="btn btn-danger btn-sm" name="listarInscripciones" >
                                                                <i class="fas fa-times"></i> Ya tiene una clase a esta hora  o ya estas incrito(consultar inscripciones)
                                                            </button>
                                                        </form>
                                                    
                                                    </c:if>
                                                    
                                                    <c:if test="${not horario.tieneClaseEnMismoHorario}">
                                                        <c:if test="${horario.plazasOcupadas < horario.plazasOfertadas}">
                                                            <c:choose>
                                                                <c:when test="${empty horario.inscripcion}">
                                                                    <form action="${pageContext.request.contextPath}/Create" method="post">
                                                                        <input type="hidden" name="horarioId" value="${horario.id}">
                                                                        <input type="hidden" name="inscripcionId" value="${horario.inscripcion.id}">
                                                                        <button type="submit" class="btn btn-success btn-sm" name="confirmarInscripcion" value="inscripcion">
                                                                            <i class="fas fa-user-plus"></i> Inscribirse
                                                                        </button>
                                                                    </form>
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
                                                    </c:if>
                                                    
                                                    </c:if>
                                                    <c:if test="${sessionScope.usuarioLogueado.numeroInscripcion > 15}">
                                                        <button type="button" class="btn btn-danger btn-sm">
                                                            <i class="fas fa-times"></i> No puede inscribirse a más de 16 clases
                                                        </button>
                                                    </c:if>
                                                    </c:if>
                                                    <c:if test="${sessionScope.usuarioLogueado.activo == false}">
                                                        <button type="button" class="btn btn-secondary btn-sm" disabled>
                                                            <i class="fas fa-times"></i> Usuario inactivo pendiente de aprobación por pago
                                                        </button>
                                                    </c:if>
                                                    </c:if>
                                                
                                                    <c:if test="${sessionScope.usuarioLogueado.rol == 'GERENTE'}">
                                                        <form action="${pageContext.request.contextPath}/Delete" method="post">
                                                            <input type="hidden" name="horarioId" value="${horario.id}">
                                                            <button type="submit" name="eliminarHorario" class="btn btn-danger btn-sm" value="eliminarHorario">
                                                                <i class="fas fa-trash-alt"></i> Eliminar Clase
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:forTokens>
                </div>
            </c:if>

            <div class="mt-4">
                <form action="FrontController" method="post">
                    <button type="submit" name="inicio" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Volver
                    </button>
                </form>
            </div>
        </div>

        <div class="loading-overlay" id="loadingOverlay">
            <div class="loading-spinner"></div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const loadingOverlay = document.getElementById('loadingOverlay');
                const forms = document.querySelectorAll('form');

                // Función para limpiar cookies inválidas
                function cleanInvalidCookies() {
                    document.cookie.split(";").forEach(function (c) {
                        document.cookie = c.replace(/^ +/, "").replace(/=.*/, "=;expires=" + new Date().toUTCString() + ";path=/");
                    });
                }

                // Limpiar cookies inválidas al cargar la página
                cleanInvalidCookies();

                // Función para mostrar el overlay de carga
                function showLoading() {
                    loadingOverlay.style.display = 'flex';

                }

                // Función para ocultar el overlay de carga
                function hideLoading() {
                    loadingOverlay.style.display = 'none';

                }

                // Agregar evento submit a todos los formularios
                forms.forEach(form => {
                    form.addEventListener('submit', function (e) {
                        // No prevenir el envío del formulario
                        showLoading();
                        cleanInvalidCookies();
                        // Permitir que el formulario se envíe normalmente
                        return true;
                    });
                });

                // Manejar errores de red
                window.addEventListener('error', function (e) {
                    if (e.target.tagName === 'IMG' || e.target.tagName === 'SCRIPT') {
                        hideLoading();
                    }
                });

                // Manejar cuando la página termina de cargar
                window.addEventListener('load', function () {
                    hideLoading();
                    cleanInvalidCookies();
                });

                // Manejar cuando el usuario intenta navegar fuera de la página
                window.addEventListener('beforeunload', function () {
                    showLoading();
                });
            });
        </script>
    </body>
</html>
