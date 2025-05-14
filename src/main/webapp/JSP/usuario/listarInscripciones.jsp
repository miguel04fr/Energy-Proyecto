<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Mis Inscripciones</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/INC/estilos.css" />
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <style>
            .inscripciones-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 15px;
                font-family: 'Roboto', sans-serif;
                margin-top: 100px;
            }

            .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .page-title {
                color: #2c3e50;
                font-size: 1.5em;
                margin: 0;
            }

            .stats-container {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
            }

            .stat-card {
                background: white;
                padding: 15px;
                border-radius: 6px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                flex: 1;
                text-align: center;
            }

            .stat-number {
                font-size: 1.5em;
                color: #3498db;
                font-weight: bold;
                margin-bottom: 2px;
            }

            .stat-label {
                color: #7f8c8d;
                font-size: 0.8em;
            }

            .inscripciones-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 12px;
                margin-bottom: 20px;
            }

            .inscripcion-card {
                background: white;
                border-radius: 6px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                overflow: hidden;
                transition: transform 0.2s;
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .inscripcion-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 2px 5px rgba(0,0,0,0.15);
            }

            .inscripcion-header {
                background: #3498db;
                color: white;
                padding: 8px 12px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-shrink: 0;
            }

            .deporte-titulo {
                font-size: 1em;
                font-weight: bold;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .fecha-badge {
                background: rgba(255,255,255,0.2);
                padding: 2px 6px;
                border-radius: 10px;
                font-size: 0.75em;
                white-space: nowrap;
            }

            .inscripcion-body {
                padding: 10px 12px;
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 8px;
                flex-grow: 1;
            }

            .info-group {
                display: flex;
                flex-direction: column;
                gap: 1px;
            }

            .info-label {
                color: #7f8c8d;
                font-size: 0.7em;
                text-transform: uppercase;
            }

            .info-value {
                color: #2c3e50;
                font-weight: 500;
                font-size: 0.85em;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .acciones {
                padding: 8px 12px;
                background: #f8f9fa;
                border-top: 1px solid #eee;
                flex-shrink: 0;
            }

            .btn-cancelar {
                background: #e74c3c;
                color: white;
                border: none;
                padding: 5px 10px;
                border-radius: 4px;
                cursor: pointer;
                transition: background 0.3s;
                font-size: 0.8em;
                width: 100%;
            }

            .btn-cancelar:hover {
                background: #c0392b;
            }

            .empty-state {
                text-align: center;
                padding: 30px;
                background: white;
                border-radius: 6px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }

            .empty-state h2 {
                color: #2c3e50;
                margin-bottom: 8px;
                font-size: 1.3em;
            }

            .empty-state p {
                color: #7f8c8d;
                margin-bottom: 15px;
                font-size: 0.9em;
            }

            .btn-admin {
                padding: 8px 15px;
                font-size: 0.9em;
            }

            .btn-volver {
                margin-top: 15px;
                padding: 8px 15px;
                font-size: 0.9em;
            }

            @media (min-width: 1200px) {
                .inscripciones-grid {
                    grid-template-columns: repeat(6, 1fr);
                }
            }

            @media (min-width: 992px) and (max-width: 1199px) {
                .inscripciones-grid {
                    grid-template-columns: repeat(4, 1fr);
                }
            }

            @media (min-width: 768px) and (max-width: 991px) {
                .inscripciones-grid {
                    grid-template-columns: repeat(3, 1fr);
                }
            }

            @media (min-width: 576px) and (max-width: 767px) {
                .inscripciones-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (max-width: 575px) {
                .inscripciones-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp" />
        
        <div class="inscripciones-container">
            <div class="page-header">
                <h1 class="page-title">Mis Inscripciones</h1>
               
            </div>

            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-number">${listaInscripciones.size()}</div>
                    <div class="stat-label">Total Inscripciones</div>
                </div>
            </div>
            
            <c:if test="${empty listaInscripciones}">
                <div class="empty-state">
                    <h2>No tienes inscripciones</h2>
                    <p>Aún no te has inscrito en ninguna actividad. ¡Explora nuestros horarios y encuentra la actividad perfecta para ti!</p>
                    <form action="FrontController" method="post">
                        <button type="submit" name="listarDeportes" class="btn btn-admin">Ver Actividades</button>
                    </form>
                </div>
            </c:if>

            <c:if test="${not empty listaInscripciones}">
                <div class="inscripciones-grid">
                    <c:forEach var="inscripcion" items="${listaInscripciones}">
                        <div class="inscripcion-card">
                            <div class="inscripcion-header">
                                <span class="deporte-titulo">${inscripcion.horario.deporte.nombreDeporte}</span>
                                <span class="fecha-badge"><fmt:formatDate value="${inscripcion.fechaInscripcion}" pattern="dd/MM/yyyy"/></span>
                            </div>
                            <div class="inscripcion-body">
                                <div class="info-group">
                                    <span class="info-label">Día</span>
                                    <span class="info-value">${inscripcion.horario.diaSemana}</span>
                                </div>
                                <div class="info-group">
                                    <span class="info-label">Hora</span>
                                    <span class="info-value">${inscripcion.horario.hora}</span>
                                </div>
                                <div class="info-group">
                                    <span class="info-label">Sala</span>
                                    <span class="info-value">${inscripcion.horario.salaId}</span>
                                </div>
                                <div class="info-group">
                                    <span class="info-label">Entrenador</span>
                                    <span class="info-value">${inscripcion.usuario.nombre} ${inscripcion.usuario.apellido}</span>
                                </div>
                            </div>
                            <div class="acciones">
                                <form action="Delete" method="post">
                                    <input type="hidden" name="horarioId" value="${inscripcion.horario.id}">
                                    <input type="hidden" name="inscripcionId" value="${inscripcion.id}">
                                    <button type="submit" name="cancelarInscripcion" class="btn-cancelar">
                                        Cancelar Inscripción
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <form action="FrontController" method="post">
                <button type="submit" name="inicio" class="btn btn-volver">Volver</button>
            </form>
        </div>
    </body>
</html> 