<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath}/imgs/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/crud.css?v=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sidebar.css?v=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
    <title>Reservas</title>
</head>
<body>
<div class="page-wrapper">
    <c:set var="pageName" value="reservas" scope="request" />
    <jsp:include page="/WEB-INF/pages/includes/navbar.jsp" />
    
    <div class="app-shell">
        <jsp:include page="/WEB-INF/pages/includes/sidebar.jsp" />
        
        <main class="main-content">
            <c:if test="${not empty erro}">
                <script>
                    window.addEventListener('DOMContentLoaded', () => {
                        Swal.fire({
                            title: 'Erro!',
                            text: '<c:out value="${erro}" />',
                            icon: 'error',
                            confirmButtonColor: '#007bff'
                        });
                    });
                </script>
            </c:if>
            <c:if test="${not empty msg}">
                <script>
                    window.addEventListener('DOMContentLoaded', () => {
                        let text = '';
                        <c:choose>
                            <c:when test="${msg == 'salva'}">text = 'Reserva cadastrada com sucesso!';</c:when>
                            <c:when test="${msg == 'editada'}">text = 'Reserva atualizada com sucesso!';</c:when>
                            <c:when test="${msg == 'cancelada'}">text = 'Reserva cancelada com sucesso!';</c:when>
                            <c:when test="${msg == 'sucesso'}">text = 'Agendamento realizado com sucesso!';</c:when>
                        </c:choose>
                        if (text) {
                            Swal.fire({
                                title: 'Sucesso!',
                                text: text,
                                icon: 'success',
                                confirmButtonColor: '#007bff'
                            });
                        }
                    });
                </script>
            </c:if>

            <c:if test="${tela == 'novo'}">
            <section class="content-card">
                <h2><c:out value="${reserva.id > 0 ? 'Editar Agendamento' : 'Novo Agendamento'}" /></h2>
                <form action="reserva" method="post" class="form-grid" id="reservaForm">
                    <input type="hidden" name="csrfToken" value="${csrfToken}">
                    <input type="hidden" name="id" value="${reserva.id}">
                    
                    <div class="form-field">
                        <label for="salaId">Sala <span style="color: #dc3545; font-weight: bold;">*</span></label>
                        <select id="salaId" name="salaId" required>
                            <option value="">Selecione uma sala</option>
                            <c:forEach var="s" items="${salas}">
                                <option value="${s.id}" ${reserva.salaId == s.id ? 'selected' : ''}>
                                    <c:out value="${s.nome}" />
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-field">
                        <label for="docenteId">Nome do Professor <span style="color: #dc3545; font-weight: bold;">*</span></label>
                        <select id="docenteId" name="docenteId" required>
                            <option value="">Selecione um professor</option>
                            <c:forEach var="d" items="${docentes}">
                                <option value="${d.id}" ${reserva.docenteId == d.id ? 'selected' : ''}>
                                    <c:out value="${d.nome}" />
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-field">
                        <label for="finalidade">Nome da Disciplina <span style="color: #dc3545; font-weight: bold;">*</span></label>
                        <input type="text" id="finalidade" name="finalidade" value="<c:out value='${reserva.finalidade}' />" placeholder="Nome da Disciplina" required>
                    </div>
                    
                    <div class="form-field">
                        <label for="dataReserva">Data <span style="color: #dc3545; font-weight: bold;">*</span></label>
                        <input type="date" id="dataReserva" name="dataReserva" value="${reserva.dataReserva}" required>
                    </div>
                    
                    <div class="form-field">
                        <label for="horaInicio">Hora de Início <span style="color: #dc3545; font-weight: bold;">*</span></label>
                        <input type="time" id="horaInicio" name="horaInicio" value="${reserva.horaInicio}" required>
                    </div>
                    
                    <div class="form-field">
                        <label for="horaFim">Hora de Fim <span style="color: #dc3545; font-weight: bold;">*</span></label>
                        <input type="time" id="horaFim" name="horaFim" value="${reserva.horaFim}" required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit">Salvar Agendamento</button>
                    </div>
                </form>
            </section>
            </c:if>

            <c:if test="${tela == 'listar'}">
            <section class="content-card">
                <div class="card-header-actions">
                    <h2>Agendamentos existentes</h2>
                    <a class="btn-primary-link" href="reserva?tela=novo">Nova reserva</a>
                </div>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Sala</th>
                        <th>Professor</th>
                        <th>Disciplina</th>
                        <th>Data</th>
                        <th>Início</th>
                        <th>Fim</th>
                        <th>Ações</th>
                    </tr>
                    <c:forEach var="r" items="${reservas}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td><c:out value="${r.salaNome}" /></td>
                            <td><c:out value="${r.docenteNome}" /></td>
                            <td><c:out value="${r.finalidade}" /></td>
                            <td><c:out value="${r.dataReserva}" /></td>
                            <td><c:out value="${r.horaInicio}" /></td>
                            <td><c:out value="${r.horaFim}" /></td>
                            <td class="actions">
                                <a href="reserva?acao=editar&id=${r.id}" title="Editar" class="btn-icon btn-edit"><i class="fa-solid fa-pen-to-square"></i></a>
                                <a href="reserva?acao=cancelar&id=${r.id}" title="Cancelar" class="btn-icon btn-delete btn-confirm-delete" data-message="Tem certeza que deseja cancelar esta reserva?"><i class="fa-solid fa-trash-can"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </section>
            </c:if>
        </main>
    </div>
</div>
    <script>
        window.addEventListener('DOMContentLoaded', () => {
            // Confirmation dialogs
            document.querySelectorAll('.btn-confirm-delete').forEach(button => {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    const url = this.getAttribute('href');
                    const message = this.getAttribute('data-message') || 'Tem certeza que deseja prosseguir?';
                    
                    Swal.fire({
                        title: 'Confirmação',
                        text: message,
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#d33',
                        cancelButtonColor: '#3085d6',
                        confirmButtonText: 'Sim, cancelar!',
                        cancelButtonText: 'Cancelar'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = url;
                        }
                    });
                });
            });

            // Reservation form validation
            const reservaForm = document.getElementById('reservaForm');
            if (reservaForm) {
                reservaForm.addEventListener('submit', function(e) {
                    const horaInicio = document.getElementById('horaInicio').value;
                    const horaFim = document.getElementById('horaFim').value;
                    
                    if (horaInicio && horaFim && horaInicio >= horaFim) {
                        e.preventDefault();
                        Swal.fire({
                            title: 'Horário Inválido',
                            text: 'A hora de fim deve ser posterior à hora de início.',
                            icon: 'warning',
                            confirmButtonColor: '#007bff'
                        });
                    }
                });
            }
        });
    </script>
</body>
</html>