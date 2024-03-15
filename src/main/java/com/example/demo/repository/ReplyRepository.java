package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Reply;

@Mapper
public interface ReplyRepository {

	@Select("""
				SELECT R.*, M.nickname AS extra__writer
				FROM reply AS R
				INNER JOIN `member` AS M
				ON R.memberId = M.id
				WHERE relTypeCode = #{relTypeCode}
				AND relId = #{relId}
				ORDER BY R.id ASC;
			""")
	List<Reply> getForPrintReplies(int loginedMemberId, String relTypeCode, int relId);

	@Insert("""
				INSERT INTO reply
				SET regDate = NOW(),
				updateDate = NOW(),
				memberId = #{loginedMemberId},
				relTypeCode = #{relTypeCode},
				relId = #{relId},
				`body` = #{body}
			""")
	void writeReply(int loginedMemberId, String relTypeCode, int relId, String body);

	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	@Select("""
				SELECT R.*
				FROM reply AS R
				WHERE R.id = #{id}
			""")
	Reply getReply(int id);

	@Delete("""
				DELETE FROM reply
				WHERE id = #{id}
			""")
	void deleteReply(int id);

	@Update("""
			UPDATE reply
			SET `body` = #{body},
			updateDate = NOW()
			WHERE id = #{id}
				""")
	public void modifyReply(int id, String body);

}