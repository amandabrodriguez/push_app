class PushMessage {
  final String messageId, title, body;
  final DateTime sentDate;
  final Map<String, dynamic>? data;
  final String? imageUrl;

  PushMessage({
    required this.messageId,
    required this.title,
    required this.body,
    required this.sentDate,
    this.data,
    this.imageUrl,
  });

  @override
  String toString() {
    return '''
      PushMessage: 
      id: $messageId
      title: $title
      body: $body
      sentDate: $sentDate
      data: $data
      imageUrl: $imageUrl
    ''';
  }
}
