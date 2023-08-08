<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div style="max-width: 800px; margin: 0 auto;">
    <h2>Thống kê mật độ chuyến xe</h2>
    <canvas id="myChart" width="400" height="200"></canvas>
        <h3>Tuyến: </h3>
        <c:forEach items="${route}" var="r">
        <h5>${r.id} : ${r.startLocation} - ${r.endLocation}</h5>
    </c:forEach>
</div>

<script>
    var routeIds = ${routeIds};
    var tripCounts = ${tripCounts};

    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: routeIds,
            datasets: [{
                    label: 'Số lượng chuyến xe',
                    data: tripCounts,
                    backgroundColor: 'rgba(13,110,253,0.4)',
                    borderColor: 'rgba(13,110,253,1)',
                    borderWidth: 2
                }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>