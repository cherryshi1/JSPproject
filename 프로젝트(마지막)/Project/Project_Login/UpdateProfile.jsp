<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO, dto.MemberDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Profile</title>
    
     <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7;
            text-align: center;
        }
        h1 {
            margin-top: 50px;
            color: #333;
        }
        h2 {
            margin-top: 20px;
            color: #007bff;
        }
        input[type="button"] {
            margin-top: 20px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="button"]:hover {
            background-color: #0056b3;
        }
    </style>
    
</head>
<body>

    <h1>프로필 변경</h1>

    <%-- 세션에서 사용자 ID 가져오기 --%>
    <% String userId = (String) session.getAttribute("id"); %>

    <%-- 폼에서 전달된 수정된 정보를 가져옵니다 --%>
    <% String nickname = request.getParameter("nickname");
       String email = request.getParameter("email");
       String phone = request.getParameter("phone");
    %>

    <%-- 사용자 정보를 업데이트하기 위해 MemberDAO를 사용합니다 --%>
    <% MemberDAO memberDAO = new MemberDAO(getServletContext());
       MemberDTO member = new MemberDTO();
       member.setId(userId);
       member.setNickname(nickname);
       member.setEmail(email);
       member.setPhone(phone);
       
       int result = memberDAO.updateMemberInfo(member);
       memberDAO.close();
       
       if (result > 0) {
    %>
       <h2>프로필이 변경되었습니다!</h2>
       
       <input type="button" value="로그인 페이지로 돌아가기" onclick="location.href='./UpdateLogin.jsp';">
       <input type="button" value="목록으로 돌아가기" onclick="location.href='./UpdateListMainForm.jsp';">
    <% } else { %>
       <h2>업데이트에 실패하였습니다. 다시 시도해 주세요.</h2>
    <% } %>

</body>
</html>
