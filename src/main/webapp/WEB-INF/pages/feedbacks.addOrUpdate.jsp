<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<h1>PHẢN HỒI</h1>

<c:url value="/feedbacks/" var="action" />
<form:form modelAttribute="feedback" method="post" action="${action}" enctype="multipart/form-data">
    <form:hidden path="id" />

    <div class="form-floating mb-3 mt-3">
        <form:input type="text" class="form-control" path="comment" id="comment" placeholder="comment" name="comment" />
        <label for="comment">Thông tin phản hồi</label>
    </div>  

    <div class="form-floating mb-3 mt-3">
        <form:select class="form-select" id="ticketId" name="ticketId" path="ticketId">
          <option value="${feedback.ticketId.id}" selected>${feedback.ticketId.id}</option>
        </form:select>
        <label for="ticketId" class="form-label">Mã vé</label>
    </div>

    <div class="form-floating mb-3 mt-3">
        <button class="btn btn-info mt-1" type="submit">
            <c:choose>
                <c:when test="${feedback.id != null}">Cập nhật phản hồi</c:when>
                <c:otherwise>Thêm phản hồi</c:otherwise>
            </c:choose>
        </button>
    </div>
</form:form>
