package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.service.ReactionPointService;
import com.example.demo.service.ReplyService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrArticleController {

	@Autowired
	private Rq rq;

	@Autowired
	private ArticleService articleService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private ReplyService replyService;

	@Autowired
	private ReactionPointService reactionPointService;

	public UsrArticleController() {

	}

	// 액션 메서드
	
	@RequestMapping("/usr/article/writeEmail")
	public String sendEmail(HttpServletRequest req) {

		return "usr/article/writeEmail";
	}

	@RequestMapping("/usr/article/list")
	public String showList(HttpServletRequest req, Model model, @RequestParam(defaultValue = "1") int boardId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title,body") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {

		Rq rq = (Rq) req.getAttribute("rq");

		Board board = boardService.getBoardById(boardId);

		int articlesCount = articleService.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);

		if (board == null) {
			return rq.historyBackOnView("없는 게시판이야");
		}

		// 한페이지에 글 10개씩이야
		// 글 20개 -> 2 page
		// 글 24개 -> 3 page
		int itemsInAPage = 10;

		int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);

		List<Article> articles = articleService.getForPrintArticles(boardId, itemsInAPage, page, searchKeywordTypeCode,
				searchKeyword);

		model.addAttribute("board", board);
		model.addAttribute("boardId", boardId);
		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("articles", articles);

		return "usr/article/list";
	}

	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, Model model, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);
		ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), "article", id);

		if (usersReactionRd.isSuccess()) {
			model.addAttribute("userCanMakeReaction", usersReactionRd.isSuccess());
		}

		List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), "article", id);

		int repliesCount = replies.size();

		model.addAttribute("article", article);
		model.addAttribute("replies", replies);
		model.addAttribute("repliesCount", repliesCount);
		model.addAttribute("isAlreadyAddGoodRp",
				reactionPointService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), id, "article"));
		model.addAttribute("isAlreadyAddBadRp",
				reactionPointService.isAlreadyAddBadRp(rq.getLoginedMemberId(), id, "article"));

		return "usr/article/detail";
	}

	@RequestMapping("/usr/article/doIncreaseHitCountRd")
	@ResponseBody
	public ResultData doIncreaseHitCountRd(int id) {

		ResultData increaseHitCountRd = articleService.increaseHitCount(id);

		if (increaseHitCountRd.isFail()) {
			return increaseHitCountRd;
		}

		ResultData rd = ResultData.newData(increaseHitCountRd, "hitCount", articleService.getArticleHitCount(id));

		rd.setData2("id", id);

		return rd;

	}

	@RequestMapping("/usr/article/write")
	public String showJoin(HttpServletRequest req) {

		return "usr/article/write";
	}

	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, String title, String body, int boardId) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.isNullOrEmpty(title)) {
			return Ut.jsHistoryBack("F-1", "제목을 입력해주세요");
		}
		if (Ut.isNullOrEmpty(body)) {
			return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
		}

		ResultData<Integer> writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), title, body, boardId);

		int id = (int) writeArticleRd.getData1();

		Article article = articleService.getArticle(id);

		return Ut.jsReplace(writeArticleRd.getResultCode(), writeArticleRd.getMsg(), "../article/detail?id=" + id);

	}

	@RequestMapping("/usr/article/modify")
	public String showModify(HttpServletRequest req, Model model, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
		}

		model.addAttribute("article", article);

		return "usr/article/modify";
	}

	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, int id, String title, String body) {
		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getArticle(id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
		}

		ResultData loginedMemberCanModifyRd = articleService.userCanModify(rq.getLoginedMemberId(), article);

		if (loginedMemberCanModifyRd.isSuccess()) {
			articleService.modifyArticle(id, title, body);
		}

		return Ut.jsReplace(loginedMemberCanModifyRd.getResultCode(), loginedMemberCanModifyRd.getMsg(),
				"../article/detail?id=" + id);
	}

	// 로그인 체크 -> 유무 체크 -> 권한 체크 -> 삭제
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getArticle(id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
		}

		ResultData loginedMemberCanDeleteRd = articleService.userCanDelete(rq.getLoginedMemberId(), article);

		if (loginedMemberCanDeleteRd.isSuccess()) {
			articleService.deleteArticle(id);
		}

		return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(),
				"../article/list");
	}

}