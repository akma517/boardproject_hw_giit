<%@page import="dao.MemberDao"%>
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
	/* 사전작업 */
	request.setCharacterEncoding("utf-8");
	System.out.println("updateMemberPwForm.jsp 로직 진입");
	
	/* 인증 방어 코드 : 로그인 전에만 페이지 열람 가능 */
	// 만약 로그인하지 않은 멤버가 updateMemberPwForm.jsp에 접근하려고 할 시, index.jsp 페이지로 강제 이동시킨다.
	Member member = (Member)session.getAttribute("loginMember");
	
	if (member == null) {
		response.sendRedirect("./index.jsp");
		System.out.println("[debug] updateMemberPwForm.jsp => index.jsp로 강제 이동: 로그인하지 않은 멤버의 강제 접근을 막았습니다.");
		return; 
	}
			
%>
	<h1>비밀번호 수정</h1>
	<form method="post" action="./updateMemberPwAction.jsp">
		<div>현재 비밀번호 : </div>
		<div><input type="password" name="memberPw"></div>
		<div>새로운 비밀번호 : </div>
		<div><input type="password" name="memberPwNew"></div>
		<div><input type="submit" value="비밀번호 수정"></div>
	</form>
<%
	System.out.println("updateMemberPwForm.jsp 로직 종료");
%>
</body>
</html>