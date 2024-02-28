<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "common.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "dao.*" %>
<%@ include file="./AdminCheck.jsp" %>    
    
<%
	// 화면 입력값 받기
	String title = request.getParameter("title");
	String genre = request.getParameter("genre");
	String releasedate = request.getParameter("releasedate");
	
	String img = request.getParameter("img");
	String synopsis = request.getParameter("synopsis");
	String trailer = request.getParameter("trailer");
	
	// DTO 객체에 저장
	BoardDTO dto = new BoardDTO();
	dto.setTitle(title);
	dto.setGenre(genre);
	dto.setReleasedate(releasedate);
	
	dto.setImg(img);
	dto.setSynopsis(synopsis);
	dto.setTrailer(trailer);
		
	
	// DAO 객체를 이용해 DB에 저장
	BoardDAO dao = new BoardDAO(application);
	int result = dao.insertWrite(dto);
	dao.close();
	
	if(result == 1) {  // insert 성공시
		response.sendRedirect("ListMainForm.jsp");
	} else {
		JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
	}
%>    