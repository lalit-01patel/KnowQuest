<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - KnowQuest</title>
    <link rel="stylesheet" href="css/main.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">
    <h2>📊 Admin Dashboard</h2>
    <hr>

    <div class="row text-center">
        <div class="col-md-4">
            <div class="card shadow-sm p-3">
                <h4>👤 Users</h4>
                <p class="fs-3"><%= request.getAttribute("userCount") %></p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm p-3">
                <h4>❓ Questions</h4>
                <p class="fs-3"><%= request.getAttribute("questionCount") %></p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm p-3">
                <h4>💡 Answers</h4>
                <p class="fs-3"><%= request.getAttribute("answerCount") %></p>
            </div>
        </div>
    </div>

    <div class="mt-4">
        <a href="home" class="btn btn-primary">⬅ Back to Home</a>
    </div>
</body>
</html>