staffIdSelectChangeHandler();

$("#staffId").on("change", staffIdSelectChangeHandler);

function staffIdSelectChangeHandler() {
    const $selected = $("#staffId").find(":selected");

    if ($selected.val()) {
        $("#isPaid").prop("checked", true);
    } else {
        $("#isPaid").prop("checked", false);
    }
}
