package com.jhta.netflix.count_limit.vo;

public class Count_limitVo {
	private int cl_num;
	private int count;
	private int users_num;
	public Count_limitVo() {
	}
	public Count_limitVo(int cl_num, int count, int users_num) {
		this.cl_num = cl_num;
		this.count = count;
		this.users_num = users_num;
	}
	public int getCl_num() {
		return cl_num;
	}
	public void setCl_num(int cl_num) {
		this.cl_num = cl_num;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getUsers_num() {
		return users_num;
	}
	public void setUsers_num(int users_num) {
		this.users_num = users_num;
	}
	
	
}
