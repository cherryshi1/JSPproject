<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find ID / Password</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 400px;
        margin: 20px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        text-align: center;
        margin-bottom: 20px;
    }
    form {
        margin-bottom: 20px;
    }
    label {
        display: block;
        margin-bottom: 5px;
    }
    input[type="text"],
    input[type="password"],
    input[type="email"],
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
    .result-message {
        text-align: center;
        margin-top: 20px;
    }
    a {
        display: block;
        text-align: center;
        text-decoration: none;
        color: #007bff;
        margin-top: 20px;
    }
    a:hover {
        text-decoration: underline;
    }
</style>

</head>
<body>

<%
    String action = request.getParameter("action");
    String resultMessage = "";

    // MemberDAO 객체 생성
    MemberDAO dao = new MemberDAO(getServletContext());

    if ("findID".equals(action)) {
        String email = request.getParameter("email");
        String foundID = dao.findIDByEmail(email);
        if (foundID != null) {
            resultMessage = "아이디 검색결과: " + foundID;
        } else {
            resultMessage = "입력한 이메일에 해당하는 아이디가 없습니다.";
        }
    }

    if ("findPassword".equals(action)) {
        String id = request.getParameter("id");
        String email = request.getParameter("email");
        String foundPassword = dao.findPassword(id,email);
        if (foundPassword != null) {
            resultMessage = "비밀번호 검색결과: " + foundPassword;
        } else {
            resultMessage = "입력한 아이디와 이메일에 해당하는 비밀번호가 없습니다.";
        }
    }
%>


<!-- 아이디 및 비밀번호 찾기 폼 -->
<h2>아이디 찾기</h2>
<form action="FindID.jsp" method="get">
    <input type="hidden" name="action" value="findID">
    <label for="email">이메일:</label>
    <input type="email" id="email" name="email" required>
    <input type="submit" value="아이디 찾기">
</form>

<h2>비밀번호 찾기</h2>
<form action="FindID.jsp" method="get">
    <input type="hidden" name="action" value="findPassword">
    <label for="id">ID:</label>
    <input type="text" id="id" name="id" required>
    <label for="email">이메일:</label>
    <input type="email" id="email" name="email" required>
    <input type="submit" value="비밀번호 찾기">
</form>

<!-- 결과 메시지 출력 -->
<div style="margin-top: 20px;">
    <%= resultMessage %>
</div>

<a href="../ListMainForm.jsp">홈페이지로 돌아가기</a>

</body>
</html>
