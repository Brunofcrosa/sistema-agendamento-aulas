<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/imgs/favicon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <title>Docentes</title>
</head>
<body>
<div class="d-flex flex-column min-vh-100 bg-light">
    <c:set var="pageName" value="docentes" scope="request" />
    <jsp:include page="/WEB-INF/pages/includes/navbar.jsp" />

    <div class="d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/pages/includes/sidebar.jsp" />

        <main class="flex-grow-1 p-4 d-flex flex-column align-items-center">
            <div class="w-100" style="max-width: 980px;">

                <c:if test="${not empty erro}">
                    <div class="alert alert-danger fw-bold" role="alert">${erro}</div>
                </c:if>
                <c:choose>
                    <c:when test="${param.msg == 'salvo'}"><div class="alert alert-success fw-bold">Docente cadastrado!</div></c:when>
                    <c:when test="${param.msg == 'excluido'}"><div class="alert alert-success fw-bold">Docente excluído!</div></c:when>
                    <c:when test="${param.msg == 'editado'}"><div class="alert alert-success fw-bold">Docente atualizado!</div></c:when>
                </c:choose>

                <c:if test="${tela == 'novo'}">
                    <div class="card shadow-sm mb-4 border-0">
                        <div class="card-body p-4">
                            <h4 class="card-title fw-bold text-dark mb-4">${docente.id > 0 ? 'Editar Docente' : 'Novo Docente'}</h4>

                            <form action="docente" method="post" class="row g-3">
                                <input type="hidden" name="id" value="${docente.id}">

                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Nome do Docente</label>
                                    <input type="text" class="form-control" name="nome" value="${docente.nome}" placeholder="Ex: Professor X" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Matrícula</label>
                                    <input type="text" class="form-control" name="matricula" value="${docente.matricula}" placeholder="Ex: 123456" required>
                                </div>

                                <div class="col-12 text-center mt-4">
                                    <button type="submit" class="btn btn-primary px-5 fw-bold">${docente.id > 0 ? 'Salvar Docente' : 'Cadastrar Docente'}</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:if>

                <c:if test="${tela == 'listar'}">
                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="card-title fw-bold text-dark m-0">Docentes Cadastrados</h4>
                                <a href="docente?tela=novo" class="btn btn-outline-primary fw-bold">Cadastrar docente</a>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nome do Docente</th>
                                        <th>Matrícula</th>
                                        <th>Ações</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="d" items="${docentes}" varStatus="status">
                                        <tr>
                                            <td>${status.index + 1}</td>
                                            <td class="fw-semibold">${d.nome}</td>
                                            <td>${d.matricula}</td>
                                            <td>
                                                <a href="docente?acao=editar&id=${d.id}" class="text-primary me-3 fs-5"><i class="fa-solid fa-pen-to-square"></i></a>
                                                <a href="docente?acao=excluir&id=${d.id}" class="text-danger fs-5" onclick="return confirm('Excluir docente?')"><i class="fa-solid fa-trash-can"></i></a>
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