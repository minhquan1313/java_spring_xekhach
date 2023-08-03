<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<h1>TẠO USER</h1>

<c:url value="/users/" var="action" />
<form:form modelAttribute="user" method="post" action="${action}" enctype="multipart/form-data">
    <form:errors path="*" element="div" cssClass="alert alert-danger" />
    
    <form:hidden path="id"/>
    <form:hidden path="avatar"/>
    <div class="form-floating mb-3 mt-3">
        <form:input type="text" class="form-control" path="username" id="username" 
                    placeholder="Username" name="username" />
        <label for="name">Username</label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <form:input type="text" class="form-control" path="password" id="password" 
                    placeholder="Password" name="password" />
        <label for="name">Password</label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <form:input type="text" class="form-control" path="lastName" id="lastName" 
                    placeholder="Họ" name="lastName" />
        <label for="name">Họ</label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <form:input type="text" class="form-control" path="firstName" id="firstName" 
                    placeholder="Tên" name="firstName" />
        <label for="name">Tên</label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <form:select class="form-select" id="role" name="role" path="roleId">
            <c:forEach items="${roles}" var="r">
                <c:choose>
                    <c:when test="${r.id == user.roleId.id}">
                        <option value="${r.id}" selected> ${r.title}</option>
                    </c:when>
                    <c:otherwise>
                        <option value="${r.id}"> ${r.title}</option>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </form:select>
        <label for="role" class="form-label">Role</label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <form:input type="file" class="form-control" path="file" id="file" 
                    placeholder="Avatar"/>
        <label for="file">Avatar</label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <button class="btn btn-info mt-1" type="submit">
            <c:choose>
                <c:when test="${user.id != null}">
                    Cập nhật sản phẩm
                </c:when>
                <c:otherwise>
                    Thêm sản phẩm 
                </c:otherwise>
            </c:choose>
        </button>
    </div>
</form:form>