<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="#{board.name }"></c:set>
<%@ include file="../common/head.jspf"%>


<section class="mt-8 text-xl px-4">
	<div class="mx-auto overflow-x-auto">


		<h1 style="text-align: center; font-size: 25; margin-top: 100px;">${board.name}</h1>
		<div class="area-for-badge mx-auto" style="width: 50%; position: relative;">
			<div class="badge badge-outline" style="margin-bottom: 10px;">${articlesCount }개</div>
		</div>

	</div>
	<table class="table-box-1 table mx-auto custom-table" style="width: 50%;">
		<colgroup>
			<col style="width: 8%" />
			<col style="width: 50%" />
			<col style="width: 10%" />
			<col style="width: 15%" />
			<col style="width: 5%" />
			<col style="width: 5%" />
			<col style="width: 5%" />
		</colgroup>
		<thead>
			<tr>
				<th style="background-color: #f9f9f9f9;">번호</th>
				<th style="text-align: center; background-color: #f9f9f9f9;">제목</th>
				<th style="background-color: #f9f9f9f9;">작성자</th>
				<th style="text-align: center; background-color: #f9f9f9f9;">날짜</th>
				<th style="text-align: center; background-color: #f9f9f9f9;">조회수</th>
				<th style="text-align: center; background-color: #f9f9f9f9;">좋아요</th>
				<th style="text-align: center; background-color: #f9f9f9f9;">싫어요</th>

			</tr>
		</thead>
		<tbody>
			<c:forEach var="article" items="${articles }">
				<tr class="hover">

					<td>${article.id }</td>

					<td>
						<a href="detail?id=${article.id }">${article.title }
							<c:if test="${article.extra__repliesCnt > 0 }">
								<span style="color: red;">[${article.extra__repliesCnt }]</span>
							</c:if>
						</a>
					</td>
					<td>${article.extra__writer }</td>
					<td style="text-align: center;">${article.regDate.substring(0,10) }</td>
					<td style="text-align: center;">${article.hitCount }</td>
					<td style="text-align: center;">${article.goodReactionPoint }</td>
					<td style="text-align: center;">${article.badReactionPoint }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 	글쓰기버튼 -->
	<div class="area-for-writeBtn mx-auto" style="width: 50%; position: relative;">
		
		<a class="writeBtn btn btn-sm" href="../article/write" style="position: absolute; right: 15px; top: 15px;">글쓰기</a>
	</div>
	
	
	<!-- 	동적 페이징 -->
	<div class="pagination flex justify-center mt-3" style="margin-top: 50px;">
		<c:set var="paginationLen" value="3" />
		<c:set var="startPage" value="${page -  paginationLen  >= 1 ? page - paginationLen : 1}" />
		<c:set var="endPage" value="${page +  paginationLen  <= pagesCount ? page + paginationLen : pagesCount}" />

		<c:set var="baseUri" value="?boardId=${boardId }" />
		<c:set var="baseUri" value="${baseUri }&searchKeywordTypeCode=${searchKeywordTypeCode}" />
		<c:set var="baseUri" value="${baseUri }&searchKeyword=${searchKeyword}" />

		<c:if test="${startPage > 1 }">
			<a class="btn btn-circle btn-ghost btn-xs" style="margin-left: 5px; margin-right: 5px;" href="${baseUri }&page=1">1</a>
			<button class="btn btn-xs btn-circle btn-disabled" style="margin-left: 5px; margin-right: 5px;">...</button>
		</c:if>

		<c:forEach begin="${startPage }" end="${endPage }" var="i">
			<a class="btn btn-circle btn-ghost btn-xs ${param.page == i ? 'btn-active' : '' }"
				style="margin-left: 5px; margin-right: 5px;" href="${baseUri }&page=${i }">${i }</a>
		</c:forEach>

		<c:if test="${endPage < pagesCount }">
			<button class="btn btn-xs btn-circle btn-disabled" style="margin-left: 5px; margin-right: 5px;">...</button>
			<a class="btn btn-circle btn-ghost btn-xs" style="margin-left: 5px; margin-right: 5px;"
				href="${baseUri }&page=${pagesCount }">${pagesCount }</a>
		</c:if>

	</div>
	
	
	<!-- 검색창 -->
	<div class="mb-4 flex justify-center" style="margin-top: 50px;">
		<div class="flex"></div>
		<form action="">
			<input type="hidden" name="boardId" value="${param.boardId }" />
			<select data-value="${param.searchKeywordTypeCode }" class="select select-bordered select-sm w-full max-w-xs"
				style="width: 100px;" name="searchKeywordTypeCode">
				<option value="title">제목</option>
				<option value="body">내용</option>
				<option value="title,body">제목+내용</option>
			</select>
			<input value="${param.searchKeyword }" name="searchKeyword" type="text" placeholder="검색어를 입력해주세요"
				class="input-sm input input-bordered w-48 max-w-xs" style="margin-top: 5px;" />
			<button class="btn btn-ghost btn-sm" type="submit">검색</button>
		</form>
	</div>

</section>



<%@ include file="../common/foot.jspf"%>