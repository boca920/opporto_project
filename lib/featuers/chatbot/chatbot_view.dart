import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/services/ai_chat_service.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();
  bool _isTyping = false;

  final List<_ChatMessage> _messages = [
    _ChatMessage(
      fromBot: true,
      text:
          'Hi! I’m Opporto Assistant.\nTell me what you need help with (jobs, profile, password, applications).',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();

    setState(() {
      _messages.add(_ChatMessage(fromBot: false, text: text));
      _isTyping = true;
    });

    String reply;
    try {
      // If OPENAI_API_KEY exists, use real AI. Otherwise fall back to local replies.
      if (AiChatService.apiKey != null) {
        final convo = _messages
            .where((m) => m.text.isNotEmpty)
            .take(20)
            .map((m) => {
                  'role': m.fromBot ? 'assistant' : 'user',
                  'content': m.text,
                })
            .toList();
        reply = await AiChatService.reply(messages: convo);
      } else {
        reply = _autoReply(text);
      }
    } catch (e) {
      reply = 'Sorry, I could not reach the AI service.\n$e';
    }

    if (!mounted) return;
    setState(() {
      _messages.add(_ChatMessage(fromBot: true, text: reply));
      _isTyping = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent + 120,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  String _autoReply(String text) {
    final t = text.toLowerCase();
    if (t.contains('password') || t.contains('reset') || t.contains('otp')) {
      return 'Password help:\n- Use “Forgot Password” from Login\n- Enter OTP\n- Set a new password\nIf you share the error message, I can guide you precisely.';
    }
    if (t.contains('job') || t.contains('وظيفة') || t.contains('jobs')) {
      return 'Jobs help:\n- Employers can post from “JobsTab”\n- Job Seekers see jobs in Home + All jobs\nIf jobs don’t appear, check that you’re logged in and that “GetAll jobs” returns items.';
    }
    if (t.contains('profile') || t.contains('بروفايل') || t.contains('cv')) {
      return 'Profile help:\n- Your profile reads from your account data\n- You can upload CV/Resume from Profile features (if enabled)\nTell me what you want to edit and I’ll guide you.';
    }
    if (t.contains('application') || t.contains('apply') || t.contains('طلب')) {
      return 'Applications help:\n- Apply from a job card (if your flow supports it)\n- Employers can review applications in their dashboard\nTell me your role (Employer/Job Seeker) and what step fails.';
    }
    return 'Got it. Can you tell me:\n1) Your role (Employer/Job Seeker)\n2) What screen you are on\n3) The exact error or what you expected to happen';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: const Text('Help Center', ),
        centerTitle: true,
      ),
      body: Column(children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == _messages.length) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: const Text(
                        'Typing…',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  );
                }
                final m = _messages[index];
                final bubbleColor =
                    m.fromBot ? Colors.grey.shade100 : AppColors.movColor;
                final textColor = m.fromBot ? Colors.black87 : Colors.white;
                final align =
                    m.fromBot ? Alignment.centerLeft : Alignment.centerRight;

                return Align(
                  alignment: align,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 320),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      borderRadius: BorderRadius.circular(16),
                      border: m.fromBot
                          ? Border.all(color: Colors.grey.shade200)
                          : null,
                    ),
                    child: Text(
                      m.text,
                      style: TextStyle(color: textColor, height: 1.3),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      decoration: InputDecoration(
                        hintText: 'Type your message…',
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide:
                              const BorderSide(color: AppColors.movColor, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 48,
                    width: 48,
                    child: ElevatedButton(
                      onPressed: _isTyping ? null : _send,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.movColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(Icons.send, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final bool fromBot;
  final String text;

  _ChatMessage({required this.fromBot, required this.text});
}

