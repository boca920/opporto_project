import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  bool _isLoading = false;


  static const String _apiKey = "AIzaSyCprSG4QUQMsOrlD77v4RUXmlnnKDNywtw";

  @override
  void initState() {
    super.initState();
    _messages.add(
      Message(
        id: _generateId(),
        content: "Hello! I am your AI assistant. How can I help you today?",
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  String _generateId() =>
      DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(1000).toString();

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(
        id: _generateId(),
        content: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isLoading = true;
      _messageController.clear();
    });
    _scrollToBottom();

    try {
      final response = await _callGeminiAPI(text);
      setState(() {
        _messages.add(Message(
          id: _generateId(),
          content: response,
          isUser: false,
          timestamp: DateTime.now(),
        ));
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add(Message(
          id: _generateId(),
          content:
          "Sorry, I couldn't process your request. Please try again.",
          isUser: false,
          timestamp: DateTime.now(),
        ));
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  Future<String> _callGeminiAPI(String message) async {
    final uri = Uri.parse(
        "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateText?key=$_apiKey");

    final body = jsonEncode({
      "prompt": {"text": message},
      "temperature": 0.7,
      "candidate_count": 1,
    });

    final response =
    await http.post(uri, headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['output'] ?? "No response";
    } else {
      print('Error: ${response.body}');
      throw Exception('Failed to get response from Gemini API');
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

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("AI Chat", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment:
                  msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: msg.isUser ? Colors.blueAccent : Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg.content,
                        style: const TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),
          ),
<<<<<<< HEAD
          SizedBox(width: 12,),
          GestureDetector(onTap: _isLoading?null:_sendMessage,child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: _isLoading ?LinearGradient(colors:[ Colors.grey.withOpacity(0.3),Colors.grey.withOpacity(0.2)]):LinearGradient(colors: [Color(0xff667EEA),Color(0x0ff64ba2)]),
              borderRadius: BorderRadius.circular(50),
              boxShadow:
                _isLoading?[]:[
                BoxShadow(
                  color: Color(0xFF667Eea).withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                )
              ]
=======
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: TextStyle(color: Colors.white60),
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _isLoading ? null : _sendMessage,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blueAccent,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
>>>>>>> 838bf7e7b7a2a7a537a07a7d911ba1fa585305fb
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;

  Message(
      {required this.id,
        required this.content,
        required this.isUser,
        required this.timestamp});
}