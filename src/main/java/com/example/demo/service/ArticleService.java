package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.ArticleRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.ResultData;

@Service
public class ArticleService {

	@Autowired
	private ArticleRepository articleRepository;

	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}

	// 서비스 메서드
	public Article getForPrintArticle(int loginedMemberId, int id) {
		Article article = articleRepository.getForPrintArticle(id);

		controlForPrintData(loginedMemberId, article);

		return article;
	}

	private void controlForPrintData(int loginedMemberId, Article article) {
		if (article == null) {
			return;
		}
		ResultData userCanModifyRd = userCanModify(loginedMemberId, article);
		article.setUserCanModify(userCanModifyRd.isSuccess());

		ResultData userCanDeleteRd = userCanDelete(loginedMemberId, article);
		article.setUserCanDelete(userCanDeleteRd.isSuccess());
	}

	public ResultData userCanDelete(int loginedMemberId, Article article) {

		if (article.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 글에 대한 삭제 권한이 없습니다", article.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 글이 삭제 되었습니다", article.getId()));
	}

	public ResultData userCanModify(int loginedMemberId, Article article) {

		if (article.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 글에 대한 수정 권한이 없습니다", article.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 글을 수정했습니다", article.getId()));
	}

	public ResultData<Integer> writeArticle(int memberId, String title, String body, int boardId) {
		articleRepository.writeArticle(memberId, title, body, boardId);

		int id = articleRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 글이 생성되었습니다", id), "id", id);
	}

	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public void modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);
	}

	public Article getArticle(int id) {
		return articleRepository.getArticle(id);
	}

	public List<Article> getArticles() {
		return articleRepository.getArticles();
	}

	public int getArticlesCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {
		return articleRepository.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);
	}
//
//	public List<Article> getForPrintArticles(int boardId) {
//		return articleRepository.getForPrintArticles(boardId);
//	}

	public ResultData increaseHitCount(int id) {
		int affectedRow = articleRepository.increaseHitCount(id);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "해당 게시물 없음", "id", id);
		}

		return ResultData.from("S-1", "해당 게시물 조회수 증가", "id", id);

	}

	public Object getArticleHitCount(int id) {
		return articleRepository.getArticleHitCount(id);
	}

	public List<Article> getForPrintArticles(int boardId, int itemsInAPage, int page, String searchKeywordTypeCode,
			String searchKeyword) {

//		SELECT * FROM article WHERE boardId = 1 ORDER BY id DESC LIMIT 0, 10; 1page
//		SELECT * FROM article WHERE boardId = 1 ORDER BY id DESC LIMIT 10, 10; 2page

		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		return articleRepository.getForPrintArticles(boardId, limitFrom, limitTake, searchKeywordTypeCode,
				searchKeyword);
	}

	public ResultData increaseGoodReactionPoint(int relId) {
		int affectedRow = articleRepository.increaseGoodReactionPoint(relId);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "없는 게시물");
		}

		return ResultData.from("S-1", "좋아요 증가", "affectedRow", affectedRow);
	}

	public ResultData increaseBadReactionPoint(int relId) {
		int affectedRow = articleRepository.increaseBadReactionPoint(relId);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "없는 게시물");
		}

		return ResultData.from("S-1", "싫어요 증가", "affectedRow", affectedRow);
	}

	public ResultData decreaseGoodReactionPoint(int relId) {
		int affectedRow = articleRepository.decreaseGoodReactionPoint(relId);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "없는 게시물");
		}

		return ResultData.from("S-1", "좋아요 감소", "affectedRow", affectedRow);
	}

	public ResultData decreaseBadReactionPoint(int relId) {
		int affectedRow = articleRepository.decreaseBadReactionPoint(relId);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "없는 게시물");
		}

		return ResultData.from("S-1", "싫어요 감소", "affectedRow", affectedRow);
	}

	public int getGoodRP(int relId) {
		return articleRepository.getGoodRP(relId);
	}

	public int getBadRP(int relId) {
		return articleRepository.getBadRP(relId);
	}

}