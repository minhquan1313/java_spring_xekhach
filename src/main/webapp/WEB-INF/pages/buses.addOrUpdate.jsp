<%-- Document : bus.addOrUpdate Created on : Aug 1, 2023, 3:52:55 PM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/buses" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
        </div>
        <h3 class="text-center">
            <c:choose>
                <c:when test="${bus.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
            xe khách
        </h3>

        <div class="invisible" style="flex: 1"></div>
    </div>

    <c:url value="/buses/add" var="action" />
    <form:form method="post" action="${action}" modelAttribute="bus" enctype="multipart/form-data">
        <form:errors path="*" element="div" cssClass="alert alert-danger" />
        <form:hidden path="id" />
        <form:hidden path="image" />
        <c:if test="${bus.id == null}">
            <input type="hidden" name="selectedSeats" id="selectedSeats" value="" />
        </c:if>
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-dash-square-fill"></i>
                </span>
                <form:input
                    type="text"
                    class="form-control"
                    placeholder="Biển số xe"
                    path="licensePlate"
                />
            </div>
            <form:errors path="licensePlate" element="div" cssClass="text-danger" />
        </div>

        <c:if test="${bus.id != null}">
            <div class="mb-3">
                <img
                    src="${bus.image}"
                    width="300"
                    class="img-thumbnail rounded mx-auto d-block"
                    alt="..."
                />
            </div>
        </c:if>

        <div class="mb-3">
            <label for="formFile" class="form-label">
                <c:choose>
                    <c:when test="${bus.id == null}"> Chọn ảnh </c:when>
                    <c:otherwise> Chọn ảnh mới </c:otherwise>
                </c:choose>
            </label>
            <form:input class="form-control" type="file" id="formFile" path="file" />
        </div>

        <c:if test="${bus.id == null}">
            <section class="mb-3">
                <label for="seatSelect" class="form-label"> Chọn kích cỡ mẫu </label>
                <select id="seatSelect" class="form-select mb-3">
                    <option selected value="5x10">5x10</option>
                    <option value="10x20">10x20</option>
                </select>

                <div class="align-items-center d-flex flex-column mb-3">
                    <div id="seatArrayContainer" style="--col: x; --row: x"></div>
                </div>

                <div class="d-flex">
                    <span class="">Tổng số chỗ ngồi đã chọn: </span>
                    <span id="seatCount" class="ms-3">1</span>
                </div>
                <div class="text-danger">${noSeatSelectedError}</div>

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

                    <c:url value="/js/busAddSeat.js" var="busAddSeat" />
                    <script src="${busAddSeat}"></script>
                </div>
            </section>
        </c:if>

        <button type="submit" class="btn btn-outline-info w-100">
            <c:choose>
                <c:when test="${bus.id == null}"> Thêm </c:when>
                <c:otherwise> Cập nhật </c:otherwise>
            </c:choose>
        </button>
    </form:form>
</section>
