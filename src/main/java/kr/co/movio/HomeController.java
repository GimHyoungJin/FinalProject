package kr.co.movio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.movio.movie.MovieDAO;
import kr.co.movio.movie.MovieDTO;

import kr.co.movio.reservation.reservationDAO;
import kr.co.movio.review.ReviewDAO;

import java.util.List;
import java.util.stream.Collectors;

@Controller //MVC 패턴의 컨트롤러 역할을 한다.
public class HomeController {
    
    @Autowired
    MovieDAO movieDao;

    @Autowired
    ReviewDAO reviewDao;

    @Autowired
    reservationDAO reservationDao;

    //객체 생성 확인을 위한 default Constructor
    public HomeController() {
        System.out.println("-----HomeController() 객체 생성");
    }

    //루트 URL "/"에 접속하면 /main으로 리다이렉트되며, /main은 index.jsp를 반환함.
    // => http:localhost:8080/ 으로 접속하면 url에 보이는 것은 localhost:8080/main이라는 이야기
    @RequestMapping("/")
    public String home() {
        return "redirect:/main";
    }

    @RequestMapping("/main")
    public String main(Model model) {
        try {
            List<MovieDTO> movies = movieDao.getMovies();
            for (MovieDTO movie : movies) {
                int totalAudience = reservationDao.getTotalAudience(String.valueOf(movie.getMovie_id()));
                movie.setTotal_audience(totalAudience);
            }

            // 누적 관객 수에 따라 영화를 정렬
            List<MovieDTO> sortedMovies = movies.stream()
                    .sorted((m1, m2) -> Integer.compare(m2.getTotal_audience(), m1.getTotal_audience()))
                    .collect(Collectors.toList());

            // 상위 4개 영화만 선택
            List<MovieDTO> topMovies = sortedMovies.stream().limit(4).collect(Collectors.toList());

            model.addAttribute("movies", topMovies);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "index"; // index.jsp로 반환
    }
}
