(() => {
    const $sidebar = $("#sidebar");
    const $btn = $("#sidebar_expand_btn");

    $btn.on("click", function () {
        $sidebar.toggleClass("active");

        if ($sidebar.hasClass("active")) {
            Cookies.set("sidebarExpanded", "true");
        } else {
            Cookies.set("sidebarExpanded", "false");
        }
    });

    const $sidebarAppName = $("#sidebar_app_name");
    setWidth($sidebarAppName);
    setWidth($(".sidebar_li_item_text"));

    function setWidth($ele = $()) {
        $ele.each(function () {
            const $inner = $(this).find("span");
            const width = window.getComputedStyle($inner[0]).width;
            $(this).attr("style", `width: ${width}`);
        });
    }
})();
