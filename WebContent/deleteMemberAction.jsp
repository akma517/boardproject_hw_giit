<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* 사전작업 */
	request.setCharacterEncoding("utf-8");
	System.out.println("[debug] deleteMemberAction.jsp 로직 진입");
	
	/* 인증 방어 코드 : 로그인 후에만 페이지 열람 가능 */
	// 만약 로그인하지 않은 멤버가 deleteMemberAction.jsp에 접근하려고 할 시, index.jsp 페이지로 강제 이동시킨다.
	Member member = (Member)session.getAttribute("loginMember");
	
	if (member == null) {
		response.sendRedirect("./index.jsp");
		System.out.println("[debug] deleteMemberAction.jsp => index.jsp로 강제 이동: 로그인 하지 않은 멤버의 강제 접근을 막았습니다.");
		return; 
	}
	
	String memberPw = request.getParameter("memberPw");
	
	// 탈퇴 정보값 디버깅
	System.out.println("[debug] deleteMemberAction.jsp => 탈퇴 정보 비밀번호 : " + memberPw);
	
	// 탈퇴 정보 유효성 검사
	if (memberPw == null) {
		response.sendRedirect("./deleteMemberForm.jsp");
		System.out.println("[debug]  deleteMemberAction.jsp => deleteMemberForm.jsp로 강제 이동: 탈퇴 정보에 null값이 있어 이전 페이지로 돌려보냈습니다.");
		return; 
	}

	// db 작업 위한 Dao 객체 생성
	MemberDao memberDao = new MemberDao();
			
	// 회원 탈퇴 정보 세팅
	Member loginedMember = memberDao.selectMemberOne(member.getMemberId());
	member.setMemberPw(memberPw);
	
	
	int confirm = memberDao.deleteMemeber(member);
	
	if (confirm==1) {
		
		System.out.println("[debug] deleteMemberAction.jsp => 회원탈퇴 성공");
		response.sendRedirect("./logOut.jsp");
		
		
		System.out.println("[debug] deleteMemberAction.jsp 로직 종료");
		
		return;
	} else {
		System.out.println("[debug] deleteMemberAction.jsp => 회원탈퇴 실패 : 입력 정보를 다시 확인해 주세요.");
		response.sendRedirect("./deleteMemberForm.jsp");
		
		
		System.out.println("[debug] deleteMemberAction.jsp 로직 종료");
		
		return;
	}
	
%>