<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="common.JSFunction" %>

<%
    // 세션에서 사용자 ID 가져오기
    String userId = (String) session.getAttribute("id");

    // MemberDAO 객체 생성
    MemberDAO memberDAO = new MemberDAO(getServletContext());

    // 회원 탈퇴 처리
    boolean success = memberDAO.unregisterMember(userId);

    // 회원 탈퇴 성공 여부에 따라 메시지 표시
    if (success) {
        // 회원 탈퇴가 성공한 경우
        // 세션 초기화 및 ListMainForm.jsp페이지로 이동
        session.invalidate(); // 세션 초기화
        JSFunction.alertLocation("성공적으로 삭제되었습니다", "../ListMainForm.jsp", out);
        // response.sendRedirect("../ListMainForm.jsp");
    } else {
        // 회원 탈퇴가 실패한 경우
        // 에러 메시지 표시
        out.println("<h1>회원 탈퇴 실패</h1>");
        out.println("<p>회원 탈퇴 중 오류가 발생했습니다. 다시 시도해주세요.</p>");
        response.sendRedirect("../ListMainForm.jsp");
    }
%>

