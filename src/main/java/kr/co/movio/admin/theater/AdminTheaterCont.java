package kr.co.movio.admin.theater;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/theater")
public class AdminTheaterCont {

    private final AdminTheaterDAO theaterDAO;

    public AdminTheaterCont(AdminTheaterDAO theaterDAO) {
        this.theaterDAO = theaterDAO;
    }

    @GetMapping
    public String getTheaters(Model model) {
        List<AdminTheaterDTO> theaters = theaterDAO.getAllTheaters();
        model.addAttribute("theaters", theaters);
        return "admin/theater";
    }

    @PostMapping("/add")
    public String addTheater(@RequestParam("theaterName") String theaterName,
                             @RequestParam("regionId") String regionId,
                             @RequestParam("address") String address,
                             @RequestParam("screenCount") int screenCount,
                             @RequestParam("totalSeats") int totalSeats,
                             @RequestParam("latitude") double latitude,
                             @RequestParam("longitude") double longitude) {
        AdminTheaterDTO theater = new AdminTheaterDTO(theaterDAO.getAllTheaters().size() + 1, regionId, theaterName, address, screenCount, totalSeats, latitude, longitude);
        theaterDAO.addTheater(theater);
        return "redirect:/admin/theater";
    }

    @PostMapping("/delete")
    public String deleteTheater(@RequestParam("theaterId") int theaterId) {
        theaterDAO.removeTheater(theaterId);
        return "redirect:/admin/theater";
    }
}