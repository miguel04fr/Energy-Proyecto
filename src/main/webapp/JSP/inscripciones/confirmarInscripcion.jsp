<%-- 
    Document   : confirmarInscripcion
    Created on : 4 abr 2025, 9:21:51
    Author     : zapat
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="contexto" value="${pageContext.request.contextPath}" scope="application"/>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Confirmar Inscripción</title>
        <link rel="stylesheet" href="${contexto}/CSS/confirmarInscripcion.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <style>
            .no-plazas-container {
                text-align: center;
                padding: 40px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                max-width: 600px;
                margin: 40px auto;
            }
            
            .no-plazas-icon {
                font-size: 48px;
                color: #e74c3c;
                margin-bottom: 20px;
            }
            
            .no-plazas-message {
                font-size: 1.2em;
                color: #2c3e50;
                margin-bottom: 30px;
            }
            
            .btn-volver {
                display: inline-block;
                padding: 12px 25px;
                background-color: #2c3e50;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                border: none;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.3s;
            }
            
            .btn-volver:hover {
                background-color: #34495e;
            }

            .horarios-container {
                max-width: 1000px;
                margin: 0 auto;
                padding: 20px;
            }

            .dia-section {
                margin-bottom: 30px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .dia-titulo {
                background: #3498db;
                color: white;
                margin: 0;
                padding: 15px 20px;
                font-size: 1.2em;
            }

            .horarios-tabla {
                padding: 15px;
            }

            .tabla-header {
                display: grid;
                grid-template-columns: 100px 80px 80px 1fr 80px;
                gap: 10px;
                padding: 10px;
                background: #f8f9fa;
                border-radius: 4px;
                margin-bottom: 5px;
                font-weight: bold;
                color: #2c3e50;
            }

            .tabla-fila {
                display: grid;
                grid-template-columns: 100px 80px 80px 1fr 80px;
                gap: 10px;
                padding: 10px;
                align-items: center;
                border-bottom: 1px solid #eee;
            }

            .tabla-fila:hover {
                background: #f8f9fa;
            }

            .col-hora {
                color: #e74c3c;
                font-weight: 500;
            }

            .col-plazas {
                text-align: center;
            }

            .inscribirse-btn {
                background: #2ecc71;
                color: white;
                border: none;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                cursor: pointer;
                transition: all 0.3s;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto;
            }

            .inscribirse-btn:hover {
                background: #27ae60;
                transform: scale(1.1);
            }

            .inscribirse-btn i {
                font-size: 1em;
            }

            @media (max-width: 768px) {
                .tabla-header, .tabla-fila {
                    grid-template-columns: 80px 60px 60px 1fr 60px;
                    font-size: 0.9em;
                }
                
                .col-entrenador {
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp"/>
        <div id="loginNotification" class="notification" data-logged-in="${not empty sessionScope.usuarioLogueado}">
            <i class="fas fa-exclamation-circle"></i>
            <span>Debes iniciar sesión para inscribirte</span>
        </div>
        <div class="container">
            <c:if test="${empty listaHorarios}">
                <div class="no-plazas-container">
                    <div class="no-plazas-icon">
                        <i class="fas fa-calendar-times"></i>
                    </div>
                    <h2>No hay plazas disponibles</h2>
                    <p class="no-plazas-message">
                        Lo sentimos, actualmente no hay horarios disponibles para ${deporte.nombreDeporte}. 
                        Por favor, intenta de nuevo más tarde o consulta otros deportes.
                    </p>
                    <form action="FrontController" method="post">
                        <button type="submit" name="inicio" class="btn-volver">Volver</button>
                    </form>
                </div>
            </c:if>
            
            <c:if test="${not empty listaHorarios}">
                <div class="header">
                    <h1>Horarios Disponibles para ${deporte.nombreDeporte}</h1>
                </div>

                <div class="horarios-container">
                    <c:set var="diaActual" value="" />
                    <c:forEach var="horario" items="${listaHorarios}">
                        <c:if test="${horario.diaSemana != diaActual}">
                            <c:set var="diaActual" value="${horario.diaSemana}" />
                            <div class="dia-section">
                                <h2 class="dia-titulo">${horario.diaSemana}</h2>
                                <div class="horarios-tabla">
                                    <div class="tabla-header">
                                        <div class="col-hora">Hora</div>
                                        <div class="col-sala">Sala</div>
                                        <div class="col-plazas">Plazas</div>
                                        <div class="col-entrenador">Entrenador</div>
                                        <div class="col-accion">Acción</div>
                                    </div>
                        </c:if>
                                    <div class="tabla-fila">
                                        <div class="col-hora">${horario.hora}</div>
                                        <div class="col-sala">${horario.salaId}</div>
                                        <div class="col-plazas">${horario.plazasOfertadas}</div>
                                        <div class="col-entrenador">${horario.usuario.nombre} ${horario.usuario.apellido}</div>
                                        <div class="col-accion">
                                            <form action="Create" method="post" class="inscripcion-form">
                                                <input type="hidden" name="usuarioId" value="${sessionScope.usuarioLogueado.id}">
                                                <input type="hidden" name="horarioId" value="${horario.id}">
                                                <button type="submit" name="confirmarInscripcion" class="inscribirse-btn">
                                                    <i class="fas fa-check"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                        <c:if test="${horario.diaSemana != diaActual}">
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </c:if>
        </div>
        
    <!-- Modal de Login -->
    <div id="loginModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2><i class="fas fa-sign-in-alt"></i> Acceder</h2>
                <span class="close-modal" data-modal="loginModal">&times;</span>
            </div>
            <div class="modal-body">
                <form id="loginForm" class="auth-form" method="post" action="Login">
                    <div class="form-group">
                        <label for="loginEmail"><i class="fas fa-envelope"></i> Email</label>
                        <input type="email" id="loginEmail" placeholder="tu@email.com" name="email">
                    </div>
                    <div class="form-group">
                        <label for="loginPassword"><i class="fas fa-lock"></i> Contraseña</label>
                        <div class="password-input">
                            <input type="password" id="loginPassword" placeholder="Tu contraseña" name="password">
                            <button type="button" class="toggle-password"><i class="fas fa-eye"></i></button>
                        </div>
                    </div>
                    <div class="form-group remember-forgot">
                        <div class="remember-me">
                            <input type="checkbox" id="rememberMe">
                            <label for="rememberMe">Recordarme</label>
                        </div>
                        <a href="#" class="forgot-password">¿Olvidaste tu contraseña?</a>
                    </div>
                    <button type="submit" class="submit-auth-btn" name="login">Acceder</button>
                    <div class="social-login">
                        <p>O accede con</p>
                        <div class="social-buttons">
                            <button type="button" class="social-btn google"><i class="fab fa-google"></i> Google</button>
                            <button type="button" class="social-btn facebook"><i class="fab fa-facebook-f"></i> Facebook</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <p>¿No tienes cuenta? <a href="#" id="switchToRegister">Regístrate aquí</a></p>
            </div>
        </div>
    </div>

    <!-- Modal de Registro -->
    <div id="registerModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2><i class="fas fa-user-plus"></i> Crear Cuenta</h2>
                <span class="close-modal" data-modal="registerModal">&times;</span>
            </div>
            <div class="modal-body">
                <form id="registerForm" class="auth-form" action="${contexto}/Create" method="POST" > 
                    <div class="form-row">
                        <div class="form-group">
                            <label for="registerDni"><i class="fas fa-id-card"></i> DNI</label>
                            <input type="text" id="registerDni" name="dni" value="12344678X" >
                        </div>
                        <div class="form-group">
                            <label for="registerName"><i class="fas fa-user"></i> Nombre</label>
                            <input type="text" id="registerName" name="nombre" value="Juan" >
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="registerLastName"><i class="fas fa-user"></i> Apellidos</label>
                            <input type="text" id="registerLastName" name="apellido" value="Pérez López" >
                        </div>
                        <div class="form-group">
                            <label for="registerBirthDate"><i class="fas fa-calendar"></i> Fecha de Nacimiento</label>
                            <input type="date" id="registerBirthDate" name="fechaNacimiento" value="2000-01-01" >
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="registerEmail"><i class="fas fa-envelope"></i> Email</label>
                        <input type="email" id="registerEmail" name="email" value="b@gmail.com" >
                    </div>

                    <div class="form-group">
                        <label for="registerPhone"><i class="fas fa-phone"></i> Teléfono</label>
                        <input type="tel" id="registerPhone" name="telefono" value="123256789">
                    </div>

                    <div class="form-group">
                        <label for="registerAvatar"><i class="fas fa-image"></i> Foto de Perfil</label>
                        <input type="file" id="registerAvatar" name="avatar" accept="image/*">
                    </div>

                    <div class="form-group">
                        <label for="registerPassword"><i class="fas fa-lock"></i> Contraseña</label>
                        <div class="password-input">
                            <input type="password" id="registerPassword" name="clave" value="b" >
                            <button type="button" class="toggle-password"><i class="fas fa-eye"></i></button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="registerPasswordConfirm"><i class="fas fa-lock"></i> Confirmar Contraseña</label>
                        <div class="password-input">
                            <input type="password" id="registerPasswordConfirm" value="b" >
                            <button type="button" class="toggle-password"><i class="fas fa-eye"></i></button>
                        </div>
                    </div>

                    <div class="form-group terms">
                        <input type="checkbox" id="termsCheck" checked required>
                        <label for="termsCheck">Acepto los <a href="#">Términos y Condiciones</a> y la <a href="#">Política de Privacidad</a></label>
                    </div>

                    <button type="submit" class="submit-auth-btn" name="registrase" value="regisrto">Crear Cuenta</button>
                </form>

            </div>
            <div class="modal-footer">
                <p>¿Ya tienes cuenta? <a href="#" id="switchToLogin">Accede aquí</a></p>
            </div>
        </div>
    </div>

    <!-- Overlay para los modales -->
    <div id="modalOverlay"></div>
        <script src="${contexto}/JS/crearInscripcion.js" defer=""></script>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const forms = document.querySelectorAll('.inscripcion-form');
                const notification = document.getElementById('loginNotification');
                const usuarioLogueado = notification.dataset.loggedIn === 'true';
                
                forms.forEach(form => {
                    form.addEventListener('submit', function(e) {
                        if (!usuarioLogueado) {
                            e.preventDefault();
                            notification.classList.add('show');
                            setTimeout(() => {
                                notification.classList.remove('show');
                            }, 3000);
                        }
                    });
                });
            });
        </script>
    </body>
</html> 