<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	session.setAttribute("id", session.getAttribute("id"));
%>
    
    <!-- "정말로 삭제하시겠습니까?" 를 띄우기 위한 JavaScript 코드 -->
<script type="text/javascript">
    var confirmed = confirm("정말로 삭제하시겠습니까?");
    if (confirmed) {
        window.location.href = "./UnRegisterProcess.jsp";
    } else {
        history.back();  // 이전 페이지로 돌아가기
    }
</script>