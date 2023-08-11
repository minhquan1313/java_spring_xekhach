<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:url value="/" var="action" />
<nav class="navbar navbar-expand-lg border-bottom border-bottom-dark">
    <div class="container">
        <a class="navbar-brand" href="${action}">${app_name}</a>
        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarNav"
            aria-controls="navbarNav"
            aria-expanded="false"
            aria-label="Toggle navigation"
        >
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto"></ul>
            <c:choose>
                <c:when test="${pageContext.request.userPrincipal.name != null}">
                    <div class="d-flex">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="${action}">
                                    ${pageContext.request.userPrincipal.name}
                                </a>
                            </li>

                            <li class="nav-item">
                                <c:url value="/logout" var="logout" />
                                <a class="btn btn-outline-warning" href="${logout}">Đăng xuất</a>
                            </li>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="d-flex">
                        <c:url value="/login" var="login" />
                        <a class="btn btn-info" href="${login}">Đăng nhập</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>
