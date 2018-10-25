<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<script type="text/javascript">
	
	
	var cloneCnt=0;	
	
	$(document).ready(function(){
		$("#videoCheck").click(function(){
			if(this.checked==true){
				$("#file").append("<input type='file' name='file1'>");
				$("#frm").attr("enctype","multipart/form-data");
			}else{
				$("#file").empty();
				$("#frm").attr("enctype","application/www-form-urlencoded");				
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
			sqContent.setAttribute("name","sqTitle"+cloneCnt);
			sqContent.setAttribute("placeholder","질문내용을 입력하세요");
			
			qBox.append(sqContent);
			//qBox.append(option);
			$("#opDiv").css("display","block");
			$("#mainSurvey2").append(qBox);				
			
		}
		
		$("#type1").click(function(){
			var br=document.createElement("br");
			var sqType=document.createElement("input");
			sqType.setAttribute("type","hidden");
			sqType.setAttribute("name",cloneCnt+"/sqType");
			sqType.setAttribute("value","1");
			
			var op1=document.createElement("input");
			op1.setAttribute("type","text");
			op1.setAttribute("name",cloneCnt+"/saAnswer");
			op1.setAttribute("placeholder","옵션을 입력하세요");
			$("#opDiv").css("display","none");
			var box="box"+cloneCnt;
			var qbox=document.getElementById(box);
			qbox.append(br);
			qbox.append(op1);	
			$("#qPlus").css("display","block");				
		});
		$("#type2").click(function(){
			var br=document.createElement("br");
			var op2=document.createElement("input");
			op2.setAttribute("type","text");
			op2.setAttribute("placeholder","옵션을 입력하세요");
			$("#opDiv").css("display","none");
			var box="box"+cloneCnt;
			var qbox=document.getElementById(box);
			qbox.append(br);
			qbox.append(op2);	
			$("#qPlus").css("display","block");				
		});
		$("#type3").click(function(){
			var br=document.createElement("br");
			var op3=document.createElement("input");
			op3.setAttribute("type","text");
			op3.setAttribute("placeholder","옵션을 입력하세요");
			$("#opDiv").css("display","none");
			var box="box"+cloneCnt;
			var qbox=document.getElementById(box);
			qbox.append(br);
			qbox.append(op3);	
			$("#qPlus").css("display","block");				
		});
		$("#type4").click(function(){
			var br=document.createElement("br");
			var op4=document.createElement("input");
			op4.setAttribute("type","text");
			op4.setAttribute("readonly","readonly");
			op4.setAttribute("value","주관식답변입니다.");
			$("#opDiv").css("display","none");
			var box="box"+cloneCnt;
			var qbox=document.getElementById(box);
			qbox.append(br);
			qbox.append(op4);				
			$("#qPlus").css("display","block");
			$("#opPlus").css("display","none");
		});
		
		
		$("#opPlus").click(function(){
			var br=document.createElement("br");
			var option=document.createElement("input");
			option.setAttribute("type","text");
			option.setAttribute("name",cloneCnt+"/saAnswer");
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
			$("#opPlus").css("display","block");
			$("#qPlus").css("display","none");
			appendDiv();
		});
		$("#qPlus2").click(function(){
			$("#opPlus").css("display","block");
			$("#qPlus").css("display","none");
			appendDiv();
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
		<input type="button" id="opPlus" style="display: block" value="옵션추가">		
		<input type="button" id="qPlus1" value="질문추가">
		<input type="button" id="qPlus2" value="같은질문추가">
	</div>
	<input type="submit" value="등록">
</form>
