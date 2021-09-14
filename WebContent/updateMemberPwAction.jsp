<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	/* 사전작업 */
	request.setCharacterEncoding("utf-8");
	System.out.println("[debug] updateMemberPwAction.jsp 로직 진입");
	
	/* 인증 방어 코드 : 로그인 후에만 페이지 열람 가능 */
	// 만약 로그인하지 않은 멤버가 updateMemberPwAction.jsp에 접근하려고 할 시, index.jsp 페이지로 강제 이동시킨다.
	Member member = (Member)session.getAttribute("loginMember");
	
	if (member == null) {
		response.sendRedirect("./index.jsp");
		System.out.println("[debug] updateMemberPwAction.jsp => index.jsp로 강제 이동: 로그인 하지 않은 멤버의 강제 접근을 막았습니다.");
		return; 
	}
	
	String memberPwNew = request.getParameter("memberPwNew");
	String memberPw = request.getParameter("memberPw");
	
	// 비밀번호 수정값 디버깅
	System.out.println("[debug] deleteMemberAction.jsp => 비밀번호 수정값 기존 비밀번호 : " + memberPw);
	System.out.println("[debug] deleteMemberAction.jsp => 비밀번호 수정값 새로운 비밀번호 : " + memberPwNew);
	
	// 탈퇴 정보 유효성 검사
	if (memberPw == null || memberPwNew == null) {
		response.sendRedirect("./updateMemberPwForm.jsp");
		System.out.println("[debug] updateMemberPwAction.jsp => updateMemberPwForm.jsp로 강제 이동: 비밀번호 수정값에 null값이 있어 이전 페이지로 돌려보냈습니다.");
		return; 
	}

	// db 작업 위한 Dao 객체 생성
	MemberDao memberDao = new MemberDao();
			
	// 멤버 정보 가져오기
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
		
		System.out.println("[debug] updateMemberPwAction.jsp 로직 종료");		
		
		return;
	}
	
%>