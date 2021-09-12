package vo;

public class Comment {
	private int commentNo;
	private int boardNo;
	private String commentContent;
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public String getCommeantDate() {
		return commeantDate;
	}
	public void setCommeantDate(String commeantDate) {
		this.commeantDate = commeantDate;
	}
	private String commeantDate;
}
