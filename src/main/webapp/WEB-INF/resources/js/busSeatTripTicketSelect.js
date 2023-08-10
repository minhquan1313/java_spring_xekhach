(() => {
    const initSeatSelected = $("#selectedSeats").val();
    if (initSeatSelected != "") bindSeat(initSeatSelected);

    updateSeat();

    $("button[data-pos]:not(disabled)").on("click", function () {
        toggleBtn($(this));

        updateSeat();
    });
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    function toggleBtn($btn) {
        $btn.attr("active", (i, v) => (v == "" ? null : ""));
    }

    function updateSeat() {
        const $idAndPosArr = $("button[data-pos][active]").map((i, r) => {
            const $r = $(r);
            const id = $r.attr("data-id");
            const pos = $r.attr("data-pos");
            const disabled = $r.attr("disabled");
            const userChosen = $r.attr("userChosen");

            const x =
                id +
                "_" +
                pos +
                "_" +
                (disabled != undefined ? "true" : "false") +
                "_" +
                (userChosen != undefined ? "true" : "false");
            return x;
        });

        const idAndPosStr = $idAndPosArr.get().join(",");

        $("#selectedSeats").val(idAndPosStr);
        updateCount($idAndPosArr.length);
    }
    function bindSeat(initSeatSelected) {
        // 1_1_1,2_2_2
        const $x = $(initSeatSelected.split(","));

        console.log($x);

        // const pos = "1_1_1".substring("1_1_1".indexOf("_") + 1);
    }
    function updateCount(count) {
        $("#seatCount").html(count);
        embedPrice(count);
    }
    function embedPrice(count) {
        if (typeof globalSeatCount == "undefined" || typeof priceInputHandler == "undefined")
            return;

        globalSeatCount = count;
        priceInputHandler();
    }
})();
