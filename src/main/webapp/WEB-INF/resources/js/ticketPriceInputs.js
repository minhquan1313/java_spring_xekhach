let globalSeatCount = 0;
let extraPrice = 0;
let basePrice = 0;
let paidPrice = 0;
setPriceOnInputs();
priceInputHandler();

$("#extraPrice").on("input", priceInputHandler);
function priceInputHandler() {
    let extraP = $("#extraPrice").val() ?? "0";
    extraP = extraP.replace(/\,/g, "");

    extraPrice = extraP == "" ? 0 : parseInt(extraP);

    paidPrice = globalSeatCount == 0 ? 0 : globalSeatCount * basePrice + extraPrice;

    $("#paidPrice").val(paidPrice);
    $("#extraPrice").val(extraPrice.toLocaleString());
}

$("#paidPrice").on("input", () => {
    extraPrice = paidPrice - basePrice;

    $("#extraPrice").val(extraPrice.toLocaleString());
});

function setPriceOnInputs() {
    const $initSelected = $("#tripId").find(":selected");
    basePrice = parseInt($initSelected.attr("data-basePrice"));

    $("#basePrice").val(basePrice.toLocaleString());
}
