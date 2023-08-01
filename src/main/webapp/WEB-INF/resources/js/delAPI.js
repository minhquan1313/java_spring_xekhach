function delAPI(path) {
    fetch(path, {
        method: "delete",
    }).then((r) => {
        if (r.status === 204) {
            location.reload();
        } else {
            alert("Something wrong!!!");
        }
    });
}
