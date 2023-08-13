<%-- Document : trips Created on : Aug 3, 2023, 2:03:22 PM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--  -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--  -->
<section class="container-xxl my-4">
  <div class="container">
    <div class="d-flex align-items-center mb-3">
      <div class="d-flex justify-content-start" style="flex: 1">
        <c:url value="/" var="backUrl" />
        <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
      </div>

      <h3 class="text-center">Các chuyến xe hiện có</h3>
      <div class="d-flex justify-content-end flex-wrap" style="flex: 1">
        <div class="btn-group">
          <c:url value="/trips/add" var="createUrl" />
          <a href="${createUrl}" class="btn btn-outline-info text-nowrap">Thêm</a>

          <button type="button" class="btn btn-outline-info dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
            <span class="visually-hidden"></span>
          </button>
          <ul class="dropdown-menu">
            <li>
              <c:url value="/trips/find" var="findUrl" />
              <a href="${findUrl}" class="dropdown-item"> Tìm kiếm </a>
            </li>
            <li>
              <c:url value="/trips/chart" var="chartUrl" />
              <a href="${chartUrl}" class="dropdown-item"> Chart </a>
            </li>
            <li>
              <c:url value="/api/tickets/${item.id}" var="delUrl" />
              <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
              <button class="dropdown-item btn btn-danger" ${delClick}>Xoá</button>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>

  <table class="table table-hover">
    <thead>
      <tr>
        <th scope="col">id</th>
        <th scope="col">Khởi hành</th>
        <th scope="col">Điểm đi</th>
        <th scope="col">Điểm đến</th>
        <th scope="col">Tên tài xế</th>
        <th scope="col">Xe</th>
        <th scope="col">Giá</th>
      </tr>
    </thead>
    <tbody class="table-group-divider">
      <c:forEach items="${trips}" var="item">
        <tr>
          <th scope="row">${item.id}</th>
          <td>
            <fmt:formatDate value="${item.startAt}" pattern="${date_pattern}" />
          </td>
          <td>${item.routeId.startLocation}</td>
          <td>${item.routeId.endLocation}</td>
          <td>${item.driverId}</td>
          <td>
            <c:url value="/buses/${item.busId.id}" var="busDetail" />
            <a href="${busDetail}" class="link-underline link-underline-opacity-0 text-primary-emphasis"> ${item.busId.licensePlate}</a>
          </td>
          <td>
            <fmt:formatNumber type="number" maxFractionDigits="0" value="${item.price}" />
            VNĐ
          </td>
          <!-- here here here  -->
          <td>
            <div class="btn-group float-end">
              <c:url value="/trips/edit/${item.id}" var="editUrl" />
              <a href="${editUrl}" class="btn btn-primary"> Sửa </a>

              <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
                <span class="visually-hidden"></span>
              </button>
              <ul class="dropdown-menu">
                <li>
                  <c:url value="/tickets/add" var="ticketUrl">
                    <c:param name="tripId" value="${item.id}" />
                  </c:url>
                  <a href="${ticketUrl}" class="dropdown-item"> Đặt vé </a>
                </li>
                <li>
                  <c:url value="/feedbacks" var="feedbackUrl">
                    <c:param name="tripId" value="${item.id}" />
                  </c:url>
                  <a href="${feedbackUrl}" class="dropdown-item"> Phản hồi </a>
                </li>
                <li>
                  <c:url value="/api/trips/${item.id}" var="delUrl" />
                  <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
                  <button class="dropdown-item" ${delClick}>Xoá</button>
                </li>
              </ul>
            </div>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</section>

<c:url value="/js/delAPI.js" var="delAPI" />
<script src="${delAPI}"></script>
