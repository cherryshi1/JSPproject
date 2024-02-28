package dao;
import java.sql.Date;
import java.util.*;
import dto.BoardDTO;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

public class BoardDAO extends JDBConnect{
	
	public BoardDAO(ServletContext application) {
		super(application);
	}
	
	// 전체 게시글의 수를 반환
		public int selectCount(Map<String, Object> map) {
			int totalCount = 0;
			
			String query = "SELECT COUNT(*) FROM board ";
			if(map.get("searchWord") != null) {
				query+= " WHERE " + map.get("searchField") + " "
						+ "LIKE '%" + map.get("searchWord") + "%'";
			}
			
			try {
				stmt = conn.createStatement();
				rs = stmt.executeQuery(query); // 쿼리 실행
				
				rs.next();
				
				totalCount = rs.getInt(1);  // 쿼리 결과의 첫번째 값을 얻어옴
				
			} catch(Exception e) {
				System.out.println("게시글의 수를 조회하는 중 에러 발생...");
				e.printStackTrace();
			}
			
			return totalCount;
		}
	
	/*
	 * 게시물의 목록을 조회하여 반환
	 */
	public List<BoardDTO> selectList(Map<String, Object> map) {
		List<BoardDTO> list = new ArrayList<>();
		
		String query = "SELECT * FROM board";
		
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ "LIKE '%" + map.get("searchWord") + "%'";
		}
		query += " ORDER BY releasedate DESC";	// 시퀀스 번호 역순 정렬
		
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				
				dto.setId(rs.getString("id"));
				dto.setMovie(rs.getString("movie"));
				dto.setTitle(rs.getString("title"));
				dto.setGenre(rs.getString("genre"));
				dto.setReleasedate(rs.getString("releasedate"));
				dto.setImg(rs.getString("img"));
				dto.setSynopsis(rs.getString("synopsis"));
				dto.setViews(rs.getInt("views"));
				
				list.add(dto);
			}
		} catch(Exception e) {
			System.out.println("게시물 목록 조회중 오류");
			e.printStackTrace();
		}
		
		return list;
	}
	
