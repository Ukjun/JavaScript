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
    %>
    <%
    	// 데이터베이스 연결부분
    	// 지역변수는 살아있는 범위가 코드에 미치는 영향이 매우 크다
    	List<BoardVO> boardList = new ArrayList();
    
    	Connection conn = null;
    	PreparedStatement ps = null;
    	ResultSet rs = null;
    	
    	String sql = " select i_board, title,ctnt, i_student from t_board ";
    	
    	
    	try{
    		conn = getConn();
    		ps = conn.prepareStatement(sql);
    		rs = ps.executeQuery(); //select문일때는 이메소드를 사용 dml언어일때는 excuteUpdate()사용
    		
    		while(rs.next()){
    			// 해당 레코드의 내용이 있다면 true 없다면 false
    			int i_board = rs.getInt("i_board");
    			String title = rs.getString("title");
    			//String ctnt = rs.getString("ctnt");
    			//int i_student = rs.getInt("i_student");
    			BoardVO vo = new BoardVO();
    			//반복문 밖에있으면 주소값은 한곳만 가르켜서 값이 한개만 반복적으로 뜬다.
    			
    			vo.setI_board(i_board);
    			vo.setTitle(title);
    			//vo.setCtnt(ctnt);
    			//vo.setI_student(i_student);
    			
    			boardList.add(vo);
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}finally{
    		// 열었으면 꼭 닫아야된다 닫는 순서는 스택처럼 
    		// 맨마지막에 열린것이 먼저 닫힌다
    		// 동시에 뭉쳐놧을 경우 예외가 터졌을 경우 다른부분이 안닫힐 경우가 있기때문에 따로 분리해서 닫는다
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
</head>
<style>
	h1{
		text-align : center;
		color : #ffccff;
		margin : 0 auto;
	}
	table{
		width : 400px;
		margin : 10px;
		padding : 10px;
		border-collapse : collapse;
		text-align : center;
		margin : 0 auto;
		font-size : 1.5em;
	}
</style>
<body>
	<div><h1>게시판 리스트</h1></div>
	<table border=1  >
		<tr>
			<th>NO</th>
			<th>제목</th>
		</tr>
		<%
			for(BoardVO vo : boardList){
		%>
		<tr>
			<td><%= vo.getI_board() %></td>
			<td><a href="/jsp/boardDetail.jsp?i_board=<%=vo.getI_board() %>">
			<%= vo.getTitle() %>
			</a>
			<!-- 
				get 방식(속도) , post방식(보안)
				? > query시작 
			 	ex) http://localhost:8089/jsp/boardDetail.jsp?i_board=3
			 	-> 리스트를 클릭했을때 그 항목의 i_board값을 적는다
			--> 
		</tr>
		<%}%>
		<%
			
		%>
	</table>
</body>
</html>