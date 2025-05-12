<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Lista de Deportes</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/INC/estilos.css" />
        <style>
            .deportes-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 25px;
                padding: 20px;
                max-width: 1200px;
                margin: 0 auto;
            }
            
            .deporte-card {
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                overflow: hidden;
                transition: transform 0.3s;
                display: flex;
                flex-direction: column;
                height: 100%;
            }
            
            .deporte-card:hover {
                transform: translateY(-5px);
            }
            
            .deporte-imagen {
                width: 100%;
                height: 180px;
                object-fit: cover;
            }
            
            .deporte-contenido {
                padding: 15px;
                flex-grow: 1;
                display: flex;
                flex-direction: column;
            }
            
            .deporte-nombre {
                color: #2c3e50;
                font-size: 1.3em;
                margin-bottom: 10px;
                text-align: center;
            }
            
            .deporte-acciones {
                margin-top: auto;
                padding-top: 15px;
                text-align: center;
            }
            
            .btn-inscribirse {
                background-color: #27ae60;
                color: white;
                padding: 10px 20px;
                border-radius: 4px;
                text-decoration: none;
                transition: all 0.3s;
                border: none;
                cursor: pointer;
                font-weight: bold;
                display: inline-block;
                width: 100%;
                text-align: center;
            }
            
            .btn-inscribirse:hover {
                background-color: #219a52;
                transform: scale(1.02);
            }
            
            @media (max-width: 768px) {
                .deportes-grid {
                    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                    gap: 15px;
                    padding: 10px;
                }
                
                .deporte-imagen {
                    height: 150px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp" />
        
        <div class="container">
            <h1>Deportes Disponibles</h1>
            
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            
            <c:if test="${empty listaDeportes}">
                <p class="info-message">No hay deportes disponibles</p>
            </c:if>
            
            <c:if test="${not empty listaDeportes}">
                <div class="deportes-grid">
                    <c:forEach var="deporte" items="${listaDeportes}">
                        <div class="deporte-card">
                            <img src="${pageContext.request.contextPath}/img/${deporte.nombreDeporte}.jpg" 
                                 alt="${deporte.nombreDeporte}" 
                                 class="deporte-imagen"
                                 onerror="this.src='${pageContext.request.contextPath}/img/deporte_default.jpg'">
                            <div class="deporte-contenido">
                                <h2 class="deporte-nombre">${deporte.nombreDeporte}</h2>
                                <div class="deporte-acciones">
                                    <form action="FrontController" method="post">
                                        <input type="hidden" name="selectedSport" value="${deporte.nombreDeporte}">
                                        <button type="submit" name="confirmarInscripcion" class="btn-inscribirse">
                                            Inscribirse
                                        </button>
                                    </form>
                                </div>
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