<%-- 
    Document   : roles.addOrUpdate
    Created on : Aug 3, 2023, 3:21:04 PM
    Author     : Duc Hung
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<h1>TẠO ROLE</h1>

<c:url value="/roles/" var="action" />
<form:form modelAttribute="role" method="post" action="${action}" enctype="multipart/form-data"> 
      <form:hidden path="id" />
    <div class="form-floating mb-3 mt-3">
        <form:input type="text" class="form-control" path="title" id="title" placeholder="Title" name="title" />
        <label for="name">Tên role</label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <button class="btn btn-info mt-1" type="submit">
            <c:choose>
                <c:when test="${role.id != null}">Cập nhật role</c:when>
                <c:otherwise>Tạo role</c:otherwise>
            </c:choose>
        </button>
    </div>

</form:form>
