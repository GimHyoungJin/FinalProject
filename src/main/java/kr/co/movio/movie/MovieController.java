package kr.co.movio.movie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.movio.reservation.TicketReservationDTO;
import kr.co.movio.reservation.reservationDAO;
import kr.co.movio.review.ReviewDAO;
import kr.co.movio.review.ReviewDTO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/movie")
public class MovieController {

    @Autowired
    MovieDAO movieDao;

    @Autowired
    ReviewDAO reviewDao;

    @Autowired
    reservationDAO reservationDao;

    @Value("${file.upload-dir}")
    private String uploadDir;

    //영화 목록 페이지를 반환합니다.
    @GetMapping("/movielist")
    public String movieList(Model model) {
        try {
            List<MovieDTO> movies = movieDao.getMovies();
            model.addAttribute("movies", movies);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "movie/movielist";
    }

    //곧 개봉할 영화 목록 페이지를 반환합니다.
    @GetMapping("/comingsoon")
    public String comingSoon(Model model) {
        try {
            List<MovieDTO> movies = movieDao.getMovies();
            LocalDate today = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            List<MovieDTO> comingSoon = movies.stream()
                    .filter(movie -> LocalDate.parse(movie.getRelease_date(), formatter).isAfter(today))
                    .collect(Collectors.toList());

            model.addAttribute("movies", comingSoon);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "movie/comingsoon";
    }

    //영화 상세 정보 페이지를 반환합니다.
    @GetMapping("/moviedetail")
    public String movieDetail(@RequestParam("id") String movieId, Model model) {
        try {
            MovieDTO movie = movieDao.getMovieById(movieId);
            if (movie != null) {
                model.addAttribute("title", movie.getMovie_title());
                model.addAttribute("releaseDate", movie.getRelease_date());
                model.addAttribute("description", movie.getDescription());
                model.addAttribute("posterUrl", movie.getPoster_url());
                model.addAttribute("movieId", movieId);
                model.addAttribute("trailerUrl", movie.getTrailer_url());

                int totalAudience = reservationDao.getTotalAudience(movieId);
                double rating = reservationDao.getRating(movieId);
                double movieGrade = reservationDao.getMovieGrade(movieId);

                model.addAttribute("totalAudience", totalAudience);
                model.addAttribute("rating", rating);
                model.addAttribute("movieGrade", movieGrade);

                model.addAttribute("ageRating", movie.getAge_rating());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "movie/moviedetail";
    }

    //영화 리뷰 페이지를 반환합니다.
    @GetMapping("/comment")
    public String movieComment(@RequestParam("id") String movieId,
                               @RequestParam(value = "sort", required = false) String sort,
                               @RequestParam(value = "page", defaultValue = "1") int page,
                               Model model) {
        int pageSize = 5;
        int offset = (page - 1) * pageSize;

        try {
            MovieDTO movie = movieDao.getMovieById(movieId);
            if (movie != null) {
                model.addAttribute("title", movie.getMovie_title());
                model.addAttribute("releaseDate", movie.getRelease_date());
                model.addAttribute("description", movie.getDescription());
                model.addAttribute("posterUrl", movie.getPoster_url());
                model.addAttribute("movieId", movieId);
                model.addAttribute("trailerUrl", movie.getTrailer_url());

                int totalAudience = reservationDao.getTotalAudience(movieId);
                double rating = reservationDao.getRating(movieId);
                double movieGrade = reservationDao.getMovieGrade(movieId);

                model.addAttribute("totalAudience", totalAudience);
                model.addAttribute("rating", rating);
                model.addAttribute("movieGrade", movieGrade);

                model.addAttribute("ageRating", movie.getAge_rating());
            }

            List<ReviewDTO> reviewList;
            if ("rating".equals(sort)) {
                reviewList = reviewDao.getReviewsByMovieIdSortedByRatingPaged(movieId, offset, pageSize);
            } else {
                reviewList = reviewDao.getReviewsByMovieIdSortedByDatePaged(movieId, offset, pageSize);
            }

            int totalReviews = reviewDao.getTotalReviewCountByMovieId(movieId);
            int totalPages = (int) Math.ceil((double) totalReviews / pageSize);

            model.addAttribute("reviewCount", totalReviews);
            model.addAttribute("reviewList", reviewList);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("movieId", movieId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "movie/moviedetail_review";
    }

    //영화 트레일러 페이지를 반환합니다.
    @GetMapping("/trailer")
    public String showTrailer(@RequestParam("id") String movieId, Model model) {
        try {
            MovieDTO movie = movieDao.getMovieById(movieId);
            if (movie != null) {
                model.addAttribute("title", movie.getMovie_title());
                model.addAttribute("releaseDate", movie.getRelease_date());
                model.addAttribute("posterUrl", movie.getPoster_url());
                model.addAttribute("trailerUrl", movie.getTrailer_url());
                model.addAttribute("movieId", movieId);

                int totalAudience = reservationDao.getTotalAudience(movieId);
                double rating = reservationDao.getRating(movieId);
                double movieGrade = reservationDao.getMovieGrade(movieId);

                model.addAttribute("totalAudience", totalAudience);
                model.addAttribute("rating", rating);
                model.addAttribute("movieGrade", movieGrade);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "movie/trailer_url";
    }

    //영화 작성(등록) 페이지를 반환합니다.
    @GetMapping("/write")
    public String showMovieWriteForm(@RequestParam(value = "category", required = false) String category, Model model) {
        if (category == null || category.isEmpty()) {
            category = "boxoffice";
        }
        model.addAttribute("category", category);
        return "movie/write";
    }

    //새로운 영화를 등록하는 메소드
    @PostMapping("/register")
    public String registerMovie(@RequestParam("movie_title") String movieTitle,
                                @RequestParam("release_date") String releaseDate,
                                @RequestParam("description") String description,
                                @RequestParam("poster") MultipartFile posterFile,
                                @RequestParam("trailerUrl") String trailerUrl,
                                @RequestParam("age_rating") String ageRating,
                                @RequestParam("genre") String genre,
                                Model model,
                                HttpServletRequest req) {
        ServletContext application = req.getServletContext();
        String basePath = application.getRealPath("/static/images/poster");

        try {
            String maxMovieId = movieDao.getMaxMovieId();
            int newMovieId = maxMovieId != null ? Integer.parseInt(maxMovieId) + 1 : 1;
            MovieDTO movie = new MovieDTO();
            movie.setMovie_id(newMovieId);
            movie.setMovie_title(movieTitle);
            movie.setRelease_date(releaseDate);
            movie.setDescription(description);
            movie.setAge_rating(ageRating);
            movie.setGenre(genre);

            if (!posterFile.isEmpty()) {
                String originalFilename = posterFile.getOriginalFilename();
                Path uploadPath = Paths.get(basePath).toAbsolutePath().normalize();

                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                Path targetLocation = uploadPath.resolve(originalFilename);
                posterFile.transferTo(targetLocation.toFile());
                movie.setPoster_url("/images/poster/" + originalFilename);
            }

            movie.setTrailer_url(trailerUrl);

            movieDao.addMovie(movie);
            return "redirect:/movie/movielist";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "영화 등록 중 오류가 발생했습니다.");
            return "movie/write";
        }
    }

    //영화 수정 페이지를 반환합니다.
    @GetMapping("/edit")
    public String showEditForm(@RequestParam("id") String movieId, Model model) {
        MovieDTO movie = movieDao.getMovieById(movieId);
        if (movie != null) {
            model.addAttribute("movie", movie);
            model.addAttribute("posterUrl", movie.getPoster_url());
        }
        return "movie/edit";
    }

    //영화 등록한걸 수정하는 메소드
    @PostMapping("/update")
    public String updateMovie(@ModelAttribute MovieDTO movie,
                              @RequestParam("poster") MultipartFile posterFile,
                              @RequestParam("existingPosterUrl") String existingPosterUrl,
                              HttpServletRequest req) {
        ServletContext application = req.getServletContext();
        String basePath = application.getRealPath("/static/images/poster");

        try {
            if (!posterFile.isEmpty()) {
                String originalFilename = posterFile.getOriginalFilename();
                Path uploadPath = Paths.get(basePath).toAbsolutePath().normalize();

                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                Path targetLocation = uploadPath.resolve(originalFilename);
                posterFile.transferTo(targetLocation.toFile());
                movie.setPoster_url("/static/images/poster/" + originalFilename);
            } else {
                movie.setPoster_url(existingPosterUrl);
            }

            movieDao.updateMovie(movie);
            return "redirect:/movie/moviedetail?id=" + movie.getMovie_id();
        } catch (Exception e) {
            e.printStackTrace();
            return "movie/edit";
        }
    }

    @PostMapping("/delete")
    public String deleteMovie(@RequestParam("id") String movieId) {
        try {
            int movie_Id = Integer.parseInt(movieId);
            movieDao.deleteMovie(movie_Id);
            return "redirect:/movie/movielist";
        } catch (Exception e) {
            e.printStackTrace();
            return "movie/movielist";
        }
    }

    //예매 번호를 확인하는 메소드
    @GetMapping("/verifyReservation")
    @ResponseBody
    public boolean verifyReservation(@RequestParam("reservationId") String reservationId, HttpSession session) {
        TicketReservationDTO reservation = reservationDao.getReservationById(reservationId);
        if (reservation != null && reservation.getMem_id().equals(session.getAttribute("mem_id"))) {
            session.setAttribute("canWriteReview", true);
            return true;
        } else {
            session.setAttribute("canWriteReview", false);
            return false;
        }
    }

    //영화가 사용자의 계정으로 등록되었는지 확인하는 메소드
    @GetMapping("/checkMovieRegistered")
    @ResponseBody
    public boolean checkMovieRegistered(@RequestParam("movieId") String movieId, HttpSession session) {
        String memId = (String) session.getAttribute("mem_id");
        if (memId == null) {
            return false;
        }
        return reservationDao.isMovieRegisteredByUser(movieId, memId);
    }

    //본 영화가 등록되었는지 확인하는 메소드
    @GetMapping("/checkRegistered")
    @ResponseBody
    public Map<String, Boolean> checkRegistered(@RequestParam("movieId") String movieId, @RequestParam("memId") String memId) {
        boolean isRegistered = reservationDao.isRegistered(movieId, memId);
        Map<String, Boolean> response = new HashMap<>();
        response.put("registered", isRegistered);
        return response;
    }

    //리뷰 작성 권한을 확인하는 메소드
    @GetMapping("/checkSessionForReview")
    @ResponseBody
    public boolean checkSessionForReview(HttpSession session) {
        Boolean canWriteReview = (Boolean) session.getAttribute("canWriteReview");
        return canWriteReview != null && canWriteReview;
    }
}
