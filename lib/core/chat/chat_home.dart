import 'dart:convert';
import 'dart:math';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/chat/message.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _message = [];
  bool _isLoading = false;
  late AnimationController _animationController;

  static const String _apiKey = "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";
  static const String _apiUrl = "https://openrouter.ai/api/v1/chat/completions";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    _message.add(
      Message(
        content: "Hello! I am your assistant. How can I help you today?",
        isUser: false,
        timestamp: DateTime.now(),
        id: _generateId(),
      ),
    );
  }

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        Random().nextInt(1000).toString();
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;
    final userMessage = _messageController.text.trim();
    _messageController.clear();
    setState(() {
      _message.add(
        Message(
          content: userMessage,
          isUser: true,
          timestamp: DateTime.now(),
          id: _generateId(),
        ),
      );
      _isLoading = true;
    });
    _scrollToBottom();

    try {
      final response = await _callOpenRouterAPI(userMessage);
      setState(() {
        _message.add(
          Message(
            content: response,
            isUser: false,
            timestamp: DateTime.now(),
            id: _generateId(),
          ),
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _message.add(
          Message(
            content: "Sorry, I couldn't process your request. Please try again.",
            isUser: false,
            timestamp: DateTime.now(),
            id: _generateId(),
          ),
        );
        _isLoading = false;
      });
    }
    _scrollToBottom();
  }

  Future<String> _callOpenRouterAPI(String message) async {
    final headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
      'HTTP-Referer': 'https://your-app.com',
      'X-Title': 'AI Chat Assistant',
    };
    final body = jsonEncode({
      'model': 'deepseek/deepseek-r1:free',
      'messages': [
        {'role': 'system', 'content': 'You are a helpful AI Assistant.'},
        {'role': 'user', 'content': message},
      ],
      'max_tokens': 2000,
      'temperature': 0.7,
    });
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to load response: ${response.statusCode}');
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

  Widget _buildAvatar(bool isUser) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: isUser
            ? LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764BA2)])
            : LinearGradient(colors: [Color(0xff11998e), Color(0xff38ef7d)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        isUser ? Icons.person : Icons.smart_toy,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
              0.3 + (sin(_animationController.value * 2 * pi + index * 0.5) * 0.3),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff0A0A0A),
              Color(0xff1A1A2E),
              Color(0xFF16213E),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff667eea), Color(0xff764ba2)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff667eea).withOpacity(0.3),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.smart_toy_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AI Assistant',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Ask me anything",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _message.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _message.length && _isLoading) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            _buildAvatar(false),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildDot(0),
                                  SizedBox(width: 4),
                                  _buildDot(1),
                                  SizedBox(width: 4),
                                  _buildDot(2),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return _buildMessageBubble(_message[index]);
                  },
                ),
              ),

              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isUser) _buildAvatar(false),
          SizedBox(width: 8),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: message.isUser
                    ? LinearGradient(colors: [Color(0xFF667EEA), Color(0xFF764BA2)])
                    : LinearGradient(colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)]),
                borderRadius: BorderRadius.circular(20),
                border: message.isUser
                    ? null
                    : Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: message.isUser ? Color(0xFF667EEA).withOpacity(0.3) : Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: message.isUser
                  ? Text(
                message.content,
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
                  : GptMarkdown(
                message.content,
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ),
          ),
          SizedBox(width: 8),
          if (message.isUser) _buildAvatar(true),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    if (_isLoading) {
      _animationController.repeat();
    } else {
      _animationController.stop();
    }
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: null,
                onSubmitted: (value) {
                  _sendMessage();
                },

                style: TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Type Your message...",
                  hintStyle: TextStyle(color: Colors.white60,),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ),
          ),
          SizedBox(width: 12,),
          GestureDetector(onTap: _isLoading?null:_sendMessage,child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: _isLoading ?LinearGradient(colors:[ Colors.grey.withOpacity(0.3),Colors.grey.withOpacity(0.2)]):LinearGradient(colors: [Color(0xff667EEA),Color(0xFF64BA2)]),
              borderRadius: BorderRadius.circular(50),
              boxShadow:
                _isLoading?[]:[
                BoxShadow(
                  color: Color(0xFF667Eea).withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                )
              ]
            ),
            child: Icon(_isLoading?Icons.hourglass_empty:Icons.send_rounded,color:  Colors.white,size: 20,),
          ),)
        ],
      ),
    );
  }
}
