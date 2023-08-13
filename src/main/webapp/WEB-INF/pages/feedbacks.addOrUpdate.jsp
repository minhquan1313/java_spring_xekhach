<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/tickets" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
        </div>
        <h3 class="text-center">
            <c:choose>
                <c:when test="${feedback.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
            phản hồi
        </h3>
        <div class="invisible" style="flex: 1"></div>
    </div>
    <c:url value="/feedbacks/" var="action" />
    <form:form modelAttribute="feedback" method="post" action="${action}" enctype="multipart/form-data">
        <form:hidden path="id" />
        <div class="form-floating mb-3 mt-3">
            <form:textarea class="form-control"  path="comment" id="comment" placeholder="comment" name="comment" rows="4" />
            <label for="comment">Nhập phản hồi</label>
        </div>
        <div class="form-floating mb-3 mt-3">
            <form:select class="form-select" id="ticketId" name="ticketId" path="ticketId">
                <option value="${feedback.ticketId.id}" selected>${feedback.ticketId.id}</option>
            </form:select>
            <label for="ticketId" class="form-label">Mã vé</label>
        </div>

        <div class="form-floating mb-3 mt-3">
            <button class="btn btn-outline-info w-100" type="submit">
                <c:choose>
                    <c:when test="${feedback.id != null}">Cập nhật phản hồi</c:when>
                    <c:otherwise>Thêm phản hồi</c:otherwise>
                </c:choose>
            </button>
        </div>
    </form:form>
</section>
