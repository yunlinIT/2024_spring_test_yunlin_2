package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.demo.interceptor.BeforeActionInterceptor;
import com.example.demo.interceptor.NeedLoginInterceptor;
import com.example.demo.interceptor.NeedLogoutInterceptor;

@Configuration
public class MyWebMVCConfigurer implements WebMvcConfigurer {

	// BeforeActionInterceptor 불러오기(연결)
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;

	// NeedLoginInterceptor 불러오기(연결)
	@Autowired
	NeedLoginInterceptor needLoginInterceptor;

	// NeedLogoutInterceptor 불러오기(연결)
	@Autowired
	NeedLogoutInterceptor needLogoutInterceptor;

	// 인터셉터 등록(적용)
	public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**")
//				.excludePathPatterns("/error");
//
//		registry.addInterceptor(needLoginInterceptor).addPathPatterns("/usr/article/write")
//				.addPathPatterns("/usr/article/doWrite").addPathPatterns("/usr/article/modify")
//				.addPathPatterns("/usr/article/doModify").addPathPatterns("/usr/article/doDelete");
//
//		registry.addInterceptor(needLogoutInterceptor).addPathPatterns("/usr/member/login")
//				.addPathPatterns("/usr/member/doLogin").addPathPatterns("/usr/member/join")
//				.addPathPatterns("/usr/member/doJoin");

		InterceptorRegistration ir;

		ir = registry.addInterceptor(beforeActionInterceptor);
		ir.addPathPatterns("/**");
		ir.addPathPatterns("/favicon.ico");
		ir.excludePathPatterns("/resource/**");
		ir.excludePathPatterns("/error");

		ir = registry.addInterceptor(needLoginInterceptor);
//		게시글 관련
		ir.addPathPatterns("/usr/article/write");
		ir.addPathPatterns("/usr/article/doWrite");
		ir.addPathPatterns("/usr/article/modify");
		ir.addPathPatterns("/usr/article/doModify");
		ir.addPathPatterns("/usr/article/doDelete");

//		회원관련
		ir.addPathPatterns("/usr/member/myPage");
		ir.addPathPatterns("/usr/member/checkPw");
		ir.addPathPatterns("/usr/member/doCheckPw");
		ir.addPathPatterns("/usr/member/modify");
		ir.addPathPatterns("/usr/member/doModify");

//		댓글관련
		ir.addPathPatterns("/usr/reply/doWrite");
		ir.addPathPatterns("/usr/reply/doModify");
		ir.addPathPatterns("/usr/reply/doDelete");

//		좋아요 관련
		ir.addPathPatterns("/usr/reactionPoint/doGoodReaction");
		ir.addPathPatterns("/usr/reactionPoint/doBadReaction");

		ir = registry.addInterceptor(needLogoutInterceptor);
		ir.addPathPatterns("/usr/member/login");
		ir.addPathPatterns("/usr/member/doLogin");
		ir.addPathPatterns("/usr/member/join");
		ir.addPathPatterns("/usr/member/doJoin");
		ir.addPathPatterns("/usr/member/findLoginId");
		ir.addPathPatterns("/usr/member/doFindLoginId");
		ir.addPathPatterns("/usr/member/findLoginPw");
		ir.addPathPatterns("/usr/member/doFindLoginPw");
	}

}