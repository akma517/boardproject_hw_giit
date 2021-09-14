<%@page import="dao.MemberDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자바 송현우</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<style type="text/css">
		.center-block{
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			z-index: 1;
		}
	</style>
</head>
<body>
	<div class="container pt-3 center-block" style="width:330px; padding:15px;">
	<%
		/* 사전작업 */
		request.setCharacterEncoding("utf-8");
		System.out.println("[debug] updateMemberPwForm.jsp 로직 진입");
		
		/* 인증 방어 코드 : 로그인 전에만 페이지 열람 가능 */
		// 만약 로그인하지 않은 멤버가 updateMemberPwForm.jsp에 접근하려고 할 시, index.jsp 페이지로 강제 이동시킨다.
		Member member = (Member)session.getAttribute("loginMember");
		
		if (member == null) {
			response.sendRedirect("./index.jsp");
			System.out.println("[debug] updateMemberPwForm.jsp => index.jsp로 강제 이동: 로그인하지 않은 멤버의 강제 접근을 막았습니다.");
			return; 
		}
				
	%>
		<div class="center-block text-center" style="width:300px; padding:15px;">
			<h1>비밀번호 수정</h1>
			<form class="form-group" method="post" action="./updateMemberPwAction.jsp">
				<div>현재 비밀번호 : </div>
				<div><input class="form-control" type="password" name="memberPw"></div>
				<div>새로운 비밀번호 : </div>
				<div><input class="form-control" type="password" name="memberPwNew"></div>
				<br>
				<div><input class="btn btn-outline-primary" type="submit" value="비밀번호 수정"></div>
			</form>
		<%
			System.out.println("[debug] updateMemberPwForm.jsp 로직 종료");
		%>
		</div>
	</div>
</body>
</html>