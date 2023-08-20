<%-- Document : bus.addOrUpdate Created on : Aug 1, 2023, 3:52:55 PM Author :
Binh --%>
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
      <c:url value="/buses" var="backUrl" />
      <a href="${backUrl}" class="btn btn-outline-info text-nowrap">
        <spring:message code="ui.global.back" />
      </a>
    </div>
    <h3 class="text-center">
      <c:choose>
        <c:when test="${bus.id == null}">
          <spring:message code="ui.global.add" />
        </c:when>
        <c:otherwise>
          <spring:message code="ui.global.update" />
        </c:otherwise>
      </c:choose>
      <spring:message code="ui.bus" var="__header_title" />
      ${fn:toLowerCase(__header_title)}
    </h3>

    <div class="invisible" style="flex: 1"></div>
  </div>

  <c:url value="/buses/add" var="action" />
  <form:form
    method="post"
    action="${action}"
    modelAttribute="bus"
    enctype="multipart/form-data"
  >
    <form:errors path="*" element="div" cssClass="alert alert-danger" />
    <form:hidden path="id" />
    <form:hidden path="image" />
    <c:if test="${bus.id == null}">
      <input type="hidden" name="selectedSeats" id="selectedSeats" value="" />
    </c:if>
    <div class="mb-3">
      <div class="input-group">
        <span class="input-group-text">
          <i class="bi bi-dash-square-fill"></i>
        </span>

        <spring:message code="ui.bus.license_plate" var="__license_plate" />
        <form:input
          type="text"
          class="form-control"
          placeholder="${__license_plate}"
          path="licensePlate"
        />
      </div>
      <form:errors path="licensePlate" element="div" cssClass="text-danger" />
    </div>

    <c:if test="${bus.id != null}">
      <div class="mb-3">
        <img
          src="${bus.image}"
          width="300"
          class="img-thumbnail rounded mx-auto d-block"
          alt="..."
        />
      </div>
    </c:if>

    <div class="mb-3">
      <label for="formFile" class="form-label">
        <c:choose>
          <c:when test="${bus.id == null}">
            <spring:message code="ui.bus.select_image" />
          </c:when>
          <c:otherwise>
            <spring:message code="ui.bus.select_new_image" />
          </c:otherwise>
        </c:choose>
      </label>
      <form:input class="form-control" type="file" id="formFile" path="file" />
    </div>

    <c:if test="${bus.id == null}">
      <section class="mb-3">
        <label for="seatSelect" class="form-label">
          <spring:message code="ui.bus.select_bus_seat_template" />
        </label>
        <select id="seatSelect" class="form-select mb-3">
          <option selected value="5x10">5x10</option>
          <option value="10x20">10x20</option>
        </select>

        <div class="align-items-center d-flex flex-column mb-3">
          <div id="seatArrayContainer" style="--col: x; --row: x"></div>
        </div>

        <div class="d-flex">
          <span class="">
            <spring:message code="ui.ticket.total_bus_seat_selected" />
            :
          </span>
          <span id="seatCount" class="ms-3">~</span>
        </div>
        <!-- <div class="text-danger">${noSeatSelectedError}</div> -->

        <div class="d-none">
          <c:url value="/css/busSeat.css" var="busSeat" />
          <link rel="stylesheet" href="${busSeat}" />

          <c:url value="/js/busAddSeat.js" var="busAddSeat" />
          <script src="${busAddSeat}"></script>
        </div>
      </section>
    </c:if>

    <button type="submit" class="btn btn-outline-info w-100">
      <c:choose>
        <c:when test="${bus.id == null}">
          <spring:message code="ui.global.add" />
        </c:when>
        <c:otherwise>
          <spring:message code="ui.global.update" />
        </c:otherwise>
      </c:choose>
    </button>
  </form:form>
</section>
