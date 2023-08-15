<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<section class="my-4">
    <div class="container">
        <div class="d-flex align-items-center mb-3">
            <div class="d-flex justify-content-start" style="flex: 1">
                <c:url value="/trips" var="backUrl" />
                <a href="${backUrl}" class="btn btn-outline-info text-nowrap"><spring:message code="ui.global.back" /> </a>
            </div>

            <h3 class="text-center">Thông tin mật độ chuyến xe</h3>
            <div class="d-flex justify-content-end" style="flex: 1"></div>
        </div>
    </div>

    <div class="mb-3">
        <div class="container-xxl mb-3">
            <canvas data-label-chart="${routeChartJs.dataOf}" data-labels-chart="${routeChartJs.label}" data-data-chart="${routeChartJs.data}" data-table-name-chart="${routeChartJs.tableName}" data-type-chart="${routeChartJs.chartType}"></canvas>
        </div>
    </div>
</section>

<c:url value="/js/chartJsCreate.js" var="chartJsCreate" />
<script src="${chartJsCreate}"></script>
