<%-- Document : routes.add Created on : Aug 1, 2023, 10:13:11 AM Author : Binh
--%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--  -->
<section class="container py-4">
  <div class="d-flex align-items-center mb-3">
    <div class="d-flex justify-content-start" style="flex: 1">
      <c:url value="/routes" var="backUrl" />
      <a href="${backUrl}" class="btn btn-outline-info text-nowrap">
        <spring:message code="ui.global.back" />
      </a>
    </div>
    <h3 class="text-center">
      <c:choose>
        <c:when test="${route.id == null}">
          <spring:message code="ui.global.add" />
        </c:when>
        <c:otherwise>
          <spring:message code="ui.global.update" />
        </c:otherwise>
      </c:choose>
      <spring:message code="ui.route" var="__header_title" />
      ${fn:toLowerCase(__header_title)}
    </h3>

    <div class="invisible" style="flex: 1"></div>
  </div>

  <c:url value="/routes/add" var="action" />
  <form:form
    method="post"
    action="${action}"
    modelAttribute="route"
    enctype="multipart/form-data"
  >
  
    <form:hidden path="id" />

    <div class="row g-3 mb-3">
      <div class="col-12 col-lg">
        <div class="input-group">
          <span class="input-group-text">
            <i class="bi bi-cursor"></i>
          </span>

          <spring:message
            code="ui.route.start_location"
            var="__start_location"
          />
          <form:input
            type="text"
            class="form-control"
            placeholder="${__start_location}"
            path="startLocation"
          />
            <form:errors path="startLocation" element="div" cssClass="text-danger" />
        </div>
      </div>

      <div class="col-12 col-lg">
        <div class="input-group">
          <span class="input-group-text">
            <i class="bi bi-geo-fill"></i>
          </span>

          <spring:message code="ui.route.end_location" var="__end_location" />
          <form:input
            type="text"
            class="form-control"
            placeholder="${__end_location}"
            path="endLocation"
          />
            <form:errors path="endLocation" element="div" cssClass="text-danger" />
        </div>
      </div>
    </div>

    <div class="mb-3">
      <div class="form-check">
        <input
          class="form-check-input"
          type="checkbox"
          id="round_trip"
          name="round_trip"
          checked
        />
        <label class="form-check-label" for="round_trip">
          <spring:message code="ui.route.two_ways" />
        </label>
      </div>
    </div>

    <button type="submit" class="btn btn-outline-info w-100">
      <c:choose>
        <c:when test="${route.id == null}">
          <spring:message code="ui.global.add" />
        </c:when>
        <c:otherwise>
          <spring:message code="ui.global.update" />
        </c:otherwise>
      </c:choose>
    </button>
  </form:form>
</section>
