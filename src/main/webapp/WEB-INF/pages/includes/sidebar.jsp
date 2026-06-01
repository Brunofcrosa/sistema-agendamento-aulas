<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<aside class="bg-light border-end shadow-sm d-flex flex-column" style="width: 265px; min-height: calc(100vh - 60px);">
  <div class="p-3 mt-3">
    <ul class="nav flex-column">

      <li class="nav-item mb-2">
        <small class="text-primary fw-bold text-uppercase px-3">Principal</small>
      </li>
      <li class="nav-item">
        <a class="nav-link fw-semibold ${pageName == 'home' ? 'active bg-primary bg-opacity-10 text-primary border-start border-primary border-3' : 'text-dark'}" href="home">
          <i class="fa-solid fa-house me-2"></i> Página Inicial
        </a>
      </li>

      <li class="nav-item mt-4 mb-2">
        <small class="text-primary fw-bold text-uppercase px-3">Gerenciamento</small>
      </li>
      <li class="nav-item">
        <a class="nav-link fw-semibold ${pageName == 'salas' ? 'active bg-primary bg-opacity-10 text-primary border-start border-primary border-3' : 'text-dark'}" href="sala">
          <i class="fa-solid fa-door-open me-2"></i> Salas
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link fw-semibold ${pageName == 'reservas' ? 'active bg-primary bg-opacity-10 text-primary border-start border-primary border-3' : 'text-dark'}" href="reserva">
          <i class="fa-solid fa-calendar-check me-2"></i> Agendamentos
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link fw-semibold ${pageName == 'docentes' ? 'active bg-primary bg-opacity-10 text-primary border-start border-primary border-3' : 'text-dark'}" href="docente">
          <i class="fa-solid fa-chalkboard-user me-2"></i> Docentes
        </a>
      </li>

    </ul>
  </div>
</aside>