<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.DcommentDTO"%>
<%@ page import="dao.DcommentDAO"%>
<%@ page import="common.JSFunction" %>

<%

	
 	//화면에서 수정된 내용 가져오기
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
	
	//수정
	int result = 0;
	result = dao.updateComment(dto);
			
	try{if(result == 1){//수정성공 -> 상세화면으로 이동
		response.sendRedirect("Detail.jsp?movie=" + dto.getMovie());
	 
	}
	else{
			JSFunction.alertBack("댓글 수정이 실패하였습니다.", out);
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dao.close();
	}	
%>