function selectBindInput({ selectId, inputBindName }) {
    const select = document.querySelector(`#${selectId}`);
    const input = document.querySelector(`input[name=${inputBindName}]`);

    if (!input || !select) {
        console.error("No input or select");
        return;
    }

    select?.addEventListener("change", () => bindDataHandler(input));

    input.disabled = true;

    if (select.selectedOptions[0].value) {
        input.disabled = false;
    }

    function bindDataHandler(input) {
        const value = this.value;

        input.value = value;
    }
}
