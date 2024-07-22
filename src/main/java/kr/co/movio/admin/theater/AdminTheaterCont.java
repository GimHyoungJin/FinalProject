package kr.co.movio.admin.theater;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.co.movio.theater.TheaterDAO;
import kr.co.movio.theater.TheaterDTO;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/theater")
public class AdminTheaterCont {

    private final TheaterDAO theaterDAO;

    public AdminTheaterCont(TheaterDAO theaterDAO) {
        this.theaterDAO = theaterDAO;
    }

    @GetMapping
    public String getTheaters(Model model) {
        try {
            List<TheaterDTO> theaters = theaterDAO.getAllTheaters();
            model.addAttribute("theaters", theaters);
            List<Map<String, Object>> regions = theaterDAO.getAllRegions();
            model.addAttribute("regions", regions);
            return "admin/theater";
        } catch (Exception e) {
            return "error"; // 에러 페이지로 리다이렉트
        }
    }

    @PostMapping("/add")
    public String addTheater(@RequestParam("theaterId") String theaterId,
                             @RequestParam("theaterName") String theaterName,
                             @RequestParam("regionId") String regionId,
                             @RequestParam("address") String address,
                             @RequestParam("theatersNum") int theatersNum,
                             @RequestParam("totalSeats") int totalSeats,
                             @RequestParam("latitude") double latitude,
                             @RequestParam("longitude") double longitude,
                             Model model) {
        try {
            TheaterDTO theater = new TheaterDTO();
            theater.setTheater_id(theaterId); // 사용자가 입력한 ID 설정
            theater.setRegion_id(regionId);
            theater.setTheater_name(theaterName);
            theater.setAddress(address);
            theater.setTheaters_num(theatersNum);
            theater.setTotal_seats(totalSeats);
            theater.setLatitude(latitude);
            theater.setLongitude(longitude);

            // Theater 추가하는 메서드 호출
            theaterDAO.addTheater(theater);

            return "redirect:/admin/theater";
        } catch (Exception e) {
            return "error"; // 에러 페이지로 리다이렉트
        }
    }

    @PostMapping("/delete")
    public String deleteTheater(@RequestParam("theaterId") String theaterId) {
        try {
            theaterDAO.softDeleteTheater(theaterId);
            return "redirect:/admin/theater";
        } catch (Exception e) {
            return "error"; // 에러 페이지로 리다이렉트
        }
    }
}
