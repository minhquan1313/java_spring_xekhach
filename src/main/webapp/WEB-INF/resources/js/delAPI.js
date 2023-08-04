function delAPI(path) {
    fetch(path, {
        method: "delete"
    }).then(res => {
        if (res.status === 204)
            location.reload();
        else
            alert("Something wrong!!!");
    });
}

console.log("hello");
