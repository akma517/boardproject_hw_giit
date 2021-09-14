<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.Board" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자바 송현우</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- 꿀팁: ctr + shift + f 누르면 자동 정렬됨 -->
	<!-- 꿀팁: sql 쿼리문에서 distinct 사용은 권장하지 않음(속도가 매우 느림) 모든 행을 훑기 때문 -->
	<!-- 꿀팁: F2를 누르면 파일의 이름을 바꿀 수 있음 -->
	<!-- 꿀팁:  null과 "null"은 다르다.(주의할 것)(boolean값도 마찬가지, 인자값을 넘길때는 언제나 주의) -->
	<!-- 어려워 -->
	<!-- container-fluid 옵션을 주면 중앙집중형이 아닌 와이드 형태의 container로 만들어줌 -->
	<div class="container">
		<!-- body를 건들이지 않고 이를 대신할 div를 컨테이너로 함 -->
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
			<a class="navbar-brand" href="./selectBoardList.jsp">전체보기</a>
		<%
		
			/* 사전작업 */
			request.setCharacterEncoding("utf-8");
			System.out.println("slelectBoardList 로직 진입");
			
			
			// 기본 카테고리값 all로 설정
			String displayCategory = "ALL";
			
			// 카테고리 인자값이 있으면 그것을 카테고리로 사용
			if(request.getParameter("boardCategory") != null){
				displayCategory = request.getParameter("boardCategory");
			}
			
			System.out.println("[debug] 카테고리값 : " + displayCategory);
			
			/* 페이징 작업 */
			// 페이지 기본값 설정
			int currentPage = 1;
			
			// 페이지 인자값이 있으면 그것을 사용
			if (request.getParameter("currentPage") != null) {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}
			
			/* 노출될 게시글 페이징 */
			// beginRow의 값은 db 결과값이 0행부터 시작이므로 currentPage에서 -1을 해주고 rowPerPage를 곱해준다. 
			int rowPerPage = 10;
			int beginRow = (currentPage-1) * rowPerPage; 
			
			// db 작업 위한 Dao 객체 생성
			BoardDao boardDao = new BoardDao();
			
			// 카테고리 받아오기
			ArrayList<String> boardCategoryList = boardDao.selectBoardCategoryList();
			
			// 게시글 리스트 받아오기
			ArrayList<Board> boardList = boardDao.selectBoardListByPage(beginRow, rowPerPage, displayCategory);
			
			// 카테고리 검색조건에 맞는 게시글 수 받아오기
			int countDisplay = boardDao.selectCountDisplay(rowPerPage, displayCategory);
			
			// 카테고리 노출
			for (String category : boardCategoryList){
		%>
				<a class="navbar-brand" href="./selectBoardList.jsp?boardCategory=<%=category %>"><%=category %></a>
		<%
			}
		%>
		</nav>
		<div class="jumbotron">
			<h1>게시글 목록</h1>
				<div>
					<p>
						csharp, html, java
					</p>
					<h3>카테고리: <%=displayCategory %></h3>
					<h4>총 게시글 수:<%=countDisplay %></h4>
					<h4>현 페이지:<%=currentPage %></h4>
					<a href="./insertBoardForm.jsp" class="btn btn-primary">글입력</a>
				</div>
		</div>
		<table class="table table-bordered">
			<thead class="thead-light ">
				<tr>
					<th class="text-center" style="width: 20%" >게시글 카테고리</th>
					<th class="text-center" style="width: 80%">게시글 제목</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(Board b:boardList){
			%>
				<tr>
					<td class="text-center"><%=b.getBoardCategory()%></td>
					<td class="text-center"><a href="./selectBoardOne.jsp?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a></td>
				</tr>
			<%
				}
			%>
			</tbody>
		</table>
		<!-- 네비게이션 페이징 스타일 적용  -->	
		<ul class="nav justify-content-center">
		<%		
			/* 네비게이션 페이징 */
			
			// 페이징 범위 구하기
			int lastPage = countDisplay /rowPerPage;				// 한 페이지당 10개(rowPerPage)씩 담았을 때 생성될 마지막 페이지 계산
			int displayRangePage = 10;								// 화면 밑단에 보일 네비게이션 페이징 범위 단위값
			
			int rangeStartPage = ((currentPage / displayRangePage) * displayRangePage);			// 현 페이징 범위 시작 숫자를 계산
			int rangeEndPage = ((currentPage / displayRangePage) * displayRangePage) + displayRangePage;		// 현 페이징 범위 끝 숫자를 계산
			
			
			// 10페이지가 클릭되어도 네비게이션 페이징이 다음 범위로 이동하지 않기 위한 조건문 
			if ((currentPage % displayRangePage) == 0) {
				rangeStartPage -= displayRangePage;
				rangeEndPage -= displayRangePage;
			}
			
			// 마지막 페이지 정확히 계산
			if (countDisplay % displayRangePage != 0 ) {							
				lastPage += 1;
			}
			
			// 페이징 범위 끝 숫자가 마지막 페이지 보다 더 크면 페이징 범위 끝 숫자를 마지막 페이지로 바꿈 (다음 버튼 노출 안 시키기 위해)
		    if(rangeEndPage >= lastPage ) {
		        rangeEndPage = lastPage; 
		     }
			
		    // 디버깅용
		    System.out.println("[debug] 현재 페이지 : " + currentPage);
		    System.out.println("[debug] 마지막 페이지 : " + lastPage);
		    System.out.println("[debug] 페이징 범위 단위값 : " + displayRangePage);
		    System.out.println("[debug] 페이징 시작 범위 숫자 : " + (rangeStartPage+1));
		    System.out.println("[debug] 페이징 끝 범위 숫자 : " + rangeEndPage);
		    System.out.println("[debug] 총 게시글 개수 : " + countDisplay);	
		    
		    // 현재 페이지 범위가 네비게이션 페이징 범위 단위값 이상일 경우에만 이전 버튼을 노출(이전 버튼이 노출되어야 할 상황에만 노출시키기 위해)
			if( rangeStartPage > (displayRangePage - 1) ) {	
		%>
				<!-- &nbsp;는 HTML에서 띄어쓰기 특수문자 -->
				<!-- 쿼리스트링을 넘길 때에는 초기값은 "?", 그 뒤의 다른 값들이 있다면 "&"로 붙이며 사용한다. -->
				<a href="./selectBoardList.jsp?currentPage=<%=1%>&boardCategory=<%=displayCategory %>">&nbsp;처음으로&nbsp;</a>
				<a href="./selectBoardList.jsp?currentPage=<%=rangeStartPage-9%>&boardCategory=<%=displayCategory %>">&nbsp;이전&nbsp;</a>
		<%
			}
		    
			// 현 페이지의 페이징 범위에 맞는 네비게이션 버튼을 노출
			for (int i = rangeStartPage+1; i < rangeEndPage+1; i++) {				
		%>	
				<a href="./selectBoardList.jsp?currentPage=<%=i%>&boardCategory=<%=displayCategory %>">&nbsp;<%=i%>&nbsp;</a>
		<%		
			}
			
			// 현재 페이지 범위가 총 페이지 개수의 마지막 개수보다 작을 경우에만 다음 버튼을 노출(다음 버튼이 노출되어야 할 상황에만 노출시키기 위해)
			if((rangeEndPage) < lastPage) {
		%>
				<a href="./selectBoardList.jsp?currentPage=<%=rangeStartPage+11%>&boardCategory=<%=displayCategory %>">&nbsp;다음&nbsp;</a>
				<a href="./selectBoardList.jsp?currentPage=<%=lastPage%>&boardCategory=<%=displayCategory %>">&nbsp;끝으로&nbsp;</a>
		<%
			}
		%>
		</ul class="nav justify-content-center">
	</div>
<%
	System.out.println("slelectBoardList 로직 종료");
%>
</body>
</html>