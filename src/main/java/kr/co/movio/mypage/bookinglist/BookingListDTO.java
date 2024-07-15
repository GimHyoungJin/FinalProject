package kr.co.movio.mypage.bookinglist;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;

public class BookingListDTO {
    private String bookingId;
    private String memberId;
    private String movieInfo;
    private String seatInfo;
    private int adultCount;
    private int teenCount;
    private int childCount;
    private int totalCount;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date bookingDate;

    private String movieTitle;
    private String movieStartTime;
    private String movieEndTime;

    // Getters and Setters
    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getMovieInfo() {
        return movieInfo;
    }

    public void setMovieInfo(String movieInfo) {
        this.movieInfo = movieInfo;
    }

    public String getSeatInfo() {
        return seatInfo;
    }

    public void setSeatInfo(String seatInfo) {
        this.seatInfo = seatInfo;
    }

    public int getAdultCount() {
        return adultCount;
    }

    public void setAdultCount(int adultCount) {
        this.adultCount = adultCount;
    }

    public int getTeenCount() {
        return teenCount;
    }

    public void setTeenCount(int teenCount) {
        this.teenCount = teenCount;
    }

    public int getChildCount() {
        return childCount;
    }

    public void setChildCount(int childCount) {
        this.childCount = childCount;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public String getMovieStartTime() {
        return movieStartTime;
    }

    public void setMovieStartTime(String movieStartTime) {
        this.movieStartTime = movieStartTime;
    }

    public String getMovieEndTime() {
        return movieEndTime;
    }

    public void setMovieEndTime(String movieEndTime) {
        this.movieEndTime = movieEndTime;
    }
}
