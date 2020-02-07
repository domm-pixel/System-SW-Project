package user;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	// dao : 데이터베이스 접근 객체의 약자로서
	// 실질적으로 db에서 회원정보 불러오거나 db에 회원정보 넣을때
	private Connection conn; // connection:db에접근하게 해주는 객체
	private PreparedStatement pstmt;
	private ResultSet rs;
	// mysql에 접속해 주는 부분
	public UserDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함
		try {
			String dbURL = "jdbc:mysql://localhost:3301/JSP?useUnicode=true&characterEncoding=UTF-8";
			String dbID = "root";
			String dbPassword = "markany1@";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
		e.printStackTrace(); // 오류가 무엇인지 출력
		}
	}

	// 로그인을 시도하는 함수****
	public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if(rs.next()){
                if(rs.getString(1).equals(userPassword))
                    return 1;    // 로그인 성공
                else
                    return 0; // 비밀번호 불일치
            }
            return -1; // ID가 없음
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // DB 오류
        
    }
    
    public int join(User user) {
        String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserEmail());
            return pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
	}
}