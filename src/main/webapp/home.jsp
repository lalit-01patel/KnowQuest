<%@ page import="java.util.List" %>
<%@ page import="model.Question" %>
<%@ page import="model.User" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) { response.sendRedirect("login.html?err=Please+login"); return; }
  List<Question> questions = (List<Question>) request.getAttribute("questions");
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <title>KnowQuest – Home</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="css/home.css"/>
</head>
<body>
  <!-- Navbar -->
  <header class="header py-2 shadow-sm bg-white">
    <div class="container d-flex align-items-center justify-content-between">
      <div class="d-flex align-items-center gap-2">
        <!-- Gradient KQ Logo -->
        <svg width="40" height="40" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
          <defs>
            <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" style="stop-color:#5e72e4;stop-opacity:1" />
              <stop offset="100%" style="stop-color:#ff8c00;stop-opacity:1" />
            </linearGradient>
          </defs>
          <rect width="100" height="100" rx="20" fill="url(#grad1)"/>
          <text x="50%" y="55%" dominant-baseline="middle" text-anchor="middle"
                font-size="50" font-family="Inter, sans-serif" fill="white" font-weight="bold">
            KQ
          </text>
        </svg>
        <span class="brand fw-bold fs-4">KnowQuest</span>
      </div>
      <div class="d-flex align-items-center gap-3">
        <form action="search" method="get" class="d-flex w-100">
          <input id="searchInput" class="form-control" name="query" style="min-width:260px" placeholder="Search questions..."/>
        </form>
        <a href="profile.jsp" class="btn btn-profile px-3">
          <%= user.getName() %>
        </a>
        <a href="logout" class="btn btn-danger px-3">Logout</a>
      </div>
    </div>
  </header>

  <!-- Main -->
  <main class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h4 class="m-0">All Questions</h4>
      <a href="ask.jsp" class="btn btn-primary rounded-pill px-3">Ask a doubt</a>
    </div>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
      <%
        if (questions == null || questions.isEmpty()) {
      %>
        <div class="col-12">
          <div class="alert alert-info">No questions available yet.</div>
        </div>
      <%
        } else {
          for (Question q : questions) {
      %>
        <div class="col">
          <a class="text-decoration-none text-reset" href="question?id=<%= q.getId() %>">
            <div class="card question-card h-100 shadow-sm border-0">
              <div class="card-body">
                <div class="d-flex justify-content-between">
                  <h5 class="card-title mb-1"><%= q.getTitle() %></h5>
                  <span class="badge bg-light text-dark"><%= q.getSubject() == null ? "General" : q.getSubject() %></span>
                </div>
                <p class="text-muted mb-1 small">by <%= q.getAskedByName() %></p>
                <p class="card-text"><%= q.getContent().length() > 160 ? q.getContent().substring(0,157)+"..." : q.getContent() %></p>
              </div>
            </div>
          </a>
        </div>
      <%
          }
        }
      %>
    </div>
  </main>

  <!-- Footer -->
  <footer class="footer mt-5 py-3 bg-light text-center border-top">
    <div class="container">
      <span class="text-muted">&copy; 2025 KnowQuest | Developed by Lalit Patel</span>
    </div>
  </footer>

  <!-- Scripts -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
