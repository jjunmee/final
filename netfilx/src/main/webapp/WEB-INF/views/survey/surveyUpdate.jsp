<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>




<div id="surveyForm">
	<div class="surveyList">
		<div id="tab" class="leftBox">
			<div class="leftDivBox">
				<a href="<c:url value='/survey/list?code=1'/>">현재진행중인설문</a>
			</div>
			<div class="leftDivBox">
				<a href="<c:url value='/survey/list?code=2'/>">완료된 설문</a>
			</div>
			<div class="leftDivBox">
				<a href="<c:url value='/survey/mySurvey'/>">나의 설문지</a>
			</div>
		</div>
		<div id="box" class="rightBox">	
			<form name="frm" action="<c:url value='/survey/surveyInsert2'/>" method="post" enctype="multipart/form-data">
				<div id="surveyOverall">
					<div class="overall">
						<table style="width:80%">
							<tr class="tableshow">
								<th><label for="surveyName">설문제목</label></th>
								<td>
									<input type="text" id="surveyName" name="surveyName" value="${surveyVo.surveyName }" placeholder="설문제목을 입력하세요">
									<input type="button" id="hideBtn" value=" . . . ">
								</td>
							</tr>
							<tr class="tableshow">
								<th><label for="surveyDescription">설문내용</label></th>
								<td><textarea rows="5" cols="cols" id="surveyDescription" name="surveyDescription" value="${surveyVo.surveyDescription }" placeholder="설문내용을 입력하세요"></textarea></td>
							</tr>
							<tr class="tablehide">
								<th><label for="videoCheck"><input type="checkbox" id="videoCheck">영상첨부</label></th>
								<td><span id="file"></span></td>
							</tr>
							<tr class="tablehide">
								<th>설문종료일</th>
								<td><input type="text" id="surveyEnd" name="surveyEnd" readonly="readonly">value="${surveyVo.surveyEnd }</td>
							</tr>
						</table>
					</div>	
				</div>
				<div id="typeChoice" class="typeChoice">
					<input type="button" id="choice1" value="객관식그리드">
					<input type="button" id="choice2" value="복합질문타입">
				</div>
				<div id="mainSurvey1" class="mainSurvey1" style="display: none">			
					
				</div>
				<div id="mainSurvey2" class="mainSurvey2" style="display: none">
								
				</div>	
				<div id="opDiv" class="opDiv" style="display: none;margin-top: 10px;width:80%;">
					<input type="button" id="type1" onclick="checktype1()" value="객관식질문">
					<input type="button" id="type2" onclick="checktype2()" value="중복체크">
					<input type="button" id="type3" onclick="checktype3()" value="직선단계">
					<input type="button" id="type4" onclick="checktype4()" value="주관식질문">
				</div>
				
				<div id="qPlusBox" class="qPlusBox" style="display: none;margin-top:10px;width:80%;">				
					<input type="button" id="qPlus1" value="질문추가" >
					<input type="button" id="qPlus2" value="같은질문추가" >
				</div>
				<div id="things" class="things">
					<input type="hidden" name="surveyNum" value="${surveyNum }">
					<input type="button" id="submitBtn1" onclick="submitOk(1)" value="저장하기">
					<input type="button" id="submitBtn2" onclick="submitOk(2)" value="등록하기" style="display: none;">
				</div>
			</form>
		</div>
	</div>
</div>