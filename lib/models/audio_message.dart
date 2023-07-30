class AudioMessage {
  final int id;
  final String data;
  final String mime;

  AudioMessage({
    required this.id,
    required this.data,
    required this.mime,
  });

  /// This method is used to convert a map to a ChatMessage object
  factory AudioMessage.fromApi(Map<String, dynamic> map) {
    return AudioMessage(
      id: map['id'] as int,
      data: map['audio'] as String,
      mime: map['mime'] as String,
    );
  }
}
