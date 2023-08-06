<%-- Document : trips.detail Created on : Aug 4, 2023, 12:52:13 PM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/trips" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
        </div>
        <h3 class="text-center">Tìm chuyến xe</h3>

        <div class="invisible" style="flex: 1"></div>
    </div>

    <c:url value="/trips" var="action" />
    <form method="get" action="${action}" enctype="multipart/form-data">
        <!-- Route -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-cursor"></i>
                </span>
                <select class="form-select" id="startLocation">
                    <option value="" selected disabled>Chọn điểm đi</option>

                    <c:forEach items="${routesStart}" var="c">
                        <option value="${c.startLocation}">${c.startLocation}</option>
                    </c:forEach>
                </select>
            </div>
            <input type="hidden" name="startLocation" />
        </div>
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-geo-fill"></i>
                </span>
                <select class="form-select" id="endLocation">
                    <option value="" selected disabled>Chọn điểm đến</option>

                    <c:forEach items="${routesEnd}" var="c">
                        <option value="${c.endLocation}">${c.endLocation}</option>
                    </c:forEach>
                </select>
            </div>
            <input type="hidden" name="endLocation" />
        </div>

        <!-- Bus -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-bus-front-fill"></i>
                </span>
                <select class="form-select" id="busId">
                    <option value="" selected disabled>Chọn xe khách</option>

                    <c:forEach items="${buses}" var="c">
                        <option value="${c.id}">
                            ${c.licensePlate} - ${fn:length(c.busSeatTemplateSet)} chỗ
                        </option>
                    </c:forEach>
                </select>
            </div>
            <input type="hidden" name="busId" />
        </div>

        <!-- price -->
        <div class="mb-3">
            <div class="input-group mb-3">
                <span class="input-group-text">Khoảng giá</span>
                <input type="text" id="fromPrice" class="form-control" placeholder="Từ" />
                <span class="input-group-text">-</span>
                <input type="text" id="toPrice" class="form-control" placeholder="Đến" />
            </div>
            <input type="hidden" name="fromPrice" />
            <input type="hidden" name="toPrice" />

            <div class="range-slide">
                <div class="slide bg-secondary">
                    <div class="line bg-primary" id="line" style="left: 0%; right: 0%"></div>
                    <span
                        class="thumb border border-primary-subtle bg-primary"
                        id="thumbMin"
                        style="left: 0%"
                    ></span>
                    <span
                        class="thumb border border-primary-subtle bg-primary"
                        id="thumbMax"
                        style="left: 100%"
                    ></span>
                </div>
                <input
                    id="rangeMin"
                    type="range"
                    max="${toPrice}"
                    min="${fromPrice}"
                    step="1000"
                    value="${fromPrice}"
                />
                <input
                    id="rangeMax"
                    type="range"
                    max="${toPrice}"
                    min="${fromPrice}"
                    step="1000"
                    value="${toPrice}"
                />
                <div>
                    <style>
                        :root {
                            --height: 4px;
                            --thumb-size: 18px;
                        }

                        .range-slide {
                            position: relative;
                            height: var(--height);
                            width: 100%;
                        }

                        .range-slide *:not(input) {
                            user-select: none;
                        }

                        .slide {
                            position: absolute;
                            top: 0;
                            height: var(--height);
                            left: 0;
                            right: 0;
                            border-radius: 999px;
                        }

                        .line {
                            position: absolute;
                            top: 0;
                            height: var(--height);
                        }

                        .thumb {
                            position: absolute;
                            z-index: 2;
                            text-align: left;
                            border-radius: 50%;
                            outline: none;
                            top: 50%;
                            transform: translateY(-50%);
                            height: var(--thumb-size);
                            width: var(--thumb-size);
                        }
                        .thumb#thumbMax {
                            transform: translate(-100%, -50%);
                        }

                        input[type="range"] {
                            -webkit-appearance: none;
                            appearance: none;
                            position: absolute;
                            pointer-events: none;
                            z-index: 3;
                            height: var(--height);
                            top: 0;
                            width: 100%;
                            opacity: 0;
                            margin: 0;
                        }

                        input[type="range"]::-webkit-slider-thumb {
                            -webkit-appearance: none;
                            appearance: none;
                            pointer-events: all;
                            border-radius: 50%;
                            cursor: pointer;
                            width: var(--thumb-size);
                            height: var(--thumb-size);
                        }
                    </style>
                </div>
            </div>
        </div>

        <!-- driverId -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-person-rolodex"></i>
                </span>

                <select class="form-select" id="driverId">
                    <option value="" selected disabled>Chọn tài xế</option>

                    <c:forEach items="${drivers}" var="c">
                        <option value="${c.id}">${c.lastName} ${c.firstName}</option>
                    </c:forEach>
                </select>
            </div>
            <input type="hidden" name="driverId" />
        </div>

        <!-- startAt -->
        <div class="mb-3 row">
            <div class="col col-md-6">
                <div id="dateTimePickerFrom" class="input-group">
                    <span class="input-group-text"> Từ </span>
                    <input type="text" class="form-control" readonly />
                </div>
            </div>

            <div class="col col-md-6">
                <div id="dateTimePickerTo" class="input-group">
                    <span class="input-group-text"> Đến </span>
                    <input type="text" class="form-control" readonly />
                </div>
            </div>

            <input type="hidden" name="timeFrom" />
            <input type="hidden" name="timeTo" />
        </div>

        <button type="submit" class="btn btn-outline-info w-100">Tìm</button>
    </form>
