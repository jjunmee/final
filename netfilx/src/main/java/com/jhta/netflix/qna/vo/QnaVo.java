package com.jhta.netflix.qna.vo;

import java.util.Date;

public class QnaVo {
	// 문의번호 
    private Integer qna_num;
    // 문의제목 
    private String qna_title;
    // 문의내용 
    private String qna_content;
    // 문의게시일 
    private Date qna_regdate;
    // 공개/비공개 
    private Boolean qna_open;
    // lev 
    private Integer lev;
    // step 
    private Integer step;
    // 유저번호 
    private Integer users_num;
    
    public QnaVo() {}
	public QnaVo(Integer qna_num, String qna_title, String qna_content, Date qna_regdate, Boolean qna_open, Integer lev,
			Integer step, Integer users_num) {
		super();
		this.qna_num = qna_num;
		this.qna_title = qna_title;
		this.qna_content = qna_content;
		this.qna_regdate = qna_regdate;
		this.qna_open = qna_open;
		this.lev = lev;
		this.step = step;
		this.users_num = users_num;
	}
	public Integer getQna_num() {
		return qna_num;
	}
	public void setQna_num(Integer qna_num) {
		this.qna_num = qna_num;
	}
	public String getQna_title() {
		return qna_title;
	}
	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}
	public String getQna_content() {
		return qna_content;
	}
	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}
	public Date getQna_regdate() {
		return qna_regdate;
	}
	public void setQna_regdate(Date qna_regdate) {
		this.qna_regdate = qna_regdate;
	}
	public Boolean getQna_open() {
		return qna_open;
	}
	public void setQna_open(Boolean qna_open) {
		this.qna_open = qna_open;
	}
	public Integer getLev() {
		return lev;
	}
	public void setLev(Integer lev) {
		this.lev = lev;
	}
	public Integer getStep() {
		return step;
	}
	public void setStep(Integer step) {
		this.step = step;
	}
	public Integer getUsers_num() {
		return users_num;
	}
	public void setUsers_num(Integer users_num) {
		this.users_num = users_num;
	}
    
    
}
