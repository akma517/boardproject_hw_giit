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
	/* 사전 작업 */
	request.setCharacterEncoding("utf-8");
	System.out.println("insertMemberForm.jsp 로직 진입");

	/* 인증 방어 코드 : 로그인 전에만 페이지 열람 가능 */
	// 만약 로그인한 멤버가 insertMemberForm.jsp에 접근할 시, index.jsp 페이지로 강제 이동시킨다.
	Member member = (Member)session.getAttribute("loginMember");
	
	if (member != null) {
		response.sendRedirect("./index.jsp");
		System.out.println("[debug] insertMemberForm.jsp => index.jsp로 강제 이동: 이미 로그인한 멤버의 강제 접근을 막았습니다.");
		return; 
	}
	
%>
	<h1>회원가입</h1>
	<form method="post" action="./insertMemberAction.jsp">
		<div>ID : </div>
		<div><input type="text" name="memberId"></div>
		<div>비밀번호 : </div>
		<div><input type="password" name="memberPw"></div>
		<div>이름 : </div>
		<div><input type="text" name="memberName"></div>
		<div>나이 : </div>
		<div><input type="text" name="memberAge"></div>
		<div>성별 : </div>
		<div>
			<input type="radio" name="memberGender" value="남" checked="checked">
			<label for="memberGender">남</label>
			<input type="radio" name="memberGender" value="여">
			<label for="memberGender">여</label>
		</div>
		<div><input type="submit" value="회원가입"></div>
	</form>
<%
	System.out.println("insertMemberForm.jsp 로직 종료");
%>
</body>
</html>