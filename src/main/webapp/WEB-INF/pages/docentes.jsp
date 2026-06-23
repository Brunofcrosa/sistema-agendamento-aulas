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
    <title>Docentes</title>
</head>
<body>
<div class="page-wrapper">
    <c:set var="pageName" value="docentes" scope="request" />
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
                            <c:when test="${msg == 'salvo'}">text = 'Docente cadastrado com sucesso!';</c:when>
                            <c:when test="${msg == 'excluido'}">text = 'Docente excluído com sucesso!';</c:when>
                            <c:when test="${msg == 'editado'}">text = 'Docente atualizado com sucesso!';</c:when>
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
                <h2><c:out value="${docente.id > 0 ? 'Editar Docente' : 'Novo Docente'}" /></h2>
                <form action="docente" method="post" class="form-grid">
                    <input type="hidden" name="csrfToken" value="${csrfToken}">
                    <input type="hidden" name="id" value="${docente.id}">
                    
                    <div class="form-field">
                        <label for="matricula">Matrícula <span style="color: #dc3545; font-weight: bold;">*</span></label>
                        <input type="text" id="matricula" name="matricula" value="<c:out value='${docente.matricula}' />" placeholder="Ex: 123456" required>
                    </div>
                    
                    <div class="form-field">
                        <label for="nome">Nome do Docente <span style="color: #dc3545; font-weight: bold;">*</span></label>
                        <input type="text" id="nome" name="nome" value="<c:out value='${docente.nome}' />" placeholder="Ex: Professor X" required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit">
                            <c:out value="${docente.id > 0 ? 'Salvar Docente' : 'Cadastrar Docente'}" />
                        </button>
                    </div>
                </form>
            </section>
            </c:if>

            <c:if test="${tela == 'listar'}">
            <section class="content-card">
                <div class="card-header-actions">
                    <h2>Docentes Cadastrados</h2>
                    <a class="btn-primary-link" href="docente?tela=novo">Cadastrar docente</a>
                </div>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Nome do Docente</th>
                        <th>Matrícula</th>
                        <th>Ações</th>
                    </tr>
                    <c:forEach var="d" items="${docentes}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td><c:out value="${d.nome}" /></td>
                            <td><c:out value="${d.matricula}" /></td>
                            <td class="actions">
                                <a href="docente?acao=editar&id=${d.id}" title="Editar" class="btn-icon btn-edit"><i class="fa-solid fa-pen-to-square"></i></a>
                                <a href="docente?acao=excluir&id=${d.id}" title="Excluir" class="btn-icon btn-delete btn-confirm-delete" data-message="Tem certeza que deseja excluir este docente?"><i class="fa-solid fa-trash-can"></i></a>
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
                        confirmButtonText: 'Sim, excluir!',
                        cancelButtonText: 'Cancelar'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = url;
                        }
                    });
                });
            });
        });
    </script>
</body>
</html>