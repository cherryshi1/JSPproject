<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="LinkPage" align="right">
	
				<!-- 상단 메뉴 --> <%
 if ((session.getAttribute("id")) != null) {
 %> <a href="./Project_Login/Logout.jsp">로그아웃</a> &nbsp;&nbsp;&nbsp; <%
 } else {
 %>
				<a href="./Project_Login/Login.jsp">로그인</a> &nbsp;&nbsp;&nbsp; <%
 }
 %>
				<a href="./Project_Login/Register.jsp">회원가입</a> &nbsp;&nbsp;&nbsp; <a
				href="./Project_Login/MyPage.jsp">마이페이지</a>
			
</div>
