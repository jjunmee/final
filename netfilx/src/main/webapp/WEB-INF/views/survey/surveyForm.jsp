<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<script type="text/javascript">
	
	
	var cloneCnt=0;	
	
	$(document).ready(function(){
		$("#videoCheck").click(function(){
			if(this.checked==true){
				$("#file").append("<input type='file' name='file1'>");
			}else{
				$("#file").empty();
			}
		});
		$("#surveyEnd").datepicker({
			dateFormat: "yy/mm/dd", //날짜 포맷형식
			showOn:"button",
			buttonText:"달력펼치기",
			changeMonth: true,
			changeYear:true		
		});
		$("#choice1").click(function(){
			$("#typeChoice").hide();			
			$("#mainSurvey1").show();
		});
		$("#choice2").click(function(){
			$("#typeChoice").hide();			
			$("#mainSurvey2").show();
			appendDiv();			
		});
		function appendDiv(){
			var qBox=document.createElement("div");
			var br=document.createElement("br");
			qBox.setAttribute("id","box"+ (++cloneCnt));
			qBox.setAttribute("name","box"+cloneCnt);
			
			var sqContent=document.createElement("input");
			sqContent.setAttribute("type","text");
			sqContent.setAttribute("placeholder","질문내용을 입력하세요");
			/*
			var opDiv=document.createElement("div");
			opDiv.setAttribute("id","opDiv");
			var type1=document.createElement("input");
			type1.setAttribute("type","button");
			type1.setAttribute("value","객관식 질문");
			var type2=document.createElement("input");	
			type2.setAttribute("type","button");
			type2.setAttribute("value","중복선택");
			var type3=document.createElement("input");
			type3.setAttribute("type","button");
			type3.setAttribute("value","직선 단계");
			var type4=document.createElement("input");
			type4.setAttribute("type","button");
			type4.setAttribute("value","주관식 질문");
			opDiv.appendChild(type1);
			opDiv.appendChild(type2);
			opDiv.appendChild(type3);
			opDiv.appendChild(type4);
			*/
			var option=document.createElement("input");
			option.setAttribute("type","text");
			option.setAttribute("placeholder","옵션을 입력하세요");
			
			qBox.append(sqContent);
			$("#opDiv").css("display","block");
			$("#mainSurvey2").append(qBox);	
			
			$("#type1").click(function(){
				$("#opDiv").css("display","none");
				qBox.append(br);
				qBox.append(option);
				$("#qPlus").css("display","block");				
			});
			$("#type2").click(function(){
				$("#opDiv").css("display","none");
				qBox.append(br);
				qBox.append(option);
				$("#qPlus").css("display","block");				
			});
			$("#type3").click(function(){
				$("#opDiv").css("display","none");
				qBox.append(br);
				qBox.append(option);
				$("#qPlus").css("display","block");				
			});
			$("#type4").click(function(){
				$("#opDiv").css("display","none");
				qBox.append(br);
				qBox.append(option);
				$("#qPlus").css("display","block");				
			});
			
			
		}
		$("#opPlus").click(function(){
			var br=document.createElement("br");
			var option=document.createElement("input");
			option.setAttribute("type","text");
			option.setAttribute("placeholder","옵션을 입력하세요");
			var box="box"+cloneCnt;
			var qbox=document.getElementById(box);
			qbox.appendChild(br);							
			qbox.appendChild(option);
		});
		/*
		function optionPlus(cloneCnt){				
			var br1=document.createElement("br");
			var option1=document.createElement("input");
			option1.setAttribute("type","text");
			option1.setAttribute("placeholder","옵션을 입력하세요");
			qBox.append(br1);			
			qBox.append(option1);
		}
		*/
		$("#qPlus1").click(function(){
			$("#qPlus").css("display","none");
			appendDiv();
		});
		$("#qPlus2").click(function(){
			$("#qPlus").css("display","none");
		});
		
	});
	
	
	

</script>

<form id="frm" action="<c:url value='/survey/surveyInsert'/>" method="post">
	<div id="surveyOverall">
		<label>설문제목<input type="text" name="surveyName" placeholder="설문제목을 입력하세요"></label><br>
		<label><input type="checkbox" id="videoCheck">영상첨부</label><span id="file"></span><br>
		<label>설문내용<br><textarea rows="5" cols="cols" name="surveyContent" placeholder="설문내용을 입력하세요"></textarea></label><br>
		설문종료일<input type="text" id="surveyEnd" name="surveyEnd" readonly="readonly">		
	</div>
	<div id="typeChoice">
		<input type="button" id="choice1" value="객관식그리드">
		<input type="button" id="choice2" value="복합질문타입">
	</div>
	<div id="mainSurvey1" style="display: none">
		
	</div>
	<div id="mainSurvey2" style="display: none">		
		
	</div>	
	<div id="opDiv" style="display: none">
		<input type="button" id="type1" value="객관식질문">
		<input type="button" id="type2" value="중복체크">
		<input type="button" id="type3" value="직선단계">
		<input type="button" id="type4" value="주관식질문">
	</div>
	<div id="qPlus" style="display: none">
		<input type="button" id="opPlus" value="옵션추가">
		<br>
		<input type="button" id="qPlus1" value="질문추가">
		<input type="button" id="qPlus2" value="같은질문추가">
	</div>
</form>
