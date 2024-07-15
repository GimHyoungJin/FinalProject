package kr.co.movio.order;

public class OrderDTO {
	
    private String order_no;  
    private String mem_id;    
    private int order_total;  
    private String payment;
    private String deliverynm;
    private String deliveryaddr;
    private String deliverymsg;
    private String order_state;

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

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public String getDeliverynm() {
        return deliverynm;
    }

    public void setDeliverynm(String deliverynm) {
        this.deliverynm = deliverynm;
    }

    public String getDeliveryaddr() {
        return deliveryaddr;
    }

    public void setDeliveryaddr(String deliveryaddr) {
        this.deliveryaddr = deliveryaddr;
    }

    public String getDeliverymsg() {
        return deliverymsg;
    }

    public void setDeliverymsg(String deliverymsg) {
        this.deliverymsg = deliverymsg;
    }

    public String getOrder_state() {
        return order_state;
    }

    public void setOrder_state(String order_state) {
        this.order_state = order_state;
    }
}
