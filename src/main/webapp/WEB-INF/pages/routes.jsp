<%-- Document : routes Created on : Aug 1, 2023, 10:12:59 AM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->
<section class="container my-4">
    <div class="d-flex align-items-center mb-3">
        <div class="d-flex justify-content-start" style="flex: 1">
            <c:url value="/" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">
                <spring:message code="ui.global.back" />
            </a>
        </div>

        <h3 class="text-center">
            <spring:message code="ui.route.header_title" />
        </h3>
        <div class="d-flex justify-content-end" style="flex: 1">
            <c:url value="/routes/add" var="createUrl" />
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
                        <spring:message code="ui.route.start_location" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.route.end_location" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.global.action" />
                    </th>
                </tr>
            </thead>
            <tbody class="table-group-divider">
                <c:forEach items="${routes}" var="route">
                    <tr>
                        <th scope="row">${route.id}</th>
                        <td>${route.startLocation}</td>
                        <td>${route.endLocation}</td>
                        <td>
                            <div class="btn-group float-end">
                                <c:url value="/routes/edit/${route.id}" var="editUrl" />
                                <a href="${editUrl}" class="btn btn-primary">
                                    <spring:message code="ui.global.edit" />
                                </a>

                                <c:url value="/api/routes/${route.id}" var="delUrl" />
                                <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
                                <button class="btn btn-danger" ${delClick}>
                                    <spring:message code="ui.global.delete" />
                                </button>
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
