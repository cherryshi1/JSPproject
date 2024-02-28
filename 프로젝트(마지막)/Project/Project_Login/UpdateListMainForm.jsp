<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    	// 업데이트 로그인을 위한 로그아웃
    	session.invalidate();
		response.sendRedirect("../ListMainForm.jsp");
%>