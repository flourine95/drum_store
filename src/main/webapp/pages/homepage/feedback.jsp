<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Feedback - NGXH MAI ĐĂA CHUN</title>
  <style>
    /* Reset CSS và font chung */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      line-height: 1.6;
      background-color: #f8f9fa;
      color: #333;
    }

    /* Header */
    header {
      background-color: #2c3e50;
      color: white;
      padding: 1rem 0;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .header-container {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 20px;
    }

    .logo {
      font-size: 1.8rem;
      font-weight: bold;
      color: #3498db;
    }

    nav ul {
      display: flex;
      list-style: none;
    }

    nav ul li {
      margin-left: 20px;
    }

    nav ul li a {
      color: white;
      text-decoration: none;
      font-weight: 500;
      transition: color 0.3s;
    }

    nav ul li a:hover {
      color: #3498db;
    }

    /* Phần nội dung chính */
    .main-container {
      max-width: 800px;
      margin: 30px auto;
      padding: 30px;
      background-color: white;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      border-radius: 8px;
    }

    h2 {
      color: #2c3e50;
      text-align: center;
      margin-bottom: 30px;
      padding-bottom: 15px;
      border-bottom: 1px solid #eee;
    }

    /* Form phản hồi */
    .feedback-form label {
      display: block;
      margin-bottom: 8px;
      font-weight: 600;
      color: #2c3e50;
    }

    .feedback-form input[type="text"],
    .feedback-form input[type="email"],
    .feedback-form textarea {
      width: 100%;
      padding: 12px;
      margin-bottom: 20px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 16px;
      transition: border 0.3s;
    }

    .feedback-form input:focus,
    .feedback-form textarea:focus {
      border-color: #3498db;
      outline: none;
    }

    .feedback-form textarea {
      min-height: 150px;
      resize: vertical;
    }

    .submit-btn {
      background-color: #3498db;
      color: white;
      border: none;
      padding: 12px 25px;
      font-size: 16px;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s;
      display: block;
      margin: 0 auto;
    }

    .submit-btn:hover {
      background-color: #2980b9;
    }

    /* Thông báo */
    .alert {
      padding: 15px;
      margin-top: 20px;
      border-radius: 4px;
      text-align: center;
    }

    .alert-success {
      background-color: #d4edda;
      color: #155724;
    }

    /* Footer */
    footer {
      background-color: #2c3e50;
      color: #ecf0f1;
      padding: 50px 0 20px;
    }

    .footer-container {
      max-width: 1200px;
      margin: 0 auto;
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 30px;
      padding: 0 20px;
    }

    .footer-column h3 {
      color: #3498db;
      margin-bottom: 20px;
      font-size: 1.2rem;
      position: relative;
      padding-bottom: 10px;
    }

    .footer-column h3::after {
      content: '';
      position: absolute;
      left: 0;
      bottom: 0;
      width: 50px;
      height: 2px;
      background-color: #3498db;
    }

    .footer-column ul {
      list-style: none;
    }

    .footer-column ul li {
      margin-bottom: 10px;
    }

    .footer-column ul li a {
      color: #ecf0f1;
      text-decoration: none;
      transition: color 0.3s;
    }

    .footer-column ul li a:hover {
      color: #3498db;
    }

    .search-box {
      display: flex;
      margin-top: 15px;
    }

    .search-box input {
      flex: 1;
      padding: 10px;
      border: none;
      border-radius: 4px 0 0 4px;
    }

    .search-box button {
      padding: 10px 15px;
      background-color: #3498db;
      color: white;
      border: none;
      border-radius: 0 4px 4px 0;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .search-box button:hover {
      background-color: #2980b9;
    }

    .copyright {
      text-align: center;
      padding-top: 30px;
      margin-top: 30px;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      font-size: 0.9rem;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .header-container {
        flex-direction: column;
        text-align: center;
      }

      nav ul {
        margin-top: 15px;
        justify-content: center;
      }

      nav ul li {
        margin: 0 10px;
      }

      .main-container {
        padding: 20px;
        margin: 20px;
      }
    }
  </style>
</head>
<body>
<!-- Header -->

<!-- Nội dung chính -->
<div class="main-container">
  <h2>GỬI ĐÁNH GIÁ SẢN PHẨM</h2>
  <form class="feedback-form" action="feedback" method="post">
    <label for="name">Họ và tên:</label>
    <input type="text" id="name" name="name" required>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>

    <label for="message">Nội dung phản hồi:</label>
    <textarea id="message" name="message" required></textarea>

    <button type="submit" class="submit-btn">GỬI PHẢN HỒI</button>
  </form>

  <% if (request.getAttribute("success") != null) { %>
  <div class="alert alert-success">
    <%= request.getAttribute("success") %>
  </div>
  <% } %>
</div>


</body>
</html>