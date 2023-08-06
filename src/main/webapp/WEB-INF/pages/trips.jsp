<%-- Document : trips Created on : Aug 3, 2023, 2:03:22 PM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--  -->
<section class="container my-4">
    <div class="container">
        <div class="d-flex align-items-center mb-3">
            <div class="d-flex justify-content-start" style="flex: 1">
                <c:url value="/" var="backUrl" />
                <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
            </div>

            <h3 class="text-center">Các chuyến xe hiện có</h3>
            <div class="d-flex justify-content-end" style="flex: 1">
                <c:url value="/trips/find" var="findUrl" />
                <a href="${findUrl}" class="btn btn-outline-info text-nowrap me-2">Tìm kiếm</a>

                <c:url value="/trips/add" var="createUrl" />
                <a href="${createUrl}" class="btn btn-outline-info text-nowrap">Thêm</a>
            </div>
        </div>
    </div>
    <div class="table-responsive">
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
                        <td>
                            <fmt:formatDate value="${item.startAt}" pattern="${date_pattern}" />
                        </td>
                        <td>${item.routeId.startLocation}</td>
                        <td>${item.routeId.endLocation}</td>
                        <td>${item.driverId.lastName} ${item.driverId.firstName}</td>
                        <td>
                            <c:url value="/buses/${item.busId.id}" var="busDetail" />
                            <a href="${busDetail}"> ${item.busId.licensePlate}</a>
                        </td>
                        <td>
                            <fmt:formatNumber
                                type="number"
                                maxFractionDigits="0"
                                value="${item.price}"
                            />
                            VNĐ
                        </td>
                        <td>
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
    </div>
</section>

<c:url value="/js/delAPI.js" var="delAPI" />
<script src="${delAPI}"></script>
