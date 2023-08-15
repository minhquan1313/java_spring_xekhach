<%-- Document : trips.addOrUpdate Created on : Aug 4, 2023, 12:51:57 PM Author : Binh --%>
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
        <h3 class="text-center">
            <c:choose>
                <c:when test="${trip.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
            chuyến xe
        </h3>

        <div class="invisible" style="flex: 1"></div>
    </div>

    <c:url value="/trips/add" var="action" />
    <form:form modelAttribute="trip" method="post" action="${action}" enctype="multipart/form-data">
        <form:errors path="*" element="div" cssClass="alert alert-danger" />
        <form:hidden path="id" />

        <!-- Route -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-cursor"></i>
                </span>
                <span class="input-group-text">
                    <i class="bi bi-geo-fill"></i>
                </span>
                <form:select class="form-select" path="routeId">
                    <c:forEach items="${routes}" var="c">
                        <c:set value="" var="selected" />
                        <c:if test="${c.id == trip.routeId.id}">
                            <c:set value="selected" var="selected" />
                        </c:if>
                        <option value="${c.id}" ${selected}>${c.startLocation} - ${c.endLocation}</option>
                    </c:forEach>
                </form:select>

                <c:url value="/routes/add" var="createUrl" />
                <a href="${createUrl}" class="input-group-text link-underline link-underline-opacity-0 bg-info-subtle">
                    <i class="bi bi-plus-square-dotted"></i>
                </a>
            </div>
            <form:errors path="routeId" element="div" cssClass="text-danger" />
        </div>

        <!-- Bus -->
        <!-- Không cho phép thay đổi xe - vì liên quan đến chỗ ngồi -->
        <div class="mb-3">
            <div class="input-group mb-2">
                <span class="input-group-text">
                    <i class="bi bi-bus-front-fill"></i>
                </span>

                <c:set value="" var="disabled" />
                <c:if test="${trip.id != null}">
                    <c:set value="disabled" var="disabled" />
                </c:if>

                <form:select class="form-select" path="busId" id="busSelect">
                    <c:forEach items="${buses}" var="c">
                        <c:set value="" var="selected" />
                        <c:if test="${c.id == trip.busId.id}">
                            <c:set value="selected" var="selected" />
                            <option value="${c.id}" data-image="${c.image}" ${selected}>${c.licensePlate} - ${c.busSeatTemplateCount} chỗ</option>
                        </c:if>

                        <c:if test="${trip.id == null}">
                            <option value="${c.id}" data-image="${c.image}" ${selected}>${c.licensePlate} - ${c.busSeatTemplateCount} chỗ</option>
                        </c:if>
                    </c:forEach>
                </form:select>
                <c:url value="/buses/add" var="createUrl" />
                <a href="${createUrl}" class="input-group-text link-underline link-underline-opacity-0 bg-info-subtle">
                    <i class="bi bi-plus-square-dotted"></i>
                </a>
            </div>
            <div class="col col-md-6 mx-auto">
                <div>
                    <img id="busImage" src="?" class="img-thumbnail rounded d-block object-fit-contain mx-auto" alt="..." style="max-height: 60vh" />
                </div>
            </div>
            <form:errors path="busId" element="div" cssClass="text-danger" />
        </div>
        <!-- driverId -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-person-rolodex"></i>
                </span>
                <form:select class="form-select" path="driverId">
                    <c:forEach items="${drivers}" var="c">
                        <c:set value="" var="selected" />
                        <c:if test="${c.id == trip.driverId.id}">
                            <c:set value="selected" var="selected" />
                        </c:if>
                        <option value="${c.id}" ${selected}>${c}</option>
                    </c:forEach>
                </form:select>

                <c:url value="/users/add" var="createUrl" />
                <a href="${createUrl}" class="input-group-text link-underline link-underline-opacity-0 bg-info-subtle">
                    <i class="bi bi-plus-square-dotted"></i>
                </a>
            </div>

            <form:errors path="driverId" element="div" cssClass="text-danger" />
        </div>
        <!-- startAt -->
        <div class="mb-3">
            <div class="input-group" id="datetimepicker1">
                <span class="input-group-text">
                    <i class="bi bi-calendar-event"></i>
                </span>
                <input id="datetimepicker1Input" type="text" class="form-control" readonly />
                <span class="input-group-text" data-td-toggle="datetimepicker" style="cursor: pointer">
                    <i class="bi bi-calendar-plus"></i>
                </span>
            </div>
            <form:hidden path="startAt" />
            <form:errors path="startAt" element="div" cssClass="text-danger" />
        </div>

        <!-- price -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-currency-dollar"></i>
                </span>
                <form:input type="text" class="form-control" placeholder="Giá tiền" path="price" />
                <span class="input-group-text"> VND </span>
            </div>
            <form:errors path="price" element="div" cssClass="text-danger" />
        </div>

        <button type="submit" class="btn btn-outline-info w-100">
            <c:choose>
                <c:when test="${trip.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
        </button>
    </form:form>
</section>

<c:url value="/js/selectBindInput.js" var="selectBindInput" />
<script src="${selectBindInput}"></script>

<c:url value="/js/dateTimePicker.js" var="dateTimePicker" />
<script src="${dateTimePicker}"></script>

<script>
    let initStartAt = $("#startAt").val();
    let x = initStartAt ? undefined : new Date();
    dateTimePicker({
        dateTimePickerId: "datetimepicker1",
        inputNameBind: "startAt",
        minDate: x,
    });

    selectBindInput({
        selectId: "busSelect",
        inputBindName: null,
        cb: (selected) => {
            const url = selected.getAttribute("data-image");
            const busImage = document.getElementById("busImage");
            busImage.src = url;

            console.log({ selected, url });
        },
    });
</script>
