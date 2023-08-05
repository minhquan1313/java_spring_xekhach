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
<section class="container pt-4 my-auto h-100">
    <c:url value="/trips" var="action" />
    <form method="get" action="${action}" enctype="multipart/form-data">
        <!-- Route -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-cursor"></i>
                </span>
                <select class="form-select" name="startLocation">
                    <option value="" selected disabled>Chọn điểm đi</option>

                    <c:forEach items="${routesStart}" var="c">
                        <option value="${c.id}">${c.startLocation}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-geo-fill"></i>
                </span>
                <select class="form-select" name="endLocation">
                    <option value="" selected disabled>Chọn điểm đến</option>

                    <c:forEach items="${routesEnd}" var="c">
                        <option value="${c.id}">${c.endLocation}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <!-- Bus -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-bus-front-fill"></i>
                </span>
                <select class="form-select" name="busId">
                    <option value="" selected disabled>Chọn xe khách</option>

                    <c:forEach items="${buses}" var="c">
                        <option value="${c.id}">
                            ${c.licensePlate} - ${fn:length(bus.busSeatTemplateSet)} chỗ
                        </option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <!-- price -->
        <div class="mb-3">
            <div class="input-group mb-3">
                <span class="input-group-text">Khoảng giá</span>
                <input
                    type="text"
                    id="fromPrice"
                    name="fromPrice"
                    class="form-control"
                    placeholder="Từ"
                />
                <span class="input-group-text">-</span>
                <input
                    type="text"
                    id="toPrice"
                    name="toPrice"
                    class="form-control"
                    placeholder="Đến"
                />
            </div>

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
                <input id="rangeMin" type="range" max="300000" min="0" step="1000" value="0" />
                <input id="rangeMax" type="range" max="300000" min="0" step="1000" value="300000" />
                <div>
                    <style>
                        :root {
                            --height: 4px;
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
                            height: 18px;
                            width: 18px;
                            margin-left: -9px;
                        }

                        input[type="range"] {
                            -webkit-appearance: none;
                            appearance: none;
                            position: absolute;
                            pointer-events: none;
                            z-index: 3;
                            height: 3px;
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
                            width: 18px;
                            height: 18px;
                        }
                    </style>
                    <script>
                        const minInit = document.getElementById("rangeMin").min;
                        const maxInit = document.getElementById("rangeMin").max;
                        const gap = maxInit / 10;

                        let min = minInit;
                        let max = maxInit;

                        rangeMinHandler.call($("#rangeMin")[0]);
                        rangeMaxHandler.call($("#rangeMax")[0]);

                        function calcLeftPosition(value) {
                            return (value * 100) / maxInit;
                        }

                        $("#rangeMin").on("input", rangeMinHandler);
                        $("#rangeMax").on("input", rangeMaxHandler);
                        function rangeMinHandler() {
                            const newValue = this.value;
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
                            $("#fromPrice").val(min);
                        }
                        function rangeMaxHandler() {
                            const newValue = this.value;
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
                            $("#toPrice").val(max);
                        }
                    </script>
                </div>
            </div>
        </div>

        <!-- driverId -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-person-rolodex"></i>
                </span>

                <select class="form-select" name="driverId">
                    <option value="" selected disabled>Chọn tài xế</option>

                    <c:forEach items="${drivers}" var="c">
                        <option value="${c.id}">${c.lastName} ${c.firstName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <!-- startAt -->
        <div class="mb-3 row">
            <div id="datetimepickerFrom" class="input-group col col-md-6">
                <span class="input-group-text"> Từ </span>
                <input type="hidden" name="timeFrom" />
                <input id="datetimepickerFromInput" type="text" class="form-control" readonly />
            </div>

            <div id="datetimepickerTo" class="input-group col col-md-6">
                <span class="input-group-text"> Đến </span>
                <input type="hidden" name="timeTo" />
                <input id="datetimepickerToInput" type="text" class="form-control" readonly />
            </div>
        </div>
        <!-- here here here  -->
        <div class="mb-3">
            <div
                class="input-group"
                id="datetimepicker1"
                data-td-target-input="nearest"
                data-td-target-toggle="nearest"
            >
                <span class="input-group-text">
                    <i class="bi bi-calendar-event"></i>
                </span>
                <input
                    id="datetimepicker1Input"
                    type="text"
                    class="form-control"
                    data-td-target="#datetimepicker1"
                    readonly
                />
                <span
                    class="input-group-text"
                    data-td-target="#datetimepicker1"
                    data-td-toggle="datetimepicker"
                    style="cursor: pointer"
                >
                    <i class="bi bi-calendar-plus"></i>
                </span>
            </div>
            <hidden path="startAt" />
            <errors path="startAt" element="div" cssClass="text-danger" />
        </div>

        <button type="submit" class="btn btn-outline-info w-100">Tìm</button>
    </form>
</section>

<c:url value="/js/dateTimePicker.js" var="dateTimePicker" />
<script src="${dateTimePicker}"></script>
<script>
    // dateTimePicker({ dateTimePickerId: "datetimepicker1", inputNameBind: "startAt" });

    // const busImage = document.getElementById("busImage");
    // const busSelect = document.getElementById("busSelect");
    // setImage(busImage, busSelect);

    // busSelect.addEventListener("change", (e) => setImage(busImage, busSelect));

    // function setImage(img, select) {
    //     const selected = select.selectedOptions[0];
    //     const url = selected.getAttribute("data-image");
    //     img.src = url;

    //     console.log({ selected, url });
    // }
</script>
