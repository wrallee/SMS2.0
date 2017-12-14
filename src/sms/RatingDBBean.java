package sms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RatingDBBean {
	
	private static RatingDBBean instance = new RatingDBBean();

	public static RatingDBBean getInstance() {
		return instance;
	}

	private RatingDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/OracleDB");
		return ds.getConnection();
	}
//-------------------------------------이름로그인 추가-------------------------------------------
	public String getIdFromName(String name) {
		String id = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select * from worker where name = ?");
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				id = rs.getString("id");
				System.out.println(id);
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (Exception e2) {}}
			if (pstmt != null) {try {pstmt.close();} catch (Exception e2) {}}
			if (conn != null) {try {conn.close();} catch (Exception e2) {}}
		}
		return id;
	}
//-------------------------------------이름로그인 추가-------------------------------------------
	public String getDept(String id) {
		String dept = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select dept from worker where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dept = rs.getString("dept");
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e2) {
				}
			}
		}

		return dept;

	}
	
	public String getName(String id) {
		String name = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select name from worker where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				name = rs.getString("name");
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e2) {
				}
			}
		}

		return name;

	}

	public ArrayList<RatingDataBean> getMemberlist(String dept) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RatingDataBean ratingData = null;
		ArrayList<RatingDataBean> worker_list = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from worker where dept = ?");
			pstmt.setString(1, dept);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				worker_list = new ArrayList<RatingDataBean>();
				do {
					ratingData = new RatingDataBean();
					ratingData.setId(rs.getString("id"));
					ratingData.setName(rs.getString("name"));
					ratingData.setDept(rs.getString("dept"));
					ratingData.setAddr(rs.getString("addr"));
					worker_list.add(ratingData);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e2) {
				}
			}
		}

		return worker_list;
	}
	
	public int getMemberlistCount(String dept) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RatingDataBean ratingData = null;
		ArrayList<RatingDataBean> worker_list = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from worker where dept = ?");
			pstmt.setString(1, dept);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				worker_list = new ArrayList<RatingDataBean>();
				do {
					ratingData = new RatingDataBean();
					ratingData.setId(rs.getString("id"));
					ratingData.setName(rs.getString("name"));
					ratingData.setDept(rs.getString("dept"));
					ratingData.setAddr(rs.getString("addr"));
					worker_list.add(ratingData);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e2) {
				}
			}
		}

		return worker_list.size();
	}

	public int userCheck(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String chkId = null;
		int x = -1;
		if( id.equals( "admin" ) )
			return 1 ;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from worker where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				chkId = rs.getString("id");
				if (chkId.equals("admin")) {
					x = 1;
				} else {
					x = 0;
				}
			} else {
				x = -1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
				}
			}
		}
		return x;
	}

	public SurveyDataBean getSurveyInfo() throws Exception {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	
		SurveyDataBean sb = null;
		try {
			
			conn = getConnection();
			
			String sql = "select * from SURVEY where state = 'ONGOING'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	
				sb = new SurveyDataBean();
				sb.setCode(rs.getString("code"));
				sb.setTitle(rs.getString("title"));
				sb.setMemo(rs.getString("memo"));
				sb.setState(rs.getString("state"));
				sb.setCre_date(rs.getString("cre_date"));
				sb.setStart_date(rs.getString("start_date"));
			}else {
				return null ;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
			} catch (Exception e2) {
			}
			try {
				if (conn != null) conn.close();
			} catch (Exception e2) {
			}
			try {
				if (rs != null) rs.close();
			} catch (Exception e2) {
			}
		}
		
		return sb;	
	}
	
	
	public int getRSMDColCount(String code) { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		int ans = -1;
		try {
			conn = getConnection();
			
			String sql = "select * from " + code;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			rsmd = rs.getMetaData();
			ans =  rsmd.getColumnCount();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
			} catch (Exception e2) {
			}
			try {
				if (conn != null) conn.close();
			} catch (Exception e2) {
			}
			try {
				if (rs != null) rs.close();
			} catch (Exception e2) {
			}
		}
		return ans;
	}
	
	public String getRSMDColName(String code, int column) { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String name = null;
		try {
			conn = getConnection();
			
			String sql = "select * from " + code;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			rsmd = rs.getMetaData();
			name = rsmd.getColumnName(column);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
			} catch (Exception e2) {
			}
			try {
				if (conn != null) conn.close();
			} catch (Exception e2) {
			}
			try {
				if (rs != null) rs.close();
			} catch (Exception e2) {
			}
		}
		return name;
	}
	
	public int dataSaving(String[][] data, String rater, String surveyCode) {
		for (int i = 0; i < data.length; i++) {
			data[i][0] = rater;
			for (int j = 0; j < data[0].length; j++) {
				System.out.print(data[i][j] + "\t");
			}
			System.out.println();
		}
		Connection con = null;
		Connection con2 = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		int res = 0;
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleDB");
			con2 = ds.getConnection();
			pstmt2 = con2.prepareStatement("DELETE FROM " + surveyCode + " where rater = ?");
			System.out.println("데이터세이빙  :" + surveyCode);
			pstmt2.setString(1, rater);
			pstmt2.executeQuery();
			// 기존의 데이터들을 지운다.
			for(int i = 0; i < data.length; i++) {
				boolean chk = false;
				con = ds.getConnection();
				String subSql = " VALUES (?,?";
				for (int j = 0; j < data[0].length - 2; j++) {
					subSql += ",?";
				}
				subSql += ")";
				pstmt = con.prepareStatement("INSERT INTO " + surveyCode + subSql);
				
				// 데이터 값이 하나라도 null이면 다음 대상자 평가로 넘어간다.
				for (int k = 2; k < data[0].length; k++ ) {
					if (data[i][k] == null) {
						chk = true;
						break;
					}
				}
				if (chk) {
					continue;
				}
				pstmt.setString(1, data[i][0]);
				pstmt.setString(2, data[i][1]);
				for (int j = 3; j <= data[0].length; j++) {
					pstmt.setInt(j, Integer.parseInt(data[i][j - 1]));
				}
				res += pstmt.executeUpdate();
				System.out.println("데이터 입력 성공! (" + (i + 1) + "행)");
			}
		} catch (Exception ex) {
			System.out.println("가입오류 : " + ex.getMessage());
			ex.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			}
			if (pstmt2 != null) {
				try {
					pstmt2.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
			if (con2 != null) {
				try {
					con2.close();
				} catch (Exception e) {
				}
			}
		}
		return res;
	}
	
	
	public String[][] dataLoading(String rater, String dept, String surveyCode) {
		String data[][] = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		int memberCount = 0;
		int i = 0;
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
			System.out.println("데이터로딩 : " + rater+ " " + surveyCode);
			pstmt = conn.prepareStatement("SELECT * FROM " + surveyCode + " WHERE RATER = ?");
			System.out.println("select문");
			pstmt.setString(1, rater);
			rs = pstmt.executeQuery();
			System.out.println("실행완료");
			rsmd = rs.getMetaData();
			memberCount = getMemberlistCount(dept);
			data = new String[memberCount - 1][rsmd.getColumnCount()];
			
			System.out.println("memberCount : " + memberCount);
			while (rs.next()) {
				for (int j = 0; j < rsmd.getColumnCount(); j++) {				
					data[i][j] = rs.getString(j + 1);		
				}
				i++;
				
			} 
			// 콘솔확인구문
			for (int j = 0; j < i; j++) {
				for (int j2 = 0; j2 < rsmd.getColumnCount(); j2++) {
					System.out.print(data[j][j2] + "  ");
				}
				System.out.println();
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return data;
	}


	
}

