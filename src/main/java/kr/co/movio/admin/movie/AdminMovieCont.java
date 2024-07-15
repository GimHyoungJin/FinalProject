package kr.co.movio.admin.movie;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/admin/movie")
public class AdminMovieCont {

    private final AdminMovieDAO movieDAO;

    public AdminMovieCont(AdminMovieDAO movieDAO) {
        this.movieDAO = movieDAO;
    }

    @GetMapping
    public String getMovies(Model model) {
        List<AdminMovieDTO> movies = movieDAO.getAllMovies();
        model.addAttribute("movies", movies);
        return "admin/movie";
    }

    @PostMapping("/add")
    public String addMovie(@RequestParam("title") String title, @RequestParam("releaseDate") String releaseDate,
                           @RequestParam("ageRating") String ageRating, @RequestParam("genre") String genre,
                           @RequestParam("description") String description, @RequestParam("image") MultipartFile image,
                           @RequestParam("trailerUrl") String trailerUrl, @RequestParam("status") String status) throws IOException {
        
        String imagePath = saveFile(image);

        AdminMovieDTO movie = new AdminMovieDTO(movieDAO.getAllMovies().size() + 1, title, releaseDate, ageRating, genre, description, imagePath, trailerUrl, status);
        movieDAO.addMovie(movie);
        return "redirect:/admin/movie";
    }

    private String saveFile(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            return "";
        }
        String fileName = file.getOriginalFilename();
        String filePath = "C:/path/to/your/upload/directory/" + fileName; // 경로를 실제 업로드 폴더 경로로 변경해야 합니다.
        file.transferTo(new File(filePath));
        return fileName;
    }

    @PostMapping("/delete")
    public String deleteMovie(@RequestParam("movieId") int movieId) {
        movieDAO.removeMovie(movieId);
        return "redirect:/admin/movie";
    }

    @PostMapping("/updateStatus")
    public String updateMovieStatus(@RequestParam("movieId") int movieId, @RequestParam("status") String status) {
        movieDAO.updateMovieStatus(movieId, status);
        return "redirect:/admin/movie";
    }
}
