<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/imgs/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/crud.css?v=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sidebar.css?v=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
    <title>Salas</title>
</head>
<body>
<div class="page-wrapper">
    <c:set var="pageName" value="salas" scope="request" />
    <jsp:include page="/WEB-INF/pages/includes/navbar.jsp" />
    <div class="app-shell">
        <jsp:include page="/WEB-INF/pages/includes/sidebar.jsp" />
        <main class="main-content">
            <c:if test="${not empty erro}"><div class="msg erro">${erro}</div></c:if>
            <c:choose>
                <c:when test="${param.msg == 'salvo'}"><div class="msg">Sala cadastrada!</div></c:when>
                <c:when test="${param.msg == 'excluido'}"><div class="msg">Sala excluída!</div></c:when>
                <c:when test="${param.msg == 'editado'}"><div class="msg">Sala atualizada!</div></c:when>
                <c:when test="${param.msg == 'sucesso'}"><div class="msg">Agendado com sucesso!</div></c:when>
            </c:choose>
            <c:if test="${tela == 'novo'}">
            <section class="content-card">
                <h2>${sala.id > 0 ? 'Editar Sala' : 'Nova Sala'}</h2>
                <form action="sala" method="post" class="form-grid">
                    <input type="hidden" name="id" value="${sala.id}">
                    <div class="form-field">
                        <label>Número da Sala</label>
                        <input type="text" name="nome" value="${sala.nome}" placeholder="Ex: F209" required>
                    </div>
                    <div class="form-field">
                        <label>Capacidade Máxima</label>
                        <input type="number" name="capacidade" value="${sala.capacidade}" min="1" placeholder="Ex: 40" required>
                    </div>
                    <label class="check"><input type="checkbox" name="recursos" value="Projetor" ${sala.recursos == 'Projetor' ? 'checked' : ''}> Possui Projetor</label>
                    <div class="form-field">
                        <label>Status</label>
                        <select name="ativa">
                            <option value="on" ${sala.id == null || sala.ativa ? 'selected' : ''}>Ativa</option>
                            <option value="" ${sala.id != null && !sala.ativa ? 'selected' : ''}>Manutenção</option>
                        </select>
                    </div>
                    <input type="hidden" name="bloco" value="Principal">
                    <div class="form-actions">
                        <button type="submit">Salvar Sala</button>
                    </div>
                </form>
            </section>
            </c:if>
            <c:if test="${tela == 'listar'}">
            <section class="content-card">
                <div class="card-header-actions">
                    <h2>Salas Cadastradas</h2>
                    <a class="btn-primary-link" href="sala?tela=novo">Cadastrar sala</a>
                </div>
                <table>
                    <tr><th>ID</th><th>Número da Sala</th><th>Capacidade Máxima</th><th>Projetor</th><th>Status</th><th>Ações</th></tr>
                    <c:forEach var="s" items="${salas}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${s.nome}</td>
                            <td>${s.capacidade}</td>
                            <td>${s.recursos == 'Projetor' ? 'Sim' : 'Não'}</td>
                            <td>${s.ativa ? 'Ativa' : 'Manutenção'}</td>
                            <td class="actions">
                                <a href="sala?acao=editar&id=${s.id}" title="Editar" class="btn-icon btn-edit"><i class="fa-solid fa-pen-to-square"></i></a>
                                <a href="sala?acao=excluir&id=${s.id}" title="Excluir" class="btn-icon btn-delete" onclick="return confirm('Excluir sala?')"><i class="fa-solid fa-trash-can"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </section>
            </c:if>
            <%--
            <c:if test="${tela == 'encontrar'}">
            <section class="content-card">
                <h2>Encontrar Sala Disponível</h2>
                <form action="sala" method="get" class="form-grid search-grid">
                    <input type="hidden" name="tela" value="encontrar">
                    <div class="form-field">
                        <label>Capacidade Necessária</label>
                        <input type="number" name="capacidade" value="${param.capacidade}" min="1">
                    </div>
                    <div class="form-field">
                        <label>Dia da Semana</label>
                        <select name="diaSemana">
                            <option value="SEGUNDA" ${param.diaSemana == 'SEGUNDA' ? 'selected' : ''}>SEGUNDA</option>
                            <option value="TERÇA" ${param.diaSemana == 'TERÇA' ? 'selected' : ''}>TERÇA</option>
                            <option value="QUARTA" ${param.diaSemana == 'QUARTA' ? 'selected' : ''}>QUARTA</option>
                            <option value="QUINTA" ${param.diaSemana == 'QUINTA' ? 'selected' : ''}>QUINTA</option>
                            <option value="SEXTA" ${param.diaSemana == 'SEXTA' ? 'selected' : ''}>SEXTA</option>
                        </select>
                    </div>
                    <div class="form-field">
                        <label>Hora de Início</label>
                        <input type="time" name="horaInicio" value="${param.horaInicio}">
                    </div>
                    <div class="form-field">
                        <label>Hora de Fim</label>
                        <input type="time" name="horaFim" value="${param.horaFim}">
                    </div>
                    <label class="check"><input type="checkbox" name="possuiProjetor" value="true" ${param.possuiProjetor == 'true' ? 'checked' : ''}> Possui Projetor</label>
                    <div class="form-actions search-actions">
                        <button type="submit">Buscar Salas</button>
                    </div>
                </form>
            </section>

            <section class="content-card">
                <h2>Salas Sugeridas</h2>
                <table>
                    <tr><th>Número da Sala</th><th>Capacidade</th><th>Projetor</th><th>Status</th><th>Ações</th></tr>
                    <c:forEach var="s" items="${salas}">
                        <c:if test="${s.ativa && (empty param.capacidade || s.capacidade >= param.capacidade) && (empty param.possuiProjetor || s.recursos == 'Projetor')}">
                            <tr>
                                <td>${s.nome}</td>
                                <td>${s.capacidade}</td>
                                <td>${s.recursos == 'Projetor' ? 'Sim' : 'Não'}</td>
                                <td>Ativa</td>
                                <td class="actions"><a class="table-button" href="sala?acao=reservarRapido&salaId=${s.id}&diaSemana=${param.diaSemana}&horaInicio=${param.horaInicio}&horaFim=${param.horaFim}&capacidade=${param.capacidade}&possuiProjetor=${param.possuiProjetor}">Reservar</a></td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
            </section>
            </c:if>
            --%>
        </main>
    </div>
</div>
</body>
</html>

