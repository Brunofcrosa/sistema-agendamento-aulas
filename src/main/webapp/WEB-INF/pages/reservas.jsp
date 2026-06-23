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
                <div class="msg erro"><c:out value="${erro}" /></div>
            </c:if>
            
            <c:choose>
                <c:when test="${msg == 'salva'}"><div class="msg">Reserva cadastrada!</div></c:when>
                <c:when test="${msg == 'editada'}"><div class="msg">Reserva atualizada!</div></c:when>
                <c:when test="${msg == 'cancelada'}"><div class="msg">Reserva cancelada!</div></c:when>
                <c:when test="${msg == 'sucesso'}"><div class="msg">Agendado com sucesso!</div></c:when>
            </c:choose>

            <c:if test="${tela == 'novo'}">
            <section class="content-card">
                <h2><c:out value="${reserva.id > 0 ? 'Editar Agendamento' : 'Novo Agendamento'}" /></h2>
                <form action="reserva" method="post" class="form-grid">
                    <input type="hidden" name="csrfToken" value="${csrfToken}">
                    <input type="hidden" name="id" value="${reserva.id}">
                    
                    <div class="form-field">
                        <label for="salaId">Sala</label>
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
                        <label for="docenteId">Nome do Professor</label>
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
                        <label for="finalidade">Nome da Disciplina</label>
                        <input type="text" id="finalidade" name="finalidade" value="<c:out value='${reserva.finalidade}' />" placeholder="Nome da Disciplina" required>
                    </div>
                    
                    <div class="form-field">
                        <label for="dataReserva">Data</label>
                        <input type="date" id="dataReserva" name="dataReserva" value="${reserva.dataReserva}" required>
                    </div>
                    
                    <div class="form-field">
                        <label for="horaInicio">Hora de Início</label>
                        <input type="time" id="horaInicio" name="horaInicio" value="${reserva.horaInicio}" required>
                    </div>
                    
                    <div class="form-field">
                        <label for="horaFim">Hora de Fim</label>
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
                                <a href="reserva?acao=cancelar&id=${r.id}" title="Cancelar" class="btn-icon btn-delete" onclick="return confirm('Cancelar reserva?')"><i class="fa-solid fa-trash-can"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </section>
            </c:if>
        </main>
    </div>
</div>
</body>
</html>