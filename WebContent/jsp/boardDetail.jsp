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
    String strI_board = request.getParameter("i_board");
    //String sql = "select title,ctnt,i_student from t_board where i_board = " + strI_board;
    String sql = "select a.title, a.ctnt, a.i_student, b.nm from t_board A join t_student B on A.i_student = b.i_student where i_board = " + strI_board;
    String name ="";
    try{
		conn = getConn();
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		while(rs.next()){
			vo.setCtnt(rs.getString("ctnt"));
			vo.setTitle(rs.getString("title"));
			vo.setI_student(rs.getInt("i_student"));
			name = rs.getString("nm");
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
</head>
<body>
	<div>
		<h2>상세 페이지: <%=strI_board %></h2>
		<p><%=vo.getCtnt()%></p>
		<p><%=vo.getTitle()%></p>
		<p><%=vo.getI_student()%></p>
		<p>Writer : <%=name%></p>
	</div>
</body>
</html>