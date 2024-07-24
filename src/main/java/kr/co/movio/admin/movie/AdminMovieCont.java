package kr.co.movio.admin.movie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import kr.co.movio.movie.MovieDAO;
import kr.co.movio.movie.MovieDTO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequestMapping("/admin/movie")
public class AdminMovieCont {

    @Autowired
    private MovieDAO movieDAO;

    @GetMapping
    public String getMovies(Model model) {
        List<MovieDTO> movies = movieDAO.getMovies();
        model.addAttribute("movies", movies);
        return "admin/movie";
    }

    @PostMapping("/add")
    public String addMovie(@RequestParam("movie_title") String movieTitle,
                           @RequestParam("release_date") String releaseDate,
                           @RequestParam("age_rating") String ageRating,
                           @RequestParam("genre") String genre,
                           @RequestParam("description") String description,
                           @RequestParam("poster_url") MultipartFile posterUrl,
                           @RequestParam("trailer_url") String trailerUrl,
                           RedirectAttributes redirectAttributes,
                           HttpServletRequest req) {
        ServletContext application = req.getServletContext();
        String basePath = application.getRealPath("/static/images/poster");

        try {
            String maxMovieId = movieDAO.getMaxMovieId();
            int newMovieId = maxMovieId != null ? Integer.parseInt(maxMovieId) + 1 : 1;

            MovieDTO movie = new MovieDTO();
            movie.setMovie_id(newMovieId);
            movie.setMovie_title(movieTitle);
            movie.setRelease_date(releaseDate);
            movie.setAge_rating(ageRating);
            movie.setGenre(genre);
            movie.setDescription(description);

            if (!posterUrl.isEmpty()) {
                String originalFilename = posterUrl.getOriginalFilename();
                Path uploadPath = Paths.get(basePath).toAbsolutePath().normalize();

                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                Path targetLocation = uploadPath.resolve(originalFilename);
                posterUrl.transferTo(targetLocation.toFile());
                movie.setPoster_url("/static/images/poster/" + originalFilename);
            }

            movie.setTrailer_url(trailerUrl);

            movieDAO.addMovie(movie);
            return "redirect:/admin/movie";
        } catch (IOException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "파일 업로드 실패");
            return "redirect:/admin/movie";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "영화 추가 실패");
            return "redirect:/admin/movie";
        }
    }

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

            movieDAO.updateMovie(movie);
            return "redirect:/admin/movie";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/movie/edit";
        }
    }

    @PostMapping("/delete")
    public String deleteMovie(@RequestParam("id") String movieId) {
        try {
            int movie_Id = Integer.parseInt(movieId);

            // 연관된 screenmovie 레코드 먼저 삭제
            movieDAO.deleteScreenMoviesByMovieId(movie_Id);

            // movie 레코드 삭제
            movieDAO.deleteMovie(movie_Id);

            return "redirect:/admin/movie";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/admin/movie";
        }
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam("id") String movieId, Model model) {
        MovieDTO movie = movieDAO.getMovieById(movieId);
        if (movie != null) {
            model.addAttribute("movie", movie);
            model.addAttribute("existingPosterUrl", movie.getPoster_url());
        }
        return "admin/editMovie";
    }
}
