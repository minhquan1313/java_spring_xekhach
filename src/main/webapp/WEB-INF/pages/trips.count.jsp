<%-- 
    Document   : trips.count
    Created on : Aug 6, 2023, 6:55:47 PM
    Author     : Duc Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>Thống kê số lượng trip theo route</h1>
<table>
    <tr>
        <th>Route ID</th>
        <th>Trip Count</th>
    </tr>
    <c:forEach items="${tripCounts}" var="tripCount">
        <tr>
            <td>${tripCount[0]}</td>
            <td>${tripCount[1]}</td>
        </tr>
    </c:forEach>
</table>