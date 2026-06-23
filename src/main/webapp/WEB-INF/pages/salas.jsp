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
    <title>Salas</title>
</head>
<body>
<div class="page-wrapper">
    <c:set var="pageName" value="salas" scope="request" />
    <jsp:include page="/WEB-INF/pages/includes/navbar.jsp" />
    
    <div class="app-shell">
        <jsp:include page="/WEB-INF/pages/includes/sidebar.jsp" />
        
        <main class="main-content">
            <c:if test="${not empty erro}">
                <div class="msg erro"><c:out value="${erro}" /></div>
            </c:if>
            
            <c:choose>
                <c:when test="${msg == 'salvo'}"><div class="msg">Sala cadastrada!</div></c:when>
                <c:when test="${msg == 'excluido'}"><div class="msg">Sala excluída!</div></c:when>
                <c:when test="${msg == 'editado'}"><div class="msg">Sala atualizada!</div></c:when>
                <c:when test="${msg == 'sucesso'}"><div class="msg">Agendado com sucesso!</div></c:when>
            </c:choose>
            <c:if test="${tela == 'novo'}">
            <section class="content-card">
                <h2><c:out value="${sala.id > 0 ? 'Editar Sala' : 'Nova Sala'}" /></h2>
                <form action="${pageContext.request.contextPath}/sala" method="post" class="form-grid">
                    <input type="hidden" name="csrfToken" value="${csrfToken}">
                    <input type="hidden" name="id" value="${sala.id}">
                    
                    <div class="form-field">
                        <label for="nome">Número da Sala</label>
                        <input type="text" id="nome" name="nome" value="<c:out value='${sala.nome}' />" placeholder="Ex: F209" required>
                    </div>
                    
                    <div class="form-field">
                        <label for="capacidade">Capacidade Máxima</label>
                        <input type="number" id="capacidade" name="capacidade" value="${sala.capacidade}" min="1" placeholder="Ex: 40" required>
                    </div>
                    
                    <div class="form-field">
                        <label class="check" for="recursos">
                            <input type="checkbox" id="recursos" name="recursos" value="Projetor" ${sala.recursos == 'Projetor' ? 'checked' : ''}> 
                            Possui Projetor
                        </label>
                    </div>
                    
                    <div class="form-field">
                        <label for="ativa">Status</label>
                        <select id="ativa" name="ativa">
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
                    <a class="btn-primary-link" href="${pageContext.request.contextPath}/sala?tela=novo">Cadastrar sala</a>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Número da Sala</th>
                            <th>Capacidade Máxima</th>
                            <th>Projetor</th>
                            <th>Status</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${salas}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td><c:out value="${s.nome}" /></td>
                                <td>${s.capacidade}</td>
                                <td>${s.recursos == 'Projetor' ? 'Sim' : 'Não'}</td>
                                <td>${s.ativa ? 'Ativa' : 'Manutenção'}</td>
                                <td class="actions">
                                    <a href="${pageContext.request.contextPath}/sala?acao=editar&id=${s.id}" title="Editar" class="btn-icon btn-edit"><i class="fa-solid fa-pen-to-square"></i></a>
                                    <a href="${pageContext.request.contextPath}/sala?acao=excluir&id=${s.id}" title="Excluir" class="btn-icon btn-delete" onclick="return confirm('Excluir sala?')"><i class="fa-solid fa-trash-can"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>
            </c:if>
            <c:if test="${tela == 'encontrar'}">
            <section class="content-card">
                <h2>Encontrar Sala Disponível</h2>
                <form action="${pageContext.request.contextPath}/sala" method="get" class="form-grid search-grid">
                    <input type="hidden" name="tela" value="encontrar">
                    
                    <div class="form-field">
                        <label for="searchCapacidade">Capacidade Necessária</label>
                        <input type="number" id="searchCapacidade" name="capacidade" value="<c:out value='${param.capacidade}' />" min="1" placeholder="Ex: 20">
                    </div>
                    
                    <div class="form-field">
                        <label for="searchDiaSemana">Dia da Semana</label>
                        <select id="searchDiaSemana" name="diaSemana">
                            <option value="SEGUNDA" ${param.diaSemana == 'SEGUNDA' ? 'selected' : ''}>SEGUNDA</option>
                            <option value="TERÇA" ${param.diaSemana == 'TERÇA' ? 'selected' : ''}>TERÇA</option>
                            <option value="QUARTA" ${param.diaSemana == 'QUARTA' ? 'selected' : ''}>QUARTA</option>
                            <option value="QUINTA" ${param.diaSemana == 'QUINTA' ? 'selected' : ''}>QUINTA</option>
                            <option value="SEXTA" ${param.diaSemana == 'SEXTA' ? 'selected' : ''}>SEXTA</option>
                        </select>
                    </div>
                    
                    <div class="form-field">
                        <label for="searchHoraInicio">Hora de Início</label>
                        <input type="time" id="searchHoraInicio" name="horaInicio" value="<c:out value='${param.horaInicio}' />">
                    </div>
                    
                    <div class="form-field">
                        <label for="searchHoraFim">Hora de Fim</label>
                        <input type="time" id="searchHoraFim" name="horaFim" value="<c:out value='${param.horaFim}' />">
                    </div>
                    
                    <div class="form-field">
                        <label class="check" for="searchPossuiProjetor">
                            <input type="checkbox" id="searchPossuiProjetor" name="possuiProjetor" value="true" ${param.possuiProjetor == 'true' ? 'checked' : ''}> 
                            Possui Projetor
                        </label>
                    </div>
                    
                    <div class="form-actions search-actions">
                        <button type="submit">Buscar Salas</button>
                    </div>
                </form>
            </section>

            <section class="content-card">
                <h2>Salas Sugeridas</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Número da Sala</th>
                            <th>Capacidade</th>
                            <th>Projetor</th>
                            <th>Status</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${salasSugeridas}">
                            <tr>
                                <td><c:out value="${s.nome}" /></td>
                                <td><c:out value="${s.capacidade}" /></td>
                                <td><c:out value="${s.recursos == 'Projetor' ? 'Sim' : 'Não'}" /></td>
                                <td>Ativa</td>
                                <td class="actions">
                                    <a class="table-button" href="${pageContext.request.contextPath}/sala?acao=reservarRapido&salaId=${s.id}&diaSemana=<c:out value='${param.diaSemana}'/>&horaInicio=<c:out value='${param.horaInicio}'/>&horaFim=<c:out value='${param.horaFim}'/>&capacidade=<c:out value='${param.capacidade}'/>&possuiProjetor=<c:out value='${param.possuiProjetor}'/>">
                                        Reservar
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty salasSugeridas && not empty param.diaSemana}">
                            <tr>
                                <td colspan="5" style="text-align: center; color: #777; padding: 20px;">
                                    Nenhuma sala disponível atende aos critérios informados.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </section>
            </c:if>
        </main>
    </div>
</div>
</body>
</html>