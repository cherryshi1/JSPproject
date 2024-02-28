<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./AdminCheck.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
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
	
	if(form.content.value == "") {
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

<h2>영화 페이지 - 글 작성</h2>
<form name="writeFrm" method="post" action="WriteProcess.jsp"
      onsubmit="return validateForm(this);">
    <%
	request.setAttribute("id", session.getAttribute("id"));
	request.setAttribute("nickname", session.getAttribute("nickname"));
	%>
    <table border="1" width="90%">
        <tr>
            <td align="center">제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td align="center">장르</td>
            <td>
                <input type="text" name="genre" style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td align="center">개봉일</td>
            <td>
                <input type="text" name="releasedate" style="width: 90%;" />
            </td>
        </tr>
        <tr>
        <tr>
            <td align="center">줄거리</td>
            <td>
                <textarea name="synopsis" style="width: 90%;" ></textarea>
            </td>
        </tr>
         <tr>
            <td align="center">이미지 url</td>
            <td>
                <input type="text" name="img" style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td align="center">트레일러(Youtube 동영상 ID)</td>
            <td>
                <input type="text" name="trailer" style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='ListMainForm.jsp';">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>