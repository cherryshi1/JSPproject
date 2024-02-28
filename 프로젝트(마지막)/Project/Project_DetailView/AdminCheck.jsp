<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="common.JSFunction" %>
    
<%
	if(session.getAttribute("UserKey") == null) {
		JSFunction.alertLocation("로그인 후 사용해주세요", "../ListMainForm.jsp", out);
	} else if(!session.getAttribute("UserKey").equals("0")) {
		JSFunction.alertLocation("관리자만 사용할 수 있습니다", "../ListMainForm.jsp", out);
	}
%>