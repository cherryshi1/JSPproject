<%@page import="jakarta.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.BoardDAO , dto.BoardDTO"%>
<%@ page import="dao.DcommentDAO, dto.DcommentDTO"%>
<%@ page import="java.util.*"%>
<%@ page import="common.JSFunction"%>
<%@ page import="dao.ImgDAO, dto.ImgDTO"%>
<%@ page import="dao.GoodPointDAO, dto.GoodPointDTO"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8" name="viewport"
	content="width=device-width, initial-scale=1.0">
<title>영화 상세정보</title>
<link href="default.css" rel="stylesheet" type="text/css" media="all">
<link
	href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&family=Noto+Sans+KR:wght@100..900&family=Dongle:wght@700&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Serif+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style>
[id*="hidden"] {
	display: none;
}
</style>
<!-- 댓글썼는지 확인 -->
<script type="text/javascript">
	function validateForm(form) {
		var comments = form.comment.value;
		if (comments == null || comments.trim() == "") {
			alert("내용을 입력하세요.");
			form.comment.focus();
			return false;
		}
		return true;
	}

	// url 공유하기
	function copyURL() {
		var url = window.location.href;
		navigator.clipboard.writeText(url);
		alert("주소가 복사되었습니다");
		
		
	}
	//댓글 삭제
	function deleteComment(){
		var confirmed = confirm("정말로 삭제하겠습니까?");
		if (confirmed){
			var form = document.cmt;
			form.method = "post";
			form.action = "DeleteComment.jsp";
			form.submit();
		}
	}	
	
	function showhidden(num){
	    var hidden = document.getElementById("hidden " + num);
	    if (hidden.style.display == "block") {
	        hidden.style.display = "none";
	    } else {
	        hidden.style.display = "block";
	    }
	}
	
	function votehidden(){
		var hidden = document.getElementById("vote");
		if (hidden.style.display == "block") {
	        hidden.style.display = "none";
	    } 
	}
	
	

	
	
