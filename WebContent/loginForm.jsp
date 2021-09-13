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
<%
	/* 인증 방어 코드 : 로그인 전에만 페이지 열람 가능 */
	// 만약 로그인한 멤버가 loginForm.jsp에 접근하려고 할 시, index.jsp 페이지로 강제 이동시킨다.
	Member member = (Member)session.getAttribute("loginMember");
	
	System.out.println("loginForm.jsp 로직 진입");	
	
	if (member != null) {
		response.sendRedirect("./index.jsp");
		System.out.println("[debug] lgoinForm.jsp => index.jsp로 강제 이동: 이미 로그인한 멤버의 강제 접근을 막았습니다.");
		return; 
	}
	
%>
	<h1>로그인</h1>
	<form method="post" action="./loginAction.jsp">
		<div>MemberId : </div>
		<div><input type="text" name="memberId"></div>
		<div>MemberPw : </div>
		<div><input type="password" name="memberPw"></div>
		<div><input type="submit" value="로그인"></div>
	</form>
<%
	System.out.println("loginForm.jsp 로직 종료");
%>
</body>
</html>