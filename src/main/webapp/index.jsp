<!DOCTYPE html>
   <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="es">
    <head>
    <c:set var="contexto" value="${pageContext.request.contextPath}" scope="application"/>
     <jsp:directive.page contentType="text/html" pageEncoding="UTF-8"/>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.0/sweetalert.min.js"></script>
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <c:url var="estilo" value="/CSS/inicio.css" scope="application" />
        <c:set var="contexto" value="${pageContext.request.contextPath}" scope="application"/>
    <meta charset="UTF-8">
    <title>Gestión de Deportes</title>
    <link rel="stylesheet" href="CSS/index.css">
</head>
<body>
  <jsp:include page="/INC/cabecera.jsp"/>
  <c:if test="${not empty error}">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        Swal.fire({
            title: "¡Atención!",
            text: "${error}",
            icon: "error",
            confirmButtonColor: "#3085d6",
            confirmButtonText: "Aceptar"
        });
        Swal.showLoading();
        setTimeout(() => {
            Swal.close();
        }, 3000); // Cierra el mensaje después de 3 segundos
        
    </script>
</c:if>
<c:if test="${not empty success}">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        Swal.fire({
            title: "¡Atención!",
            text: "${success}",
            icon: "success",
            confirmButtonColor: "#3085d6",
            confirmButtonText: "Aceptar"
        });
        Swal.showLoading();
        setTimeout(() => {
            Swal.close();
        }, 3000); // Cierra el mensaje después de 3 segundos
        
    </script>
</c:if>


    <div class="hero-banner">
        <div class="hero-content">
            <h1>Descubre Tu Pasión Deportiva</h1>
            <p>Únete a nuestra comunidad y disfruta de los mejores deportes</p>
            <a href="#sports-section" class="hero-btn">Explorar Deportes</a>
        </div>
    </div>

    <main>
        <form id="sportsForm" action="FrontController" method="post">
            <section class="carousel-section">
                <div class="section-header">
                    <h2>Nuestros Deportes</h2>
                    <p>Descubre todas las actividades que tenemos para ti</p>
                </div>
                <div class="carousel-container">
                    <div class="carousel">
                        <div class="carousel-item active">
                            <img src="${contexto}/img/Logonegro.png" alt="Oferta Especial" class="imagen">
                            <div class="carousel-caption">
                                <h3>¡Oferta Especial!</h3>
                                <p>3 meses de membresía por el precio de 2. ¡Aprovecha esta oportunidad única!</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="${contexto}/img/Logonegro.png" alt="Nuevas Clases" class="imagen">
                            <div class="carousel-caption">
                                <h3>Nuevas Clases</h3>
                                <p>¡Próximamente! Clases de CrossFit y Yoga Aéreo. ¡Prepárate para el cambio!</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="${contexto}/img/Logonegro.png" alt="Pack Familiar" class="imagen">
                            <div class="carousel-caption">
                                <h3>Pack Familiar</h3>
                                <p>Inscríbete con tu familia y obtén un 20% de descuento en todas las membresías.</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="${contexto}/img/Logonegro.png" alt="Nuevo Equipamiento" class="imagen">
                            <div class="carousel-caption">
                                <h3>Nuevo Equipamiento</h3>
                                <p>Hemos renovado toda nuestra sala de pesas con equipamiento de última generación.</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="${contexto}/img/Logonegro.png" alt="Programa Personalizado" class="imagen">
                            <div class="carousel-caption">
                                <h3>Programa Personalizado</h3>
                                <p>¡Nuevo! Programa de entrenamiento personalizado con seguimiento nutricional incluido.</p>
                            </div>
                        </div>
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
                            <button type="submit" class="sport-btn" data-sport="${deporte.nombreDeporte}" name="selectedSport" value="${deporte.nombreDeporte}">
                                <span>Inscribirse</span>
                                <i class="fas fa-arrow-right"></i>
                            </button>
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
            <a href="#sports-section" class="cta-btn">Inscríbete Ahora</a>
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
                    <li><a href="index.jsp"><i class="fas fa-angle-right"></i> Inicio</a></li>
                 
                </ul>
            </div>
            <div class="footer-section social">
                <h3>Síguenos</h3>
                <div class="social-links">
                    <a href="https://www.facebook.com/"><i class="fab fa-facebook-f"></i></a>
                    <a href="https://www.twitter.com/"><i class="fab fa-twitter"></i></a>
                    <a href="https://www.instagram.com/"><i class="fab fa-instagram"></i></a>
                    <a href="https://www.youtube.com/"><i class="fab fa-youtube"></i></a>
                    <a href="https://www.linkedin.com/"><i class="fab fa-linkedin-in"></i></a>
                </div>
                <div class="newsletter">
                    <h3>Suscríbete a nuestro boletín</h3>
                        <form action="FrontController" method="post">

                    <div class="newsletter-form">
                            <input type="email" placeholder="Tu email" name="emailFooter">
                            <button type="submit" name="boletinFooter"><i class="fas fa-paper-plane"></i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 Energy. Todos los derechos reservados. Diseñado con <i class="fas fa-heart"></i> para amantes del deporte.</p>
        </div>
    </footer>


    <script src="JS/index.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            let currentIndex = 0;
            const items = document.querySelectorAll('.carousel-item');
            const indicators = document.querySelectorAll('.indicator');
            
            function showSlide(index) {
                items.forEach(item => item.classList.remove('active'));
                indicators.forEach(indicator => indicator.classList.remove('active'));
                
                items[index].classList.add('active');
                indicators[index].classList.add('active');
            }
            
            function nextSlide() {
                currentIndex = (currentIndex + 1) % items.length;
                showSlide(currentIndex);
            }
            
            // Auto-rotación cada 5 segundos
            setInterval(nextSlide, 3000);
            
            // Controles manuales
            document.getElementById('prevBtn').addEventListener('click', function() {
                currentIndex = (currentIndex - 1 + items.length) % items.length;
                showSlide(currentIndex);
            });
            
            document.getElementById('nextBtn').addEventListener('click', function() {
                currentIndex = (currentIndex + 1) % items.length;
                showSlide(currentIndex);
            });
            
            // Indicadores
            indicators.forEach((indicator, index) => {
                indicator.addEventListener('click', function() {
                    currentIndex = index;
                    showSlide(currentIndex);
                });
            });
        });
    </script>
</body>
</html>

