<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath}/imgs/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
    <title>Cadastro</title>
</head>
<body>
    <c:set var="navbarFull" value="true" scope="request" />
    <jsp:include page="/WEB-INF/pages/includes/navbar.jsp" />
    
    <div class="page-center">
        <div class="box">
            <h2>Criar Conta</h2>
            <form action="usuario" method="post">
                <input type="hidden" name="csrfToken" value="${csrfToken}">
                
                <div class="input-group">
                    <label for="nome">Nome</label>
                    <input type="text" id="nome" name="nome" placeholder="Ex: Maria Silva" required>
                </div>
                
                <div class="input-group">
                    <label for="email">E-mail</label>
                    <input type="email" id="email" name="email" placeholder="Ex: maria@email.com" required>
                </div>
                
                <div class="input-group">
                    <label for="senha">Senha</label>
                    <input type="password" id="senha" name="senha" placeholder="Digite sua senha" required>
                </div>
                
                <button type="submit">Cadastrar</button>
            </form>
            
            <a class="back-link" href="${pageContext.request.contextPath}/login">Voltar ao Login</a>
            
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
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/pages/includes/footer.jsp" />
</body>
</html>