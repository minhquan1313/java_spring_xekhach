<%-- Document : routes.add Created on : Aug 1, 2023, 10:13:11 AM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<section class="container pt-4 my-auto h-100">
    <c:url value="/routes/add" var="action" />
    <form:form method="post" action="${action}" modelAttribute="route">
        <form:errors path="*" element="div" cssClass="alert alert-danger" />
        <form:hidden path="id" />

        <div class="form-floating mb-3">
            <form:input type="text" class="form-control" id="startLocation" path="startLocation" />
            <label for="startLocation">Nơi xuất phát</label>
            <form:errors path="startLocation" element="div" cssClass="text-danger" />
        </div>

        <div class="form-floating mb-3">
            <form:input type="text" class="form-control" id="endLocation" path="endLocation" />
            <label for="endLocation">Điểm đến</label>
            <form:errors path="endLocation" element="div" cssClass="text-danger" />
        </div>

        <button type="submit" class="btn btn-primary w-100">
            <c:choose>
                <c:when test="${route.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
        </button>
    </form:form>
</section>
