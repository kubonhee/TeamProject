package net.yangchoo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.ChatMessage;
import net.yangchoo.domain.ChatRoom;
import net.yangchoo.mapper.ChatMapper;

@Service
@Log4j
@AllArgsConstructor
public class ChatServiceImpl implements ChatService {

	private ChatMapper chatMapper;
	
	@Override
	public ChatRoom selectChatRoom(Integer roomId) {
		return chatMapper.selectChatRoom(roomId);
	}

	@Override
	public Integer insertMessage(ChatMessage chatMessage) {
		log.warn(String.format("insertMessage(%s)", chatMessage));
		return chatMapper.insertMessage(chatMessage);
	}

	@Override
	public List<ChatMessage> messageList(Integer roomId) {
		log.warn(String.format("messageList(%s)", roomId));
		return chatMapper.messageList(roomId);
	}

	@Override
	public void updateCount(ChatMessage message) {
		log.warn(String.format("updateCount(%s)", message));
	}

	@Override
	public int createChat(ChatRoom room) {
		log.warn(String.format("createChat(%s)", room));
		return chatMapper.createChat(room);
	}

	@Override
	public ChatRoom searchChatRoom(ChatRoom room) {
		log.warn(String.format("searchChatRoom(%s)", room));
		return chatMapper.searchChatRoom(room);
	}

	@Override
	public List<ChatRoom> chatRoomList(ChatRoom chatRoom) {
		log.warn(String.format("chatRoomList(%s)", chatRoom));
		return chatMapper.chatRoomList(chatRoom);
	}

	@Override
	public int selectUnReadCount(ChatMessage message) {
		log.warn(String.format("selectUnReadCount(%s)", message));
		return 0;
	}
	
}
