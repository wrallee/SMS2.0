package survey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import survey.SurveyDataBean;

public class SurveyDBBean {
	private static SurveyDBBean instance=new SurveyDBBean();
	
	public static SurveyDBBean getInstance() {
		return instance;
	}
	private SurveyDBBean() {
		
	}
	
	private Connection getConnection() throws Exception {
		Context initCtx= new InitialContext();
		Context envCtx= (Context) initCtx.lookup("java:comp/env");
		DataSource ds= (DataSource) envCtx.lookup("jdbc/OracleDB");//연결객체 할당받음
		return ds.getConnection();
	}
	
	public SurveyDataBean selectSurvey(String code) {
		Connection conn=null;
		PreparedStatement pstmt=null;	
		ResultSet rs=null;
		SurveyDataBean surveydata= null;
		
		String sql="select * from survey where code = " + code;
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			rs.next();
			
			surveydata= new SurveyDataBean();
			surveydata.setCode(rs.getString("code"));
			surveydata.setTitle(rs.getString("title"));
			surveydata.setState(rs.getString("state"));
			surveydata.setCre_date(rs.getString("cre_date"));
			surveydata.setStart_date(rs.getString("start_date"));
			surveydata.setEnd_date(rs.getString("end_date"));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt != null) try {pstmt.close();}catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}			
		}
		return surveydata;
		
	}

	
	//설문 추가 (설문항목들 제외)
	public int insertSurvey(SurveyDataBean surveydata) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt1=null;
		PreparedStatement pstmt2=null;
		int result=0;
		ResultSet rs= null;
		String subSql = "Insert Into SURVEY (code, state, title, memo, cre_date ) "
				+ "values ( ? , 'READY' , ? , ? , systimestamp ) ";
		String sql = "CREATE TABLE " + surveydata.getCode() + " (" + " rater VARCHAR2(5) REFERENCES worker(id)"
				+ " on delete cascade, ratee VARCHAR2(5) REFERENCES worker(id) on delete cascade, "
				+ surveydata.getOrder() + " VARCHAR2(5)," 
				+ "  CONSTRAINT " + "pk_" + surveydata.getCode()
				+ " PRIMARY KEY( rater , ratee )" + ") ";
		System.out.println(sql);
		try {
			
			conn=getConnection();
			
			pstmt1= conn.prepareStatement(sql);
			rs= pstmt1.executeQuery();
			System.out.println("첫번째 설문입력 프로세스 OK");
			pstmt2= conn.prepareStatement(subSql);
			pstmt2.setString(1, surveydata.getCode());
			pstmt2.setString(2, surveydata.getTitle());
			pstmt2.setString(3, surveydata.getMemo());
			result=pstmt2.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("입력오류 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt2 != null) try {pstmt2.close();}catch (SQLException ex) {}
			if(pstmt1 != null) try {pstmt1.close();}catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		return result;
	}
	//설문 삭제
	public int deleteSurvey(String code) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt1=null;
		PreparedStatement pstmt2=null;
		int result=0;
		String sql = "DROP TABLE " + code + "";
		String subSql = "DELETE FROM SURVEY WHERE code = '" + code + "'";

		try {
			conn=getConnection();
			
			pstmt1 = conn.prepareStatement(sql);
			pstmt1.executeQuery();
			pstmt2 = conn.prepareStatement(subSql);
			pstmt2.executeQuery();
			result += 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt2 != null) try {pstmt2.close();} catch (SQLException ex) {}
			if(pstmt1 != null) try {pstmt1.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		return result;		
	}
	


	
	public ResultSetMetaData getTableMdata(String code) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM " + code;
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			return rs.getMetaData();
		} catch (Exception e) {
			System.out.println("테이블 메타데이터 로드 오류: " + e.getMessage());
			return null;
		}		
	}
	
	// 그룹에 따른 ResultSet 반환 메소드
	public ResultSet getResultSet(String code) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsMdata = null;
		
		String sql = null;
		
		try {
			sql = "SELECT * FROM " + code;
			
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			return rs;
			
		} catch (Exception e) {
			System.out.println("getResultSet메소드 오류: " + e.getMessage());
			return null;
		}
	}
	
	public int deleteColumn(String code, String columnname) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int result=0;
		String sql = "ALTER TABLE " + code + " DROP COLUMN " + columnname;
		
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();
			
			result += 1;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			
		}
		return result;
					
	}

	public int addColumn(String code, String columnname) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int result=0;
		
		try {
//			select * from s004
//			getmetadata a = columncount
			
			conn=getConnection();
			
			pstmt=conn.prepareStatement("ALTER TABLE " + code +
					" add " + columnname + " VARCHAR2(10)");
//			pstmt.setString(1, columnname);		
			pstmt.executeQuery();
			
			result = 1;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch (SQLException ex) {}
			if(conn != null) try {conn.close();} catch (SQLException ex) {}
		}
		return result;
	}
	

	public int ongoingSurvey (String code) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		ResultSet rs = null;
		int result=0;
		String sql = "select * from SURVEY where state = 'ONGOING'";
		String sql2 = "UPDATE SURVEY SET STATE = 'ONGOING' WHERE CODE = ?";		
		try {
			conn= getConnection();
			pstmt= conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = -1;
				return result;
			}
			pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, code);
			pstmt2.executeUpdate();
			
			result = 1;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
			if (pstmt2 != null) try { pstmt2.close(); } catch (SQLException e) {}
			if (conn != null) try { conn.close(); } catch (SQLException e) {}
			if (rs != null) try { rs.close(); } catch (SQLException e) {}
		}
		return result;
	}
	
	public int completeSurvey (String code) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int result=0;
		String sql = "UPDATE SURVEY SET STATE = 'COMPLETE' WHERE CODE = ?";
		
	
		try {
			conn= getConnection();
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, code);
			pstmt.executeUpdate();
			
			result = 1;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
			if (conn != null) try { conn.close(); } catch (SQLException e) {}
		}
		return result;
	}
}