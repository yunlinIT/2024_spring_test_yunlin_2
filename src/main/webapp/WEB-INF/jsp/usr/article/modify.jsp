<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시글 수정"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>

<!-- Article modify 관련 -->
<script type="text/javascript">
	let ArticleModify__submitFormDone = false;
	function ArticleModify__submit(form) {
		if (ArticleModify__submitFormDone) {
			return;
		}
		form.title.value = form.title.value.trim();
		if (form.title.value == 0) {
			alert('제목을 입력해주세요');
			return;
		}
		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();
		if (markdown.length == 0) {
			alert('내용 써라');
			editor.focus();
			return;
		}
		form.body.value = markdown;
		ArticleModify__submitFormDone = true;
		form.submit();
	}
</script>

<section class="mt-8 text-xl px-4">
	<h1 style="text-align: center; font-size: 25; margin-top: 100px; font-weight: 600;">게시글 수정</h1>
	<div class="mx-auto">
		<form action="../article/doModify" method="POST" onsubmit="ArticleModify__submit(this); return false;">
			<input type="hidden" name="body">
			<input type="hidden" name="id" value="${article.id }" />
			<table class="modify-box table-box-1 mx-auto" border="1">
				<tbody>
					<tr>
						<th style="font-weight: 600">번호</th>
						<td>${article.id }</td>
					</tr>
					<tr>
						<th style="font-weight: 600">작성날짜</th>
						<td>${article.regDate }</td>
					</tr>
					<tr>
						<th style="font-weight: 600">수정날짜</th>
						<td>${article.updateDate }</td>
					</tr>
					<tr>
						<th style="font-weight: 600">작성자</th>
						<td>${article.extra__writer }</td>
					</tr>
					<tr>
						<th style="font-weight: 600">제목</th>
						<td>
							<input class="ititle input input-bordered input-md w-full " type="text" name="title" placeholder="제목을 입력해주세요"
								value="${article.title }" />
						</td>
					</tr>

					<tr>
						<th style="font-weight: 600">내용</th>
						<td>
							<%-- 								<textarea class="input input-bordered w-full max-w-xs" type="text" name="body" placeholder="내용을 입력해주세요" />${article.body }</textarea> --%>
							<div class="toast-ui-editor">
								<script type="text/x-template">${article.body }
      </script>
							</div>
						</td>
					</tr>
					<tr>
						<th></th>
						<td style="text-align: left;">
							<button class="writeBtn btn btn-sm" type="submit" value="수정">수정</button>
							<span style="float: right;">
								<button class="backBtn btn btn-sm btn-ghost" class="" type="button" onclick="history.back();">뒤로가기</button>
							</span>
						</td>
					</tr>
				</tbody>
			</table>
		</form>


	</div>
</section>



<%@ include file="../common/foot.jspf"%>