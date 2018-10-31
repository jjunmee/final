 package com.jhta.netflix.survey.controller;


import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.jhta.netflix.survey.service.SurveyService;
import com.jhta.netflix.survey.vo.SurveyAnswerDto;
import com.jhta.netflix.survey.vo.SurveyAnswerVo;
import com.jhta.netflix.survey.vo.SurveyQuestionDto;
import com.jhta.netflix.survey.vo.SurveyQuestionVo;
import com.jhta.netflix.survey.vo.SurveyVideoVo;
import com.jhta.netflix.survey.vo.SurveyVo;

@Controller
public class SurveyController {
	@Autowired private SurveyService service;
	
	@RequestMapping(value="/survey/list", method=RequestMethod.GET)
	public String surveyList(int code,Model model) {
		String state="";
		
		if(code==1) {//������������ ����
			state="��ϿϷ�";			
		}else if(code==2){//�Ϸ�� ����(code:2)
			state="��������";
		}			
		List<SurveyVo> list= service.surveyListSelect(state);
		model.addAttribute("list",list);
		model.addAttribute("code",code);
		return ".survey.surveyList";
	}
	
	@RequestMapping(value="/survey/surveyInsert1", method=RequestMethod.GET)
	public String surveyForm1(Model model,HttpServletRequest request) {
		//String userId=(String)request.getSession().getAttribute("userId");
		String userId="alsl";
		int point=service.userSelect(userId).getPoint();
		model.addAttribute("userId",userId);
		model.addAttribute("userPoint",point);
		return ".survey.surveyForm1";
	}
	@RequestMapping(value="/survey/surveyInsert1",method=RequestMethod.POST)
	public String surveyForm1ok(SurveyVo vo,HttpServletRequest request,Model model) {
		//String userId=(String)request.getSession().getAttribute("userId");
		String userId="alsl";
		int userNum=service.userSelect(userId).getUsersNum();
		vo.setUserNum(userNum);
		if(service.surveyInsert(vo)>0) {
			//�������̺� �μ�Ʈ�����ϸ� �������̺��� ����Ʈ ������Ű��
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("userNum", userNum);
			map.put("point", vo.getSpoint());
			service.userPointUpdate(map);
		}
		return ".survey.surveyForm2";
	}
	
	@RequestMapping(value="/survey/surveyInsert2",method=RequestMethod.POST)
	public String survey(SurveyVo surveyVo,@ModelAttribute SurveyQuestionDto sqDto,
			@ModelAttribute SurveyAnswerDto saDto,MultipartFile file1,HttpSession session,int choiceType) {	
		//�������̺� insert
		//String userId=(String)session.getAttribute("userId");
		String userId="alsl";
		int userNum=service.userSelect(userId).getUsersNum();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userNum", userNum);
		//���������� �Է½�ų�� ������� �Է½�ų���� ȭ�� �����ٽ��غ���!
		map.put("state", "�����Ϸ�");
		int surveyNum=service.surveyNumSelect(map);
		surveyVo.setSurveyNum(surveyNum);
		surveyVo.setSurveyEnd(surveyVo.getSurveyEnd().replaceAll("/", "-"));
		service.surveyUpdate(surveyVo);
		
		//�����������̺� insert
		try {
			if(!file1.isEmpty()) {//������ �Ѿ������
				String uploadPath=session.getServletContext().getRealPath("/resources/upload/survey");
				String orgsrc=file1.getOriginalFilename();
				String savesrc=UUID.randomUUID()+"_"+orgsrc;
				InputStream is=file1.getInputStream();
				FileOutputStream fos=new FileOutputStream(uploadPath+"\\"+savesrc);
				FileCopyUtils.copy(is, fos);
				is.close();
				fos.close();
				System.out.println("���Ͼ��ε� ��� : "+uploadPath);
				long filesize=file1.getSize();
				System.out.println("����ũ�� : " + filesize);
				SurveyVideoVo svVo=new SurveyVideoVo(0, surveyNum, orgsrc, savesrc);
				service.surveyVideoInsert(svVo);
			}		
		}catch(NullPointerException npe) {//���ϰ����� npe�� �߻������� �׳� �ѱ�������?!
			System.out.println("�Ѿ�� ���� ����!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}catch(IOException ie) {
			ie.printStackTrace();
		}
		
		List<SurveyQuestionDto> qlist = sqDto.getQlist();
		List<SurveyAnswerDto> salist=saDto.getSalist();	
		int qtime=0;//������ ����Ƚ�����ϱ�		
		for(SurveyQuestionDto sq:qlist) {
			String sqTitle=sq.getSqTitle();
			SurveyQuestionVo sqVo=new SurveyQuestionVo(0, surveyNum, sqTitle, sq.getSqType());
			service.surveyQuestionInsert(sqVo);
			
			//������ȣ��������
			Map<String, Object> map1=new HashMap<String, Object>();
			map1.put("surveyNum", surveyNum);
			map1.put("sqTitle", sqTitle);
			int sqNum=service.sqNumSelect(map1);
			//������ ������ȣ�� ������̺� insert�ϱ�
			
			if(choiceType==1) {//�����ı׸����϶�
				for(int i=0;i<salist.size();i++) {
					SurveyAnswerDto alist=salist.get(i);
					for(String answer:alist.getAlist()) {
						SurveyAnswerVo saVo=new SurveyAnswerVo(0, sqNum, answer);
						service.surveyAnswerInsert(saVo);
					}						
				}					
			}else if(choiceType==2) {//�����������϶�								
				for(int i=0;i<salist.size();i++) {
					if(qtime==i) {
						SurveyAnswerDto alist=salist.get(i);
						for(String answer:alist.getAlist()) {
							SurveyAnswerVo saVo=new SurveyAnswerVo(0, sqNum, answer);
							service.surveyAnswerInsert(saVo);
						}					
					}
				}
				qtime++;
			}
		}
		return ".survey.home";
	}
	
}
