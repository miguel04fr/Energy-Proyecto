<%-- 
    Document   : cabecera
    Created on : 27 ene. 2025, 16:29:58
    Author     : migue
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="contexto" value="${pageContext.request.contextPath}" scope="application"/>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<jsp:include page="metas.inc"/>
<!-- Font Awesome (que ya tienes) -->
<link rel="stylesheet" href="${contexto}/CSS/index.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css">
 
<header>
    <nav class="navbar">
        <div class="logo">
           <img src="img/Logonegro.png" alt="logo" class="logo-img" width="24px" height="24px">
            <span>Energy</span>
        </div>
        <button class="menu-toggle" id="menuToggle">
            <i class="fas fa-bars"></i>
        </button>
        <div class="nav-links">
            <form action="FrontController" method="post">
               
                <c:if test="${not empty sessionScope.usuarioLogueado}">
                    <c:if test="${sessionScope.usuarioLogueado.rol == 'USUARIO'}">
                        <button type="submit" name="inicio" value="inicio">Inicio</button>
                        <button type="submit" name="listarDeportes" value="listarDeportes">Deportes</button>
                        <button type="submit" name="listarHorarios" value="listarHorarios">Horarios</button>
                        <button type="submit" name="listarEntrenadores" value="listarEntrenadores">Entrenadores</button>
                        
                        <button type="submit" name="listarInscripciones" value="listarInscripciones">Inscripciones</button>
                    </c:if>
                    <c:if test="${sessionScope.usuarioLogueado.rol == 'ADMIN'}">
                        <button type="submit" name="inicioAdmin" value="inicioAdmin">Inicio</button>

                        <button type="submit" name="modificarSalas" value="modificarSalas">Modificar Salas</button>
                        <button type="submit" name="eliminarGerente" value="eliminarGerente">Eliminar Gerente</button>
                        <button type="submit" name="modificarDeportes" value="modificarDeportes">Modificar Deportes</button>
                        <button type="submit" name="crearGerenteAdmin" value="crearGerenteAdmin">Crear Gerente</button>
                    </c:if>
                    <c:if test="${sessionScope.usuarioLogueado.rol == 'ENTRENADOR'}">
                        <button type="submit" name="inicio" value="inicio">Inicio</button>

                        <button type="submit" name="misHorarios" value="misHorarios">Mis Horarios</button>
                        <button type="submit" name="misAlumnos" value="misAlumnos">Mis Alumnos</button>
                    </c:if>
                    <c:if test="${sessionScope.usuarioLogueado.rol == 'GERENTE'}">
                        <button type="submit" name="inicio" value="inicio">Inicio</button>

                        <button type="submit" name="listarHorarios" value="listarHorarios">Horarios</button>
                        <button type="submit" name="listarEntrenadores" value="listarEntrenadores">Entrenadores</button>
                        <button type="submit" name="modificarEntrenadores" value="modificarEntrenadores">Modificar Entrenadores</button>
                        <button type="submit" name="darAltaBaja" value="darAltaBaja">Gestion Clientes</button>
                    </c:if>
                </c:if>
            
            </form>
        </div>
        <div class="auth-buttons">
            <c:choose>
                <c:when test="${not empty sessionScope.usuarioLogueado}">
                    <div class="user-menu">
                        <span class="user-name">${sessionScope.usuarioLogueado.nombre}</span>
                        <form action="FrontController" method="post">
                            <c:if test="${sessionScope.usuarioLogueado.rol == 'ENTRENADOR'}">

   <button type="submit" name="verPerfil" value="verPerfil" class="cerrar-sesion">
                                <i class="fas fa-user-circle"></i>
                                Mi Perfil
                            </button>                            </c:if>
                            <c:if test="${sessionScope.usuarioLogueado.rol == 'USUARIO'}">

                            <button type="submit" name="verPerfil" value="verPerfil" class="cerrar-sesion">
                                <i class="fas fa-user-circle"></i>
                                Mi Perfil
                            </button>
                        </c:if>
                        </form>
                    
                        <form action="FrontController" method="post">
                    
                            <input type="hidden" name="cerrarSesion" value="cerrarSesion">
                            <button type="submit" name="cerrarSesion" value="cerrarSesion" class="cerrar-sesion">
                                <i class="fas fa-sign-out-alt"></i>
                                Cerrar Sesión
                            </button>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <button class="login-btn" data-modal="loginModal">Iniciar Sesión</button>
                    <button class="register-btn" data-modal="registerModal">Registrarse</button>
                </c:otherwise>
            </c:choose>
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle"></i> ${requestScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </div>
    </nav>
</header>

