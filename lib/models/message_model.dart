class MessageModel {
  final String id;
  final String username;
  final String message;
  final DateTime timestamp;

  MessageModel(this.id, this.username, this.message, this.timestamp);

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(json['id'], json['username'], json['message'],
        DateTime.fromMillisecondsSinceEpoch(json['timestamp']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'message': message,
        'timestamp': timestamp.millisecondsSinceEpoch
      };
}
