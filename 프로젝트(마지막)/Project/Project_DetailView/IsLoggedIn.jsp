<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="common.JSFunction" %>
    
<%
	if(session.getAttribute("UserId") == null) {
		JSFunction.alertLocation("로그인 후 이용해 주세요", "../06_Session/02_LoginForm.jsp", out);
	}
%>