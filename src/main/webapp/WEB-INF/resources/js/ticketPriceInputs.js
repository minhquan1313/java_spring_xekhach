let globalSeatCount = 0;
setPriceOnInputs();
priceInputHandler();

$("#extraPrice, #basePrice").on("input", priceInputHandler);
function priceInputHandler() {
    const baseP = $("#basePrice").val() ?? "0";
    const extraP = $("#extraPrice").val() ?? "0";

    $("#paidPrice").val(
        globalSeatCount == 0 ? 0 : globalSeatCount * parseInt(baseP) + parseInt(extraP)
    );
}

$("#paidPrice").on("input", () => {
    const paidP = $("#paidPrice").val() ?? "0";
    const baseP = $("#basePrice").val() ?? "0";

    $("#extraPrice").val(parseInt(paidP) - parseInt(baseP));
});

function setPriceOnInputs() {
    const $initSelected = $("#tripId").find(":selected");

    $("#basePrice").val($initSelected.attr("data-basePrice"));
}
