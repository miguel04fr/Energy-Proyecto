<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verificación de Código</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp"/>
        
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="text-center">Ingrese el código de verificación que le enviamos a su correo</h3>
                        </div>
                        <div class="card-body">
                            <form action="${contexto}/Login" method="POST">
                                <c:if test="${not empty mensaje}">
                                    <div class="alert alert-${tipoMensaje}">
                                        ${mensaje}
                                    </div>
                                </c:if>
                                <div class="mb-3">
                                    <label for="codigo" class="form-label">Código de 6 dígitos</label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="codigo" 
                                           name="codigo" 
                                           pattern="[0-9]{6}" 
                                           maxlength="6" 
                                           required 
                                           oninput="this.value = this.value.replace(/[^0-9]/g, '')"
                                           placeholder="Ingrese el código de 6 dígitos">
                                </div>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary" name="verificarCodigo">Verificar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
