<%@page import="dao.BoardDao"%>
<%@page import="vo.Board"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자바 송현우</title>
</head>
<body>
<%
	/* 사전작업 */
	request.setCharacterEncoding("utf-8");	/* utf-8로 인코딩을 세팅해 준다. */
	System.out.println("insertBoardAction 로직 진입");
	
	/* 인자값 받기 */
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardCategory = request.getParameter("boardCategory");
	
	// DB에 줄바꿈 문자를 넣어주기 위해 변환
	boardContent = boardContent.replaceAll("\r\n|\n", "<br>");
	
	// 디버깅
	System.out.println("[debug] 제목 : " + boardTitle);
	System.out.println("[debug] 내용 : " + boardContent);
	System.out.println("[debug] 카테고리 : " + boardCategory);
	
	// DAO에서 db 삽입 작업 수행
	BoardDao boardDao = new BoardDao();
	boardDao.insertBoard(boardTitle, boardContent, boardCategory);
	
	response.sendRedirect("./selectBoardList.jsp");
	
	System.out.println("insertBoardAction 로직 종료");
%>
</body>
</html>