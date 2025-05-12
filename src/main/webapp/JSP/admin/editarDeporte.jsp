<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar Deporte - Energy</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/index.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <jsp:include page="/INC/cabecera.jsp"/>

        <main class="admin-container">
            <div class="section-header">
                <h2>Editar Deporte</h2>
                <p>Modifica la información del deporte seleccionado</p>
            </div>

            <form action="FrontController" method="post" class="edit-form" enctype="multipart/form-data">
                <input type="hidden" name="op" value="updateDeporte">
                <input type="hidden" name="idDeporte" value="${deporte.idDeporte}">

                <div class="form-group">
                    <label for="nombre">
                        <i class="fas fa-running"></i>
                        Nombre del Deporte
                    </label>
                    <input type="text" id="nombre" name="nombre" value="${deporte.nombre}" required>
                </div>

                <div class="form-group">
                    <label for="descripcion">
                        <i class="fas fa-info-circle"></i>
                        Descripción
                    </label>
                    <textarea id="descripcion" name="descripcion" rows="4" required>${deporte.descripcion}</textarea>
                </div>

                <div class="form-group">
                    <label for="imagen">
                        <i class="fas fa-image"></i>
                        Imagen del Deporte
                    </label>
                    <div class="image-preview">
                        <img src="${pageContext.request.contextPath}/img/${deporte.imagen}" alt="${deporte.nombre}" id="preview">
                    </div>
                    <input type="file" id="imagen" name="imagen" accept="image/*" onchange="previewImage(event)">
                </div>

                <div class="form-group">
                    <label for="precio">
                        <i class="fas fa-euro-sign"></i>
                        Precio por Sesión
                    </label>
                    <input type="number" id="precio" name="precio" value="${deporte.precio}" step="0.01" required>
                </div>

                <div class="form-group">
                    <label for="capacidad">
                        <i class="fas fa-users"></i>
                        Capacidad Máxima
                    </label>
                    <input type="number" id="capacidad" name="capacidad" value="${deporte.capacidad}" required>
                </div>

                <div class="form-actions">
                    <button type="submit" class="submit-btn">
                        <i class="fas fa-save"></i>
                        Guardar Cambios
                    </button>
                    <a href="FrontController?op=admin" class="reset-btn">
                        <i class="fas fa-times"></i>
                        Cancelar
                    </a>
                </div>
            </form>
        </main>

        <script>
            function previewImage(event) {
                const preview = document.getElementById('preview');
                const file = event.target.files[0];
                const reader = new FileReader();

                reader.onload = function() {
                    preview.src = reader.result;
                }

                if (file) {
                    reader.readAsDataURL(file);
                }
            }
        </script>
    </body>
</html> 