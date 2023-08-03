<%-- Document : routes.add Created on : Aug 1, 2023, 10:13:11 AM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<section class="container pt-4 my-auto h-100">
    <c:url value="/routes/add" var="action" />
    <form:form method="post" action="${action}" modelAttribute="route" accept-charset="utf-8">
        <form:errors path="*" element="div" cssClass="alert alert-danger" />
        <form:hidden path="id" />

        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text" id="basic-addon1">
                    <i class="bi bi-cursor"></i>
                </span>
                <form:input
                    type="text"
                    class="form-control"
                    placeholder="Nơi xuất phát"
                    path="startLocation"
                />
            </div>
            <form:errors path="startLocation" element="div" cssClass="text-danger" />
        </div>

        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text" id="basic-addon1">
                    <i class="bi bi-geo-fill"></i>
                </span>
                <form:input
                    type="text"
                    class="form-control"
                    placeholder="Điểm đến"
                    path="endLocation"
                />
            </div>
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
