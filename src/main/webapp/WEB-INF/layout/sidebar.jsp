<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--  -->
<c:url value="/css/sideBar.css" var="sideBar" />
<link rel="stylesheet" href="${sideBar}" />

<c:set value="" var="active" />
<c:if test="${sidebarExpanded == true}">
    <c:set value="active" var="active" />
</c:if>
<div id="sidebar" class="border-end d-flex flex-column pb-3 ${active}">
    <div class="d-flex">
        <c:url value="/" var="home" />
        <a href="${home}" class="link-light d-flex py-3 mx-auto align-items-center justify-content-center link-underline link-underline-opacity-0">
            <i class="bi bi-bus-front fs-3"></i>

            <span id="sidebar_app_name" class="fs-3 ms-4 text-nowrap">
                <span class="d-inline-block"> ${app_name} </span>
            </span>
        </a>
    </div>

    <div class="my-3 overflow-y-auto overflow-x-hidden" style="flex: 1">
        <div class="list-group list-group-flush">
            <!-- Get current url in the url bar -->
            <c:set value="${requestScope['javax.servlet.forward.request_uri']}" var="currentUrl" />
            <c:set value="${null}" scope="application" var="sideBarUIItem" />
            <!-- Get selected route -->
            <c:forEach items="${sideBarUI}" var="c">
                <c:url value="${c.url}" var="url" />

                <c:if test="${fn:containsIgnoreCase(currentUrl, url)}">
                    <c:set value="${c}" scope="application" var="sideBarUIItem" />
                </c:if>
            </c:forEach>

            <!-- Render list with selected role added -->
            <c:forEach items="${sideBarUI}" var="c">
                <c:url value="${c.url}" var="url" />
                <c:set value="" var="active" />

                <c:if test="${sideBarUIItem.url == c.url}">
                    <c:set value="active" var="active" />
                </c:if>

                <a href="${url}" type="button" class="d-flex align-items-center list-group-item list-group-item-action ${active}">
                    <i class="${c.icon}"></i>
                    <span class="sidebar_li_item_text ms-3 d-inline-block text-nowrap">
                        <span class="d-inline-block">${c.title}</span>
                    </span>
                </a>
            </c:forEach>
        </div>
    </div>

    <div class="d-flex justify-content-end mx-2">
        <button type="button" class="btn" id="sidebar_expand_btn">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-bar-left" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M12.5 15a.5.5 0 0 1-.5-.5v-13a.5.5 0 0 1 1 0v13a.5.5 0 0 1-.5.5ZM10 8a.5.5 0 0 1-.5.5H3.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L3.707 7.5H9.5a.5.5 0 0 1 .5.5Z"></path>
            </svg>
        </button>
    </div>
</div>

<c:url value="/js/sideBar.js" var="sideBar" />
<script src="${sideBar}"></script>
