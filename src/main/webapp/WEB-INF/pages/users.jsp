<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<h1>USERS</h1>

<div>
    <c:url value="/users/add" var="createUser" />
    <a href="${createUser}" class="btn btn-info mt-1">Tạo user</a>
</div>
<table class="table table-hover">
    <thead>
        <tr>
            <th>Id</th>
            <th></th>
            <th>Họ</th>
            <th>Tên</th>
            <th>Tài khoản</th>
            <th>Mật khẩu</th>
            <th>Vai trò</th>
            <th></th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${users}" var="u">
            <tr>
                <td>${u.id}</td>
                <td>
                    <img src="${u.avatar}" alt="${u.username}" width="120" />
                </td>
                <td>${u.lastName}</td>
                <td>${u.firstName}</td>
                <td>${u.username}</td>
                <td>${u.password}</td>
                <td>${u.roleId.title}</td>
                <td>
                    <c:url value="/users/${u.id}" var="api" />
                    <a href="${api}" class="btn btn-success">Cập nhật</a>

                    <c:url value="/api/users/${u.id}" var="delUrl" />
                    <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
                    <button class="btn btn-primary" ${delClick}>Xoá</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<c:url value="/js/delAPI.js" var="delAPI" />
<script src="${delAPI}"></script>
