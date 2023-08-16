function delAPI(path) {
  const $btn = $(this);
  $btn.attr("disabled", "");

  fetch(path, {
    method: "delete",
  }).then((res) => {
    if (res.status === 204) {
      location.reload();
    } else {
      let msg = "Something wrong!!!";
      // switch (res.status) {
      //   case 405:
      //     msg = "You are not allowed!!!";
      //     break;
      // }
      $btn.attr("disabled", null);
      alert(msg);
    }
  });
}
