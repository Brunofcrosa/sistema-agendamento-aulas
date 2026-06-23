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
    <title>Login</title>
</head>
<body>
    <c:set var="navbarFull" value="true" scope="request" />
    <jsp:include page="/WEB-INF/pages/includes/navbar.jsp" />
    
    <div class="container">
        <div class="box">
            <h2>Login</h2>
            <form action="login" method="post">
                <input type="hidden" name="csrfToken" value="${csrfToken}">
                
                <div class="input-group">
                    <label for="email">E-mail</label>
                    <input type="email" id="email" name="email" placeholder="E-mail" required>
                </div>
                
                <div class="input-group">
                    <label for="senha">Senha</label>
                    <input type="password" id="senha" name="senha" placeholder="Senha" required>
                </div>
                
                <button type="submit">Entrar</button>
            </form>
            
            <a href="cadastro">Criar conta</a>
            
            <c:if test="${msg == 'cadastrado'}">
                <script>
                    window.addEventListener('DOMContentLoaded', () => {
                        Swal.fire({
                            title: 'Sucesso!',
                            text: 'Conta criada com sucesso!',
                            icon: 'success',
                            confirmButtonColor: '#007bff'
                        });
                    });
                </script>
            </c:if>
            
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