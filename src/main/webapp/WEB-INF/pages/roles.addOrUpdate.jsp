<%-- Document : roles.addOrUpdate Created on : Aug 3, 2023, 3:21:04 PM Author : Duc Hung --%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/roles" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
        </div>
        <h3 class="text-center">
            <c:choose>
                <c:when test="${role.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
            vai trò
        </h3>

        <div class="invisible" style="flex: 1"></div>
    </div>

    <c:url value="/roles/" var="action" />
    <form:form method="post" action="${action}" modelAttribute="role" enctype="multipart/form-data">
        <form:hidden path="id" />
        <c:if test="${role.id != null}">
            <form:hidden path="title" />
        </c:if>

        <div class="mb-3">
            <c:choose>
                <c:when test="${role.id == null}">
                    <form:input type="text" class="form-control" path="title" id="title" placeholder="Vai trò" name="title" />
                </c:when>
                <c:otherwise>
                    <input disabled class="form-control" value="${role.title}" />
                </c:otherwise>
            </c:choose>
        </div>

        <div class="mb-3">
            <form:input type="text" class="form-control" path="displayName" id="displayName" placeholder="Tên vai trò hiển thị" name="displayName" />
        </div>

        <button type="submit" class="btn btn-outline-info w-100">
            <c:choose>
                <c:when test="${role.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
        </button>
    </form:form>
</section>
