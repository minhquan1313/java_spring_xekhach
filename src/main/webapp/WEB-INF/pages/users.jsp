<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <c:choose>
                <c:when test="${not empty param.id or not empty param.kw or not empty param.roleId}">
                    <c:url value="/users" var="backUrl" />
                </c:when>
                <c:otherwise>
                    <c:url value="/" var="backUrl" />
                </c:otherwise>
            </c:choose>
            <c:url value="/" var="backUrl" />
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">
                <spring:message code="ui.global.back" />
            </a>
        </div>
        <h3 class="text-center">
            <spring:message code="ui.user.header_title" />
        </h3>
        <c:url value="/users/add" var="createUrl" />
        <div class="d-flex justify-content-end" style="flex: 1">
            <a href="${createUrl}" class="btn btn-outline-info text-nowrap">
                <spring:message code="ui.global.add" />
            </a>
        </div>
    </div>
    <c:url value="/users" var="action" />
    <div class="d-flex align-items-end">
        <form class="d-flex w-100" action="${action}">
            <div class="flex-grow-1 me-2"><input type="text" class="form-control w-100" name="kw" placeholder="<spring:message code="ui.user.type_keyword" />" value="${param.kw}"/></div>
            <div class="me-2">
                <select class="form-select" name="roleId">
                    <option value="">
                        <spring:message code="ui.user.role" />
                    </option>
                    <c:forEach items="${roles}" var="r">
                        <c:choose>
                            <c:when test="${r.id eq param.roleId}">
                                <option value="${r.id}" selected>${r.displayName}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${r.id}">${r.displayName}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </div>
            <button class="btn btn-primary mx-1" type="submit">
                <spring:message code="ui.global.find" />
            </button>
        </form>
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
                        <spring:message code="ui.user.last_name" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.user.first_name" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.user.username" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.user.password" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.user.role" />
                    </th>
                    <th scope="col">
                        <spring:message code="ui.global.action" />
                    </th>
                </tr>
            </thead>
            <tbody class="table-group-divider">
                <c:forEach items="${users}" var="u">
                    <tr>
                        <th scope="row">${u.id}</th>
                        <td>
                            <img src="${u.avatar}" alt="${u.username}" width="120" />
                        </td>
                        <td>${u.lastName}</td>
                        <td>${u.firstName}</td>
                        <td>${u.username}</td>
                        <td>${u.password}</td>
                        <td>${u.roleId.displayName}</td>
                        <td>
                            <div class="btn-group float-end">
                                <c:url value="/users/${u.id}" var="api" />
                                <a href="${api}" class="btn btn-primary">
                                    <spring:message code="ui.global.edit" />
                                </a>

                                <c:url value="/api/users/${u.id}" var="delUrl" />
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
