<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/imgs/favicon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <title>Painel</title>
    <style>
        .hover-card { transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out; }
        .hover-card:hover { transform: translateY(-3px); box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important; }
    </style>
</head>
<body>
<div class="d-flex flex-column min-vh-100 bg-light">
    <c:set var="pageName" value="home" scope="request" />
    <jsp:include page="/WEB-INF/pages/includes/navbar.jsp" />

    <div class="d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/pages/includes/sidebar.jsp" />

        <main class="flex-grow-1 p-4 d-flex flex-column align-items-center">
            <div class="w-100" style="max-width: 1120px;">
                <h2 class="fs-4 fw-bold text-dark mb-4" style="color: #032947;">Gerenciador</h2>

                <div class="row g-4">
                    <div class="col-md-4">
                        <a href="sala?tela=listar" class="text-decoration-none">
                            <div class="card border-0 shadow-sm h-100 hover-card p-3">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <div class="text-primary fs-3"><i class="fa-solid fa-door-open"></i></div>
                                    <div class="flex-grow-1">
                                        <h5 class="card-title fw-bold text-dark mb-1 fs-5">Gerenciar salas</h5>
                                        <p class="card-text text-muted small mb-0">Operações referentes ao gerenciamento de salas.</p>
                                    </div>
                                    <div class="text-primary"><i class="fa-solid fa-arrow-right"></i></div>
                                </div>
                            </div>
                        </a>
                    </div>

                    <div class="col-md-4">
                        <a href="reserva?tela=listar" class="text-decoration-none">
                            <div class="card border-0 shadow-sm h-100 hover-card p-3">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <div class="text-primary fs-3"><i class="fa-solid fa-calendar-check"></i></div>
                                    <div class="flex-grow-1">
                                        <h5 class="card-title fw-bold text-dark mb-1 fs-5">Alocamento de salas</h5>
                                        <p class="card-text text-muted small mb-0">Operações referentes ao alocamento de salas.</p>
                                    </div>
                                    <div class="text-primary"><i class="fa-solid fa-arrow-right"></i></div>
                                </div>
                            </div>
                        </a>
                    </div>

                    <div class="col-md-4">
                        <a href="docente?tela=listar" class="text-decoration-none">
                            <div class="card border-0 shadow-sm h-100 hover-card p-3">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <div class="text-primary fs-3"><i class="fa-solid fa-chalkboard-user"></i></div>
                                    <div class="flex-grow-1">
                                        <h5 class="card-title fw-bold text-dark mb-1 fs-5">Gerenciar docentes</h5>
                                        <p class="card-text text-muted small mb-0">Operações referentes ao gerenciamento de docentes.</p>
                                    </div>
                                    <div class="text-primary"><i class="fa-solid fa-arrow-right"></i></div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>