<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시글 상세보기"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>

<!-- <iframe src="http://localhost:8081/usr/article/doIncreaseHitCountRd?id=372" frameborder="0"></iframe> -->

<!-- 변수 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	params.memberId = parseInt('${loginedMemberId}');
	
	console.log(params);
	console.log(params.memberId);
	
	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
	var isAlreadyAddBadRp = ${isAlreadyAddBadRp};
	
	
</script>

<!-- 조회수 -->
<script>
	function ArticleDetail__doIncreaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);

		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}

	$(function() {
		// 		ArticleDetail__doIncreaseHitCount();
		setTimeout(ArticleDetail__doIncreaseHitCount, 2000);
	});
</script>

<!-- 좋아요 싫어요  -->
<script>
	<!-- 좋아요 싫어요 버튼	-->
	function checkRP() {
		if(isAlreadyAddGoodRp == true){
			$('#likeButton').toggleClass('btn-outline');
		}else if(isAlreadyAddBadRp == true){
			$('#DislikeButton').toggleClass('btn-outline');
		}else {
			return;
		}
	}
	
	function doGoodReaction(articleId) {
		if(isNaN(params.memberId) == true){
			if(confirm('로그인 해야해. 로그인 페이지로 가실???')){
				var currentUri = encodeURIComponent(window.location.href);
				window.location.href = '../member/login?afterLoginUri=' + currentUri; // 로그인 페이지에 원래 페이지의 uri를 같이 보냄
			}
			return;
		}
		
		$.ajax({
			url: '/usr/reactionPoint/doGoodReaction',
			type: 'POST',
			data: {relTypeCode: 'article', relId: articleId},
			dataType: 'json',
			success: function(data){
				console.log(data);
				console.log('data.data1Name : ' + data.data1Name);
				console.log('data.data1 : ' + data.data1);
				console.log('data.data2Name : ' + data.data2Name);
				console.log('data.data2 : ' + data.data2);
				if(data.resultCode.startsWith('S-')){
					var likeButton = $('#likeButton');
					var likeCount = $('#likeCount');
					var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					
					if(data.resultCode == 'S-1'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}else if(data.resultCode == 'S-2'){
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}else {
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}
					
				}else {
					alert(data.msg);
				}
		
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('좋아요 오류 발생 : ' + textStatus);

			}
			
		});
	}
	
	
	
	function doBadReaction(articleId) {
		
		if(isNaN(params.memberId) == true){
			if(confirm('로그인 해야해. 로그인 페이지로 가실???')){
				var currentUri = encodeURIComponent(window.location.href);
				window.location.href = '../member/login?afterLoginUri=' + currentUri; // 로그인 페이지에 원래 페이지의 uri를 같이 보냄
			}
			return;
		}
		
	 $.ajax({
			url: '/usr/reactionPoint/doBadReaction',
			type: 'POST',
			data: {relTypeCode: 'article', relId: articleId},
			dataType: 'json',
			success: function(data){
				console.log(data);
				console.log('data.data1Name : ' + data.data1Name);
				console.log('data.data1 : ' + data.data1);
				console.log('data.data2Name : ' + data.data2Name);
				console.log('data.data2 : ' + data.data2);
				if(data.resultCode.startsWith('S-')){
					var likeButton = $('#likeButton');
					var likeCount = $('#likeCount');
					var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					
					if(data.resultCode == 'S-1'){
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
					}else if(data.resultCode == 'S-2'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
		
					}else {
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
					}
			
				}else {
					alert(data.msg);
				}
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('싫어요 오류 발생 : ' + textStatus);
			}
			
		});
	}
	
	$(function() {
		checkRP();
	});
</script>

<!-- 댓글 -->
<script>
		var ReplyWrite__submitDone = false;

		function ReplyWrite__submit(form) {
			if (ReplyWrite__submitDone) {
				alert('이미 처리중입니다');
				return;
			}
			console.log(123);
			
			console.log(form.body.value);
			
			if (form.body.value.length < 3) {
				alert('댓글은 3글자 이상 입력해');
				form.body.focus();
				return;
			}

			ReplyWrite__submitDone = true;
			form.submit();

		}
</script>
<!-- 댓글 수정 -->
<script>
function toggleModifybtn(replyId) {
	
	console.log(replyId);
	
	$('#modify-btn-'+replyId).hide();
	$('#save-btn-'+replyId).show();
	$('#reply-'+replyId).hide();
	$('#modify-form-'+replyId).show();
}

