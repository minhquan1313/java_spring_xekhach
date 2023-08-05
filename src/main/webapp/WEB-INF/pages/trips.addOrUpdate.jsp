<%-- Document : trips.addOrUpdate Created on : Aug 4, 2023, 12:51:57 PM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%> add or update
<section class="container pt-4 my-auto h-100">
    <c:url value="/trips/add" var="action" />
    <form:form modelAttribute="trip" method="post" action="${action}" enctype="multipart/form-data">
        <form:errors path="*" element="div" cssClass="alert alert-danger" />
        <form:hidden path="id" />

        <!-- Route -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-dash-square-fill"></i>
                </span>
                <span class="input-group-text">
                    <i class="bi bi-dash-square-fill"></i>
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
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-dash-square-fill"></i>
                </span>
                <form:select class="form-select" path="busId">
                    <c:forEach items="${buses}" var="c">
                        <c:choose>
                            <c:when test="${c.id == trip.busId.id}">
                                <option value="${c.id}" selected>${c.licensePlate}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${c.id}">${c.licensePlate}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </form:select>
            </div>
            <form:errors path="busId" element="div" cssClass="text-danger" />
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
                    <i class="bi bi-dash-square-fill"></i>
                </span>
                <input
                    id="datetimepicker1Input"
                    type="text"
                    class="form-control"
                    data-td-target="#datetimepicker1"
                />
                <span
                    class="input-group-text"
                    data-td-target="#datetimepicker1"
                    data-td-toggle="datetimepicker"
                >
                    <i class="bi bi-dash-square-fill"></i>
                </span>
            </div>
            <form:hidden path="startAt" />
            <form:errors path="startAt" element="div" cssClass="text-danger" />
        </div>

        <!-- price -->
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-dash-square-fill"></i>
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

<c:url value="/js/dateTimePicker.js" var="script" />
<script src="${script}"></script>
<script>
    dateTimePicker("datetimepicker1", "startAt");
</script>
