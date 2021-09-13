<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	/* 로그인 처리 */
	// input: request => memberId, memberPw
	// output(success): session => Member loginMember
	// output(false): 
	request.setCharacterEncoding("utf-8");
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	// 입력값 디버깅
	System.out.println("[debug] loginAction.jsp => 입력받은 아이디 : " + memberId);
	System.out.println("[debug] loginAction.jsp => 입력받은 비밀번호 : " + memberPw);
	
	MemberDao memberDao = new MemberDao();
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	Member returnedMember = memberDao.login(paramMember);
	
	// 로그인 여부 디버깅
	if(returnedMember == null) {
		
		System.out.println("[debug] loginAction.jsp => 로그인 실패 : 일치하는 멤버 정보가 없음");
		response.sendRedirect("./loginForm.jsp");
		return;
		
	} else {
		
		System.out.println("[debug] loginAction.jsp => 로그인 성공");
		System.out.println("[debug] loginAction.jsp => 로그인 멤버 아이디 : " + returnedMember.getMemberId());
		System.out.println("[debug] loginAction.jsp => 로그인 멤버 이름 : " + returnedMember.getMemberName());
		
		// session, request(생성하지 않아도 이미 생성되어 있는 jsp 내장 객체)
		// returnedMember 객체를 사용자의 session에 저장
		session.setAttribute("loginMember", returnedMember);
		
		response.sendRedirect("./index.jsp");
		return;
		
	}
	
	
	
	
%>