package kr.co.movio.admin.movie;

public class AdminMovieDTO {
    private int movieId;
    private String movieTitle;
    private String releaseDate;
    private String description;
    private String posterUrl;
    private String trailerUrl;
    private int totalAudience;
    private String ageRating;
    private String genre;
    private String status; // status 속성 추가

    // Getters and Setters
    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }

    public String getTrailerUrl() {
        return trailerUrl;
    }

    public void setTrailerUrl(String trailerUrl) {
        this.trailerUrl = trailerUrl;
    }

    public int getTotalAudience() {
        return totalAudience;
    }

    public void setTotalAudience(int totalAudience) {
        this.totalAudience = totalAudience;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

	@Override
	public String toString() {
		return "AdminMovieDTO [movieId=" + movieId + ", movieTitle=" + movieTitle + ", releaseDate=" + releaseDate
				+ ", description=" + description + ", posterUrl=" + posterUrl + ", trailerUrl=" + trailerUrl
				+ ", totalAudience=" + totalAudience + ", ageRating=" + ageRating + ", genre=" + genre + ", status="
				+ status + "]";
	}
}
