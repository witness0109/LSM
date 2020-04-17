<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="divEmpty">
	<div class="hiddenData">
		<span id="totalCntlist">${totalCntlist }</span>
	</div>
	<table class="col">
		<thead>
			<tr>
				<th scope="col">강의명</th>
				<th scope="col">기간</th>
			</tr>
		</thead>
		<tbody id="list">
			<c:if test="${totalCntlist eq 0 }">
				<tr>
					<td colspan="9">강의목록이 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:set var="nRow" value="${pageSize*(currentPagelist-1) }" />
			<c:forEach items="${cnsList }" var="list">
				<tr>
					<td><a href="javascript:fcnsUserList('1','${list.lec_seq }','${list.lec_nm}')">${list.lec_nm}</a></td>
					<td>${list.stDay }<span> ~ </span>${list.edDay}</td>
				</tr>
				<c:set var="nRow" value="${nRow + 1 }" />
			</c:forEach>

		</tbody>
		
	</table>
</div>