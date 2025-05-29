<!DOCTYPE html>
   <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="es">
    <head>
    <c:set var="contexto" value="${pageContext.request.contextPath}" scope="application"/>
     <jsp:directive.page contentType="text/html" pageEncoding="UTF-8"/>
     
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <c:url var="estilo" value="/CSS/inicio.css" scope="application" />
        <c:set var="contexto" value="${pageContext.request.contextPath}" scope="application"/>
    <meta charset="UTF-8">
    <title>Gestión de Deportes</title>
    <link rel="stylesheet" href="CSS/index.css">
</head>
<body>
  <jsp:include page="/INC/cabecera.jsp"/>

 

    <main>
        <form id="sportsForm" action="FrontController" method="post">
            <section class="carousel-section">
                <div class="section-header">
                    <h2>Nuestros Deportes</h2>
                    <p>Descubre todas las actividades que tenemos para ti</p>
                </div>
                <div class="carousel-container">
                    <div class="carousel">
                        <c:forEach var="deporte" items="${listaDeportes}" varStatus="status">
                            <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                <img src="${contexto}/img/Logonegro.png" alt="Programa Personalizado" class="imagen">
                            <div class="carousel-caption">
                                <h3>Programa Personalizado</h3>
                                <p>¡Nuevo! Programa de entrenamiento personalizado con seguimiento nutricional incluido.</p>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                    <button type="button" class="carousel-control prev" id="prevBtn"><i class="fas fa-chevron-left"></i></button>
                    <button type="button" class="carousel-control next" id="nextBtn"><i class="fas fa-chevron-right"></i></button>
                    <div class="carousel-indicators">
                        <span class="indicator active" data-index="0"></span>
                        <span class="indicator" data-index="1"></span>
                        <span class="indicator" data-index="2"></span>
                        <span class="indicator" data-index="3"></span>
                        <span class="indicator" data-index="4"></span>
                        <span class="indicator" data-index="5"></span>
                        <span class="indicator" data-index="6"></span>
                        <span class="indicator" data-index="7"></span>
                        <span class="indicator" data-index="8"></span>
                        <span class="indicator" data-index="9"></span>
                    </div>
                </div>
            </section>

            <section id="sports-section" class="sports-grid">
                <div class="section-header">
                    <h2>Elige tu Deporte</h2>
                    <p>Inscríbete en la actividad que más te apasione</p>
                </div>
                <div class="sports-container">
                    <c:forEach var="deporte" items="${listaDeportes}">
                    <div class="sport-card">
                        <div class="card-image">
                            <img src="img/Logonegro.png" alt="${deporte.nombreDeporte}" class="imagen" style="width: 100%; height: 100%; object-fit: contain; display: block;">
                            <div class="card-overlay">
                                <i class="fas fa-futbol"></i>
                            </div>
                        </div>
                        <div class="card-content">
                            <h3>${deporte.nombreDeporte}</h3>
                            <p>${deporte.descripcion}</p>
                          
                        </div>
                    </div>
                    </c:forEach>
                  
                </div>

             
            </section>
        </form> 
    </main>

    <section class="cta-section">
        <div class="cta-content">
            <h2>¿Listo para comenzar?</h2>
            <p>Únete a nuestra comunidad deportiva y transforma tu vida</p>
           
        </div>
    </section>

    <footer>
        <div class="footer-content">
            <div class="footer-section about">
                <div class="logo-footer">
                    <i class="fas fa-running"></i>
                    <h3>Energy</h3>
                </div>
                <p>Tu plataforma de gestión deportiva para descubrir, aprender y disfrutar de los mejores deportes con profesionales cualificados.</p>
                <div class="contact">
                    <p><i class="fas fa-map-marker-alt"></i> Av. del Deporte 123, Madrid</p>
                    <p><i class="fas fa-phone"></i> +34 123 456 789</p>
                    <p><i class="fas fa-envelope"></i> info@energy.com</p>
                </div>
            </div>
            <div class="footer-section links">
                <h3>Enlaces Rápidos</h3>
                <ul>
                    <li><a href="#"><i class="fas fa-angle-right"></i> Inicio</a></li>
                    <li><a href="#"><i class="fas fa-angle-right"></i> Deportes</a></li>
                    <li><a href="#"><i class="fas fa-angle-right"></i> Inscripciones</a></li>
                    <li><a href="#"><i class="fas fa-angle-right"></i> Eventos</a></li>
                    <li><a href="#"><i class="fas fa-angle-right"></i> Contacto</a></li>
                </ul>
            </div>
            <div class="footer-section social">
                <h3>Síguenos</h3>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
                <div class="newsletter">
                    <h3>Suscríbete a nuestro boletín</h3>
                    <div class="newsletter-form">
                        <input type="email" placeholder="Tu email">
                        <button type="button"><i class="fas fa-paper-plane"></i></button>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 Energy. Todos los derechos reservados. Diseñado con <i class="fas fa-heart"></i> para amantes del deporte.</p>
        </div>
    </footer>


    <script src="JS/index.js"></script>
</body>
</html>

