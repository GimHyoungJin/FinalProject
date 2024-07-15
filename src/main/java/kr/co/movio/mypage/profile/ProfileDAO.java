package kr.co.movio.mypage.profile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;

public class ProfileDAO {

    private DataSource dataSource;

    public ProfileDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public ProfileDTO getProfile(String userId) throws SQLException {
        String query = "SELECT * FROM profiles WHERE user_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProfileDTO profile = new ProfileDTO();
                    // 필드 설정
                    return profile;
                }
            }
        }
        return null;
    }
}
