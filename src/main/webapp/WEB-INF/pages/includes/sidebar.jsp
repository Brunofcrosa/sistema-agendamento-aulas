<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<aside class="sidebar-container bg-navy-custom">
  <nav class="sidebar-menu-wrapper">
    <ul class="menu-nav">
      <li class="menu-section">
        <h4 class="menu-section-text">Principal</h4>
      </li>
      <li class="menu-item ${pageName == 'home' ? 'menu-item-active' : ''}">
        <a class="menu-link" href="home">
          <i class="menu-link-icon fa-solid fa-house"></i>
          <span class="menu-link-text">Página Inicial</span>
        </a>
      </li>

      <li class="menu-section">
        <h4 class="menu-section-text">Gerenciamento</h4>
      </li>
      <li class="menu-item ${pageName == 'salas' && tela != 'encontrar' ? 'menu-item-active' : ''}">
        <a class="menu-link" href="sala">
          <i class="menu-link-icon fa-solid fa-door-open"></i>
          <span class="menu-link-text">Salas</span>
        </a>
      </li>
      <li class="menu-item ${pageName == 'reservas' ? 'menu-item-active' : ''}">
        <a class="menu-link" href="reserva">
          <i class="menu-link-icon fa-solid fa-calendar-check"></i>
          <span class="menu-link-text">Agendamento de Salas</span>
        </a>
      </li>
      <li class="menu-item ${pageName == 'docentes' ? 'menu-item-active' : ''}">
        <a class="menu-link" href="docente">
          <i class="menu-link-icon fa-solid fa-chalkboard-user"></i>
          <span class="menu-link-text">Gerenciar Docentes</span>
        </a>
      </li>

      <%--
      <li class="menu-section">
        <h4 class="menu-section-text">Ferramentas</h4>
      </li>
      <li class="menu-item ${pageName == 'salas' && tela == 'encontrar' ? 'menu-item-active' : ''}">
        <a class="menu-link" href="sala?tela=encontrar">
          <i class="menu-link-icon fa-solid fa-magnifying-glass"></i>
          <span class="menu-link-text">Encontrar Salas</span>
        </a>
      </li>
      --%>
    </ul>
  </nav>
</aside>
