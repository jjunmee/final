<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mh.css'/>">
<style>
	#pointFillForm ul li{list-style: none; margin-left: 0;}
	#gradelist{box-sizing: border-box; font-family: 'Helvetica Neue', sans-serif;}
	#gradelist>ul>li>.bb>div{position: relative; padding: 5px 10px 5px 10px; border-left: 1px solid #fff; float: left;}
	#gradelist>ul>li>.bb>.cl{clear: left;  border-left: 0px;}
	#gradelist>ul>li>.bb{border: 3px solid #fff; height: 40px; margin-bottom: 15px; width: 800px;}
	#payForm table th{width: 200px;}
	#payForm table td{width: 600px;}
	#mCh th{width: 200px;}
	#mCh td{width: 600px;}
	#gradelist .gradebox {
		display: flex;
		flex-direction: column;
		justify-content: center;
	}
		
	#gradelist .radio-tile-group {
		display: flex;
		flex-direction: column;
		flex-wrap: wrap;
		justify-content: center;
	}
	
	#gradelist .input-container {
		position: relative;
		height:  30px;
		width:  400px;
		margin-bottom: 10px;
	}
	
	#gradelist .radio-button {
		opacity: 0;
		position: absolute;
		top: 0;
		left: 0;
		height: 30px;
		width: 400px;
		margin: 0;
		cursor: pointer;
	}
			
	#gradelist .radio-tile {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		width: 400px;
		height: 30px;
		border: 2px solid #ccc;
		border-radius: 5px;
		padding: 10px;
	}
	
	#gradelist .radio-tile-label {
		text-align: center;
		font-size: 8px;
		font-weight: 600;
		text-transform: uppercase;
		letter-spacing: 1px;
		color: #ccc;
	}
			
	#gradelist .radio-button:checked + .radio-tile {
		background-color: #ccc;
		border: 2px solid #ccc;
		color: white;
	}
	
	#gradelist .radio-tile-label {
		color: white;
	}

</style>
<script>
	$(function(){
		var code = '${code}';
		if(code != null && code != ""){
			alert(code);
		}
		//등급 리스트 뿌리기
		gradelist();
	});
	
	//등급뿌리기
	function gradelist(){
		$.ajax({
			url:"<c:url value='/grade/gradelist'/>",
			dataType:"json",
			success:function(data){
				var str="<div class=\"gradebox\">";
				$(data).each(function(i,json){
					str+= "<div class=\"input-container\">"
							+ "<input id=\"grade" + json.grade_num + "\" class=\"radio-button\" type=\"radio\" name=\"grade\" onclick=\"gradeselect(" + json.grade_price + "," + json.grade_num + ")\"/>"
							+ "<div class=\"radio-tile\">"
								+ "<label for=\"grade" + json.grade_num + "\" class=\"radio-tile-label\">" + json.grade_name + " / " + json.grade_person + " / " + json.grade_price + "</label>"
							+ "</div>"
						+ "</div>";
				});
				str+= "</div>";
				$("#gradelist").append(str);
			}
		});
	}
	
	function gradeselect(price,num){
		$("#gradePrice").empty();
		$("#usePoint").empty();
		$("#totalPrice").empty();
		var str1 = "<input type=\"number\" value=\"0\" name=\"pointPrice\" id=\"id_pointPrice\" min=\"0\" max=\"";
		//유저가 가지고 있는 포인트가 >= 멤버쉽금액보다
		if(${userPoint } >= price){
			str1 +=  price; 
		}else{
			str1 +=  ${userPoint }; 
		}
		str1 += "\" step=\"10\" onchange=\"pointCard(" + price + ")\" required>";
		var str = "<input type=\"hidden\" name=\"grade_num\" value=\"" + num + "\">";
		var str2 = price + "원<input type=\"hidden\" name=\"cardPrice\" value=\"" + price + "\">"
		$("#totalPrice").append(str2);
		$("#gradePrice").append(price + "원" + str);
		$("#usePoint").append(str1);
	}
	
	function pointCard(num){
		$("#totalPrice").empty();
		$("#pointErr").empty();
		$("#card").empty();
		//사용할 포인트
		var pointprice = $("#id_pointPrice").val();
		var total = 0;
		//사용할포인트 >= 결제해야할금액
		var str1 = ""
		var strcard = ""
		if(pointprice < num){
			total = num - pointprice;
			strcard = "<table>" +
						"<tr>" +
							"<th>총 결제 금액</th>" +
							"<td>" +
								"<span id=\"totalPrice\"></span>" +
							"</td>" +
						"</tr>" +
						"<tr>" +
							"<th>카드번호</th>" +
							"<td>" +
								"<input type=\"text\" name=\"creditCardNumber\" id=\"id_creditCardNumber\" valuse=\"0\" required>" +
							"</td>" +
						"</tr>" +
						"<tr>" +
							"<th>이름</th>" +
							"<td>" +
								"<input type=\"text\" name=\"username\" id=\"id_username\" valuse=\"0\" required>" +
							"</td>" +
						"</tr>" +
						"<tr>" +
							"<th>생일</th>" +
							"<td>" +
								"<select name=\"birthDate\" required>" +
									"<option></option>";
									for(var i=1; i<=31; i++){
										strcard +=	"<option value=\"" + i + "\" label=\"" + i + "\">" + i + "</option>";
									}
							strcard += "</select>" +
							"</td>" +
						"</tr>" +
						"<tr>" +
							"<th>생월</th>" +
							"<td>" +
								"<select name=\"birthMonth\" required>" +
									"<option></option>";
									for(var i=1; i<=12; i++){
										strcard +=	"<option value=\"" + i + "\" label=\"" + i + "월\">" + i + "월</option>";
									}
								strcard += "</select>" +
							"</td>" +
						"</tr>" +
						"<tr>" +
							"<th>생년</th>" +
							"<td><input type=\"number\" min=\"1800\" max=\"2018\" value=\"1994\" required></td>" +
						"</tr>" +
					"</table>";
		}else{
			$("#card").empty();
		}
		var str = total + "원<input type=\"hidden\" name=\"cardPrice\" value=\"" + total + "\">"
		$("#card").append(strcard);
		$("#totalPrice").append(str);
		$("#pointErr").append(str1);
	}
	function pointCh(){
		alert("멤버쉽을 선택해주세요");
	}
