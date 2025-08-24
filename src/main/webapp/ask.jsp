<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) { response.sendRedirect("login.html?err=Please+login"); return; }
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <title>Ask a Doubt – KnowQuest</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="css/home.css"/>
</head>
<body>
  <header class="header py-2">
    <div class="container d-flex align-items-center justify-content-between">
      <div class="d-flex align-items-center gap-2">
        <img src="https://dummyimage.com/40x40/000/fff.png&text=KQ" class="rounded"/>
        <span class="brand">KnowQuest</span>
      </div>
      <div class="d-flex align-items-center gap-3">
        <input id="searchInput" class="form-control" style="min-width:260px" placeholder="Search questions..."/>
        <a href="home" class="btn btn-home">Home</a>
        <a href="${pageContext.request.contextPath}/profile.jsp" class="btn btn-profile">
          <%= user.getName() %>
        </a>
        <a href="logout" class="btn btn-danger">Logout</a>
      </div>
    </div>
  </header>

  <main class="container py-4">
    <div class="card question-card">
      <div class="card-body">
        <h4 class="card-title mb-4">Ask a Doubt</h4>
        <form action="askQuestion" method="post">
          <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title" class="form-control" required/>
          </div>
          <div class="mb-3">
            <label class="form-label">Subject</label>
            <input type="text" name="subject" class="form-control" required/>
          </div>
          <div class="mb-3">
            <label class="form-label">Content</label>
            <textarea name="content" class="form-control" rows="5" required></textarea>
          </div>
          <button class="btn btn-primary">Post Question</button>
        </form>
      </div>
    </div>
  </main>
</body>
</html>