<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear Cliente - Energy</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/INC/estilos.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/crearGerenteAdmin.css"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp"/>
        
        <div class="theme-toggle">
            <button id="themeToggle" class="theme-button">
                <i class="fas fa-moon"></i>
                <span>Cambiar Tema</span>
            </button>
        </div>
        
        <div class="container">
            <div class="form-container">
                <h1 class="page-title">Crear Nuevo Cliente</h1>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/Create" method="post" class="admin-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="dni"><i class="fas fa-id-card"></i> DNI</label>
                            <input type="text" id="dni" name="dni" required 
                                   pattern="[0-9]{8}[A-Z]" 
                                   value="${requestScope.usuario.dni}"
                                   title="8 números seguidos de una letra mayúscula">
                        </div>
                        <div class="form-group">
                            <label for="nombre"><i class="fas fa-user"></i> Nombre</label>
                            <input type="text" id="nombre" name="nombre" required
                                   pattern="[A-Za-záéíóúÁÉÍÓÚñÑ\s]{2,50}"
                                   value="${requestScope.usuario.nombre}"
                                   title="Solo letras y espacios, entre 2 y 50 caracteres">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="apellido"><i class="fas fa-user"></i> Apellidos</label>
                            <input type="text" id="apellido" name="apellido" required
                                   pattern="[A-Za-záéíóúÁÉÍÓÚñÑ\s]{2,100}"
                                   value="${requestScope.usuario.apellido}"
                                   title="Solo letras y espacios, entre 2 y 100 caracteres">
                        </div>
                        <div class="form-group">
                            <label for="fechaNacimiento"><i class="fas fa-calendar"></i> Fecha de Nacimiento</label>
                            <input type="date" id="fechaNacimiento" name="fechaNacimiento" required
                                   min="1950-01-01" max="2005-12-31"
                                   value="${requestScope.usuario.fechaNacimiento}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email"><i class="fas fa-envelope"></i> Email</label>
                        <input type="email" id="email" name="email" required
                               pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                               value="${requestScope.usuario.email}"
                               title="Introduce un email válido">
                    </div>

                    <div class="form-group">
                        <label for="telefono"><i class="fas fa-phone"></i> Teléfono</label>
                        <input type="tel" id="telefono" name="telefono" required 
                               pattern="[6-9][0-9]{8}" 
                               value="${requestScope.usuario.telefono}"
                               title="9 dígitos comenzando por 6, 7, 8 o 9">
                    </div>

                    <div class="form-group">
                        <label for="iban"><i class="fas fa-credit-card"></i> IBAN</label>
                        <input type="text" id="iban" name="iban" required 
                               pattern="[A-Z]{2}[0-9]{22}" 
                               value="${requestScope.usuario.iban}"
                               title="2 letras seguidas de 22 números">
                    </div>

                    <div class="form-group">
                        <label for="clave"><i class="fas fa-lock"></i> Contraseña</label>
                        <div class="password-input">
                            <input type="password" id="clave" name="clave" required
                                  >
                           
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmarClave"><i class="fas fa-lock"></i> Repita su contraseña</label>
                        <div class="password-input">
                            <input type="password" id="confirmarClave" name="confirmarClave" required
                                  >
                            
                        </div>
                        <div id="passwordError" class="error-message" style="display: none; color: #dc3545; font-size: 0.875em; margin-top: 5px;">
                            Las contraseñas no coinciden
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" name="crearCliente" class="btn-submit" id="submitButton">
                            <i class="fas fa-user-plus"></i> Crear Usuario
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Toggle password visibility
                const togglePasswordButtons = document.querySelectorAll('.toggle-password');
                const passwordInputs = document.querySelectorAll('input[type="password"]');
                
                togglePasswordButtons.forEach((button, index) => {
                    button.addEventListener('click', function() {
                        const input = passwordInputs[index];
                        const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
                        input.setAttribute('type', type);
                        this.querySelector('i').classList.toggle('fa-eye');
                        this.querySelector('i').classList.toggle('fa-eye-slash');
                    });
                });

                // Password validation
                const clave = document.getElementById('clave');
                const confirmarClave = document.getElementById('confirmarClave');
                const passwordError = document.getElementById('passwordError');
                const submitButton = document.getElementById('submitButton');

                function validatePasswords() {
                    if (clave.value !== confirmarClave.value) {
                        passwordError.style.display = 'block';
                        submitButton.disabled = true;
                        return false;
                    } else {
                        passwordError.style.display = 'none';
                        submitButton.disabled = false;
                        return true;
                    }
                }

                clave.addEventListener('input', validatePasswords);
                confirmarClave.addEventListener('input', validatePasswords);

                // Form validation
                const form = document.querySelector('.admin-form');
                const inputs = form.querySelectorAll('input[required]');
                
                inputs.forEach(input => {
                    input.addEventListener('input', function() {
                        validateInput(this);
                    });
                    
                    input.addEventListener('blur', function() {
                        validateInput(this);
                    });
                });

                function validateInput(input) {
                    const isValid = input.checkValidity();
                    input.classList.toggle('valid', isValid && input.value.length > 0);
                    input.classList.toggle('invalid', !isValid && input.value.length > 0);
                }

                // Theme toggle functionality
                const themeToggle = document.getElementById('themeToggle');
                const themeIcon = themeToggle.querySelector('i');
                const themeText = themeToggle.querySelector('span');
                
                // Check for saved theme preference
                const savedTheme = localStorage.getItem('theme');
                if (savedTheme) {
                    document.body.setAttribute('data-theme', savedTheme);
                    updateThemeButton(savedTheme);
                }

                themeToggle.addEventListener('click', function() {
                    const currentTheme = document.body.getAttribute('data-theme');
                    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
                    
                    document.body.setAttribute('data-theme', newTheme);
                    localStorage.setItem('theme', newTheme);
                    updateThemeButton(newTheme);
                });

                function updateThemeButton(theme) {
                    if (theme === 'dark') {
                        themeIcon.className = 'fas fa-sun';
                        themeText.textContent = 'Tema Claro';
                    } else {
                        themeIcon.className = 'fas fa-moon';
                        themeText.textContent = 'Tema Oscuro';
                    }
                }

                // Validar contraseñas al cargar la página
                validatePasswords();
            });
        </script>
    </body>
</html>
