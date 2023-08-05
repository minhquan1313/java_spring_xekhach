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
<section class="container pt-4 my-auto h-100">
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
                        <c:choose>
                            <c:when test="${c.id == trip.routeId.id}">
                                <option value="${c.id}" selected>
                                    ${c.startLocation} - ${c.endLocation}
                                </option>
                            </c:when>
                            <c:otherwise>
                                <option value="${c.id}">
                                    ${c.startLocation} - ${c.endLocation}
                                </option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </form:select>
            </div>
            <form:errors path="routeId" element="div" cssClass="text-danger" />
        </div>

        <!-- Bus -->
        <div class="mb-3">
            <div class="input-group mb-2">
                <span class="input-group-text">
                    <i class="bi bi-bus-front-fill"></i>
                </span>
                <form:select class="form-select" path="busId" id="busSelect">
                    <c:forEach items="${buses}" var="c">
                        <c:if test="${c.id == trip.busId.id}">
                            <c:set value="selected" var="selected" />
                        </c:if>
                        <option value="${c.id}" data-image="${c.image}" ${selected}>
                            ${c.licensePlate} - ${fn:length(c.busSeatTemplateSet)} chỗ
                        </option>
                    </c:forEach>
                </form:select>
            </div>
            <div class="col col-md-6 mx-auto">
                <div>
                    <img
                        id="busImage"
                        src="?"
                        class="img-thumbnail rounded d-block object-fit-contain mx-auto"
                        alt="..."
                        style="max-height: 60vh"
                    />
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
                        <c:if test="${c.id == trip.driverId.id}">
                            <c:set value="selected" var="selected" />
                        </c:if>
                        <option value="${c.id}" ${selected}>
                            ${c.lastName} ${c.firstName} - ${c.roleId.title}
                        </option>
                    </c:forEach>
                </form:select>
            </div>
            <form:errors path="driverId" element="div" cssClass="text-danger" />
        </div>
        <!-- startAt -->
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
            </div>
            <form:errors path="price" element="div" cssClass="text-danger" />
        </div>

        <c:if test="${trip.id == null}">
            <section class="mb-3"></section>
        </c:if>

        <button type="submit" class="btn btn-outline-info w-100">
            <c:choose>
                <c:when test="${trip.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
        </button>
    </form:form>
</section>

<c:url value="/js/dateTimePicker.js" var="dateTimePicker" />
<script src="${dateTimePicker}"></script>
<script>
    dateTimePicker({ dateTimePickerId: "datetimepicker1", inputNameBind: "startAt" });

    const busImage = document.getElementById("busImage");
    const busSelect = document.getElementById("busSelect");
    setImage(busImage, busSelect);

    busSelect.addEventListener("change", (e) => setImage(busImage, busSelect));

    function setImage(img, select) {
        const selected = select.selectedOptions[0];
        const url = selected.getAttribute("data-image");
        img.src = url;

        console.log({ selected, url });
    }
</script>
