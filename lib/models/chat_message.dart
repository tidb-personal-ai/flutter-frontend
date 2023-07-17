/// This class is used to represent a chat message.
/// It conatins id, message, timestam and sender
class ChatMessage {
  final int id;
  final String message;
  final DateTime timestamp;
  final ChatMessageSender sender;

  ChatMessage({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.sender,
  });

  /// This method is used to convert a map to a ChatMessage object
  factory ChatMessage.fromMap(Map<dynamic, dynamic> map) {
    return ChatMessage(
      id: map['id'] as int,
      message: map['message'] as String,
      timestamp: map['timestamp'] as DateTime,
      sender: map['sender'] == 'user'
          ? ChatMessageSender.user
          : ChatMessageSender.ai,
    );
  }

  /// This method is used to convert a map to a ChatMessage object
  factory ChatMessage.fromApi(Map<String, dynamic> map, {ChatMessageSender? sender}) {
    return ChatMessage(
      id: map['id'] as int,
      message: map['message'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      sender: sender ?? (map['sender'] == 'user'
          ? ChatMessageSender.user
          : ChatMessageSender.ai),
    );
  }

  /// This method is used to convert a ChatMessage object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'timestamp': timestamp,
      'sender': sender.name,
    };
  }

  /// This method is used to convert a ChatMessage object to a map
  Map<String, dynamic> toApi() {
    return {
      'id': id,
      'message': message,
      'timestamp': timestamp,
      'sender': sender.name,
    };
  }
}

enum ChatMessageSender { user, ai }
