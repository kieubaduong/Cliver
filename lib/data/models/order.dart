import 'package:json_annotation/json_annotation.dart';

import 'package:cliver_mobile/data/enums/status.dart';
import 'package:cliver_mobile/data/models/model.dart';
import 'package:cliver_mobile/data/models/order_history.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  DateTime? createdAt;
  DateTime? updatedAt;
  int? id;
  int? price;
  String? note;
  String? dueBy;
  String? buyerId;
  User? buyer;
  String? sellerId;
  User? seller;
  int? revisionTimes;
  int? leftRevisionTimes;
  int? packageId;
  String? paymentMethod;
  Package? package;
  Status? status;
  List<Review>? reviews;
  List<OrderHistory>? histories;
  Order({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.price,
    this.note,
    this.dueBy,
    this.buyerId,
    this.buyer,
    this.sellerId,
    this.seller,
    this.revisionTimes,
    this.leftRevisionTimes,
    this.packageId,
    this.paymentMethod,
    this.package,
    this.status,
    this.reviews,
    this.histories,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
