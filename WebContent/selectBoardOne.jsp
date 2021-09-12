<%@page import="dao.CommentDao"%>
<%@page import="dao.BoardDao"%>
<%@page import="vo.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자바 송현우</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container p-3 my-3">
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
			<a class="navbar-brand" href="./selectBoardList.jsp">전체보기</a>
		<%
		
			/* 사전작업 */
			request.setCharacterEncoding("utf-8");
			System.out.println("slelectBoardOne 로직 진입");
			
			// 디버깅용 기본값 설정
			int boardNo = 1;
		
			if (request.getParameter("boardNo") != null) {
				boardNo = Integer.parseInt(request.getParameter("boardNo"));
			}		
			
			// db 작업 위한 Dao 객체 생성
			BoardDao boardDao = new BoardDao();
			
			// 카테고리 받아오기
			ArrayList<String> boardCategoryList = boardDao.selectBoardCategoryList();
			
			// 넘겨받은 boardNo에 해당하는 게시글을 받아오기
			Board board = boardDao.selectBoardOne(boardNo);
			
			// 카테고리 노출
			for (String category : boardCategoryList){
		%>
				<a class="navbar-brand" href="./selectBoardList.jsp?boardCategory=<%=category %>"><%=category %></a>
		<%
			}
		%>
		</nav>
		<div class="jumbotron">
			<h1>게시글 상세 보기</h1>
		</div>
		<!-- 저장된 보드 객체의 데이터를 노출 -->
		<!-- th 너비 조절(https://stackoverflow.com/questions/15115052/how-to-set-up-fixed-width-for-td) -->
		<!-- th,td 가운데 정렬(https://frhyme.github.io/others/text_align_bootstrap/) -->
		<table class="table">
			<thead class="thead-light">	
				<tr class="align-content-center">
					<th class="text-center" style="width: 15%"><%=board.getBoardNo() %></th>
					<th class="text-center" style="width: 70%" colspan="3"><%=board.getBoardTitle() %></th>
					<th class="text-center" style="width: 15%" ><%=board.getBoardCategory() %></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<!-- 게시글 내용이 적어도 최소 크기를 유지할 수 있도록(필요 이상의 들쑥날쑥한 화면 방지) -->
					<td class="text-justify" colspan="5" style="height: 400px"><%=board.getBoardContent() %></td>	
				</tr>
				<tr>
					<td class="text-right" colspan="5">
						<%=board.getBoardDate() %><br>
						<a href="./updateBoardForm.jsp?boardNo=<%=board.getBoardNo()%>" class="btn btn-outline-primary btn-sm">수정</a>
						<a href="./deleteBoardAction.jsp?boardNo=<%=board.getBoardNo()%>" class="btn btn-outline-danger btn-sm">삭제</a>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- 댓글 파트 -->
		<div>
			<form action="./insertCommentAction.jsp" metohd="post">
				<input type="hidden" name="boardNo" value="<%=boardNo %>">
				<div class="form-group">
					<label for="comment">Comment:</label>
					<textarea name="commentContent" rows="5" class="form-control"></textarea>
				</div>
				<div class="text-right">
					<button class="btn btn-outline-primary">댓글입력</button>
				</div>
			</form>
		</div>
		<br>
		<!-- 댓글목록 출력, 10개씩 페이징~ -->
		<div>
		<%
			/* 댓글 페이징 작업 */
			// 페이지 초기값 설정
			int commentCurrentPage = 1;
			
			// 페이지 인자값이 있으면 그것을 사용
			if (request.getParameter("commentCurrentPage") != null) {
				commentCurrentPage = Integer.parseInt(request.getParameter("commentCurrentPage"));
			}
			
			/* 노출될 댓글 페이징 */
			int commentRowPerPage = 10;
			int commentBeginRow = (commentCurrentPage-1) * commentRowPerPage; 
		
			// db 작업 위한 Dao 객체 생성
			CommentDao commentDao = new CommentDao();
			
			// 게시글에 달린 댓글 리스트 받아오기
			ArrayList<Comment> commentList = commentDao.selectCommentListByPage(board.getBoardNo(), commentBeginRow, commentRowPerPage);
			
			// 게시글에 달린 댓글 리스트의 수 받아오기
			int countComment = commentDao.selectCountComment(commentRowPerPage, board.getBoardNo());

			
		%>
		<!-- tr의 테두리 부분 넣기위한 속성) talbe:style="border-collapse: collapse" -->
		<!-- tr의 테두리 부분 넣기위한 속성) tr:style="border-bottom: 1px solid grey" -->
		<!-- 참고한 사이트(https://roqkfrhdqngkwk.tistory.com/28) -->
		<table class="table table-borderless" style="border-collapse: collapse">
			<thead>
				<tr  style="border-bottom: 2px solid black">
					<th class="text-left" style="width: 80%" ><h2>댓글목록</h2></th>
					<th class="text-right" style="width: 20%"><%=countComment %>개</th>
				</tr>
			</thead>
			<tbody>
		<%
			for(Comment c :commentList){
		%>
				<tr style="border-bottom: 1px solid grey">
					<td class="text-left">
						<h3><small><%=c.getCommentContent()%></small></h3>
					</td>
					<td class="text-right">
						<%=c.getCommeantDate()%>&nbsp;
						<a href="./deleteCommentAction.jsp?boardNo=<%=board.getBoardNo()%>&commentNo=<%=c.getCommentNo()%>" class="btn btn-outline-danger btn-sm">삭제</a>
					</td>
				</tr>
		<%
			}
		%>
			</tbody>
		</table>
		<!-- 네비게이션 페이징 스타일 적용  -->	
		<ul class="nav justify-content-center">
		<%		
			/* 4) 네비게이션 댓글 페이징 */
			
			// 댓글 페이징 범위 구하기
			int commentLastPage = countComment /commentRowPerPage;				// 한 페이지당 10개(rowPerPage)씩 담았을 때 생성될 마지막 페이지 계산
			int commentDisplayRangePage = 10;								// 화면 밑단에 보일 네비게이션 페이징 범위 단위값
			
			int commentRangeStartPage = ((commentCurrentPage / commentDisplayRangePage) * commentDisplayRangePage);			// 현 페이징 범위 시작 숫자를 계산
			int commentRangeEndPage = ((commentCurrentPage / commentDisplayRangePage) * commentDisplayRangePage) + commentDisplayRangePage;		// 현 페이징 범위 끝 숫자를 계산
			
			
			// 10페이지가 클릭되어도 네비게이션 페이징이 다음 범위로 이동하지 않기 위한 조건문 
			if ((commentCurrentPage % commentDisplayRangePage) == 0) {
				commentRangeStartPage -= commentDisplayRangePage;
				commentRangeEndPage -= commentDisplayRangePage;
			}
			
			// 마지막 페이지 정확히 계산
			if (countComment % commentDisplayRangePage != 0 ) {							
				commentLastPage += 1;
			}
			
			// 페이징 범위 끝 숫자가 마지막 페이지 보다 더 크면 페이징 범위 끝 숫자를 마지막 페이지로 바꿈 (다음 버튼 노출 안 시키기 위해)
		    if(commentRangeEndPage >= commentLastPage ) {
		    	commentRangeEndPage = commentLastPage; 
		     }
			
		    // 디버깅용
		    System.out.println("[debug] 현재 댓글 페이지 : " + commentCurrentPage);
		    System.out.println("[debug] 마지막 댓글 페이지 : " + commentLastPage);
		    System.out.println("[debug] 댓글 페이징 범위 단위값 : " + commentDisplayRangePage);
		    System.out.println("[debug] 댓글 페이징 시작 범위 숫자 : " + (commentRangeStartPage+1));
		    System.out.println("[debug] 댓글 페이징 끝 범위 숫자 : " + commentRangeEndPage);
		    System.out.println("[debug] 총 댓글 개수 : " + countComment);	
		    
		    // 현재 페이지 범위가 네비게이션 페이징 범위 단위값 이상일 경우에만 이전 버튼을 노출(이전 버튼이 노출되어야 할 상황에만 노출시키기 위해)
			if( commentRangeStartPage > (commentDisplayRangePage - 1) ) {	
		%>
				<!-- &nbsp;는 HTML에서 띄어쓰기 특수문자 -->
				<!-- 쿼리스트링을 넘길 때에는 초기값은 "?", 그 뒤의 다른 값들이 있다면 "&"로 붙이며 사용한다. -->
				<a href="./selectBoardOne.jsp?commentCurrentPage=<%=1%>&boardNo=<%=board.getBoardNo() %>">&nbsp;처음으로&nbsp;</a>
				<a href="./selectBoardOne.jsp?commentCurrentPage=<%=commentRangeStartPage-9%>&boardNo=<%=board.getBoardNo() %>">&nbsp;이전&nbsp;</a>
		<%
			}
		    
			// 현 페이지의 페이징 범위에 맞는 네비게이션 버튼을 노출
			for (int i = commentRangeStartPage+1; i < commentRangeEndPage+1; i++) {				
		%>	
				<a href="./selectBoardOne.jsp?commentCurrentPage=<%=i%>&boardNo=<%=board.getBoardNo() %>">&nbsp;<%=i%>&nbsp;</a>
		<%		
			}
			
			// 현재 페이지 범위가 총 페이지 개수의 마지막 개수보다 작을 경우에만 다음 버튼을 노출(다음 버튼이 노출되어야 할 상황에만 노출시키기 위해)
			if((commentRangeEndPage) < commentLastPage) {
		%>
				<a href="./selectBoardOne.jsp?commentCurrentPage=<%=commentRangeStartPage+11%>&boardNo=<%=board.getBoardNo() %>">&nbsp;다음&nbsp;</a>
				<a href="./selectBoardOne.jsp?commentCurrentPage=<%=commentLastPage%>&boardNo=<%=board.getBoardNo() %>">&nbsp;끝으로&nbsp;</a>
		<%
			}
		%>
		</ul class="nav justify-content-center">
		</div>
	</div>
<%
	System.out.println("slelectBoardOne 로직 종료");
%>
</body>
</html>