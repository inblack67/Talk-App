class MMessage {
  final int id;
  final String content;

  MMessage({
    required this.id,
    required this.content,
  });

  factory MMessage.fromJSON(Map<String, dynamic> json) {
    return MMessage(
      id: json['id'],
      content: json['content'],
    );
  }
}
