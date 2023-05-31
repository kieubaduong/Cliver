// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revenues.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Revenues _$RevenuesFromJson(Map<String, dynamic> json) => Revenues(
      cancelledOrders: json['cancelledOrders'] as int?,
      pendingClearance: json['pendingClearance'] as int?,
      withdrawn: json['withdrawn'] as int?,
      usedForPurchases: json['usedForPurchases'] as int?,
      cleared: json['cleared'] as int?,
    );

Map<String, dynamic> _$RevenuesToJson(Revenues instance) => <String, dynamic>{
      'cancelledOrders': instance.cancelledOrders,
      'pendingClearance': instance.pendingClearance,
      'withdrawn': instance.withdrawn,
      'usedForPurchases': instance.usedForPurchases,
      'cleared': instance.cleared,
    };
