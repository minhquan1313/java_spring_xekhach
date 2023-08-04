<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<h1>ROLES</h1>

<div>
    <c:url value="/roles/add" var="createRole" />
    <a href="${createRole}" class="btn btn-info mt-1">Tạo Role</a>
</div>
<table class="table table-hover">
    <thead>
        <tr>
            <th>Id</th>
            <th>Tên</th>
            <th></th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${roles}" var="r">
            <tr>
                <td>${r.id}</td>
                <td>${r.title}</td>
                <td>
                    <c:url value="/roles/${r.id}" var="api" />
                    <a href="${api}" class="btn btn-success">Cập nhật</a>

                    <c:url value="/api/roles/${r.id}" var="delUrl" />
                    <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
                    <button class="btn btn-primary" ${delClick}>Xoá</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<c:url value="/js/delAPI.js" var="delAPI" />
<script src="${delAPI}"></script>

