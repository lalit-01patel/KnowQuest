<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="model.Question" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) { response.sendRedirect("login.html?err=Please+login"); return; }
  List<Question> searchResults = (List<Question>) request.getAttribute("searchResults");
  String searchQuery = (String) request.getAttribute("searchQuery");
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <title>Search Results for "<%= searchQuery %>" – KnowQuest</title>
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
        <form action="search" method="get" class="d-flex w-100">
          <input id="searchInput" class="form-control" name="query" value="<%= searchQuery %>" style="min-width:260px" placeholder="Search questions..."/>
        </form>
        <a href="${pageContext.request.contextPath}/profile.jsp" class="btn btn-profile">
          <%= user.getName() %>
        </a>
        <a href="logout" class="btn btn-danger">Logout</a>
      </div>
    </div>
  </header>

  <main class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h4 class="m-0">Search Results for "<%= searchQuery %>"</h4>
    </div>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
      <%
        if (searchResults == null || searchResults.isEmpty()) {
      %>
        <div class="col-12">
          <div class="alert alert-info">No questions found matching your search.</div>
        </div>
      <%
        } else {
          for (Question q : searchResults) {
      %>
        <div class="col">
          <a class="text-decoration-none text-reset" href="question?id=<%= q.getId() %>">
            <div class="card question-card h-100">
              <div class="card-body">
                <div class="d-flex justify-content-between">
                  <h5 class="card-title mb-1"><%= q.getTitle() %></h5>
                  <span class="badge text-bg-light"><%= q.getSubject() == null ? "General" : q.getSubject() %></span>
                </div>
                <p class="text-muted mb-1">by <%= q.getAskedByName() %></p>
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
</body>
</html>