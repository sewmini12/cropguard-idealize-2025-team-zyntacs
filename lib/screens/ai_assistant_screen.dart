import 'package:flutter/material.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _messages.add(ChatMessage(
      text: "Hello! I'm your CropGuard AI assistant. I can help you with plant diseases, pest control, farming tips, and weather advice. How can I assist you today?",
      isUser: false,
      timestamp: DateTime.now(),
      messageType: MessageType.welcome,
    ));
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
      _messages.add(ChatMessage(
        text: userMessage,
        isUser: true,
        timestamp: DateTime.now(),
        messageType: MessageType.text,
      ));
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _messages.add(ChatMessage(
          text: _generateAIResponse(userMessage),
          isUser: false,
          timestamp: DateTime.now(),
          messageType: MessageType.text,
        ));
        _isTyping = false;
      });
      _scrollToBottom();
    });
  }

  String _generateAIResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    
    if (message.contains('disease') || message.contains('sick') || message.contains('problem')) {
      return "I can help identify plant diseases! For the most accurate diagnosis, I recommend:\n\n1. Take a clear photo of the affected leaves\n2. Note any spots, discoloration, or unusual growth\n3. Check for pests on the undersides of leaves\n4. Consider recent weather conditions\n\nCommon diseases I can help with include blight, powdery mildew, rust, and bacterial infections. Would you like specific advice for a particular plant?";
    } else if (message.contains('pest') || message.contains('bug') || message.contains('insect')) {
      return "Pest control is crucial for healthy crops! Here are some effective strategies:\n\n🐛 **Natural Methods:**\n• Neem oil spray for aphids and soft-bodied insects\n• Companion planting (marigolds, basil)\n• Beneficial insects like ladybugs\n\n🚫 **Prevention:**\n• Regular inspection of plants\n• Proper spacing for air circulation\n• Remove infected plant debris\n\nWhat type of pest are you dealing with? I can provide more specific advice!";
    } else if (message.contains('weather') || message.contains('rain') || message.contains('sun')) {
      return "Weather plays a huge role in farming success! Here's what I recommend:\n\n☀️ **Hot Weather:**\n• Water early morning or evening\n• Provide shade for sensitive plants\n• Mulch to retain moisture\n\n🌧️ **Rainy Conditions:**\n• Ensure good drainage\n• Watch for fungal diseases\n• Harvest ripe fruits to prevent rot\n\nWould you like specific advice for current weather conditions in your area?";
    } else if (message.contains('water') || message.contains('irrigation')) {
      return "Proper watering is essential! Here are my top tips:\n\n💧 **Best Practices:**\n• Water deeply but less frequently\n• Check soil moisture 2 inches down\n• Water at the base, not on leaves\n• Morning watering is ideal\n\n📏 **Amount Guide:**\n• Most vegetables: 1-2 inches per week\n• Newly planted: More frequent, shallow watering\n• Established plants: Deep, weekly watering\n\nWhat type of plants are you growing? I can give more specific guidance!";
    } else if (message.contains('fertilizer') || message.contains('nutrients')) {
      return "Nutrition is key to healthy plants! Here's my fertilizer guide:\n\n🌱 **Organic Options:**\n• Compost - slow release, improves soil\n• Fish emulsion - quick nitrogen boost\n• Bone meal - phosphorus for roots/flowers\n• Kelp meal - potassium and micronutrients\n\n📅 **Timing:**\n• Spring: Balanced fertilizer at planting\n• Growing season: Light, frequent feeding\n• Fall: Reduce nitrogen, increase potassium\n\nWhat crops are you fertilizing? I can recommend specific ratios!";
    } else if (message.contains('tomato')) {
      return "Tomatoes are one of my favorites to help with! Here's essential tomato care:\n\n🍅 **Growing Tips:**\n• Full sun (6-8 hours daily)\n• Consistent watering to prevent blossom end rot\n• Support with cages or stakes\n• Prune suckers for better fruit production\n\n🚨 **Common Issues:**\n• Blight - improve air circulation\n• Hornworms - hand pick or use BT spray\n• Cracking - maintain consistent moisture\n\nWhat specific tomato question do you have?";
    } else if (message.contains('hello') || message.contains('hi') || message.contains('hey')) {
      return "Hello there! 👋 I'm excited to help you grow amazing crops! I'm here to assist with:\n\n🌱 Plant disease diagnosis\n🐛 Pest identification and control\n🌦️ Weather-based farming advice\n💧 Irrigation and watering tips\n🌿 Organic gardening methods\n🍅 Crop-specific guidance\n\nWhat would you like to know about your garden today?";
    } else if (message.contains('thanks') || message.contains('thank you')) {
      return "You're very welcome! 😊 I'm always here to help you grow the best crops possible. Feel free to ask me anything about farming, gardening, or plant care. Happy growing! 🌱";
    } else {
      return "That's an interesting question! While I specialize in plant diseases, pest control, and farming advice, I'm always learning. Could you provide more details about your specific gardening or farming challenge? I'd love to help you find a solution!\n\nSome areas where I excel:\n• Disease identification\n• Pest management\n• Watering and nutrition\n• Weather-related advice\n• Organic farming methods";
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildQuickActionTile(
              icon: Icons.camera_alt,
              title: 'Disease Diagnosis',
              subtitle: 'Upload a photo for plant disease identification',
              onTap: () {
                Navigator.pop(context);
                _sendPredefinedMessage("I need help identifying a plant disease. Can you guide me through the diagnosis process?");
              },
            ),
            _buildQuickActionTile(
              icon: Icons.bug_report,
              title: 'Pest Control',
              subtitle: 'Get advice on managing garden pests',
              onTap: () {
                Navigator.pop(context);
                _sendPredefinedMessage("I'm dealing with pests in my garden. What are the best natural control methods?");
              },
            ),
            _buildQuickActionTile(
              icon: Icons.water_drop,
              title: 'Watering Guide',
              subtitle: 'Learn proper watering techniques',
              onTap: () {
                Navigator.pop(context);
                _sendPredefinedMessage("Can you help me with proper watering techniques for my plants?");
              },
            ),
            _buildQuickActionTile(
              icon: Icons.wb_sunny,
              title: 'Weather Advice',
              subtitle: 'Get weather-based farming tips',
              onTap: () {
                Navigator.pop(context);
                _sendPredefinedMessage("What should I consider for my crops based on current weather conditions?");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _sendPredefinedMessage(String message) {
    _messageController.text = message;
    _sendMessage();
  }

  Widget _buildQuickActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showQuickActions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          // Input area
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.smart_toy,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Theme.of(context).primaryColor
                    : Colors.grey.withAlpha(25),
                borderRadius: BorderRadius.circular(18).copyWith(
                  bottomLeft: message.isUser ? const Radius.circular(18) : const Radius.circular(4),
                  bottomRight: message.isUser ? const Radius.circular(4) : const Radius.circular(18),
                ),
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
                          ? Colors.white.withAlpha(179) 
                          : Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              child: const Icon(
                Icons.person,
                size: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.smart_toy,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(25),
              borderRadius: BorderRadius.circular(18).copyWith(
                bottomLeft: const Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 200)),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.5 + (value * 0.5),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: _showQuickActions,
              icon: Icon(
                Icons.add_circle_outline,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Ask about diseases, pests, or farming tips...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _sendMessage,
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final MessageType messageType;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    required this.messageType,
  });
}

enum MessageType {
  text,
  image,
  welcome,
  suggestion,
}
