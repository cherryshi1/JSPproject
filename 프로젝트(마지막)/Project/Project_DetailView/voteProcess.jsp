<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.Iterable"%>
<%@ page import ="dto.BoardDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 결과</title>
<script type="text/javascript">
</script>
</head>
<body>
	
	<%
	String select = request.getParameter("advantage");
	Map<String, Integer> voteData = (Map<String, Integer>)session.getAttribute("voteData");
	
	if (voteData == null) {
        voteData = new HashMap<>();
        String[] advantages = {"actor", "director", "cgnbgm", "story"};

        for (String advantage : advantages) {
            voteData.put(advantage, 0);
        }
    }
	
	String[] advantages = {"actor", "director", "cgnbgm", "story"};
	Map<String, String> valuename = new HashMap<>(); // value값 이름
	
	for (String advantage : advantages) {
		switch(advantage){
		case "actor" : valuename.put(advantage, "뛰어난 연기력의 출연진들");
		break;
		case "director" : valuename.put(advantage, "명성있는 감독과 제작진들");
		break;
		case "cgnbgm" : valuename.put(advantage, "화려한 영상미와 배경음악");
		break;
		case "sotry" : valuename.put(advantage, "몰입력 있는 스토리");
		break;
		}
	}
	
    
	int voteCount = voteData.get(select); //현재 투표값
	Map<String, Integer> voteResult = new HashMap<>(); //투표결과 select 한 결과값
	voteData.put(select, voteCount + 1);
	session.setAttribute("voteData", voteData); //세션에 데이터저장
	session.setAttribute("hasVoted", true); //투표유무
	%>
	
	<jsp:include page="voteResult.jsp" />
	
</body>
</html>