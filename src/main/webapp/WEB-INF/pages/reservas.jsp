<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/imgs/favicon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <title>Reservas</title>
</head>
<body>
<div class="d-flex flex-column min-vh-100 bg-light">
    <c:set var="pageName" value="reservas" scope="request" />
    <jsp:include page="/WEB-INF/pages/includes/navbar.jsp" />

    <div class="d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/pages/includes/sidebar.jsp" />

        <main class="flex-grow-1 p-4 d-flex flex-column align-items-center">
            <div class="w-100" style="max-width: 980px;">

                <c:if test="${not empty erro}">
                    <div class="alert alert-danger fw-bold" role="alert">${erro}</div>
                </c:if>
                <c:choose>
                    <c:when test="${param.msg == 'salva'}"><div class="alert alert-success fw-bold">Reserva cadastrada!</div></c:when>
                    <c:when test="${param.msg == 'editada'}"><div class="alert alert-success fw-bold">Reserva atualizada!</div></c:when>
                    <c:when test="${param.msg == 'cancelada'}"><div class="alert alert-danger fw-bold">Reserva excluída!</div></c:when>
                    <c:when test="${param.msg == 'sucesso'}"><div class="alert alert-success fw-bold">Agendado com sucesso!</div></c:when>
                </c:choose>

                <c:if test="${tela == 'novo'}">
                    <div class="card shadow-sm mb-4 border-0">
                        <div class="card-body p-4">
                            <h4 class="card-title fw-bold text-dark mb-4">${reserva.id > 0 ? 'Editar Agendamento' : 'Novo Agendamento'}</h4>

                            <form action="reserva" method="post" class="row g-3">
                                <input type="hidden" name="id" value="${reserva.id}">

                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Sala</label>
                                    <select class="form-select" name="salaId" required>
                                        <option value="">Selecione uma sala</option>
                                        <c:forEach var="s" items="${salas}">
                                            <option value="${s.id}" ${reserva.salaId == s.id ? 'selected' : ''}>${s.nome}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Nome do Professor</label>
                                    <select class="form-select" name="docenteId" required>
                                        <option value="">Selecione um professor</option>
                                        <c:forEach var="d" items="${docentes}">
                                            <option value="${d.id}" ${reserva.docenteId == d.id ? 'selected' : ''}>${d.nome}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-12">
                                    <label class="form-label fw-bold">Nome da Disciplina</label>
                                    <input type="text" class="form-control" name="finalidade" value="${reserva.finalidade}" placeholder="Nome da Disciplina" required>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Data</label>
                                    <input type="date" class="form-control" name="dataReserva" value="${reserva.dataReserva}" required>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Hora de Início</label>
                                    <input type="time" class="form-control" name="horaInicio" value="${reserva.horaInicio}" required>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Hora de Fim</label>
                                    <input type="time" class="form-control" name="horaFim" value="${reserva.horaFim}" required>
                                </div>

                                <div class="col-12 text-center mt-4">
                                    <button type="submit" class="btn btn-primary px-5 fw-bold">Salvar Agendamento</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:if>

                <c:if test="${tela == 'listar'}">
                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="card-title fw-bold text-dark m-0">Agendamentos cadastrados</h4>
                                <a href="reserva?tela=novo" class="btn btn-outline-primary fw-bold">Nova reserva</a>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
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
                                    </thead>
                                    <tbody>
                                    <c:set var="counter" value="1" />
                                    <c:forEach var="r" items="${reservas}">
                                        <c:if test="${r.status == 'ATIVA'}">
                                            <tr>
                                                <td>${counter}</td>
                                                <td class="fw-semibold">${r.salaNome}</td>
                                                <td>${r.docenteNome}</td>
                                                <td>${r.finalidade}</td>
                                                <td>${r.dataReserva}</td>
                                                <td>${r.horaInicio}</td>
                                                <td>${r.horaFim}</td>
                                                <td>
                                                    <a href="reserva?acao=editar&id=${r.id}" class="text-primary me-2 fs-5"><i class="fa-solid fa-pen-to-square"></i></a>
                                                    <a href="reserva?acao=cancelar&id=${r.id}" class="text-danger fs-5" onclick="return confirm('Excluir reserva?')"><i class="fa-solid fa-trash-can"></i></a>
                                                </td>
                                            </tr>
                                            <c:set var="counter" value="${counter + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>

            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>