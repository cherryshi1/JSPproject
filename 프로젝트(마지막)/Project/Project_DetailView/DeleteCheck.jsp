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
	
	// ********************
	// 게시물 삭제 중 확인을 위한 연산 추후 추가*********************
	dao.close();
%>

<!-- "정말로 삭제하시겠습니까?" 를 띄우기 위한 JavaScript 코드 -->
<script type="text/javascript">
    var confirmed = confirm("정말로 삭제하시겠습니까?");
    if (confirmed) {
        window.location.href = "./DeleteProcess.jsp?movie=<%=dto.getMovie()%>";
    } else {
        history.back();  // 이전 페이지로 돌아가기
    }
</script>

