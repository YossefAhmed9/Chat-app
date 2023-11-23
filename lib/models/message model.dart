class Message {
  dynamic message;

  Message(this.message);

  factory Message.fromJson(dynamic json) {
    return Message(json['message']);
  }
}
