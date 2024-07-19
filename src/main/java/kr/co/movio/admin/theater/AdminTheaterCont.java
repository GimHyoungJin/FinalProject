package kr.co.movio.admin.theater;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.co.movio.theater.TheaterDAO;
import kr.co.movio.theater.TheaterDTO;

import java.util.List;

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
            return "admin/theater";
        } catch (Exception e) {

            return "error"; // 에러 페이지로 리다이렉트
        }
    }

    @PostMapping("/add")
    public String addTheater(@RequestParam("theaterName") String theaterName,
                             @RequestParam("regionId") String regionId,
                             @RequestParam("address") String address,
                             @RequestParam("screenCount") int screenCount,
                             @RequestParam("totalSeats") int totalSeats,
                             @RequestParam("latitude") double latitude,
                             @RequestParam("longitude") double longitude) {
        try {
            TheaterDTO theater = new TheaterDTO();
            theater.setTheater_id(String.valueOf(theaterDAO.getAllTheaters().size() + 1)); // ID 설정
            theater.setRegion_id(regionId);
            theater.setTheater_name(theaterName);
            theater.setAddress(address);
            theater.setTheaters_num(screenCount);
            theater.setTotal_seats(totalSeats);
            theater.setLatitude(latitude);
            theater.setLongitude(longitude);

      //      theaterDAO.addTheater(theater);   관리자페이지 영화관 추가 
            return "redirect:/admin/theater";
        } catch (Exception e) {
        
            return "error"; // 에러 페이지로 리다이렉트
        }
    }

    /* 관리자페이지 영화관 관리 삭제
    @PostMapping("/delete")
    public String deleteTheater(@RequestParam("theaterId") String theaterId) {
        try {
            theaterDAO.softDeleteTheater(theaterId);
            return "redirect:/admin/theater";
        } catch (Exception e) {
  
            return "error"; // 에러 페이지로 리다이렉트
        }
    }
*/
}
