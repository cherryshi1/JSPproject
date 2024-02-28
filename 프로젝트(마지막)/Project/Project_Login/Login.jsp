<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="dao.MemberDAO" %>
<%@ page import="dto.MemberDTO" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
    }
    .container {
        max-width: 400px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        text-align: center;
        margin-bottom: 20px;
    }
    label {
        display: block;
        margin-bottom: 5px;
    }
    input[type="text"],
    input[type="password"],
    input[type="submit"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    input[type="submit"] {
        background-color: #007bff;
        color: #fff;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #0056b3;
    }
    .links {
        text-align: center;
        margin-top: 20px;
    }
    .links a {
        color: #007bff;
        text-decoration: none;
    }
    .links a:hover {
        text-decoration: underline;
    }
    
    
</style>

</head>

<body>


<jsp:include page="../Link/Link_Login.jsp"/>

<div>
    <h2>Login</h2>
    <form action="LoginProcess.jsp" method="post">
        <div >
            <label for="id">ID:</label>
            <input type="text" id="id" name="id" required><br>
            <% if (request.getAttribute("error") != null)  { %>
    <div style="color: red;"><%= request.getAttribute("error") %></div>
<% } %>
        </div><br>
        <div >
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div >
            <input type="submit" value="Login">
        </div>
    </form>
</div>

<!-- 아이디 및 비밀번호 찾기 버튼 -->
<div style="margin-top: 20px;">
<input type="button" value="아이디 찾기" onclick="location.href='FindID.jsp';">
<input type="button" value="비밀번호 찾기" onclick="location.href='FindID.jsp';">
  
</div>
<br><br>
<input type="button" value="홈페이지로 돌아가기" onclick="location.href='../ListMainForm.jsp';">



</body>

</html>
