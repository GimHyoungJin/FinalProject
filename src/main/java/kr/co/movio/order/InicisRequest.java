package kr.co.movio.order;

public class InicisRequest {
	
    private String imp_uid;
    private String mer_uid;
    private int paid_amount;
    private String apply_num;
    private String buyer_email;
    private String buyer_name;
    private String pay_method;
    private String pay_status;
    private String card_information;
    private String pro_detail_code;
    private int order_detail_amount;
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
	public String getApply_num() {
		return apply_num;
	}
	public void setApply_num(String apply_num) {
		this.apply_num = apply_num;
	}
	public String getBuyer_email() {
		return buyer_email;
	}
	public void setBuyer_email(String buyer_email) {
		this.buyer_email = buyer_email;
	}
	public String getBuyer_name() {
		return buyer_name;
	}
	public void setBuyer_name(String buyer_name) {
		this.buyer_name = buyer_name;
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
	public String getPro_detail_code() {
		return pro_detail_code;
	}
	public void setPro_detail_code(String pro_detail_code) {
		this.pro_detail_code = pro_detail_code;
	}
	public int getOrder_detail_amount() {
		return order_detail_amount;
	}
	public void setOrder_detail_amount(int order_detail_amount) {
		this.order_detail_amount = order_detail_amount;
	}
    
}
