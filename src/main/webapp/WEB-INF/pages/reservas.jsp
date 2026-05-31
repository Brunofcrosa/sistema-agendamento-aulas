<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
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
            <c:if test="${not empty erro}"><div class="msg erro">${erro}</div></c:if>
             <c:choose>
                 <c:when test="${param.msg == 'salva'}"><div class="msg">Reserva cadastrada!</div></c:when>
                 <c:when test="${param.msg == 'editada'}"><div class="msg">Reserva atualizada!</div></c:when>
                 <c:when test="${param.msg == 'cancelada'}"><div class="msg">Reserva cancelada!</div></c:when>
                 <c:when test="${param.msg == 'sucesso'}"><div class="msg">Agendado com sucesso!</div></c:when>
             </c:choose>
            <c:if test="${tela == 'novo'}">
            <section class="content-card">
                <h2>${reserva.id > 0 ? 'Editar Agendamento' : 'Novo Agendamento'}</h2>
                <form action="reserva" method="post" class="form-grid">
                    <input type="hidden" name="id" value="${reserva.id}">
                    <div class="form-field">
                        <label>Sala</label>
                        <select name="salaId" required>
                            <option value="">Selecione uma sala</option>
                            <c:forEach var="s" items="${salas}">
                                <option value="${s.id}" ${reserva.salaId == s.id ? 'selected' : ''}>${s.nome}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-field">
                        <label>Nome do Professor</label>
                        <select name="docenteId" required>
                            <option value="">Selecione um professor</option>
                            <c:forEach var="d" items="${docentes}">
                                <option value="${d.id}" ${reserva.docenteId == d.id ? 'selected' : ''}>${d.nome}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-field">
                        <label>Nome da Disciplina</label>
                        <input type="text" name="finalidade" value="${reserva.finalidade}" placeholder="Nome da Disciplina" required>
                    </div>
                    <div class="form-field">
                        <label>Data</label>
                        <input type="date" name="dataReserva" value="${reserva.dataReserva}" required>
                    </div>
                    <div class="form-field">
                        <label>Hora de Início</label>
                        <input type="time" name="horaInicio" value="${reserva.horaInicio}" required>
                    </div>
                    <div class="form-field">
                        <label>Hora de Fim</label>
                        <input type="time" name="horaFim" value="${reserva.horaFim}" required>
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
                    <tr><th>ID</th><th>Sala</th><th>Professor</th><th>Disciplina</th><th>Data</th><th>Início</th><th>Fim</th><th>Ações</th></tr>
                    <c:set var="counter" value="1" />
                    <c:forEach var="r" items="${reservas}">
                        <c:if test="${r.status == 'ATIVA'}">
                            <tr>
                                <td>${counter}</td>
                                <td>${r.salaNome}</td>
                                <td>${r.docenteNome}</td>
                                <td>${r.finalidade}</td>
                                <td>${r.dataReserva}</td>
                                <td>${r.horaInicio}</td>
                                <td>${r.horaFim}</td>
                                <td class="actions">
                                    <a href="reserva?acao=editar&id=${r.id}" title="Editar" class="btn-icon btn-edit"><i class="fa-solid fa-pen-to-square"></i></a>
                                    <a href="reserva?acao=cancelar&id=${r.id}" title="Excluir" class="btn-icon btn-delete" onclick="return confirm('Cancelar reserva?')"><i class="fa-solid fa-trash-can"></i></a>
                                </td>
                            </tr>
                            <c:set var="counter" value="${counter + 1}" />
                        </c:if>
                    </c:forEach>
                </table>
            </section>
            </c:if>
        </main>
    </div>
</div>
</body>
</html>

