<%@page import="dao.CommentDao"%>
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
	/* utf-8로 인코딩을 세팅해 준다. */
	request.setCharacterEncoding("utf-8");	
	System.out.println("insertCommentAction 로직 진입");
	
	/* 인자값 받기 */
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String commentContent = request.getParameter("commentContent");

	
	// DB에 줄바꿈 문자를 넣어주기 위해 변환
	commentContent = commentContent.replaceAll("\r\n|\n", "<br>");
	
	// 디버깅
	System.out.println("[debug] 댓글을 단 게시글의 번호 : " + boardNo);
	System.out.println("[debug] 댓글 내용 : " + commentContent);
	
	// 댓글을 삭제하는 작업 수행
	CommentDao commentDao = new CommentDao();
	commentDao.insertComment(boardNo, commentContent);
	
	response.sendRedirect("./selectBoardOne.jsp?boardNo=" + boardNo);
	
	System.out.println("insertCommentAction 로직 종료");
%>
</body>
</html>