</script>
<div class="mhdiv">
	<h1>스트리밍 멤버쉽 결제</h1>
	<table id="mCh">
		<tr>
			<th>멤버쉽 선택</th>
			<td>
				<div id="gradelist"></div>
			</td>
		</tr>
	</table>
	<div id = "payForm">
	<form action="<c:url value='/pay/payment'/>" method="post" class="form1000">
		<table>
			<tr>
				<th>선택한 멤버쉽 금액</th>
				<td>
					<span id="gradePrice"></span>
				</td>
			</tr>
			<tr>
				<th>포인트결제</th>
				<td>
					보유포인트 : ${userPoint } <br>
					사용포인트 : <span id="usePoint"><input type="number" name="pointPrice" id="id_pointPrice" step="10" readonly="readonly" onclick="pointCh()"></span><span id="pointErr"></span>
				</td>
			</tr>
		</table>
		<div id="card">
			<table>
				<tr>
					<th>총 결제 금액</th>
					<td>
						<span id="totalPrice"></span>
					</td>
				</tr>
				<tr>
					<th>카드번호</th>
					<td>
						<input type="text" name="creditCardNumber" id="id_creditCardNumber" valuse="0" required>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="username" id="id_username" valuse="0" required>
					</td>
				</tr>
				<tr>
					<th>생일</th>
					<td>
						<select name="birthDate" required>
							<option></option>
							<option value="1" label="1">1</option>
							<option value="2" label="2">2</option>
							<option value="3" label="3">3</option>
							<option value="4" label="4">4</option>
							<option value="5" label="5">5</option>
							<option value="6" label="6">6</option>
							<option value="7" label="7">7</option>
							<option value="8" label="8">8</option>
							<option value="9" label="9">9</option>
							<option value="10" label="10">10</option>
							<option value="11" label="11">11</option>
							<option value="12" label="12">12</option>
							<option value="13" label="13">13</option>
							<option value="14" label="14">14</option>
							<option value="15" label="15">15</option>
							<option value="16" label="16">16</option>
							<option value="17" label="17">17</option>
							<option value="18" label="18">18</option>
							<option value="19" label="19">19</option>
							<option value="20" label="20">20</option>
							<option value="21" label="21">21</option>
							<option value="22" label="22">22</option>
							<option value="23" label="23">23</option>
							<option value="24" label="24">24</option>
							<option value="25" label="25">25</option>
							<option value="26" label="26">26</option>
							<option value="27" label="27">27</option>
							<option value="28" label="28">28</option>
							<option value="29" label="29">29</option>
							<option value="30" label="30">30</option>
							<option value="31" label="31">31</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>생월</th>
					<td>
						<select name="birthMonth" required>
							<option></option>
							<option value="1" label="1월">1월</option>
							<option value="2" label="2월">2월</option>
							<option value="3" label="3월">3월</option>
							<option value="4" label="4월">4월</option>
							<option value="5" label="5월">5월</option>
							<option value="6" label="6월">6월</option>
							<option value="7" label="7월">7월</option>
							<option value="8" label="8월">8월</option>
							<option value="9" label="9월">9월</option>
							<option value="10" label="10월">10월</option>
							<option value="11" label="11월">11월</option>
							<option value="12" label="12월">12월</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>생년</th>
					<td><input type="number" min="1800" max="2018" value="1994" required></td>
				</tr>
			</table>
		</div>
		<input type="submit" value="충전">
	</form>
	</div>
</div>