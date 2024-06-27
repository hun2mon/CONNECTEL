package com.connec.tel.dto;

import org.apache.ibatis.type.Alias;

@Alias("faqDTO")
public class FaqDTO {
    private String FAQ_no; // FAQ_no를 int가 아닌 String으로 변경
    private String FAQ_subject;
    private String FAQ_content;
    private String register;
    private String FAQ_category;
    private String updater;
    private String FAQ_date;

    public String getUpdater() {
		return updater;
	}

	public void setUpdater(String updater) {
		this.updater = updater;
	}

	public String getFAQ_no() {
        return FAQ_no;
    }

    public void setFAQ_no(String fAQ_no) {
        FAQ_no = fAQ_no;
    }

    public String getFAQ_subject() {
        return FAQ_subject;
    }

    public void setFAQ_subject(String fAQ_subject) {
        FAQ_subject = fAQ_subject;
    }

    public String getFAQ_content() {
        return FAQ_content;
    }

    public void setFAQ_content(String fAQ_content) {
        FAQ_content = fAQ_content;
    }

    public String getRegister() {
        return register;
    }

    public void setRegister(String register) {
        this.register = register;
    }

    public String getFAQ_category() {
        return FAQ_category;
    }

    public void setFAQ_category(String fAQ_category) {
        FAQ_category = fAQ_category;
    }
}
