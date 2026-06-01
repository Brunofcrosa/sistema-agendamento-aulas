<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath}/imgs/favicon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <title>Salas</title>
</head>
<body>
<div class="d-flex flex-column min-vh-100 bg-light">
    <c:set var="pageName" value="salas" scope="request" />
    <jsp:include page="/WEB-INF/pages/includes/navbar.jsp" />

    <div class="d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/pages/includes/sidebar.jsp" />

        <main class="flex-grow-1 p-4 d-flex flex-column align-items-center">
            <div class="w-100" style="max-width: 980px;">

                <c:if test="${not empty erro}">
                    <div class="alert alert-danger fw-bold" role="alert">${erro}</div>
                </c:if>

                <c:choose>
                    <c:when test="${param.msg == 'salvo'}"><div class="alert alert-success fw-bold">Sala cadastrada!</div></c:when>
                    <c:when test="${param.msg == 'excluido'}"><div class="alert alert-success fw-bold">Sala excluída!</div></c:when>
                    <c:when test="${param.msg == 'editado'}"><div class="alert alert-success fw-bold">Sala atualizada!</div></c:when>
                </c:choose>

                <c:if test="${tela == 'novo'}">
                    <div class="card shadow-sm mb-4 border-0">
                        <div class="card-body p-4">
                            <h4 class="card-title fw-bold text-dark mb-4">${sala.id > 0 ? 'Editar Sala' : 'Nova Sala'}</h4>

                            <form action="sala" method="post" class="row g-3">
                                <input type="hidden" name="id" value="${sala.id}">

                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Número da Sala</label>
                                    <input type="text" class="form-control" name="nome" value="${sala.nome}" placeholder="Ex: F209" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Capacidade Máxima</label>
                                    <input type="number" class="form-control" name="capacidade" value="${sala.capacidade}" min="1" placeholder="Ex: 40" required>
                                </div>

                                <div class="col-md-6 d-flex align-items-center mt-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="recursos" value="Projetor" id="checkProjetor" ${sala.recursos == 'Projetor' ? 'checked' : ''}>
                                        <label class="form-check-label fw-bold" for="checkProjetor">Possui Projetor</label>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Status</label>
                                    <select class="form-select" name="ativa">
                                        <option value="on" ${sala.id == null || sala.ativa ? 'selected' : ''}>Ativa</option>
                                        <option value="" ${sala.id != null && !sala.ativa ? 'selected' : ''}>Manutenção</option>
                                    </select>
                                </div>

                                <input type="hidden" name="bloco" value="Principal">

                                <div class="col-12 text-center mt-4">
                                    <button type="submit" class="btn btn-primary px-5 fw-bold">Salvar Sala</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:if>

                <c:if test="${tela == 'listar'}">
                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="card-title fw-bold text-dark m-0">Salas Cadastradas</h4>
                                <a href="sala?tela=novo" class="btn btn-outline-primary fw-bold">Cadastrar sala</a>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Número da Sala</th>
                                        <th>Capacidade</th>
                                        <th>Projetor</th>
                                        <th>Status</th>
                                        <th>Ações</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="s" items="${salas}" varStatus="status">
                                        <tr>
                                            <td>${status.index + 1}</td>
                                            <td class="fw-semibold">${s.nome}</td>
                                            <td>${s.capacidade}</td>
                                            <td>${s.recursos == 'Projetor' ? 'Sim' : 'Não'}</td>
                                            <td>
                                                <span class="badge ${s.ativa ? 'bg-success' : 'bg-warning text-dark'}">${s.ativa ? 'Ativa' : 'Manutenção'}</span>
                                            </td>
                                            <td>
                                                <a href="sala?acao=editar&id=${s.id}" class="text-primary me-3 fs-5"><i class="fa-solid fa-pen-to-square"></i></a>
                                                <a href="sala?acao=excluir&id=${s.id}" class="text-danger fs-5" onclick="return confirm('Excluir sala?')"><i class="fa-solid fa-trash-can"></i></a>
                                            </td>
                                        </tr>
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