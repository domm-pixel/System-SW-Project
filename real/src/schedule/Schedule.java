package schedule;

public class Schedule {
	private String schTitle;	//����
	private String userID;		//����� ���̵�
	private String schDate;		//����
	private String schContent;	//����
	private int schAvailable;	//�ð�ó��
	private int schID;			//�ۼ��� ���̵�
	
	
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
