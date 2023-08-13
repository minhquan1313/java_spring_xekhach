function selectBindInput({ selectId, inputBindName, cb }) {
    const select = document.querySelector(`#${selectId}`);
    const input = document.querySelector(`input[name=${inputBindName}]`);

    if (!select) {
        console.error("No input or select");
        return;
    }

    input && (input.disabled = true);
    bindDataHandler.call(select);

    select?.addEventListener("change", bindDataHandler);

    function bindDataHandler() {
        const selected = this.selectedOptions?.[0];
        const value = selected.value;
        // console.log({ x: this, input, value });
        if (!cb) {
            if (!input) return;
            input.value = value;
            if (value != "") input.disabled = false;
            else input.disabled = true;
        } else cb(selected, input);
    }
}
