import 'package:json_annotation/json_annotation.dart';

part 'revenues.g.dart';

@JsonSerializable()
class Revenues {
  int? cancelledOrders;
  int? pendingClearance;
  int? withdrawn;
  int? usedForPurchases;
  int? cleared;


  Revenues({this.cancelledOrders, this.pendingClearance, this.withdrawn,
    this.usedForPurchases, this.cleared});

  factory Revenues.fromJson(Map<String, dynamic> json) => _$RevenuesFromJson(json);
  Map<String, dynamic> toJson() => _$RevenuesToJson(this);
}