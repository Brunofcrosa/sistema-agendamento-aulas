<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">

<nav class="navbar-custom ${empty sessionScope.usuario || navbarFull ? 'navbar-full' : ''}">
    <div class="navbar-custom__left"></div>

    <div class="navbar-custom__center">
        <img class="navbar-title-logo" src="${pageContext.request.contextPath}/imgs/logo.png" alt="Logotipo do Sistema de Agendamento de Salas de Aula">
    </div>

    <div class="navbar-custom__right">
        <c:if test="${not empty sessionScope.usuario && !navbarFull}">
            <form action="${pageContext.request.contextPath}/logout" method="get" class="form-logout">
                <input type="hidden" name="csrfToken" value="${csrfToken}">
                <button type="submit" class="btn-logout" aria-label="Sair do sistema">
                    <i class="fa-solid fa-arrow-right-from-bracket" aria-hidden="true"></i> Sair
                </button>
            </form>
        </c:if>
    </div>
</nav>