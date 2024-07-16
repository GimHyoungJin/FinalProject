package kr.co.movio.admin.movie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/movie")
public class AdminMovieCont {

    @Autowired
    private AdminMovieDAO movieDAO;

    @GetMapping
    public String getMovies(Model model) {
        List<AdminMovieDTO> movies = movieDAO.getAllMovies();
        model.addAttribute("movies", movies);
        return "admin/movie";
    }

    @PostMapping("/add")
    public String addMovie(AdminMovieDTO movie) {
        movieDAO.addMovie(movie);
        return "redirect:/admin/movie";
    }

    @PostMapping("/updateStatus")
    public String updateMovieStatus(AdminMovieDTO movie) {
        movieDAO.updateMovieStatus(movie);
        return "redirect:/admin/movie";
    }

    @PostMapping("/delete")
    public String deleteMovie(@RequestParam int movieId) {
        movieDAO.deleteMovie(movieId);
        return "redirect:/admin/movie";
    }
}
