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
<h1>Phản hồi</h1>
<c:url value="/feedbacks" var="action" />
<table class="table table-hover">
    <thead>
        <tr>
            <th>Id</th>
            <th>Thông tin phản hồi</th>
            <th>Mã vé</th>
            <th>Chuyến</th>
            <th>Người phản hồi</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${feedbacks}" var="f">
            <tr>
                <td>${f.id}</td>
                <td>${f.comment}</td>
                <td>${f.ticketId.id}</td>
                <td>${f.ticketId.tripId.routeId.startLocation} - ${f.ticketId.tripId.routeId.endLocation}</td>
                <td>${f.ticketId.userId}</td>
                  <td>
                    <c:url value="/feedbacks/edit?feedbackId=${f.id}&tripId=${f.ticketId.tripId.id}" var="api" />
                    <a href="${api}" class="btn btn-success">Cập nhật</a>

                    <c:url value="/api/feedbacks/${f.id}" var="delUrl" />
                    <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
                    <button class="btn btn-primary" ${delClick}>Xoá</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<c:url value="/js/delAPI.js" var="delAPI" />
<script src="${delAPI}"></script>