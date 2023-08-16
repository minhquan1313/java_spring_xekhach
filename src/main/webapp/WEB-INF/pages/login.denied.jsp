<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->

<section class="container d-flex flex-column h-100 py-4">
  <c:url value="/" var="action" />
  <div class="my-auto text-center">
    <spring:message code="ui.authentication.access_denied" />
  </div>
</section>
