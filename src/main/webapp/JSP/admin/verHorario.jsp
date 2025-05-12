<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Ver Horarios</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/INC/estilos.css" />
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp" />
        
        <div class="container">
            <h1>Lista de Horarios</h1>
            
            <c:if test="${sessionScope.usuarioLogueado.rol == 'GERENTE'}">
                <div class="admin-actions">
                    <form action="FrontController" method="post">
                        <button type="submit" name="crearInscripcion" class="btn btn-admin">
                            Crear Nueva Inscripción
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
                <div class="table-container">
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Deporte</th>
                            <th>Entrenador</th>
                            <th>Día</th>
                            <th>Hora</th>
                            <th>Plazas Ofertadas</th>
                            <c:if test="${sessionScope.usuarioLogueado.rol == 'USUARIO'}">
                                <th>Inscribirse</th>
                            </c:if>
                            <c:if test="${sessionScope.usuarioLogueado.rol == 'GERENTE'}">
                                <th>Eliminar Clase</th>
                            </c:if>
                        </tr>
                        <c:forEach var="horario" items="${requestScope.listaHorarios}">
                            <tr>
                                <td>${horario.id}</td>
                                <td>${horario.deporte.nombreDeporte}</td>
                                <td>${horario.usuario.nombre} ${horario.usuario.apellido}</td>
                                <td>${horario.diaSemana}</td>
                                <td>${horario.hora}</td>
                                <td>${horario.plazasOfertadas}</td>
                                <c:if test="${sessionScope.usuarioLogueado.rol == 'USUARIO'}">
                                    <td>
                                        <form action="${pageContext.request.contextPath}/Create" method="post">
                                            <input type="hidden" name="horarioId" value="${horario.id}">
                                            <button type="submit" name="confirmarInscripcion" class="btn btn-ver">Inscribirse</button>
                                        </form>
                                    </td>
                                </c:if>
                                <c:if test="${sessionScope.usuarioLogueado.rol == 'GERENTE'}">
                                    <td>
                                        <form action="${pageContext.request.contextPath}/Delete" method="post">
                                            <input type="hidden" name="horarioId" value="${horario.id}">
                                            <button type="submit" name="eliminarHorario" class="btn btn-ver">Eliminar Clase</button>
                                        </form>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </c:if>
            
            <form action="FrontController" method="post">
                <button type="submit" name="inicio" class="btn btn-volver">Volver</button>
            </form>
        </div>
    </body>
</html>
