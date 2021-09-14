package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBUtil;
import vo.Comment;

public class CommentDao {
	
	// 댓글 리스트를 조회하여 페이징한 후, 전달하는 메소드
	public ArrayList<Comment> selectCommentListByPage(int boardNo, int commentBeginRow, int commentRowPerPage) throws ClassNotFoundException, SQLException{
		
		// DBUtil 클래스로 connection을 만듬
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문 골격 생성
		String sql = "select comment_no, comment_content,  comment_date from comment where board_no=? order by comment_date desc limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
						
		// 쿼리문 세팅				
		stmt.setInt(1, boardNo);
		stmt.setInt(2, commentBeginRow);
		stmt.setInt(3, commentRowPerPage);
					
		// 디버깅
		System.out.println("[debug] 댓글들 불러오는 쿼리문 : " +stmt);
					
		ResultSet rs = stmt.executeQuery();	
					
		// 조회 결과 comment 리스트에 담기
		ArrayList<Comment> commentList = new ArrayList<Comment>();
					
		while(rs.next()) {
			Comment comment = new Comment();
						
			comment.setCommentNo(rs.getInt("comment_no"));
			comment.setCommentContent(rs.getString("comment_content"));
			comment.setCommeantDate(rs.getString("comment_date"));
						
			commentList.add(comment);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return commentList;
	}
	
	// 댓글의 총 개수를 구한 후, 전달하는 메소드
	public int selectCountComment(int commentRowPerPage, int boardNo) throws SQLException, ClassNotFoundException {
		
		// DBUtil 클래스로 connection을 만듬
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 조건에 맞는 검색 결과의 총 게시글들의 수 계산하기
		String sql = "select Count(*) from comment where board_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
					
		ResultSet rs = stmt.executeQuery();
					
		System.out.println("[debug] 검색 결과 게시글 총 개수 조회 쿼리문 : " + stmt);
					
		int countComment = 0;
		if (rs.next()) {
			countComment = rs.getInt(1);	
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return countComment;
	}
	
	// 댓글을 db에 삽입하는 메소드
	public void insertComment(int boardNo, String commentContent) throws ClassNotFoundException, SQLException {

		// DBUtil 클래스로 connection을 만듬
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문 골격 생성
		PreparedStatement stmt = conn.prepareStatement("insert into comment ( board_no, comment_content, comment_date) values (?,?,now())"); // ?표현식 : 변수자리 
		
		// 쿼리문 세팅
		stmt.setInt(1, boardNo);
		stmt.setString(2, commentContent);
		
		System.out.println("[debug] 댓글 insert 쿼리문 : " + stmt);
		
		// 쿼리문 실행 결과 확인
		int confirm = stmt.executeUpdate();
		System.out.println("[debug] insert된 행의 개수 : " + confirm);
		
		// 커넥션 닫기
		stmt.close();
		conn.close();
	}
	
	// 댓글을 삭제하는 메소드
	public void deleteComment(int boardNo, int commentNo) throws ClassNotFoundException, SQLException {
		
		// DBUtil 클래스로 connection을 만듬
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문 기본 골격 작성
		PreparedStatement stmt = conn.prepareStatement("delete from comment where board_no=? and comment_no=?");
		
		// 쿼리문 세팅
		stmt.setInt(1, boardNo);
		stmt.setInt(2, commentNo);
		
		// 디버깅
		System.out.println("[debug]쿼리 : "+ stmt);
		
		// 쿼리문 실행
		int confirm = stmt.executeUpdate();
		
		// 디버깅
		System.out.println("[debug]삭제된 행의 개수 : " + confirm);
		
		stmt.close();
		conn.close();
	}
}