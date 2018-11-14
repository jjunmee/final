package com.jhta.netflix.survey.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.jhta.netflix.point_info.service.Point_infoService;
import com.jhta.netflix.point_info.vo.Point_infoVo;
import com.jhta.netflix.survey.service.SurveyService;
import com.jhta.netflix.survey.vo.SurveyVo;

@Component
public class SurveyScheduler {
	@Autowired SurveyService service;	
	@Autowired Point_infoService pointService;
	//매일 오전12:00에 호출되는 스케쥴러
	@Scheduled(cron="0 0 0 * * *")
	public void scheduler() {
		System.out.println("스케쥴러 레고!!!!!!!!!!!!!!!");
		try {		
			//현재날짜와 surveyEnd+1의 날짜가 같고, state가 등록완료인 설문번호 얻어오기
			List<SurveyVo> list=service.toUpdateSurveyVoSelect();
			//위에서 얻어온 설문번호의 state를 설문완료로 update하기
			if(list!=null) {
				for(SurveyVo vo:list) {
					int surveyNum=vo.getSurveyNum();
					Map<String, Object> map=new HashMap<String, Object>();
					map.put("surveyNum", surveyNum);
					map.put("state", "설문종료");
					service.surveyStateUpdate(map);//설문상태변경
					int userNum=vo.getUserNum();
					int leftPoint=service.leftPoint(surveyNum);
					Map<String, Object> map1=new HashMap<String, Object>();
					map1.put("point", leftPoint);
					map1.put("userNum", userNum);				
					service.userPointUpdate1(map1);//user테이블 point추가
					Point_infoVo pointVo=new Point_infoVo(0, null, "설문종료반환금-반환-"+leftPoint, "point", userNum);
					pointService.insert(pointVo);//pointinfo테이블에 포인트사용내역 추가
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
