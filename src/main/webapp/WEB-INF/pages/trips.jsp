<%-- Document : trips Created on : Aug 3, 2023, 2:03:22 PM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<section class="container-fluid mt-4">
    <div class="d-flex align-items-center">
        <a href="#" class="invisible">Thêm</a>

        <h3 class="text-center w-100">Các tuyến xe hiện có</h3>
        <!-- here here here -->
        <c:url value="/trips/add" var="createUrl" />
        <a href="${createUrl}" class="btn btn-outline-info text-nowrap">Thêm</a>
    </div>

    <table class="table table-hover">
        <thead>
            <tr>
                <th scope="col">id</th>
                <th scope="col">Khởi hành</th>
                <th scope="col">Điểm đi</th>
                <th scope="col">Điểm đến</th>
                <th scope="col">Tên tài xế</th>
                <th scope="col">Xe</th>
                <th scope="col">Giá</th>
            </tr>
        </thead>
        <tbody class="table-group-divider">
            <c:forEach items="${trips}" var="item">
                <tr>
                    <th scope="row">${item.id}</th>
                    <td>${item.startAt}</td>
                    <td>${item.routeId.startLocation}</td>
                    <td>${item.routeId.endLocation}</td>
                    <td>${item.driverId.lastName} ${item.driverId.firstName}</td>
                    <td>${item.busId.licensePlate}</td>
                    <td>${item.price}</td>
                    <td>
                        <c:url value="/trips/${item.id}" var="detailUrl" />
                        <a href="${detailUrl}" class="btn btn-primary">Xem chi tiết</a>

                        <c:url value="/trips/edit/${item.id}" var="editUrl" />
                        <a href="${editUrl}" class="btn btn-primary">Sửa</a>

                        <c:url value="/api/trips/${item.id}" var="delUrl" />
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
