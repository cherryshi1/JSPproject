<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="dto.MemberDTO" %>
    <%@ page import ="dao.MemberDAO" %>
    <%@ page import ="common.JSFunction" %>
    
<%
String id = request.getParameter("id");
String password = request.getParameter("password");
String nickname = request.getParameter("nickname");
String email = request.getParameter("email");
String userkey = request.getParameter("userkey");
String phone = request.getParameter("phone");


MemberDTO dto = new MemberDTO();
dto.setId(id);
dto.setPwd(password);
dto.setNickname(nickname);
dto.setEmail(email);
dto.setUserkey(userkey);
dto.setPhone(phone);

MemberDAO dao = new MemberDAO(application);
int result = dao.insertWrite(dto);

dao.close();
if(result == 1){
	response.sendRedirect("Login.jsp");
}else{
	 System.out.println("회원가입 실패");
	 JSFunction.alertLocation("회원가입에 실패했습니다", "Login.jsp", out);
}

%>