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
			var quest=$("#question").clone(true);
			quest.attr("id","quest");
			quest.attr("name","quest");
			$("#mainSurvey2").append(quest);
			$("#mainSurvey2").css("display","block");			
			$("#quest").css("display","block");			
		});		
		
	});
	function showContent1(event){
		var par=event.target.parentNode;
		var next=event.target.parentNode.nextElementSibling;
		par.style.display="none";
		next.style.display="block";			
		
	}
	function showContent2(event){
		var par=event.target.parentNode;
		var next=event.target.parentNode.nextElementSibling.nextElementSibling;
		par.style.display="none";
		next.style.display="block";			
	}
	function showContent3(event){
		var par=event.target.parentNode;
		var next=event.target.parentNode.nextElementSibling.nextElementSibling.nextElementSibling;
		par.style.display="none";
		next.style.display="block";			
	}
	function showContent4(event){
		var par=event.target.parentNode;
		var next=event.target.parentNode.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling;
		par.style.display="none";
		next.style.display="block";			
	}
	function appendDiv1(e){
		var question=document.getElementById("question");
		var quest=question.cloneNode(true);
		quest.setAttribute("id", "quest");
		quest.setAttribute("name","quest");
		var op=quest.firstElementChild.nextElementSibling.nextElementSibling;
		op.style.display="block";
		op.nextElementSibling.style.display="none";
		op.nextElementSibling.nextElementSibling.style.display="none";
		op.nextElementSibling.nextElementSibling.nextElementSibling.style.display="none";
		op.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.style.display="none";
		document.getElementById("mainSurvey2").append(quest);
		quest.style.display="block";
		e.target.parentNode.style.display="none";
	}
	function appendDiv2(e){		
		var question=document.getElementsByName("quest");
		var quest=question[question.length-1].cloneNode(true);		
		//var quest=question[num].cloneNode(true);
		//quest.setAttribute("id", "quest");
		document.getElementById("mainSurvey2").append(quest);
		quest.style.display="block";
		e.target.parentNode.style.display="none";
		//document.getElementById("sqType").style.display="block";
		//quest.firstChild.nextElementSibling.nextElementSibling.style.display="block";		
	}
	function optionPlus(event){
		var saa=document.getElementById("saAnswer").cloneNode(true);
		event.target.previousElementSibling.append(saa);
	}
	
	

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


	<div id="question" style="display: none">
		<input type="text" name="sqContent" placeholder="질문제목을 입력하세요">
		<br>
		<div id="sqType">
			<input type="button" id="type1" onclick="showContent1(event)" value="객관식질문">
			<input type="button" id="type2" onclick="showContent2(event)" value="중복체크">
			<input type="button" id="type3" onclick="showContent3(event)" value="직선단계">
			<input type="button" id="type4" onclick="showContent4(event)" value="주관식질문">
		</div>
		<div id="content1" style="display: none">
			<div id="option">
				<input type="text" id="saAnswer" name="saAnswer" placeholder="옵션을 입력하세요">
				<br>
			</div>
			<input type="button" onclick="optionPlus(event)" value="옵션추가">			
			<br>
			<div id="btnBox">
				<input type="button" id="qPlus1" onclick="appendDiv1(event)" value="질문추가">
				<input type="button" id="qPlus2" onclick="appendDiv2(event)" value="같은질문추가">
			</div>
		</div>
		<div id="content2" style="display: none">
			<input type="text" name="saAnswer" placeholder="옵션을 입력하세요">
			<br>
			<input type="button" onclick="optionPlus()" value="옵션추가">	
			<br>
			<div id="btnBox">
				<input type="button" id="qPlus1" onclick="appendDiv1(event)" value="질문추가">
				<input type="button" id="qPlus2" onclick="appendDiv2(event)" value="같은질문추가">
			</div>
		</div>
		<div id="content3" style="display: none">
			<input type="text" name="saAnswer" placeholder="옵션을 입력하세요">
			<br>
			<input type="button" onclick="optionPlus()" value="옵션추가">	
			<br>
			<div id="btnBox">
				<input type="button" id="qPlus1" onclick="appendDiv1(event)" value="질문추가">
				<input type="button" id="qPlus2" onclick="appendDiv2(event)" value="같은질문추가">
			</div>
		</div>
		<div id="content4" style="display: none">
			<input type="text" name="saAnswer" placeholder="옵션을 입력하세요">
			<br>
			<input type="button" onclick="optionPlus()" value="옵션추가">	
			<br>
			<div id="btnBox">
				<input type="button" id="qPlus1" onclick="appendDiv1(event)" value="질문추가">
				<input type="button" id="qPlus2" onclick="appendDiv2(event)" value="같은질문추가">
			</div>
		</div>
	</div>
</form>
