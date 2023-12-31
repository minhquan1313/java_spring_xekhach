<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->

<nav class="navbar navbar-expand-lg border-bottom border-bottom-dark">
    <div class="container-fluid">
        <div class="navbar-brand">
            <spring:message code="${sideBarUIItem.title}" />
        </div>

        <c:choose>
            <c:when test="${authenticated_user != null}">
                <div class="ms-auto btn-group dropstart dropdown">
                    <div class="rounded-pill btn btn-dark d-flex border" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="bg-warning rounded-pill me-3 overflow-hidden" style="aspect-ratio: 1/1; width: 1.6rem">
                            <img class="object-fit-cover w-100 h-100 d-block" src="${authenticated_user.avatar}" alt="" />
                        </div>
                        <div>${authenticated_user}</div>
                    </div>
                    <ul class="dropdown-menu">
                        <li>
                            <c:url value="/users?kw=${authenticated_user.username}" var="detailUrl" />
                            <a href="${detailUrl}" class="dropdown-item">
                                <spring:message code="ui.header.user.detail" />
                            </a>
                        </li>
                        <li>
                            <c:url value="/logout" var="logout" />
                            <a class="dropdown-item" href="${logout}">
                                <spring:message code="ui.header.user.logout" />
                            </a>
                        </li>
                    </ul>
                </div>
            </c:when>
            <c:otherwise>
                <div class="ms-auto">
                    <c:url value="/login" var="login" />
                    <a href="${login}" class="rounded-pill btn btn-primary">
                        <spring:message code="ui.header.user.login" />
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Language -->
        <div class="ms-2" style="width: 5rem">
            <div class="input-group">
                <select id="languageSelect" class="form-select rounded-pill">
                    <c:forEach items="${allLanguages}" var="c">
                        <c:set value="" var="selected" />
                        <c:if test="${c == language}">
                            <c:set value="selected" var="selected" />
                        </c:if>

                        <option value="${c}" data-cookie-name="${LANG}" ${selected}>${c}</option>
                    </c:forEach>
                </select>
            </div>

            <c:url value="/js/languageChange.js" var="languageChange" />
            <script src="${languageChange}"></script>
        </div>
    </div>
</nav>
