package kr.co.movio.admin.theater;

public class AdminTheaterDTO {

    private int theaterId;
    private String regionId;
    private String theaterName;
    private String address;
    private int screenCount;
    private int totalSeats;
    private double latitude;
    private double longitude;

    public AdminTheaterDTO(int theaterId, String regionId, String theaterName, String address, int screenCount, int totalSeats, double latitude, double longitude) {
        this.theaterId = theaterId;
        this.regionId = regionId;
        this.theaterName = theaterName;
        this.address = address;
        this.screenCount = screenCount;
        this.totalSeats = totalSeats;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    // Getters and setters
    public int getTheaterId() {
        return theaterId;
    }

    public void setTheaterId(int theaterId) {
        this.theaterId = theaterId;
    }

    public String getRegionId() {
        return regionId;
    }

    public void setRegionId(String regionId) {
        this.regionId = regionId;
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

    public int getScreenCount() {
        return screenCount;
    }

    public void setScreenCount(int screenCount) {
        this.screenCount = screenCount;
    }

    public int getTotalSeats() {
        return totalSeats;
    }

    public void setTotalSeats(int totalSeats) {
        this.totalSeats = totalSeats;
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

   @Override
   public String toString() {
      return "AdminTheaterDTO [theaterId=" + theaterId + ", regionId=" + regionId + ", theaterName=" + theaterName
            + ", address=" + address + ", screenCount=" + screenCount + ", totalSeats=" + totalSeats + ", latitude="
            + latitude + ", longitude=" + longitude + "]";
   }
}