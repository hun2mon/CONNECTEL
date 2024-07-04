package com.connec.tel.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("profile")
public class ProfileDTO {
	// 직원정보
	private String emp_no;
	private int dept_code;
	private int rank_code;
	private String name;
	private String gender;
	private String email;
	private String password;
	private String phone;
	private String birth;
	private int post_no;
	private String address;
	private String detail_address;
	private String bank_name;
	private String account_no;
	private Date join_date;
	private String authority;
	private Date regist_date;
	private String updater;
	private Date update_date;
	private String register;
	private String dept_name;
	private String eName;
	private String rank_name;
	private int app_procedure;
	// 사진 정보
	private int pho_no;
	private String ori_pho_name;
	private String pho_name;
	private String ref_idx;
	private String pho_division;
	// 재직상태
	private String status_division;
	
	// 연차정보
	private int annual;
	private String leave_division;
	private int draft_no;
	private String leave_cate;
	private float leave_use;
	private Date leave_start;
	private Date leave_end;
	private String total_leave;
	private String use_leave;
	private String balance_leave;
	
	
	
	
	public String getTotal_leave() {
		return total_leave;
	}
	public void setTotal_leave(String total_leave) {
		this.total_leave = total_leave;
	}
	public String getUse_leave() {
		return use_leave;
	}
	public void setUse_leave(String use_leave) {
		this.use_leave = use_leave;
	}
	public String getBalance_leave() {
		return balance_leave;
	}
	public void setBalance_leave(String balance_leave) {
		this.balance_leave = balance_leave;
	}
	public int getAnnual() {
		return annual;
	}
	public void setAnnual(int annual) {
		this.annual = annual;
	}
	public String getLeave_division() {
		return leave_division;
	}
	public void setLeave_division(String leave_division) {
		this.leave_division = leave_division;
	}
	public int getDraft_no() {
		return draft_no;
	}
	public void setDraft_no(int draft_no) {
		this.draft_no = draft_no;
	}
	public String getLeave_cate() {
		return leave_cate;
	}
	public void setLeave_cate(String leave_cate) {
		this.leave_cate = leave_cate;
	}
	public float getLeave_use() {
		return leave_use;
	}
	public void setLeave_use(float leave_use) {
		this.leave_use = leave_use;
	}
	public Date getLeave_start() {
		return leave_start;
	}
	public void setLeave_start(Date leave_start) {
		this.leave_start = leave_start;
	}
	public Date getLeave_end() {
		return leave_end;
	}
	public void setLeave_end(Date leave_end) {
		this.leave_end = leave_end;
	}
	public String getStatus_division() {
		return status_division;
	}
	public void setStatus_division(String status_division) {
		this.status_division = status_division;
	}
	public String getRef_idx() {
		return ref_idx;
	}
	public void setRef_idx(String ref_idx) {
		this.ref_idx = ref_idx;
	}
	public int getPho_no() {
		return pho_no;
	}
	public void setPho_no(int pho_no) {
		this.pho_no = pho_no;
	}
	public String getOri_pho_name() {
		return ori_pho_name;
	}
	public void setOri_pho_name(String ori_pho_name) {
		this.ori_pho_name = ori_pho_name;
	}
	public String getPho_name() {
		return pho_name;
	}
	public void setPho_name(String pho_name) {
		this.pho_name = pho_name;
	}

	public String getPho_division() {
		return pho_division;
	}
	public void setPho_division(String pho_division) {
		this.pho_division = pho_division;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public int getDept_code() {
		return dept_code;
	}
	public void setDept_code(int dept_code) {
		this.dept_code = dept_code;
	}
	public int getRank_code() {
		return rank_code;
	}
	public void setRank_code(int rank_code) {
		this.rank_code = rank_code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public int getPost_no() {
		return post_no;
	}
	public void setPost_no(int post_no) {
		this.post_no = post_no;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetail_address() {
		return detail_address;
	}
	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}
	public String getBank_name() {
		return bank_name;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	public String getAccount_no() {
		return account_no;
	}
	public void setAccount_no(String account_no) {
		this.account_no = account_no;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public Date getRegist_date() {
		return regist_date;
	}
	public void setRegist_date(Date regist_date) {
		this.regist_date = regist_date;
	}
	public String getUpdater() {
		return updater;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String geteName() {
		return eName;
	}
	public void seteName(String eName) {
		this.eName = eName;
	}
	public String getRank_name() {
		return rank_name;
	}
	public void setRank_name(String rank_name) {
		this.rank_name = rank_name;
	}
	public int getApp_procedure() {
		return app_procedure;
	}
	public void setApp_procedure(int app_procedure) {
		this.app_procedure = app_procedure;
	}

}
