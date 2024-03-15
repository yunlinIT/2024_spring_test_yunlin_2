package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

//import com.example.demo.crawling.WebCrawler2_melonTop100;

@Controller
public class UsrHomeController {

	@RequestMapping("/usr/home/main")
	public String showMain() {

		return "/usr/home/main";
	}

	@RequestMapping("/")
	public String showRoot() {

		return "redirect:/usr/home/main";
	}

//	@RequestMapping("/usr/home/main/crawl")
//	public String crawl() {
//		WebCrawler2_melonTop100.crawl();
//		return "/usr/home/main";
//	}
//	
//	@RequestMapping("/usr/home/main/crawlcafe")
//	public String crawlcafe() {
//		WebCrawler13.crawlMap();
//		return "/usr/home/main";
//	}
}