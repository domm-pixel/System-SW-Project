package schedule;

public class Schedule {
	private String schTitle;	//제목
	private String userID;		//사용자 아이디
	private String schDate;		//일자
	private String schContent;	//내용
	private int schAvailable;	//시각처리
	private int schID;			//작성자 아이디
	
	
	public int getSchID() {
		return schID;
	}
	public void setSchID(int schID) {
		this.schID = schID;
	}
	public String getSchTitle() {
		return schTitle;
	}
	public void setSchTitle(String schTitle) {
		this.schTitle = schTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getSchDate() {
		return schDate;
	}
	public void setSchDate(String schDate) {
		this.schDate = schDate;
	}
	public String getSchContent() {
		return schContent;
	}
	public void setSchContent(String schContent) {
		this.schContent = schContent;
	}
	public int getSchAvailable() {
		return schAvailable;
	}
	public void setSchAvailable(int schAvailable) {
		this.schAvailable = schAvailable;
	}
	
}
