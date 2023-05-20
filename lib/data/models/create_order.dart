import 'dart:convert';

class CreateOrder {
  String note;
  int packageId;
  CreateOrder({
    required this.note,
    required this.packageId,
  });

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'packageId': packageId,
    };
  }

  factory CreateOrder.fromMap(Map<String, dynamic> map) {
    return CreateOrder(
      note: map['note'],
      packageId: map['packageId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateOrder.fromJson(String source) =>
      CreateOrder.fromMap(json.decode(source));
}
