package kr.co.movio.order;

import java.util.List;
import java.util.Map;

import kr.co.movio.cart.CartDTO;

public class OrderDTO {
    private String order_no;
    private String mem_id;
    private int order_total;
    private String order_state; // 주문 상태
    private List<CartDTO> orderDetails; // 주문 상세 목록

    // OrderDetail 및 Payment 정보 추가
    private List<Map<String, Object>> orderDetailsList; // 주문 상세 정보 목록
    private Map<String, Object> paymentInfo; // 결제 정보

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

    public List<Map<String, Object>> getOrderDetailsList() {
        return orderDetailsList;
    }

    public void setOrderDetailsList(List<Map<String, Object>> orderDetailsList) {
        this.orderDetailsList = orderDetailsList;
    }

    public Map<String, Object> getPaymentInfo() {
        return paymentInfo;
    }

    public void setPaymentInfo(Map<String, Object> map) {
        this.paymentInfo = map;
    }

    @Override
    public String toString() {
        return "OrderDTO [order_no=" + order_no + ", mem_id=" + mem_id + ", order_total=" + order_total
                + ", order_state=" + order_state + ", orderDetails=" + orderDetails 
                + ", orderDetailsList=" + orderDetailsList + ", paymentInfo=" + paymentInfo + "]";
    }
}
