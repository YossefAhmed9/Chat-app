class Message {
  dynamic message;

  dynamic id;

  Message(this.message, this.id);

  factory Message.fromJson(dynamic json) {
    return Message(json['message'], json['id']);
  }
}
