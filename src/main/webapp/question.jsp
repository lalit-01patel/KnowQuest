<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,model.*,dao.*" %>
<%
    int qid = Integer.parseInt(request.getParameter("id"));
    QuestionDAO qdao = new QuestionDAO();
    Question q = qdao.findById(qid);

    AnswerDAO adao = new AnswerDAO();
    List<Answer> answers = adao.listByQuestionId(qid);

    User user = (User) session.getAttribute("user");
%>
<!doctype html>
<html lang="en">
<head>
    <title><%= q.getTitle() %> – KnowQuest</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Custom -->
    <link rel="stylesheet" href="css/home.css"/>
    <link rel="stylesheet" href="css/toast.css"/>
</head>
<body>
    <!-- Header -->
    <header class="header py-2 shadow-sm">
      <div class="container d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center gap-2">
          <!-- Gradient SVG Logo -->
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
          <span class="brand fw-bold fs-5">KnowQuest</span>
        </div>
        <div class="d-flex align-items-center gap-3">
          <a href="home" class="btn btn-home">Home</a>
          <a href="${pageContext.request.contextPath}/profile.jsp" class="btn btn-profile">
            <%= user.getName() %>
          </a>
          <a href="logout" class="btn btn-danger">Logout</a>
        </div>
      </div>
    </header>

    <!-- Main -->
    <main class="container py-4">
        <div class="row">
            <!-- Question card -->
            <div class="col-md-12 mb-4">
                <div class="card shadow-sm border-0 question-card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start">
                            <h3 class="card-title mb-2 fw-semibold"><%= q.getTitle() %></h3>
                            <span class="badge rounded-pill bg-gradient">
                              <%= q.getSubject() == null ? "General" : q.getSubject() %>
                            </span>
                        </div>
                        <p class="text-muted mb-2">Asked by <strong><%= q.getAskedByName() %></strong></p>
                        <p class="card-text"><%= q.getContent() %></p>

                        <!-- PDF + QR buttons -->
                        <div class="mt-3 d-flex gap-2">
                            <a href="exportPdf?id=<%= qid %>" class="btn btn-danger">📄 PDF</a>
                            <a href="qr?id=<%= qid %>" class="btn btn-dark" target="_blank">🔳 QR</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Answers -->
            <div class="col-md-12">
                <h4 class="mb-3 fw-semibold">Answers</h4>
                <% if (answers == null || answers.isEmpty()) { %>
                    <div class="alert alert-info shadow-sm">No answers found for this question.</div>
                <% } else {
                    for (Answer a : answers) { %>
                    <div class="card shadow-sm border-0 answer-card mb-3">
                        <div class="card-body">
                            <p class="card-text"><%= a.getContent() %></p>
                            <p class="text-muted small mb-2">By <strong><%= a.getAnsweredByName() %></strong> at <%= a.getCreatedAt() %></p>
                            <div class="d-flex align-items-center gap-3">
                                <p class="m-0">
                                    <span class="text-success fw-bold">👍 <%= a.getUpvotes()%></span>
                                    <span class="text-danger fw-bold">👎 <%= a.getDownvotes()%></span>
                                </p>
                                <% if (a.isVerified()) { %>
                                    <span class="badge bg-success">✅ Verified</span>
                                <% } %>
                            </div>

                            <!-- Vote + Verify -->
                            <div class="mt-3 d-flex gap-2">
                                <form action="vote" method="post" class="d-flex gap-2">
                                    <input type="hidden" name="answerId" value="<%= a.getId() %>">
                                    <input type="hidden" name="questionId" value="<%= qid %>">
                                    <button type="submit" name="type" value="up" class="btn btn-sm btn-outline-success">Upvote</button>
                                    <button type="submit" name="type" value="down" class="btn btn-sm btn-outline-danger">Downvote</button>
                                </form>

                                <% if (user != null && "TEACHER".equalsIgnoreCase(user.getRole())) { %>
                                    <form action="verifyAnswer" method="post">
                                        <input type="hidden" name="answerId" value="<%= a.getId() %>">
                                        <input type="hidden" name="questionId" value="<%= qid %>">
                                        <button type="submit" class="btn btn-sm btn-primary">Mark Verified</button>
                                    </form>
                                <% } %>
                            </div>
                        </div>
                    </div>
                <% }
                } %>
            </div>

            <!-- Add Answer -->
            <div class="col-md-12 mt-4">
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <h4 class="card-title mb-3">Add Your Answer</h4>
                        <form action="answer" method="post">
                            <input type="hidden" name="questionId" value="<%= qid %>">
                            <div class="mb-3">
                                <textarea name="content" class="form-control" rows="5" required placeholder="Write your answer..."></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Submit Answer</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer mt-5 py-3 bg-light text-center border-top">
      <div class="container">
        <span class="text-muted">&copy; 2025 KnowQuest | Developed by Lalit Patel</span>
      </div>
    </footer>

    <!-- Toast -->
    <div id="toastContainer"></div>

    <!-- JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/question.js" defer></script>
    <script src="js/toast.js"></script>
    <script>
      <% if (request.getParameter("msg") != null) { %>
          showToast("<%= request.getParameter("msg") %>", "success");
      <% } %>
    </script>
</body>
</html>
