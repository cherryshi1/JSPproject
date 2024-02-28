<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.BoardDAO" %>
<%@ page import="dto.BoardDTO" %>
<%@ page import="common.JSFunction" %>
<%@ include file="./AdminCheck.jsp" %>
    
<%
	String movie = request.getParameter("movie");	// 무비(시퀀스) 정보를 얻어오기(해당 게시물)

	BoardDTO dto = new BoardDTO();
	BoardDAO dao = new BoardDAO(application);
	
	dto = dao.DetailView(movie);	// dto 객체에 무비값의 게시물 정보를 얻기
	
	int result = dao.deletePost(dto);
	dao.close();
	
	if(result==1) {
		JSFunction.alertLocation("성공적으로 삭제되었습니다", "../ListMainForm.jsp", out);
	} else {
		JSFunction.alertBack("삭제 중 오류가 발생하였습니다", out);
	}
%>