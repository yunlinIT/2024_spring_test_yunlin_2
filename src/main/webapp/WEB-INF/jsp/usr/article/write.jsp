<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시글 작성"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<!-- Article write 관련 -->
<script type="text/javascript">
	let ArticleWrite__submitFormDone = false;
	function ArticleWrite__submit(form) {
		if (ArticleWrite__submitFormDone) {
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
			alert('내용을 입력해주세요');
			editor.focus();
			return;
		}
		form.body.value = markdown;
		ArticleWrite__submitFormDone = true;
		form.submit();
	}
</script>

<section class="mt-8 text-xl px-4">
	<h1 style="text-align: center; font-size: 25; margin-top: 100px; font-weight: 600;">게시글 작성</h1>
	<div class="mx-auto">
		<form action="../article/doWrite" method="POST" onsubmit="ArticleWrite__submit(this); return false;">
			<input type="hidden" name="body">
			<table class="write-box table-box-1 mx-auto" border="1">
				<tbody>
					<tr>
						<th style="font-weight: 600">작성자</th>
						<td>
							<div>${rq.loginedMember.nickname }</div>
						</td>
					</tr>
					<tr>
						<th style="font-weight: 600">게시판</th>
						<td>
							<select class="select select-bordered select-sm w-full max-w-xs" name="boardId">
								<!-- 									<option selected="selected" disabled>게시판을 선택해주세요</option> -->
								<option value="1">크레마 소식</option>
								<option value="2">자유게시판</option>
								<option value="3">질문게시판</option>
							</select>
						</td>
					</tr>
					<tr>
						<th style="font-weight: 600">제목</th>
						<td>
							<input class="title input input-bordered input-md w-full " autocomplete="off" type="text"
								placeholder="제목을 입력해주세요" name="title" />
						</td>
					</tr>
					<tr>
						<th style="font-weight: 600">내용</th>
						<td>
							<div class="toast-ui-editor">
								<script type="text/x-template">
      </script>
							</div>
						</td>
					</tr>


					<tr>
						<th></th>
						<td style="text-align: left;">
							<button class="writeBtn btn btn-sm" type="submit" value="등록">등록</button>
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


<style>
.backBtn {
	color: #a9a9a9;
}
</style>

<%@ include file="../common/foot.jspf"%>