<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "common.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "dao.*" %>
<%@ include file="./AdminCheck.jsp" %>
<%
	String movie = request.getParameter("movie");	// 무비(시퀀스) 정보를 얻어오기(해당 게시물)

	BoardDTO dto = new BoardDTO();
	BoardDAO dao = new BoardDAO(application);

	dto = dao.DetailView(movie);	// dto 객체에 무비값의 게시물 정보를 얻기
	dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f5f5f5;
    }

    h2 {
        text-align: center;
        margin-top: 20px;
    }

    form {
        width: 60%;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
    }

    table {
        width: 100%;
    }

    td {
        padding: 10px;
    }
	
	textarea {
		height : 200px;
	}
    input[type="text"] {
        width: 100%;
        padding: 8px;
        border-radius: 4px;
        border: 1px solid #ccc;
        box-sizing: border-box;
        margin-top: 4px;
        margin-bottom: 10px;
    }

    button[type="submit"], button[type="reset"], button[type="button"] {
        padding: 10px 20px;
        border: none;
        background-color: #4CAF50;
        color: white;
        cursor: pointer;
        border-radius: 4px;
    }

    button[type="submit"]:hover, button[type="reset"]:hover, button[type="button"]:hover {
        background-color: #45a049;
    }
</style>
<script type="text/javascript">
function validateForm(form) {  // 폼 내용 검증
	if(form.title.value == "") {
		alert("제목을 입력하세요");
		form.title.focus();
		return false;
	}
	
	if(form.genre.value == "") {
		alert("장르를 입력하세요");
		form.genre.focus();
		return false;
	}
	
	if(form.releasedate.value == "") {
		alert("개봉일을 입력하세요");
		form.releasedate.focus();
		return false;
	}
	
	if(form.synopsis.value == "") {
		alert("내용을 입력하세요");
		form.content.focus();
		return false;
	}
	
	if(form.synopsis.value == "") {
		alert("줄거리를 입력하세요");
		form.synopsis.focus();
		return false;
	}
}
</script>
</head>
<body>
<form name="EditFrm" method="post" action="EditProcess.jsp?movie=<%= dto.getMovie() %>"
      onsubmit="return validateForm(this);">
       <table border="1" width="90%">
        <tr>
            <td align="center">제목</td>
            <td>
                <input type="text" name="title" value="<%= dto.getTitle() %>" style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td align="center">장르</td>
            <td>
                <input type="text" name="genre" value="<%= dto.getGenre()%>" style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td align="center">개봉일</td>
            <td>
                <input type="text" name="releasedate" value="<%= dto.getReleasedate().substring(0,10)%>" style="width: 90%;" />
            </td>
        </tr>
        <tr>
        <tr>
            <td align="center">줄거리</td>
            <td>
                <textarea name="synopsis" style="width: 90%;" ><%= dto.getSynopsis() %>"  </textarea>
            </td>
        </tr>
        <tr>
            <td align="center">이미지 url</td>
            <td>
                <input type="text" name="img" value="<%= dto.getImg() %>"  style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td align="center">트레일러 url(Youtube 동영상 ID)</td>
            <td>
                <input type="text" name="trailer" value="<%= dto.getTrailer() %>"  style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='../ListMainForm.jsp';">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>