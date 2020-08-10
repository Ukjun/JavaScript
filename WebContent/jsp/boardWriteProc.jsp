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
    request.setCharacterEncoding("UTF-8");
    //한글 깨짐 방지 명령어 
    // web.xml에 설정파일을 추가하면 굳이 일일히 추가하지 않아도 된다.
    String title = request.getParameter("title");
    String ctnt = request.getParameter("ctnt");
    String strI_student = request.getParameter("i_student");
    
    
    if("".equals(title)||"".equals(ctnt)||"".equals(strI_student)){
    	response.sendRedirect("boardWrite.jsp?err=10");
    	return;
    }
    
    // boardWriteProc에서 원하는 값 title, ctnt, strI_student
    Connection conn = null;
    PreparedStatement ps= null;
   
    String sql = "insert into t_board(i_board, title,ctnt, i_student) "+
    		"select nvl(max(i_board),0)+ 1,?,?,? from t_board";
    int result = -1;
    
    try{
    	conn = getConn();
    	ps = conn.prepareStatement(sql);
        ps.setString(1,title);
        ps.setString(2,ctnt);
        ps.setString(3,strI_student);
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
    	return; // 메소드가 종료 (switch문이 종료되지않는다.)
    case 0:
    	err = 10;
    	break;
    case -1:
    	err = 20;
    	break;
    }
    response.sendRedirect("boardWrite.jsp?err=" + err);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>title : <%=title %></div>
<div>ctnt : <%=ctnt %></div>
<div>strI_student : <%=strI_student%></div>
<a href="/jsp/boardList.jsp">리스트로 이동</a>
</body>
</html>