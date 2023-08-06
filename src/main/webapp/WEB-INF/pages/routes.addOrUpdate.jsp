<%-- Document : routes.add Created on : Aug 1, 2023, 10:13:11 AM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/routes" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
        </div>
        <h3 class="text-center">
            <c:choose>
                <c:when test="${route.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
            tuyến xe
        </h3>

        <div class="invisible" style="flex: 1"></div>
    </div>

    <c:url value="/routes/add" var="action" />
    <form:form
        method="post"
        action="${action}"
        modelAttribute="route"
        enctype="multipart/form-data"
    >
        <form:errors path="*" element="div" cssClass="alert alert-danger" />
        <form:hidden path="id" />

        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
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
                <span class="input-group-text">
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
        <button type="submit" class="btn btn-outline-info w-100">
            <c:choose>
                <c:when test="${route.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
        </button>
    </form:form>
</section>
