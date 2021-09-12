package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import db.DBUtil;
import vo.Board;

public class BoardDao {
	
	// 특정 게시글을 조회하여 이를 전달하는 메소드
	public Board selectBoardOne(int boardNo) throws ClassNotFoundException, SQLException {
		// 자기 자신의 메소드를 호출(this)
		
		// DBUtil 클래스로 connection을 만듬
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
					
		// 전달받은 board_no과 매칭되는 게시글을 가져오는 쿼리문 골격 생성
		PreparedStatement stmt = conn.prepareStatement("select board_no, board_title, board_category, board_content, board_date from board where board_no=?");
					
		// 쿼리문 세팅
		stmt.setInt(1, boardNo);
					
		// 디버깅
		System.out.println("[debug] 게시글 정보 조회 쿼리문 :" + stmt);
					
		ResultSet rs = stmt.executeQuery();
					
		/* 보드 객체 생성 후 조회된 데이터 저장 작업 */
					
		Board board = null;
					
		if (rs.next()){
						
		// 메모리 절약
		board = new Board();
						
		// 파라미터 세팅
		board.setBoardNo(rs.getInt("board_no"));
		board.setBoardTitle(rs.getString("board_title"));
		board.setBoardCategory(rs.getString("board_category"));
		board.setBoardContent(rs.getString("board_content"));
		board.setBoardDate(rs.getString("board_date"));
						
		// 디버깅
		System.out.println("[debug] 번호 : " + board.getBoardNo());
		System.out.println("[debug] 제목 : " + board.getBoardTitle());
		System.out.println("[debug] 내용 : " + board.getBoardContent());
		System.out.println("[debug] 카테고리 : " + board.getBoardCategory());
		System.out.println("[debug] 날짜 : " + board.getBoardDate());
		
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return board;
	}
	
	// 검색조건에 맞는 게시글의 총 개수를 구해서 전달하는 메소드
	public int selectCountDisplay(int rowPerPage, String displayCategory) throws SQLException, ClassNotFoundException {
		
		// DBUtil 클래스로 connection을 만듬
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 조건에 맞는 검색 결과의 총 게시글들의 수 계산하기
		String sql = null;
		PreparedStatement stmt = null;
					
		// 카테고리가 있고 없고에 따라(ALL or 특정 카테고리) 쿼리문을 다르게 구성
		if (displayCategory.equals("ALL")) {
			sql = "select Count(*) from board";
			stmt = conn.prepareStatement(sql);
						
		} else {
			sql = "select Count(*) from board where board_category=?";
			stmt = conn.prepareStatement(sql);
						
			// 쿼리문 세팅
			stmt.setString(1, displayCategory);
		}
					
		ResultSet rs = stmt.executeQuery();
					
		System.out.println("[debug] 검색 결과 게시글 총 개수 조회 쿼리문 : " + stmt);
					
		int countDisplay = 0;
		if (rs.next()) {
			countDisplay = rs.getInt(1);	
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return countDisplay;
	}
	
	// 게시글들을 검색조건에 맞게 페이징하여 전달하는 메소드
	public ArrayList<Board> selectBoardListByPage(int beginRow, int rowPerPage, String displayCategory) throws SQLException, ClassNotFoundException {
		
		// DBUtil 클래스로 connection을 만듬
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문 골격 생성
		String sql = null;
		PreparedStatement stmt = null;
			
		// 페이징 쿼리문 세팅
		// 카테고리가 있고 없고에 따라(ALL or 특정 카테고리) 쿼리문을 다르게 구성
		if (displayCategory.equals("ALL")) {
			sql = "select board_no, board_category, board_title from board order by board_date desc limit ?,?";
			stmt = conn.prepareStatement(sql);
				
			// 쿼리문 세팅				
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
				
		} else {
			sql = "select board_no, board_category, board_title from board where board_category=? order by board_date desc limit ?,?";
			stmt = conn.prepareStatement(sql);					
				
			// 쿼리문 세팅
			stmt.setString(1, displayCategory);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);			
			
		}
				
		// 디버깅
		System.out.println("[debug] 게시글 불러오는 쿼리문 : " + stmt);
				
		// ResultSet은 일반적인 데이터 타입이 아니기에(대중성? 부족?) 일반적인 데이터 타입으로 변환해 준다.
		ResultSet rs = stmt.executeQuery();	
				
		// 조회 결과 board 리스트에 담기
		ArrayList<Board> boardList = new ArrayList<Board>();
		
		while(rs.next()) {
			Board board = new Board();
				
			board.setBoardNo(rs.getInt("board_no"));
			board.setBoardTitle(rs.getString("board_title"));
			board.setBoardCategory(rs.getString("board_category"));
					
			boardList.add(board);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return boardList;
	}

	// 게시글들이 가지는 카테고리들을 조회하여 전달하는 메소드
	public  ArrayList<String> selectBoardCategoryList() throws SQLException, ClassNotFoundException {
		
		// DBUtil 클래스로 connection을 만듬
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "select distinct board_category from board order by board_category asc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		System.out.println("[debug] 쿼리문 : " + stmt);
		
		// ResultSet은 일반적인 데이터 타입이 아니기에(일반성 부족) 일반적인 데이터 타입으로 변환해 준다.
		ResultSet rs = stmt.executeQuery();		
		
		ArrayList<String> boardCategoryList = new ArrayList<>();
		
		while(rs.next()){
			boardCategoryList.add(rs.getString("board_category"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return boardCategoryList;
	}
	
	// 게시글을 db에 삽입하는 메소드
	public void insertBoard(String boardTitle, String boardContent, String boardCategory) throws SQLException, ClassNotFoundException {
		
		// DBUtil 클래스로 connection을 만듬
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문 골격 생성
		PreparedStatement stmt = conn.prepareStatement("insert into board ( board_title, board_content, board_category, board_date) values (?,?,?,now())"); // ?표현식 : 변수자리 
		
		// 쿼리문 세팅
		stmt.setString(1, boardTitle);
		stmt.setString(2, boardContent);
		stmt.setString(3, boardCategory);
		
		System.out.println("[debug] 게시글 insert 쿼리문 : " + stmt);
		
		// 쿼리문 실행 결과 확인
		int confirm = stmt.executeUpdate();
		
		// 디버깅
		System.out.println("[debug] insert된 행의 개수 : " + confirm);
		
		stmt.close();
		conn.close();
		
		
	}
	
	// 게시글을 수정하는 메소드
	public void updateBoard(int boardNo, String boardCategory, String boardTitle, String boardContent) throws ClassNotFoundException, SQLException {
		
		// DBUtil 클래스로 connection을 만듬
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문 기본 골격 작성
		String sql = "update board set board_title=?, board_content=?, board_category=? where board_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// 쿼리문 세팅
		stmt.setString(1, boardTitle);
		stmt.setString(2, boardContent);
		stmt.setString(3, boardCategory);
		stmt.setInt(4, boardNo);

		// 디버깅
		System.out.println("[debug] 쿼리 : " + stmt);
		
		int confirm = stmt.executeUpdate();
		
		// 디버깅
		System.out.println("[debug] 수정된 행의 개수 : " + confirm);
		
		stmt.close();
		conn.close();
		
	}
	
	// 게시글을 삭제하는 메소드
	public void deleteBoard(int boardNo) throws ClassNotFoundException, SQLException {
		
		// DBUtil 클래스로 connection을 만듬
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문 기본 골격 작성
		PreparedStatement stmt = conn.prepareStatement("delete from board where board_no=?");
		
		// 쿼리문 세팅
		stmt.setInt(1, boardNo);
		
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