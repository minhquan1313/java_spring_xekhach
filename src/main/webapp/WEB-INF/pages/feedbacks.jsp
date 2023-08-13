<%-- 
    Document   : feedback
    Created on : Aug 11, 2023, 1:52:07 AM
    Author     : Duc Hung
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
        </div>
        <h3 class="text-center">Phản hồi</h3>
        <div class="invisible" style="flex: 1"></div>
    </div>
    <c:url value="/feedbacks" var="action" />
    <table class="table table-hover">
        <thead>
            <tr>
                <th  scope="col">Id</th>
                <th  scope="col">Thông tin phản hồi</th>
                <th  scope="col">Mã vé</th>
                <th  scope="col">Chuyến</th>
                <th  scope="col">Người phản hồi</th>
                <th  scope="col">Hành động</th>
            </tr>
        </thead>
        <tbody class="table-group-divider">
            <c:forEach items="${feedbacks}" var="f">
                <tr>
                    <th scope="row">${f.id}</th>
                    <td>${f.comment}</td>
                    <td>${f.ticketId.id}</td>
                    <td>${f.ticketId.tripId.routeId.startLocation} - ${f.ticketId.tripId.routeId.endLocation}</td>
                    <td>${f.ticketId.userId}</td>
                    <td>
                        <div class="btn-group float-end">
                            <c:url value="/feedbacks/edit?feedbackId=${f.id}&tripId=${f.ticketId.tripId.id}" var="update" />
                            <a href="${update}" class="btn btn-primary">Cập nhật</a>

                            <c:url value="/api/feedbacks/${f.id}" var="delUrl" />
                            <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
                            <button class="btn btn-danger" ${delClick}>Xoá</button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</section>
<c:url value="/js/delAPI.js" var="delAPI" />
<script src="${delAPI}"></script>