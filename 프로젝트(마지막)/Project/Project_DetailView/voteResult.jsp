<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 결과(표 수)</title>
<link rel="stylesheet" href="voteCSS.css">
</head>
<body>
<% 
	Map<String, Integer> voteData = (Map<String, Integer>) session.getAttribute("voteData");
	 
	String[] advantages = {"actor", "director", "cgnbgm", "story"};
    Map<String, String> valuename = new HashMap<>();
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

		int totalVote = voteData.get("actor") + voteData.get("director") + voteData.get("cgnbgm")+ voteData.get("story");
		int actor = voteData.get("actor"); 
		int director = voteData.get("director");  
		int cgnbgm = voteData.get("cgnbgm");  
		int story = voteData.get("story");  

		// 각 옵션별 투표 비율 계산
		double actorPercentage = (actor / (double)totalVote) * 100;
		double directorPercentage = (director / (double)totalVote) * 100;
		double cgnbgmPercentage = (cgnbgm / (double)totalVote) * 100;
		double storyPercentage = (story / (double)totalVote) * 100;
		%>

		<div class="chart-container">
	뛰어난 연기력의 출연진들<br><div class="bar" style="width: <%= Math.round(actorPercentage) %>%;"><%= actor %></div><br>
    명성있는 감독과 제작진들 <br><div class="bar" style="width: <%= Math.round(directorPercentage) %>%;"><%= director %></div><br>
    화려한 영상미와 배경음악 <br><div class="bar" style="width: <%= Math.round(cgnbgmPercentage) %>%;"><%= cgnbgm %></div><br>
    몰입력 있는 스토리 <br><div class="bar" style="width: <%= Math.round(storyPercentage) %>%;"><%= story %></div>
		</div>
		
	

	<%
	Boolean voteresultvisit = (Boolean) session.getAttribute("voteresultvisit");
	if (!Boolean.TRUE.equals(voteresultvisit)) {%>
	<button type="button" onclick="location.href='Detail.jsp?movie=<%=request.getParameter("movie")%>';">뒤로가기</button>
	<%}session.setAttribute("voteresultvisit", true);%>


</body>
</html>