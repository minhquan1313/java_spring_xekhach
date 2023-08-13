function inputBindInput({ inputId, inputBindName, cb }) {
    const input = document.querySelector(`#${inputId}`);
    const inputToBind = document.querySelector(`input[name=${inputBindName}]`);

    if (!input) {
        console.error("No input or select");
        return;
    }

    inputToBind && (inputToBind.disabled = true);
    bindDataHandler.call(input);

    input?.addEventListener("input", bindDataHandler);

    function bindDataHandler() {
        const _input = this;
        const value = _input.value;
        // console.log({ x: this, input, value });
        if (!cb) {
            if (!inputToBind) return;

            inputToBind.value = value;
            console.log({ value, inputToBind, _input, c: value != "" });
            if (value != "") inputToBind.disabled = false;
            else inputToBind.disabled = true;
        } else cb(_input, inputToBind);
    }
}
