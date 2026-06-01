<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<nav class="navbar navbar-light bg-light shadow-sm sticky-top px-4" style="height: 60px;">
  <div class="container-fluid d-flex justify-content-between align-items-center">

    <div class="navbar-brand mx-auto">
      <img src="${pageContext.request.contextPath}/imgs/logo.png" alt="Agendamento" style="height: 40px; object-fit: contain;">
    </div>

    <div class="d-flex">
      <c:if test="${not empty sessionScope.usuario && !navbarFull}">
        <a href="logout" class="btn btn-outline-secondary btn-sm fw-bold d-flex align-items-center gap-2">
          <i class="fa-solid fa-arrow-right-from-bracket"></i> Sair
        </a>
      </c:if>
    </div>
  </div>
</nav>