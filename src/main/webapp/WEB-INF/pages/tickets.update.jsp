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
<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/tickets" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
        </div>
        <h3 class="text-center">
            <c:choose>
                <c:when test="${ticket.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
            vé xe
        </h3>

        <div class="invisible" style="flex: 1"></div>
    </div>

    <c:url value="/tickets/add" var="action" />
    <form:form
        modelAttribute="ticket"
        method="post"
        action="${action}"
        enctype="multipart/form-data"
    >
        <form:errors path="*" element="div" cssClass="alert alert-danger" />
        <form:hidden path="id" />

        <!-- Trip -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-geo-fill"></i>
                </span>

                <form:select class="form-select" path="tripId">
                    <c:forEach items="${trips}" var="c">
                        <c:set value="" var="selected" />
                        <c:if test="${c.id == trip.id || c.id == ticket.tripId.id}">
                            <c:set value="${c.price}" var="basePrice" />
                            <c:set value="selected" var="selected" />
                        </c:if>
                        <c:url value="/tickets/add" var="reloadUrl">
                            <c:param name="tripId" value="${c.id}" />
                        </c:url>
                        <option
                            value="${c.id}"
                            data-url="${reloadUrl}"
                            data-basePrice="${c.price}"
                            ${selected}
                        >
                            id: ${c.id}
                        </option>
                    </c:forEach>
                </form:select>
                <c:set value="${trip}" var="c" />

                <div class="form-control tripIdSelectData" data-tripId="${c.id}">
                    <div>${c.routeId.startLocation} -> ${c.routeId.endLocation}</div>
                    <div>
                        <fmt:formatDate value="${c.startAt}" pattern="${date_pattern}" />
                    </div>
                    <div>${c.busId.licensePlate} - ${fn:length(c.busId.busSeatTripSet)}</div>
                    <div>${c.driverId}</div>
                </div>

                <c:url value="/trips/add" var="createUrl" />
                <a
                    href="${createUrl}"
                    class="input-group-text link-underline link-underline-opacity-0 bg-info-subtle"
                >
                    <i class="bi bi-plus-square-dotted"></i>
                </a>
            </div>
            <form:errors path="tripId" element="div" cssClass="text-danger" />
        </div>

        <!-- bookingUsers -->
        <div class="mb-3">
            <div class="input-group">
                <span
                    class="input-group-text"
                    data-bs-toggle="tooltip"
                    data-bs-title="User nào đặt vé"
                >
                    <i class="bi bi-person"></i>
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
                <a
                    href="${createUrl}"
                    class="input-group-text link-underline link-underline-opacity-0 bg-info-subtle"
                >
                    <i class="bi bi-plus-square-dotted"></i>
                </a>
            </div>
            <form:errors path="userId" element="div" cssClass="text-danger" />
        </div>

        <!-- paidPrice -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-currency-dollar"></i>
                </span>
                <c:choose>
                    <c:when test="${ticket.id == null}">
                        <input
                            id="basePrice"
                            type="text"
                            class="form-control"
                            placeholder="Giá chuyến"
                            readonly
                        />
                        <c:if test="${not empty extraPriceTitle}">
                            <span class="input-group-text"> ${extraPriceTitle} </span>
                            <input
                                type="text"
                                id="extraPrice"
                                class="form-control"
                                placeholder="Phí phát sinh"
                                value="${extraPrice}"
                            />
                        </c:if>
                        <span class="input-group-text"> = </span>
                        <form:input
                            type="text"
                            class="form-control"
                            placeholder="Tổng thanh toán"
                            path="paidPrice"
                        />
                        <script>
                            setPriceOnInputs();
                            priceInputHandler();

                            $("#extraPrice, #basePrice").on("input", priceInputHandler);
                            function priceInputHandler() {
                                const baseP = $("#basePrice").val() ?? "0";
                                const extraP = $("#extraPrice").val() ?? "0";

                                $("#paidPrice").val(parseInt(baseP) + parseInt(extraP));
                            }

                            $("#paidPrice").on("input", () => {
                                const paidP = $("#paidPrice").val() ?? "0";
                                const baseP = $("#basePrice").val() ?? "0";

                                $("#extraPrice").val(parseInt(paidP) - parseInt(baseP));
                            });

                            function setPriceOnInputs() {
                                const $initSelected = $("#tripId").find(":selected");

                                $("#tripId").on("change", () => {
                                    const $selected = $("#tripId").find(":selected");
                                    location.replace($selected.attr("data-url"));
                                });

                                $("#basePrice").val($initSelected.attr("data-basePrice"));
                            }
                        </script>
                    </c:when>

                    <c:otherwise>
                        <form:input
                            type="text"
                            class="form-control"
                            placeholder="Tổng thanh toán"
                            path="paidPrice"
                        />
                    </c:otherwise>
                </c:choose>
                <span class="input-group-text"> VND </span>
            </div>
            <form:errors path="paidPrice" element="div" cssClass="text-danger" />
        </div>

        <!-- paidWith -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-wallet2"></i>
                </span>

                <form:select class="form-select" path="paidWith">
                    <c:forEach items="${['Tiền mặt', 'Momo', 'Chuyển khoản']}" var="c">
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

        <!-- staff -->
        <div class="mb-3">
            <div class="input-group">
                <span
                    class="input-group-text"
                    data-bs-toggle="tooltip"
                    data-bs-title="Nhân viên in vé"
                >
                    <i class="bi bi-person"></i>
                </span>
                <form:select class="form-select" path="staffId">
                    <option value="" ${selected}>Chọn nhân viên in vé</option>

                    <c:forEach items="${staffUsers}" var="c">
                        <c:set value="" var="selected" />
                        <c:if test="${c.id == ticket.staffId.id}">
                            <c:set value="selected" var="selected" />
                        </c:if>
                        <option value="${c.id}" ${selected}>${c}</option>
                    </c:forEach>
                </form:select>

                <c:url value="/users/add" var="createUrl" />
                <a
                    href="${createUrl}"
                    class="input-group-text link-underline link-underline-opacity-0 bg-info-subtle"
                >
                    <i class="bi bi-plus-square-dotted"></i>
                </a>
            </div>

            <form:errors path="staffId" element="div" cssClass="text-danger" />
        </div>

        <!-- isPaid -->
        <div class="mb-3">
            <div class="form-check">
                <form:checkbox class="form-check-input" path="isPaid" id="isPaid" />
                <label class="form-check-label" for="isPaid" style="cursor: pointer">
                    Đã thanh toán
                </label>
            </div>

            <div class="d-none">
                <script>
                    staffIdSelectChangeHandler();

                    $("#staffId").on("change", staffIdSelectChangeHandler);

                    function staffIdSelectChangeHandler() {
                        const $selected = $("#staffId").find(":selected");

                        console.log(Boolean($selected.val()), { x: $selected.val() });

                        if ($selected.val()) {
                            $("#isPaid").prop("checked", true);
                        } else {
                            $("#isPaid").prop("checked", false);
                        }
                    }
                </script>
            </div>
        </div>

        <!-- selectSeat -->
        <div class="mb-3">
            <label class="form-label">Chọn ghế ngồi</label>

            <div class="align-items-center d-flex flex-column mb-3">
                <div
                    id="seatArrayContainer"
                    class="d-none"
                    style="--col: ${seats.col}; --row: ${seats.row}"
                >
                    <c:forEach items="${seats.array}" var="c" varStatus="i">
                        <c:set value="" var="disabled" />
                        <c:if test="${c.available != true}">
                            <c:set value="disabled" var="disabled" />
                        </c:if>

                        <button
                            type="button"
                            data-id="${c.id}"
                            data-pos="${c.x}_${c.y}"
                            class="text-primary"
                            style="--x: ${c.x}; --y: ${c.y};"
                            ${disabled}
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
                <span>Tổng số chỗ ngồi đã chọn: </span>
                <span id="seatCount" class="ms-3">1</span>
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
                    <span class="input-group-text"> Tạo lúc </span>
                    <input id="datetimepicker1Input" type="text" class="form-control" readonly />
                    <span
                        class="input-group-text"
                        data-td-toggle="datetimepicker"
                        style="cursor: pointer"
                    >
                        <i class="bi bi-calendar-plus"></i>
                    </span>
                </div>
                <form:hidden path="createdAt" />
                <form:errors path="createdAt" element="div" cssClass="text-danger" />
            </div>
        </c:if>

        <button type="submit" class="btn btn-outline-info w-100">
            <c:choose>
                <c:when test="${ticket.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
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
        });
    </script>
</c:if>
