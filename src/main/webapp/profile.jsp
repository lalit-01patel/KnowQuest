<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User,dao.QuestionDAO,dao.AnswerDAO,model.Question,model.Answer"%>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) { response.sendRedirect("login.html?err=Please+login"); return; }

  QuestionDAO qdao = new QuestionDAO();
  AnswerDAO adao = new AnswerDAO();

  int questionCount = qdao.listAllByUser(user.getId()).size();
  java.util.List<Answer> answers = adao.listByUser(user.getId());
  int answerCount   = answers.size();

  int upvoteCount = 0;
  int downvoteCount = 0;
  int verifiedCount = 0;

  for (Answer a : answers) {
      upvoteCount += a.getUpvotes();
      downvoteCount += a.getDownvotes();
      if (a.isVerified()) {
          verifiedCount++;
      }
  }
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
    <!-- Header -->
    <header class="header py-2 shadow-sm bg-light">
      <div class="container d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center gap-2">
          <img src="https://dummyimage.com/40x40/000/fff.png&text=KQ" alt="logo" class="rounded"/>
          <span class="brand fw-bold fs-5">KnowQuest</span>
        </div>
        <div class="d-flex align-items-center gap-3">
          <a href="home" class="btn btn-home btn-sm">Home</a>
          <a href="logout" class="btn btn-danger btn-sm">Logout</a>
        </div>
      </div>
    </header>

    <!-- Profile Info -->
    <main class="container py-4">
        <h2 class="mb-4">Profile</h2>

        <div class="card shadow-sm mb-4">
            <div class="card-body d-flex align-items-center flex-column flex-md-row">
                <img src="https://dummyimage.com/100x100/5e72e4/ffffff.png&text=<%= String.valueOf(user.getName().charAt(0)) %>"
                     alt="Profile Picture" class="rounded-circle mb-3 mb-md-0 me-md-4">
                <div class="text-center text-md-start">
                    <h4 class="card-title fw-bold mb-1"><%= user.getName() %></h4>
                    <p class="text-muted mb-0"><%= user.getEmail() %></p>
                    <p class="text-muted mb-0">Role: <%= user.getRole() %></p>
                </div>
            </div>
        </div>

        <!-- Stats -->
        <div class="row row-cols-1 row-cols-md-5 g-4 mb-4">
            <div class="col">
                <div class="card text-center shadow-sm">
                    <div class="card-body">
                        <h6 class="text-muted">Questions Asked</h6>
                        <h2 class="fw-bold text-primary"><%=questionCount%></h2>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card text-center shadow-sm">
                    <div class="card-body">
                        <h6 class="text-muted">Answers Given</h6>
                        <h2 class="fw-bold text-primary"><%=answerCount%></h2>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card text-center shadow-sm">
                    <div class="card-body">
                        <h6 class="text-muted">Upvotes</h6>
                        <h2 class="fw-bold text-success"><%=upvoteCount%></h2>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card text-center shadow-sm">
                    <div class="card-body">
                        <h6 class="text-muted">Downvotes</h6>
                        <h2 class="fw-bold text-danger"><%=downvoteCount%></h2>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card text-center shadow-sm">
                    <div class="card-body">
                        <h6 class="text-muted">Verified Answers</h6>
                        <h2 class="fw-bold text-primary"><%=verifiedCount%></h2>
                    </div>
                </div>
            </div>
        </div>

        <!-- Questions -->
        <div class="card shadow-sm mb-4">
          <div class="card-body">
            <h5 class="card-title mb-3">My Questions</h5>
            <div class="row row-cols-1 g-3">
              <% for (Question q : qdao.listAllByUser(user.getId())) { %>
                <div class="col">
                  <div class="card border shadow-sm h-100">
                    <div class="card-body">
                      <a href="question?id=<%=q.getId()%>" class="fw-bold text-decoration-none text-dark">
                        <%=q.getTitle()%>
                      </a>
                    </div>
                  </div>
                </div>
              <% } %>
            </div>
          </div>
        </div>

        <!-- Answers -->
        <div class="card shadow-sm">
          <div class="card-body">
            <h5 class="card-title mb-3">My Answers</h5>
            <div class="row row-cols-1 g-3">
              <% for (Answer a : answers) { %>
                <div class="col">
                  <div class="card border shadow-sm h-100">
                    <div class="card-body">
                      <p class="mb-2">
                        On <a href="question?id=<%=a.getQuestionId()%>"
                              class="fw-bold text-primary text-decoration-none">
                              <%=a.getQuestionTitle()%>
                        </a>
                      </p>
                      <p class="mb-2"><%=a.getContent()%></p>
                      <small class="text-muted">
                        👍 <%=a.getUpvotes()%> | 👎 <%=a.getDownvotes()%> |
                        ✅ <%=a.isVerified() ? "Verified" : "Not Verified" %>
                      </small>
                    </div>
                  </div>
                </div>
              <% } %>
            </div>
          </div>
        </div>

    </main>

    <!-- Footer -->
    <footer class="bg-light text-center py-3 mt-4 border-top">
        <p class="mb-0">&copy; 2025 KnowQuest. All Rights Reserved.</p>
    </footer>
</body>
</html>
