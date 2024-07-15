package kr.co.movio.movie;

public class MovieDTO {
    private String movie_id;
    private String movie_title;
    private String release_date;
    private String description;
    private String poster_url;
    private String trailer_url;
    private int total_audience; // 누적관객수

    // Getters and Setters
    public String getMovie_id() {
        return movie_id;
    }

    public void setMovie_id(String movie_id) {
        this.movie_id = movie_id;
    }

    public String getMovie_title() {
        return movie_title;
    }

    public void setMovie_title(String movie_title) {
        this.movie_title = movie_title;
    }

    public String getRelease_date() {
        return release_date;
    }

    public void setRelease_date(String release_date) {
        this.release_date = release_date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPoster_url() {
        return poster_url;
    }

    public void setPoster_url(String poster_url) {
        this.poster_url = poster_url;
    }

    public String getTrailer_url() {
        return trailer_url;
    }

    public void setTrailer_url(String trailer_url) {
        this.trailer_url = trailer_url;
    }

    public int getTotal_audience() {
        return total_audience;
    }

    public void setTotal_audience(int total_audience) {
        this.total_audience = total_audience;
    }
}
