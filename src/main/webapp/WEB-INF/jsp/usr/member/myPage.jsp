<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="마이페이지"></c:set>
<%@ include file="../common/head.jspf"%>



<section>
	<div class="MyPage">
		<div class="MyPageBox">
			<div class="Rectangle6">
				<section class="mt-8 text-xl px-4">


					<div class="title">마이페이지</div>

					<div class="MyInfo">
						<span class="material-symbols-outlined"> person_edit </span>
						<div class="ContentName">나의 회원정보</div>
						<a class="MyInfoBtn" href="../member/myInfo">바로가기</a>
					</div>
					<div class="MyWrite">
						<span class="material-symbols-outlined"> edit_note </span>
						<div class="ContentName">나의 게시글</div>
						<a class="MyWriteBtn" href="">0 개</a>
					</div>
					<div class="MyReply">
						<span class="material-symbols-outlined"> mode_comment </span>
						<div class="ContentName">나의 댓글</div>
						<a class="MyReplyBtn" href="">0 개</a>
					</div>
					<div class="MyQna">
						<span class="material-symbols-outlined"> live_help </span>
						<div class="ContentName">나의 질문</div>
						<a class="MyQnaBtn" href="">0 개</a>
					</div>
					<div class="MyLike">
						<span class="material-symbols-outlined"> favorite </span>
						<div class="ContentName">나의 찜 목록</div>
						<a class="MyLikeBtn" href="">0 개</a>
					</div>


					<div class="btns">
						<button class="backBtn btn btn-sm" type="button" onclick="history.back();">뒤로가기</button>

					</div>

				</section>
			</div>
		</div>
	</div>
</section>

<style>
.title {
	font-weight: 600;
	color: #666666;
	margin-left: 10px;
}

.MyPage {
	width: 100%;
	height: 100vh;
	display: flex;
	flex-direction: column;
	margin-top: 100px;
	align-items: center;
	font-family: Pretendard;
}

.MyPageBox {
	width: 500px;
	height: 311px;
	position: relative;
}

.ContentName {
	color: #a9a9a9;
	font-size: 14px;
	font-weight: 500;
	left: 60px;
	position: absolute;
	display: flex;
}

.MyInfo {
	width: 400px;
	height: 24px;
	left: 115px;
	top: 160px;
	position: absolute;
	display: flex;
}

.MyInfoBtn {
	color: #666666;
	font-size: 14px;
	font-weight: 500;
	position: absolute;
	right: 140px;
}

.MyWrite {
	width: 400px;
	height: 24px;
	left: 115px;
	top: 230px;
	position: absolute;
	display: flex;
}

.MyWriteBtn {
	color: #666666;
	font-size: 14px;
	font-weight: 500;
	position: absolute;
	right: 140px;
}

.MyReply {
	width: 400px;
	height: 24px;
	left: 115px;
	top: 300px;
	position: absolute;
	display: flex;
}

.MyReplyBtn {
	color: #666666;
	font-size: 14px;
	font-weight: 500;
	position: absolute;
	right: 140px;
}

.MyQna {
	width: 400px;
	height: 24px;
	left: 115px;
	top: 370px;
	position: absolute;
	display: flex;
}

.MyQnaBtn {
	color: #666666;
	font-size: 14px;
	font-weight: 500;
	position: absolute;
	right: 140px;
}

.MyLike {
	width: 400px;
	height: 24px;
	left: 115px;
	top: 440px;
	position: absolute;
	display: flex;
}

.MyLikeBtn {
	color: #666666;
	font-size: 14px;
	font-weight: 500;
	position: absolute;
	right: 140px;
}

.MyInfo .material-symbols-outlined, .MyWrite .material-symbols-outlined,
	.MyReply .material-symbols-outlined, .MyQna .material-symbols-outlined,
	.MyLike .material-symbols-outlined {
	/* 변경 */
	position: absolute;
	left: 0px;
	color: #666666;
}

.Rectangle6 {
	width: 500px;
	height: 670px;
	left: 0px;
	top: 0px;
	position: absolute;
	background: rgba(255, 255, 255, 0);
	border-radius: 15px;
	border: 1px #a9a9a9 solid;
}

.joinBtn {
	width: 74px;
	height: 39px;
	position: absolute;
	right: 0px;
	top: 40px;
	color: #a9a9a9;
	font-size: 12px;
	font-weight: 600;
}

.backBtn {
	width: 100px;
	height: 39px;
	position: absolute;
	left: 40%;
	bottom: 30px;
}
</style>





<%@ include file="../common/foot.jspf"%>