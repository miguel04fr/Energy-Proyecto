<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mi Perfil - Energy</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/perfil.css">
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp"/>
        
        <div class="container">
            <div class="profile-container">
                <h1><i class="fas fa-user-circle"></i> Mi Perfil</h1>
                
                <c:if test="${not empty requestScope.mensaje}">
                    <div class="alert ${requestScope.tipoMensaje}">
                        <i class="fas ${requestScope.tipoMensaje == 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i>
                        ${requestScope.mensaje}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/Update" method="POST" class="profile-form">
                    <input type="hidden" name="id" value="${sessionScope.usuarioLogueado.id}">
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="dni"><i class="fas fa-id-card"></i> DNI</label>
                            <input type="text" id="dni" name="dni" placeholder="12345678A" pattern="[0-9]{8}[A-Z]" value="${sessionScope.usuarioLogueado.dni}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="nombre"><i class="fas fa-user"></i> Nombre</label>
                            <input type="text" id="nombre" name="nombre" placeholder="Nombre" title="Solo letras y espacios, entre 2 y 50 caracteres" pattern="[A-Za-záéíóúÁÉÍÓÚñÑ\s]{2,50}" value="${sessionScope.usuarioLogueado.nombre}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="apellido"><i class="fas fa-user"></i> Apellidos</label>
                            <input type="text" id="apellido" name="apellido" placeholder="Apellidos" title="Solo letras y espacios, entre 2 y 100 caracteres" pattern="[A-Za-záéíóúÁÉÍÓÚñÑ\s]{2,100}" value="${sessionScope.usuarioLogueado.apellido}" required>
                        </div>
                        <div class="form-group">
                            <label for="fechaNacimiento"><i class="fas fa-calendar"></i> Fecha de Nacimiento</label>
                            <input type="date" id="fechaNacimiento" name="fechaNacimiento" title="Fecha de nacimiento" placeholder="dd/mm/yyyy" min="1950-01-01" max="2005-12-31" value="${sessionScope.usuarioLogueado.fechaNacimiento}" readonly>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email"><i class="fas fa-envelope"></i> Email</label>
                        <input type="email" id="email" name="email" placeholder="email@email.com" title="Introduce un email válido" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" value="${sessionScope.usuarioLogueado.email}" required>
                    </div>

                    <div class="form-group">
                        <label for="telefono"><i class="fas fa-phone"></i> Teléfono</label>
                        <input type="tel" id="telefono" name="telefono" placeholder="999999999"   pattern="[6-9][0-9]{8}" 
                        value="${sessionScope.usuarioLogueado.telefono}"
                        title="9 dígitos comenzando por 6, 7, 8 o 9" required>
                    </div>

                    <div class="form-group">
                        <label for="iban"><i class="fas fa-credit-card"></i> IBAN</label>
                        <input type="text" id="iban" name="iban" placeholder="ES1234567890123456789012" pattern="[A-Z]{2}[0-9]{22}" title="2 letras seguidas de 22 números" value="${sessionScope.usuarioLogueado.iban}" required>
                    </div>

                    <div class="form-group">
                        <label for="clave"><i class="fas fa-lock"></i> Nueva Contraseña</label>
                        <div class="password-input">
                            <input type="password" id="clave" name="clave" placeholder="Dejar en blanco para mantener la actual">
                            <button type="button" class="toggle-password"></i></button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmarClave"><i class="fas fa-lock"></i> Confirmar Nueva Contraseña</label>
                        <div class="password-input">
                            <input type="password" id="confirmarClave" name="confirmarClave" placeholder="Confirmar nueva contraseña">
                            <button type="button" class="toggle-password"></button>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" name="actualizarPerfil" class="btn-primary">
                            <i class="fas fa-save"></i> Guardar Cambios
                        </button>
                    
                    </div>
                </form>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
               

                // Validación del formulario
                const form = document.querySelector('.profile-form');
                const password = document.getElementById('clave');
                const confirmPassword = document.getElementById('confirmarClave');

                form.addEventListener('submit', function(e) {
                    if (password.value || confirmPassword.value) {
                        if (password.value !== confirmPassword.value) {
                            e.preventDefault();
                            alert('Las contraseñas no coinciden');
                        }
                    }
                });

                // Validación de campos
                const inputs = form.querySelectorAll('input[required]');
                inputs.forEach(input => {
                    input.addEventListener('input', function() {
                        this.classList.toggle('valid', this.value.trim() !== '');
                        this.classList.toggle('invalid', this.value.trim() === '');
                    });
                });
            });
        </script>
    </body>
</html> 