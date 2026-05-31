<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/imgs/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <title>Login</title>
</head>
<body>
<c:set var="navbarFull" value="true" scope="request" />
<jsp:include page="/WEB-INF/pages/includes/navbar.jsp" />
<div class="container">
    <div class="box">
        <h2>Login</h2>
        <form action="login" method="post">
            <input type="email" name="email" placeholder="E-mail" required>
            <input type="password" name="senha" placeholder="Senha" required>
            <button type="submit">Entrar</button>
        </form>
        <a href="cadastro">Criar conta</a>
        <c:if test="${not empty erro}">
            <p class="erro">${erro}</p>
        </c:if>
    </div>
</div>

<jsp:include page="/WEB-INF/pages/includes/footer.jsp" />

</body>
</html>

