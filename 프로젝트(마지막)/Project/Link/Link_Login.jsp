<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <table border="1" width="100%">
	<tr>
		<td align="right">
			<!-- 상단 메뉴 -->
			<%if(session.getAttribute("id") == null) {%>
			
			<% } else {%>
			<a href="./Logout.jsp">로그아웃</a>
			&nbsp;&nbsp;&nbsp;
			<% } %>
			<a href="./Register.jsp">회원가입</a>
			&nbsp;&nbsp;&nbsp;
			<a href="./MyPage.jsp">마이페이지</a>
			&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
	</table>