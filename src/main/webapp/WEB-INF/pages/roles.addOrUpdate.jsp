<%-- Document : roles.addOrUpdate Created on : Aug 3, 2023, 3:21:04 PM Author :
Duc Hung --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->
<section class="container py-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/roles" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">
                <spring:message code="ui.global.back" />
            </a>
        </div>
        <h3 class="text-center">
            <c:choose>
                <c:when test="${role.id == null}">
                    <spring:message code="ui.global.add" />
                </c:when>
                <c:otherwise>
                    <spring:message code="ui.global.update" />
                </c:otherwise>
            </c:choose>
            <spring:message code="ui.role" var="__role" />
            ${fn:toLowerCase(__role)}
        </h3>

        <div class="invisible" style="flex: 1"></div>
    </div>

    <c:url value="/roles/" var="action" />
    <form:form
        method="post"
        action="${action}"
        modelAttribute="role"
        enctype="multipart/form-data"
        >
        <form:hidden path="id" />
        <c:if test="${role.id != null}">
            <form:hidden path="title" />
        </c:if>

        <div class="mb-3">
            <c:choose>
                <c:when test="${role.id == null}">
                    <spring:message code="ui.role.role_name" var="__role_name" />
                    <form:input
                        type="text"
                        class="form-control"
                        path="title"
                        id="title"
                        placeholder="${__role_name}"
                        name="title"
                        />
                </c:when>
                <c:otherwise>
                    <input disabled class="form-control" value="${role.title}" />
                </c:otherwise>
            </c:choose>
            <form:errors
                path="title"
                element="div"
                cssClass="alert alert-danger" />
        </div>

        <div class="mb-3">
            <spring:message
                code="ui.role.role_display_name"
                var="__role_display_name"
                />
            <form:input
                type="text"
                class="form-control"
                path="displayName"
                id="displayName"
                placeholder="${__role_display_name}"
                name="displayName"
                />
                <form:errors
                path="displayName"
                element="div"
                cssClass="alert alert-danger" />
        </div>

        <button type="submit" class="btn btn-outline-info w-100">
            <c:choose>
                <c:when test="${role.id == null}">
                    <spring:message code="ui.global.add" />
                </c:when>
                <c:otherwise>
                    <spring:message code="ui.global.update" />
                </c:otherwise>
            </c:choose>
        </button>
    </form:form>
</section>
