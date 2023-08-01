<%-- Document : routes Created on : Aug 1, 2023, 10:12:59 AM Author : Binh --%> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="/js/delAPI.js" defer></script>
<section class="container mt-4">
    <div class="d-flex align-items-center">
        <a href="#" class="invisible">Thêm route</a>

        <h3 class="text-center w-100">Các tuyến xe</h3>

        <c:url value="/routes/add" var="createRouteUrl" />
        <a href="${createRouteUrl}" class="btn btn-primary text-nowrap">Thêm route</a>
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
                        <c:url value="/routes/edit/${route.id}" var="editRouteUrl" />
                        <a href="${editRouteUrl}" class="btn btn-primary">Sửa</a>

                        <c:url value="/routes/${route.id}" var="delRouteUrl" />
                        <c:set value="onclick=(delAPI(${delRouteUrl}))" var="delRouteClick" />
                        <button class="btn btn-primary" ${delRouteClick}>Xoá</button>
                    </td>
                </tr></c:forEach
            >
        </tbody>
    </table>
</section>
