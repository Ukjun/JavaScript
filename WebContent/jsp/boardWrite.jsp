<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<form action="/jsp/boardWriteProc.jsp" method="post">
		<!--
			jsp/boardWritePorc.jsp로 내용을 전달할거임 
			post로 보내면 캡슐화로 보내서 queryString이 생성되지않는다 
			name은 값을 찾아가는 키로 쓰인다 (id, class는 제외)
			label : 해당 대상을 클릭햇을때 focus가 가도록 하기 위해서 
			주로 체크박스 라디오박스에 많이 사용 (버튼을 누르기 힘들기 때문)
		 -->
		<div>
			<label>제목 : <input type="text" name="title"></label>
		</div>
		<div>
			<label>내용 : <textarea name="ctnt"></textarea></label>
		</div>
		<div>
			<label>작성자 : <input type = "text" name="i_student"></label>
		</div>
		<div>
			<input type="submit" value="글 등록" >
			<input type="reset" value="다시 작성">
		</div>
		</form>
	</div>
</body>
</html>