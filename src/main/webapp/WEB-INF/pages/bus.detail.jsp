<%-- Document : bus.detail.jsp Created on : Aug 2, 2023, 3:05:03 PM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="container mt-4">
    <div class="row">
        <div class="col-12 col-md-6">
            <img src="${bus.image}" class="img-thumbnail rounded mx-auto d-block" alt="..." />
        </div>
        <div class="col-12 col-md-6">
            <div class="">
                <span>Id: </span>
                <span class="h6">${bus.id}</span>
            </div>
            <div class="">
                <span>Biển số xe: </span>
                <span class="h6">${bus.licensePlate}</span>
            </div>
            <div class="">
                <span>Tổng số chỗ ngồi: </span>
                <span class="h6">${seatCount}</span>
            </div>
            <div class="">
                <span>Chỗ ngồi trên xe: </span>
            </div>
            <section>
                <div class="align-items-center d-flex flex-column mb-3">
                    <div id="seatArrayContainer" style="--col: ${seats.col}; --row: ${seats.row}">
                        <c:forEach items="${seats.array}" var="seat" varStatus="i">
                            <c:choose>
                                <c:when test="${seat.available == true}">
                                    <button
                                        type="button"
                                        data-pos="${seat.x}_${seat.y}"
                                        class="text-primary d-flex align-items-center justify-content-center"
                                        style="--x: ${seat.x}; --y: ${seat.y};"
                                    >
                                        <h3 class="m-0" withoutActive>
                                            <i class="bi bi-circle"></i>
                                        </h3>
                                        <h3 class="m-0" withActive>
                                            <i class="bi bi-circle-fill"></i>
                                        </h3>
                                    </button>
                                </c:when>

                                <c:otherwise>
                                    <button
                                        data-pos="${seat.x}_${seat.y}"
                                        class="text-primary d-flex align-items-center justify-content-center"
                                        style="--x: ${seat.x}; --y: ${seat.y};"
                                        disabled
                                    >
                                        <h3 class="m-0" withoutActive>
                                            <i class="bi bi-circle"></i>
                                        </h3>
                                        <h3 class="m-0" withActive>
                                            <i class="bi bi-circle-fill"></i>
                                        </h3>
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                </div>

                <c:url value="/css/busSeat.css" var="busSeat" />
                <link rel="stylesheet" href="${busSeat}" />

                <c:url value="/js/busDetailSeat.js" var="busDetailSeat" />
                <script src="${busDetailSeat}"></script>
            </section>
        </div>
    </div>
</div>
