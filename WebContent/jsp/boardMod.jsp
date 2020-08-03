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
    	String strI_board = request.getParameter("i_board");
   		int intI_board = Integer.parseInt(strI_board);
    	Connection conn = null;
    	PreparedStatement ps= null;
    	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action = "/jsp/boardModProc.jsp?i_board=<%=intI_board%>" method="post">
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
			<a href ="/jsp/boardWrite.jsp?i_board=<%=intI_board %>"><button>수정</button></a>
		</div>
		<div><%=intI_board %></div>
	</form>
</body>
</html>