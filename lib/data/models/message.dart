// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cliver_mobile/data/models/custom_order.dart';
import 'package:cliver_mobile/data/models/model.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  late int? id;
  late String? content;
  late String? senderId;
  late User? sender;
  late int? roomId;
  late int? postId;

  late Post? relatedPost;
  late int? repliedToMessageId;
  late DateTime? createdAt;
  late int? customPackageId;
  late CustomOrder? customPackage;

  //for ui
  Rx<bool> isLoading = false.obs;
  Rx<bool> isError = false.obs;
  String? replyMessage;

  Message({
    this.id,
    this.content,
    this.senderId,
    this.sender,
    this.roomId,
    this.postId,
    this.relatedPost,
    this.repliedToMessageId,
    this.createdAt,
    this.customPackageId,
    this.customPackage,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  static List<Message> getMessages() {
    return [];
  }
}
