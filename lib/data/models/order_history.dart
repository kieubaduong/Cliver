import 'package:json_annotation/json_annotation.dart';
import '../enums/enums.dart';
import 'model.dart';
part 'order_history.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderHistory {
  int? id;
  Status? status;
  DateTime? createdAt;
  int? resourceId;
  Resource? resource;
  int? orderId;
  OrderHistory({
    this.id,
    this.status,
    this.createdAt,
    this.resourceId,
    this.resource,
    this.orderId,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryToJson(this);
}
