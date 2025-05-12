<%-- 
Document   : crearInscripcion
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
        <title>Formulario de Reserva</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="${contexto}/CSS/crearInscripcion.css"/>
        <style>
            .loading {
                display: none;
                color: #666;
                font-style: italic;
            }
            .error-message {
                color: #e74c3c;
                display: none;
                margin-top: 5px;
            }
            select:disabled {
                background-color: #f5f5f5;
                cursor: not-allowed;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>Formulario de Reserva</h1>
                <button id="toggleMode" class="toggle-btn">Modo Oscuro</button>
            </div>

            <form action="Create" method="post">
                <div class="form-group">
                    <select name="salaId" id="salaId">
                        <c:forEach var="lista" items="${listaSalas}">
                            <option value="${lista.idSala}">${lista.idSala}</option>
                        </c:forEach>
                    </select>
                    <span class="loading" id="loadingDias">Cargando días disponibles...</span>
                    <span class="error-message" id="errorDias"></span>
                </div>

                <div class="form-group">
                    <label for="diaSemana">Día de la Semana:</label>
                    <select id="diaSemana" name="diaSemana" required disabled>
                        <option value="">Seleccione un día</option>
                    </select>
                    <span class="loading" id="loadingHoras">Cargando horas disponibles...</span>
                    <span class="error-message" id="errorHoras"></span>
                </div>

                <div class="form-group">
                    <label for="hora">Hora:</label>
                    <select id="hora" name="hora" required disabled>
                        <option value="">Seleccione una hora</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="plazasOfertadas">Número de plazas ofertadas:</label>
                    <input type="number" id="plazasOfertadas" name="plazasOfertadas" value="1" required>
                </div>

                <div class="form-group">
                    <label for="deporte">Deporte:</label>
                    <select id="nombre" name="nombreDeporte">
                        <c:forEach var="lista" items="${listaDeportes}">
                            <option value="${lista.nombreDeporte}">${lista.nombreDeporte}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="entrenador">Entrenador:</label>
                    <select id="entrenadorId" name="entrenadorId" disabled>
                        <option value="">Primero seleccione día y hora</option>
                    </select>
                </div>

                <div class="form-group">
                    <input type="submit" value="Enviar" class="submit-btn" name="crearInscripcion" disabled>
                    <span class="error-message" id="errorHorario"></span>
                </div>
            </form>
        </div>

        <script>
            $(document).ready(function() {
                const salaInput = $('#salaId');
                const diaSelect = $('#diaSemana');
                const horaSelect = $('#hora');
                const entrenadorSelect = $('#entrenadorId');
                const submitBtn = $('input[type="submit"]');
                const loadingDias = $('#loadingDias');
                const loadingHoras = $('#loadingHoras');
                const errorDias = $('#errorDias');
                const errorHoras = $('#errorHoras');
                const errorHorario = $('#errorHorario');

                // Función para cargar días disponibles
                function cargarDiasDisponibles() {
                    const salaId = salaInput.val();
                    if (!salaId) return;

                    loadingDias.show();
                    errorDias.hide();
                    diaSelect.prop('disabled', true);
                    horaSelect.prop('disabled', true);
                    entrenadorSelect.prop('disabled', true);
                    submitBtn.prop('disabled', true);
                    horaSelect.html('<option value="">Seleccione una hora</option>');
                    entrenadorSelect.html('<option value="">Primero seleccione día y hora</option>');

                    $.get('HorarioAjaxController', {
                        action: 'getDiasDisponibles',
                        salaId: salaId
                    })
                    .done(function(data) {
                        diaSelect.html('<option value="">Seleccione un día</option>');
                        data.forEach(function(dia) {
                            diaSelect.append('<option value="' + dia + '">' + dia + '</option>');
                        });
                        diaSelect.prop('disabled', false);
                    })
                    .fail(function(jqXHR) {
                        errorDias.text('Error al cargar los días disponibles').show();
                    })
                    .always(function() {
                        loadingDias.hide();
                    });
                }

                // Función para cargar horas disponibles
                function cargarHorasDisponibles() {
                    const salaId = salaInput.val();
                    const diaSemana = diaSelect.val();
                    if (!salaId || !diaSemana) return;

                    loadingHoras.show();
                    errorHoras.hide();
                    horaSelect.prop('disabled', true);
                    entrenadorSelect.prop('disabled', true);
                    submitBtn.prop('disabled', true);
                    entrenadorSelect.html('<option value="">Primero seleccione día y hora</option>');

                    $.get('HorarioAjaxController', {
                        action: 'getHorasDisponibles',
                        salaId: salaId,
                        diaSemana: diaSemana
                    })
                    .done(function(data) {
                        horaSelect.html('<option value="">Seleccione una hora</option>');
                        data.forEach(function(hora) {
                            horaSelect.append('<option value="' + hora + '">' + hora + '</option>');
                        });
                        horaSelect.prop('disabled', false);
                    })
                    .fail(function(jqXHR) {
                        errorHoras.text('Error al cargar las horas disponibles').show();
                    })
                    .always(function() {
                        loadingHoras.hide();
                    });
                }

                // Función para habilitar el selector de entrenador
                function habilitarEntrenador() {
                    if (horaSelect.val() && diaSelect.val()) {
                        entrenadorSelect.html('<option value="">Seleccione un entrenador</option>');
                        <c:forEach var="lista" items="${listaEntrenadores}">
                            entrenadorSelect.append('<option value="${lista.id}">${lista.nombre}</option>');
                        </c:forEach>
                        entrenadorSelect.prop('disabled', false);
                    } else {
                        entrenadorSelect.html('<option value="">Primero seleccione día y hora</option>');
                        entrenadorSelect.prop('disabled', true);
                    }
                }

                // Función para validar el horario
                function validarHorario() {
                    const entrenadorId = entrenadorSelect.val();
                    const diaSemana = diaSelect.val();
                    const hora = horaSelect.val();
                    
                    if (!entrenadorId || !diaSemana || !hora) return;

                    $.get('HorarioAjaxController', {
                        action: 'validarHorario',
                        entrenadorId: entrenadorId,
                        diaSemana: diaSemana,
                        hora: hora
                    })
                    .done(function(data) {
                        if (data.disponible) {
                            errorHorario.hide();
                            submitBtn.prop('disabled', false);
                        } else {
                            errorHorario.text(data.mensaje).show();
                            submitBtn.prop('disabled', true);
                        }
                    })
                    .fail(function() {
                        errorHorario.text('Error al validar el horario').show();
                        submitBtn.prop('disabled', true);
                    });
                }

                // Eventos
                salaInput.on('change', cargarDiasDisponibles);
                diaSelect.on('change', cargarHorasDisponibles);
                horaSelect.on('change', habilitarEntrenador);
                entrenadorSelect.on('change', function() {
                    validarHorario();
                });

                // Cargar días disponibles al cargar la página
                cargarDiasDisponibles();
            });
        </script>
    </body>
</html>


