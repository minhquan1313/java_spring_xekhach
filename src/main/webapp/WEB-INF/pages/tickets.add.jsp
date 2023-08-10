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
                <span class="input-group-text" data-bs-toggle="tooltip" data-bs-title="Mã chuyến">
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

                <ul class="list-group tripIdSelectData" data-tripId="${trip.id}" style="flex: 1">
                    <li class="list-group-item">
                        Tuyến: ${trip.routeId.startLocation} -> ${trip.routeId.endLocation}
                    </li>
                    <li class="list-group-item">
                        Khởi hành:
                        <fmt:formatDate value="${trip.startAt}" pattern="${date_pattern}" />
                    </li>
                    <li class="list-group-item">
                        Xe: ${trip.busId.licensePlate} - ${fn:length(trip.busId.busSeatTripSet)}
                    </li>
                    <li class="list-group-item">Tài xế: ${trip.driverId}</li>
                </ul>

                <c:url value="/trips/add" var="createUrl" />
                <a
                    href="${createUrl}"
                    class="input-group-text link-underline link-underline-opacity-0 bg-info-subtle"
                >
                    <i class="bi bi-plus-square-dotted"></i>
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
                <span
                    class="input-group-text"
                    data-bs-toggle="tooltip"
                    data-bs-title="Chọn người dùng đặt vé"
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
                <span class="input-group-text" data-bs-toggle="tooltip" data-bs-title="Giá tiền">
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

        <div class="mb-3 row g-3">
            <!-- paidWith -->
            <div class="col-12 col-md-6 col-xl-4">
                <div class="input-group">
                    <span
                        class="input-group-text"
                        data-bs-toggle="tooltip"
                        data-bs-title="Phương thức thanh toán"
                    >
                        <i class="bi bi-wallet2"></i>
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
                    <span
                        class="input-group-text"
                        data-bs-toggle="tooltip"
                        data-bs-title="Nhân viên in vé"
                    >
                        <i class="bi bi-person"></i>
                    </span>
                    <form:select class="form-select" path="staffId">
                        <option value="">Chọn nhân viên in vé</option>

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
            <div class="col-12 col-xl-4">
                <div class="input-group">
                    <label class="form-control" style="cursor: pointer">
                        <form:checkbox class="form-check-input me-1" path="isPaid" id="isPaid" />
                        <label> Đã thanh toán </label>
                    </label>
                </div>
                <div class="d-none">
                    <script>
                        staffIdSelectChangeHandler();

                        $("#staffId").on("change", staffIdSelectChangeHandler);

                        function staffIdSelectChangeHandler() {
                            const $selected = $("#staffId").find(":selected");

                            if ($selected.val()) {
                                $("#isPaid").prop("checked", true);
                                $("#isPaid").attr("disabled", "");
                            } else {
                                $("#isPaid").prop("checked", false);
                                $("#isPaid").attr("disabled", null);
                            }
                        }
                    </script>
                </div>
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
                    <c:forEach items="${seats.array}" var="c">
                        <c:set value="" var="userChosen" />
                        <c:if test="${c.userChosen == true}">
                            <c:set value="userChosen active" var="userChosen" />
                        </c:if>

                        <c:set value="" var="disabled" />
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
                            data-bs-toggle="tooltip"
                            data-bs-title="${c.id} - ${c.x}_${c.y}"
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
