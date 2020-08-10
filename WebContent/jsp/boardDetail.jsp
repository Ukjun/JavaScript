<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.util.*" %>
    <%@ page import = "com.koreait.web.BoardVO" %>
    <%!
    	//!차이 : 변수가 지역변수 > 전역변수 
    	// <%... :스크립트릿(Scriptlet)태그
    	private Connection getConn()throws Exception{
    		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
    		String username = "hr";
    		String password = "koreait2020";
    		
    		Class.forName("oracle.jdbc.driver.OracleDriver");
    		Connection conn = DriverManager.getConnection(url,username,password);
    		//staic메소드 이므로 클래스.메소드로 사용가능
    		//파라미터 들어오는것으로 처리가 가능할때만 사용(속도가 빠르고 사용하기가 편하다)
    		System.out.println("접속 성공");
    		return conn;
    	}
    	BoardVO vo = new BoardVO();
    %>
    <%
    Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
    String strI_board = request.getParameter("i_board"); // boardDetail에서 원하는 값 (request로 넘어오는 인자가 원하는 값이다ㅁ)
    if(strI_board==null){
    	%>
    		<script>
    		alert("잘못된 접근");
    		location.href='/jsp/boardList.jsp';
    		</script>
    	<% 		
    	return;
    }
    int intI_board= Integer.parseInt(strI_board);
    String sql = "select title,ctnt,i_student from t_board where i_board= ?"; 
    // 일반적인 sql문
    //String sql = "select a.title, a.ctnt, a.i_student, b.nm from t_board A join t_student B on A.i_student = b.i_student where i_board = " + strI_board;
    // join문까지 사용
    //String name ="";
    try{
		conn = getConn();
		ps = conn.prepareStatement(sql);
		ps.setInt(1,intI_board); 
		rs = ps.executeQuery();
		while(rs.next()){
			vo.setCtnt(rs.getString("ctnt"));
			vo.setTitle(rs.getString("title"));
			vo.setI_student(rs.getInt("i_student"));
		//	name = rs.getString("nm");
			///... ////
		}
    }catch(Exception e){
		e.printStackTrace();
	}finally{
		if(rs!=null){
			try{
				rs.close();
			}catch(Exception e){}
		}
		if(ps!=null){
			try{
				ps.close();
			}catch(Exception e){}
		}
		if(conn!=null){
			try{
				conn.close();
			}catch(Exception e){}
		}
	}
    
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.menu{
		display : inline-block;
		border : 1px solid #fff;
	}
	
	.menu a{
		
	}
	.container{
	text-align : center;
	margin : 0 auto;
	}
	
	.container h2{
		margin-top: 50px;
		color : #FF0040;'
	}
</style>
</head>
<body>
	<div class="container">
		<div><h2>상세 페이지: <%=strI_board %></h2></div>
		<div><p>제목 : <%=vo.getTitle()%></p></div>
		<div><p>내용 : <%=vo.getCtnt()%></p></div>
		<div><p>작성자 : <%=vo.getI_student()%></p></div>
		
		<div class="menu">
			<a href ="/jsp/boardList.jsp">리스트로 가기</a>
			<a href = "#" onclick ="preDel(<%=intI_board %>)">삭제</a>
			<a href="/jsp/boardMod.jsp?i_board=<%=intI_board%>">수정</a>
		</div>
	</div>
	<script>
		function preDel(intI_board){
			if(confirm("삭제하시겠습니까?")){
				location.href="/jsp/boardDel.jsp?intI_board=" + intI_board;
			}
		}
	</script>
</body>
</html>