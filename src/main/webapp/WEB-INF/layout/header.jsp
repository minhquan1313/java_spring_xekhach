<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->

<nav class="navbar navbar-expand-lg border-bottom border-bottom-dark">
    <div class="container-fluid">
        <div class="navbar-brand">${sideBarUIItem.title}</div>

        <c:choose>
            <c:when test="${authenticated_user != null}">
                <div class="btn-group dropstart dropdown">
                    <div class="rounded-pill btn btn-dark d-flex border" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="bg-warning rounded-pill me-3 overflow-hidden" style="aspect-ratio: 1/1; width: 1.6rem">
                            <img class="object-fit-cover w-100 h-100 d-block" src="${user.avatar}" alt="" />
                        </div>
                        <div>${user}</div>
                    </div>
                    <ul class="dropdown-menu">
                        <li>
                            <c:url value="/users?kw=${user.username}" var="detailUrl" />
                            <a href="${detailUrl}" class="dropdown-item"> Thông tin </a>
                        </li>
                        <li>
                            <c:url value="/logout" var="logout" />
                            <a class="dropdown-item" href="${logout}">Đăng xuất</a>
                        </li>
                    </ul>
                </div>
            </c:when>
            <c:otherwise>
                <div class="ms-auto">
                    <c:url value="/login" var="login" />
                    <a href="${login}" class="rounded-pill btn btn-primary">Đăng nhập</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</nav>
