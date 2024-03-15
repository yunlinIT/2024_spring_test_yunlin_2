package com.example.demo.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.util.Ut;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class NeedLoginInterceptor implements HandlerInterceptor {
	@Autowired
	private Rq rq;

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		Rq rq = (Rq) req.getAttribute("rq");

		if (!rq.isLogined()) {
			System.out.println("==============로그인 하고 써============");
			String afterLoginUri = rq.getEncodedCurrentUri();
			rq.jsprintReplace("F-A", "로그인 후 이용해주세요", "../member/login?afterLoginUri=" + afterLoginUri);

			return false;

		}

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}