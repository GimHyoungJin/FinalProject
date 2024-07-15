package kr.co.movio.cart;

public class CartDTO {

    private int cart_no;
    private String mem_id;
    private String pro_detail_code;
    private int cart_price;
    private int cart_amount;
    private String cart_date;
    private String pro_name; // 상품명 필드 추가

    public CartDTO() {}

    public int getCart_no() {
        return cart_no;
    }

    public void setCart_no(int cart_no) {
        this.cart_no = cart_no;
    }

    public String getMem_id() {
        return mem_id;
    }

    public void setMem_id(String mem_id) {
        this.mem_id = mem_id;
    }

    public String getPro_detail_code() {
        return pro_detail_code;
    }

    public void setPro_detail_code(String pro_detail_code) {
        this.pro_detail_code = pro_detail_code;
    }

    public int getCart_price() {
        return cart_price;
    }

    public void setCart_price(int cart_price) {
        this.cart_price = cart_price;
    }

    public int getCart_amount() {
        return cart_amount;
    }

    public void setCart_amount(int cart_amount) {
        this.cart_amount = cart_amount;
    }

    public String getCart_date() {
        return cart_date;
    }

    public void setCart_date(String cart_date) {
        this.cart_date = cart_date;
    }

    public String getPro_name() {
        return pro_name;
    }

    public void setPro_name(String pro_name) {
        this.pro_name = pro_name;
    }

    @Override
    public String toString() {
        return "CartDTO [cart_no=" + cart_no + ", mem_id=" + mem_id + ", pro_detail_code=" + pro_detail_code 
                + ", cart_price=" + cart_price + ", cart_amount=" + cart_amount + ", cart_date=" + cart_date 
                + ", pro_name=" + pro_name + "]";
    }
}
