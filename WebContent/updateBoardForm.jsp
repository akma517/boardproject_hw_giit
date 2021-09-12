<%@page import="dao.BoardDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자바 송현우</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%
	/* 사전작업 */
	request.setCharacterEncoding("utf-8");
	System.out.println("updateBoardForm 로직 진입");
	
	// 방어 코드
	if (request.getParameter("boardNo") == null) {
		response.sendRedirect("./selectBoardList.jsp?currentPage=1");
		return;	
	}
	
	// 게시글 번호 받기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));

	// 디버깅
	System.out.println("[debug] 게시글 번호 : " + boardNo);
	
	
	// db 작업 위한 Dao 객체 생성
	BoardDao boardDao = new BoardDao();
	
	// 카테고리 받아오기
	ArrayList<String> boardCategoryList = boardDao.selectBoardCategoryList();
	
	// 넘겨받은 boardNo에 해당하는 게시글 받아오기
	Board board = boardDao.selectBoardOne(boardNo);
	
	// boardContent의 웹에 맞춰진 개행문자를 textArea에 맞게 변환
	String javaEscText = board.getBoardContent();
	board.setBoardContent(javaEscText.replaceAll("<br>", "\r\n"));	

%>
	<!-- 출력 -->
	<div class="container p-3 my-3 border">
	<h1 class="text-center">게시글 수정</h1>
		<form action="./updateBoardAction.jsp" method="post">	<!-- method="get" <<< default -->
			<div class="form-group">게시글 번호 : </div>
			<div class="form-group"><input type="text" name="boardNo" class="form-control" value="<%=board.getBoardNo() %>" readonly="readonly"></div>
			<div class="form-group">카테고리 : </div>
			<div class="form-group">
				<select name="boardCategory" class="form-control" >
			<%
				// 카테고리 노출
				for (String category : boardCategoryList){
			%>
					<option value="<%=category %>"><%=category %></option>
			<%
				}
			%>
				</select>
			</div>
			<div  class="form-group">제목 : </div>
			<div  class="form-group"><input name="boardTitle" class="form-control" type="text" value="<%=board.getBoardTitle() %>" /></div>
			<div class="form-group">내용 : </div>
			<div class="form-group"><textarea name="boardContent" class="form-control"" rows="5" cols="50" wrap="hard"><%=board.getBoardContent() %></textarea></div>
			<div class="text-right">
				<input type="submit" class="btn btn-outline-primary" value="글수정" />
				<input type="reset" class="btn btn-outline-danger" value="초기화"/>
			</div>
		</form>
	</div>
<%
	System.out.println("updateBoardForm 로직 종료");
%>
</body>
</html>