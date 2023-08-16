<%-- Document : tickets.addOrUpdate Created on : Aug 4, 2023, 12:51:57 PM Author
: Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--  -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->
<section class="container py-4">
  <div class="d-flex align-items-center mb-3">
    <div class="d-flex justify-content-start" style="flex: 1">
      <c:url value="/tickets" var="backUrl" />
      <a href="${backUrl}" class="btn btn-outline-info text-nowrap">
        <spring:message code="ui.global.back" />
      </a>
    </div>
    <h3 class="text-center">
      <spring:message code="ui.global.detail" />

      <spring:message code="ui.ticket" var="__header_title" />
      ${fn:toLowerCase(__header_title)}
    </h3>

    <div class="invisible" style="flex: 1"></div>
  </div>

  <!-- ticketId -->
  <div class="mb-3">
    <div class="input-group">
      <span
        class="input-group-text"
        data-bs-toggle="tooltip"
        data-bs-title='<spring:message code="ui.ticket.id" />'
      >
        <i class="bi bi-person"></i>
      </span>
      <div class="form-control">${ticket.id}</div>
    </div>
  </div>
  <!-- Trip -->

  <div class="mb-3">
    <div class="input-group">
      <span
        class="input-group-text"
        data-bs-toggle="tooltip"
        data-bs-title='<spring:message code="ui.trip.id" />'
      >
        <i class="bi bi-geo-fill"></i>
      </span>

      <c:url value="/trips?id=${ticket.tripId.id}" var="tripFind" />
      <div class="form-control align-items-center d-flex">
        <a
          href="${tripFind}"
          class="link-underline link-underline-opacity-0 text-primary-emphasis"
        >
          <spring:message code="ui.trip.id" />
          : ${ticket.tripId.id}
        </a>
      </div>

      <ul
        class="list-group tripIdSelectData"
        data-tripId="${ticket.tripId.id}"
        style="flex: 1"
      >
        <li class="list-group-item">
          <spring:message code="ui.route" />
          : ${ticket.tripId.routeId.startLocation} ->
          ${ticket.tripId.routeId.endLocation}
        </li>
        <li class="list-group-item">
          <spring:message code="ui.trip.start_at" />
          :
          <fmt:formatDate
            value="${ticket.tripId.startAt}"
            pattern="${date_pattern}"
          />
        </li>
        <li class="list-group-item">
          <spring:message code="ui.bus.license_plate" />
          : ${ticket.tripId.busId.licensePlate} - ${trip.busId.busSeatTripCount}
        </li>
        <li class="list-group-item">
          <spring:message code="ui.bus.driver_name" />
          : ${ticket.tripId.driverId}
        </li>
      </ul>
    </div>
  </div>

  <!-- bookingUser -->
  <div class="mb-3">
    <div class="input-group">
      <span
        class="input-group-text"
        data-bs-toggle="tooltip"
        data-bs-title='<spring:message code="ui.ticket.tooltip.choose_user_booking" />'
      >
        <i class="bi bi-person"></i>
      </span>
      <div class="form-control">${ticket.userId}</div>
    </div>
  </div>

  <!-- createdAt -->
  <div class="mb-3">
    <div class="input-group">
      <span
        class="input-group-text"
        data-bs-toggle="tooltip"
        data-bs-title='<spring:message code="ui.ticket.created_at" />'
      >
        <i class="bi bi-wallet2"></i>
      </span>

      <div class="form-control">
        <fmt:formatDate value="${ticket.createdAt}" pattern="${date_pattern}" />
      </div>
    </div>
  </div>

  <!-- paidPrice -->
  <div class="mb-3 row g-3">
    <div class="col-12 col-lg-6">
      <div class="input-group">
        <span
          class="input-group-text"
          data-bs-toggle="tooltip"
          data-bs-title='<spring:message code="ui.ticket.paid_price" />'
        >
          <i class="bi bi-currency-dollar"></i>
        </span>
        <div class="form-control">
          <fmt:formatNumber
            type="number"
            maxFractionDigits="0"
            value="${ticket.paidPrice}"
          />
        </div>
        <span class="input-group-text">VND</span>
      </div>
    </div>

    <!-- paidWith -->
    <div class="col-12 col-lg-6">
      <div class="input-group">
        <span
          class="input-group-text"
          class="input-group-text"
          data-bs-toggle="tooltip"
          data-bs-title='<spring:message code="ui.ticket.paid_with" />'
        >
          <i class="bi bi-wallet2"></i>
        </span>
        <div class="form-control">${ticket.paidWith}</div>
      </div>
    </div>
  </div>

  <div class="mb-3 row g-3">
    <c:if test="${ticket.staffId != null}">
      <!-- staffId -->
      <div class="col">
        <div class="input-group">
          <span
            class="input-group-text"
            data-bs-toggle="tooltip"
            data-bs-title='<spring:message code="ui.ticket.printing_staff" />'
          >
            <i class="bi bi-person"></i>
          </span>

          <c:url value="/users?id=${ticket.staffId.id}" var="userFind" />
          <div class="form-control">
            <a
              href="${userFind}"
              class="link-underline link-underline-opacity-0 text-primary-emphasis"
            >
              ${ticket.staffId}
            </a>
          </div>
        </div>
      </div>
    </c:if>

    <div class="col">
      <!-- isPaid -->
      <div class="input-group">
        <c:choose>
          <c:when test="${ticket.isPaid == 'true'}">
            <span class="input-group-text">
              <i class="bi bi-emoji-heart-eyes-fill"></i>
            </span>
            <div class="form-control">
              <spring:message code="ui.ticket.is_paid_status.paid" />
            </div>
          </c:when>

          <c:otherwise>
            <span class="input-group-text">
              <i class="bi bi-emoji-frown-fill"></i>
            </span>
            <div class="form-control">
              <spring:message code="ui.ticket.is_paid_status.unpaid" />
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <!-- selectSeat -->
    <div class="mb-3">
      <label class="form-label">
        <spring:message code="ui.ticket.choose_seat" />
      </label>

      <div class="align-items-center d-flex flex-column mb-3">
        <div
          id="seatArrayContainer"
          class="d-none"
          style="--col: ${seats.col}; --row: ${seats.row}"
        >
          <c:forEach items="${seats.array}" var="c">
            <c:set value="" var="userChosen" />
            <c:if test="${c.userChosen == true}">
              <c:set value="userChosen active" var="userChosen" />
            </c:if>

            <c:set value="disabled" var="disabled" />
            <c:if test="${userChosen == '' && c.available != true}">
              <c:set value="disabled" var="disabled" />
            </c:if>

            <button
              type="button"
              data-id="${c.id}"
              data-pos="${c.x}_${c.y}"
              class="text-primary"
              style="--x: ${c.x}; --y: ${c.y};"
              ${disabled}
              ${userChosen}
            >
              <h3 class="m-0" withoutActive>
                <i class="bi bi-circle"></i>
              </h3>
              <h3 class="m-0" withActive>
                <i class="bi bi-circle-fill"></i>
              </h3>
            </button>
          </c:forEach>
        </div>
      </div>

      <div class="d-flex">
        <span>
          <spring:message code="ui.ticket.total_bus_seat_selected" />
          :
        </span>
        <span id="seatCount" class="ms-3">~</span>
      </div>
      <input type="hidden" name="selectedSeats" id="selectedSeats" />

      <div class="d-none">
        <c:url value="/css/busSeat.css" var="busSeat" />
        <link rel="stylesheet" href="${busSeat}" />
      </div>
    </div>
  </div>
</section>

<c:url value="/js/busSeatTripTicketSelect.js" var="busSeatTripTicketSelect" />
<script src="${busSeatTripTicketSelect}"></script>
