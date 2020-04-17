<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="divEmpty">
	<div class="hiddenData">
		<span id="totalCount">${totalCount}</span>
	</div>
	<table class="col">
		<thead>
			<tr>
				<th scope="col">강의명</th>
				<th scope="col">시작일</th>
				<th scope="col">종료일</th>
				<th scope="col">강의실</th>
				<th scope="col">강사명</th>
			</tr>
		</thead>
		<tbody id="lecList">
			<c:if test="${totalCount eq 0}">
				<tr>
					<td colspan="5">강의목록이 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
			<c:forEach items="${list}" var="list">
				<tr>
					<td><a href="javascript:fselectlecDtl('1','${list.lec_seq}')">${list.lec_nm}</a></td>
					<td>${list.lec_st}</td>
					<td>${list.lec_ed}</td>
					<td>${list.rm_seq}</td>
					<td>${list.user_id}</td>
				</tr>
			</c:forEach>		
		</tbody>
	</table>
</div>			