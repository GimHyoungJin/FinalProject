package kr.co.movio.admin.movie;

public class AdminMovieDTO {

    private int id;
    private String title;
    private String releaseDate;
    private String ageRating;
    private String genre;
    private String description;
    private String image;
    private String trailerUrl;
    private String status;

    public AdminMovieDTO() {
        // 기본 생성자
    }

    public AdminMovieDTO(int id, String title, String releaseDate, String ageRating, String genre, String description, String image, String trailerUrl, String status) {
        this.id = id;
        this.title = title;
        this.releaseDate = releaseDate;
        this.ageRating = ageRating;
        this.genre = genre;
        this.description = description;
        this.image = image;
        this.trailerUrl = trailerUrl;
        this.status = status;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getAgeRating() {
        return ageRating;
    }

    public void setAgeRating(String ageRating) {
        this.ageRating = ageRating;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTrailerUrl() {
        return trailerUrl;
    }

    public void setTrailerUrl(String trailerUrl) {
        this.trailerUrl = trailerUrl;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