function doModifyReply(replyId) {
	 console.log(replyId); // 디버깅을 위해 replyId를 콘솔에 출력
	    
	    // form 요소를 정확하게 선택
	    var form = $('#modify-form-' + replyId);
	    console.log(form); // 디버깅을 위해 form을 콘솔에 출력

	    // form 내의 input 요소의 값을 가져옵니다
	    var text = form.find('input[name="reply-text-' + replyId + '"]').val();
	    console.log(text); // 디버깅을 위해 text를 콘솔에 출력

	    // form의 action 속성 값을 가져옵니다
	    var action = form.attr('action');
	    console.log(action); // 디버깅을 위해 action을 콘솔에 출력
	
    $.post({
    	url: '/usr/reply/doModify', // 수정된 URL
        type: 'POST', // GET에서 POST로 변경
        data: { id: replyId, body: text }, // 서버에 전송할 데이터
        success: function(data) {
        	$('#modify-form-'+replyId).hide();
        	$('#reply-'+replyId).text(data);
        	$('#reply-'+replyId).show();
        	$('#save-btn-'+replyId).hide();
        	$('#modify-btn-'+replyId).show();
        },
        error: function(xhr, status, error) {
            alert('댓글 수정에 실패했습니다: ' + error);
        }
	})
}
</script>

<!-- 상세보기페이지 -->

<section class="detail-page">

	<!-- 글 상세보기 부분 -->

	<div class="page-title">자유게시판</div>

	<!-- 	상단버튼들 -->


	<div class="page-btns">
		<div class="modify-delete-btns">
			<c:if test="${article.userCanModify }">
				<a class="modify-btn" href="../article/modify?id=${article.id }">수정</a>
			</c:if>
			<c:if test="${article.userCanDelete }">
				<a class="delete-btn" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
					href="../article/doDelete?id=${article.id }">삭제</a>
			</c:if>
		</div>
		<button class="list-btn" type="button" onclick="history.back();">목록</button>
	</div>

	<!-- 	본문 부분 -->

	<div class="detail-section">
		<div class="title">${article.title }</div>
		<div class="writer">${article.extra__writer }</div>
		<div class="regDate">${article.regDate }</div>
		<div class="view-count">
			<div class="viewcount-name article-detail__hit-count">조회수</div>
			<div class="viewcount-num">${article.hitCount }</div>
		</div>
		<div class="top-line"></div>
		<div class="body"><div class="toast-ui-viewer">
							<script type="text/x-template">${article.body}</script></div>
		<div class="like-dislike-btns">
			<!-- 좋아요 버튼 -->
			<span class="img-2 material-symbols-outlined heart"> favorite </span>
			<button class="like" id="likeButton" onclick="doGoodReaction(${param.id})">좋아요</button>
			<div class="like-count-num" id="likeCount">${article.goodReactionPoint }</div>

			<!-- 싫어요 버튼 -->

			<span class="img material-symbols-outlined thumb_down"> thumb_down </span>
			<button class="dislike" id="DislikeButton" onclick="doBadReaction(${param.id})">싫어요</button>
			<div class="dislike-count-num" id="DislikeCount">${article.badReactionPoint }</div>
		</div>
		<div class="bottom-line"></div>
	</div>



	<!-- 댓글 작성 부분 -->

	<div class="reply-section">
		<div class="write-review" style="font-weight: 600; width: 1050px">댓글 작성</div>
		</br>

		<c:if test="${rq.isLogined() }">
			<form action="../reply/doWrite" method="POST" onsubmit="ReplyWrite__submit(this); return false;">
				<input type="hidden" name="relTypeCode" value="article" /> <input type="hidden" name="relId" value="${article.id }" />

				<textarea class="input input input-bordered input-md w-full" autocomplete="off" placeholder="댓글을 남겨주세요" name="body"
					style="height: 83px; width:1064px;"> </textarea>

				<div></div>
				<input class="btn btn-sm mt-4" type="submit" value="등록" />
			</form>
		</c:if>
		<c:if test="${!rq.isLogined() }">
			<a href="${rq.loginUri }" style="text-decoration: underline; font-weight: 600;">로그인</a> 후 이용해주세요.
				</c:if>
		</br>




		<!-- 댓글 목록 부분 -->

		<div class="reply-count">
			<div class="reply-title" style="font-weight: 600; font-size: 17px;">댓글</div>
			<div class=" reply-count-num" style="font-weight: 700; font-size: 13px">(${repliesCount })</div>
		</div>

		<c:forEach var="reply" items="${replies }">
			<div class="reply">
				<div class="reply-box">
					<div class="reply-writer 댓글작성자" style="font-size: 13px;">${reply.extra__writer }</div>





					<div class="reply-body 댓글내용" style="font-size: 14px; margin-top:4px;">
						<span id="reply-${reply.id }">${reply.body }</span>
						<form method="POST" id="modify-form-${reply.id }" style="display: none;" action="/usr/reply/doModify">
							<input style="width: 1064px;"type="text" value="${reply.body }" name="reply-text-${reply.id }" />
						</form>
					</div>
					
					<div class="reply-regDate 날짜" style="margin-top:5px;">${reply.regDate.substring(0,10) }</div>
				

					<!-- 	수정 삭제 버튼		 -->
					<div class="mod-del-btns" style="font-weight: 600; color: #666666; margin-top:10px;">
						<c:if test="${reply.userCanModify }">
							<button onclick="toggleModifybtn('${reply.id}');" id="modify-btn-${reply.id }" style="white-space: nowrap;">수정</button>
							<button onclick="doModifyReply('${reply.id}');" style="white-space: nowrap; display: none;"
								id="save-btn-${reply.id }">저장</button>

						</c:if>

						<c:if test="${reply.userCanDelete }">
							<a style="white-space: nowrap; margin-left: 10px;" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
								href="../reply/doDelete?id=${reply.id }">삭제</a>
						</c:if>
					</div>
					<div class="reply-box-bottom-line"></div>
				</div>

			</div>
		</c:forEach>

	</div>
