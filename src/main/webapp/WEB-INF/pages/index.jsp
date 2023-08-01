<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->
<c:url value="/" var="action" />
<section class="container mt-3">
    <h1>Hello Đây là java spring xe khách</h1>

    <div class="">
        <c:url value="/routes" var="routes" />
        <a href="${routes}">Routes</a>
    </div>

    <div class="">
        <c:url value="/buses" var="buses" />
        <a href="${buses}">Buses</a>
    </div>
</section>
<c:url value="/js/main.js" var="mainJs" />
<script src="${mainJs}"></script>
