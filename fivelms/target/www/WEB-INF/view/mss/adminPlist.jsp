<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div class="divEmpty">
		<div class="hiddenData">
			<span id="totalCntaPlist">${totalCntaPlist }</span>
		</div>
		<table class="col">
			<thead>
				<tr>
					<th scope="col">강의</th>
					<th scope="col">강의실</th>
					<th scope="col">시작일</th>
					<th scope="col">종료일</th>
					<th scope="col">총일수</th>
				</tr>
			</thead>
			<tbody id="aPlist">
			<c:if test="${aPlist == null }">
				<tr>
					<td colspan="9">강의목록이 존재하지 않습니다.</td>
				</tr>
			</c:if>			
			<c:set var="nRow" value="${pageSize*(currentPageaPlist-1) }"/>
			<c:forEach items="${aPlist }" var="list">
				<tr>
					<td><a href="javascript:fPopModalPlistDtl('${list.lec_seq }')">${list.lec_nm}</a></td>
					<td>${list.rm_seq }</td>
					<td>${list.lec_st }</td>
					<td>${list.lec_ed }</td>
					<td>${list.total }</td>
				</tr>
				<c:set var="nRow" value="${nRow + 1 }"/>
			</c:forEach>
			
			</tbody>
		</table>
	</div>