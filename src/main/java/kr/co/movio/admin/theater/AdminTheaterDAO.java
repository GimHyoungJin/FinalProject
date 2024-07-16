package kr.co.movio.admin.theater;

import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class AdminTheaterDAO {

    private List<AdminTheaterDTO> theaters;

    public AdminTheaterDAO() {
        theaters = new ArrayList<>();
        // 더미 데이터 추가
        theaters.add(new AdminTheaterDTO(1, "seoul", "Theater 1", "Address 1", 5, 100, 37.5665, 126.9780));
        theaters.add(new AdminTheaterDTO(2, "busan", "Theater 2", "Address 2", 7, 150, 35.1796, 129.0756));
        theaters.add(new AdminTheaterDTO(3, "daegu", "Theater 3", "Address 3", 10, 200, 35.8714, 128.6014));
        theaters.add(new AdminTheaterDTO(4, "incheon", "Theater 4", "Address 4", 3, 80, 37.4563, 126.7052));
        theaters.add(new AdminTheaterDTO(5, "gwangju", "Theater 5", "Address 5", 8, 180, 35.1595, 126.8526));
    }

    public List<AdminTheaterDTO> getAllTheaters() {
        return theaters;
    }

    public void addTheater(AdminTheaterDTO theater) {
        theaters.add(theater);
    }

    public void removeTheater(int theaterId) {
        theaters.removeIf(theater -> theater.getTheaterId() == theaterId);
    }
}