<!-- Modal de Login -->
<div id="loginModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2><i class="fas fa-sign-in-alt"></i> Acceder</h2>
            <span class="close-modal" data-modal="loginModal">&times;</span>
        </div>
        <div class="modal-body">
            <form id="loginForm" class="auth-form" method="post" action="${contexto}/Login">
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
                
                <button type="submit" class="submit-auth-btn" name="login">Acceder</button>
                <p class="mb-0"><a href="${contexto}/JSP/olvidarContrasena/olvidarContrasena.jsp">¿Olvidaste tu contraseña?</a></p>

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
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle"></i> ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <form id="registerForm" class="auth-form" action="${contexto}/Create" method="POST">
                <div class="form-row">
                    <div class="form-group">
                        <label for="registerDni"><i class="fas fa-id-card"></i> DNI</label>
                        <input type="text" id="registerDni" name="dni" value="${requestScope.usuario.dni}">
                    </div>
                    <div class="form-group">
                        <label for="registerName"><i class="fas fa-user"></i> Nombre</label>
                        <input type="text" id="registerName" name="nombre" value="${requestScope.usuario.nombre}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="registerLastName"><i class="fas fa-user"></i> Apellidos</label>
                        <input type="text" id="registerLastName" name="apellido" value="${requestScope.usuario.apellido}">
                    </div>
                    <div class="form-group">
                        <label for="registerBirthDate"><i class="fas fa-calendar"></i> Fecha de Nacimiento</label>
                        <input type="date" id="registerBirthDate" name="fechaNacimiento" value="${requestScope.usuario.fechaNacimiento}">
                    </div>
                </div>

                <div class="form-group">
                    <label for="registerEmail"><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" id="registerEmail" name="email" value="${requestScope.usuario.email}">
                </div>

                <div class="form-group">
                    <label for="registerPhone"><i class="fas fa-phone"></i> Teléfono</label>
                    <input type="tel" id="registerPhone" name="telefono" value="${requestScope.usuario.telefono}">
                </div>
                <div class="form-group">
                    <label for="registerIban"><i class="fas fa-credit-card"></i> IBAN</label>
                    <input type="tel" id="registerIban" name="iban" value="${requestScope.usuario.iban}">
                </div>

                <div class="form-group">
                    <label for="registerPassword"><i class="fas fa-lock"></i> Contraseña</label>
                    <div class="password-input">
                        <input type="password" id="registerPassword" name="clave" value=""required >
                        <button type="button" class="toggle-password"><i class="fas fa-eye"></i></button>
                    </div>
                </div>

                <div class="form-group">
                    <label for="registerPasswordConfirm"><i class="fas fa-lock"></i> Confirmar Contraseña</label>
                    <div class="password-input">
                        <input type="password" id="registerPasswordConfirm" value=""  required>
                        <button type="button" class="toggle-password"><i class="fas fa-eye"></i></button>
                    </div>
                </div>

                <div class="form-group terms">
                    <input type="checkbox" id="termsCheck"  required>
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

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Funcionalidad del menú móvil
        const menuToggle = document.getElementById('menuToggle');
        const navLinks = document.querySelector('.nav-links');
        
        menuToggle.addEventListener('click', function() {
            navLinks.classList.toggle('active');
        });
        
        // Cerrar el menú cuando se hace clic en un enlace
        const navItems = document.querySelectorAll('.nav-links a, .nav-links button');
        navItems.forEach(item => {
            item.addEventListener('click', function() {
                navLinks.classList.remove('active');
            });
        });
        
        // Funcionalidad de los modales
        const modalButtons = document.querySelectorAll('[data-modal]');
        const modals = document.querySelectorAll('.modal');
        const overlay = document.getElementById('modalOverlay');
        const closeButtons = document.querySelectorAll('.close-modal');
        const switchToRegister = document.getElementById('switchToRegister');
        const switchToLogin = document.getElementById('switchToLogin');

        function openModal(modalId) {
            const modal = document.getElementById(modalId);
            modal.classList.add('active');
            overlay.classList.add('active');
        }

        function closeModal(modalId) {
            const modal = document.getElementById(modalId);
            modal.classList.remove('active');
            overlay.classList.remove('active');
        }

        modalButtons.forEach(button => {
            button.addEventListener('click', () => {
                const modalId = button.getAttribute('data-modal');
                openModal(modalId);
            });
        });

        closeButtons.forEach(button => {
            button.addEventListener('click', () => {
                const modalId = button.getAttribute('data-modal');
                closeModal(modalId);
            });
        });

        overlay.addEventListener('click', () => {
            modals.forEach(modal => {
                modal.classList.remove('active');
            });
            overlay.classList.remove('active');
        });

        // Switch entre modales
        switchToRegister.addEventListener('click', (e) => {
            e.preventDefault();
            closeModal('loginModal');
            openModal('registerModal');
        });

        switchToLogin.addEventListener('click', (e) => {
            e.preventDefault();
            closeModal('registerModal');
            openModal('loginModal');
        });

        // Toggle password visibility
        const togglePasswordButtons = document.querySelectorAll('.toggle-password');
        togglePasswordButtons.forEach(button => {
            button.addEventListener('click', function() {
                const input = this.previousElementSibling;
                const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
                input.setAttribute('type', type);
                this.querySelector('i').classList.toggle('fa-eye');
                this.querySelector('i').classList.toggle('fa-eye-slash');
            });
        });

        // Validación del formulario de registro
        const registerForm = document.getElementById('registerForm');
        const submitButton = registerForm.querySelector('button[type="submit"]');
        const inputs = registerForm.querySelectorAll('input[type="text"], input[type="email"], input[type="tel"], input[type="password"], input[type="date"]');
        
        // Mensajes de error personalizados
        const errorMessages = {
            dni: 'El DNI debe tener 8 números seguidos de una letra mayúscula',
            nombre: 'El nombre es obligatorio y debe contener solo letras',
            apellido: 'Los apellidos son obligatorios y deben contener solo letras',
            email: 'Introduce un email válido',
            telefono: 'El teléfono debe tener 9 dígitos',
            iban: 'El IBAN debe tener el formato correcto (2 letras + 22 números)',
            password: 'La contraseña debe tener al menos 8 caracteres, una letra y un número',
            passwordConfirm: 'Las contraseñas deben coincidir',
            fechaNacimiento: 'Debes ser mayor de 18 años'
        };

        // Patrones de validación mejorados
        const patterns = {
            dni: /^[0-9]{8}[A-Z]$/,
            nombre: /^[A-Za-zÁáÉéÍíÓóÚúÑñ\s]{2,50}$/,
            apellido: /^[A-Za-zÁáÉéÍíÓóÚúÑñ\s]{2,100}$/,
            email: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
            phone: /^[6-9][0-9]{8}$/,
            iban: /^[A-Z]{2}[0-9]{22}$/,
        };

        // Función para mostrar mensaje de error
        function showError(input, message) {
            const formGroup = input.closest('.form-group');
            let errorDiv = formGroup.querySelector('.error-message');
            
            if (!errorDiv) {
                errorDiv = document.createElement('div');
                errorDiv.className = 'error-message';
                formGroup.appendChild(errorDiv);
            }
            
            errorDiv.textContent = message;
            errorDiv.style.color = 'var(--danger)';
            errorDiv.style.fontSize = '0.8rem';
            errorDiv.style.marginTop = '0.3rem';
        }

        // Función para limpiar mensaje de error
        function clearError(input) {
            const formGroup = input.closest('.form-group');
            const errorDiv = formGroup.querySelector('.error-message');
            if (errorDiv) {
                errorDiv.remove();
            }
        }

        // Función para validar un campo
        function validateField(input) {
            const value = input.value.trim();
            let isValid = true;
            let errorMessage = '';

            switch(input.id) {
                case 'registerDni':
                    isValid = patterns.dni.test(value);
                    errorMessage = errorMessages.dni;
                    break;
                case 'registerName':
                    isValid = patterns.nombre.test(value);
                    errorMessage = errorMessages.nombre;
                    break;
                case 'registerLastName':
                    isValid = patterns.apellido.test(value);
                    errorMessage = errorMessages.apellido;
                    break;
                case 'registerEmail':
                    isValid = patterns.email.test(value);
                    errorMessage = errorMessages.email;
                    break;
                case 'registerPhone':
                    isValid = patterns.phone.test(value);
                    errorMessage = errorMessages.telefono;
                    break;
                case 'registerIban':
                    isValid = patterns.iban.test(value);
                    errorMessage = errorMessages.iban;
                    break;
                case 'registerBirthDate':
                    const birthDate = new Date(value);
                    const today = new Date();
                    const age = today.getFullYear() - birthDate.getFullYear();
                    isValid = age >= 18;
                    errorMessage = errorMessages.fechaNacimiento;
                    break;
                case 'registerPassword':
                    isValid = patterns.password.test(value);
                    errorMessage = errorMessages.password;
                    break;
                case 'registerPasswordConfirm':
                    const password = document.getElementById('registerPassword').value;
                    isValid = value === password && value.length > 0;
                    errorMessage = errorMessages.passwordConfirm;
                    break;
                default:
                    isValid = value.length > 0;
            }

            input.classList.remove('valid', 'invalid');
            if (value.length > 0) {
                input.classList.add(isValid ? 'valid' : 'invalid');
                if (!isValid) {
                    showError(input, errorMessage);
                } else {
                    clearError(input);
                }
            }
            return isValid;
        }

        // Función para validar todo el formulario
        function validateForm() {
            let isValid = true;
            inputs.forEach(input => {
                if (!validateField(input)) {
                    isValid = false;
                }
            });
            
            // Validar términos y condiciones
            const termsCheck = document.getElementById('termsCheck');
            if (!termsCheck.checked) {
                isValid = false;
                showError(termsCheck, 'Debes aceptar los términos y condiciones');
            } else {
                clearError(termsCheck);
            }

            // Actualizar estado del botón
            submitButton.disabled = !isValid;
            if (isValid) {
                submitButton.type = 'submit';
                submitButton.style.cursor = 'pointer';
            } else {
                submitButton.type = 'button';
                submitButton.style.cursor = 'not-allowed';
            }
        }

        // Añadir event listeners para validación en tiempo real
        inputs.forEach(input => {
            input.addEventListener('input', () => {
                validateField(input);
                validateForm();
            });
            input.addEventListener('blur', () => {
                validateField(input);
                validateForm();
            });
        });

        // Validar términos y condiciones
        document.getElementById('termsCheck').addEventListener('change', validateForm);

        // Validación inicial
        validateForm();
    });
</script>
</div>