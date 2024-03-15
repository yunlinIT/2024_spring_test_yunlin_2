package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.ReplyRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;

@Service
public class ReplyService {

	@Autowired
	private ReplyRepository replyRepository;

	public ReplyService(ReplyRepository replyRepository) {
		this.replyRepository = replyRepository;
	}

	public List<Reply> getForPrintReplies(int loginedMemberId, String relTypeCode, int relId) {
		List<Reply> replies = replyRepository.getForPrintReplies(loginedMemberId, relTypeCode, relId);

		for (Reply reply : replies) {
			controlForPrintData(loginedMemberId, reply);
		}

		return replies;
	}

	public ResultData<Integer> writeReply(int loginedMemberId, String relTypeCode, int relId, String body) {
		replyRepository.writeReply(loginedMemberId, relTypeCode, relId, body);

		int id = replyRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 댓글이 생성되었습니다", id), "id", id);
	}

	private void controlForPrintData(int loginedMemberId, Reply reply) {
		if (reply == null) {
			return;
		}
		ResultData userCanModifyRd = userCanModify(loginedMemberId, reply);
		reply.setUserCanModify(userCanModifyRd.isSuccess());

		ResultData userCanDeleteRd = userCanDelete(loginedMemberId, reply);
		reply.setUserCanDelete(userCanDeleteRd.isSuccess());
	}

	public ResultData userCanDelete(int loginedMemberId, Reply reply) {

		if (reply.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 댓글에 대한 삭제 권한이 없습니다", reply.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 댓글이 삭제 되었습니다", reply.getId()));
	}

	public ResultData userCanModify(int loginedMemberId, Reply reply) {

		if (reply.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 댓글에 대한 수정 권한이 없습니다", reply.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 댓글을 수정했습니다", reply.getId()));
	}

	public Reply getReply(int id) {
		return replyRepository.getReply(id);
	}

	public ResultData deleteReply(int id) {
		replyRepository.deleteReply(id);
		return ResultData.from("S-1", Ut.f("%d번 댓글을 삭제했습니다", id));
	}

	public void modifyReply(int id, String body) {
		replyRepository.modifyReply(id, body);
	}
}