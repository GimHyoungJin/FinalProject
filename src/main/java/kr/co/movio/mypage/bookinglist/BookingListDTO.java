package kr.co.movio.mypage.bookinglist;

public class BookingListDTO {
    private String resId; // UUID 형식
    private String memId;
    private String screenMovieId;
    private String resSeatInfo;
    private int adult;
    private int teenager;
    private int child;
    private int totPeople;
    private String resDate;
    private String username;
    private String email;
    private int movieId;
    private String movieTitle;
    private String theaterName;
    private String address;

    // Getters and setters...

    public String getResId() {
        return resId;
    }

    public void setResId(String resId) {
        this.resId = resId;
    }

    public String getMemId() {
        return memId;
    }

    public void setMemId(String memId) {
        this.memId = memId;
    }

    public String getScreenMovieId() {
        return screenMovieId;
    }

    public void setScreenMovieId(String screenMovieId) {
        this.screenMovieId = screenMovieId;
    }

    public String getResSeatInfo() {
        return resSeatInfo;
    }

    public void setResSeatInfo(String resSeatInfo) {
        this.resSeatInfo = resSeatInfo;
    }

    public int getAdult() {
        return adult;
    }

    public void setAdult(int adult) {
        this.adult = adult;
    }

    public int getTeenager() {
        return teenager;
    }

    public void setTeenager(int teenager) {
        this.teenager = teenager;
    }

    public int getChild() {
        return child;
    }

    public void setChild(int child) {
        this.child = child;
    }

    public int getTotPeople() {
        return totPeople;
    }

    public void setTotPeople(int totPeople) {
        this.totPeople = totPeople;
    }

    public String getResDate() {
        return resDate;
    }

    public void setResDate(String resDate) {
        this.resDate = resDate;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

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

    public String getTheaterName() {
        return theaterName;
    }

    public void setTheaterName(String theaterName) {
        this.theaterName = theaterName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
