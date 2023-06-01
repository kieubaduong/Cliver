// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cliver_mobile/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'room.g.dart';

@JsonSerializable(explicitToJson: true)
class Room {
  late int? id;
  late int? lastMessageId;
  late Message? lastMessage;
  late List<User>? members;
  late List<Message>? messages;

  // for ui
  bool? isReaded = false;

  Room({
    this.id,
    this.lastMessageId,
    this.lastMessage,
    this.members,
    this.messages,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
