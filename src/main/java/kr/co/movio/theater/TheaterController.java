package kr.co.movio.theater;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/theater")
public class TheaterController {

    private final TheaterDAO theaterDao;

    // TheaterDAO를 주입받는 생성자
    public TheaterController(TheaterDAO theaterDao) {
        this.theaterDao = theaterDao;
    }

    // 극장 목록 페이지를 반환하는 메서드
    @GetMapping("/list")
    public String theaterList(Model model) {
        // 모든 극장 정보를 모델에 추가
        model.addAttribute("theaterList", theaterDao.getAllTheaters());
        return "theater/theaterlist"; // 뷰 이름 반환
    }

    // 극장 상세 정보 페이지를 반환하는 메서드
    @GetMapping("/detail")
    public String theaterDetail(@RequestParam("no") String theaterNo, Model model) {
        // 극장 ID로 극장 정보를 가져와서 모델에 추가
        TheaterDTO theater = theaterDao.getTheaterByNo(theaterNo);
        if (theater != null) {
            model.addAttribute("theater", theater);
            // 극장 ID로 극장 상세 정보를 가져와서 모델에 추가
            List<TheaterInfoDTO> theaterInfoList = theaterDao.getTheaterInfoByTheaterId(theaterNo);
            model.addAttribute("theaterInfoList", theaterInfoList);
        }
        return "theater/theaterdetail"; // 뷰 이름 반환
    }
}
