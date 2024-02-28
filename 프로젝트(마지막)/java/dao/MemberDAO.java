package dao;
import common.JDBConnect;
import dto.MemberDTO;
import jakarta.servlet.ServletContext;
import java.sql.*;

public class MemberDAO extends JDBConnect{
	// 생성자에서 DB 연결작업 진행
	public MemberDAO(ServletContext application) {
		// JDBConnect(application) 생성자 호출
		super(application);
	}
	
	public MemberDTO getMemberDTO(String id, String pwd) {
		String sql = "SELECT * FROM member WHERE id=? and pwd=?";
		MemberDTO dto = new MemberDTO();	// 조회한 회원정보를 저장하는 객체
		
		try {
			// 쿼리 실행
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
		
			// 조회 결과 처리
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPwd(rs.getString("pwd"));
				dto.setNickname(rs.getString("nickname"));
				dto.setEmail(rs.getString("email"));
				dto.setUserkey(rs.getString("userkey"));
				dto.setPhone(rs.getString("phone"));	
			}
		} catch(Exception e) {
			System.out.println("회원 정보 조회중 오류");
			e.printStackTrace();
		} finally {
			close();
		}
		return dto;
	}
	
	public int insertWrite(MemberDTO dto) { 
		int result = 0;
		
		try {
		String query = "INSERT INTO member("
				  + "id, pwd, nickname, email, userkey, phone)"
				  + "VALUES("
				  + "?, ?, ?, ?, ?, ?)";
		
		pstmt = conn.prepareStatement(query);
		
		pstmt.setString(1, dto.getId());
		pstmt.setString(2, dto.getPwd());
		pstmt.setString(3, dto.getNickname());
		pstmt.setString(4, dto.getEmail());
		pstmt.setString(5, dto.getUserkey());
		pstmt.setString(6, dto.getPhone());
		
		result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("회원가입중 오류 발생");
		}
		
		return result;
		
		
	}
	//회원 정보 수정을 위한 userId만 사용한 메서드
	public MemberDTO getMemberById(String userId) {
	    String sql = "SELECT * FROM member WHERE id=?";
	    MemberDTO dto = new MemberDTO(); // 조회한 회원정보를 저장하는 객체

	    try {
	        // 쿼리 실행
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userId);
	        rs = pstmt.executeQuery();

	        // 조회 결과 처리
	        if(rs.next()) {
	            dto.setId(rs.getString("id"));
	            dto.setPwd(rs.getString("pwd"));
	            dto.setNickname(rs.getString("nickname"));
	            dto.setEmail(rs.getString("email"));
	            dto.setUserkey(rs.getString("userkey"));
	            dto.setPhone(rs.getString("phone"));  
	        }
	    } catch(Exception e) {
	        System.out.println("회원 정보 조회중 오류");
	        e.printStackTrace();
	    } finally {
	        close();
	    }
	    return dto;
	}
	

	    // 회원 정보 업데이트
	    public int updateMemberInfo(MemberDTO member) {
	        int result = 0;
	        try {
	            String sql = "UPDATE member SET nickname=?, email=?, phone=? WHERE id=?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, member.getNickname());
	            pstmt.setString(2, member.getEmail());
	            pstmt.setString(3, member.getPhone());
	            pstmt.setString(4, member.getId());
	            result = pstmt.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	            System.out.println("회원 정보 업데이트 중 오류 발생");
	        } finally {
	            close();
	        }
	        return result;
	    }
	
	    //회원가입시 아이디 중복검사
	    public boolean checkIdExists(String id) {
	        String sql = "SELECT id FROM member WHERE id = ?";
	        try {
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, id);
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next()) {
	                return true; // 이미 존재하는 아이디
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false; // 존재하지 않는 아이디
	    }
	    
	    //회원가입시 이메일 중복검사
	    public boolean checkEmailExists(String email) {
	        String sql = "SELECT email FROM member WHERE email = ?";
	        try {
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, email);
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next()) {
	                return true; // 이미 존재하는 이메일
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false; // 존재하지 않는 이메일
	    }
	    

	        // 기타 멤버 변수 및 메소드

	        // 회원 탈퇴 처리 메소드
	   
	        public boolean unregisterMember(String userId) {
	            // SQL 문장
	            String sql = "DELETE FROM member WHERE id = ?";

	            // PreparedStatement 선언
	            PreparedStatement pstmt = null;

	            try {
	                // PreparedStatement 초기화
	                pstmt = conn.prepareStatement(sql);
	                pstmt.setString(1, userId);

	                // SQL 실행
	                int rowsAffected = pstmt.executeUpdate();

	                // SQL 실행 결과에 따라 true 또는 false 반환
	                return (rowsAffected > 0);
	            } catch (SQLException e) {
	                // 오류 발생 시 예외 처리
	                e.printStackTrace();
	                return false; // 실패로 처리
	            } finally {
	                // 자원 해제
	                try {
	                    if (pstmt != null) {
	                        pstmt.close();
	                    }
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            }
	        }

// 이메일을 기반으로 아이디 찾기 메서드
	        public String findIDByEmail(String email) {
	            String foundID = null;
	            PreparedStatement pstmt = null;
	            ResultSet rs = null;

	            try {
	                String sql = "SELECT id FROM member WHERE email = ?";
	                pstmt = conn.prepareStatement(sql);
	                pstmt.setString(1, email);
	                rs = pstmt.executeQuery();

	                if (rs.next()) {
	                    foundID = rs.getString("id");
	                }
	            } catch (SQLException e) {
	                System.out.println("아이디 찾기 중 오류 발생");
	                e.printStackTrace();
	            } finally {
	                // 자원 해제
	                close();
	            }
	            return foundID;
	        }



	        // 비밀번호 찾기 메서드
	        public String findPassword(String id, String email) {
	            String foundPassword = null;
	            PreparedStatement pstmt = null;
	            ResultSet rs = null;
	            
	            try {
	                String sql = "SELECT pwd FROM member WHERE id = ? AND email = ?";
	                pstmt = conn.prepareStatement(sql);
	                pstmt.setString(1, id);
	                pstmt.setString(2, email);
	                rs = pstmt.executeQuery();
	                
	                if (rs.next()) {
	                    foundPassword = rs.getString("pwd");
	                }
	            } catch (SQLException e) {
	            	System.out.println("비밀번호 찾기 중 오류 발생");
	                e.printStackTrace();
	            } finally {
	                // 자원 해제
	                close();
	            }

	            return foundPassword;
	        }
		
	    
}
