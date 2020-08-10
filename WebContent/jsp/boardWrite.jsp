<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String msg = "";
    String err = request.getParameter("err");
    if(err!=null){
    	switch(err){
    	case "10":
    		msg = "등록할수 없습니다.";
    		break;
    	case "20":
    		msg = "DB에러 발생";
    		break;
    	}
    }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#msg {
		color: red;
	}
	.container{
		width : 400px;
		text-align : center;
		border: 1px solid black;
		float : left;
		align-justify : justify;
	}
	#frm {
		margin : 30px auto;
	}
</style>
</head>
<body>
	<div id ="msg"><%=msg%></div>
	<div class="container">
		<form id = "frm" action="/jsp/boardWriteProc.jsp" method="post" onsubmit="return chk()">
		<!--
			on...으로 시작하면 이벤트를 나타낸다.
			jsp/boardWritePorc.jsp로 내용을 전달 
			post로 보내면 캡슐화로 보내서 queryString이 생성되지않는다 
			name은 값을 찾아가는 키로 쓰인다 (id, class는 제외)
			label : 해당 대상을 클릭햇을때 focus가 가도록 하기 위해서 
			주로 체크박스 라디오박스에 많이 사용 (버튼을 누르기 힘들기 때문)
			submit명령어로 인해 자동으로 전송 / reset명령어로 인해 자동으로 내용 초기화
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
		<div class="div_button">
			<input type="submit" value="글 등록" >
			<input type="reset" value="다시 작성">
		</div>
		</form>
	</div>
	<script>
	// script 는 element를 가지고 놀기 때문에 아래쪽에 있는것이 좋다.( 내용을 가져와서 써야하기 때문에 )
	
		function eleValid(ele,cmt){
			if(ele.value.length==0)	{
				alert(cmt);
				ele.focus();
				return true;
			}	
		}
		function chk(){
			console.log(`title : \${frm.title.value}`);
			console.log(`ctnt : \${frm.ctnt.value}`);
			console.log(`i_student : \${frm.i_student.value}`);
			if(eleValid(frm.title,'제목')){
				return false;
			}else if(eleValid(frm.ctnt,'내용')){
				return false;
			}else if(eleValid(frm.i_student,'작성자')){
				return false;
			}else{
			}
			/* if(frm.title.value==''){
				alert('제목을 입력해 주세요')
				frm.title.focus(); // 커서를 title쪽으로 이동시키게 한다 
				return false;
			} else if(frm.ctnt.value.length==0){
				alert('내용을 입력해주세요');
				frm.ctnt.focus();
				return false;
			} */
			
		}
	</script>
</body>
</html>