let btnList = document.querySelectorAll("button[data-pos]");

btnList.forEach((r) =>
    r.addEventListener("click", function (e) {
        this.toggleAttribute("active");
    })
);

console.log({ btnList });
