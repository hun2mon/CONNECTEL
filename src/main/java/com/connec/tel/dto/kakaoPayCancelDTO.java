package com.connec.tel.dto;


public class kakaoPayCancelDTO {
	public String aid;
	public String tid;
	public String status;
	public String partner_order_id;
	public String aidpartner_user_id;
	public String payment_method_type;
	
	public Amount amount;
	public Amount approved_cancel_amount;
	public Amount canceled_amount;
	public Amount cancel_available_amount;
	
	
	
	public class Amount {
		public int total;
		public int tax_free;
		public int vat;
		public int point;

	}
}
