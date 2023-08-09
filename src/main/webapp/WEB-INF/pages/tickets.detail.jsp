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
        <h3 class="text-center">Chi tiết vé xe</h3>

        <div class="invisible" style="flex: 1"></div>
    </div>

    <!-- tripId -->
    <div class="mb-3">
        <div class="input-group">
            <span class="input-group-text" data-bs-toggle="tooltip" data-bs-title="Mã vé">
                <i class="bi bi-person"></i>
            </span>
            <div class="form-control">${ticket.id}</div>
        </div>
    </div>

    <!-- bookingUser -->
    <div class="mb-3">
        <div class="input-group">
            <span class="input-group-text" data-bs-toggle="tooltip" data-bs-title="User đặt vé">
                <i class="bi bi-person"></i>
            </span>
            <div class="form-control">${ticket.userId}</div>
        </div>
    </div>

    <!-- createdAt -->
    <div class="mb-3">
        <div class="input-group">
            <span
                class="input-group-text"
                data-bs-toggle="tooltip"
                data-bs-title="Thời gian đặt vé"
            >
                <i class="bi bi-wallet2"></i>
            </span>

            <div class="form-control">
                <fmt:formatDate value="${ticket.createdAt}" pattern="${date_pattern}" />
            </div>
        </div>
    </div>

    <!-- Trip -->
    <div class="mb-3">
        <div class="input-group">
            <span class="input-group-text">
                <i class="bi bi-geo-fill"></i>
            </span>

            <c:url value="/trips?id=${ticket.tripId.id}" var="tripFind" />
            <div class="form-control">
                <a
                    href="${tripFind}"
                    class="link-underline link-underline-opacity-0 text-primary-emphasis"
                >
                    Mã chuyến: ${ticket.tripId.id}
                </a>
            </div>

            <ul
                class="list-group tripIdSelectData"
                data-tripId="${ticket.tripId.id}"
                style="flex: 1"
            >
                <li class="list-group-item">
                    Tuyến: ${ticket.tripId.routeId.startLocation} ->
                    ${ticket.tripId.routeId.endLocation}
                </li>
                <li class="list-group-item">
                    Khởi hành:
                    <fmt:formatDate value="${ticket.tripId.startAt}" pattern="${date_pattern}" />
                </li>
                <li class="list-group-item">
                    Xe ${ticket.tripId.busId.licensePlate} -
                    ${fn:length(ticket.tripId.busId.busSeatTripSet)}
                </li>
                <li class="list-group-item">Tài xế ${ticket.tripId.driverId}</li>
            </ul>
        </div>
    </div>

    <!-- paidPrice -->
    <div class="mb-3 row g-3">
        <div class="col-12 col-lg-6">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-currency-dollar"></i>
                </span>
                <div class="form-control">
                    <fmt:formatNumber
                        type="number"
                        maxFractionDigits="0"
                        value="${ticket.paidPrice}"
                    />
                </div>
                <span class="input-group-text"> VND </span>
            </div>
        </div>

        <!-- paidWith -->
        <div class="col-12 col-lg-6">
            <div class="input-group">
                <span
                    class="input-group-text"
                    class="input-group-text"
                    data-bs-toggle="tooltip"
                    data-bs-title="Phương thức thanh toán"
                >
                    <i class="bi bi-wallet2"></i>
                </span>
                <div class="form-control">${ticket.paidWith}</div>
            </div>
        </div>
    </div>

    <div class="mb-3 row g-3">
        <div class="col">
            <!-- isPaid -->
            <div class="input-group">
                <c:choose>
                    <c:when test="${ticket.isPaid == 'true'}">
                        <span class="input-group-text">
                            <i class="bi bi-geo-fill"></i>
                        </span>
                        <div class="form-control">Đã thanh toán</div>
                    </c:when>

                    <c:otherwise>
                        <span class="input-group-text">
                            <i class="bi bi-geo-fill"></i>
                        </span>
                        <div class="form-control">Chưa thanh toán</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <c:if test="${ticket.staffId != null}">
            <div class="col">
                <div class="input-group">
                    <span class="input-group-text"> Nhân viên xuất vé </span>

                    <c:url value="/users?id=${ticket.staffId.id}" var="userFind" />
                    <div class="form-control">
                        <a
                            href="${userFind}"
                            class="link-underline link-underline-opacity-0 text-primary-emphasis"
                            >${ticket.staffId}
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</section>
