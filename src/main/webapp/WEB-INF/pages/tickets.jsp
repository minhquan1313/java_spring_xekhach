<%-- Document : tickets Created on : Aug 3, 2023, 2:03:22 PM Author : Binh --%>
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

      <h3 class="text-center">Các vé xe hiện có</h3>
      <div class="d-flex justify-content-end" style="flex: 1">
        <c:url value="/tickets/add" var="createUrl" />
        <a href="${createUrl}" class="btn btn-outline-info text-nowrap">Thêm</a>
      </div>
    </div>
  </div>

  <table class="table table-hover">
    <thead>
      <tr>
        <th scope="col">id</th>
        <th scope="col">Mã chuyến</th>
        <th scope="col">Ngày đặt vé</th>
        <th scope="col">Số ghế đặt</th>
        <th scope="col">Điểm đi</th>
        <th scope="col">Điểm đến</th>
        <th scope="col">Giá</th>
        <th scope="col">Thanh toán với</th>
        <th scope="col">Đã thanh toán</th>
        <th scope="col">Xuất vé</th>
        <th scope="col">Xe</th>
      </tr>
    </thead>
    <tbody class="table-group-divider">
      <c:forEach items="${tickets}" var="item">
        <tr>
          <th scope="row">${item.id}</th>
          <th scope="row">
            <c:url value="/trips?id=${item.tripId.id}" var="tripFindIdUrl" />
            <a href="${tripFindIdUrl}" class="link-underline link-underline-opacity-0 text-primary-emphasis"> ${item.tripId.id}</a>
          </th>
          <td>
            <fmt:formatDate value="${item.createdAt}" pattern="${date_pattern}" />
          </td>
          <td>${item.totalSeat}</td>
          <td>${item.tripId.routeId.startLocation}</td>
          <td>${item.tripId.routeId.endLocation}</td>
          <td>
            <fmt:formatNumber type="number" maxFractionDigits="0" value="${item.paidPrice}" />
            VNĐ
          </td>
          <td>${item.paidWith}</td>
          <td>
            <c:set value="" var="checked" />
            <c:if test="${item.isPaid == true}">
              <c:set value="checked" var="checked" />
            </c:if>
            <input class="form-check-input" type="checkbox" disabled ${checked} />
          </td>
          <td>
            <c:url value="/users?id=${item.staffId.id}" var="userFind" />
            <a href="${userFind}" class="link-underline link-underline-opacity-0 text-primary-emphasis">${item.staffId} </a>
          </td>
          <td>
            <c:url value="/buses/${item.tripId.busId.id}" var="busDetail" />
            <a href="${busDetail}" class="link-underline link-underline-opacity-0 text-primary-emphasis"> ${item.tripId.busId.licensePlate}</a>
          </td>

          <td>
            <div class="btn-group float-end">
              <c:url value="/tickets/update/${item.id}" var="editUrl" />
              <a href="${editUrl}" class="btn btn-primary"> Sửa </a>

              <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
                <span class="visually-hidden"></span>
              </button>
              <ul class="dropdown-menu">
                <li>
                  <c:url value="/feedbacks/add?ticketId=${item.id}" var="feedBackUrl" />
                  <a href="${feedBackUrl}" class="dropdown-item btn btn-primary">Phản hồi</a>
                </li>
                <li>
                  <c:url value="/tickets/${item.id}" var="detailUrl" />
                  <a href="${detailUrl}" class="dropdown-item btn btn-primary"> Chi tiết </a>
                </li>
                <li>
                  <c:url value="/api/tickets/${item.id}" var="delUrl" />
                  <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
                  <button class="dropdown-item btn btn-danger" ${delClick}>Xoá</button>
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
