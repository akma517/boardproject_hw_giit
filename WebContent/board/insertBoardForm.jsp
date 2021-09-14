<%@page import="dao.BoardDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
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
		System.out.println("insertBoardForm 로직 진입");
		
		// db 작업 위한 Dao 객체 생성
		BoardDao boardDao = new BoardDao();
		
		// 카테고리 받아오기
		ArrayList<String> boardCategoryList = boardDao.selectBoardCategoryList();
%>
	<div class="container p-3 my-3 border">
		<h1 class="text-center">게시글 입력</h1>
		<form action="./insertBoardAction.jsp" method="post">	<!-- method="get" <<< default -->
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
			<div  class="form-group"><input name="boardTitle" class="form-control" type="text" /></div>
			<div class="form-group">내용 : </div>
			<div class="form-group"><textarea name="boardContent" class="form-control" rows="5" cols="50" wrap="hard"></textarea></div>
			<div class="text-right">
				<input type="submit" class="btn btn-outline-primary " value="글입력" />
				<input type="reset" class="btn btn-outline-danger" value="초기화"/>
			</div>
		</form>
	</div>
<%
	System.out.println("insertBoardForm 로직 종료");
%>
</body>
</html>