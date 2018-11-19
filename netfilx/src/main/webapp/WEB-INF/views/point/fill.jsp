<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mh.css'/>">
<style>
	#pointFillForm ul li{list-style: none; margin-left: 0;}
</style>
<div class="mhdiv">
	<h1>포인트 충전</h1>
	<form action="<c:url value='/point/fill'/>" method="post">
		<table>
			<tr>
				<th>충전금액</th>
				<td>
					<input type="number" name="pointPrice" id="id_pointPrice" min="1000" max="1000000" step="500" required>
				</td>
			</tr>
			<tr>
				<th>카드번호</th>
				<td>
					<input type="text" name="creditCardNumber" id="id_creditCardNumber" required>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="username" id="id_username" required>
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
		<input type="submit" value="충전">
	</form>
</div>