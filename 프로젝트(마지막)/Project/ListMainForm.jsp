<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="dto.*"%>
<%@ page import="java.util.*"%>
<%

// 페이지 번호
// 리스트 페이지의 파라미터가 null인 경우 1, 아닌경우 리스트 페이지를 반환하라
int listPage = (request.getParameter("listPage") == null) ? 1 : Integer.parseInt(request.getParameter("listPage"));

// DAO 객체를 생성하여 DB 연결
BoardDAO dao = new BoardDAO(application);

// 사용자가 입력한 검색 조건 저장
Map<String, Object> param = new HashMap<>();
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");

if (searchWord != null) {
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
	
}

int totalCount = dao.selectCount(param);
// 전체 게시글을 9로 나눈 수를 반환(올림)
int pageCount = (int) Math.ceil((double)totalCount / 9);
//한 페이지에 9개씩 보이도록 처리

List<BoardDTO> boardList = dao.selectListPerPage(param, listPage); // 게시글 목록 받기
List<BoardDTO> bestList = dao.BestList();
List<BoardDTO> openList = dao.OpenList();
dao.close(); // DB연결 닫기
%>
<!DOCTYPE html>
<html>
<style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        h2 {
        	font-size: 42px;
            text-align: center;
        }
        
        hr {
        	width:80%;
        	align:center;
        	border-color: gray;
        	margin:100px;
        }

        table {
            width: 95%;
            margin-left: auto;
            margin-right: auto;
            
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        .synopsis {
            width: 450px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .pagination {
            margin: 20px auto;
            text-align: center;
        }

        .pagination a {
            color: black;
            padding: 8px 16px;
            text-decoration: none;
            transition: background-color .3s;
            margin: 0 4px;
        }

        .pagination a.active {
            background-color: #4CAF50;
            color: white;
            border: 1px solid #4CAF50;
        }

        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }

        .button-container {
            position: flex;
            float : right;
            bottom:20px;
            right: 40px;
            padding : 20px;
            
        }

        .button-container button {
            padding: 10px 20px;
            border: none;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            
        }

        .button-container button:hover {
            background-color: #007bff;
        }
        
        .LinkPage {
            width: 95%;
            margin-top: 20px;
            margin-left: auto;
            margin-right: auto;
            
        }
        .container {
    margin: 0 auto;
    overflow-x: hidden; /* 컨테이너 내용이 넘칠 경우 가로 스크롤바를 표시 */
    white-space: nowrap; /* 내부 요소들이 줄바꿈되지 않도록 설정 */
    background-color: black;
    padding: 20px 0; /* 상하 패딩 추가 */
}

	.container > * {
    max-width: 100%; /* 컨테이너의 최대 너비를 초과하지 않도록 설정 */
}
                
        .boxA {
        
        	width:100%
        	height:500px;
        	display: flex;
        	
  			justify-content: center;
        }
        
        .blank {
        	width:350px;
        	height:auto;
        	float:left;
        	display:inline-block;
        	cursor:pointer;
        	position: relative;
        	margin: 20px;
        	margin-top:50px;
        	border: 0.5px solid rgba(255, 255, 255,0.3);
        }
        
        .boxB {
    display: flex;
    justify-content: center;
    flex-wrap: nowrap; /* 요소들이 다음 줄로 넘어가지 않고 한 줄에 표시되도록 설정 */
    }
    
            
       .best {
    display: inline-block; /* 인라인 블록 요소로 설정하여 가로로 나열 */
    cursor: pointer;
    position: relative;
    height:400px;
    margin: 20px; /* 사진 사이의 좌우 마진 조정 */
    border: 0.5px solid rgba(255, 255, 255, 0.3);
    vertical-align: middle; /* 이미지들이 상단 정렬되도록 설정 */
}

	.best img {
    width: 300px; /* 이미지의 원래 비율 유지 */
    height: auto; /* 이미지 높이를 고정하여 일관성 있는 레이아웃 유지 */
}   
	.theater {
	width:100%;
	height:500px;
	background-color: white;
	}     
	.LinkButton {
		padding-top: 50px;
		text-align: center;
	}
	
	.LinkButton button {
			width:20%;
            padding: 10px 20px;
            margin:15px;
            border: none;
            background-color: rgba(104, 175, 255);
            color: white;
            cursor: pointer;
            font-size: 16px;
            
        }
        
        footer{
   
   width: 100%;
   height: 110px;
   top : 100px;
   bottom: 0px;
   position: relative;
   color : white;
   background-color : rgba(0,0,0,0.5);
   font-style: italic;
}
    </style>
<head>
<meta charset="UTF-8">
<title>영화 페이지</title>
</head>
<body>
	<div width="95%" class="LinkPage">
	<jsp:include page="../Project/Link/Link.jsp"/>  <!-- 공통링크(상단) -->
	<% if((session.getAttribute("nickname")) != null) { %>
	<p align="right"> <%= session.getAttribute("nickname") %> 회원님, 안녕하세요! &nbsp;&nbsp;&nbsp;</p>
	<%} %>
	
	</div>
	<h2>영화 개봉작 리스트</h2>
	<!-- 검색폼 -->
	<form method="get">
		<table width="100%">
			<tr onmouseover="this.style.backgroundColor='white'">
				<td align ="left" style="border:none;">
					전체 <%= totalCount %>건
				</td>
				<td align="right" style="border:none; hover:none;">
				<select name="searchField">
						<option value="title">제목</option>
						<option value="genre">장르</option>
				</select> 
				<input type="text" name="searchWord" placeholder="검색어 입력" >
				<input type="submit" value="검색하기" /></td>
			</tr>
		</table>
	</form>
	
	<!-- 게시물 목록 -->
	<table border="1" width="100%" style= "border-style: none;">
		<!-- 각 칼럼의 이름 -->
		<tr>
			<th>번호</th>
			<th>
				이미지
			</th>
			<th>제목</th>
			<th>장르</th>
			<th>개봉일</th>
			<th>줄거리</th>
		</tr>
		<!-- 목록의 내용 -->
		<%
		if (boardList.isEmpty()) {
			// 게시물이 존재하지 않을 때
		%>
		<tr>
			<td colspan="5" align="center">등록된 게시물이 존재하지 않습니다</td>
		</tr>
		<%
		} else {
		// 게시물이 존재할 떄
		int idx = 1;
		for (BoardDTO dto : boardList) {
		%>
		<tr align="center">
			<td><%=((listPage-1)*10)+ idx++ %></td>
			<td width="200">
				<img src="<%=dto.getImg()%>" width="70" height="110" onclick="location.href='./Project_DetailView/Detail.jsp?movie=<%=dto.getMovie()%>'" style="cursor:pointer">
			</td>
			<td width="180"><a href="./Project_DetailView/Detail.jsp?movie=<%=dto.getMovie()%>"><%=dto.getTitle()%></a></td>
			<td width="150"><%=dto.getGenre()%></td>
			<td><%=dto.getReleasedate().substring(0, 10)%></td>
			<td width="450">
				<div class="synopsis">
					<%=dto.getSynopsis() %>
				</div>
			</td>
		</tr>
		
		<%
			
		}
		}
		%>
	</table>
	
	<!-- 페이지네이션 -->
	<div class="pagination">
	
				<%
					for(int i = 1; i <= pageCount; i++) {
						if (i == 1)
							out.print("<a href='ListMainForm.jsp?listPage=" + i + "'>" + i + "</a>");
						else
							out.print(" | <a href='ListMainForm.jsp?listPage=" + i + "'>" + i + "</a>");
					}
				%>
				
				<!-- 목록 하단의 [글쓰기] 버튼 -->
	
	
	<div class="button-container">
		<% if(listPage != 1) {%>
			<button type="button" onclick="location.href='ListMainForm.jsp';">
					메인으로 돌아가기</button>
		<% } %>
			<% if(session.getAttribute("UserKey") != null && session.getAttribute("UserKey").equals("0")) {
			%>
				<button type="button" onclick="location.href='./Write.jsp';">
					글쓰기(관리자)</button>
			<% } %>
		
		</div>
	</div>
	<hr>
	
		<h2>BEST 추천 영화(조회수 TOP3)</h2>
		<div class="container">
			<%
		if (bestList.isEmpty()) {
			// 게시물이 존재하지 않을 때
		%>
		<div class="boxA">
			<img src="#" class="blank">
			<img src="#" class="blank">
			<img src="#" class="blank">
		<%
		} else { %>
		
		
		<% 
		// 게시물이 존재할 떄
		for (BoardDTO dto : bestList) {
		%>	
			<div class="boxB">
			<img src="<%=dto.getImg()%>" class="best" onclick="location.href='./Project_DetailView/Detail.jsp?movie=<%=dto.getMovie()%>'" >
			
		<% }} %>
		</div>
		</div>
	</div>
	
	<hr>
	
		<h2 style="color:white;">개봉임박 영화</h2>
		<div class="container">
			<%
		if (bestList.isEmpty()) {
			// 게시물이 존재하지 않을 때
		%>
		<div class="boxA">
			<img src="#" class="blank">
			<img src="#" class="blank">
			<img src="#" class="blank">
		<%
		} else { %>
		
		
		<% 
		// 게시물이 존재할 떄
		for (BoardDTO dto : openList) {
		%>	
			<div class="boxB">
			<img src="<%=dto.getImg()%>" class="best" onclick="location.href='./Project_DetailView/Detail.jsp?movie=<%=dto.getMovie()%>'" >
			
		<% }} %>
		</div>
		</div>
	</div>
	<div class="theater">
	<h2 style="padding-top: 50px">더 많은 영화가 궁금할땐?</h2>
	<h3 style="font-size: 40px;" align="center">지금 바로 확인하세요!</h3>
		<div class="LinkButton">
		<button onclick="window.location.href = 'https://www.cgv.co.kr/';">CGV 바로가기</button>
		<button onclick="window.location.href = 'https://www.megabox.co.kr/';">메가박스 바로가기</button>
		<button onclick="window.location.href = 'https://www.lottecinema.co.kr/NLCHS';">롯데시네마 바로가기</button>
		</div>
	</div>
	
	
</body>
<footer>
<br>
  <p>  
     <span>프로젝트 팀원 : 권민채, 배재천, 정영훈</span><br>
     <span>2024.2.21~ 2024.2.27</span>
  </p>
  <small>Copyright & copy; 2024.Team3. All Rights Reserved.</small>
</footer>
</html>