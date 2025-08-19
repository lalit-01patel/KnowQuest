function showToastFromQuery() {
  const params = new URLSearchParams(location.search);
  const msg = params.get("msg");
  const err = params.get("err");
  if (msg) alert(msg);
  if (err) alert(err);
}
document.addEventListener("DOMContentLoaded", showToastFromQuery);