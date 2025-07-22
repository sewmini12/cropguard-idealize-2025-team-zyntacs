import 'package:flutter/material.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  State<BotScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _messages.add(
      ChatMessage(
        text: "Hello! I'm your CropGuard AI assistant. I can help you with:\n\n"
            "🌱 Crop disease identification\n"
            "🌾 Farming best practices\n"
            "🌤️ Weather-related advice\n"
            "💧 Irrigation recommendations\n"
            "🌿 Pest management\n\n"
            "How can I help you today?",
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text.trim();
    setState(() {
      _messages.add(
        ChatMessage(
          text: userMessage,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate bot response
    Future.delayed(const Duration(milliseconds: 1000), () {
      _generateBotResponse(userMessage);
    });
  }

  void _generateBotResponse(String userMessage) {
    String botResponse = _getBotResponse(userMessage.toLowerCase());
    
    setState(() {
      _messages.add(
        ChatMessage(
          text: botResponse,
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    });
    _scrollToBottom();
  }

  String _getBotResponse(String message) {
    // Simple keyword-based responses (in a real app, you'd use an AI API)
    if (message.contains('disease') || message.contains('sick') || message.contains('spots')) {
      return "I can help identify crop diseases! 🔍\n\n"
          "Common symptoms to look for:\n"
          "• Yellow or brown spots on leaves\n"
          "• Wilting or curling leaves\n"
          "• Unusual growths or discoloration\n\n"
          "For accurate diagnosis, try using our Disease Detection feature with a photo of the affected plant.";
    }
    
    if (message.contains('water') || message.contains('irrigation') || message.contains('drought')) {
      return "Water management is crucial for healthy crops! 💧\n\n"
          "Tips for proper irrigation:\n"
          "• Water early morning or late evening\n"
          "• Check soil moisture 2-3 inches deep\n"
          "• Use drip irrigation for efficiency\n"
          "• Monitor weather forecasts\n\n"
          "Different crops have different water needs. What crop are you growing?";
    }
    
    if (message.contains('pest') || message.contains('insect') || message.contains('bug')) {
      return "Pest management is essential for crop protection! 🐛\n\n"
          "Integrated Pest Management (IPM) approach:\n"
          "• Regular crop monitoring\n"
          "• Use beneficial insects\n"
          "• Crop rotation\n"
          "• Targeted pesticide use when necessary\n\n"
          "Can you describe the pests you're seeing?";
    }
    
    if (message.contains('weather') || message.contains('rain') || message.contains('temperature')) {
      return "Weather plays a big role in farming! 🌤️\n\n"
          "Check our Weather Advice section for:\n"
          "• 7-day weather forecasts\n"
          "• Planting recommendations\n"
          "• Harvest timing advice\n"
          "• Storm preparation tips\n\n"
          "What specific weather concern do you have?";
    }
    
    if (message.contains('fertilizer') || message.contains('nutrients') || message.contains('soil')) {
      return "Soil health and nutrition are vital! 🌱\n\n"
          "Key nutrients for crops:\n"
          "• Nitrogen (N) - leaf growth\n"
          "• Phosphorus (P) - root development\n"
          "• Potassium (K) - disease resistance\n\n"
          "Consider soil testing to determine exact needs. What crops are you fertilizing?";
    }
    
    if (message.contains('hello') || message.contains('hi') || message.contains('hey')) {
      return "Hello! 👋 I'm here to help with all your farming questions. "
          "You can ask me about crop diseases, pest management, irrigation, soil health, or any other farming topics!";
    }
    
    // Default response
    return "That's an interesting question! 🤔\n\n"
        "While I don't have specific information about that topic, I can help you with:\n"
        "• Crop disease identification\n"
        "• Pest management strategies\n"
        "• Irrigation and water management\n"
        "• Soil health and fertilization\n"
        "• Weather-related farming advice\n\n"
        "Feel free to ask about any of these topics!";
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CropGuard AI Assistant'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.green.shade50,
                    Colors.white,
                  ],
                ),
              ),
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(message: _messages[index]);
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Ask me anything about farming...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                    textInputAction: TextInputAction.send,
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  mini: true,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: message.isUser 
                          ? Colors.white.withOpacity(0.7)
                          : Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.grey,
                size: 24,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    }
  }
}
