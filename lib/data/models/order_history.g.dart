// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistory _$OrderHistoryFromJson(Map<String, dynamic> json) => OrderHistory(
      id: json['id'] as int?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      resourceId: json['resourceId'] as int?,
      resource: json['resource'] == null
          ? null
          : Resource.fromJson(json['resource'] as Map<String, dynamic>),
      orderId: json['orderId'] as int?,
    );

Map<String, dynamic> _$OrderHistoryToJson(OrderHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$StatusEnumMap[instance.status],
      'createdAt': instance.createdAt?.toIso8601String(),
      'resourceId': instance.resourceId,
      'resource': instance.resource?.toJson(),
      'orderId': instance.orderId,
    };

const _$StatusEnumMap = {
  Status.PendingPayment: 'PendingPayment',
  Status.Created: 'Created',
  Status.Doing: 'Doing',
  Status.Delivered: 'Delivered',
  Status.Completed: 'Completed',
  Status.Cancelled: 'Cancelled',
};
