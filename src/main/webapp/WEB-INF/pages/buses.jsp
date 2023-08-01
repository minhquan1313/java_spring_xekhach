<%-- Document : bus Created on : Aug 1, 2023, 3:32:29 PM Author : Binh --%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<section class="container mt-4">
    <div class="d-flex align-items-center">
        <a href="#" class="invisible">Thêm xe</a>

        <h3 class="text-center w-100">Các xe hiện có</h3>

        <c:url value="/buses/add" var="createUrl" />
        <a href="${createUrl}" class="btn btn-primary text-nowrap">Thêm xe</a>
    </div>

    <table class="table table-hover">
        <thead>
            <tr>
                <th scope="col">id</th>
                <th scope="col">Hình ảnh</th>
                <th scope="col">Biển số</th>
                <th scope="col">Cho ngoi</th>
                <th scope="col">Hành động</th>
                <th scope="col"></th>
            </tr>
        </thead>
        <tbody class="table-group-divider">
            <c:forEach items="${buses}" var="bus" varStatus="i">
                <tr>
                    <th scope="row">${bus.id}</th>
                    <td class="w-25">
                        <img
                            src="${bus.image}"
                            class="img-thumbnail rounded mx-auto d-block"
                            alt="..."
                        />
                    </td>
                    <td>${bus.licensePlate}</td>
                    <td>${count[i.index]}</td>
                    <td>
                        <c:url value="/buses/edit/${bus.id}" var="editUrl" />
                        <a href="${editUrl}" class="btn btn-primary">Sửa</a>

                        <c:url value="/api/buses/${bus.id}" var="delUrl" />
                        <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
                        <button class="btn btn-primary" ${delClick}>Xoá</button>
                    </td>
                    <td>
                        <c:forEach items="${bus.busSeatTemplateSet}" var="seatTemplate">
                            <div class="">${seatTemplate.busSeat}</div>
                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</section>

<c:url value="/js/delAPI.js" var="delAPI" />
<script src="${delAPI}"></script>
