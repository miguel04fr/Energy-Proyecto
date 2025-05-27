<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Restablecer Contraseña</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp"/>
        
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="text-center">Restablecer Contraseña</h3>
                        </div>
                        <div class="card-body">
                            <form action="Login" method="POST" onsubmit="return validarContrasenas()">
                                <c:if test="${not empty mensaje}">
                                    <div class="alert alert-${tipoMensaje}">
                                        ${mensaje}
                                    </div>
                                </c:if>
                                
                                <div class="mb-3">
                                    <label for="nuevaContrasena" class="form-label">Nueva Contraseña</label>
                                    <input type="password" 
                                           class="form-control" 
                                           id="nuevaContrasena" 
                                           name="nuevaContrasena" 
                                           required 
                                           minlength=""
                                           placeholder="Ingrese su nueva contraseña">
                                </div>
                                
                                <div class="mb-3">
                                    <label for="confirmarContrasena" class="form-label">Confirmar Contraseña</label>
                                    <input type="password" 
                                           class="form-control" 
                                           id="confirmarContrasena" 
                                           name="confirmarContrasena" 
                                           required 
                                           minlength=""
                                           placeholder="Confirme su nueva contraseña">
                                </div>
                                
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary" name="restablecerContrasena">Restablecer Contraseña</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function validarContrasenas() {
                var nuevaContrasena = document.getElementById('nuevaContrasena').value;
                var confirmarContrasena = document.getElementById('confirmarContrasena').value;
                
                if (nuevaContrasena !== confirmarContrasena) {
                    alert('Las contraseñas no coinciden');
                    return false;
                }
                
                if (nuevaContrasena.length < 1) {
                    alert('La contraseña debe tener al menos 1 caracter');
                    return false;
                }
                
                return true;
            }
        </script>
    </body>
</html>
