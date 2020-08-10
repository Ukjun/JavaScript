<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.util.*" %>
    <%@ page import = "com.koreait.web.BoardVO" %>
    <%!
    	
    	private Connection getConn()throws Exception{
    		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
    		String username = "hr";
    		String password = "koreait2020";
    		
    		Class.forName("oracle.jdbc.driver.OracleDriver");
    		Connection conn = DriverManager.getConnection(url,username,password);
  
    		System.out.println("접속 성공");
    		return conn;
    	}
    	BoardVO vo = new BoardVO();
    %>
    <%
    request.setCharacterEncoding("UTF-8");
    
    String title = request.getParameter("title");
    String ctnt = request.getParameter("ctnt");
    
    
    String strI_board = request.getParameter("i_board");
    
    
    int intI_board = Integer.parseInt(strI_board);
    
    
    Connection conn = null;
    PreparedStatement ps= null;
   
    String sql = "update t_board set title=?,ctnt=? where i_board="+intI_board;
    int result = 0;
    
    try{
    	conn = getConn();
    	ps = conn.prepareStatement(sql);
        ps.setString(1,title);
        ps.setString(2,ctnt);
        //ps.setString(3,strI_student);
        result = ps.executeUpdate();  
       	
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
    int err=0;
    switch(result){
    case 1:
    	response.sendRedirect("/jsp/boardList.jsp");
    	return; 
    case 0:
    	err = 10;
    	break;
    case -1:
    	err = 20;
    	break;
    }
    response.sendRedirect("/jsp/boardMod.jsp?err=" + err);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html>