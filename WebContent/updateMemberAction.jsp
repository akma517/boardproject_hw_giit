<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	/* 사전작업 */
	request.setCharacterEncoding("utf-8");
	System.out.println("[debug] updateMemberAction.jsp 로직 진입");
	
	/* 인증 방어 코드 : 로그인 후에만 페이지 열람 가능 */
	// 만약 로그인하지 않은 멤버가 updateMemberAction.jsp에 접근하려고 할 시, index.jsp 페이지로 강제 이동시킨다.
	Member member = (Member)session.getAttribute("loginMember");
	
	if (member == null) {
		response.sendRedirect("./index.jsp");
		System.out.println("[debug] updateMemberAction.jsp => index.jsp로 강제 이동: 로그인 하지 않은 멤버의 강제 접근을 막았습니다.");
		return; 
	}
	
	String memberName = request.getParameter("memberName");
	String memberAgeString = request.getParameter("memberAge");
	String memberGender = request.getParameter("memberGender");
	String memberPw = request.getParameter("memberPw");
	
	// 회원 정보 수정값 디버깅
	System.out.println("[debug] insertMemberAction.jsp => 회원 정보 수정값 이름 : " +  memberName);
	System.out.println("[debug] insertMemberAction.jsp => 회원 정보 수정값 나이 : " + memberAgeString);
	System.out.println("[debug] insertMemberAction.jsp => 회원 정보 수정값 성별 : " + memberGender);
	System.out.println("[debug] insertMemberAction.jsp => 회원 정보 수정값 비밀번호 : " + memberPw);
	
	// 가입 정보 유효성 검사
	if (memberName == null || memberAgeString == null || memberGender == null || memberPw == null) {
		response.sendRedirect("./updateMemberForm.jsp");
		System.out.println("[debug] updateMemberAction.jsp => updatetMemberForm.jsp로 강제 이동: 회원 정보 수정값에 null값이 있어 이전 페이지로 돌려보냈습니다.");
		return; 
	}
	
	// 유효성 검사 후, memeberAge의 타입에 맞게 형 변환
	int memberAge = Integer.parseInt(memberAgeString);

	// db 작업 위한 Dao 객체 생성
	MemberDao memberDao = new MemberDao();
			
	// 멤버 정보 가져오기
	Member loginedMember = memberDao.selectMemberOne(member.getMemberId());
	
	loginedMember.setMemberPw(memberPw);
	
	Member afterMember = new Member();
	
	afterMember.setMemberName(memberName);
	afterMember.setMemberAge(memberAge);
	afterMember.setMemberGender(memberGender);
	afterMember.setMemberPw(memberPw);
	
	int confirm = memberDao.updateMember(loginedMember, afterMember);
	
	if (confirm==1) {
		
		System.out.println("[debug] updateMemberAction.jsp => 회원정보 수정 성공");
		response.sendRedirect("./selectMemberOne.jsp");
		
		System.out.println("[debug] updateMemberAction.jsp 로직 종료");
		
		return;
	} else {
		
		System.out.println("[debug] updateMemberAction.jsp => 회원정보 수정 실패 : 입력 정보를 다시 확인해 주세요.");
		response.sendRedirect("./selectMemberOne.jsp");
		
		System.out.println("[debug] updateMemberAction.jsp 로직 종료");
		
		return;
	}

%>