<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.DcommentDTO"%>
<%@ page import="dao.DcommentDAO"%>
<%@ page import="common.JSFunction"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>comment Process</title>
</head>
<body>

	<!-- 화면 입력 값 받기 -->
	<%
	if (session.getAttribute("id") == null) {

		JSFunction.alertLocation("로그인 후 이용해 주세요", "../Project_Login/Login.jsp", out);
	} else {
		String content = request.getParameter("content");
		String movie = request.getParameter("movie");
		String nickname = session.getAttribute("nickname").toString();
		String id = session.getAttribute("id").toString();

		//DTO 객체에 저장
		DcommentDTO dto = new DcommentDTO();

		dto.setContent(content);
		dto.setNickname(nickname);
		dto.setId(id);
		dto.setMovie(movie);

		DcommentDAO dao = new DcommentDAO(application);
		//DAO 객체를 이용해 DB에 저장
		try {int result = dao.insertComment(dto);

			if (result == 1) {
		response.sendRedirect("Detail.jsp?movie=" + movie);
			} else {
		JSFunction.alertBack("댓글 쓰기에 실패하였습니다.", out);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.close();

		}
	}
	%>
</body>
</html>