</section>

<script>

</script>


<style>
.detail-page {
	margin: 100px auto 0;
	/* 수정된 부분: 상단 마진을 100px로 지정하여 요소를 브라우저 위에서 100px 아래로 내립니다. */
	display: flex;
	flex-direction: column;
	align-items: center;
	font-weight: 400;
	white-space: nowrap;
	padding: 0 20px;
	max-width: 1100px;
}

@media ( max-width : 991px) {
	.detail-page {
		white-space: initial;
	}
}

.page-title {
	color: #333;
	font: 20px Inter, sans-serif;
	font-weight: 600;
}

.page-btns {
	align-self: stretch;
	display: flex;
	width: 100%;
	align-items: start;
	justify-content: space-between;
	gap: 20px;
	font-size: 10px;
	color: #fff;
	font-weight: 600;
	text-align: center;
}

@media ( max-width : 991px) {
	.page-btns {
		max-width: 100%;
		flex-wrap: wrap;
		white-space: initial;
	}
}

.modify-delete-btns {
	display: flex;
	margin-top: 11px;
	gap: 15px;
}

@media ( max-width : 991px) {
	.modify-delete-btns {
		white-space: initial;
	}
}

.modify-btn {
	font-family: Pretendard, sans-serif;
	font-size: 12px;
	border-radius: 5px;
	border: 1px solid #fff;
	background-color: #333;
	aspect-ratio: 2.74;
	justify-content: center;
	padding: 7px 23px;
	border-radius: 5px
}

@media ( max-width : 991px) {
	.modify-btn {
		white-space: initial;
		padding: 0 20px;
	}
}

.delete-btn {
	font-family: Pretendard, sans-serif;
	font-size: 12px;
	border-radius: 5px;
	border: 1px solid #fff;
	background-color: #333;
	aspect-ratio: 2.74;
	justify-content: center;
	padding: 7px 23px;
}

@media ( max-width : 991px) {
	.delete-btn {
		white-space: initial;
		padding: 0 20px;
	}
}

.list-btn {
	font-family: Pretendard, sans-serif;
	font-size: 12px;
	border-radius: 5px;
	border: 1px solid #fff;
	background-color: #333;
	margin-top: 11px;
	aspect-ratio: 2.74;
	justify-content: center;
	padding: 7px 23px;
}

@media ( max-width : 991px) {
	.list-btn {
		white-space: initial;
		padding: 0 20px;
	}
}

.detail-section {
	align-self: stretch;
	display: flex;
	margin-top: 31px;
	width: 100%;
	flex-direction: column;
	font-size: 12px;
	color: #333;
}

@media ( max-width : 991px) {
	.detail-section {
		max-width: 100%;
		white-space: initial;
	}
}

.title {
	width: 100%;
	font: 500 20px Pretendard, sans-serif;
	font-size: 21px;
}

@media ( max-width : 991px) {
	.title {
		max-width: 100%;
	}
}

.writer {
	font-family: Pretendard, sans-serif;
	font-weight: 600;
	font-size: 14px;
	margin-top: 15px;
	width: 100%;
	margin-top: 15px;
}

@media ( max-width : 991px) {
	.writer {
		max-width: 100%;
	}
}

.regDate {
	color: #a9a9a9;
	font-family: Pretendard, sans-serif;
	margin-top: 10px;
	width: 100%;
}

@media ( max-width : 991px) {
	.regDate {
		max-width: 100%;
	}
}

.view-count {
	align-self: start;
	display: flex;
	margin-top: 11px;
	gap: 7px;
	color: #a9a9a9;
}

@media ( max-width : 991px) {
	.view-count {
		white-space: initial;
	}
}

.viewcount-name {
	font-family: Pretendard, sans-serif;
}

.viewcount-num {
	font-family: Pretendard, sans-serif;
}

