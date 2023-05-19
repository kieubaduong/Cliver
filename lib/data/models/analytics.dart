import 'package:json_annotation/json_annotation.dart';

part 'analytics.g.dart';

@JsonSerializable()
class Analytics {
  int earningInMonth;
  double avgSellingPrice;
  int activeOrders;
  int availableForWithdrawal;
  int completedOrders;

  Analytics(
      {this.earningInMonth = 0,
      this.avgSellingPrice = 0,
      this.activeOrders = 0,
      this.availableForWithdrawal = 0,
      this.completedOrders = 0});

  factory Analytics.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsToJson(this);
}
