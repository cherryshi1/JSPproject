<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "common.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "dao.*" %>
<%@ include file="./AdminCheck.jsp" %>
<%
	String movie = request.getParameter("movie");	// 무비(시퀀스) 정보를 얻어오기(해당 게시물)
	String title = request.getParameter("title");
	String genre = request.getParameter("genre");
	String releasedate = request.getParameter("releasedate");
	String synopsis = request.getParameter("synopsis");
	
	String img = request.getParameter("img");
	String trailer = request.getParameter("trailer");

	BoardDTO dto = new BoardDTO();
	
	dto.setMovie(movie);
	dto.setTitle(title);
	dto.setGenre(genre);
	dto.setReleasedate(releasedate);
	dto.setSynopsis(synopsis);
	
	dto.setImg(img);
	dto.setTrailer(trailer);
	
	BoardDAO dao = new BoardDAO(application);
	int result = dao.updateEdit(dto);
	if(result==1) {
		// DB에 수정된 내용 저장 성공, 게시글 상세화면으로 이동
		JSFunction.alertLocation("게시글이 수정 되었습니다", "../ListMainForm.jsp", out);
	} else {
		// 실패
		JSFunction.alertBack("게시글 수정이 실패하였습니다", out);
	}
	
	dao.close();
%>
