package kr.co.movio.admin.movie;

import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class AdminMovieDAO {

    private List<AdminMovieDTO> movies;

    public AdminMovieDAO() {
        movies = new ArrayList<>();
        // 더미 데이터 추가
        movies.add(new AdminMovieDTO(1, "Movie 1", "2023-01-01", "15+", "Action", "This is a description for Movie 1", "movie1.jpg", "https://trailer1.com", "active"));
        movies.add(new AdminMovieDTO(2, "Movie 2", "2023-02-01", "12+", "Drama", "This is a description for Movie 2", "movie2.jpg", "https://trailer2.com", "active"));
        movies.add(new AdminMovieDTO(3, "Movie 3", "2023-03-01", "18+", "Comedy", "This is a description for Movie 3", "movie3.jpg", "https://trailer3.com", "inactive"));
        movies.add(new AdminMovieDTO(4, "Movie 4", "2023-04-01", "15+", "Horror", "This is a description for Movie 4", "movie4.jpg", "https://trailer4.com", "active"));
        movies.add(new AdminMovieDTO(5, "Movie 5", "2023-05-01", "12+", "Sci-Fi", "This is a description for Movie 5", "movie5.jpg", "https://trailer5.com", "inactive"));
        movies.add(new AdminMovieDTO(6, "Movie 6", "2023-06-01", "18+", "Romance", "This is a description for Movie 6", "movie6.jpg", "https://trailer6.com", "active"));
        movies.add(new AdminMovieDTO(7, "Movie 7", "2023-07-01", "15+", "Adventure", "This is a description for Movie 7", "movie7.jpg", "https://trailer7.com", "active"));
        movies.add(new AdminMovieDTO(8, "Movie 8", "2023-08-01", "12+", "Thriller", "This is a description for Movie 8", "movie8.jpg", "https://trailer8.com", "inactive"));
        movies.add(new AdminMovieDTO(9, "Movie 9", "2023-09-01", "18+", "Fantasy", "This is a description for Movie 9", "movie9.jpg", "https://trailer9.com", "active"));
        movies.add(new AdminMovieDTO(10, "Movie 10", "2023-10-01", "15+", "Mystery", "This is a description for Movie 10", "movie10.jpg", "https://trailer10.com", "inactive"));
    }

    public List<AdminMovieDTO> getAllMovies() {
        return movies;
    }

    public void addMovie(AdminMovieDTO movie) {
        movies.add(movie);
    }

    public void removeMovie(int movieId) {
        movies.removeIf(movie -> movie.getId() == movieId);
    }

    public void updateMovieStatus(int movieId, String status) {
        for (AdminMovieDTO movie : movies) {
            if (movie.getId() == movieId) {
                movie.setStatus(status);
                break;
            }
        }
    }
}
