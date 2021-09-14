package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.DBUtil;
import vo.Member;

// 규칙 => 매개변수값은 첫줄에 디버깅
public class MemberDao {
	
	/* 로그인 */
	// input: Member => memberId, memberPw
	// output(success): Member => memberId, memberName
	// output(false): null
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		
		// 입력값 디버깅
		System.out.println("[debug] MemberDao.login(Member member) => 입력받은 멤버 아이디 : " + member.getMemberId());
		System.out.println("[debug] MemberDao.login(Member member) => 입력받은 멤버 비밀번호 : " + member.getMemberPw());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 별칭(alias)를 설정할 때, AS를 안붙여줘도 되고, 별칭이 영어일 경우, ""를 사용해주지 않아도 된다.
		String sql = "SELECT member_id memberId, member_name AS memberName FROM member WHERE member_id=? and member_pw=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1,member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		
		// 쿼리 디버깅
		System.out.println("[debug] MemberDao.login(Member member) => 쿼리문 : " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		
		// 객체에 null을 넣으면 그 객체의 기본 구조도 없이 그냥 null 값이 된다. 객체에 null을 넣고 그 객체의 메소드를 호출하면 nullPointError가 발생한다.
		
		if(rs.next()) {
			
			Member returnedMember = new Member();
			
			returnedMember.setMemberId(rs.getString("memberId"));
			returnedMember.setMemberName(rs.getString("memberName"));
			
			// 출력값 디버깅
			System.out.println("[debug] MemberDao.login(Member member) => 멤버 아이디 : " + returnedMember.getMemberId());
			System.out.println("[debug] MemberDao.login(Member member) => 멤버 이름 : " + returnedMember.getMemberName());
			
			rs.close();
			stmt.close();
			conn.close();
			
			return returnedMember;
			
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return null;
	}
	
	/* 회원 정보 출력(select) */
	// input: Member => memberId, memberPw
	// output(success): Member => memberId, memberName, memberDate, memberGender, memberAge
	// output(false): null
	public Member selectMemberOne(String memberId) throws ClassNotFoundException, SQLException {
		
		// 입력값 디버깅
		System.out.println("[debug] MemberDao.selectMemberOne(String memberId) => 멤버 아이디 : " + memberId);
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 별칭(alias)를 설정할 때, AS를 안붙여줘도 되고, 별칭이 영어일 경우, ""를 사용해주지 않아도 된다.
		String sql = "SELECT member_id memberId, member_name memberName, member_age memberAge, member_gender memberGender, member_date memberDate FROM member WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, memberId);
		
		// 쿼리 디버깅
		System.out.println("[debug] MemberDao.selectMemberOne(String memberId) => 쿼리문 : " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		
			if(rs.next()) {
			
			Member returnedMember = new Member();
			
			returnedMember.setMemberId(rs.getString("memberId"));
			returnedMember.setMemberName(rs.getString("memberName"));
			returnedMember.setMemberAge(rs.getInt("memberAge"));
			returnedMember.setMemberGender(rs.getString("memberGender"));
			returnedMember.setMemberDate(rs.getString("memberDate"));
			
			// 출력값 디버깅
			System.out.println("[debug] MemberDao.selectMemberOne(String memberId) => 멤버 아이디 : " + returnedMember.getMemberId());
			System.out.println("[debug] MemberDao.selectMemberOne(String memberId) => 멤버 이름 : " + returnedMember.getMemberName());
			System.out.println("[debug] MemberDao.selectMemberOne(String memberId) => 멤버 나이 : " + returnedMember.getMemberAge());
			System.out.println("[debug] MemberDao.selectMemberOne(String memberId) => 멤버 성별 : " + returnedMember.getMemberGender());
			System.out.println("[debug] MemberDao.selectMemberOne(String memberId) => 멤버 가입날짜 : " + returnedMember.getMemberDate());
			
			rs.close();
			stmt.close();
			conn.close();
			
			return returnedMember;
			
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return null;
	}
	
	/* 회원 가입(insert) */
	// input:  Member => memberId, memberPw, MemberName, MemberAge, MemberGender
	// output(success): 1
	// output(false): 0
	public int insertMember(Member member) throws ClassNotFoundException, SQLException {
		
		// 입력값 디버깅
		System.out.println("[debug] MemberDao.insertMember(Member member) => 가입자 아이디 : " + member.getMemberId());
		System.out.println("[debug] MemberDao.insertMember(Member member) => 가입자 비밀번호 : " + member.getMemberPw());
		System.out.println("[debug] MemberDao.insertMember(Member member) => 가입자 이름 : " + member.getMemberName());
		System.out.println("[debug] MemberDao.insertMember(Member member) => 가입자 나이 : " + member.getMemberAge());
		System.out.println("[debug] MemberDao.insertMember(Member member) => 가입자 성별 : " + member.getMemberGender());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 별칭(alias)를 설정할 때, AS를 안붙여줘도 되고, 별칭이 영어일 경우, ""를 사용해주지 않아도 된다.
		String sql = "INSERT INTO member(member_id, member_pw, member_name, member_age, member_gender, member_date) VALUES(?,?,?,?,?,NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		stmt.setInt(4, member.getMemberAge());
		stmt.setString(5, member.getMemberGender());
		
		// 쿼리 디버깅
		System.out.println("[debug] MemberDao.insertMember(Member member) => 쿼리문 : " + stmt);
		
		// db 작업 결과 성공 여부 저장
		int confirm = stmt.executeUpdate();
		
		return confirm;
	}
	
	/* 비밀번호 수정(update) */
	// input:  Member => memberId, memberPw, String memberPwNew
	// output(success): 1
	// output(false): 0
	public int updateMemberPw(Member member, String memberPwNew) throws ClassNotFoundException, SQLException {
		
		// 입력값 디버깅
		System.out.println("[debug] MemberDao.updateMemberPw(Member member, String memberPwNew) => 멤버 아이디 : " + member.getMemberId());
		System.out.println("[debug] MemberDao.updateMemberPw(Member member, String memberPwNew) => 멤버 기존 비밀번호 : " + member.getMemberPw());
		System.out.println("[debug] MemberDao.updateMemberPw(Member member, String memberPwNew) => 멤버 신규 비밀번호 : " + memberPwNew);
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 별칭(alias)를 설정할 때, AS를 안붙여줘도 되고, 별칭이 영어일 경우, ""를 사용해주지 않아도 된다.
		String sql = "UPDATE member SET member_pw=? WHERE member_id=? and member_pw=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, memberPwNew);
		stmt.setString(2, member.getMemberId());
		stmt.setString(3, member.getMemberPw());
		
		// 쿼리 디버깅
		System.out.println("[debug] MemberDao.updateMemberPw(Member member, String memberPwNew) => 쿼리문 : " + stmt);
		
		// db 작업 결과 성공 여부 저장
		int confirm = stmt.executeUpdate();
		
		return confirm;
	}
	
	/* 기타 수정(update) */
	// input:  Member member => memberId, memberPw
	// output(success): 1
	// output(false): 0
	public int updateMember(Member beforeMember, Member afterMember) throws ClassNotFoundException, SQLException {
		
		// 입력값 디버깅
		System.out.println("[debug] MemberDao.updateMember(Member beforeMember, Member afterMember) => 멤버 아이디 : " + beforeMember.getMemberId());
		System.out.println("[debug] MemberDao.updateMember(Member beforeMember, Member afterMember) => 멤버 비밀번호 : " + afterMember.getMemberPw());
		
		System.out.println("[debug] MemberDao.updateMember(Member beforeMember, Member afterMember) => 멤버 기존 이름 : " + beforeMember.getMemberName());
		System.out.println("[debug] MemberDao.updateMember(Member beforeMember, Member afterMember) => 멤버 기존 나이 : " + beforeMember.getMemberAge());
		System.out.println("[debug] MemberDao.updateMember(Member beforeMember, Member afterMember) => 멤버 기존 성별 : " + beforeMember.getMemberGender());
		
		System.out.println("[debug] MemberDao.updateMember(Member beforeMember, Member afterMember) => 멤버 신규 이름 : " + afterMember.getMemberName());
		System.out.println("[debug] MemberDao.updateMember(Member beforeMember, Member afterMember) => 멤버 신규 나이 : " + afterMember.getMemberAge());
		System.out.println("[debug] MemberDao.updateMember(Member beforeMember, Member afterMember) => 멤버 신규 성별 : " + afterMember.getMemberGender());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 별칭(alias)를 설정할 때, AS를 안붙여줘도 되고, 별칭이 영어일 경우, ""를 사용해주지 않아도 된다.
		String sql = "UPDATE member SET member_name=?, member_age=?, member_gender=? WHERE member_id=? and member_pw=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, afterMember.getMemberName());
		stmt.setInt(2, afterMember.getMemberAge());
		stmt.setString(3, afterMember.getMemberGender());
		stmt.setString(4, beforeMember.getMemberId());
		stmt.setString(5, afterMember.getMemberPw());
		
		// 쿼리 디버깅
		System.out.println("[debug] MemberDao.updateMember(Member beforeMember, Member afterMember) => 쿼리문 : " + stmt);
		
		// db 작업 결과 성공 여부 저장
		int confirm = stmt.executeUpdate();
		
		return confirm;
	}
	
	
	/* 회원 탈퇴(delete) */
	// input:  Member member => memberId, memberPw
	// output(success): 1
	// output(false): 0
	public int deleteMemeber(Member member) throws ClassNotFoundException, SQLException {
		
		// 입력값 디버깅
		System.out.println("[debug] MemberDao.deleteMember(Member member) => 멤버 아이디 : " + member.getMemberId());
		System.out.println("[debug] MemberDao.deleteMember(Member member) => 멤버 비밀번호 : " + member.getMemberPw());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 별칭(alias)를 설정할 때, AS를 안붙여줘도 되고, 별칭이 영어일 경우, ""를 사용해주지 않아도 된다.
		String sql = "DELETE FROM member WHERE member_id=? and member_pw=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		
		// 쿼리 디버깅
		System.out.println("[debug] MemberDao.deleteMember(Member member) => 쿼리문 : " + stmt);
		
		// db 작업 결과 성공 여부 저장
		int confirm = stmt.executeUpdate();
		
		return confirm;

	}
	

	

	
	
}
