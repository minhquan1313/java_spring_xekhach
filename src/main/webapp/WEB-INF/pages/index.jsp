<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->

<section class="container mt-3">

    <h1>USERS</h1>

    <div>
        <a href="<c:url value="/users" />" class="btn btn-info mt-1">Tạo user</a>
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
                <td>${u.firstName} </td>
                <td>${u.username} </td>
                <td>${u.password} </td>  
                <td>
            <c:choose>
                <c:when test="${u.roleId.id == 1}">
                    Admin
                </c:when>
                <c:when test="${u.roleId.id == 2}">
                    Staff
                </c:when>
                <c:when test="${u.roleId.id == 3}">
                    Driver
                </c:when>
                <c:when test="${u.roleId.id == 4}">
                    User
                </c:when>
                <c:otherwise>
                    Không xác định
                </c:otherwise>
            </c:choose>
            </td>
            <td>
            <c:url value="/users/${u.id}" var = "api"/>
            <a href="${api}" class="btn btn-success">Cập nhật</a>
            <button class="btn btn-danger" onclick="deleteUser('${api}')">Xóa</button>
            </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
</section>
<c:url value="/js/main.js" var="mainJs" />
<script src="${mainJs}"></script>
