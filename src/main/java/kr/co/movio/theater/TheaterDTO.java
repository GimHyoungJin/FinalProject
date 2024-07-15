package kr.co.movio.theater;

public class TheaterDTO {
    private String theater_id;
    private String region_id;
    private String theater_name;
    private String address;
    private int theaters_num;
    private int total_seats;
    private double latitude;
    private double longitude;

    // Getters and Setters
    public String getTheater_id() {
        return theater_id;
    }

    public void setTheater_id(String theater_id) {
        this.theater_id = theater_id;
    }

    public String getRegion_id() {
        return region_id;
    }

    public void setRegion_id(String region_id) {
        this.region_id = region_id;
    }

    public String getTheater_name() {
        return theater_name;
    }

    public void setTheater_name(String theater_name) {
        this.theater_name = theater_name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getTheaters_num() {
        return theaters_num;
    }

    public void setTheaters_num(int theaters_num) {
        this.theaters_num = theaters_num;
    }

    public int getTotal_seats() {
        return total_seats;
    }

    public void setTotal_seats(int total_seats) {
        this.total_seats = total_seats;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
}
