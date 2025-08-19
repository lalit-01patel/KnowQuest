document.querySelectorAll('form[action="vote"]').forEach(form => {
    form.addEventListener('submit', function(e) {
        e.preventDefault(); // Prevent default form submission

        const formData = new FormData(this);
        const answerId = this.dataset.answerId;

        fetch('vote', {
            method: 'POST',
            body: formData
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json(); // Parse the JSON response
        })
        .then(data => {
            // Update the vote counts on the page
            const upvoteSpan = document.querySelector(`.card-body [data-vote-count="up"]`);
            const downvoteSpan = document.querySelector(`.card-body [data-vote-count="down"]`);

            if (upvoteSpan && downvoteSpan) {
                upvoteSpan.textContent = data.upvotes;
                downvoteSpan.textContent = data.downvotes;
            }
        })
        .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
            alert('Failed to submit vote. Please try again.');
        });
    });
});