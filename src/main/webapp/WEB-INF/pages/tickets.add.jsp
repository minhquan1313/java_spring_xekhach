<%-- Document : tickets.addOrUpdate Created on : Aug 4, 2023, 12:51:57 PM Author : Binh --%>
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
        <form:hidden path="id" />
        <input type="hidden" name="selectedSeats" id="selectedSeats" value="" />

        <!-- bookingUsers -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-person"></i>
                </span>
                <form:select class="form-select" path="userId">
                    <c:forEach items="${bookingUsers}" var="c">
                        <c:set value="" var="selected" />
                        <c:if test="${c.id == ticket.userId.id}">
                            <c:set value="selected" var="selected" />
                        </c:if>
                        <option value="${c.id}" ${selected}>${c.lastName} ${c.firstName}</option>
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
                    <div>${c.driverId.lastName} ${c.driverId.firstName}</div>
                </div>
                <script>
                    $(document).ready(() => {
                        $("#tripId").on("change", () => {
                            let $selected = $("#tripId").find(":selected");
                            location.replace($selected.attr("data-url"));
                        });

                        changeHandler();

                        function changeHandler() {
                            let $selected = $("#tripId").find(":selected");
                            let id = $selected.val();

                            $(".tripIdSelectData").each((i, item) => {
                                let itemId = $(item).attr("data-tripId");
                                $(item).attr("style", itemId == id ? "" : "display:none");
                            });
                            $("#basePrice").val($selected.attr("data-basePrice"));
                        }
                    });
                </script>

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
                        <span class="input-group-text"> ${extraPriceTitle} </span>
                        <input
                            type="text"
                            id="extraPrice"
                            class="form-control"
                            placeholder="Phí phát sinh"
                            value="${extraPrice}"
                        />
                        <span class="input-group-text"> = </span>
                        <form:input
                            type="text"
                            class="form-control"
                            placeholder="Tổng thanh toán"
                            path="paidPrice"
                        />
                        <script>
                            $(document).ready(() => {
                                priceInputHandler();

                                $("#tripId").on("change", priceInputHandler);

                                $("#extraPrice, #basePrice").on("input", priceInputHandler);
                                function priceInputHandler() {
                                    $("#paidPrice").val(
                                        parseInt($("#basePrice").val()) +
                                            parseInt($("#extraPrice").val())
                                    );
                                }

                                $("#paidPrice").on("input", () => {
                                    $("#extraPrice").val(
                                        parseInt($("#paidPrice").val()) -
                                            parseInt($("#basePrice").val())
                                    );
                                });
                            });
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

        <!-- isPaid -->
        <div class="mb-3">
            <div class="form-check">
                <form:checkbox class="form-check-input" path="isPaid" id="isPaid" />
                <label class="form-check-label" for="isPaid" style="cursor: pointer">
                    Đã thanh toán
                </label>
            </div>
        </div>

        <!-- selectSeat -->
        <div class="mb-3">
            <label class="form-label">Chọn ghế ngồi</label>
            <select id="seatSelect" class="d-none">
                <option selected value="5x10">5x10</option>
            </select>

            <div class="align-items-center d-flex flex-column mb-3">
                <div id="seatArrayContainer" style="--col: ${seats.col}; --row: ${seats.row}">
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
                <span class="">Tổng số chỗ ngồi đã chọn: </span>
                <span id="seatCount" class="ms-3">1</span>
            </div>

            <div class="d-none">
                <style>
                    #seatArrayContainer {
                        display: grid;
                        grid-template-columns: repeat(var(--col), 3rem);
                        grid-template-rows: repeat(var(--row), 1fr);
                    }
                    button[data-pos] {
                        aspect-ratio: 1/1;
                        background-color: transparent;
                        border-color: transparent;
                        grid-column: var(--x);
                        grid-row: var(--y);

                        filter: grayscale(1);
                    }
                    button[data-pos] *.bi {
                        font-size: 2rem;
                    }
                    button[data-pos]:disabled {
                        filter: grayscale(1);
                    }
                    button[data-pos][active] {
                        filter: hue-rotate(300deg);
                    }
                    button[data-pos] *[withActive] {
                        display: none;
                    }
                    button[data-pos] *[withoutActive] {
                        display: block;
                    }
                    button[data-pos][active] *[withActive] {
                        display: block;
                    }
                    button[data-pos][active] *[withoutActive] {
                        display: none;
                    }
                </style>

                <script>
                    $("button[data-pos]:not(disabled)").on("click", function () {
                        const $btn = $(this);
                        $btn.attr("active", (i, v) => (v == "" ? null : ""));

                        // const isSelected = $btn.attr("active") != undefined;
                    });
                </script>
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

<c:url value="/js/selectBindInput.js" var="selectBindInput" />
<script src="${selectBindInput}"></script>

<c:url value="/js/dateTimePicker.js" var="dateTimePicker" />
<script src="${dateTimePicker}"></script>

<c:if test="${ticket.id != null}">
    <script>
        // let initStartAt = $("#createdAt").val();
        // let x = initStartAt ? undefined : new Date();
        dateTimePicker({
            dateTimePickerId: "datetimepicker1",
            inputNameBind: "createdAt",
        });
    </script>
</c:if>
<script>
    // let initStartAt = $("#startAt").val();
    // let x = initStartAt ? undefined : new Date();
    // dateTimePicker({
    //     dateTimePickerId: "datetimepicker1",
    //     inputNameBind: "startAt",
    //     minDate: x,
    // });

    // selectBindInput({
    //     selectId: "busSelect",
    //     inputBindName: null,
    //     cb: (selected) => {
    //         const url = selected.getAttribute("data-image");
    //         const busImage = document.getElementById("busImage");
    //         busImage.src = url;

    //         console.log({ selected, url });
    //     },
    // });
</script>
