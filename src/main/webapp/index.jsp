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
    <title>Login</title>
</head>
<body>
<div class="d-flex flex-column min-vh-100 bg-light">
    <c:set var="navbarFull" value="true" scope="request" />
    <jsp:include page="/WEB-INF/pages/includes/navbar.jsp" />

    <div class="d-flex flex-grow-1 justify-content-center align-items-center pb-5">
        <div class="card shadow border-0" style="width: 360px; border-top: 4px solid #0d6efd !important;">
            <div class="card-body p-4">
                <h3 class="text-center fw-bold mb-4" style="color: #032947;">Login</h3>
                <form action="login" method="post">
                    <div class="mb-3">
                        <input type="email" name="email" class="form-control form-control-lg" placeholder="E-mail" required>
                    </div>
                    <div class="mb-4">
                        <input type="password" name="senha" class="form-control form-control-lg" placeholder="Senha" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold">Entrar</button>
                </form>
                <div class="text-center mt-3">
                    <a href="cadastro" class="text-decoration-none fw-semibold">Criar conta</a>
                </div>
                <c:if test="${not empty erro}">
                    <div class="alert alert-danger mt-3 mb-0 text-center fw-bold">${erro}</div>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/includes/footer.jsp" />
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>