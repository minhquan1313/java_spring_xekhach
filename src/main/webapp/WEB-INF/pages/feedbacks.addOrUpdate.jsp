<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--  -->
<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/feedbacks" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">
                <spring:message code="ui.global.back" />
            </a>
        </div>
        <h3 class="text-center">
            <c:choose>
                <c:when test="${feedback.id == null}">
                    <spring:message code="ui.global.add" />
                </c:when>
                <c:otherwise>
                    <spring:message code="ui.global.update" />
                </c:otherwise>
            </c:choose>
            <spring:message code="ui.feedback" var="__header_title" />
            ${fn:toLowerCase(__header_title)}
        </h3>
        <div class="invisible" style="flex: 1"></div>
    </div>
    <c:url value="/feedbacks/" var="action" />
    <form:form modelAttribute="feedback" method="post" action="${action}" enctype="multipart/form-data">
        <form:hidden path="id" />
        <div class="form-floating mb-3 mt-3">
            <form:textarea class="form-control" path="comment" id="comment" name="comment" rows="4" />
            <label for="comment">
                <spring:message code="ui.feedback.comment" />
            </label>
        </div>
        <div class="form-floating mb-3 mt-3">
            <form:select class="form-select" id="ticketId" name="ticketId" path="ticketId">
                <option value="${feedback.ticketId.id}" selected>${feedback.ticketId.id}</option>
            </form:select>
            <label for="ticketId" class="form-label">
                <spring:message code="ui.ticket.id" />
            </label>
        </div>

        <div class="form-floating mb-3 mt-3">
            <button class="btn btn-outline-info w-100" type="submit">
                <c:choose>
                    <c:when test="${feedback.id != null}"><spring:message code="ui.global.update" /> </c:when>
                    <c:otherwise>
                        <spring:message code="ui.global.add" />
                    </c:otherwise>
                </c:choose>
            </button>
        </div>
    </form:form>
</section>
