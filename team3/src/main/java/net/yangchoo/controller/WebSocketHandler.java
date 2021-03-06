package net.yangchoo.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.PongMessage;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.ChatMessage;
import net.yangchoo.domain.ChatRoom;
import net.yangchoo.domain.ChatSession;
import net.yangchoo.domain.LoginUserDTO;
import net.yangchoo.service.ChatService;

@Controller("wsHandler")
@Log4j
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS)
public class WebSocketHandler extends TextWebSocketHandler {

	@Autowired
	private Gson gson;
	@Autowired
    private ChatService cService;
	@Autowired
	private ChatSession cSession;
    
	private List<String> users = new ArrayList<String>(); 
	
	// 채팅방 목록 <방 번호, ArrayList<session> >이 들어간다.
    private Map<Integer, ArrayList<WebSocketSession>> roomList = new ConcurrentHashMap<>();
    // session, 방 번호가 들어간다.
    private Map<WebSocketSession, Integer> sessionList = new ConcurrentHashMap<>();
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("ws/chat")
	public void echo() {
		
	}
	
	@GetMapping("ws/room/{roomId}") @ResponseBody
	public List<ChatMessage> messageList(@PathVariable Integer roomId, String userId, Model model) throws JsonIOException, IOException {
        
        List<ChatMessage> mList = cService.messageList(roomId);
 
        // 안읽은 메세지의 숫자 0으로 바뀌기
        ChatMessage message = new ChatMessage();
        message.setUserId(userId);
        message.setRoomId(roomId);
        cService.updateCount(message);
        
        return mList;
    }
	
	/**
     * 채팅 방이 없을 때 생성
     * @param room
     * @param userEmail
     * @param masterNickname
     * @return
     */
    @ResponseBody
    @RequestMapping("ws/createChat")
    public Integer createChat(ChatRoom room){
        ChatRoom exist  = cService.searchChatRoom(room);
        
        // DB에 방이 없을 때
        if(exist == null) {
            System.out.println("방이 없다!!");
            cService.createChat(room);
            return room.getRoomId();
        }
        // DB에 방이 있을 때
        else{
            System.out.println("방이 있다!!");
            return exist.getRoomId();
        }
    }
    /**
     * 채팅 방 목록 불러오기
     * @param room
     * @param userEmail
     * @param response
     * @return 
     * @throws JsonIOException
     * @throws IOException
     */
    @RequestMapping("ws/chatRoomList") @ResponseBody
    public List<ChatRoom> createChat(ChatRoom room, ChatMessage message) {
        List<ChatRoom> cList = cService.chatRoomList(room);
        
        for(int i = 0; i < cList.size(); i++) {
            message.setRoomId(cList.get(i).getRoomId());
            message.setUserId(room.getUserId());
            int count = cService.selectUnReadCount(message);
            cList.get(i).setUnReadCount(count);
        }
        return cList;
    }
    
    @RequestMapping("ws/chatSession") @ResponseBody
    public ArrayList<LoginUserDTO> chatSession() {
        return new ArrayList<>(new TreeSet<>(cSession.getLoginUser()));
    }
    
    
	/**
	 * 연결성공
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String id = session.getId();
		log.warn("입장자 : " + session.getPrincipal().getName());
		log.warn(id + " :: 접속");
		users.add(session.getPrincipal().getName());
		log.warn("현재 접속중인 사람 :: " + users);
	}

	/**
	 * 메세지 송수신
	 */
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		// 전달받은 메세지
		ChatMessage chatMessage = gson.fromJson((String) message.getPayload(), ChatMessage.class);

		
        // 받은 메세지에 담긴 roomId로 해당 채팅방을 찾아온다.
        ChatRoom chatRoom = cService.selectChatRoom(chatMessage.getRoomId());
        
        
        // 채팅 세션 목록에 채팅방이 존재하지 않고, 처음 들어왔고, DB에서의 채팅방이 있을 때
        // 채팅방 생성
        
        if(chatMessage.getMessage().equals("ENTER-CHAT"))
	        if(roomList.get(chatRoom.getRoomId()) == null) {
	            // 채팅방에 들어갈 session들
	            ArrayList<WebSocketSession> sessionTwo = new ArrayList<>();
	            // session 추가
	            sessionTwo.add(session);
	            // sessionList에 추가
	            sessionList.put(session, chatRoom.getRoomId());
	            // RoomList에 추가
	            roomList.put(chatRoom.getRoomId(), sessionTwo);
	            // 확인용
	            log.warn("채팅방 생성");
	            roomList.entrySet().forEach(log::warn);
	            sessionList.entrySet().forEach(log::warn);
	        }
	        
	        // 채팅방이 존재 할 때
	        else {
	            // RoomList에서 해당 방번호를 가진 방이 있는지 확인.
	            roomList.get(chatRoom.getRoomId()).add(session);
	            // sessionList에 추가
	            sessionList.put(session, chatRoom.getRoomId());
	            // 확인용
	            log.warn("생성된 채팅방으로 입장");
	            roomList.entrySet().forEach(log::warn);
	            sessionList.entrySet().forEach(log::warn);
	        }
        else {
	        TextMessage textMessage = new TextMessage(gson.toJson(chatMessage));
	        
	        // 현재 session 수
	        int sessionCount = 0;
	
	        // 해당 채팅방의 session에 뿌려준다.
	        for(WebSocketSession sess : roomList.get(chatRoom.getRoomId())) {
	            sess.sendMessage(textMessage);
	            sessionCount++;
	        }
	        
	        // 동적쿼리에서 사용할 sessionCount 저장
	        // sessionCount == 2 일 때는 unReadCount = 0,
	        // sessionCount == 1 일 때는 unReadCount = 1
	        chatMessage.setSessionCount(sessionCount);
	        // DB에 저장한다.
	        int a = cService.insertMessage(chatMessage);
	        
	        if(a == 1) {
	        	log.warn("메세지 전송 및 DB 저장 성공");
	        }else {
	        	log.warn("메세지 전송 실패!!! & DB 저장 실패!!");
	        }
        }
	}

	/**
	 * 연결해제
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.warn("퇴장자 : " + session.getPrincipal().getName());
		users.remove(session.getPrincipal().getName());
		log.warn("현재 접속중인 사람 :: " + users);
		
		log.warn(sessionList.get(session));
		if(sessionList.get(session) != null) {
            // 해당 session의 방 번호를 가져와서, 방을 찾고, 그 방의 ArrayList<session>에서 해당 session을 지운다.
            roomList.get(sessionList.get(session)).remove(session);
            sessionList.remove(session);
        }
	}
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log.trace("error", exception);
	}
	
}
