package kr.co.movio.reservation;

public class TicketPaymentDTO {
	
    private String pay_id;
    private String res_id; 
    private String imp_uid;
    private String mer_uid;
    private String pay_method;
    private int tot_price;
    private int dis_price;
    private int final_price;
    private String pay_status;
    private String pay_time;
    private String card_information;
	
    public String getPay_id() {
		return pay_id;
	}
	public void setPay_id(String pay_id) {
		this.pay_id = pay_id;
	}
	public String getRes_id() {
		return res_id;
	}
	public void setRes_id(String res_id) {
		this.res_id = res_id;
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
	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	public int getTot_price() {
		return tot_price;
	}
	public void setTot_price(int tot_price) {
		this.tot_price = tot_price;
	}
	public int getDis_price() {
		return dis_price;
	}
	public void setDis_price(int dis_price) {
		this.dis_price = dis_price;
	}
	public int getFinal_price() {
		return final_price;
	}
	public void setFinal_price(int final_price) {
		this.final_price = final_price;
	}
	public String getPay_status() {
		return pay_status;
	}
	public void setPay_status(String pay_status) {
		this.pay_status = pay_status;
	}
	public String getPay_time() {
		return pay_time;
	}
	public void setPay_time(String pay_time) {
		this.pay_time = pay_time;
	}
	public String getCard_information() {
		return card_information;
	}
	public void setCard_information(String card_information) {
		this.card_information = card_information;
	}
	
	@Override
	public String toString() {
		return "TicketPaymentDTO [pay_id=" + pay_id + ", res_id=" + res_id + ", imp_uid=" + imp_uid + ", mer_uid="
				+ mer_uid + ", pay_method=" + pay_method + ", tot_price=" + tot_price + ", dis_price=" + dis_price
				+ ", final_price=" + final_price + ", pay_status=" + pay_status + ", pay_time=" + pay_time
				+ ", card_information=" + card_information + "]";
	}

}
