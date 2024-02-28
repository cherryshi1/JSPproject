<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.DcommentDTO"%>
<%@ page import="dao.DcommentDAO"%>
<%@ page import="common.JSFunction" %>
<%
//사용자 ID 조회
	String content = request.getParameter("content");
	String dcomment = request.getParameter("dcomment");
	String id = request.getParameter("id");
	String movie = request.getParameter("movie");
	String nickname = request.getParameter("nickname");
	
	DcommentDTO dto = new DcommentDTO();
	DcommentDAO dao = new DcommentDAO(application);
	
	//DTO에 저장
	dto.setContent(content);
	dto.setDcomment(dcomment);
	dto.setId(id);
	dto.setMovie(movie);
	dto.setNickname(nickname);
	
	System.out.println(dto.getContent() + ":" + dto.getDcomment() + ":" + dto.getId() + ":" + dto.getMovie() + ":" + dto.getNickname());
	
	//수정
	int result = 0;
	result = dao.deleteComment(dto);
	
	if(result==1){//성공시 목록으로 이동
		JSFunction.alertLocation("삭제에 성공했습니다.","Detail.jsp?movie=" + dto.getMovie(), out);
	}else{
		JSFunction.alertBack("삭제에 실패했습니다.", out);
	}
%>
