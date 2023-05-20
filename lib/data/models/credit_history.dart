import 'package:json_annotation/json_annotation.dart';

part 'credit_history.g.dart';

@JsonSerializable()
class CreditHistory {
  int? id;
  int? amount;
  String? description;
  String? type;
  DateTime? createdAt;

  CreditHistory({
    this.id,
    this.amount,
    this.description,
    this.type,
    this.createdAt,
  });

  factory CreditHistory.fromJson(Map<String, dynamic> json) =>
      _$CreditHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$CreditHistoryToJson(this);
}
