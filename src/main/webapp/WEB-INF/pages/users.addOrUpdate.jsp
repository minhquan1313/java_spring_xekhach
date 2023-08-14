<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/users" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
        </div>
        <h3 class="text-center">Users</h3>
        <div class="invisible" style="flex: 1"></div>
    </div>
    <c:url value="/users/" var="action" />
    <form:form modelAttribute="user" method="post" action="${action}" enctype="multipart/form-data">
        <form:errors path="*" element="div" cssClass="alert alert-danger" />

        <form:hidden path="id" />
        <form:hidden path="avatar" />
        <c:if test="${empty user.id}">
            <div class="form-floating mb-3 mt-3">
                <form:input
                    type="text"
                    class="form-control"
                    path="username"
                    id="username"
                    placeholder="Username"
                    name="username"
                    />
                <label for="name">Tên tài khoản</label>
            </div>
        </c:if>
        <c:if test="${not empty user.id}">
            <div class="form-floating mb-3 mt-3">
                <form:input
                    type="text"
                    class="form-control"
                    path="username"
                    id="username"
                    placeholder="Username"
                    name="username"
                    readonly="true"
                    />
                <label for="name">Tên tài khoản</label>
            </div>
        </c:if>

        <div class="form-floating mb-3 mt-3">
            <form:input
                type="text"
                class="form-control"
                path="password"
                id="password"
                placeholder="Password"
                name="password"
                />
            <label for="name">Mật khẩu</label>
        </div>
        <div class="form-floating mb-3 mt-3">
            <form:input
                type="text"
                class="form-control"
                path="lastName"
                id="lastName"
                placeholder="Họ"
                name="lastName"
                />
            <label for="name">Họ</label>
        </div>
        <div class="form-floating mb-3 mt-3">
            <form:input
                type="text"
                class="form-control"
                path="firstName"
                id="firstName"
                placeholder="Tên"
                name="firstName"
                />
            <label for="name">Tên</label>
        </div>
        <div class="form-floating mb-3 mt-3">
            <form:select class="form-select" id="role" name="role" path="roleId">
                <c:forEach items="${roles}" var="r">
                    <c:choose>
                        <c:when test="${r.id == user.roleId.id}">
                            <option value="${r.id}" selected>${r.displayName}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${r.id}">${r.displayName}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </form:select>
            <label for="role" class="form-label">Vai trò</label>
        </div>
        <div class="form-floating mb-3 mt-3">
            <form:input type="file" class="form-control" path="file" id="file" placeholder="Avatar" />
            <label for="file">Avatar</label>
        </div>
        <div class="form-floating mb-3 mt-3">
            <button class="btn btn-outline-info w-100" type="submit">
                <c:choose>
                    <c:when test="${user.id != null}">Cập nhật</c:when>
                    <c:otherwise>Thêm</c:otherwise>
                </c:choose>
            </button>
        </div>
    </section>
</form:form>