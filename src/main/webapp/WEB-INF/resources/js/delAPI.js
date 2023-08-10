function delAPI(path) {
    const $btn = $(this);
    $btn.attr("disabled", "");

    fetch(path, {
        method: "delete",
    }).then((res) => {
        if (res.status === 204) {
            location.reload();
        } else {
            $btn.attr("disabled", null);
            alert("Something wrong!!!");
        }
    });
}

console.log("hello");
