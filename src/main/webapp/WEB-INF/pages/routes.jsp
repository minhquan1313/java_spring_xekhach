<%-- Document : routes Created on : Aug 1, 2023, 10:12:59 AM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<section class="container mt-4">
    <div class="d-flex align-items-center">
        <a href="#" class="invisible">Thêm tuyến</a>

        <h3 class="text-center w-100">Các tuyến xe</h3>

        <c:url value="/routes/add" var="createUrl" />
        <a href="${createUrl}" class="btn btn-outline-info text-nowrap">Thêm tuyến</a>
    </div>

    <table class="table table-hover">
        <thead>
            <tr>
                <th scope="col">id</th>
                <th scope="col">Khởi hành</th>
                <th scope="col">Điểm đến</th>
                <th scope="col">Hành động</th>
            </tr>
        </thead>
        <tbody class="table-group-divider">
            <c:forEach items="${routes}" var="route">
                <tr>
                    <th scope="row">${route.id}</th>
                    <td>${route.startLocation}</td>
                    <td>${route.endLocation}</td>
                    <td>
                        <!--  -->
                        <c:url value="/routes/edit/${route.id}" var="editUrl" />
                        <a href="${editUrl}" class="btn btn-primary">Sửa</a>

                        <c:url value="/api/routes/${route.id}" var="delUrl" />
                        <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
                        <button class="btn btn-danger" ${delClick}>Xoá</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</section>

<c:url value="/js/delAPI.js" var="delAPI" />
<script src="${delAPI}"></script>
