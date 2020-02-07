package schedule;

import java.sql.*;
import java.util.*;

public class ScheduleDAO {
	private Connection conn;            // DB�� �����ϴ� ��ü
    private ResultSet rs;                // DB data�� ���� �� �ִ� ��ü  (Ctrl + shift + 'o') -> auto import
    
    public ScheduleDAO(){ 
        try {
            String dbURL = "jdbc:mysql://localhost:3301/JSP?useUnicode=true&characterEncoding=UTF-8";
            String dbID = "root";
            String dbPassword = "markany1@";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public String getDate() // ����ð��� �־��ֱ�����
    {
        String SQL = "SELECT NOW()"; // ����ð��� ��Ÿ���� mysql
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getString(1);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ""; // �����ͺ��̽� ����
    }
    public int write(String userID, String schTitle, String schContent) {
        String SQL = "INSERT INTO scheduletable VALUES (?,?,?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            pstmt.setString(2, schTitle);
            pstmt.setString(3, getDate());//��Ͻð� 
            pstmt.setString(4, schContent);
            pstmt.setInt(5, 1);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // �����ͺ��̽� ����
    }
    public ArrayList<Schedule> getList(int pageNumber)
    {
        String SQL = "SELECT * FROM scheduletable WHERE schID < ? AND schAvailable = 1 ORDER BY schID DESC LIMIT 10"; // ������������ ���� �������� ���� ���� �����´�
        ArrayList<Schedule> list = new ArrayList<Schedule>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Schedule sch = new Schedule();
                sch.setSchID(rs.getInt(1));
                sch.setSchTitle(rs.getString(2));
                sch.setUserID(rs.getString(3));
                sch.setSchDate(rs.getString(4));
                sch.setSchContent(rs.getString(5));
                sch.setSchAvailable(rs.getInt(6));
                list.add(sch);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list; 
    }
//  ����¡ ó���� ���� �Լ�
  public boolean nextPage(int pageNumber) {
      String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1"; 
      try {
          PreparedStatement pstmt = conn.prepareStatement(SQL);
          pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
          rs = pstmt.executeQuery();
          if (rs.next())
          {
              return true;
          }
      } catch (Exception e) {
          e.printStackTrace();
      }
      return false; 
  }
    public Schedule getsch(int schID)
    {
            String SQL = "SELECT * FROM BBS WHERE bbsID = ?"; 
            try {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                pstmt.setInt(1, schID);
                rs = pstmt.executeQuery();
                if (rs.next())
                {
                    Schedule sch = new Schedule();
                    sch.setSchID(rs.getInt(1));
                    sch.setSchTitle(rs.getString(2));
                    sch.setUserID(rs.getString(3));
                    sch.setSchDate(rs.getString(4));
                    sch.setSchContent(rs.getString(5));
                    sch.setSchAvailable(rs.getInt(6));
                    return sch;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null; 
        }
		public int update(int schID, String schTitle, String schContent)
		{
	        String SQL = "UPDATE scheduletable SET schTitle = ?, schContent = ? WHERE schID = ?";
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            pstmt.setString(1, schTitle);
	            pstmt.setString(2, schContent);
	            pstmt.setInt(3, schID);
	            return pstmt.executeUpdate();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return -1; // �����ͺ��̽� ����
		}
		 public int delete(int schID)
		    {
			 	String SQL = "UPDATE scheduletable SET bbsAvailable = 0  WHERE schID = ?";
				try {
				    PreparedStatement pstmt = conn.prepareStatement(SQL);
				    pstmt.setInt(1, schID);
				    return pstmt.executeUpdate();
				} catch (Exception e) {
				    e.printStackTrace();
				}
				return -1; // �����ͺ��̽� ����
		}
		 public int getNext()
		    {
		        String SQL = "SELECT schID FROM scheduletable ORDER BY schID DESC"; // ������������ ���� �������� ���� ���� �����´�
		        try {     
		            PreparedStatement pstmt = conn.prepareStatement(SQL);
		            rs = pstmt.executeQuery();
		            if(rs.next()) {
		                return rs.getInt(1) + 1; // �� ���� �Խñ��� ��ȣ
		            }
		            return 1; // ù ��° �Խù��� ���
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        return -1; // �����ͺ��̽� ����
		    }
		 

}
