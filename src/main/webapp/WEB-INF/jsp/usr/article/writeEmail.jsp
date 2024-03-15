<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="제휴 문의"></c:set>
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
	<h1 style="text-align: center; font-size: 25; margin-top: 100px; font-weight: 600;">제휴 문의하기</h1>
	<div class="mx-auto">
		<form action="../article/doWrite" method="POST" onsubmit="ArticleWrite__submit(this); return false;"> <!-- 이메일 전송 기능 구현 시 여기 수정해야함 -->
			<input type="hidden" name="body">
			<table class="write-box table-box-1 mx-auto mt-10" border="1">
				<tbody>


					<tr>
						<th style="font-weight: 600">이름</th>
						<td><input class="title input input-bordered input-md w-full max-w-xs" autocomplete="off" type="text"
							placeholder="이름을 입력해주세요" name="title" />
							<div style="display: inline-block; font-weight: 600; margin-left: 4em;">연락처</div> <input
							class="title input input-bordered input-md w-full max-w-xs" autocomplete="off" type="text"
							placeholder="전화번호를 입력해주세요" name="title" style="margin-left: 1.8em" /></td>

					</tr>

					<tr>
						<th style="font-weight: 600">이메일</th>
						<td><input class="title input input-bordered input-md w-full " autocomplete="off" type="text"
							placeholder="id@email.com" name="title" style="width: 780px" /></td>
					</tr>
					<tr>
						<th style="font-weight: 600">내용</th>
						<td>
							<!-- 							<div class="toast-ui-editor"> --> <!-- 								<script type="text/x-template"> --> <textarea
								placeholder="내용을 입력해주세요" class="textarea textarea-bordered textarea-lg" style="width: 780px; height: 300px;'"></textarea>
							</script>
							</div>
						</td>
					</tr>
					<tr>
						<th style="font-weight: 600"></th>
						<td><p style="font-weight:700;">개인정보 수집 및 이용안내</p> <br /> 1. 목적: 제휴 문의에 따른 연락처 정보 확인 <br /> 2. 항목: 이름, 연락처, 이메일 <br /> 3. 보유기간: 제휴 가능성 판단을
							위해 검토 완료 후 3개월 간 보관하며, 이후 해당 정보를 지체없이 파기합니다. <br />
						</td>
					</tr>
					<tr>
						<th style="font-weight: 600"></th>
						<td> <input type="checkbox" checked="checked" class="checkbox checkbox-xs" style="margin-right: 10px; "/> 개인정보 수집 및 이용에 동의합니다.
						</td>
					</tr>


					<tr>
						<th></th>
						</br>
						<td style="text-align: left;">
							<button class="writeBtn btn btn-sm" type="submit" value="등록" style="margin-left: 320px;">문의하기</button> <span style="float: right;">
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