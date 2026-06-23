<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath}/imgs/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css?v=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sidebar.css?v=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
    <title>Painel</title>
</head>
<body>
<div class="page-wrapper">
    <c:set var="pageName" value="home" scope="request" />
    <jsp:include page="/WEB-INF/pages/includes/navbar.jsp" />
    
    <div class="app-shell">
        <jsp:include page="/WEB-INF/pages/includes/sidebar.jsp" />
        
        <main class="main-content">
            <section class="home-section">
                
                <h2 class="section-title">Ferramentas</h2>
                <div class="tool-card-row">
                    <a class="tool-card" href="${pageContext.request.contextPath}/sala?tela=encontrar">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <div class="card-text">
                            <strong>Buscar sala ideal</strong>
                            <p>Encontre a sala perfeita com base em filtros.</p>
                        </div>
                        <i class="fa-solid fa-arrow-right icon-arrow"></i>
                    </a>
                </div>

                <h2 class="section-title">Gerenciador</h2>
                <div class="tool-card-row">
                    <a class="tool-card" href="${pageContext.request.contextPath}/sala?tela=listar">
                        <i class="fa-solid fa-door-open"></i>
                        <div class="card-text">
                            <strong>Gerenciar salas</strong>
                            <p>Operações referentes ao gerenciamento de salas.</p>
                        </div>
                        <i class="fa-solid fa-arrow-right icon-arrow"></i>
                    </a>
                    
                    <a class="tool-card" href="${pageContext.request.contextPath}/reserva?tela=listar">
                        <i class="fa-solid fa-calendar-check"></i>
                        <div class="card-text">
                            <strong>Alocamento de salas</strong>
                            <p>Operações referentes ao alocamento de salas.</p>
                        </div>
                        <i class="fa-solid fa-arrow-right icon-arrow"></i>
                    </a>
                    
                    <a class="tool-card" href="${pageContext.request.contextPath}/docente?tela=listar">
                        <i class="fa-solid fa-chalkboard-user"></i>
                        <div class="card-text">
                            <strong>Gerenciar docentes</strong>
                            <p>Operações referentes ao gerenciamento de docentes.</p>
                        </div>
                        <i class="fa-solid fa-arrow-right icon-arrow"></i>
                    </a>
                </div>
            </section>
        </main>
    </div>
</div>
</body>
</html>