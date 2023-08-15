<%-- Document : bus.detail.jsp Created on : Aug 2, 2023, 3:05:03 PM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--  -->
<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/buses" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap"> <spring:message code="ui.global.back" /> </a>
        </div>
        <h3 class="text-center">
            <spring:message code="ui.global.detail" />

            <spring:message code="ui.bus" var="__header_title" />
            ${fn:toLowerCase(__header_title)}
        </h3>

        <div class="invisible" style="flex: 1"></div>
    </div>

    <div class="row g-3 table-responsive">
        <div class="col-12 col-lg-6">
            <img src="${bus.image}" class="img-thumbnail rounded mx-auto d-block" alt="..." />
        </div>
        <div class="col-12 col-lg-6">
            <div>
                <span> <spring:message code="ui.global.id" />: </span>
                <span class="h6">${bus.id}</span>
            </div>
            <div>
                <span> <spring:message code="ui.bus.license_plate" /> : </span>
                <span class="h6">${bus.licensePlate}</span>
            </div>
            <div>
                <span> <spring:message code="ui.bus.seat.count" />: </span>
                <span class="h6">${seatCount}</span>
            </div>
            <div>
                <span><spring:message code="ui.bus.seat" />: </span>
            </div>
            <section>
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

                            <button type="button" data-id="${c.id}" data-pos="${c.x}_${c.y}" class="text-primary" style="--x: ${c.x}; --y: ${c.y};" ${disabled} ${userChosen}>
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

                <c:url value="/css/busSeat.css" var="busSeat" />
                <link rel="stylesheet" href="${busSeat}" />
            </section>
        </div>
    </div>
</section>
