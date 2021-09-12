<%@page import="dao.CommentDao"%>
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
	System.out.println("deleteCommentAction 로직 진입");
	
	// 방어 코드
	if (request.getParameter("boardNo") == null || request.getParameter("commentNo") == null) {
		response.sendRedirect("./selectBoardList.jsp?currentPage=1");
		return;	
	}
	// 파라미터 받기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	// 디버깅
	System.out.println("[debug] 게시글 번호 : " + boardNo);
	System.out.println("[debug] 댓글 번호 : " + commentNo);
	
	// 댓글 삭제 작업 수행
	CommentDao commentDao = new CommentDao();
	commentDao.deleteComment(boardNo, commentNo);
	
	// list 페이지로 전환
	response.sendRedirect("./selectBoardOne.jsp?boardNo=" + boardNo);
	
	System.out.println("deleteCommentAction 로직 종료");
%>
</body>
</html>