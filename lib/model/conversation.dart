import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatMessge {
  final String id;
  final String text;
  final types.User author;

  ChatMessge({required this.id, required this.text, required this.author});

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'authorid': author.id,
  };

  static ChatMessge fromJson(Map<String, dynamic> json) => ChatMessge(
    id: json['id'],
    text: json['text'],
    author: types.User(id: json['authorid']),
  );
}
