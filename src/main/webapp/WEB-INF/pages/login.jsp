<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->

<section class="container d-flex flex-column h-100 py-4">
  <c:url value="/login" var="action" />
  <form class="d-flex flex-column my-auto" method="post" action="${action}">
    <div class="form-floating mb-3">
      <spring:message code="ui.user.username" var="__username" />
      <input
        type="text"
        class="form-control"
        id="name"
        placeholder="${__username}"
        name="username"
      />
      <label for="name">${__username}</label>
    </div>

    <div class="form-floating mb-3">
      <spring:message code="ui.user.password" var="__password" />
      <input
        type="password"
        class="form-control"
        id="pwd"
        placeholder="${__password}"
        name="password"
      />
      <label for="pwd">${__password}</label>
    </div>

    <div class="form-floating mx-auto">
      <input
        type="submit"
        value='<spring:message code="ui.header.user.login" />'
        class="btn btn-outline-primary rounded-pill"
      />
    </div>
  </form>
</section>