</section>
<script>
    const minInit = parseInt(document.getElementById("rangeMin").min);
    const maxInit = parseInt(document.getElementById("rangeMin").max);
    const gap = maxInit / 10;

    let min = minInit;
    let max = maxInit;

    $("input[name=fromPrice]").attr("disabled", "");
    $("input[name=toPrice]").attr("disabled", "");
    rangeMinHandler.call($("#rangeMin")[0]);
    rangeMaxHandler.call($("#rangeMax")[0]);

    function calcLeftPosition(value) {
        return (value * 100) / maxInit;
    }

    $("#rangeMin").on("input", rangeMinHandler);
    $("#rangeMax").on("input", rangeMaxHandler);
    function rangeMinHandler() {
        const newValue = parseInt(this.value);
        // console.log({ newValue, min, max, b: newValue + gap > max });
        if (newValue + gap > max) {
            $(this).val(min);
            return;
        }
        min = newValue;
        $("#thumbMin").css("left", calcLeftPosition(newValue) + "%");
        $("#line").css({
            left: calcLeftPosition(newValue) + "%",
            right: 100 - calcLeftPosition(max) + "%",
        });
        $("#fromPrice").val(min.toLocaleString());

        // console.log(min != minInit);
        if (min != minInit) {
            $("input[name=fromPrice]").val(min);
            $("input[name=fromPrice]").removeAttr("disabled");
        }
    }
    function rangeMaxHandler() {
        const newValue = parseInt(this.value);
        // console.log({ newValue, min, max, b: newValue - gap < min });
        if (newValue - gap < min) {
            $(this).val(max);
            return;
        }
        max = newValue;
        $("#thumbMax").css("left", calcLeftPosition(newValue) + "%");
        $("#line").css({
            left: calcLeftPosition(min) + "%",
            right: 100 - calcLeftPosition(newValue) + "%",
        });
        $("#toPrice").val(max.toLocaleString());

        // console.log(max != maxInit);
        if (max != maxInit) {
            $("input[name=toPrice]").val(max);
            $("input[name=toPrice]").removeAttr("disabled");
        }
    }
</script>
<c:url value="/js/selectBindInput.js" var="selectBindInput" />
<script src="${selectBindInput}"></script>

<c:url value="/js/dateTimePicker.js" var="dateTimePicker" />
<script src="${dateTimePicker}"></script>
<script>
    dateTimePicker({
        dateTimePickerId: "dateTimePickerFrom",
        inputNameBind: "timeFrom",
        initTime: "",
    });
    dateTimePicker({
        dateTimePickerId: "dateTimePickerTo",
        inputNameBind: "timeTo",
        initTime: "",
    });

    selectBindInput({ selectId: "startLocation", inputBindName: "startLocation" });
    selectBindInput({ selectId: "endLocation", inputBindName: "endLocation" });
    selectBindInput({ selectId: "busId", inputBindName: "busId" });
    selectBindInput({ selectId: "driverId", inputBindName: "driverId" });
</script>
