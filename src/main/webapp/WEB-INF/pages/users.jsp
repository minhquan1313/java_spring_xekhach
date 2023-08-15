<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!--  -->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
            <a href="${backUrl}" class="btn btn-outline-info text-nowrap">Quay lại</a>
        </div>
        <h3 class="text-center">Users</h3>
        <c:url value="/users/add" var="createUrl" />
        <div class="d-flex justify-content-end" style="flex: 1">
            <a href="${createUrl}" class="btn btn-outline-info text-nowrap">Thêm</a>
        </div>
    </div>
    <c:url value="/users" var="action" />
    <div class="d-flex align-items-end">
        <form class="d-flex w-100" action="${action}">
            <div class="flex-grow-1 me-2">
                <input type="text" class="form-control w-100" name="kw" placeholder="Nhập từ khóa" value="${param.kw}" />
            </div>
            <div class="me-2">
                <select class="form-select" name="roleId">
                    <option value="">Vai trò</option>
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
            <button class="btn btn-primary mx-1" type="submit">Tìm</button>
        </form>
    </div>

    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th scope="col">id</th>
                    <th scope="col">Avatar</th>
                    <th scope="col">Họ</th>
                    <th scope="col">Tên</th>
                    <th scope="col">Tài khoản</th>
                    <th scope="col">Mật khẩu</th>
                    <th scope="col">Vai trò</th>
                    <th scope="col">Hành động</th>
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
                                <a href="${api}" class="btn btn-primary">Sửa</a>

                                <c:url value="/api/users/${u.id}" var="delUrl" />
                                <c:set value="onclick=(delAPI('${delUrl}'))" var="delClick" />
                                <button class="btn btn-danger" ${delClick}>Xoá</button>
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
