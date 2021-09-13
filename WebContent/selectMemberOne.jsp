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
</head>
<body>
<%
	/* 사전작업 */
	request.setCharacterEncoding("utf-8");
	System.out.println("slelectMemberOne.jsp 로직 진입");
	
	/* 인증 방어 코드 : 로그인 전에만 페이지 열람 가능 */
	// 만약 로그인하지 않은 멤버가 selectMemberOne.jsp에 접근하려고 할 시, index.jsp 페이지로 강제 이동시킨다.
	Member member = (Member)session.getAttribute("loginMember");
	
	if (member == null) {
		response.sendRedirect("./index.jsp");
		System.out.println("[debug] selectMemberOne.jsp => index.jsp로 강제 이동: 로그인하지 않은 멤버의 강제 접근을 막았습니다.");
		return; 
	}
			
	// db 작업 위한 Dao 객체 생성
	MemberDao memberDao = new MemberDao();
			
	// 멤버 정보 가져오기
	Member loginedMember = memberDao.selectMemberOne(member.getMemberId());
%>

	</div>
	<!-- 저장된 보드 객체의 데이터를 노출 -->
	<!-- th 너비 조절(https://stackoverflow.com/questions/15115052/how-to-set-up-fixed-width-for-td) -->
	<!-- th,td 가운데 정렬(https://frhyme.github.io/others/text_align_bootstrap/) -->
	<table class="table">
		<thead class="thead-light">	
			<tr class="align-content-center">
				<th class="text-center" style="width: 20%">아이디</th>
				<th class="text-center" style="width: 20%">이름</th>
				<th class="text-center" style="width: 20%" >나이</th>
				<th class="text-center" style="width: 20%" >성별</th>
				<th class="text-center" style="width: 20%" >가입날짜</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="text-center" style="width: 20%"><%=loginedMember.getMemberId()%></td>
				<td class="text-center" style="width: 20%"><%=loginedMember.getMemberName()%></td>
				<td class="text-center" style="width: 20%" ><%=loginedMember.getMemberAge()%>세</td>
				<td class="text-center" style="width: 20%" ><%=loginedMember.getMemberGender()%></td>
				<td class="text-center" style="width: 20%" ><%=loginedMember.getMemberDate()%></td>
			</tr>
			<tr>
				<td class="text-right" colspan="5">
					<a href="./index.jsp" class="btn btn-outline-primary btn-sm">index로</a>
					<a href="./updateMemberPwForm.jsp" class="btn btn-outline-primary btn-sm">비밀번호 수정</a>
					<a href="./updateMemberForm.jsp" class="btn btn-outline-primary btn-sm">기타정보 수정</a>
					<a href="./deleteMemberForm.jsp" class="btn btn-outline-danger btn-sm">회원탈퇴</a>
				</td>
			</tr>
		</tbody>
	</table>
<%
	System.out.println("slelectMemberOne.jsp 로직 종료");
%>
</body>
</html>