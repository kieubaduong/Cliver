import 'dart:convert';

class CreateMessage {
  String? content;
  String? senderId;
  String? receiverId;
  int? roomId;
  int? postId;
  int? repliedToMessageId;
  CreateMessage({
    this.content,
    this.senderId,
    this.receiverId,
    this.roomId,
    this.postId,
    this.repliedToMessageId,
  });

  Map<String, dynamic> toMap() {
    return {
      'Content': content,
      'SenderId': senderId,
      'ReceiverId': receiverId,
      'RoomId': roomId,
      'PostId': postId,
      'RepliedToMessageId': repliedToMessageId,
    };
  }

  factory CreateMessage.fromMap(Map<String, dynamic> map) {
    return CreateMessage(
      content: map['content'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      roomId: map['roomId']?.toInt(),
      postId: map['postId']?.toInt(),
      repliedToMessageId: map['repliedToMessageId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateMessage.fromJson(String source) =>
      CreateMessage.fromMap(json.decode(source));
}
