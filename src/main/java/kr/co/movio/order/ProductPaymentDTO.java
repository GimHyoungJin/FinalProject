package kr.co.movio.order;

public class ProductPaymentDTO {
    private String gift_id;
    private String order_no;
    private String imp_uid;
    private String mer_uid;
    private int paid_amount;
    private String pay_method;
    private String pay_status;
    private String card_information;

    // Getters and Setters
    public String getGift_id() {
        return gift_id;
    }

    public void setGift_id(String gift_id) {
        this.gift_id = gift_id;
    }

    public String getOrder_no() {
        return order_no;
    }

    public void setOrder_no(String order_no) {
        this.order_no = order_no;
    }

    public String getImp_uid() {
        return imp_uid;
    }

    public void setImp_uid(String imp_uid) {
        this.imp_uid = imp_uid;
    }

    public String getMer_uid() {
        return mer_uid;
    }

    public void setMer_uid(String mer_uid) {
        this.mer_uid = mer_uid;
    }

    public int getPaid_amount() {
        return paid_amount;
    }

    public void setPaid_amount(int paid_amount) {
        this.paid_amount = paid_amount;
    }

    public String getPay_method() {
        return pay_method;
    }

    public void setPay_method(String pay_method) {
        this.pay_method = pay_method;
    }

    public String getPay_status() {
        return pay_status;
    }

    public void setPay_status(String pay_status) {
        this.pay_status = pay_status;
    }

    public String getCard_information() {
        return card_information;
    }

    public void setCard_information(String card_information) {
        this.card_information = card_information;
    }

    @Override
    public String toString() {
        return "ProductPaymentDTO{" +
                "gift_id='" + gift_id + '\'' +
                ", order_no='" + order_no + '\'' +
                ", imp_uid='" + imp_uid + '\'' +
                ", mer_uid='" + mer_uid + '\'' +
                ", paid_amount=" + paid_amount +
                ", pay_method='" + pay_method + '\'' +
                ", pay_status='" + pay_status + '\'' +
                ", card_information='" + card_information + '\'' +
                '}';
    }
}
