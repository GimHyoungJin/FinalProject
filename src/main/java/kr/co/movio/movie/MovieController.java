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
import org.springframework.web.multipart.MultipartFile;
import kr.co.movio.review.ReviewDAO;
import kr.co.movio.review.ReviewDTO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/movie")
public class MovieController {

    @Autowired
    MovieDAO movieDao;

    @Autowired
    ReviewDAO reviewDao;

    @Value("${file.upload-dir}")
    private String uploadDir;

    @GetMapping("/movielist")
    public String movieList(Model model) {
        try {
            List<MovieDTO> movies = movieDao.getMovies();
            LocalDate today = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            List<MovieDTO> boxOffice = movies.stream()
                    .filter(movie -> LocalDate.parse(movie.getRelease_date(), formatter).isBefore(today) || 
                                      LocalDate.parse(movie.getRelease_date(), formatter).isEqual(today))
                    .collect(Collectors.toList());

            model.addAttribute("movies", boxOffice);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "movie/movielist";
    }

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
                model.addAttribute("totalAudience", movie.getTotal_audience());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "movie/moviedetail";
    }

    @GetMapping("/comment")
    public String movieComment(@RequestParam("id") String movieId, @RequestParam(value = "sort", required = false) String sort, Model model) {
        try {
            MovieDTO movie = movieDao.getMovieById(movieId);
            if (movie != null) {
                model.addAttribute("title", movie.getMovie_title());
                model.addAttribute("releaseDate", movie.getRelease_date());
                model.addAttribute("description", movie.getDescription());
                model.addAttribute("posterUrl", movie.getPoster_url());
                model.addAttribute("movieId", movieId);
                model.addAttribute("trailerUrl", movie.getTrailer_url());

                List<ReviewDTO> reviewList;
                if ("totalAudience".equals(sort)) {
                    reviewList = reviewDao.getReviewsByMovieIdSortedByRating(movieId);
                } else {
                    reviewList = reviewDao.getReviewsByMovieIdSortedByDate(movieId);
                }

                model.addAttribute("reviewCount", reviewList.size());
                model.addAttribute("reviewList", reviewList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "movie/moviedetail_review";
    }

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
                model.addAttribute("totalAudience", movie.getTotal_audience());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "movie/trailer_url";
    }


    @GetMapping("/write")
    public String showMovieWriteForm(@RequestParam(value = "category", required = false) String category, Model model) {
        if (category == null || category.isEmpty()) {
            category = "boxoffice"; // 기본값 설정
        }
        model.addAttribute("category", category);
        return "movie/write";
    }

    @PostMapping("/register")
    public String registerMovie(@RequestParam("movie_title") String movieTitle,
                                @RequestParam("release_date") String releaseDate,
                                @RequestParam("description") String description,
                                @RequestParam("poster") MultipartFile posterFile,
                                @RequestParam("trailerUrl") String trailerUrl,
                                Model model,
                                HttpServletRequest req) {
        ServletContext application = req.getServletContext();
        String basePath = application.getRealPath("/storage");

        try {
            // 가장 높은 movie_id 값을 가져와서 새로운 movie_id 설정
            String maxMovieId = movieDao.getMaxMovieId();
            int newMovieId = maxMovieId != null ? Integer.parseInt(maxMovieId) + 1 : 1;
            MovieDTO movie = new MovieDTO();
            movie.setMovie_id(String.valueOf(newMovieId));
            movie.setMovie_title(movieTitle);
            movie.setRelease_date(releaseDate);
            movie.setDescription(description);

            if (!posterFile.isEmpty()) {
                String originalFilename = posterFile.getOriginalFilename();
                String fileName = UUID.randomUUID().toString() + "_" + originalFilename;
                Path uploadPath = Paths.get(basePath).toAbsolutePath().normalize();

                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                Path targetLocation = uploadPath.resolve(fileName);
                posterFile.transferTo(targetLocation.toFile());
                movie.setPoster_url("/storage/" + fileName);
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

    // 영화 수정 페이지
    @GetMapping("/edit")
    public String showEditForm(@RequestParam("id") String movieId, Model model) {
        MovieDTO movie = movieDao.getMovieById(movieId);
        if (movie != null) {
            model.addAttribute("movie", movie);
        }
        return "movie/edit";
    }

    // 영화 수정 처리
    @PostMapping("/update")
    public String updateMovie(@ModelAttribute MovieDTO movie,
                              @RequestParam("poster") MultipartFile posterFile,
                              HttpServletRequest req) {
        ServletContext application = req.getServletContext();
        String basePath = application.getRealPath("/storage");

        try {
            if (!posterFile.isEmpty()) {
                String originalFilename = posterFile.getOriginalFilename();
                String fileName = UUID.randomUUID().toString() + "_" + originalFilename;
                Path uploadPath = Paths.get(basePath).toAbsolutePath().normalize();

                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                Path targetLocation = uploadPath.resolve(fileName);
                posterFile.transferTo(targetLocation.toFile());
                movie.setPoster_url("/storage/" + fileName);
            }
            movieDao.updateMovie(movie);
            return "redirect:/movie/moviedetail?id=" + movie.getMovie_id();
        } catch (Exception e) {
            e.printStackTrace();
            return "movie/edit";
        }
    }

    // 영화 삭제 처리
    @PostMapping("/delete")
    public String deleteMovie(@RequestParam("id") String movieId) {
        try {
            movieDao.deleteMovie(movieId);
            return "redirect:/movie/movielist";
        } catch (Exception e) {
            e.printStackTrace();
            return "movie/movielist";
        }
    }

}
