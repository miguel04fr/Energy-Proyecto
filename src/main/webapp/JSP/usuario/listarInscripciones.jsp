<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Mis Inscripciones</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/INC/estilos.css" />
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <style>
            .inscripciones-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                font-family: 'Roboto', sans-serif;
            }

            .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .page-title {
                color: #2c3e50;
                font-size: 2em;
                margin: 0;
            }

            .stats-container {
                display: flex;
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                flex: 1;
                text-align: center;
            }

            .stat-number {
                font-size: 2em;
                color: #3498db;
                font-weight: bold;
                margin-bottom: 5px;
            }

            .stat-label {
                color: #7f8c8d;
                font-size: 0.9em;
            }

            .inscripcion-card {
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 20px;
                overflow: hidden;
            }

            .inscripcion-header {
                background: #3498db;
                color: white;
                padding: 15px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .deporte-titulo {
                font-size: 1.2em;
                font-weight: bold;
            }

            .fecha-badge {
                background: rgba(255,255,255,0.2);
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 0.9em;
            }

            .inscripcion-body {
                padding: 20px;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
            }

            .info-group {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            .info-label {
                color: #7f8c8d;
                font-size: 0.9em;
            }

            .info-value {
                color: #2c3e50;
                font-weight: 500;
            }

            .acciones {
                display: flex;
                gap: 10px;
                margin-top: 15px;
                padding: 15px 20px;
                background: #f8f9fa;
                border-top: 1px solid #eee;
            }

            .btn-cancelar {
                background: #e74c3c;
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 4px;
                cursor: pointer;
                transition: background 0.3s;
            }

            .btn-cancelar:hover {
                background: #c0392b;
            }

            .empty-state {
                text-align: center;
                padding: 40px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .empty-state h2 {
                color: #2c3e50;
                margin-bottom: 10px;
            }

            .empty-state p {
                color: #7f8c8d;
                margin-bottom: 20px;
            }

            @media (max-width: 768px) {
                .page-header {
                    flex-direction: column;
                    gap: 15px;
                }

                .stats-container {
                    flex-direction: column;
                }

                .inscripcion-body {
                    grid-template-columns: 1fr;
                }
                
                .acciones {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp" />
        
        <div class="inscripciones-container">
            <div class="page-header">
                <h1 class="page-title">Mis Inscripciones</h1>
                <form action="FrontController" method="post">
                    <button type="submit" name="listarDeportes" class="btn btn-admin">Nueva Inscripción</button>
                </form>
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
                <c:forEach var="inscripcion" items="${listaInscripciones}">
                    <div class="inscripcion-card">
                        <div class="inscripcion-header">
                            <span class="deporte-titulo">${inscripcion.horario.deporte.nombreDeporte}</span>
                            <span class="fecha-badge">${inscripcion.fechaInscripcion}</span>
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
                                <span class="info-value">${inscripcion.horario.entrenador.nombre} ${inscripcion.horario.entrenador.apellido}</span>
                            </div>
                        </div>
                        <div class="acciones">
                            <form action="FrontController" method="post">
                                <input type="hidden" name="inscripcionId" value="${inscripcion.id}">
                                <button type="submit" name="cancelarInscripcion" class="btn-cancelar">
                                    Cancelar Inscripción
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <form action="FrontController" method="post">
                <button type="submit" name="inicio" class="btn btn-volver">Volver</button>
            </form>
        </div>
    </body>
</html> 