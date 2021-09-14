<!-- deleteBoardAction-->

<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자바 송현우</title>
</head>
<body>
<%
	/* 사전작업 */
	request.setCharacterEncoding("utf-8");
	System.out.println("deleteBoardAction 로직 진입");
	
	// 방어 코드
	if (request.getParameter("boardNo") == null) {
		response.sendRedirect("./selectBoardList.jsp?currentPage=1");
		return;	
	}
	
	// 게시글 번호 받기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	
	// 디버깅
	System.out.println("[debug] 게시글 번호 : " + boardNo);
	
	// 게시글 삭제 작업 수행
	BoardDao boardDao = new BoardDao();
	boardDao.deleteBoard(boardNo);
	
	// list 페이지로 전환
	response.sendRedirect("./selectBoardList.jsp?currentPage=1");
	
	System.out.println("deleteBoardAction 로직 종료");
%>
</body>
</html>