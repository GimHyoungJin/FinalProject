package kr.co.movio.review;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.UUID;

public class ReviewDTO {
    private String review_id;
    private String movie_id;
    private String mem_id;
    private String review_text;
    private BigDecimal rating;
    private Timestamp review_date;

    public ReviewDTO() {
        // UUID로 review_id 자동 생성
        this.review_id = UUID.randomUUID().toString();
    }

    public String getReview_id() {
        return review_id;
    }

    public void setReview_id(String review_id) {
        this.review_id = review_id;
    }

    public String getMovie_id() {
        return movie_id;
    }

    public void setMovie_id(String movie_id) {
        this.movie_id = movie_id;
    }

    public String getMem_id() {
        return mem_id;
    }

    public void setMem_id(String mem_id) {
        this.mem_id = mem_id;
    }

    public String getReview_text() {
        return review_text;
    }

    public void setReview_text(String review_text) {
        this.review_text = review_text;
    }


	public BigDecimal getRating() {
		return rating;
	}

	public void setRating(BigDecimal rating) {
		this.rating = rating;
	}

	public Timestamp getReview_date() {
        return review_date;
    }

    public void setReview_date(Timestamp review_date) {
        this.review_date = review_date;
    }
}
