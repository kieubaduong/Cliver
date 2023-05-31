import 'package:json_annotation/json_annotation.dart';
import '../enums/enums.dart';
import 'model.dart';
part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class Review {
  int? id;
  int? orderId;
  String? comment;
  String? userId;
  User? user;
  ReviewType? type;
  int? rating;
  DateTime? createdAt;
  Review({
    this.id,
    this.orderId,
    this.comment,
    this.userId,
    this.user,
    this.rating,
    this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
