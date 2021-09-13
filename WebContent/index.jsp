<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자바 송현우</title>
</head>
<body>
<h1>홈페이지</h1>
<%
	request.setCharacterEncoding("utf-8");
	System.out.println("index.jsp 로직 진입");	

	// session은 참조 타입만 들어간다.
	if(session.getAttribute("loginMember") == null) {
%>
	<!-- 로그인 전 -->
	<div><a href="./loginForm.jsp">로그인</a></div>
	<div><a href="./insertMemberForm.jsp">회원가입</a></div>
<%
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
%>
	<!-- 로그인 후 -->
		<div><%=loginMember.getMemberName() %>님 반갑습니다.<a href="./logOut.jsp">로그아웃</a></div>
		<div><a href="./selectMemberOne.jsp">회원정보</a></div>
<%
	}
%>
<div><a href="./selectBoardList.jsp">게시판</a></div>

<%
	System.out.println("index.jsp 로직 종료");	
%>
</body>
</html>