//	public List<BoardDTO> selectListPerPage(Map<String, Object> map, int start, int end) {
	public List<BoardDTO> selectListPerPage(Map<String, Object> map, int page) {
	    List<BoardDTO> list = new ArrayList<>();
	    
	    String query = "SELECT * FROM "
	    		+ "(select * "
	    		+ "FROM ( "
	    		+ "select row_number() over(order by releasedate DESC) RNUM, b.* "
	    		+ "from board b ";
	    
	    if(map.get("searchWord") != null) {
	        query += " WHERE " + map.get("searchField") + " "
	                + "LIKE '%" + map.get("searchWord") + "%' ";
	    }
	    
	    query += ") WHERE RNUM <= " + (page*10) + ") "; // 시퀀스 번호 역순 정렬
	    query += " WHERE RNUM > " + (page-1)*10;
	     
	    try {
	    	stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
	        
	        while(rs.next()) {
	            BoardDTO dto = new BoardDTO();
	            
	            dto.setId(rs.getString("id"));
	            dto.setMovie(rs.getString("movie"));
	            dto.setTitle(rs.getString("title"));
	            dto.setGenre(rs.getString("genre"));
	            dto.setReleasedate(rs.getString("releasedate"));
	            dto.setImg(rs.getString("img"));
	            dto.setSynopsis(rs.getString("synopsis"));
	            dto.setViews(rs.getInt("views"));
	            
	            list.add(dto);
	        }
	    } catch(Exception e) {
	        System.out.println("게시물 목록 조회중 오류");
	        e.printStackTrace();
	    }
	    
	    return list;
	}
	
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		
		try {
			// INSERT 쿼리문 작성
			String query = "INSERT INTO board("
					+ "movie, title, genre, releasedate, img, synopsis, trailer)"
					+ "VALUES("
					+ "seq_board_num.NEXTVAL, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getGenre());
			pstmt.setString(3, dto.getReleasedate());
			pstmt.setString(4, dto.getImg());
			pstmt.setString(5, dto.getSynopsis());
			pstmt.setString(6, dto.getTrailer());
			
			
			result = pstmt.executeUpdate();
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	public BoardDTO DetailView(String movie) {
		BoardDTO dto = new BoardDTO();

		String query = "SELECT * " + " FROM board " + " WHERE movie=?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, movie);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto.setMovie(rs.getString("movie"));
				dto.setTitle(rs.getString("title"));
				dto.setGenre(rs.getString("genre"));
				dto.setId(rs.getString("id"));
				dto.setReleasedate(rs.getString("releasedate"));
				dto.setSynopsis(rs.getString("synopsis"));
				dto.setNickname(rs.getString("nickname"));
				dto.setImg(rs.getString("img"));
				dto.setTrailer(rs.getString("trailer"));
				dto.setViews(rs.getInt("views"));
			}

		} catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생...");
			e.printStackTrace();
		}
		return dto;

	}
	
	public int deletePost(BoardDTO dto) {
		int result = 0;
		try {
			// 쿼리문 작성
			String query = "DELETE FROM board WHERE movie=?";
			
			// 쿼리문 완성
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, dto.getMovie());
			
			// 쿼리문 실행
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("게시물 삭제 중 예외 발생...");
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int updateEdit(BoardDTO dto) {
		int result = 0;
		
		try {
			// 쿼리문 준비
			String query = "UPDATE board SET "
						 + " title=?, genre=?, releasedate=?, synopsis=?, img=?, trailer=? "
						 + " WHERE movie=?";
			
			// 쿼리문 완성
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2,  dto.getGenre());
			pstmt.setString(3,  dto.getReleasedate());
			pstmt.setString(4, dto.getSynopsis());
			
			pstmt.setString(5,  dto.getImg());
			pstmt.setString(6,  dto.getTrailer());
			pstmt.setString(7,  dto.getMovie());
			
			// 쿼리문 실행
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	public BoardDTO UpViews(String movie) {
		BoardDTO dto = new BoardDTO();

		String query = "UPDATE board SET views = views+1 "
					+ " WHERE movie=?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, movie);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				
				dto.setViews(rs.getInt("views"));
			}

		} catch (Exception e) {
			System.out.println("조회수 업데이트 중 오류 발생...");
			e.printStackTrace();
		}
		return dto;

	}
	
	public List<BoardDTO> BestList() {
		List<BoardDTO> resultList = new ArrayList<>();
		
		String query = "SELECT rownum, A.* "
				+ " FROM (SELECT * FROM board "
				+ " ORDER BY views DESC) A "
				+ " WHERE rownum <= 3 ";

		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setMovie(rs.getString("movie"));
				dto.setTitle(rs.getString("title"));
				dto.setGenre(rs.getString("genre"));
				dto.setId(rs.getString("id"));
				dto.setReleasedate(rs.getString("releasedate"));
				dto.setSynopsis(rs.getString("synopsis"));
				dto.setNickname(rs.getString("nickname"));
				dto.setImg(rs.getString("img"));
				dto.setTrailer(rs.getString("trailer"));
				dto.setViews(rs.getInt("views"));
				
				resultList.add(dto);
			}

		} catch (Exception e) {
			System.out.println("상위 게시물 조회 중 예외 발생...");
			e.printStackTrace();
		}
		return resultList;
	}
	
	public List<BoardDTO> OpenList() {
		List<BoardDTO> resultList = new ArrayList<>();
		
		String query = "SELECT * FROM( "
				+ " SELECT board.*, (TO_DATE(releasedate, 'YYYY-MM-DD') - SYSDATE) "
				+ " FROM board "
				+ " WHERE TO_DATE(releasedate, 'YYYY-MM-DD') > SYSDATE "
				+ " ORDER BY TO_DATE(releasedate, 'YYYY-MM-DD') DESC "
				+ " ) WHERE ROWNUM <= 3";

		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setMovie(rs.getString("movie"));
				dto.setTitle(rs.getString("title"));
				dto.setGenre(rs.getString("genre"));
				dto.setId(rs.getString("id"));
				dto.setReleasedate(rs.getString("releasedate"));
				dto.setSynopsis(rs.getString("synopsis"));
				dto.setNickname(rs.getString("nickname"));
				dto.setImg(rs.getString("img"));
				dto.setTrailer(rs.getString("trailer"));
				dto.setViews(rs.getInt("views"));
				
				resultList.add(dto);
			}

		} catch (Exception e) {
			System.out.println("상위 게시물 조회 중 예외 발생...");
			e.printStackTrace();
		}
		return resultList;
	}
	
}
