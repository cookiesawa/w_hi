package ch11;

import java.sql.*;

public class LogonDBBean {
	//LogonDBBean 전역 객체 생성 <- 한개의 객제만 생성해서 공유 스레드, 인스턴트 상관없이 접근할 수 있도록
	private static LogonDBBean instance = new LogonDBBean();
	
	//LogonDBBean객체를 리턴하는 메소드
	public static LogonDBBean getInstance() {
		return instance;
	}
	
	private LogonDBBean() {
	
	}
	
	//개별 커넥션 객체를 얻어내는 메소드
	private Connection getConnection() throws Exception {
		String jdbcUrl = "jdbc:mysql://128.134.114.237:3306/db216230117"; //URL
		String dbId = "216230117"; //사용자 계정
		String dbPass = "hyw216230117"; //계정 패스워드  
		 
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection(jdbcUrl, dbId, dbPass);
	}
	
	// 아이디 중복 확인 (confirmId.jsp)에서 아이디의 중복 여부를 확인하는 메소드
	// 예전에는 코드값을 리턴해서 사용했는데 boolean값이 코드 재사용에 더 유리하고 명확
	public boolean confirmId(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
			
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select id from member where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			 
			result = rs.next();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result == false;
	}
	
	//회원 가입 처리(registerPro.jsp)에서 사용하는	새 레코드 추가 메소드
	public void insertMember(LogonDataBean member){
		Connection conn = null;
		PreparedStatement pstmt = null;
			
		try {
			conn = getConnection();
			// 이런 형식으로 작성하기
			pstmt = conn.prepareStatement("insert into member(id, passwd, name, reg_date, address, tel) values (?,?,?,?,?,?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setTimestamp(4, member.getRegDate());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getTel()); 
			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
	} 
		
	// 로그인 폼 처리(loginPro.jsp)페이지의 사용자 인증 처리 및 회원정보수정/탈퇴를
	// 사용자인증(memberCheck.jsp)에서 사용하는 메소드
	public boolean userCheck(String id, String passwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		boolean result = false;
			
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select passwd from member where id = ? and passwd = ?");
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();
				 
			result = rs.next();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
	
	//회원 정보 수정 폼(modifyForm.jsp)을 위한 기존 가입 정보를 가져오는 메소드
	public LogonDataBean getMember(String id){
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    LogonDataBean member = null;
	    try {
	        conn = getConnection();
	        pstmt = conn.prepareStatement("select id, passwd, name, reg_date, address, tel from member where id = ?");
	        pstmt.setString(1, id);
	        rs = pstmt.executeQuery();
	        if(rs.next()) {
	            member = new LogonDataBean();//데이터저장빈 객체생성
	            member.setId(rs.getString("id"));
	            member.setName(rs.getString("name"));
	            member.setRegDate(rs.getTimestamp("reg_date"));
	            member.setAddress(rs.getString("address"));
	            member.setTel(rs.getString("tel"));            
	        }
	    } catch(Exception ex) {
	        ex.printStackTrace();
	    } finally {
	        if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	    }
	    return member;//데이터 저장빈 객체 member 리턴
	}

	//회원 정보 수정 처리(modifyPro.jsp)에서 회원 정보 수정을 처리하는 메소드
	public boolean updateMember(LogonDataBean member){
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs= null;
	    try {
	        conn = getConnection();
	        pstmt = conn.prepareStatement("select passwd from member where id = ? and passwd = ?");
	        pstmt.setString(1, member.getId());
	        pstmt.setString(2, member.getPasswd());
	        rs = pstmt.executeQuery();
	        boolean exists = rs.next();
	        rs.close(); rs = null;
	        pstmt.close(); pstmt = null;
	        if(exists) {
	            pstmt = conn.prepareStatement("update member set name = ?, address = ?, tel = ? where id = ?");
	            pstmt.setString(1, member.getName());
	            pstmt.setString(2, member.getAddress());
	            pstmt.setString(3, member.getTel());
	            pstmt.setString(4, member.getId());
	            pstmt.executeUpdate();
	            return true;
	        }
	    } catch(Exception ex) { ex.printStackTrace();
	    } finally { /* 자원해제 */ }
	    return false;
	}

	//회원 탈퇴 처리(deletePro.jsp)에서 회원 정보를 삭제하는 메소드
	public boolean deleteMember(String id, String passwd) {
	  Connection conn = null;
	  PreparedStatement pstmt = null;
	  try {
	    conn = getConnection();
	    pstmt = conn.prepareStatement("delete from member where id = ? and passwd = ?");
	    pstmt.setString(1, id);
	    pstmt.setString(2, passwd);
	    int x = pstmt.executeUpdate();
	    return x == 1;
	  } catch(Exception ex) {
	    ex.printStackTrace();
	  } finally {
	    if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	    if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	  }
	  return false;
	}

	//////////////////////////////////
	// 비밀번호 변경 처리(pwmodifyPro.jsp)에서 회원 정보 수정을 처리하는 메소드
		public boolean pwupdateMember(LogonDataBean member){
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs= null;
		    try {
		        conn = getConnection();
		        pstmt = conn.prepareStatement("select passwd from member where id = ? and passwd = ?");
		        pstmt.setString(1, member.getId());
		        pstmt.setString(2, member.getPasswd());
		        rs = pstmt.executeQuery();
		        boolean exists = rs.next();
		        rs.close(); rs = null;
		        pstmt.close(); pstmt = null;
		        if(exists) {
		            pstmt = conn.prepareStatement("update member set passwd = ? where id = ?");
		            pstmt.setString(1, member.getPasswd());
		            pstmt.setString(2, member.getId());
		            pstmt.executeUpdate();
		            return true;
		        }
		    } catch(Exception ex) { ex.printStackTrace();
		    } finally { /* 자원해제 */ }
		    return false;
		}

	
}







