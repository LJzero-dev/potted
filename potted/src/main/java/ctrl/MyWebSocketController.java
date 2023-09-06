package ctrl;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class MyWebSocketController {

    @MessageMapping("/websocket")
    @SendTo("/topic/messages")
    public String handleMessage(String message) {
        return "Received message: " + message;
    }
}