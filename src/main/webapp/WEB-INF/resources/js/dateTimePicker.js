function dateTimePicker(datetimepickerId, inputNameBind) {
    const input = document.querySelector(`input[name=${inputNameBind}]`);

    const initDate = input.value ? new Date(input.value) : new Date();

    const userLocale =
        navigator.languages && navigator.languages.length
            ? navigator.languages[0]
            : navigator.language;

    const picker = new tempusDominus.TempusDominus(document.getElementById(datetimepickerId), {
        restrictions: {
            minDate: initDate,
        },
        display: {
            icons: {
                type: "icons",
                time: "bi bi-alarm",
                date: "bi bi-calendar",
                up: "bi bi-arrow-up-short",
                down: "bi bi-arrow-down-short",
                previous: "bi bi-arrow-left-short",
                next: "bi bi-arrow-right-short",
                today: "bi bi-calendar-check",
                clear: "bi bi-x",
                close: "bi bi-x-square",
            },
            sideBySide: true,
            calendarWeeks: false,
            viewMode: "calendar",
            toolbarPlacement: "bottom",
            keepOpen: false,
            buttons: {
                today: true,
                clear: false,
                close: true,
            },
            components: {
                calendar: true,
                date: true,
                month: true,
                year: true,
                decades: true,
                clock: true,
                hours: true,
                minutes: true,
                seconds: false,
                useTwentyfourHour: undefined,
            },
            inline: false,
            theme: "auto",
        },
        localization: {
            today: "Hôm nay",
            close: "Ẩn hộp thoại",
            selectMonth: "Chọn tháng",
            previousMonth: "Tháng trước",
            nextMonth: "Tháng sau",
            selectYear: "Chọn năm",
            previousYear: "Năm trước",
            nextYear: "Năm sau",
            selectDecade: "Chọn thập kỉ",
            previousDecade: "Thập kỉ trước",
            nextDecade: "Thập kỉ sau",
            previousCentury: "Thế kỉ trước",
            nextCentury: "Thế kỉ sau",
            pickHour: "Chọn giờ",
            incrementHour: "Tăng giờ",
            decrementHour: "Giảm giờ",
            pickMinute: "Chọn Minute",
            incrementMinute: "Tăng Minute",
            decrementMinute: "Giảm Minute",
            pickSecond: "Chọn Second",
            incrementSecond: "Tăng Second",
            decrementSecond: "Giảm Second",
            toggleMeridiem: "Chuyển đổi kinh tuyến",
            selectTime: "Chọn giờ",
            selectDate: "Chọn ngày",
            dayViewHeaderFormat: { month: "long", year: "2-digit" },
            locale: userLocale,
            startOfTheWeek: 1,
            hourCycle: "h24",
            dateFormats: {
                LTS: "h:mm:ss T",
                LT: "h:mm T",
                L: "dd/MM/yyyy",
                LL: "dd/MM/yyyy h:mm T",
                LLL: "d MMMM, yyyy h:mm T",
                LLLL: "dddd, d MMMM, yyyy h:mm T",
            },
            ordinal: (n) => n,
            format: "LL",
        },
    });

    picker.subscribe(tempusDominus.Namespace.events.change, (e) => {
        const { year, month, date, hours, minutes } = e.date;

        const newLocal = new Date(year, month, date, hours, minutes);

        input.value = newLocal;

        console.log(e);
        console.log(input.value);
        console.log({ year, month, date, hours, minutes, newLocal });
    });

    picker.dates.setValue(tempusDominus.DateTime.convert(initDate));
}
