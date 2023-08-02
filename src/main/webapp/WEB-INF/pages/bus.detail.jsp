<%-- Document : bus.detail.jsp Created on : Aug 2, 2023, 3:05:03 PM Author : Binh --%>
<!--  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  -->
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="container mt-4">
    <div class="row">
        <div class="col-12 col-md-6">
            <img src="${bus.image}" class="img-thumbnail rounded mx-auto d-block" alt="..." />
        </div>
        <div class="col-12 col-md-6">
            <div class="">
                <span>Id: </span>
                <span class="h6">${bus.id}</span>
            </div>
            <div class="">
                <span>Biển số xe: </span>
                <span class="h6">${bus.licensePlate}</span>
            </div>
            <div class="">
                <span>Tổng số chỗ ngồi: </span>
                <span class="h6">${seatCount}</span>
            </div>
            <div class="">
                <span>Chỗ ngồi trên xe: </span>
            </div>
            <section>
                <div
                    style="--col:${seats.col}; display: grid; grid-template-columns: repeat(var(--col), 3rem)"
                >
                    <c:forEach items="${seats.array}" var="seat" varStatus="i">
                        <c:choose>
                            <c:when test="${seat.available == true}">
                                <button
                                    data-pos="${seat.x}_${seat.y}"
                                    class="text-primary d-flex align-items-center justify-content-center"
                                    style="--x: ${seat.x}; --y: ${seat.y};"
                                >
                                    <h3 class="m-0" withoutActive><i class="bi bi-circle"></i></h3>
                                    <h3 class="m-0" withActive>
                                        <i class="bi bi-circle-fill"></i>
                                    </h3>
                                </button>
                            </c:when>

                            <c:otherwise>
                                <button
                                    data-pos="${seat.x}_${seat.y}"
                                    class="text-primary d-flex align-items-center justify-content-center"
                                    style="--x: ${seat.x}; --y: ${seat.y};"
                                    disabled
                                >
                                    <h3 class="m-0" withoutActive><i class="bi bi-circle"></i></h3>
                                    <h3 class="m-0" withActive>
                                        <i class="bi bi-circle-fill"></i>
                                    </h3>
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>

                <style>
                    button[data-pos] {
                        aspect-ratio: 1/1;
                        background-color: transparent;
                        border-color: transparent;
                        grid-column: var(--x);
                        grid-row: var(--y);
                    }
                    button[data-pos] *.bi {
                        font-size: 2rem;
                    }
                    button[data-pos]:disabled {
                        filter: grayscale(1);
                    }
                    button[data-pos][active] {
                        filter: hue-rotate(300deg);
                    }
                    button[data-pos] *[withActive] {
                        display: none;
                    }
                    button[data-pos] *[withoutActive] {
                        display: block;
                    }
                    button[data-pos][active] *[withActive] {
                        display: block;
                    }
                    button[data-pos][active] *[withoutActive] {
                        display: none;
                    }
                </style>
                <script>
                    let btnList = document.querySelectorAll("button[data-pos]");

                    btnList.forEach((r) =>
                        r.addEventListener("click", function (e) {
                            this.toggleAttribute("active");
                            // console.log("Click");
                        })
                    );

                    console.log({ btnList });
                </script>
            </section>
        </div>
    </div>
</div>
