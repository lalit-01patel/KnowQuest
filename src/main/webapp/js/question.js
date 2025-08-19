document.addEventListener("DOMContentLoaded", () => {
    // Handle vote buttons with AJAX
    document.querySelectorAll(".vote-form").forEach(form => {
        form.addEventListener("submit", e => {
            e.preventDefault();
            fetch(form.action, {
                method: "POST",
                body: new FormData(form)
            })
            .then(() => location.reload()); // simple reload to update counts
        });
    });

    // Handle verify buttons with AJAX
    document.querySelectorAll(".verify-form").forEach(form => {
        form.addEventListener("submit", e => {
            e.preventDefault();
            fetch(form.action, {
                method: "POST",
                body: new FormData(form)
            })
            .then(() => location.reload()); // reload to show ✅
        });
    });
});