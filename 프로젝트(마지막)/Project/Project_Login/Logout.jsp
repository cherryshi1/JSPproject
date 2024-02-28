<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //세션 초기화( 로그아웃을 위한)
    session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그아웃</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }

        h2 {
            color: #333;
        }

        .button {
            background-color: #007bff;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            margin: 10px;
        }

        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h2>로그아웃 되었습니다.</h2>
    <input type="button" class="button" value="로그인 페이지로 돌아가기" onclick="location.href='Login.jsp';">
    <input type="button" class="button" value="목록으로 돌아가기" onclick="location.href='../ListMainForm.jsp';">
</body>
</html>
