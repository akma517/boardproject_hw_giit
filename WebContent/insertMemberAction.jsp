<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* 사전작업 */
	request.setCharacterEncoding("utf-8");
	System.out.println("insertMemberAction.jsp 로직 진입");
	
	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	String memberGender = request.getParameter("memberGender");
	String memberPw = request.getParameter("memberPw");
	

	// db 작업 위한 Dao 객체 생성
	MemberDao memberDao = new MemberDao();
			
	// 가입 정보 세팅
	Member member = new Member();
	
	member.setMemberId(memberId);
	member.setMemberName(memberName);
	member.setMemberAge(memberAge);
	member.setMemberGender(memberGender);
	member.setMemberPw(memberPw);
	
	int confirm = memberDao.insertMember(member);
	
	if (confirm==1) {
		
		System.out.println("[debug] insertMemberAction.jsp => 회원가입 성공");
		response.sendRedirect("./index.jsp");
		
		
		System.out.println("insertMemberAction.jsp 로직 종료");
		
		return;
	} else {
		System.out.println("[debug] insertMemberAction.jsp => 회원가입 실패 : 입력 정보를 다시 확인해 주세요.");
		response.sendRedirect("./index.jsp");
		
		
		System.out.println("insertMemberAction.jsp 로직 종료");
		
		return;
	}
	
%>