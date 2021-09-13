<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	/* 사전작업 */
	request.setCharacterEncoding("utf-8");
	System.out.println("updateMemberPwAction.jsp 로직 진입");
	
	String memberPwNew = request.getParameter("memberPwNew");
	String memberPw = request.getParameter("memberPw");

	// db 작업 위한 Dao 객체 생성
	MemberDao memberDao = new MemberDao();
			
	// 멤버 정보 가져오기
	Member member = (Member)session.getAttribute("loginMember");
	
	Member loginedMember = memberDao.selectMemberOne(member.getMemberId());
	
	loginedMember.setMemberPw(memberPw);
	
	int confirm = memberDao.updateMemberPw(loginedMember, memberPwNew);
	
	if (confirm==1) {
		
		System.out.println("[debug] updateMemberPwAction.jsp => 비밀번호 수정 성공");
		response.sendRedirect("./selectMemberOne.jsp");
		
		System.out.println("updateMemberPwAction.jsp 로직 종료");
		
		return;
	} else {
		System.out.println("[debug] updateMemberPwAction.jsp => 비밀번호 수정 실패 : 입력 정보를 다시 확인해 주세요.");
		response.sendRedirect("./updateMemberPwForm.jsp");
		
		System.out.println("updateMemberPwAction.jsp 로직 종료");		
		
		return;
	}
	
%>