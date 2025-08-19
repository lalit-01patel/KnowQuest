<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User,dao.QuestionDAO,dao.AnswerDAO,model.Question,model.Answer"%>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) { response.sendRedirect("login.html?err=Please+login"); return; }
  QuestionDAO qdao = new QuestionDAO();
  AnswerDAO adao = new AnswerDAO();
%>
<!doctype html>
<html lang="en">
<head>
    <title>Profile – KnowQuest</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="css/home.css"/>
</head>
<body>
    <header class="header py-2">
      <div class="container d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center gap-2">
          <img src="https://dummyimage.com/40x40/000/fff.png&text=KQ" alt="logo" class="rounded"/>
          <span class="brand">KnowQuest</span>
        </div>
        <div class="d-flex align-items-center gap-3">
          <a href="home" class="btn btn-nav">Home</a>
          <a href="logout" class="btn btn-logout">Logout</a>
        </div>
      </div>
    </header>

    <main class="container py-4">
        <h2 class="mb-4">Profile</h2>

        <div class="card question-card mb-4">
            <div class="card-body d-flex align-items-center flex-column flex-md-row">
                <img src="https://dummyimage.com/100x100/5e72e4/ffffff.png&text=<%= user.getName().charAt(0) %>" alt="Profile Picture" class="rounded-circle mb-3 mb-md-0 me-md-4">
                <div class="text-center text-md-start">
                    <h4 class="card-title fw-bold mb-1"><%= user.getName() %></h4>
                    <p class="text-muted mb-0"><%= user.getEmail() %></p>
                    <p class="text-muted mb-0">Role: <%= user.getRole() %></p>
                </div>
            </div>
        </div>

        <div class="row row-cols-1 row-cols-md-4 g-4 mb-4">
            <div class="col">
                <div class="card question-card h-100 text-center">
                    <div class="card-body">
                        <h5 class="card-title text-muted">Questions Asked</h5>
                        <h2 class="display-5 fw-bold text-primary">0</h2>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card question-card h-100 text-center">
                    <div class="card-body">
                        <h5 class="card-title text-muted">Answers Given</h5>
                        <h2 class="display-5 fw-bold text-primary">0</h2>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card question-card h-100 text-center">
                    <div class="card-body">
                        <h5 class="card-title text-muted">Upvotes Received</h5>
                        <h2 class="display-5 fw-bold text-primary">0</h2>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card question-card h-100 text-center">
                    <div class="card-body">
                        <h5 class="card-title text-muted">Verified Answers</h5>
                        <h2 class="display-5 fw-bold text-primary">0</h2>
                    </div>
                </div>
            </div>
        </div>

        <div class="card question-card mb-4">
            <div class="card-body">
                <h5 class="card-title mb-3">My Questions</h5>
                <ul class="list-group list-group-flush">
                <% for (Question q : qdao.listAllByUser(user.getId())) { %>
                    <li class="list-group-item"><a href="question?id=<%=q.getId()%>" class="text-decoration-none text-dark"><%=q.getTitle()%></a></li>
                <% } %>
                </ul>
            </div>
        </div>

        <div class="card question-card">
            <div class="card-body">
                <h5 class="card-title mb-3">My Answers</h5>
                <ul class="list-group list-group-flush">
                <% for (Answer a : adao.listByUser(user.getId())) { %>
                    <li class="list-group-item">On <a href="question?id=<%=a.getQuestionId()%>" class="text-decoration-none text-primary"><%=a.getQuestionTitle()%></a>: <%=a.getContent()%></li>
                <% } %>
                </ul>
            </div>
        </div>
    </main>
</body>
</html>