.top-line {
	background-color: #d1d1d1;
	width: 1170px;
	max-width: 100%;
	height: 1px;
	margin: 14px 12px 0 0;
}

@media ( max-width : 991px) {
	.top-line {
		margin-right: 10px;
	}
}

.body {
	font-family: Pretendard, sans-serif;
	margin-top: 16px;
	width: 100%;
	font-size: 14px;
	font-weight: 500;
}

@media ( max-width : 991px) {
	.body {
		max-width: 100%;
	}
}

.like-dislike-btns {
	align-self: start;
	display: flex;
	justify-content: space-between;
	gap: 4px;
	margin: 294px 0 -2px;
}

@media ( max-width : 991px) {
	.like-dislike-btns {
		margin-top: 40px;
		white-space: initial;
	}
}

.thumb_down {
	aspect-ratio: 1;
	object-fit: auto;
	object-position: center;
	width: 12px;
	fill: rgba(255, 255, 255, 0);
	margin-top: 1px;
	margin-left: 10px;
	font-size: 16px;
}

.like {
	font-family: Pretendard, sans-serif;
	font-weight: 600;
}

.like-count-num {
	font-family: Pretendard, sans-serif;
	font-weight: 600;
}

.heart {
	aspect-ratio: 1;
	object-fit: auto;
	object-position: center;
	width: 12px;
	color: red;
	margin-top: 1px;
	font-size: 16px;
}

.dislike {
	font-family: Pretendard, sans-serif;
	font-weight: 600;
}

.dislike-count-num {
	font-family: Pretendard, sans-serif;
	font-weight: 600;
	margin: auto 0;
}

.bottom-line {
	background-color: #d1d1d1;
	margin-top: 33px;
	width: 1170px;
	max-width: 100%;
	height: 1px;
	margin: 14px 12px 0 0;
}

@media ( max-width : 991px) {
	.top-lin {
		max-width: 100%;
	}
}

.reply-section {
	align-self: flex-start; /* 부모 요소 왼쪽에 붙이기 위해 추가 */
	margin-top: 20px; /* 필요한 경우 위쪽 여백 조정 */
}

.reply-count {
	display: flex;
	margin-top: 24px;
	gap: 9px;
	color: #333;
	font-weight: 500;
}

@media ( max-width : 991px) {
	.reply-count {
		white-space: initial;
	}
}

.reply-title {
	font: 15px Pretendard, sans-serif;
}

.reply-count-num {
	margin-top: 2px;
	font: 12px Pretendard, sans-serif;
}

.reply {
	display: flex;
	margin-top: 32px;
	justify-content: space-between;
	gap: 20px;
}

@media ( max-width : 991px) {
	.reply {
		white-space: initial;
	}
}

.reply-box {
	display: flex;
	flex-direction: column;
	font-size: 12px;
	color: #333;
}

.reply-box-bottom-line {
	background-color: #e8e8e8;
	margin-top: 33px;
	width: 1075px;
	max-width: 100%;
	height: 1px;
	margin: 14px 12px 0 0;
}

@media ( max-width : 991px) {
	.reply-box {
		white-space: initial;
	}
}

.reply-writer {
	font-family: Pretendard, sans-serif;
	font-weight: 600;
}

.reply-body {
	font-family: Pretendard, sans-serif;
	margin-top: 8px;
}

.reply-regDate {
	color: #a9a9a9;
	margin-top: 13px;
	font: 10px Pretendard, sans-serif;
}

.re-reply-btn {
	color: #a9a9a9;
	align-self: end;
	margin-top: 42px;
	font: 10px Pretendard, sans-serif;
}

@media ( max-width : 991px) {
	.re-reply-btn {
		margin-top: 40px;
	}
}

.re-reply {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	margin: 17px 0 0 15px;
}

@media ( max-width : 991px) {
	.re-reply {
		margin-left: 10px;
		white-space: initial;
	}
}

.re-reply-box {
	display: flex;
	flex-direction: column;
	font-size: 12px;
	color: #333;
}

@media ( max-width : 991px) {
	.re-reply-box {
		white-space: initial;
	}
}

.re-reply-writer {
	font-family: Pretendard, sans-serif;
	font-weight: 600;
}

.re-reply-body {
	font-family: Pretendard, sans-serif;
	margin-top: 8px;
}

.re-reply-regDate {
	color: #a9a9a9;
	margin-top: 13px;
	font: 10px Pretendard, sans-serif;
}

.re-re-reply-bnt {
	color: #a9a9a9;
	align-self: end;
	margin-top: 42px;
	font: 10px Pretendard, sans-serif;
}

@media ( max-width : 991px) {
	.re-re-reply-bnt {
		margin-top: 40px;
	}
}
</style>







<%@ include file="../common/foot.jspf"%>