package com.jhta.netflix.user.dao;

import com.jhta.netflix.user.vo.CertificationVo;

public interface CertificationDao {
	public int maxNo();
	public String getInfo(int no);
	public int insert(CertificationVo vo);
	public void cerTest();
}
