<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->
<c:url value="/" var="action" />
<section class="container mt-3">
    <h1>Users</h1>
    <table class="table table-hover">
        <thead>
            <tr>
                <th>Id</th>
                <th>Họ</th>
                <th>Tên</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${users}" var="u">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.lastName}</td>
                    <td>${u.firstName} </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</section>
<c:url value="/js/main.js" var="mainJs" />
