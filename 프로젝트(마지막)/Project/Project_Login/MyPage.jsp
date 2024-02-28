<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO, dto.MemberDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Page</title>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7;
        }
        h1 {
            text-align: center;
            margin-top: 50px;
        }
        h2 {
            text-align: center;
        }
        a {
            display: block;
            width: 150px;
            margin: 10px auto;
            padding: 10px;
            text-align: center;
            text-decoration: none;
            color: #fff;
            background-color: #007bff;
            border-radius: 5px;
        }
        a:hover {
            background-color: #0056b3;
        }
        form {
            max-width: 400px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        input[type="hidden"] {
            display: none;
        }
        
        footer{
   
   width: 100%;
   height: 110px;
   top : 50px;
   bottom: 0px;
   position: relative;
   color : white;
   background-color : rgba(0,0,0,0.5);
   font-style: italic;
}
    </style>
    
</head>
<body>

<%
    // 세션에서 사용자 ID 가져오기
    String userId = (String) session.getAttribute("id");

    // 사용자가 로그인한 상태인지 확인
    if (userId == null || userId.isEmpty()) {
        // 로그인되지 않은 경우
%>
    <h1>로그인해주십시오</h1>
    
    <a href="Login.jsp">로그인</a>
    <a href="Register.jsp">회원가입</a>
    <br><br>
    <a href="../ListMainForm.jsp">홈페이지로 돌아가기</a>
    <br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<%
	
    } else {
        // 로그인된 경우
%>
    <h1><%= userId %>님의 MyPage입니다.</h1>

    <%-- 사용자 정보를 수정하기 위해 MemberDAO를 사용 --%>
    <%
        MemberDAO memberDAO = new MemberDAO(getServletContext());
        MemberDTO member = memberDAO.getMemberById(userId);
    %>

    <h2>회원정보 수정</h2>
    <form action="UpdateProfile.jsp" method="post">
        <input type="hidden" name="id" value="<%= member.getId() %>">
        <label for="nickname">Nickname:</label>
        <input type="text" id="nickname" name="nickname" value="<%= member.getNickname() %>"><br>
        <label for="email">Email:</label>
        <input type="text" id="email" name="email" value="<%= member.getEmail() %>"><br>
        <label for="phone">Phone:</label>
        <input type="text" id="phone" name="phone" value="<%= member.getPhone() %>"><br>
        <input type="submit" value="Update">
       <a href="../ListMainForm.jsp">홈페이지로 돌아가기</a>
    </form>
    
    <h2>회원 탈퇴</h2>
    <form action="UnRegisterCheck.jsp" method="post">
        <input type="hidden" name="id" value="<%= member.getId() %>">
        <input type="submit" value="회원탈퇴">
    </form>
    
<%
    }
%>

</body>
<footer>
<br>
  <p>  
     <span>프로젝트 팀원 : 권민채, 배재천, 정영훈</span><br>
     <span>2024.2.21~ 2024.2.27</span>
  </p>
  <small>Copyright & copy; 2024.Team3. All Rights Reserved.</small>
</footer>
</html>
