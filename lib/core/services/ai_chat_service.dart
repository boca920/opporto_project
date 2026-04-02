import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AiChatService {
  static bool get useProxy =>
      (dotenv.env['CHAT_USE_PROXY'] ?? '').trim().toLowerCase() == 'true';

  static String get proxyUrl {
    final v = dotenv.env['CHAT_PROXY_URL'];
    if (v != null && v.trim().isNotEmpty) return v.trim();
    // default: use your backend base + /api/v1/chat
    final apiRoot = dotenv.env['API_ROOT']?.trim();
    if (apiRoot != null && apiRoot.isNotEmpty) {
      return '$apiRoot/api/v1/chat';
    }
    return 'https://job-backend-mj9t.vercel.app/api/v1/chat';
  }

  static String? get apiKey {
    final k = dotenv.env['OPENAI_API_KEY'];
    if (k == null || k.trim().isEmpty) return null;
    return k.trim();
  }

  static Future<String> reply({
    required List<Map<String, String>> messages,
  }) async {
    if (useProxy) {
      return _replyViaProxy(messages: messages);
    }

    final key = apiKey;
    if (key == null) {
      throw Exception('OPENAI_API_KEY is not set in .env');
    }

    final uri = Uri.parse('https://api.openai.com/v1/chat/completions');
    final body = jsonEncode({
      'model': dotenv.env['OPENAI_MODEL']?.trim().isNotEmpty == true
          ? dotenv.env['OPENAI_MODEL']!.trim()
          : 'gpt-4o-mini',
      'temperature': 0.4,
      'messages': [
        {
          'role': 'system',
          'content':
              'You are Opporto Help Center assistant. Be concise, practical, and ask for missing details. Prefer Arabic if the user writes Arabic.'
        },
        ...messages.map((m) => {
              'role': m['role'],
              'content': m['content'],
            }),
      ],
    });

    final res = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $key',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('OpenAI error ${res.statusCode}: ${res.body}');
    }

    final json = jsonDecode(res.body);
    final content = json['choices']?[0]?['message']?['content'];
    if (content is String && content.trim().isNotEmpty) {
      return content.trim();
    }
    throw Exception('Unexpected OpenAI response shape.');
  }

  static Future<String> _replyViaProxy({
    required List<Map<String, String>> messages,
  }) async {
    final res = await http.post(
      Uri.parse(proxyUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'messages': messages,
      }),
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Chat proxy error ${res.statusCode}: ${res.body}');
    }

    final json = jsonDecode(res.body);
    final reply = json['reply'] ?? json['message'] ?? json['content'];
    if (reply is String && reply.trim().isNotEmpty) return reply.trim();
    throw Exception('Unexpected proxy response shape.');
  }
}

