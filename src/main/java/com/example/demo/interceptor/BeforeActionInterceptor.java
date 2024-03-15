package com.example.demo.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;


import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class BeforeActionInterceptor implements HandlerInterceptor {
	@Autowired
	private Rq rq;


	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {

		rq.initBeforeActionInterceptor();
		System.err.println("000000000000000000000000000000000000000000");
//		crawlAndSaveData();
		System.err.println("11111111111111111111111111111111111111");
		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
	
	
	
//
//	public void crawlAndSaveData() {
//		List<Cafe> cafes = WebCrawler13.crawlCafes();
//		
//		//System.out.println(cafes);
//		
//	    cafeService.saveCafeDataFromWebCrawler(cafes);
//	    
//
//	}
	
}