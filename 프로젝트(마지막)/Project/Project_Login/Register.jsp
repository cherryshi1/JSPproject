<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
        margin: 0;
        padding: 0;
    }
    header {
        background-color: #007bff;
        color: #fff;
        text-align: center;
        padding: 20px 0;
    }
    form {
        max-width: 400px;
        margin: 20px auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        text-align: center;
        margin-bottom: 20px;
    }
    input[type="text"],
    input[type="password"],
    input[type="number"],
    input[type="tel"],
    input[type="submit"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box; /* 입력란의 크기 계산에 패딩 및 테두리를 포함 */
    }
    input[type="submit"] {
        background-color: #007bff;
        color: #fff;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #0056b3;
    }
   input[type="button"] {
    	width : 200px;
        
        text-align: center;
        margin-top: 20px;
        text-decoration: none;
        color: #007bff;
    }
    input[type="button"]:hover {
        text-decoration: underline;
    }
    
    
</style>

</head>
<body>

    <header>
        <h1>어서오세요!</h1>
    </header>
  
    <form action="RegisterProcess.jsp" method="post">
        <h2>회원가입</h2>
        <input type="text" name="id" placeholder="id" required><br>
        <input type="password" name="password" placeholder="비밀번호" required><br>
        <input type="text" name="nickname" placeholder="닉네임" required><br>
        <input type="text" name="email" placeholder="이메일" required><br>
        <input type="hidden" name="userkey" value="1">
        <input type="tel" name="phone" placeholder="전화번호" required>
        <input type="submit" value="가입하기">
    </form>
    <div style="text-align: center;">
    <input type="button" value="로그아웃" onclick="location.href='./Logout.jsp'"><br>   
    <input type="button" value="마이페이지" onclick="location.href='./MyPage.jsp'"><br>
    <input type="button" value="홈페이지로 돌아가기" onclick="location.href='../ListMainForm.jsp'">
    
    </div>
</body>

</html>