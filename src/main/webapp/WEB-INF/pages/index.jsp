<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->

<section class="container mt-3">
    <h1>Hello Đây là java spring xe khách</h1>

    <div class="h3">
        <c:url value="/users" var="users" />
        <a href="${users}">users</a>
    </div>

    <div class="h3">
        <c:url value="/roles" var="roles" />
        <a href="${roles}">Roles</a>
    </div>

    <div class="h3">
        <c:url value="/routes" var="routes" />
        <a href="${routes}">Routes</a>
    </div>

    <div class="h3">
        <c:url value="/buses" var="buses" />
        <a href="${buses}">Buses</a>
    </div>

    <div class="h3">
        <c:url value="/trips" var="trips" />
        <a href="${trips}">trips</a>
    </div>

    <div class="h3">
        <c:url value="/tickets" var="tickets" />
        <a href="${tickets}">tickets</a>
    </div>

    <div class="h3">
        <c:url value="/revenue" var="revenue" />
        <a href="${revenue}">revenue</a>
    </div>
</section>
