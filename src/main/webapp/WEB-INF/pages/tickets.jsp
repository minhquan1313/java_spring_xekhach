<%-- Document : tickets Created on : Aug 3, 2023, 2:03:22 PM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->
<section class="py-4">
  <div class="container">
    <div class="d-flex align-items-center mb-3">
      <div class="d-flex justify-content-start" style="flex: 1">
        <c:url value="/" var="backUrl" />
        <a href="${backUrl}" class="btn btn-outline-info text-nowrap">
          <spring:message code="ui.global.back" />
        </a>
      </div>

      <h3 class="text-center">
        <spring:message code="ui.ticket.header_title" />
      </h3>
      <div class="d-flex justify-content-end" style="flex: 1">
        <c:url value="/tickets/add" var="createUrl" />
        <a href="${createUrl}" class="btn btn-outline-info text-nowrap">
          <spring:message code="ui.global.add" />
        </a>
      </div>
    </div>
  </div>

  <div class="container-xxl table-responsive">
    <table class="table table-hover">
      <thead>
        <tr>
          <th scope="col">
            <spring:message code="ui.global.id" />
          </th>
          <th scope="col">
            <spring:message code="ui.trip.id" />
          </th>
          <th scope="col">
            <spring:message code="ui.ticket.created_at" />
          </th>
          <th scope="col">
            <spring:message code="ui.ticket.seat_booked_count" />
          </th>
          <th scope="col">
            <spring:message code="ui.route.start_location" />
          </th>
          <th scope="col">
            <spring:message code="ui.route.end_location" />
          </th>
          <th scope="col">
            <spring:message code="ui.ticket.paid_price" />
          </th>
          <th scope="col">
            <spring:message code="ui.ticket.paid_with" />
          </th>
          <th scope="col">
            <spring:message code="ui.ticket.is_paid_status" />
          </th>
          <th scope="col">
            <spring:message code="ui.ticket.printing_staff" />
          </th>
          <th scope="col">
            <spring:message code="ui.bus.license_plate" />
          </th>
        </tr>
      </thead>
      <tbody class="table-group-divider">
        <c:forEach items="${tickets}" var="item">
          <tr>
            <th scope="row">${item.id}</th>
            <th scope="row">
              <c:url value="/trips?id=${item.tripId.id}" var="tripFindIdUrl" />
              <a
                href="${tripFindIdUrl}"
                class="link-underline link-underline-opacity-0 text-primary-emphasis"
              >
                ${item.tripId.id}
              </a>
            </th>
            <td>
              <fmt:formatDate
                value="${item.createdAt}"
                pattern="${date_pattern}"
              />
            </td>
            <td>${item.totalSeat}</td>
            <td>${item.tripId.routeId.startLocation}</td>
            <td>${item.tripId.routeId.endLocation}</td>
            <td>
              <fmt:formatNumber
                type="number"
                maxFractionDigits="0"
                value="${item.paidPrice}"
              />
              VNĐ
            </td>
            <td>${item.paidWith}</td>
            <td>
              <c:set value="" var="checked" />
              <c:if test="${item.isPaid == true}">
                <c:set value="checked" var="checked" />
              </c:if>
              <input
                class="form-check-input"
                type="checkbox"
                disabled
                ${checked}
              />
            </td>
            <td>
              <c:url value="/users?id=${item.staffId.id}" var="userFind" />
              <a
                href="${userFind}"
                class="link-underline link-underline-opacity-0 text-primary-emphasis"
              >
                ${item.staffId}
              </a>
            </td>
            <td>
              <c:url value="/buses/${item.tripId.busId.id}" var="busDetail" />
              <a
                href="${busDetail}"
                class="link-underline link-underline-opacity-0 text-primary-emphasis"
              >
                ${item.tripId.busId.licensePlate}
              </a>
            </td>

            <td>
              <div class="btn-group float-end">
                <c:url value="/tickets/edit/${item.id}" var="editUrl" />
                <a href="${editUrl}" class="btn btn-primary">
                  <spring:message code="ui.global.edit" />
                </a>

                <button
                  type="button"
                  class="btn btn-primary dropdown-toggle dropdown-toggle-split"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  <span class="visually-hidden"></span>
                </button>
                <ul class="dropdown-menu">
                  <li>
                    <c:choose>
                      <c:when
                        test="${item.isPaid == true && item.staffId != null}"
                      >
                        <c:url
                          value="/feedbacks/add?ticketId=${item.id}"
                          var="feedBackUrl"
                        />
                        <a
                          href="${feedBackUrl}"
                          class="dropdown-item btn btn-primary"
                        >
                          <spring:message code="ui.feedback" />
                        </a>
                      </c:when>
                      <c:otherwise>
                        <a
                          href="javascript:;"
                          class="dropdown-item btn btn-primary disabled"
                        >
                          <spring:message code="ui.feedback" />
                        </a>
                      </c:otherwise>
                    </c:choose>
                  </li>
                  <li>
                    <c:url value="/tickets/${item.id}" var="detailUrl" />
                    <a
                      href="${detailUrl}"
                      class="dropdown-item btn btn-primary"
                    >
                      <spring:message code="ui.global.detail" />
                    </a>
                  </li>
                  <li>
                    <c:url
                      value="/tickets/export/${item.id}"
                      var="exportPdfUrl"
                    />
                    <c:choose>
                      <c:when
                        test="${item.isPaid == true && item.staffId != null}"
                      >
                        <a
                          href="${exportPdfUrl}"
                          target="_blank"
                          class="dropdown-item btn btn-primary"
                        >
                          <spring:message code="ui.ticket.print_ticket" />
                        </a>
                      </c:when>
                      <c:otherwise>
                        <a
                          href="#"
                          class="dropdown-item btn btn-primary disabled"
                          onclick="return false;"
                        >
                          <spring:message code="ui.ticket.print_ticket" />
                        </a>
                      </c:otherwise>
                    </c:choose>
                  </li>
                  <li>
                    <c:url value="/api/admin/tickets/${item.id}" var="delUrl" />
                    <c:set
                      value="onclick=(delAPI('${delUrl}'))"
                      var="delClick"
                    />
                    <button class="dropdown-item btn btn-danger" ${delClick}>
                      <spring:message code="ui.global.delete" />
                    </button>
                  </li>
                </ul>
              </div>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</section>

<c:url value="/js/delAPI.js" var="delAPI" />
<script src="${delAPI}"></script>
