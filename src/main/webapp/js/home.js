document.addEventListener("DOMContentLoaded", () => {
  const search = document.getElementById("searchInput");
  if (!search) return;
  search.addEventListener("keypress", (e) => {
    if (e.key === "Enter") {
      const q = search.value.trim();
      const url = new URL(location.href);
      url.searchParams.set("q", q);
      location.href = url.toString();
    }
  });
});