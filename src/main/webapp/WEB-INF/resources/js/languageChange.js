(() => {
    $("#languageSelect").on("change", function () {
        const $this = $(this);
        const $selected = $this.find(":selected");
        const v = $selected.val();

        if (v) {
            Cookies.set($selected.attr("data-cookie-name"), v, { path: "" });
            location.reload();
        }
    });
})();
