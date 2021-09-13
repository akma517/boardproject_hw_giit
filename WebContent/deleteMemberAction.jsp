<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* 사전작업 */
	request.setCharacterEncoding("utf-8");
	System.out.println("deleteMemberAction.jsp 로직 진입");
	
	String memberPw = request.getParameter("memberPw");

	// db 작업 위한 Dao 객체 생성
	MemberDao memberDao = new MemberDao();
			
	// 회원 탈퇴 정보 세팅
	Member member = (Member)session.getAttribute("loginMember");
	Member loginedMember = memberDao.selectMemberOne(member.getMemberId());
	member.setMemberPw(memberPw);
	
	
	int confirm = memberDao.deleteMemeber(member);
	
	if (confirm==1) {
		
		System.out.println("[debug] deleteMemberAction.jsp => 회원탈퇴 성공");
		response.sendRedirect("./logOut.jsp");
		
		
		System.out.println("deleteMemberAction.jsp 로직 종료");
		
		return;
	} else {
		System.out.println("[debug] deleteMemberAction.jsp => 회원탈퇴 실패 : 입력 정보를 다시 확인해 주세요.");
		response.sendRedirect("./logOut.jsp");
		
		
		System.out.println("deleteMemberAction.jsp 로직 종료");
		
		return;
	}
	
%>