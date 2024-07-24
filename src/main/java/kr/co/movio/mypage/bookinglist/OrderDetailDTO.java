package kr.co.movio.mypage.bookinglist;

public class OrderDetailDTO {
    private int orderDetailNo;
    private String orderNo;
    private String orderDate;
    private String proDetailCode;
    private String productName;
    private int orderDetailPrice;
    private int orderDetailAmount;
    private String orderState;
    private String orderType;

    // Getters and setters...

    public int getOrderDetailNo() {
        return orderDetailNo;
    }

    public void setOrderDetailNo(int orderDetailNo) {
        this.orderDetailNo = orderDetailNo;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getProDetailCode() {
        return proDetailCode;
    }

    public void setProDetailCode(String proDetailCode) {
        this.proDetailCode = proDetailCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getOrderDetailPrice() {
        return orderDetailPrice;
    }

    public void setOrderDetailPrice(int orderDetailPrice) {
        this.orderDetailPrice = orderDetailPrice;
    }

    public int getOrderDetailAmount() {
        return orderDetailAmount;
    }

    public void setOrderDetailAmount(int orderDetailAmount) {
        this.orderDetailAmount = orderDetailAmount;
    }

    public String getOrderState() {
        return orderState;
    }

    public void setOrderState(String orderState) {
        this.orderState = orderState;
    }

    public String getOrderType() {
        return orderType;
    }

    @Override
	public String toString() {
		return "OrderDetailDTO [orderDetailNo=" + orderDetailNo + ", orderNo=" + orderNo + ", orderDate=" + orderDate
				+ ", proDetailCode=" + proDetailCode + ", productName=" + productName + ", orderDetailPrice="
				+ orderDetailPrice + ", orderDetailAmount=" + orderDetailAmount + ", orderState=" + orderState
				+ ", orderType=" + orderType + "]";
	}

	public void setOrderType(String orderType) {
        this.orderType = orderType;
    }
}
