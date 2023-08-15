<%-- Document : routes Created on : Aug 1, 2023, 10:12:59 AM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<c:url value="/revenue" var="currentUrl" />
<section class="my-4">
    <div class="container">
        <div class="d-flex align-items-center mb-3">
            <div class="d-flex justify-content-start" style="flex: 1">
                <c:url value="/" var="backUrl" />
                <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
            </div>

            <h3 class="text-center">Thông tin doanh số</h3>
            <div class="d-flex justify-content-end" style="flex: 1"></div>
        </div>
    </div>

    <form method="get" action="${currentUrl}" class="mb-3">
        <div class="container">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Năm" id="year" value="${year}" />
                <input type="hidden" class="form-control" placeholder="Năm bắt đầu" name="year" readonly />
                <button type="submit" class="btn btn-outline-secondary">Đi</button>
            </div>
        </div>

        <div class="container-xxl mb-3">
            <div class="row g-3">
                <div class="col-12 col-lg-8">
                    <canvas data-label-chart="${revenueByMonthsCurrentYChartJs.dataOf}" data-labels-chart="${revenueByMonthsCurrentYChartJs.label}" data-data-chart="${revenueByMonthsCurrentYChartJs.data}" data-table-name-chart="${revenueByMonthsCurrentYChartJs.tableName}" data-type-chart="${revenueByMonthsCurrentYChartJs.chartType}" data-postfix-chart="${revenueByMonthsCurrentYChartJs.dataPostfix}"></canvas>
                </div>

                <div class="col-12 col-lg-4">
                    <canvas data-label-chart="${revenueByQuartersChartJs.dataOf}" data-labels-chart="${revenueByQuartersChartJs.label}" data-data-chart="${revenueByQuartersChartJs.data}" data-table-name-chart="${revenueByQuartersChartJs.tableName}" data-type-chart="${revenueByQuartersChartJs.chartType}" data-postfix-chart="${revenueByQuartersChartJs.dataPostfix}"></canvas>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row g-3">
                <div class="col-12 col-lg">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Năm bắt đầu" id="yearStart" value="${yearStart}" />
                        <input type="hidden" class="form-control" placeholder="Năm bắt đầu" name="yearStart" readonly />

                        <button type="submit" class="btn btn-outline-secondary">Đi</button>
                    </div>
                </div>

                <div class="col-12 col-lg">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Năm kết thúc" id="yearEnd" value="${yearEnd}" />
                        <input type="hidden" class="form-control" placeholder="Năm kết thúc" name="yearEnd" readonly />

                        <button type="submit" class="btn btn-outline-secondary">Đi</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-xxl">
            <canvas data-label-chart="${revenueByMonthsIn5YearsChartJs.dataOf}" data-labels-chart="${revenueByMonthsIn5YearsChartJs.label}" data-data-chart="${revenueByMonthsIn5YearsChartJs.data}" data-table-name-chart="${revenueByMonthsIn5YearsChartJs.tableName}" data-type-chart="${revenueByMonthsIn5YearsChartJs.chartType}" data-postfix-chart="${revenueByMonthsIn5YearsChartJs.dataPostfix}"></canvas>
        </div>
    </form>
</section>

<c:url value="/js/chartJsCreate.js" var="chartJsCreate" />
<script src="${chartJsCreate}"></script>

<c:url value="/js/inputBindInput.js" var="inputBindInput" />
<script src="${inputBindInput}"></script>

<script>
    // $("form").on("submit",function(){
    //     $(this).find
    // })
    //     .find("input[name]")
    //     .each(function () {
    //         console.log($(this));
    //     });
    inputBindInput({ inputId: "year", inputBindName: "year" });
    inputBindInput({ inputId: "yearStart", inputBindName: "yearStart" });
    inputBindInput({ inputId: "yearEnd", inputBindName: "yearEnd" });
</script>
