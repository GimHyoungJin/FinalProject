package kr.co.movio.order;

import java.util.List;

import kr.co.movio.cart.CartDTO;

public class OrderDTO {
    private String order_no;
    private String mem_id;
    private int order_total;
    private String order_state; // 주문 상태
    private List<CartDTO> orderDetails; // 주문 상세 목록

    // Getters and Setters
    public String getOrder_no() {
        return order_no;
    }

    public void setOrder_no(String order_no) {
        this.order_no = order_no;
    }

    public String getMem_id() {
        return mem_id;
    }

    public void setMem_id(String mem_id) {
        this.mem_id = mem_id;
    }

    public int getOrder_total() {
        return order_total;
    }

    public void setOrder_total(int order_total) {
        this.order_total = order_total;
    }

    public String getOrder_state() {
        return order_state;
    }

    public void setOrder_state(String order_state) {
        this.order_state = order_state;
    }

    public List<CartDTO> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<CartDTO> orderDetails) {
        this.orderDetails = orderDetails;
    }
}
