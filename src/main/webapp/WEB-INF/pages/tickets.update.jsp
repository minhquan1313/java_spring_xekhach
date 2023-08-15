<%-- Document : tickets.add Created on : Aug 4, 2023, 12:51:57 PM Author : Binh --%>
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
<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/tickets" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap"> <spring:message code="ui.global.back" /> </a>
        </div>
        <h3 class="text-center">
            <c:choose>
                <c:when test="${ticket.id == null}">
                    <spring:message code="ui.global.add" />
                </c:when>
                <c:otherwise>
                    <spring:message code="ui.global.update" />
                </c:otherwise>
            </c:choose>
            vé xe
        </h3>

        <div class="invisible" style="flex: 1"></div>
    </div>

    <c:url value="/tickets/add" var="action" />
    <form:form modelAttribute="ticket" method="post" action="${action}" enctype="multipart/form-data">
        <form:errors path="*" element="div" cssClass="alert alert-danger" />
        <form:hidden path="id" />

        <!-- Trip -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text" data-bs-toggle="tooltip" data-bs-title='<spring:message code="ui.ticket.tooltip.choose_trip" />'>
                    <i class="bi bi-geo-fill"> </i>
                </span>

                <form:select class="form-select" path="tripId">
                    <c:forEach items="${trips}" var="c">
                        <c:set value="" var="selected" />
                        <c:if test="${c.id == trip.id}">
                            <c:set value="${c.price}" var="basePrice" />
                            <c:set value="selected" var="selected" />
                        </c:if>
                        <c:url value="/tickets/update/${ticket.id}" var="reloadUrl">
                            <c:param name="tripId" value="${c.id}" />
                        </c:url>
                        <option value="${c.id}" data-url="${reloadUrl}" data-basePrice="${c.price}" ${selected}>
                            <c:if test="${c.id == ticket.tripId.id}"> <spring:message code="ui.global.current" /> | </c:if>
                            <spring:message code="ui.trip.id" />: ${c.id}
                        </option>
                    </c:forEach>
                </form:select>

                <ul class="list-group tripIdSelectData" data-tripId="${trip.id}" style="flex: 1">
                    <li class="list-group-item"><spring:message code="ui.route" />: ${trip.routeId.startLocation} -> ${trip.routeId.endLocation}</li>
                    <li class="list-group-item">
                        <spring:message code="ui.trip.start_at" />:
                        <fmt:formatDate value="${trip.startAt}" pattern="${date_pattern}" />
                    </li>
                    <li class="list-group-item"><spring:message code="ui.bus.license_plate" />: ${trip.busId.licensePlate} - ${trip.busId.busSeatTripCount}</li>
                    <li class="list-group-item"><spring:message code="ui.bus.driver_name" />: ${trip.driverId}</li>
                </ul>

                <c:url value="/trips/add" var="createUrl" />
                <a href="${createUrl}" class="input-group-text link-underline link-underline-opacity-0 bg-info-subtle">
                    <i class="bi bi-plus-square-dotted"> </i>
                </a>
            </div>

            <div class="d-none">
                <script>
                    $("#tripId").on("change", () => {
                        const $selected = $("#tripId").find(":selected");
                        location.replace($selected.attr("data-url"));
                    });
                </script>
            </div>
            <form:errors path="tripId" element="div" cssClass="text-danger" />
        </div>

        <!-- bookingUsers -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text" data-bs-toggle="tooltip" data-bs-title='<spring:message code="ui.ticket.tooltip.choose_user_booking" />'>
                    <i class="bi bi-person"> </i>
                </span>
                <form:select class="form-select" path="userId">
                    <c:forEach items="${bookingUsers}" var="c">
                        <c:set value="" var="selected" />
                        <c:if test="${c.id == ticket.userId.id}">
                            <c:set value="selected" var="selected" />
                        </c:if>
                        <option value="${c.id}" ${selected}>${c}</option>
                    </c:forEach>
                </form:select>

                <c:url value="/users/add" var="createUrl" />
                <a href="${createUrl}" class="input-group-text link-underline link-underline-opacity-0 bg-info-subtle">
                    <i class="bi bi-plus-square-dotted"> </i>
                </a>
            </div>
            <form:errors path="userId" element="div" cssClass="text-danger" />
        </div>

        <!-- paidPrice -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text" data-bs-toggle="tooltip" data-bs-title='<spring:message code="ui.trip.price" />'>
                    <i class="bi bi-currency-dollar"> </i>
                </span>

                <input id="basePrice" type="text" class="form-control" placeholder='<spring:message code="ui.trip.price" />' readonly />
                <c:if test="${not empty extraPriceTitle}">
                    <span class="input-group-text"> ${extraPriceTitle} </span>
                    <input type="text" id="extraPrice" class="form-control" placeholder='<spring:message code="ui.ticket.extra_charge" />' value="${extraPrice}" />
                </c:if>
                <span class="input-group-text"> = </span>

                <spring:message code="ui.ticket.paid_price" var="__paid_price" />
                <form:input type="text" class="form-control" placeholder="${__paid_price}" path="paidPrice" readonly="true" />

                <span class="input-group-text"> VND </span>
            </div>

            <c:url value="/js/ticketPriceInputs.js" var="ticketPriceInputs" />
            <script src="${ticketPriceInputs}"></script>

            <form:errors path="paidPrice" element="div" cssClass="text-danger" />
        </div>

        <div class="mb-3 row g-3">
            <!-- paidWith -->
            <div class="col-12 col-md-6 col-xl-4">
                <div class="input-group">
                    <span class="input-group-text" data-bs-toggle="tooltip" data-bs-title='<spring:message code="ui.ticket.paid_with" />'>
                        <i class="bi bi-wallet2"> </i>
                    </span>

                    <form:select class="form-select" path="paidWith">
                        <c:forEach items="${paidWithTemplate}" var="c">
                            <c:set value="" var="selected" />
                            <c:if test="${c == ticket.paidWith}">
                                <c:set value="selected" var="selected" />
                            </c:if>
                            <option value="${c}" ${selected}>${c}</option>
                        </c:forEach>
                    </form:select>
                </div>
                <form:errors path="paidWith" element="div" cssClass="text-danger" />
            </div>

            <!-- staffId -->
            <div class="col-12 col-md-6 col-xl-4">
                <div class="input-group">
                    <span class="input-group-text" data-bs-toggle="tooltip" data-bs-title='<spring:message code="ui.ticket.choose_printing_staff" />'>
                        <i class="bi bi-person"> </i>
                    </span>
                    <form:select class="form-select" path="staffId">
                        <option value="">
                            <spring:message code="ui.ticket.printing_staff" />
                        </option>

                        <c:forEach items="${staffUsers}" var="c">
                            <c:set value="" var="selected" />
                            <c:if test="${c.id == ticket.staffId.id}">
                                <c:set value="selected" var="selected" />
                            </c:if>
                            <option value="${c.id}" ${selected}>${c}</option>
                        </c:forEach>
                    </form:select>

                    <c:url value="/users/add" var="createUrl" />
                    <a href="${createUrl}" class="input-group-text link-underline link-underline-opacity-0 bg-info-subtle">
                        <i class="bi bi-plus-square-dotted"> </i>
                    </a>
                </div>

                <form:errors path="staffId" element="div" cssClass="text-danger" />
            </div>

            <!-- isPaid -->
            <div class="col-12 col-xl-4">
                <label class="input-group mb-3" style="cursor: pointer">
                    <div class="input-group-text">
                        <form:checkbox class="form-check-input mt-0" path="isPaid" id="isPaid" />
                    </div>

                    <div class="form-control">
                        <spring:message code="ui.ticket.is_paid_status.paid" />
                    </div>
                </label>

                <div class="d-none">
                    <c:url value="/js/ticketIsPaid.js" var="ticketIsPaid" />
                    <script src="${ticketIsPaid}"></script>
                </div>
            </div>
        </div>

        <!-- selectSeat -->
        <div class="mb-3">
            <label class="form-label">
                <spring:message code="ui.ticket.choose_seat" />
            </label>

            <div class="align-items-center d-flex flex-column mb-3">
                <div id="seatArrayContainer" class="d-none" style="--col: ${seats.col}; --row: ${seats.row}">
                    <c:forEach items="${seats.array}" var="c">
                        <c:set value="" var="userChosen" />
                        <c:if test="${c.userChosen == true}">
                            <c:set value="userChosen active" var="userChosen" />
                        </c:if>

                        <c:set value="" var="disabled" />
                        <c:if test="${userChosen == '' && c.available != true}">
                            <c:set value="disabled" var="disabled" />
                        </c:if>

                        <button type="button" data-id="${c.id}" data-pos="${c.x}_${c.y}" class="text-primary" style="--x: ${c.x}; --y: ${c.y};" ${disabled} ${userChosen} data-bs-toggle="tooltip" data-bs-title="${c.id}">
                            <h3 class="m-0" withoutActive>
                                <i class="bi bi-circle"> </i>
                            </h3>
                            <h3 class="m-0" withActive>
                                <i class="bi bi-circle-fill"> </i>
                            </h3>
                        </button>
                    </c:forEach>
                </div>
            </div>

            <div class="d-flex">
                <span> <spring:message code="ui.ticket.total_bus_seat_selected" />: </span>
                <span id="seatCount" class="ms-3">~</span>
            </div>
            <input type="hidden" name="selectedSeats" id="selectedSeats" />

            <div class="d-none">
                <c:url value="/css/busSeat.css" var="busSeat" />
                <link rel="stylesheet" href="${busSeat}" />
            </div>
        </div>

        <!-- createdAt -->
        <c:if test="${ticket.id != null}">
            <div class="mb-3">
                <div class="input-group" id="datetimepicker1">
                    <span class="input-group-text"> <spring:message code="ui.ticket.created_at" /> </span>
                    <input id="datetimepicker1Input" type="text" class="form-control" readonly />
                    <span class="input-group-text" data-td-toggle="datetimepicker" style="cursor: pointer">
                        <i class="bi bi-calendar-plus"> </i>
                    </span>
                </div>
                <form:hidden path="createdAt" />
                <form:errors path="createdAt" element="div" cssClass="text-danger" />
            </div>
        </c:if>

        <button type="submit" class="btn btn-outline-info w-100">
            <c:choose>
                <c:when test="${ticket.id == null}">
                    <spring:message code="ui.global.add" />
                </c:when>
                <c:otherwise>
                    <spring:message code="ui.global.update" />
                </c:otherwise>
            </c:choose>
        </button>
    </form:form>
</section>

<c:url value="/js/dateTimePicker.js" var="dateTimePicker" />
<script src="${dateTimePicker}"></script>

<c:url value="/js/busSeatTripTicketSelect.js" var="busSeatTripTicketSelect" />
<script src="${busSeatTripTicketSelect}"></script>

<c:if test="${ticket.id != null}">
    <script>
        dateTimePicker({
            dateTimePickerId: "datetimepicker1",
            inputNameBind: "createdAt",
            locale: Cookies.get("${LANG}"),
        });
    </script>
</c:if>