</script>
</head>
<body>
	<%
	//db 와의 연결
	BoardDAO dao = new BoardDAO(application);
	BoardDTO dto = new BoardDTO();
	ImgDAO imgdao = new ImgDAO(application);
	ImgDTO imgdto = new ImgDTO();

	//클릭한 게시글 정보호출	
	String movie = request.getParameter("movie");
	String dcomment = request.getParameter("dcomment");

	// DB에서 상세 게시글 정보 조회하기
	dto = dao.DetailView(movie);
	imgdto = imgdao.viewImg(movie); //이미지리스트
	dao.UpViews(movie);
	
	// DB에서 댓글리스트 출력하기
	DcommentDAO ddao = new DcommentDAO(application);
	Map<String, Object> param = new HashMap<String, Object>();
	if (movie != null) { //영화를 클릭했으면 map에 영화번호 저장
		param.put("movie", movie);
	}
	// (dto : Boarddto, ddto : Dcommentdto, imgdto : Imgdto)
	List<DcommentDTO> commentList = ddao.viewComment(param);

	//로그인확인 (로그인한 경우일때)
	boolean isLoggedIn = session.getAttribute("id") != null;

	//좋아요수치
	GoodPointDAO gooddao = new GoodPointDAO(application);
	GoodPointDTO gooddto = new GoodPointDTO();
	
	dao.close();
	
	%>


	<!-- 영화정보 출력 -->
	<div id="header-wrapper"
		style="background: #111111 url('<%=imgdto.getImg1()%>'); background-size:cover;">
		<div id="header" class="container">
			<div id="logo">
				<h1>
					<a href="#" onclick="location.href='../ListMainForm.jsp';"
						style="font-family: 'East Sea Dokdo'">영화리뷰사이트</a>
				</h1>
			</div>
			<div id="menu">
				<ul>
					<li class="active"><a href="#"
						onclick="location.href='../ListMainForm.jsp';">목록으로</a></li>
					<%
					if (isLoggedIn) { //로그인 중이라면
					%>
					<li><a href='../Project_Login/MyPage.jsp'>마이 페이지</a></li>
					<li><a href='../Project_Login/Logout.jsp'>로그아웃</a></li>
					<%
					} else { //로그인 안했을경우
					%>
					<li><a href='../Project_Login/Login.jsp'>로그인</a></li>
					<li><a href='../Project_Login/Register.jsp'>회원가입</a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
		</div>

		<div id="banner-wrapper">
			<div id="banner" class="container">
				<img src="<%=dto.getImg()%>" height="80%" width="50%" class="rounded-lg shadow-lg">
				<div class="title">
					<h2><%=dto.getTitle()%></h2>
					<br> <span class="byline" style="font-size: 30px"> 개봉일
						:<%=dto.getReleasedate()%><br> 장르 : <%=dto.getGenre()%>
						&nbsp;&nbsp; <a onclick="copyURL()" class="copy"
						style="float: auto;"><span class="material-symbols-outlined">Content_Copy</span></a><br>
					</span>
					
					<!-- 좋아요 -->
					<%
					String user_id = (String)session.getAttribute("id");
					String movie_no = dto.getMovie();
					if(Boolean.TRUE.equals(gooddao.selectgoodPoint(user_id, movie_no))){ %>
					<a href='GoodPointplus.jsp?movie_no=<%= dto.getMovie() %>' class="material-symbols-outlined plus" />Favorite</a>
					&nbsp;&nbsp; <%= gooddao.goodPointCount(dto.getMovie())%>
					<%} else{ %>
					<a href='GoodPointplus.jsp?movie_no=<%= dto.getMovie() %>' class="material-symbols-outlined minus"/>Favorite</a>
					&nbsp;&nbsp; <%= gooddao.goodPointCount(dto.getMovie())%>
					<%} %>
					
				
					
				
			
					<br>
				</div>
			</div>
		</div>
	<hr>
	<!-- 영화 줄거리 & 정보  -->
	<div id="wrapper">
		<div class="container">
			<br>
			<h3 class="byline"
				style="font-family: Nanum Pen Script; font-size: 40px;">
				<%=dto.getSynopsis()%></h3>
			<br>
			<br>
			<hr>
			<br>
			<br>
			<h3 style="font-size: 20px;">
				<%=imgdto.getDirector()%>
			</h3>
			<br>
			<br>
			<hr>
			<br>
			<br>
		</div>

		<!-- 여기서부터 이미지 사진 -->
		<div id="three-column" class="container">
			<div class="boxA">
				<p>
					<img class="steel" src="<%=imgdto.getImg2()%>">
				</p>
				<a class="button button-alt">스틸컷1</a>
			</div>
			<div class="boxB">
				<p>
					<img class="steel" src="<%=imgdto.getImg3()%>">
				</p>
				<a class="button button-alt">스틸컷 2</a>
			</div>
			<div class="boxC">
				<p>
					<img class="steel" src="<%=imgdto.getImg4()%>">
				</p>
				<a class="button button-alt">스틸컷 3</a>
			</div>
		</div>
	</div>

	<!--  여기서부터 트레일러 -->
	<div id="welcome">
		<div class="container">
			<div class="title">
				<h2>Trailer</h2>
			</div>
			<iframe width="800" height="450"
				src="https://www.youtube.com/embed/<%=dto.getTrailer()%>"
				frameborder="0"
				allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"></iframe>
			<br>
			<p>
				<strong>Movie Trailer.</strong><br>트레일러를 보고 기대되는 영화를 시청후 감상평을 남겨주세요!
			</p>
			<ul class="actions">
				<a href="http://www.cgv.co.kr/ticket/" class="button button-alt">예매하러가기</a>
			</ul>
		</div>
	</div>




	<!-- 여기서부터 흰색페이지 -->
	<div id="wrapper2">
		<div class="container">
			<div class="tbox1">
				<%
				Boolean hasVoted = (Boolean) session.getAttribute("hasVoted");
				if (Boolean.TRUE.equals(hasVoted)) { //투표 했을경우
				%>
				<h2>투표 결과(표 수)</h2>
				<br>
				<jsp:include page="voteResult.jsp" />

				<%
				} else { //투표 안했을경우
				%>

				<!-- 투표기능 -->
				<div class="vote">
					<form name="vote" method="post" action="voteProcess.jsp">
						<input type="hidden" name="movie" value="<%=dto.getMovie()%>" />
						<h4>평소 영화를 볼때 가장 기대하는 부분은?</h4>
						<br> <input type="radio" name="advantage" value="actor" checked />뛰어난 연기력의 출연진들<br>
							 <input type="radio" name="advantage" value="director" />명성있는 감독과 제작진들<br> 
							 <input type="radio" name="advantage" value="cgnbgm" />화려한 영상미와 배경음악<br>
							 <input type="radio" name="advantage" value="story" />몰입력 있는 스토리<br>
							 <input type="submit" class="button btn-gradient blue mini" value="투표하기" />
					</form>
				</div>
				<%
				}
				%>
			</div>
			<div class="tbox2" style="border: 3px dotted rgb(4, 130, 255);">
				<!-- 여기서부터 댓글 -->
				<form name="cmt" method="post" action="WriteCommentProcess.jsp">
					<input type="hidden" name="movie" value="<%=movie%>" />
					<h2>감상평 댓글</h2>
					<br>
					<div class="comment-form"
						style="width: 400px; height: auto; margin-left: auto; margin-right: auto;">
						<textarea name="content" placeholder="댓글을 입력하세요"></textarea>
						<button type="submit" class="button btnFade btnBlueGreen register">등록</button>
					</div>
				</form>
				<br>
				<br>
				<!-- 댓글 출력 -->
				<table
					style="width: 500px; margin-left: auto; margin-right: auto; vertical-align: middle; justify-center: center; align-items: center;">
					<tr>
						<th>작성자</th>
						<th>내용</th>
						<th></th>
						<th style="width: 20%;"></th>
					</tr>
					<%
					int num = 0;
					int totalComment = ddao.selectComment(param);
					for (DcommentDTO ddto : commentList) {
						num = totalComment--; // 전체댓글수에서 1씩 감소
					%>
					<tr>
						<td align="center"><%=ddto.getNickname()%></td>
						<td align="center"><%=ddto.getContent()%></td>

						<%
						//본인이 쓴 댓글만 버튼보임
						if (isLoggedIn && session.getAttribute("id").toString().equals(ddto.getId())) {
						%>
						<td>
							<button type="button" class="button btn-gradient blue mini"
								onclick="showhidden(<%=num%>)">수정</button>
								<div id="hidden <%=num%>">
								<form method="post" action="EditComment.jsp">
									<input type="hidden" name="id" value="<%=ddto.getId()%>" /> <input
										type="hidden" name="dcomment" value="<%=ddto.getDcomment()%>" />
									<input type="hidden" name="movie" value="<%=ddto.getMovie()%>" />
									<input type="hidden" name="nickname" value="<%=ddto.getNickname()%>" />
									<textarea name="content"></textarea>
									<button type="submit" class="button btn-gradient blue mini">전송</button>
								</form>
							</div>
						</td>
						<td style="width: 10%;">
							<form method="post" action="DeleteComment.jsp">
								<input type="hidden" name="id" value="<%=ddto.getId()%>" /> <input
									type="hidden" name="dcomment" value="<%=ddto.getDcomment()%>" />
								<input type="hidden" name="movie" value="<%=ddto.getMovie()%>" />
								<input type="hidden" name="nickname" value="<%=ddto.getNickname()%>" />
								<input type="hidden" name="content" value="<%=ddto.getContent()%>" />
								<button type="submit" class="button btn-gradient blue mini" onclick="deleteComment();">삭제</button>
							</form>
						</td>
					</tr>
					<%
					}
					}
					%>
				</table>
			</div>
		</div>
	</div>
	<hr>



	<!-- 하단메뉴 -->
	<% if(session.getAttribute("UserKey") != null && session.getAttribute("UserKey").equals("0")) {
			%>
	<button type="button" class="button btn-gradient blue mini" style="float: right;"
		onclick="location.href='DeleteCheck.jsp?movie=<%=dto.getMovie()%>';">게시물삭제</button>
	<button type="button" class="button btn-gradient blue mini" style="float: right;"
		onclick="location.href='EditForm.jsp?movie=<%=dto.getMovie()%>';">게시물수정</button>
	<% } %>
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