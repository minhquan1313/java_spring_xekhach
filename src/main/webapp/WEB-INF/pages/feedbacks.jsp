<%-- Document : feedback Created on : Aug 11, 2023, 1:52:07 AM Author : Duc Hung --%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
            <spring:message code="ui.feedback.header_title" />
        </h3>
        <div class="invisible" style="flex: 1"></div>
    </div>

    <div class="table-responsive">
        <c:url value="/feedbacks" var="action" />
        <table class="table table-hover">
            <thead>
                <tr>
                    <th scope="col">
                        <spring:message code="ui.global.id" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.ticket.id" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.feedback.comment" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.route" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.feedback.user" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.global.action" />
                    </th>
                </tr>
            </thead>
            <tbody class="table-group-divider">
                <c:forEach items="${feedbacks}" var="f">
                    <tr>
                        <th scope="row">${f.id}</th>
                        <th>
                            <c:url value="/tickets?id=${f.ticketId.id}" var="ticketFindUrl" />
                            <a href="${ticketFindUrl}" class="link-underline link-underline-opacity-0 text-primary-emphasis"> ${f.ticketId.id} </a>
                        </th>
                        <td>${f.comment}</td>
                        <td>${f.ticketId.tripId.routeId.startLocation} - ${f.ticketId.tripId.routeId.endLocation}</td>
                        <td>${f.ticketId.userId}</td>
                        <td>
                            <div class="btn-group float-end">
                                <c:url value="/feedbacks/edit?feedbackId=${f.id}&tripId=${f.ticketId.tripId.id}" var="update" />
                                <a href="${update}" class="btn btn-primary">
                                    <spring:message code="ui.global.update" />
                                </a>

                                <c:url value="/api/feedbacks/${f.id}" var="delUrl" />
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
