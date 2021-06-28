package net.yangchoo.service;

import java.util.List;

import net.yangchoo.domain.ChatMessage;
import net.yangchoo.domain.ChatRoom;

public interface ChatService {
	
	ChatRoom selectChatRoom(Integer roomId);
	
	Integer insertMessage(ChatMessage chatMessage);
	
	List<ChatMessage> messageList(Integer roomId);
	
	void updateCount(ChatMessage message);
	
	int createChat(ChatRoom room);
	
	ChatRoom searchChatRoom(ChatRoom room);
	
	List<ChatRoom> chatRoomList(ChatRoom chatRoom);
	
	int selectUnReadCount(ChatMessage message);
}
