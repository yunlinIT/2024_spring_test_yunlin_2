<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원정보 수정"></c:set>
<%@ include file="../common/head.jspf"%>
<!-- Member modify 관련 -->

<script type="text/javascript">
	let MemberModify__submitFormDone = false;
	function MemberModify__submit(form) {
		if (MemberModify__submitFormDone) {
			return;
		}
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
			if (form.loginPwConfirm.value.length == 0) {
				alert('비밀번호 확인을 입력해주세요');
				form.loginPwConfirm.focus();
				return;
			}
			if (form.loginPw.value != form.loginPwConfirm.value) {
				alert('비밀번호가 일치하지 않습니다');
				form.loginPw.focus();
				return;
			}
		}
		form.name.value = form.name.value.trim();
		form.nickname.value = form.nickname.value.trim();
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		form.email.value = form.email.value.trim();

		MemberModify__submitFormDone = true;
		form.submit();
	}
</script>





<section>
	<div class="Modify">
		<div class="ModifyBox">
			<div class="Rectangle6">
				<section class="mt-8 text-xl px-4">
					<form action="../member/doModify" method="POST" onsubmit="MemberModify__submit(this); return false;">

						<div class="title">회원정보</div>

						<div class="regDate">
							<span class="material-symbols-outlined"> calendar_month </span>
							<div class="ContentName">가입날짜</div>
							<div class="content">${rq.loginedMember.regDate }</div>
						</div>
						<div class="loginId">
							<span class="material-symbols-outlined"> person_edit </span>
							<div class="ContentName">아이디</div>
							<div class="content">${rq.loginedMember.loginId }</div>
						</div>


						<!-- 						일단 여기 수정 -->
						<div class="loginPw">
							<span class="material-symbols-outlined"> lock </span>
							<div class="ContentName">새 비밀번호</div>

							<input id="inputBox" class="input input-sm w-full max-w-xs" autocomplete="off" type="text"
								placeholder="비밀번호를 입력해주세요" name="loginPw" />


						</div>
						<div class="loginPwConfirm">
							<span class="material-symbols-outlined"> check_circle </span>
							<div class="ContentName">비밀번호확인</div>
							
							<input id="inputBox" class="input input-sm w-full max-w-xs" autocomplete="off" type="text"
								placeholder="비밀번호 확인을 입력해주세요" name="loginPwConfirm" />
						</div>


						<div class="name">
							<span class="material-symbols-outlined"> person </span>
							<div class="ContentName">이름</div>
							<input id="inputBox" class="input input-sm w-full max-w-xs" autocomplete="off" type="text"
								placeholder="이름을 입력해주세요" name="name" value="${rq.loginedMember.name }"/>
						</div>
						
						<div class="nickname">
							<span class="material-symbols-outlined"> person_edit </span>
							<div class="ContentName">닉네임</div>
							<input id="inputBox" class="input input-sm w-full max-w-xs" autocomplete="off" type="text"
								placeholder="닉네임을 입력해주세요" name="nickname" value="${rq.loginedMember.nickname }"/>
						</div>
						
						<div class="cellphoneNum">
							<span class="material-symbols-outlined"> call </span>
							<div class="ContentName">전화번호</div>
							<input id="inputBox" class="input input-sm w-full max-w-xs" autocomplete="off" type="text"
								placeholder="전화번호 입력해주세요" name="cellphoneNum" value="${rq.loginedMember.cellphoneNum }"/>
						</div>
						
						<div class="email">
							<span class="material-symbols-outlined"> mail </span>
							<div class="ContentName">이메일</div>
							<input id="inputBox" class="input input-sm w-full max-w-xs" autocomplete="off" type="text"
								placeholder="이메일을 입력해주세요" name="email" value="${rq.loginedMember.email }"/>
						</div>



						<input class="modifyBtn btn btn-sm" type="submit" value="수정" />

						<div class="btns">

							<button class="backBtn" type="button" onclick="history.back();">뒤로가기</button>

						</div>
			</div>
</section>


<style>
.title {
	font-weight: 600;
	color: #666666;
	margin-left: 10px;
}

.Modify {
	width: 100%;
	height: 100vh;
	display: flex;
	flex-direction: column;
	margin-top: 100px;
	align-items: center;
	font-family: Pretendard;
}

.ModifyBox {
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

.content {
	color: #666666;
	font-size: 14px;
	font-weight: 500;
	position: absolute;
	left: 150px;
}

.regDate {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 130px;
	position: absolute;
	display: flex;
	align-items: center;
}

.loginId {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 200px;
	position: absolute;
	display: flex;
	align-items: center;
}

.loginPw {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 270px;
	position: absolute;
	display: flex;
	align-items: center;
}

#inputBox {
	width: 200px; 
	left : 150px;
	position: absolute;
	display: flex;
}

.loginPwConfirm {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 340px;
	position: absolute;
	display: flex;
	align-items: center;
}

.name {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 410px;
	position: absolute;
	display: flex;
	align-items: center;
}

.nickname {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 480px;
	position: absolute;
	display: flex;
	align-items: center;
}

.cellphoneNum {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 550px;
	position: absolute;
	display: flex;
	align-items: center;
}

.email {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 620px;
	position: absolute;
	display: flex;
	align-items: center;
}

.regDate .material-symbols-outlined, .loginId .material-symbols-outlined,
	.name .material-symbols-outlined, .nickname .material-symbols-outlined,
	.cellphoneNum .material-symbols-outlined, .email .material-symbols-outlined
	{
	/* 변경 */
	margin-right: 30px;
	color: #666666;
}

.Rectangle6 {
	width: 500px;
	height: 810px;
	left: 0px;
	top: 0px;
	position: absolute;
	background: rgba(255, 255, 255, 0);
	border-radius: 15px;
	border: 1px #a9a9a9 solid;
}

.loginBtn {
	width: 74px;
	height: 39px;
	position: absolute;
	right: 0px;
	top: 40px;
	color: #a9a9a9;
	font-size: 12px;
	font-weight: 400;
}

.modifyBtn {
	width: 100px;
	height: 39px;
	position: absolute;
	left: 40%;
	bottom: 30px;
	font-size: 13px;
}

.backBtn {
	width: 74px;
	height: 39px;
	position: absolute;
	right: 15px;
	bottom: 20px;
	color: #a9a9a9;
	font-size: 12px;
	font-weight: 600;
}
</style>





<%@ include file="../common/foot.jspf"%>