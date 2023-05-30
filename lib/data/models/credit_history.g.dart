// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditHistory _$CreditHistoryFromJson(Map<String, dynamic> json) =>
    CreditHistory(
      id: json['id'] as int?,
      amount: json['amount'] as int?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CreditHistoryToJson(CreditHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'description': instance.description,
      'type': instance.type,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
