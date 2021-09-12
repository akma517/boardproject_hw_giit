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
	/* 사전 작업 */
	request.setCharacterEncoding("utf-8");
	System.out.println("updateBoardAction 로직 진입");
	
	// 파라미터 받아오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardCategory = request.getParameter("boardCategory");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	
	// HTML에서 줄바꿈을 구현하기 위해 DB에 자바 기준 줄바꿈 문자를 HTML 줄바꿈 문자로 변환해서 넣어주기
	boardContent = boardContent.replaceAll("\r\n|\n", "<br>");	
	
	// 디버깅
	System.out.println("[debug] 게시글 번호 : " + boardNo);
	System.out.println("[debug] 게시글 카테고리 : " + boardCategory);
	System.out.println("[debug] 게시글 제목 : " + boardTitle);
	System.out.println("[debug] 게시글 내용 : " + boardContent);
	
	// DAO에서 수정 작업 수행
	BoardDao boardDao = new BoardDao();
	boardDao.updateBoard(boardNo, boardCategory, boardTitle, boardContent);
	
	// 수정된 게시글을 확인하기 위해 수정한 게시글 번호로 상세보기 페이지로 이동
	response.sendRedirect("./selectBoardOne.jsp?boardNo=" + boardNo);
	
	System.out.println("updateBoardAction 로직 종료");
%>
</body>
</html>