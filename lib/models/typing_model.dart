class TypingModel {
  String id;
  String username;
  bool typing;

  TypingModel(this.id, this.username, this.typing);

  factory TypingModel.fromJson(Map<String, dynamic> json) {
    return TypingModel(json['id'], json['username'], json['typing']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'typing': typing
  };
}