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
    	//i_board값을 가져와서 그 번호의 내용을 수정해야하기 때문
    	
    	String strI_board = request.getParameter("i_board");
    	int i_board = Integer.parseInt(strI_board);
    	
    	
  	 	Connection conn = null;
   	    PreparedStatement ps= null;
   	    ResultSet rs = null;
   	    
   	 	String title = request.getParameter("title");
     	String ctnt = request.getParameter("ctnt");
   	 	String sql = "select title,ctnt from t_board where i_board=?";
   	 	try{
   	 		conn = getConn();
	    	ps = conn.prepareStatement(sql);
	    	ps.setInt(1,i_board); 
        	rs = ps.executeQuery();
        	while(rs.next()){
    			vo.setCtnt(rs.getString("ctnt"));
    			vo.setTitle(rs.getString("title"));
        	}
   	 	}catch(Exception e){
   	 		
   	 	}
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action = "boardModProc.jsp?i_board=<%=i_board%>" method="post">
	<input type = "hidden" name="i_board" value="<%=strI_board%>"> 
	<!-- 쿼리로 보내는 방식이 아닌 input 타입으로 보낸다 화면에는 hidden으로 보이지 않게 된다. --> 
		<div>
			<label>제목 : <input type="text" name="title" value="<%=vo.getTitle()%>"></label>
		</div>
		<div>
			<label>내용 : <textarea name="ctnt"><%=vo.getCtnt()%></textarea></label>
		</div>
		<!-- <div>
			<label>작성자 : <input type = "text" name="i_student"></label>
		</div> -->
		<div>
			<input type="submit" value="수정" >
		</div>
		<div>intI_board=<%=i_board%></div>
	</form>
</body>
</html>