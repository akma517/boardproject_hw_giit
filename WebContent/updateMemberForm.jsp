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
	System.out.println("updateMemberForm.jsp 로직 진입");
	
	/* 인증 방어 코드 : 로그인 전에만 페이지 열람 가능 */
	// 만약 로그인하지 않은 멤버가 updateMemberForm.jsp에 접근하려고 할 시, index.jsp 페이지로 강제 이동시킨다.
	Member member = (Member)session.getAttribute("loginMember");
	
	if (member == null) {
		response.sendRedirect("./index.jsp");
		System.out.println("[debug] updateMemberForm.jsp => index.jsp로 강제 이동: 로그인하지 않은 멤버의 강제 접근을 막았습니다.");
		return; 
	}
			
	// db 작업 위한 Dao 객체 생성
	MemberDao memberDao = new MemberDao();
			
	// 멤버 정보 가져오기
	Member loginedMember = memberDao.selectMemberOne(member.getMemberId());
%>
	<h1>회원정보 수정</h1>
	<form method="post" action="./updateMemberAction.jsp">
		<div>이름 : </div>
		<div><input type="text" name="memberName" value="<%=loginedMember.getMemberName() %>"></div>
		<div>나이 : </div>
		<div><input type="text" name="memberAge" value="<%=loginedMember.getMemberAge() %>"></div>
		<div>성별 : </div>
		<div>
			<input type="radio" name="memberGender" value="남" checked="checked">
			<label for="memberGender">남</label>
			<input type="radio" name="memberGender" value="여">
			<label for="memberGender">여</label>
		</div>
		<div>본인확인을 위하여 비밀번호를 입력해 주세요. </div>
		<div><input type="password" name="memberPw"></div>
		<div><input type="submit" value="회원정보 수정"></div>
	</form>
<%
	System.out.println("updateMemberForm.jsp 로직 종료");
%>
</body>
</html>