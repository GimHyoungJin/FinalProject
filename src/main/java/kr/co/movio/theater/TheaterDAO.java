package kr.co.movio.theater;

import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class TheaterDAO {
    private final DataSource dataSource;

    // DataSource를 주입받는 생성자
    public TheaterDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    // 모든 극장 정보를 가져오는 메서드
    public List<TheaterDTO> getAllTheaters() {
        List<TheaterDTO> theaters = new ArrayList<>();
        String sql = "SELECT * FROM theater";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            // 결과 집합에서 데이터를 추출하여 TheaterDTO 객체로 변환 후 리스트에 추가
            while (rs.next()) {
                TheaterDTO theater = new TheaterDTO();
                theater.setTheater_id(rs.getString("theater_id"));
                theater.setRegion_id(rs.getString("region_id"));
                theater.setTheater_name(rs.getString("theater_name"));
                theater.setAddress(rs.getString("address"));
                theater.setTheaters_num(rs.getInt("theaters_num"));
                theater.setTotal_seats(rs.getInt("total_seats"));
                theater.setLatitude(rs.getDouble("latitude"));
                theater.setLongitude(rs.getDouble("longitude"));
                theaters.add(theater);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return theaters;
    }

    // 특정 극장 ID로 극장 정보를 가져오는 메서드
    public TheaterDTO getTheaterByNo(String theaterNo) {
        TheaterDTO theater = null;
        String sql = "SELECT * FROM theater WHERE theater_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, theaterNo);
            try (ResultSet rs = stmt.executeQuery()) {
                // 결과 집합에서 데이터를 추출하여 TheaterDTO 객체로 변환
                if (rs.next()) {
                    theater = new TheaterDTO();
                    theater.setTheater_id(rs.getString("theater_id"));
                    theater.setRegion_id(rs.getString("region_id"));
                    theater.setTheater_name(rs.getString("theater_name"));
                    theater.setAddress(rs.getString("address"));
                    theater.setTheaters_num(rs.getInt("theaters_num"));
                    theater.setTotal_seats(rs.getInt("total_seats"));
                    theater.setLatitude(rs.getDouble("latitude"));
                    theater.setLongitude(rs.getDouble("longitude"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return theater;
    }

    // 특정 극장 ID로 극장 상세 정보를 가져오는 메서드
    public List<TheaterInfoDTO> getTheaterInfoByTheaterId(String theaterId) {
        List<TheaterInfoDTO> theaterInfoList = new ArrayList<>();
        String sql = "SELECT theater_id, info_type, info_content FROM theater_info WHERE theater_id = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, theaterId);
            try (ResultSet rs = stmt.executeQuery()) {
                // 결과 집합에서 데이터를 추출하여 TheaterInfoDTO 객체로 변환 후 리스트에 추가
                while (rs.next()) {
                    TheaterInfoDTO theaterInfoDTO = new TheaterInfoDTO();
                    theaterInfoDTO.setTheaterId(rs.getInt("theater_id"));
                    theaterInfoDTO.setInfoType(rs.getString("info_type"));
                    theaterInfoDTO.setInfoContent(rs.getString("info_content"));
                    theaterInfoList.add(theaterInfoDTO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return theaterInfoList;
    }
}
