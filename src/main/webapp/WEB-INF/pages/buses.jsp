<%-- Document : bus Created on : Aug 1, 2023, 3:32:29 PM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->
<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap"> <spring:message code="ui.global.back" /> </a>
        </div>

        <h3 class="text-center">
            <spring:message code="ui.bus.header_title" />
        </h3>

        <c:url value="/buses/add" var="createUrl" />
        <div class="d-flex justify-content-end" style="flex: 1">
            <a href="${createUrl}" class="btn btn-outline-info text-nowrap">
                <spring:message code="ui.global.add" />
            </a>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th scope="col">
                        <spring:message code="ui.global.id" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.global.image" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.bus.license_plate" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.bus.seat.count" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.global.action" />
                    </th>
                </tr>
            </thead>
            <tbody class="table-group-divider">
                <c:forEach items="${buses}" var="bus" varStatus="i">
                    <tr>
                        <th scope="row">${bus.id}</th>
                        <td style="width: 10rem">
                            <img src="${bus.image}" class="img-thumbnail rounded mx-auto d-block" alt="..." />
                        </td>
                        <td>${bus.licensePlate}</td>
                        <td>${bus.busSeatTemplateCount}</td>
                        <td>
                            <div class="btn-group float-end">
                                <c:url value="/buses/edit/${bus.id}" var="editUrl" />
                                <a href="${editUrl}" class="btn btn-primary">
                                    <spring:message code="ui.global.edit" />
                                </a>

                                <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
                                    <span class="visually-hidden"> </span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li>
                                        <c:url value="/buses/${bus.id}" var="detailUrl" />
                                        <a href="${detailUrl}" class="dropdown-item btn btn-primary">
                                            <spring:message code="ui.global.detail" />
                                        </a>
                                    </li>
                                    <li>
                                        <c:url value="/api/buses/${bus.id}" var="delUrl" />
                                        <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
                                        <button class="dropdown-item btn btn-danger" ${delClick}>
                                            <spring:message code="ui.global.delete" />
                                        </button>
                                    </li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</section>

<c:url value="/js/delAPI.js" var="delAPI" />
<script src="${delAPI}"></script>
