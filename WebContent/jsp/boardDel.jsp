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
    	List<BoardVO> boardlist = new ArrayList<>();
    
    	String sql = "delete from t_board where i_board= ?";
    	//자바에서 쿼리문을 실행하는것은 자동커밋이 되어있다.
		String strI_board = request.getParameter("intI_board");
    	 	
    	
    	
	    int intI_board= Integer.parseInt(strI_board);
	   
   	 	Connection conn = null;
		PreparedStatement ps = null;
	    
	    int count =-1;
	    
	    
		try{
			conn = getConn();
			ps = conn.prepareStatement(sql);
			ps.setInt(1,intI_board);
			count = ps.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
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
		
		switch(count){
		case -1:
			response.sendRedirect("/jsp/boardDetail.jsp?err=-1&i_board = "+ intI_board);
			break;
		case 0:
			response.sendRedirect("/jsp/boardDetail.jsp?err=0&i_board = "+ intI_board);
			break;
		case 1:
			response.sendRedirect("/jsp/boardList.jsp");
			break;
		}
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div><%=count%></div>
	<script>
		alert("정상적으로 삭제되었습니다.")
	</script>
	
</body>
</html>