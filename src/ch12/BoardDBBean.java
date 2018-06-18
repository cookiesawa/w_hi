package ch12;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class BoardDBBean {
	
	private static BoardDBBean instance = new BoardDBBean();
	
    // jsp에서 DB연동빈인 BoardDBBean클래스의 메소드에 접근시 필요
    public static BoardDBBean getInstance() {
        return instance;
    }
    
    private BoardDBBean(){}
    
    //커넥션풀로부터 Connection객체를 얻어냄 : DB연동빈의 쿼리문을 수행하는 메소드에서 사용
    private Connection getConnection() throws Exception {
      String jdbcUrl = "jdbc:mysql://128.134.114.237:3306/db216230117"; //URL
      String dbId = "216230117"; //사용자 계정
      String dbPass = "hyw216230117"; //계정 패스워드

      Class.forName("com.mysql.jdbc.Driver");

      return DriverManager.getConnection(jdbcUrl, dbId, dbPass);
    }
    
    private void release(Statement stmt, Connection conn) {
    	this.release(stmt);
    	this.release(conn);
    }
    private void release(ResultSet rs, Statement stmt) {
    	this.release(rs);
    	this.release(stmt);
    }
    private void release(ResultSet rs, Statement stmt, Connection conn) {
    	this.release(rs);
    	this.release(stmt);
    	this.release(conn);
    }
    private void release(ResultSet rs) {
    	if(rs != null) {
    		try{ rs.close(); } catch(SQLException ex) {}
    	}
    }
    private void release(Statement stmt) {
    	if(stmt != null) {
    		try{ stmt.close(); } catch(SQLException ex) {}
    	}
    }
    private void release(Connection conn) {
    	if(conn != null) {
    		try{ conn.close(); } catch(SQLException ex) {}
    	}
    }
    
    
    // board테이블에 저장된 전체글의 수를 조회 <= list.jsp에서 사용
	public int getArticleCount() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int x = 0;

        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select count(*) from board");
            rs = pstmt.executeQuery();

            if (rs.next()) x = rs.getInt(1);
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
        	this.release(rs, pstmt, conn);
        }
		return x;
    }
	
    //글의 목록 조회 <= list.jsp
	public List<BoardDataBean> getArticles(int start, int end) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<BoardDataBean> articleList = new ArrayList<BoardDataBean>();//글목록을 저장하는 객체
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"select num, writer, subject, content, passwd, reg_date, ip"
            	+ ", readcount, ref, re_step, re_level"
            	+ " from board order by ref desc, re_step asc limit ?, ? ");
            pstmt.setInt(1, start - 1);
			pstmt.setInt(2, end);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	BoardDataBean article= new BoardDataBean();
            	article.setNum(rs.getInt("num")); 
            	article.setWriter(rs.getString("writer"));
            	article.setSubject(rs.getString("subject"));
            	article.setContent(rs.getString("content"));
            	article.setPasswd(rs.getString("passwd"));
            	article.setRegDate(rs.getTimestamp("reg_date"));
            	article.setReadcount(rs.getInt("readcount"));
            	article.setRef(rs.getInt("ref"));
            	article.setReStep(rs.getInt("re_step"));
            	article.setReLevel(rs.getInt("re_level"));
            	article.setIp(rs.getString("ip")); 
            	
            	//List객체에 데이터저장빈인 BoardDataBean객체를 저장
            	articleList.add(article);
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
        	this.release(rs, pstmt, conn);
        }
		return articleList;//List객체의 레퍼런스를 리턴
    }
	
    // board 테이블에 글을 추가(insert 문) <= writePro.jsp에서 사용
	public boolean insertArticle(BoardDataBean article) {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		int number = 0; // board테이블에 들어갈 글번호
        String sql = "";
        
        // 댓글이 가진 정보
		int num = article.getNum();// 제목글의 글번호
		int ref = article.getRef();// 제목글의 그룹화 아이디
		int reStep = article.getReStep();// 그룹내의 글의순서
		int reLevel = article.getReLevel();// 글제목의 들여쓰기

        try {
            conn = getConnection();
            // 현재 board 테이블에 레코드의 유무 판단과 글번호 결정
            pstmt = conn.prepareStatement("select max(num) from board");
			rs = pstmt.executeQuery();
			
			if(rs.next())//기존에 레코드가 존재
		      number = rs.getInt(1) + 1; //다음글 번호는 가장큰 글번호+1
		    else//첫번째 글
		      number = 1;
			
			this.release(rs, pstmt); // 자원해제
			
		   // 제목글과 댓글 간의 순서를 결정
		    if (num != 0) { // 댓글 - 제목글의 글번호 가짐
		      sql = "update board set re_step = re_step + 1 where ref = ? and re_step > ?";
              pstmt = conn.prepareStatement(sql);
              pstmt.setInt(1, ref);
			  pstmt.setInt(2, reStep);
			  pstmt.executeUpdate();
			  reStep = reStep + 1;
			  reLevel = reLevel + 1;
			  
			  this.release(pstmt); // 자원해제
		    } else {//제목글 - 글번호 없음
		  	  ref = number;
			  reStep = 0;
			  reLevel = 0;
		    }
		    
            // 쿼리를 작성 :board테이블에 새로운 레코드 추가
            sql = "insert into board(writer, subject, content, passwd, reg_date, ip, ref, re_step, re_level)"
            		+ " values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, article.getWriter());
            pstmt.setString(2, article.getSubject());
            pstmt.setString(3, article.getContent());
            pstmt.setString(4, article.getPasswd());
			pstmt.setTimestamp(5, article.getRegDate());
			pstmt.setString(6, article.getIp());
            pstmt.setInt(7, ref);
            pstmt.setInt(8, reStep);
            pstmt.setInt(9, reLevel);
            
            x = pstmt.executeUpdate(); //레코드 추가 성공
            
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
        	this.release(rs, pstmt, conn);
        }
        return x == 1;
    }
	
  	//글삭제처리시 사용(delete문)<=deletePro.jsp에서 사용
  	public boolean deleteArticle(int num, String passwd) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int x = -1;
        try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from board where num = ? and passwd = ?");
            pstmt.setInt(1, num);
            pstmt.setString(2, passwd);
            x = pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
        	this.release(pstmt, conn);
        }
		return x == 1;
  	}

    //글 수정폼에서 사용할 글의 내용(1개의 글)<=updateForm.jsp에서 사용
    public BoardDataBean updateGetArticle(int num) {
        Connection conn = null; PreparedStatement pstmt = null; ResultSet rs = null;
        BoardDataBean article = new BoardDataBean();
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement("select num, writer, subject, content"
            		+ ", passwd, reg_date, ip, readcount, ref, re_step"
            		+ ", re_level from board where num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
                article.setSubject(rs.getString("subject"));
                article.setPasswd(rs.getString("passwd"));
			    article.setRegDate(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
                article.setRef(rs.getInt("ref"));
                article.setReStep(rs.getInt("re_step"));
				article.setReLevel(rs.getInt("re_level"));
                article.setContent(rs.getString("content"));
			    article.setIp(rs.getString("ip"));     
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally { this.release(rs, pstmt, conn); }
		return article;
    }

    
    
    
    //글 수정처리에서 사용<=updatePro.jsp에서 사용
  	public boolean updateArticle(BoardDataBean article) {
        Connection conn = null; PreparedStatement pstmt = null; ResultSet rs = null;
		int x = -1;
        try {
            conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from board where num = ?"
					+ " and passwd = ?");
            pstmt.setInt(1, article.getNum());
            pstmt.setString(2, article.getPasswd());
            rs = pstmt.executeQuery();
            boolean success = rs.next();
            this.release(rs, pstmt);
            if(success) {
                pstmt = conn.prepareStatement("update board set subject = ?, content = ?"
                		+ " where num = ?");
                pstmt.setString(1, article.getSubject());
                pstmt.setString(2, article.getContent());
			    pstmt.setInt(3, article.getNum());
			    x = pstmt.executeUpdate();
            } else { x = 0; }
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally { this.release(rs, pstmt, conn); }
		return x == 1;
  	}
  	



}








