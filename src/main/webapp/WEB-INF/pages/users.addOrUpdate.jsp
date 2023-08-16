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
<section class="container py-4">
  <div class="d-flex align-items-center mb-3">
    <div class="d-flex justify-content-start" style="flex: 1">
      <c:url value="/users" var="backUrl" />
      <a href="${backUrl}" class="btn btn-outline-info text-nowrap">
        <spring:message code="ui.global.back" />
      </a>
    </div>
    <h3 class="text-center">
      <c:choose>
        <c:when test="${user.id == null}">
          <spring:message code="ui.global.add" />
        </c:when>
        <c:otherwise>
          <spring:message code="ui.global.update" />
        </c:otherwise>
      </c:choose>

      <spring:message code="ui.user" var="__user" />
      ${fn:toLowerCase(__user)}
    </h3>
    <div class="invisible" style="flex: 1"></div>
  </div>
  <c:url value="/users/" var="action" />
  <form:form
    modelAttribute="user"
    method="post"
    action="${action}"
    enctype="multipart/form-data"
  >
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
          name="username"
        />
        <label for="name">
          <spring:message code="ui.user.username" />
        </label>
      </div>
    </c:if>
    <c:if test="${not empty user.id}">
      <div class="form-floating mb-3 mt-3">
        <form:input
          type="text"
          class="form-control"
          path="username"
          id="username"
          name="username"
          readonly="true"
        />
        <label for="name">
          <spring:message code="ui.user.username" />
        </label>
      </div>
    </c:if>

    <div class="form-floating mb-3 mt-3">
      <form:input
        type="text"
        class="form-control"
        path="password"
        id="password"
        name="password"
      />
      <label for="name">
        <spring:message code="ui.user.password" />
      </label>
    </div>
    <div class="form-floating mb-3 mt-3">
      <form:input
        type="text"
        class="form-control"
        path="lastName"
        id="lastName"
        name="lastName"
      />
      <label for="name">
        <spring:message code="ui.user.last_name" />
      </label>
    </div>
    <div class="form-floating mb-3 mt-3">
      <form:input
        type="text"
        class="form-control"
        path="firstName"
        id="firstName"
        name="firstName"
      />
      <label for="name">
        <spring:message code="ui.user.first_name" />
      </label>
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
      <label for="role" class="form-label">
        <spring:message code="ui.user.role" />
      </label>
    </div>
    <div class="form-floating mb-3 mt-3">
      <form:input type="file" class="form-control" path="file" id="file" />
      <label for="file">
        <spring:message code="ui.global.image" />
      </label>
    </div>
    <div class="form-floating mb-3 mt-3">
      <button class="btn btn-outline-info w-100" type="submit">
        <c:choose>
          <c:when test="${user.id != null}">
            <spring:message code="ui.global.update" />
          </c:when>
          <c:otherwise>
            <spring:message code="ui.global.add" />
          </c:otherwise>
        </c:choose>
      </button>
    </div>
  </form:form>
</section>
