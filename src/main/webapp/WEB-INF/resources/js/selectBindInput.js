function selectBindInput({ selectId, inputBindName }) {
    const select = document.querySelector(`#${selectId}`);
    const input = document.querySelector(`input[name=${inputBindName}]`);

    if (!input || !select) {
        console.error("No input or select");
        return;
    }

    select?.addEventListener("change", bindDataHandler);

    input.disabled = true;

    if (select.selectedOptions[0].value) {
    }

    function bindDataHandler() {
        const value = this.selectedOptions?.[0].value;
        console.log({ x: this, input, value });

        input.value = value;
        if (value != "") input.disabled = false;
    }
}
