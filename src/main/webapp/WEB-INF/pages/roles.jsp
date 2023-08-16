<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--  -->
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!--  -->
<section class="container py-4">
  <div class="d-flex align-items-center mb-3">
    <div class="d-flex justify-content-start" style="flex: 1">
      <c:url value="/" var="backUrl" />
      <a href="${backUrl}" class="btn btn-outline-info text-nowrap">
        <spring:message code="ui.global.back" />
      </a>
    </div>

    <h3 class="text-center">
      <spring:message code="ui.role.header_title" />
    </h3>
    <div class="d-flex justify-content-end" style="flex: 1">
      <c:url value="/roles/add" var="createRole" />
      <a href="${createRole}" class="btn btn-outline-info text-nowrap">
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
            <spring:message code="ui.role.role_name" />
          </th>
          <th scope="col">
            <spring:message code="ui.role.role_display_name" />
          </th>
          <th scope="col">
            <spring:message code="ui.global.action" />
          </th>
        </tr>
      </thead>
      <tbody class="table-group-divider">
        <c:forEach items="${roles}" var="r">
          <tr>
            <th scope="row">${r.id}</th>
            <td>${r.title}</td>
            <td>${r.displayName}</td>
            <td>
              <div class="btn-group float-end">
                <c:url value="/roles/edit/${r.id}" var="editUrl" />
                <a href="${editUrl}" class="btn btn-primary">
                  <spring:message code="ui.global.edit" />
                </a>

                <c:url value="/api/admin/roles/${r.id}" var="delUrl" />
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
