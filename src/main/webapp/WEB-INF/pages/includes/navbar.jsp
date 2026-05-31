<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">

<nav class="navbar-custom ${empty sessionScope.usuario || navbarFull ? 'navbar-full' : ''}">
  <div class="navbar-custom__left"></div>

  <div class="navbar-custom__center">
    <img class="navbar-title-logo" src="${pageContext.request.contextPath}/imgs/logo.png" alt="Agendamento de Salas de Aula">
  </div>

  <div class="navbar-custom__right">
    <c:if test="${not empty sessionScope.usuario && !navbarFull}">
      <a href="logout" class="btn-logout"><i class="fa-solid fa-arrow-right-from-bracket"></i> Sair</a>
    </c:if>
  </div>
</nav>

