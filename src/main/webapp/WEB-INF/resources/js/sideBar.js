(() => {
    const $sidebar = $("#sidebar");
    const $btn = $("#sidebar_expand_btn");
    let isBtnClicked = false;

    $btn.on("click", function () {
        isBtnClicked = true;

        if ($sidebar.hasClass("active")) {
            collapse();
        } else {
            expand();
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
    function collapse() {
        $sidebar.removeClass("active");
        Cookies.set("sidebarExpanded", "false");
    }
    function expand() {
        $sidebar.addClass("active");
        Cookies.set("sidebarExpanded", "true");
    }

    $(window).on("resize", resizeHandler);
    function resizeHandler() {
        if (isBtnClicked) return;

        if (window.innerWidth < 1000) collapse();
        else expand();
    }
})();
