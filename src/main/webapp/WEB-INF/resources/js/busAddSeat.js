let seatArrayContainer = document.getElementById("seatArrayContainer");
let seatSelect = document.getElementById("seatSelect");
let seatCount = document.getElementById("seatCount");
let selectedSeats = document.getElementById("selectedSeats");

renewArray(...getSize(seatSelect));
setClickBtn();

seatSelect.addEventListener("change", function () {
    let [x, y] = getSize(seatSelect);
    renewArray(x, y);
    setClickBtn();
});

function getSize(select) {
    let [x, y] = select.value.split("x").map((r) => parseInt(r.trim()));
    return [x, y];
}

function renewArray(col, row) {
    selectedSeats.value = "";
    seatArrayContainer.style.cssText = `--row: ${row};--col: ${col}`;
    seatArrayContainer.innerHTML = ``;
    for (let r = 1; r <= row; r++) {
        for (let c = 1; c <= col; c++) {
            let xml = `
                <button
                    type="button"
                    data-pos="${c}_${r}"
                    class="text-primary d-flex align-items-center justify-content-center"
                >
                    <h3 class="m-0" withoutActive>
                        <i class="bi bi-circle"></i>
                    </h3>
                    <h3 class="m-0" withActive>
                        <i class="bi bi-circle-fill"></i>
                    </h3>
                </button>
                `;

            seatArrayContainer.innerHTML += xml;
        }
    }
}

function setClickBtn() {
    let btnList = document.querySelectorAll("button[data-pos]");
    btnList.forEach((r) => {
        r.onclick = function () {
            this.toggleAttribute("active");

            seatCount.innerText = countSeat();
            updateInputSelected();
        };
    });
    seatCount.innerText = countSeat();
    console.log({ btnList });
}

function updateInputSelected() {
    let btns = getSelectedSeat();
    selectedSeats.value = btns
        .map((r) => {
            return r.getAttribute("data-pos");
        })
        .join(",");

    console.log(selectedSeats.value);
}

function getSelectedSeat() {
    return [...document.querySelectorAll("button[data-pos][active]")];
}

function countSeat() {
    return getSelectedSeat().length;
}
