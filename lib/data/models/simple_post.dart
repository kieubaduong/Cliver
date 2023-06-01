import 'package:json_annotation/json_annotation.dart';

import '../enums/status.dart';

part 'simple_post.g.dart';

@JsonSerializable(explicitToJson: false)
class SimplePost {
  DateTime? createdAt;
  DateTime? updatedAt;
  String? title;
  String? description;
  String? userId;
  String? status;
  int? subcategoryId;
  double? ratingAvg;
  int? ratingCount;
  List<String>? tags;
  List<String>? images;
  SimplePost({
    this.createdAt,
    this.updatedAt,
    this.title,
    this.description,
    this.userId,
    this.status,
    this.subcategoryId,
    this.ratingAvg,
    this.ratingCount,
    this.tags,
    this.images,
  });

  factory SimplePost.fromJson(Map<String, dynamic> json) =>
      _$SimplePostFromJson(json);

  Map<String, dynamic> toJson() => _$SimplePostToJson(this);
}
