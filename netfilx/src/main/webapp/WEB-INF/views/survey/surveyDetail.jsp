<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link type='text/css' href="<c:url value='/resources/css/survey.css'/>" rel='stylesheet' media='screen' />
<script type="text/javascript">
	$(function(){
		var description="${surveyVo.surveyDescription}";
		description=description.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
		$('#surveyDescription').innerHTML(description);
		
	});
	function idCheck(n){
		if(n==0){//나의설문지
			location.href="<c:url value='/survey/mySurvey'/>";
		}else if(n==1){//설문구매
			location.href="<c:url value='/survey/surveyInsert1'/>";
		}
	}
</script>
<style type="text/css">
	.surveyList{height:auto;overflow: hidden}
	.surveyList table{color: white;text-align: center;}
	.surveyList table .sqTitle{text-align: left;}
	.surveyList #things input[type=submit]{margin-left:44%;width:70px;margin-top: 35px;}
	#surveyDescription{float:left;width:50%;margin-left: 2%;}
	#surveyDate{width:30%;float: right;margin-right: 2%;}
	.surveyList #video{width:700px;height:350px;margin:auto;text-align:center;}
	.surveyList #descDate{float:none;height:auto;overflow: hidden;margin-top:10px;margin-bottom: 15px;}
	#question input[type=text]{
		background-color: #2E2E2E;
	    color: #fff;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    width:700px;
	    margin-top:10px;
	}
	
	
</style>
<div class="surveyList">
	<div id="tab" class="leftBox">
		<c:if test="${userSts=='user' }">
			<div class="surBtn"><input type="button" onclick="javascript:idCheck(1);" value="설문구매하러가기"></div>
		</c:if>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=1'/>">진행중인 설문지</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=2'/>">완료된 설문지</a>
		</div>
		<c:if test="${userSts=='user' }">
			<div class="leftDivBox">
				<a href="javascript:idCheck(0);">나의 설문지</a>
			</div>
		</c:if>
	</div>
	
	<div id="box" class="centerBox">		
		<div id="surveyName"><span style="font-size: 26px;margin-left: 36%;">${surveyVo.surveyName }</span></div>
		<div id="descDate">
			<div id="surveyDescription"><h4>${surveyVo.surveyDescription }</h4></div>
			<div id="surveyDate"><span style="font-size: 20px;float:right">${surveyVo.surveyStart } ~ ${surveyVo.surveyEnd }</span></div>
		</div>
		<c:if test="${videoVo!=null }">
			<div id="video">
				<video controls autoplay style="max-width: 100%;max-height: 100%;">
					<source src='<c:url value="/resources/upload/survey/${videoVo.svSaveSrc }"/>' type="video/mp4">
				</video>
			</div>
		</c:if>
		
		<form id="qstFrm" action="<c:url value='/survey/resultInsert'/>" method="post">			
			<div id="question">
				<c:if test="${choiceType=='1' }">
					<table>
						<tr>
							<th style="width:35%;"></th>
							<c:forEach var="i" begin="0" end="${fn:length(saList[0])-1 }">
								<th style="text-align: center;">${saList[0][i].saAnswer }</th>
							</c:forEach>
						</tr>
						<c:forEach var="i" begin="0" end="${fn:length(sqVoList)-1 }">
							<tr>
								<th class="sqTitle">
									${sqVoList[i].sqTitle }
									<input type="hidden" name="resultList[${i }].sqNum" value="${sqVoList[i].sqNum }">
								</th>
								<c:forEach var="j" begin="0" end="${fn:length(saList[0])-1 }">
									<td style="text-align: center;"><input type="radio" name="resultList[${i }].srAnswer" value="${saList[0][j].saAnswer }"></td>
								</c:forEach>
							</tr>
						</c:forEach>						
					</table>				
				</c:if>		
			
				<c:if test="${choiceType=='2' }">
					<table>
						<c:forEach var="i" begin="0" end="${fn:length(sqVoList)-1 }">
							<tr><th class="sqTitle">${sqVoList[i].sqTitle }</th></tr>
							<input type="hidden" name="resultList[${i }].sqNum" value="${sqVoList[i].sqNum }">
							<c:if test="${sqVoList[i].sqType==1 }">
								<c:forEach var="j" begin="0" end="${fn:length(saList[i])-1 }">
								<tr>
									<td style="text-align: left;">
										<input type="radio" name="resultList[${i }].srAnswer" value="${saList[i][j].saAnswer }">
										${saList[i][j].saAnswer }
									</td>
								</tr>
								</c:forEach>
							</c:if>
							<c:if test="${sqVoList[i].sqType==2 }">
								<c:forEach var="j" begin="0" end="${fn:length(saList[i])-1 }">
								<tr>
									<td style="text-align: left;">
										<input type="checkbox" name="resultList[${i }].srAnswer" value="${saList[i][j].saAnswer }">
										${saList[i][j].saAnswer }
									</td>
								</tr>
								</c:forEach>			
							</c:if>
							<c:if test="${sqVoList[i].sqType==3 }">
								<tr>
									<td style="text-align: left;">
										<table>
											<c:set var="num1" value="${fn:split(saList[i][0].saAnswer,'!@#$')[0] }"/>
											<fmt:formatNumber value="${num1 }" type="number" var="n1"/>
											<c:set var="num2" value="${fn:split(saList[i][1].saAnswer,'!@#$')[0] }"/>
											<fmt:formatNumber value="${num2 }" type="number" var="n2"/>
											<c:set var="ans1" value="${fn:split(saList[i][0].saAnswer,'!@#$')[1] }"/>
											<c:set var="ans2" value="${fn:split(saList[i][1].saAnswer,'!@#$')[1] }"/>
											<tr style="border-bottom: solid 3px #151515"><td></td>
											<c:forEach var="j" begin="${n1 }" end="${n2 }">								
												<td style="text-align: center">${j }</td>								
											</c:forEach>
											<td></td></tr>
											<tr style="border-bottom: solid 3px #151515"><td style="text-align: center">${ans1 }</td>
											<c:forEach var="j" begin="${n1 }" end="${n2 }">								
												<td style="text-align: center"><input type="radio" name="resultList[${i }].srAnswer" value="${j }"></td>								
											</c:forEach>
											<td style="text-align: center">${ans2 }</td>
											</tr>
										</table>
									</td>
								</tr>
							</c:if>
							<c:if test="${sqVoList[i].sqType==4 }">
								<tr><td style="text-align: left;"><input type="text" name="resultList[${i }].srAnswer"></td></tr>
							</c:if>
						</c:forEach>
					</table>	
				</c:if>		
			</div>
			<div id="things">
				<input type="hidden" id="userId" value="${sessionScope.id }">				
				<input type="hidden" name="field" value="${field }">
				<input type="hidden" name="keyword" value="${keyword }">
				<input type="hidden" name="surveyNum" value="${surveyVo.surveyNum }">
				<input type="submit" value="참가">
			</div>
		</form>
	</div>
	
</div>