package net.yangchoo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;

import net.yangchoo.domain.ChatMessage;
import net.yangchoo.domain.ChatRoom;

public interface ChatMapper {
	
	@SelectKey(statement="SELECT SEQ_CHATROOM.NEXTVAL FROM DUAL", keyProperty="roomId", before=true, resultType=Integer.class)
	@Insert("INSERT INTO CHATROOM(ROOMID, USERID, MASTERID) VALUES (#{roomId}, #{userId}, #{masterId})")
	int createChat(ChatRoom room);
	
	@Select("SELECT * FROM CHATROOM WHERE ROOMID = #{roomId}")
	ChatRoom selectChatRoom(Integer roomId);
	
	@Insert("INSERT INTO CHATMESSAGE(MESSAGEID, ROOMID, MESSAGE, USERID) VALUES (SEQ_MESSAGE.NEXTVAL, #{roomId}, #{message}, #{userId})")
	Integer insertMessage(ChatMessage chatMessage);
	
	@Select("SELECT * FROM CHATMESSAGE WHERE ROOMID = #{roomId} AND MESSAGEID > 0")
	List<ChatMessage> messageList(Integer roomId);
	
	@Select("SELECT * FROM CHATROOM WHERE USERID = #{userId} OR MASTERID = #{userId}")
	List<ChatRoom> chatRoomList(ChatRoom chatRoom);
	
	@Select("SELECT * FROM CHATROOM WHERE USERID = #{userId} AND MASTERID = #{masterId}")
	ChatRoom searchChatRoom(ChatRoom room);
}
