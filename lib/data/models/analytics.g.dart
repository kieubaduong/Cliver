// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Analytics _$AnalyticsFromJson(Map<String, dynamic> json) => Analytics(
      earningInMonth: json['earningInMonth'] as int? ?? 0,
      avgSellingPrice: (json['avgSellingPrice'] as num?)?.toDouble() ?? 0,
      activeOrders: json['activeOrders'] as int? ?? 0,
      availableForWithdrawal: json['availableForWithdrawal'] as int? ?? 0,
      completedOrders: json['completedOrders'] as int? ?? 0,
    );

Map<String, dynamic> _$AnalyticsToJson(Analytics instance) => <String, dynamic>{
      'earningInMonth': instance.earningInMonth,
      'avgSellingPrice': instance.avgSellingPrice,
      'activeOrders': instance.activeOrders,
      'availableForWithdrawal': instance.availableForWithdrawal,
      'completedOrders': instance.completedOrders,
    };
