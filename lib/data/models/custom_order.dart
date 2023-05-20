import 'package:json_annotation/json_annotation.dart';
import '../enums/enums.dart';
import 'model.dart';
part 'custom_order.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomOrder {
  int? id;
  String? name;
  String? description;
  int? postId;
  SimplePost? post;
  String? buyerId;
  int? deliveryDays;
  int? numberOfRevisions;
  int? price;
  int? expirationDays;
  int? roomId;
  CustomOrderStatus? status;

  CustomOrder(
      {this.id,
      this.name,
      this.description,
      this.postId,
      this.post,
      this.buyerId,
      this.deliveryDays,
      this.numberOfRevisions,
      this.price,
      this.expirationDays,
      this.roomId});

  factory CustomOrder.fromJson(Map<String, dynamic> json) =>
      _$CustomOrderFromJson(json);

  Map<String, dynamic> toJson() => _$CustomOrderToJson(this);
}
