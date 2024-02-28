<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="common.JSFunction"%>
<%@ page import="dto.GoodPointDTO"%>
<%@ page import="dao.GoodPointDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좋아요 추가</title>
</head>
<body>

	<%
	if (session.getAttribute("id") == null) { //로그인확인
		JSFunction.alertLocation("로그인 후 이용해 주세요", "../Project_Login/Login.jsp", out);
	} else {
		GoodPointDAO dao = new GoodPointDAO(application);
		GoodPointDTO dto = new GoodPointDTO();
		String movie_no = request.getParameter("movie_no");
		String user_id = session.getAttribute("id").toString();
		
		dto.setUser_id(user_id);
		dto.setMovie_no(movie_no);
		

		if (Boolean.TRUE.equals(dao.selectgoodPoint(user_id, movie_no))) { //좋아요 누른지 여부 확인
			
			int result = dao.deleteGoodPoint(dto);
			if(result == 1){
				System.out.print(result);
				response.sendRedirect("Detail.jsp?movie=" + movie_no);
			}
			else{
				JSFunction.alertBack("좋아요 취소에 실패하셨습니다..", out);
			}
			dao.close();
			
		}
		
		else {

			
		try {
			int result = 0;
			result = dao.updateGoodPoint(dto);

		if (result == 1) { //갱신여부 확인
			response.sendRedirect("Detail.jsp?movie=" + movie_no);

		} else {
			JSFunction.alertBack("좋아요 갱신에 실패하셨습니다..", out);
		}

			} catch (Exception e) {
		e.printStackTrace();
			} finally {
		dao.close();

			}
		}
	}
	%>
</body>
</html>