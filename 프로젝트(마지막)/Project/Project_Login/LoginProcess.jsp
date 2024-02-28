<%@page import="javax.swing.text.html.parser.DTD"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<%@ page import="dto.MemberDTO" %>

<%
    // 아이디와 비밀번호를 받아옴
    String id = request.getParameter("id");
    String password = request.getParameter("password");
    
    // MemberDAO 객체 생성
    MemberDAO dao = new MemberDAO(application);
    
    // MemberDTO를 사용하여 아이디와 비밀번호 확인
    MemberDTO dto = dao.getMemberDTO(id, password);
    
    // 아이디와 비밀번호가 일치하는 경우
    if(dto.getId() != null) {
        // 세션에 사용자 정보 저장
        session.setAttribute("id", dto.getId());
        session.setAttribute("nickname", dto.getNickname());
        session.setAttribute("UserKey", dto.getUserkey());
        
        // 로그인 후 리다이렉트할 페이지로 이동
        response.sendRedirect("../ListMainForm.jsp");
    } else {
        // 아이디 또는 비밀번호가 일치하지 않는 경우
        request.setAttribute("error", "아이디 또는 비밀번호를 다시 확인해주세요.");
        // 로그인 페이지로 다시 이동
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }
%>
