<%-- Document : bus.addOrUpdate Created on : Aug 1, 2023, 3:52:55 PM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<section class="container pt-4 my-auto h-100">
    <c:url value="/buses/add" var="action" />
    <form:form method="post" action="${action}" modelAttribute="bus" enctype="multipart/form-data">
        <form:errors path="*" element="div" cssClass="alert alert-danger" />
        <form:hidden path="id" />
        <form:hidden path="image" />

        <div class="input-group mb-3">
            <span class="input-group-text" id="basic-addon1">
                <i class="bi bi-cursor"></i>
            </span>
            <form:input
                type="text"
                class="form-control"
                placeholder="Biển số xe"
                path="licensePlate"
                />
            <form:errors path="startLocation" element="div" cssClass="text-danger" />
        </div>

        <c:if test="${bus.id != null}">
            <div class="mb-3">
                <img
                    src="${bus.image}"
                    width="300"
                    class="img-thumbnail rounded mx-auto d-block"
                    alt="..."
                    />
            </div>
        </c:if>

        <div class="mb-3">
            <label for="formFile" class="form-label">Chọn ảnh</label>
            <form:input class="form-control" type="file" id="formFile" path="file" />
        </div>

        <button type="submit" class="btn btn-primary w-100">
            <c:choose>
                <c:when test="${bus.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
        </button>
    </form:form>
</section>
