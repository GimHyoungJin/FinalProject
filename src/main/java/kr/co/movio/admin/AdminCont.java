package kr.co.movio.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.movio.admin.movie.AdminMovieDAO;
import kr.co.movio.admin.movie.AdminMovieDTO;
import kr.co.movio.admin.theater.AdminTheaterDAO;
import kr.co.movio.admin.theater.AdminTheaterDTO;

import java.util.List;

@Controller
public class AdminCont {

    private final AdminDAO memberDAO;
    private final AdminMovieDAO movieDAO;
    private final AdminTheaterDAO theaterDAO;

    public AdminCont(AdminDAO memberDAO, AdminMovieDAO movieDAO, AdminTheaterDAO theaterDAO) {
        this.memberDAO = memberDAO;
        this.movieDAO = movieDAO;
        this.theaterDAO = theaterDAO;
    }

    @GetMapping("/admin/members")
    public String getMembers(@RequestParam(value = "search", required = false) String search, Model model) {
        List<AdminDTO> members = memberDAO.getAllMembers();
        model.addAttribute("members", members);
        return "admin/members";
    }
    
}
