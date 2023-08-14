<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
        </div>

        <h3 class="text-center">Vai trò</h3>
        <div class="d-flex justify-content-end" style="flex: 1">
            <c:url value="/roles/add" var="createRole" />
            <a href="${createRole}" class="btn btn-outline-info text-nowrap">Thêm</a>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th scope="col">id</th>
                    <th scope="col">Vai trò</th>
                    <th scope="col">Tên vai trò</th>
                    <th scope="col">Hành động</th>
                </tr>
            </thead>
            <tbody class="table-group-divider">
                <c:forEach items="${roles}" var="r">
                    <tr>
                        <th scope="row">${r.id}</th>
                        <td>${r.title}</td>
                        <td>${r.displayName}</td>
                        <td>
                            <div class="btn-group float-end">
                                <c:url value="/roles/${r.id}" var="editUrl" />
                                <a href="${editUrl}" class="btn btn-primary">Sửa</a>

                                <c:url value="/api/roles/${r.id}" var="delUrl" />
                                <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
                                <button class="btn btn-danger" ${delClick}>Xoá</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</section>

<c:url value="/js/delAPI.js" var="delAPI" />
<script src="${delAPI}"></script>
